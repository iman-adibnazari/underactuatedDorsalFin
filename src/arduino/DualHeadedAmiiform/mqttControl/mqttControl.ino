#include <ArduinoMqttClient.h>
#include "WiFiS3.h"
#include "arduino_secrets.h"
#define PI 3.1415926535897932384626433832795


///////please enter your sensitive data in the Secret tab/arduino_secrets.h
char ssid[] = SECRET_SSID;        // your network SSID (name)
char pass[] = SECRET_PASS;    // your network password (use for WPA, or use as key for WEP)

WiFiClient wifiClient;
MqttClient mqttClient(wifiClient);


const char broker[] = "192.168.0.114"; // PUT IN BROKER IP HERE
int        port     = 1883;
const char topic[]  = "robot/start";
const char topic2[]  = "robot/stop";
const char topic3[]  = "robot/gait";

//set interval for sending messages (milliseconds)
const long interval = 8000;
unsigned long previousMillis = 0;

int count = 0;

// Initialize gait parameters
float A_f = 0; 
float f = 0;
float b_f = 0;
float A_b = 0;
float b_b = 0;
float phi = 0;

// Initialize variables to hold finray angles and velocities
float theta_f = 0;
float theta_b = 0;
float thetad_f = 0;
float thetad_b = 0;

// Initialize flags and variables for finite state machine that define if robot should run or not
bool isRunning = false;
bool runFlag = false;
float startDelay = 0; 
float stopDelay = 0;

long startDelayTime = 0;
long stopDelayTime = 0;

// time variable for running gaits 
long startedRunningTime = 0;



// Initialize buffer for holding received MQTT messages

char MQTTReceiveBuffer[50]; // buffer is 50 bytes



void setup() {
  //Initialize serial and wait for port to open:
  Serial.begin(115200);
  while (!Serial) {
    ; // wait for serial port to connect. Needed for native USB port only
  }

  // attempt to connect to Wifi network:
  Serial.print("Attempting to connect to WPA SSID: ");
  Serial.println(ssid);
  while (WiFi.begin(ssid, pass) != WL_CONNECTED) {
    // failed, retry
    Serial.print(".");
    delay(5000);
  }

  Serial.println("You're connected to the network");
  Serial.println();

  Serial.print("Attempting to connect to the MQTT broker: ");
  Serial.println(broker);

  if (!mqttClient.connect(broker, port)) {
    Serial.print("MQTT connection failed! Error code = ");
    Serial.println(mqttClient.connectError());

    while (1);
  }

  Serial.println("You're connected to the MQTT broker!");
  Serial.println();

  // set the message receive callback
  mqttClient.onMessage(onMqttMessage);

  Serial.print("Subscribing to topic: ");
  Serial.println(topic);
  Serial.println();

  // subscribe to a topic
  mqttClient.subscribe(topic);
  mqttClient.subscribe(topic2);
  mqttClient.subscribe(topic3);

  // topics can be unsubscribed using:
  // mqttClient.unsubscribe(topic);

  Serial.print("Topic: ");
  Serial.println(topic);
  Serial.print("Topic: ");
  Serial.println(topic2);
  Serial.print("Topic: ");
  Serial.println(topic3);

}


void loop() {
  // call poll() regularly to allow the library to send MQTT keep alive which
  // avoids being disconnected by the broker
  mqttClient.poll();
  // Check if start/stop state needs to be switched
  stepFSM();
  // Calculate finray angle
  if (isRunning==true){
    float time = float(millis()-startedRunningTime)/1000.0; // seconds
    // compute finray angles from gait parameters
    theta_f = A_f*sin(2*PI*f*time) + b_f;
    theta_b = A_f*sin(2*PI*f*time + phi)+ b_b;

    thetad_f = A_f*2*PI*f*cos(2*PI*f*time);
    thetad_b = A_f*2*PI*f*cos(2*PI*f*time+phi);

    // Serial.println("RUNNING");

  }
  else{
    // set finray angles to 0
    // Serial.println("STOPPED");
    theta_f = 0;
    theta_b = 0;
    thetad_f = 0;
    thetad_b = 0;
    
  }
  // TODO: Send joint angles over CAN bus
    // Serial.print("theta_f: ");
    Serial.print(theta_f);
    // Serial.print(", theta_b: ");
    Serial.print("\t");
    Serial.print(theta_b);
    // Serial.print(", thetad_f: ");
    Serial.print("\t");
    Serial.print(thetad_f);
    // Serial.print(", thetad_b: ");
    Serial.print("\t");
    Serial.println(thetad_b);
    



  // TODO: Sensing/sending data back 



}


