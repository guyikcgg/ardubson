/*
 ardubson.h - Library for the BSON (Binary-JSON) format.
 Created by Hugo Arganda (argandas), April 6, 2016.
 Released into the public domain.
 */
/*
 Check BSON specification at:
 http://bsonspec.org/spec.html
 */

#ifndef ardubson_object_h
#define ardubson_object_h

#include "Arduino.h"
#include "ardubsonTypes.h"
#include "ardubsonConfig.h"
#include "ardubsonElement.h"

class BSONObject
{
    public:

        /* Build BSON Object from binary data */
        BSONObject(char* data);

        /* API to BSON Object buffer */
        char* rawData(void);

        /* Total number of bytes comprising the document */
        int32_t len(void);

        /* Get BSON Element by name */
        BSONElement getField(const char *key);
        BSONObject getFieldObject(const char *fieldName);

        /* Print BSON document in JSON format */
        char* jsonString(void);

    private:
        bool appendJSON(const char* data);
        char _objData[BSON_BUFF_SIZE];
        char _jsonStr[JSON_MAX_SIZE];
};

#endif
