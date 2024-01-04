#include <BasicLinearAlgebra.h>
#include "systemtest.h"
using namespace BLA;

float f=1.2; // Hz
float ang=40; // Maximum angel (Amplitude)
float dt=0.1; // Discrete time step
float t_old = 0;
float t;

BLA::Matrix<1> y;
BLA::Matrix<3,1> ref={0,0,0};
BLA::Matrix<1> u_old={0};
BLA::Matrix<3,1> x_old={0,0,0};
BLA::Matrix<3,1> x ={0,0,0};
BLA::Matrix<1> u ={0};

void setup() {
  Serial.begin(115200);
  Serial.setTimeout(1);
}

void  loop() {
  
  while (!Serial.available());
  y(0) = Serial.readString().toInt();
  t = millis()/1000.0;
  x(2,0)=y(0);

  if (t-t_old)>=dt {
  x = A*x_old + B*u_old + L*(y-C*x_old);
  ref(2,0)=ang*sin(2*3.14*f*t);
  u = Kl*(ref-x);
  Serial.print(String(u(0)));
  //change u to pwm
  //set up the limit
  u_old = u;
  x_old = x;
  t_old = t;
  }
  
}
