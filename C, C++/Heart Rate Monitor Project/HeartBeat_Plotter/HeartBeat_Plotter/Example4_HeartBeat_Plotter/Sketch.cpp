/*Begining of Auto generated code by Atmel studio */
#include <Arduino.h>

/*End of auto generated code by Atmel studio */

#include <Wire.h>
#include "MAX30105.h"
#include "heartRate.h"
//Beginning of Auto generated function prototypes by Atmel Studio
//End of Auto generated function prototypes by Atmel Studio
const byte RATE_SIZE = 4; //Increase this for more averaging. 4 is good.
byte rates[RATE_SIZE]; //Array of heart rates
byte rateSpot = 0;
long lastBeat = 0; //Time at which the last beat occurred

float beatsPerMinute;
int beatAvg;

MAX30105 particleSensor;

void setup()
{
  Serial.begin(9600);
  Serial.println("Initializing...");

  // Initialize sensor
  if (!particleSensor.begin(Wire, I2C_SPEED_FAST)) //Use default I2C port, 400kHz speed
  {
    Serial.println("MAX30105 was not found. Please check wiring/power. ");
    while (1);
  }

  //Setup to sense a nice looking saw tooth on the plotter
  byte ledBrightness = 0x1F; //Options: 0=Off to 255=50mA
  byte sampleAverage = 4; //Options: 1, 2, 4, 8, 16, 32 //4 on Ex. 5 
  byte ledMode = 2; //Options: 1 = Red only, 2 = Red + IR, 3 = Red + IR + Green
  int sampleRate = 400; //Options: 50, 100, 200, 400, 800, 1000, 1600, 3200 //400 on Ex. 5
  int pulseWidth = 411; //Options: 69, 118, 215, 411
  int adcRange = 4096; //Options: 2048, 4096, 8192, 16384

  particleSensor.setup(ledBrightness, sampleAverage, ledMode, sampleRate, pulseWidth, adcRange); //Configure sensor with these settings

  //Arduino plotter auto-scales annoyingly. To get around this, pre-populate
  //the plotter with 500 of an average reading from the sensor

  //Take an average of IR readings at power up
  const byte avgAmount = 64;
  long baseValue = 0;
  for (byte x = 0 ; x < avgAmount ; x++)
  {
    baseValue += particleSensor.getIR(); //Read the IR value
  }
  baseValue /= avgAmount;

  //Pre-populate the plotter so that the Y scale is close to IR values
  /*for (int x = 0 ; x < 500 ; x++)
    Serial.println(baseValue);*/
}

void loop()
{
	  long irValue = particleSensor.getIR();

	  if (checkForBeat(irValue) == true)
	  {
		  //We sensed a beat!
		  long delta = millis() - lastBeat;
		  lastBeat = millis();

		  beatsPerMinute = 60 / (delta / 1000.0);

		  if (beatsPerMinute < 255 && beatsPerMinute > 20)
		  {
			  rates[rateSpot++] = (byte)beatsPerMinute; //Store this reading in the array
			  rateSpot %= RATE_SIZE; //Wrap variable

			  //Take average of readings
			  beatAvg = 0;
			  for (byte x = 0 ; x < RATE_SIZE ; x++)
			  beatAvg += rates[x];
			  beatAvg /= RATE_SIZE;
		  }
	  }
    Serial.print("IR=");
    Serial.print(irValue);
    Serial.print(", BPM=");
    Serial.print(beatsPerMinute);
    Serial.print(", Avg BPM(RR Interval)=");
    Serial.print(beatAvg);

    if (irValue < 50000)
    Serial.print(" No finger?");

    Serial.println();
  //Serial.println(particleSensor.getIR()); //Send raw data to plotter
}
