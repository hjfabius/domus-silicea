#include "DomusSiliceaLogging.h"

void DomusSiliceaLogging::Init(int level, long baud){
    _level = constrain(level,DOMUSSILICEA_LOG_LEVEL_NOOUTPUT,DOMUSSILICEA_LOG_LEVEL_VERBOSE);
    _baud = baud;
    Serial.begin(_baud);
}

void DomusSiliceaLogging::Error(char* msg, ...){
    if (DOMUSSILICEA_LOG_LEVEL_ERRORS <= _level) {   
		print ("DOMUS SILICEA - ERR - ",0);
        va_list args;
        va_start(args, msg);
        print(msg,args);
    }
}


void DomusSiliceaLogging::Info(char* msg, ...){
    if (DOMUSSILICEA_LOG_LEVEL_INFOS <= _level) {
		print ("DOMUS SILICEA - INF - ",0);
        va_list args;
        va_start(args, msg);
        print(msg,args);
    }
}

void DomusSiliceaLogging::Debug(char* msg, ...){
    if (DOMUSSILICEA_LOG_LEVEL_DEBUG <= _level) {
		print ("DOMUS SILICEA - DBG - ",0);
        va_list args;
        va_start(args, msg);
        print(msg,args);
    }
}


void DomusSiliceaLogging::Verbose(char* msg, ...){
    if (DOMUSSILICEA_LOG_LEVEL_VERBOSE <= _level) {
		print ("DOMUS SILICEA - VER - ",0);
        va_list args;
        va_start(args, msg);
        print(msg,args);
    }
}



 void DomusSiliceaLogging::print(const char *format, va_list args) {
    //
    // loop through format string
    for (; *format != 0; ++format) {
        if (*format == '%') {
            ++format;
            if (*format == '\0') break;
            if (*format == '%') {
                Serial.print(*format);
                continue;
            }
            if( *format == 's' ) {
				register char *s = (char *)va_arg( args, int );
				Serial.print(s);
				continue;
			}
            if( *format == 'd' || *format == 'i') {
				Serial.print(va_arg( args, int ),DEC);
				continue;
			}
            if( *format == 'x' ) {
				Serial.print(va_arg( args, int ),HEX);
				continue;
			}
            if( *format == 'X' ) {
				Serial.print("0x");
				Serial.print(va_arg( args, int ),HEX);
				continue;
			}
            if( *format == 'b' ) {
				Serial.print(va_arg( args, int ),BIN);
				continue;
			}
            if( *format == 'B' ) {
				Serial.print("0b");
				Serial.print(va_arg( args, int ),BIN);
				continue;
			}
            if( *format == 'l' ) {
				Serial.print(va_arg( args, long ),DEC);
				continue;
			}
            if( *format == 'f' ) {
				Serial.print(va_arg(args, int));
				continue;
			}
            if( *format == 'c' ) {
				Serial.print(va_arg( args, int ));
				continue;
			}
            if( *format == 't' ) {
				if (va_arg( args, int ) == 1) {
					Serial.print("T");
				}
				else {
					Serial.print("F");				
				}
				continue;
			}
            if( *format == 'T' ) {
				if (va_arg( args, int ) == 1) {
					Serial.print("true");
				}
				else {
					Serial.print("false");				
				}
				continue;
			}

        }
        Serial.print(*format);
    }
 }
 
 DomusSiliceaLogging Log = DomusSiliceaLogging();

 
 
  




