#include <Encoder.h>

#define ENCA 2 // YELLOW from polulu encoder
#define ENCB 3 // WHITE from polulu encoder

#define IN2 7 //in2 from driver // pins to control direction
#define IN1 6 //in1 from driver // pins to control direction
#define pwmpin 5 //pwm to control speed

#define stepsPerRot  970.0
#define degPerStep 360.0/stepsPerRot

#define kp 20.0
#define kd 0.1
#define ki 0.05

#define pwmMax 255
#define pwmMin 0


float time = 0;
float prevTime = 0;
float error = 0;
float prevError = 0;
float cumError = 0;
float controlSignal = 0;
float ref = 0;

Encoder myEnc(2, 3);

long oldPosition  = -999;

float getAngle(Encoder enc){
  return enc.read()*degPerStep;
}

long startTime = 0;


void setSpeed(int controlSignal, int dirPin1, int dirPin2, int pwmPin){
  // Serial.print("control signal: ");
  // Serial.println(controlSignal);
  int pwmSignal = max(min(pwmMax,abs(controlSignal)),pwmMin);
  bool direction = (controlSignal >=0);

  // if speed is positive spin forward
  if(direction){
    // Set direction forward
  digitalWrite(IN1,HIGH);
  digitalWrite(IN2,LOW);
  analogWrite(pwmpin,pwmSignal);
  }
  else{
        // Set direction backward
  digitalWrite(IN1,LOW);
  digitalWrite(IN2,HIGH);
  analogWrite(pwmpin,pwmSignal);

  }


}

void computeControlSignal(){
  prevTime = time;
  time = millis()/1000.0;
  float dt = time-prevTime;
  prevError = error;
  error = ref - getAngle(myEnc);
  
  cumError += error*dt;

  controlSignal = kp*error + ki*cumError + kd*(error-prevError)/dt;
  

}


void setup() {
  pinMode(IN1, OUTPUT);
  pinMode(IN2, OUTPUT);
  pinMode(pwmpin, OUTPUT);
  
  Serial.begin(115200);
  startTime = millis()/1000.0;

}

void loop() {
  ref = 0*sin(time*6.28*8);
  computeControlSignal();
  setSpeed(int(controlSignal), IN1, IN2, pwmpin);
  Serial.println(getAngle(myEnc));
  delay(1);


  
  
}

