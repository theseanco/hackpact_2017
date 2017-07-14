#include <Arduino.h>

/*********************************************************************
This is an example for our Monochrome OLEDs based on SSD1306 drivers

  Pick one up today in the adafruit shop!
  ------> http://www.adafruit.com/category/63_98

This example is for a 128x64 size display using I2C to communicate
3 pins are required to interface (2 I2C and one reset)

Adafruit invests time and resources providing this open source code,
please support Adafruit and open-source hardware by purchasing
products from Adafruit!

Written by Limor Fried/Ladyada  for Adafruit Industries.
BSD license, check license.txt for more information
All text above, and the splash screen must be included in any redistribution
*********************************************************************/

#include <SPI.h>
#include <Wire.h>
#include <Adafruit_GFX.h>
#include <Adafruit_SSD1306.h>
// Add magnetometer libraries
#include <HMC5883L.h>
#include <SD.h>

#define OLED_RESET 8
Adafruit_SSD1306 display(OLED_RESET);

#if (SSD1306_LCDHEIGHT != 64)
#error("Height incorrect, please fix Adafruit_SSD1306.h!");
#endif

//magnetometer declarations
HMC5883L mag;
int16_t mx, my, mz;
const int chipSelect = 4;

void setup()   {
  SD.begin(chipSelect);
  Wire.begin();
  Serial.begin(9600);

  delay(1000);



  //initialize magnetometer
  mag.initialize();
  // by default, we'll generate the high voltage from the 3.3v line internally! (neat!)
  display.begin(SSD1306_SWITCHCAPVCC, 0x3C);  // initialize with the I2C addr 0x3D (for the 128x64)
  // init done


  }


void loop() {
  // get heading
  mag.getHeading(&mx, &my, &mz);
  //calculate heading in degrees
  float heading = atan2(my,mx);
  if (heading < 0)
    heading += 2 * M_PI;

  // display.setTextSize(2);
  // display.setTextColor(WHITE);
  // display.setCursor(0, 0);
  // display.println("hi laura");
  // display.print(heading * 180 / M_PI);
  // display.println(" ");
  // display.println(" ");
  // display.setTextSize(1);
  // display.println("heck");
  // Serial.println(heading * 180 / M_PI);

  int randomNumber = random(0, 100);

  String fileString = "wrong_"+String(randomNumber
  )+".txt";

  File dataFile = SD.open(fileString);

  // if the file is available, write to it:
  if (dataFile) {
    while (dataFile.available()) {
      Serial.write(dataFile.read());
    }
    dataFile.close();
  }
  // text display tests
  // display.setTextSize(1);
  // display.setTextColor(WHITE);
  // display.setCursor(0,0);
  // display.println("Hello, world!");
  // display.setTextColor(BLACK, WHITE); // 'inverted' text
  // display.println(3.141592);
  // display.setTextSize(2);
  // display.setTextColor(WHITE);
  // display.print("0x"); display.println(0xDEADBEEF, HEX);
  // display.print(mx);
  // display.print(", ");
  // display.print(my);
  // display.print(", ");
  // display.println(mz);
  display.display();
  display.clearDisplay();
}
