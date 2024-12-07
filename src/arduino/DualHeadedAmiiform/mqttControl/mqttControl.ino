#include <Arduino.h>
#include "ODriveCAN.h"

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


/* ------------- CAN SETUP  -------------  */
// TODO: Finish setting up CAN for both odrives using the dualOdriveTest exmample code
// CAN bus baudrate. Make sure this matches for every device on the bus
#define CAN_BAUDRATE 250000

// ODrive node_id for odrv0
#define ODRV0_NODE_ID 0
#define ODRV1_NODE_ID 1

// Uncomment below the line that corresponds to your hardware.
// See also "Board-specific settings" to adapt the details for your hardware setup.

// #define IS_TEENSY_BUILTIN // Teensy boards with built-in CAN interface (e.g. Teensy 4.1). See below to select which interface to use.
#define IS_ARDUINO_BUILTIN // Arduino boards with built-in CAN interface (e.g. Arduino Uno R4 Minima)
// #define IS_MCP2515 // Any board with external MCP2515 based extension module. See below to configure the module.


/* Board-specific includes ---------------------------------------------------*/


// See https://github.com/arduino/ArduinoCore-API/blob/master/api/HardwareCAN.h
// and https://github.com/arduino/ArduinoCore-renesas/tree/main/libraries/Arduino_CAN

#include <Arduino_CAN.h>
#include <ODriveHardwareCAN.hpp>





/* Board-specific settings ---------------------------------------------------*/



/* Arduinos with built-in CAN */


HardwareCAN& can_intf = CAN;

bool setupCan() {
  return can_intf.begin((CanBitRate)CAN_BAUDRATE);
}



/* Example sketch ------------------------------------------------------------*/

// Instantiate ODrive objects
ODriveCAN odrv0(wrap_can_intf(can_intf), ODRV0_NODE_ID); // Standard CAN message ID
ODriveCAN odrv1(wrap_can_intf(can_intf), ODRV1_NODE_ID); // Standard CAN message ID
ODriveCAN* odrives[] = {&odrv0,&odrv1}; // Make sure all ODriveCAN instances are accounted for here

struct ODriveUserData {
  Heartbeat_msg_t last_heartbeat;
  bool received_heartbeat = false;
  Get_Encoder_Estimates_msg_t last_feedback;
  bool received_feedback = false;
};

// Keep some application-specific user data for every ODrive.
ODriveUserData odrv0_user_data;
ODriveUserData odrv1_user_data;

// Called every time a Heartbeat message arrives from the ODrive
void onHeartbeat(Heartbeat_msg_t& msg, void* user_data) {
  ODriveUserData* odrv_user_data = static_cast<ODriveUserData*>(user_data);
  odrv_user_data->last_heartbeat = msg;
  odrv_user_data->received_heartbeat = true;
}

// Called every time a feedback message arrives from the ODrive
void onFeedback(Get_Encoder_Estimates_msg_t& msg, void* user_data) {
  ODriveUserData* odrv_user_data = static_cast<ODriveUserData*>(user_data);
  odrv_user_data->last_feedback = msg;
  odrv_user_data->received_feedback = true;
}

// Called for every message that arrives on the CAN bus
void onCanMessage(const CanMsg& msg) {
  for (auto odrive: odrives) {
    onReceive(msg, *odrive);
  }
}

