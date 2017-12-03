/*
  Created
  December 3, 2017
  by Cristian G Guerrero (@guyikcgg)

  Modified version of Append_Element_to_Builder
  April 8, 2016
  by Hugo Arganda (@argandas)
*/

#include "ardubson.h"


void setup() {
  // Setup serial port
  Serial.begin(9600);
  Serial.println("BSON Object Builder example");

  // Create a BSON Builder for the 1st child
  BSONObjBuilder bob_c1;
  // Append an element to BSON Builder
  bob_c1.append("role", "child");
  bob_c1.append("number", 1);

  // Generate child's BSON Object
  BSONObject bo_c1 = bob_c1.obj();


  // Create another BSON Builder for the parent
  BSONObjBuilder bob_p;   // parent
  // Append an element to BSON Builder
  bob_p.append("role", "parent");
  bob_p.append("n", 1);
  bob_p.append("embed", bob_c1);
  bob_p.append("other", "other string");

  // Generate parent's BSON Object
  BSONObject bo_p = bob_p.obj();


  // Print object length
  Serial.print("\r\nBSON Object data length: ");
  Serial.println(bo_p.len());
  // Print object data in HEX format
  Serial.println("BSON Object data: ");
  printHex(bo_p.rawData(), bo_p.len());

  // Get BSON Object element
  BSONElement be = bo_p.getField("other");
  Serial.print("\r\nBSON Element data length: ");
  Serial.println(be.len());
  // Print element data in HEX format
  Serial.println("BSON Element data (raw): ");
  printHex(be.rawData(), be.len());
  Serial.print("BSON Element data value: ");
  Serial.println(be.getString());

  // Get BSON Object document
  BSONObject bo = bo_p.getFieldObject("embed");
  Serial.print("BSON Element data (inside embedded Object): ");
  Serial.println(bo.getField("role").getString());
}

void loop() {
  // Do nothing
}

void printHex(char* data, int len) {
  for (int i = 0; i < len; i++, data++) {
    Serial.print("0x");
    if ((unsigned char)*data <= 0xF) Serial.print("0");
    Serial.print((unsigned char)*data, HEX);
    Serial.print(" ");
    if ((i + 1) % 0x8 == 0) Serial.println();
  }
  Serial.println();
}
