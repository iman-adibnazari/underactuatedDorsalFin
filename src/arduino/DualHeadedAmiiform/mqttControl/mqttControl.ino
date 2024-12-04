#include <ArduinoMqttClient.h>
#include "WiFiS3.h"
#include "arduino_secrets.h"

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

// Initialize flag for if robot should run or not
bool run = 0;
float startDelay = 0;
float stopDelay = 0;

// Initialize buffer for holding received MQTT messages

char MQTTReceiveBuffer[50]; // buffer is 50 bytes



void setup() {
  //Initialize serial and wait for port to open:
  Serial.begin(9600);
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

  // unsigned long currentMillis = millis();

  // if (currentMillis - previousMillis >= interval) {
  //   // save the last time a message was sent
  //   previousMillis = currentMillis;

  //   //record random value from A0, A1 and A2
  //   int Rvalue = analogRead(A0);
  //   int Rvalue2 = analogRead(A1);
  //   int Rvalue3 = analogRead(A2);

  //   Serial.print("Sending message to topic: ");
  //   Serial.println(topic);
  //   Serial.println(Rvalue);

  //   Serial.print("Sending message to topic: ");
  //   Serial.println(topic2);
  //   Serial.println(Rvalue2);

  //   Serial.print("Sending message to topic: ");
  //   Serial.println(topic2);
  //   Serial.println(Rvalue3);

  //   // send message, the Print interface can be used to set the message contents
  //   mqttClient.beginMessage(topic);
  //   mqttClient.print(Rvalue);
  //   mqttClient.endMessage();

  //   mqttClient.beginMessage(topic2);
  //   mqttClient.print(Rvalue2);
  //   mqttClient.endMessage();

  //   mqttClient.beginMessage(topic3);
  //   mqttClient.print(Rvalue3);
  //   mqttClient.endMessage();

  //   Serial.println();
  // }
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
  Serial.println("Got a start topic here");
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

  Serial.print("Start Delay: ");
  Serial.println(startDelay);

  // Serial.println("Dumping Buffer");
  // for(int i=0;i<buffIndex;i++){
  // Serial.print(MQTTReceiveBuffer[i]);
  // }
  // Serial.println();

}
void stopTopicHandler(){
  Serial.println("Got a stop topic here");
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
  Serial.print("Stop Delay: ");
  Serial.println(stopDelay);


  // Serial.println("Dumping Buffer");
  // for(int i=0;i<buffIndex;i++){
  // Serial.print(MQTTReceiveBuffer[i]);
  // }
  // Serial.println();

}
void gaitTopicHandler(){
  Serial.println("Got a gait topic here");
  // Dump whole message into buffer
  int buffIndex = 0;
  while (mqttClient.available()) {
    MQTTReceiveBuffer[buffIndex] = (char)mqttClient.read();
    buffIndex++;
  }
  Serial.println("Printing Contents of Buffer");
  for(int i=0;i<buffIndex;i++){
  Serial.print(MQTTReceiveBuffer[i]);
  }
  Serial.println();
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

  // print off all values

  Serial.print("A_f: ");
  Serial.print(A_f);
  Serial.print(" f: ");
  Serial.print(f);
  Serial.print(" b_f: ");
  Serial.print(b_f);
  Serial.print(" A_b: ");
  Serial.print(A_b);
  Serial.print(" b_b: ");
  Serial.print(b_b);
  Serial.print(" phi: ");
  Serial.println(phi);

}