void setup() {
  //Initialize serial and wait for port to open:
  delay(3000);
  Serial.begin(115200);
  while (!Serial) {
    ; // wait for serial port to connect. Needed for native USB port only
  }
  Serial.println("Got here");
    // delay(10000);

  /* --- CAN SETUP --- */
  Serial.println("Starting ODriveCAN");

  // Register callbacks for the heartbeat and encoder feedback messages
  odrv0.onFeedback(onFeedback, &odrv0_user_data);
  odrv0.onStatus(onHeartbeat, &odrv0_user_data);  
  odrv1.onFeedback(onFeedback, &odrv1_user_data);
  odrv1.onStatus(onHeartbeat, &odrv1_user_data);

  // Configure and initialize the CAN bus interface. This function depends on
  // your hardware and the CAN stack that you're using.
  if (!setupCan()) {
    Serial.println("CAN failed to initialize: reset required");
    while (true); // spin indefinitely
  }

  Serial.println("Waiting for ODrive 0...");
  while (!odrv0_user_data.received_heartbeat) {
    pumpEvents(can_intf);
    delay(100);
  }
  Serial.println("Waiting for ODrive 1...");
  while (!odrv1_user_data.received_heartbeat) {
    pumpEvents(can_intf);
    delay(100);
  }

  Serial.println("found ODrives!");

  // request bus voltage and current (1sec timeout)
  Serial.println("attempting to read bus voltage and current");
  Get_Bus_Voltage_Current_msg_t vbus;
  if (!odrv0.request(vbus, 1)) {
    Serial.println("vbus request failed!");
    while (true); // spin indefinitely
  }

  Serial.print("DC voltage [V]: ");
  Serial.println(vbus.Bus_Voltage);
  Serial.print("DC current [A]: ");
  Serial.println(vbus.Bus_Current);

  Serial.println("Enabling closed loop control for ODrive 0...");
  while (odrv0_user_data.last_heartbeat.Axis_State != ODriveAxisState::AXIS_STATE_CLOSED_LOOP_CONTROL) {
    odrv0.clearErrors();
    delay(1);
    odrv0.setState(ODriveAxisState::AXIS_STATE_CLOSED_LOOP_CONTROL);
    // Pump events for 150ms. This delay is needed for two reasons;
    // 1. If there is an error condition, such as missing DC power, the ODrive might
    //    briefly attempt to enter CLOSED_LOOP_CONTROL state, so we can't rely
    //    on the first heartbeat response, so we want to receive at least two
    //    heartbeats (100ms default interval).
    // 2. If the bus is congested, the setState command won't get through
    //    immediately but can be delayed.
    for (int i = 0; i < 15; ++i) {
      delay(10);
      pumpEvents(can_intf);
    }
  }
  Serial.println("Enabling closed loop control for ODrive 1...");
  while (odrv1_user_data.last_heartbeat.Axis_State != ODriveAxisState::AXIS_STATE_CLOSED_LOOP_CONTROL) {
    odrv1.clearErrors();
    delay(1);
    odrv1.setState(ODriveAxisState::AXIS_STATE_CLOSED_LOOP_CONTROL);
    // Pump events for 150ms. This delay is needed for two reasons;
    // 1. If there is an error condition, such as missing DC power, the ODrive might
    //    briefly attempt to enter CLOSED_LOOP_CONTROL state, so we can't rely
    //    on the first heartbeat response, so we want to receive at least two
    //    heartbeats (100ms default interval).
    // 2. If the bus is congested, the setState command won't get through
    //    immediately but can be delayed.
    for (int i = 0; i < 15; ++i) {
      delay(10);
      pumpEvents(can_intf);
    }
  }

  Serial.println("ODrives running!");

  /* --- MQTT SETUP --- */
  
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
  unsigned int reconnectTime=3000;
  unsigned int mqttAttempts = 0;
  while (!mqttClient.connect(broker, port)) {
    mqttAttempts++;
    Serial.print("MQTT connection attempt ");
    Serial.print(mqttAttempts);
    Serial.print(" failed! Error code = ");
    Serial.println(mqttClient.connectError());
    delay(reconnectTime);
    reconnectTime+=1000;
    
    

    // while (1);
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
  pumpEvents(can_intf); // This is required on some platforms to handle incoming feedback CAN messages

  // Calculate finray angle
  if (isRunning==true){
    float time = float(millis()-startedRunningTime)/1000.0; // seconds
    // compute finray angles from gait parameters
    theta_f = A_f*sin(2*PI*f*time) + b_f;
    theta_b = A_b*sin(2*PI*f*time + phi)+ b_b;

    thetad_f = A_f*2*PI*f*cos(2*PI*f*time);
    thetad_b = A_b*2*PI*f*cos(2*PI*f*time+phi);

    // Serial.println("RUNNING");
  //   float SINE_PERIOD = 0.2f; // Period of the position command sine wave in seconds

  // float t = 0.001 * millis();
  
  // float phase = t * (TWO_PI / SINE_PERIOD);
  // float amplitude = 0.05;

  // odrv0.setPosition(
  //   amplitude*sin(phase), // position
  //   amplitude*cos(phase) * (TWO_PI / SINE_PERIOD) // velocity feedforward (optional)
  // );
  // delay(2);
  // odrv1.setPosition(
  //   amplitude*sin(phase), // position
  //   amplitude*cos(phase) * (TWO_PI / SINE_PERIOD) // velocity feedforward (optional)
  // );
  // delay(2);

  }
  else{
  // float SINE_PERIOD = 0.2f; // Period of the position command sine wave in seconds

  // float t = 0.001 * millis();
  
  // float phase = t * (TWO_PI / SINE_PERIOD);
  // float amplitude = 0.01;

  // odrv0.setPosition(
  //   amplitude*sin(phase), // position
  //   amplitude*cos(phase) * (TWO_PI / SINE_PERIOD) // velocity feedforward (optional)
  // );
  // delay(2);
  // odrv1.setPosition(
  //   amplitude*sin(phase), // position
  //   amplitude*cos(phase) * (TWO_PI / SINE_PERIOD) // velocity feedforward (optional)
  // );
  // delay(2);

    // set finray angles to 0
    // Serial.println("STOPPED");
    theta_f = 0;
    theta_b = 0;
    thetad_f = 0;
    thetad_b = 0;
    
  }
  // // TODO: Send joint angles over CAN bus
  // // Serial.print("theta_f: ");
  // Serial.print(theta_f);
  // // Serial.print(", theta_b: ");
  // Serial.print("\t");
  // Serial.print(theta_b);
  // // Serial.print(", thetad_f: ");
  // Serial.print("\t");
  // Serial.print(thetad_f);
  // // Serial.print(", thetad_b: ");
  // Serial.print("\t");
  // Serial.println(thetad_b);
    
  odrv0.setPosition(
    theta_f, // position
    thetad_f // velocity feedforward (optional)
  );
  delay(2);
  odrv1.setPosition(
    theta_b, // position
    thetad_b // velocity feedforward (optional)
  );
  delay(2);

  // TODO: Sensing/sending data back 

    // print position and velocity for Serial Plotter
  if (odrv0_user_data.received_feedback) {
    Get_Encoder_Estimates_msg_t feedback = odrv0_user_data.last_feedback;
    odrv0_user_data.received_feedback = false;
    Serial.print("odrv0-pos:");
    Serial.print(feedback.Pos_Estimate);
    Serial.print(",");
    Serial.print("odrv0-vel:");
    Serial.println(feedback.Vel_Estimate);
  }
  if (odrv1_user_data.received_feedback) {
    Get_Encoder_Estimates_msg_t feedback = odrv1_user_data.last_feedback;
    odrv1_user_data.received_feedback = false;
    Serial.print("odrv1-pos:");
    Serial.print(feedback.Pos_Estimate);
    Serial.print(",");
    Serial.print("odrv1-vel:");
    Serial.println(feedback.Vel_Estimate);
  }




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