void onMqttMessage(int messageSize) {
  // Depending on the message topic, run associated handler
  String messageTopic = mqttClient.messageTopic();
  if (messageTopic == "robot/start"){
    startTopicHandler();
  }
  else if (messageTopic == "robot/stop"){
    stopTopicHandler();
  }
  else if (messageTopic == "robot/gait"){
    gaitTopicHandler();
  }
}

void startTopicHandler(){
  // Serial.println("Got a start topic here");
  // Dump whole message into buffer
  int buffIndex = 0;
  while (mqttClient.available()) {
    MQTTReceiveBuffer[buffIndex] = (char)mqttClient.read();
    buffIndex++;
  }
  // Parse value using strtok
  char* value_str = strtok(MQTTReceiveBuffer, ","); // read in comma delimited token 
  // Check if we got a valid token
  if (value_str != NULL) {
    // Convert string to float
    startDelay = atof(value_str);
  } else {
    // Handle error - not enough values in message
    startDelay = 0.0;  // or some error value
  }
  // Set variables for finite state machine controlling start/stop state
  runFlag = true; // Set runflag to true
  startDelayTime = millis() + long(startDelay*1000.0);
  // Serial.print("Current time: ");
  // Serial.print(millis());
  // Serial.print(" Starting in ");
  // Serial.print(startDelay);
  // Serial.print("seconds at: ");
  // Serial.println(startDelayTime);



}
void stopTopicHandler(){
  // Serial.println("Got a stop topic here");
  // Dump whole message into buffer
  int buffIndex = 0;
  while (mqttClient.available()) {
    MQTTReceiveBuffer[buffIndex] = (char)mqttClient.read();
    buffIndex++;
  }

  // Parse value using strtok
  char* value_str = strtok(MQTTReceiveBuffer, ","); // read in comma delimited token 
  // Check if we got a valid token
  if (value_str != NULL) {
    // Convert string to float
    stopDelay = atof(value_str);
  } else {
    // Handle error - not enough values in message
    stopDelay = 0.0; // or some error value
  }

    // Set variables for finite state machine controlling start/stop state
  runFlag = false; // Set runflag to false
  stopDelayTime = millis() + long(stopDelay*1000.0);
  // Serial.print("Current time: ");
  // Serial.print(millis());
  // Serial.print(" Stopping in ");
  // Serial.print(stopDelay);
  // Serial.print("seconds at: ");
  // Serial.println(stopDelayTime);
}
void gaitTopicHandler(){
  // Serial.println("Got a gait topic here");
  // Dump whole message into buffer
  int buffIndex = 0;
  while (mqttClient.available()) {
    MQTTReceiveBuffer[buffIndex] = (char)mqttClient.read();
    buffIndex++;
  }
  parseMessage(MQTTReceiveBuffer); // read in the gait parameters from the message

}

void parseMessage(char* message) {
  float values[6];  // Adjust size based on your needs
  char* ptr = message;
  
  // Parse each value using strtok()
  for (int i = 0; i < 6; i++) { // there are 6 parameter values that are being read in from the message
    char* value_str = strtok(i == 0 ? ptr : NULL, ","); // read in comma delimited token 
    
    // Check if we got a valid token
    if (value_str != NULL) {
      // Convert string to float
      values[i] = atof(value_str);
    } else {
      // Handle error - not enough values in message
      values[i] = 0.0;  // or some error value
    }
  }
  // Assign values
  A_f = values[0]; 
  f = values[1]; 
  b_f = values[2]; 
  A_b = values[3]; 
  b_b = values[4]; 
  phi = values[5]; 

  // // print off all values

  // Serial.print("A_f: ");
  // Serial.print(A_f);
  // Serial.print(" f: ");
  // Serial.print(f);
  // Serial.print(" b_f: ");
  // Serial.print(b_f);
  // Serial.print(" A_b: ");
  // Serial.print(A_b);
  // Serial.print(" b_b: ");
  // Serial.print(b_b);
  // Serial.print(" phi: ");
  // Serial.println(phi);
}

void stepFSM(){
  long time = millis();
  // check state switching conditions
  if (isRunning&&(!runFlag)&&(time-stopDelayTime>=0)){ // if currently running, commanded to stop, and if delay period has passed, then switch to stop state
    isRunning = false;
  } 
  if ((!isRunning)&&runFlag&&(time-startDelayTime>=0)){ // if currently stopped, commanded to run, and if delay period has passed, then switch to running state
    isRunning = true;
    startedRunningTime= millis();
  } 

}



