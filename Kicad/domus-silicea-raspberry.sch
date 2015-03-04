EESchema Schematic File Version 2  date 3/4/2015 22:12:45
LIBS:power
LIBS:device
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
LIBS:special
LIBS:microcontrollers
LIBS:dsp
LIBS:microchip
LIBS:analog_switches
LIBS:motorola
LIBS:texas
LIBS:intel
LIBS:audio
LIBS:interface
LIBS:digital-audio
LIBS:philips
LIBS:display
LIBS:cypress
LIBS:siliconi
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:valves
LIBS:customComponents
EELAYER 25  0
EELAYER END
$Descr A4 11700 8267
encoding utf-8
Sheet 1 1
Title "domus-silicea-raspberry.sch"
Date "4 mar 2015"
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Wire Wire Line
	1450 4400 1450 2900
Wire Wire Line
	1450 4400 4900 4400
Wire Wire Line
	4900 4400 4900 2700
Connection ~ 7050 2750
Wire Wire Line
	7650 2750 7050 2750
Connection ~ 1550 2200
Wire Wire Line
	1550 2700 1550 1500
Wire Wire Line
	7050 3000 7050 2600
Wire Wire Line
	6750 3200 6250 3200
Wire Wire Line
	1450 2900 1350 2900
Wire Wire Line
	1550 2700 1350 2700
Wire Wire Line
	4900 2700 4600 2700
Wire Wire Line
	4600 2400 5200 2400
Wire Wire Line
	5200 2400 5200 4100
Wire Wire Line
	1550 2200 2850 2200
Wire Wire Line
	1550 2800 1550 4100
Wire Wire Line
	1550 2800 1350 2800
Connection ~ 5200 4100
Wire Wire Line
	5750 3200 4600 3200
Wire Wire Line
	7050 4100 7050 3400
Connection ~ 7050 4100
Wire Wire Line
	7050 2100 7050 1500
Wire Wire Line
	7050 1500 1550 1500
Wire Wire Line
	1550 4100 7800 4100
Wire Wire Line
	7800 4100 7800 2950
$Comp
L TSOP4838 U?
U 1 1 54F77298
P 950 2800
F 0 "U?" H 900 3100 60  0000 C CNN
F 1 "TSOP4838" H 1050 2500 60  0000 C CNN
	1    950  2800
	-1   0    0    1   
$EndComp
$Comp
L R R?
U 1 1 54F77208
P 6000 3200
F 0 "R?" V 6080 3200 50  0000 C CNN
F 1 "220" V 6000 3200 50  0000 C CNN
	1    6000 3200
	0    1    1    0   
$EndComp
$Comp
L R R?
U 1 1 54F76C2A
P 7050 2350
F 0 "R?" V 7130 2350 50  0000 C CNN
F 1 "560" V 7050 2350 50  0000 C CNN
	1    7050 2350
	1    0    0    -1  
$EndComp
$Comp
L BNC P?
U 1 1 54F76B60
P 7800 2750
F 0 "P?" H 7810 2870 60  0000 C CNN
F 1 "BNC" V 7910 2690 40  0000 C CNN
	1    7800 2750
	1    0    0    -1  
$EndComp
Text Notes 10100 2950 0    60   ~ 0
TSAL 6200 940 nm
$Comp
L BC237 Q?
U 1 1 54F76732
P 6950 3200
F 0 "Q?" H 7150 3100 50  0000 C CNN
F 1 "BC547B" H 7200 3350 50  0000 C CNN
F 2 "TO92-EBC" H 7140 3200 30  0001 C CNN
	1    6950 3200
	1    0    0    -1  
$EndComp
$Comp
L LED D?
U 1 1 54F76656
P 10450 2600
F 0 "D?" H 10450 2700 50  0000 C CNN
F 1 "IR LED" H 10450 2500 50  0000 C CNN
	1    10450 2600
	1    0    0    -1  
$EndComp
$Comp
L RASPBERRY_PI_B_REV2 P?
U 1 1 54F763BF
P 3750 2800
F 0 "P?" H 3200 3750 60  0000 C CNN
F 1 "RASPBERRY_PI_B_REV2" H 3800 2000 60  0000 C CNN
	1    3750 2800
	1    0    0    -1  
$EndComp
$EndSCHEMATC
