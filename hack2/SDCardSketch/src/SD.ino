// A sketch that reads back random lines in a file, which will the be honed down
// for later use.
// TODO, add this to ssd1306_*.ino
#include <Arduino.h>

#include <SPI.h>
#include <SD.h>

const int chipSelect = 4;

void setup() {
  // Open serial communications and wait for port to open:
  Serial.begin(9600);
  // see if the card is present and can be initialized:
    if (!SD.begin(chipSelect)) {
    Serial.println("Card failed, or not present");
    // don't do anything more:
    return;
  }
}

void loop() {

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
}
