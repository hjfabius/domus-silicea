EESchema Schematic File Version 2  date 2/19/2015 17:27:19
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
LIBS:domus-silicea-cache
EELAYER 25  0
EELAYER END
$Descr A4 11700 8267
encoding utf-8
Sheet 1 1
Title "Silicino Prototype"
Date "19 feb 2015"
Rev ""
Comp ""
Comment1 "Format: PDIP"
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Wire Wire Line
	1400 1100 1400 1500
Wire Wire Line
	1400 1500 1500 1500
Wire Wire Line
	5400 5100 5400 4850
Wire Wire Line
	4500 1450 4500 1100
Wire Wire Line
	3150 7100 3600 7100
Wire Wire Line
	9300 1650 9850 1650
Wire Wire Line
	8000 2300 8000 1750
Wire Wire Line
	8000 1750 8100 1750
Wire Wire Line
	8100 900  5350 900 
Wire Wire Line
	5450 1600 4900 1600
Wire Wire Line
	5450 1500 5350 1500
Connection ~ 1100 4800
Wire Wire Line
	1100 5100 1250 5100
Connection ~ 1050 7100
Wire Wire Line
	1250 7100 1050 7100
Wire Wire Line
	850  1100 3250 1100
Wire Wire Line
	850  850  850  1400
Wire Wire Line
	6650 1500 7050 1500
Wire Wire Line
	4050 1450 4050 850 
Wire Wire Line
	4500 1850 4500 2300
Wire Wire Line
	4900 1600 4900 1100
Wire Wire Line
	4900 1100 3400 1100
Wire Wire Line
	2100 1600 1400 1600
Connection ~ 850  1100
Wire Wire Line
	2000 1700 2100 1700
Wire Wire Line
	5350 2300 5350 1700
Wire Wire Line
	5350 1700 5450 1700
Wire Wire Line
	7050 1500 7050 1600
Wire Wire Line
	1400 1600 1400 2300
Connection ~ 4050 1100
Wire Wire Line
	3150 1700 3550 1700
Wire Wire Line
	3550 2300 3550 2200
Wire Wire Line
	3150 1500 3250 1500
Wire Wire Line
	3250 1500 3250 1100
Wire Wire Line
	3150 1600 3400 1600
Wire Wire Line
	3400 1600 3400 1100
Wire Wire Line
	3550 1100 3550 1200
Connection ~ 3550 1100
Wire Wire Line
	7050 2000 7050 2300
Wire Wire Line
	6750 2300 6750 1700
Connection ~ 4500 1100
Wire Wire Line
	4050 1850 4050 2300
Wire Wire Line
	6750 1700 6650 1700
Wire Wire Line
	850  2300 850  1800
Wire Wire Line
	1050 7300 1050 7000
Wire Wire Line
	1050 7000 1250 7000
Wire Wire Line
	1100 4800 1250 4800
Wire Wire Line
	1100 4550 1100 5400
Wire Wire Line
	1100 5400 1250 5400
Connection ~ 1100 5100
Wire Wire Line
	5350 1500 5350 900 
Wire Wire Line
	9300 1000 9500 1000
Wire Wire Line
	9500 1000 9500 1300
Wire Wire Line
	9500 1300 8000 1300
Wire Wire Line
	8000 1300 8000 1550
Wire Wire Line
	8000 1550 8100 1550
Wire Wire Line
	8100 1100 7900 1100
Wire Wire Line
	3550 4800 3150 4800
Wire Wire Line
	3150 5650 5400 5650
Wire Wire Line
	5400 5650 5400 5500
Wire Wire Line
	5700 5300 6000 5300
Connection ~ 1400 1100
$Comp
L +BATT #PWR?
U 1 1 54E60E06
P 5400 4850
F 0 "#PWR?" H 5400 4800 20  0001 C CNN
F 1 "+BATT" H 5400 4950 30  0000 C CNN
	1    5400 4850
	1    0    0    -1  
$EndComp
Text GLabel 3550 4800 2    40   Input ~ 0
Wake
Text GLabel 3600 7100 2    40   Output ~ 0
Manual Wake
Text GLabel 7900 1100 0    40   Input ~ 0
Manual Wake
$Comp
L GND #PWR?
U 1 1 54E60C3F
P 8000 2300
F 0 "#PWR?" H 8000 2300 30  0001 C CNN
F 1 "GND" H 8000 2230 30  0001 C CNN
	1    8000 2300
	1    0    0    -1  
$EndComp
$Comp
L 7402 U3
U 2 1 54E60B19
P 8700 1650
F 0 "U3" H 8700 1700 40  0000 C CNN
F 1 "7402" H 8750 1600 40  0000 C CNN
	2    8700 1650
	1    0    0    -1  
$EndComp
$Comp
L 7402 U3
U 1 1 54E60B0A
P 8700 1000
F 0 "U3" H 8700 1050 40  0000 C CNN
F 1 "7402" H 8750 950 40  0000 C CNN
	1    8700 1000
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR?
U 1 1 54E60967
P 1100 4550
F 0 "#PWR?" H 1100 4650 30  0001 C CNN
F 1 "VCC" H 1100 4650 30  0000 C CNN
	1    1100 4550
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR?
U 1 1 54E6093D
P 1050 7300
F 0 "#PWR?" H 1050 7300 30  0001 C CNN
F 1 "GND" H 1050 7230 30  0001 C CNN
	1    1050 7300
	1    0    0    -1  
$EndComp
Text GLabel 9850 1650 2    40   Output ~ 0
Wake
Text GLabel 2000 1700 0    40   Input ~ 0
Wake
Text GLabel 6000 5300 2    40   Input ~ 0
Wake
$Comp
L NCP302 U2
U 1 1 54E57EEB
P 5800 1600
F 0 "U2" H 5800 1850 40  0000 C CNN
F 1 "NCP302" H 6150 1350 40  0000 C CNN
	1    5800 1600
	1    0    0    -1  
$EndComp
Text Notes 4550 1900 0    40   ~ 0
Reserve\nCapacitor
$Comp
L GND #PWR?
U 1 1 54E57D87
P 4500 2300
F 0 "#PWR?" H 4500 2300 30  0001 C CNN
F 1 "GND" H 4500 2230 30  0001 C CNN
	1    4500 2300
	1    0    0    -1  
$EndComp
$Comp
L C C3
U 1 1 54E57D7C
P 4500 1650
F 0 "C3" H 4550 1750 40  0000 L CNN
F 1 "???" H 4550 1550 40  0000 L CNN
	1    4500 1650
	1    0    0    -1  
$EndComp
$Comp
L NRF24L01+ U?
U 1 1 54E57CB4
P 9800 3450
F 0 "U?" H 9650 3800 50  0000 C CNN
F 1 "NRF24L01+" H 9850 3200 50  0000 C CNN
	1    9800 3450
	1    0    0    -1  
$EndComp
$Comp
L ATMEGA328P-P IC?
U 1 1 54E57C94
P 2150 5900
F 0 "IC?" H 1450 7150 50  0000 L BNN
F 1 "ATMEGA328P-P" H 2350 4500 50  0000 L BNN
F 2 "DIL28" H 1550 4550 50  0001 C CNN
	1    2150 5900
	1    0    0    -1  
$EndComp
$Comp
L MOSFET_P Q1
U 1 1 54E2206B
P 5500 5300
F 0 "Q1" H 5500 5490 40  0000 R CNN
F 1 "MOSFET_P" H 5500 5120 40  0000 R CNN
	1    5500 5300
	-1   0    0    -1  
$EndComp
Text Notes 5850 1950 0    30   ~ 0
 NCP302LSN20T1\nThreshold detection at 2V
$Comp
L CP1 C4
U 1 1 54E1F57F
P 7050 1800
F 0 "C4" H 7100 1900 40  0000 L CNN
F 1 "0.1 uF" H 7100 1700 40  0000 L CNN
	1    7050 1800
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR?
U 1 1 54E1F526
P 7050 2300
F 0 "#PWR?" H 7050 2300 30  0001 C CNN
F 1 "GND" H 7050 2230 30  0001 C CNN
	1    7050 2300
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR?
U 1 1 54E1F521
P 6750 2300
F 0 "#PWR?" H 6750 2300 30  0001 C CNN
F 1 "GND" H 6750 2230 30  0001 C CNN
	1    6750 2300
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR?
U 1 1 54E1F508
P 5350 2300
F 0 "#PWR?" H 5350 2300 30  0001 C CNN
F 1 "GND" H 5350 2230 30  0001 C CNN
	1    5350 2300
	1    0    0    -1  
$EndComp
$Comp
L MCP1640 U1
U 1 1 54DDB2F2
P 2600 1600
F 0 "U1" H 2450 1850 39  0000 C CNN
F 1 "MCP1640" H 2650 1350 39  0000 C CNN
	1    2600 1600
	1    0    0    -1  
$EndComp
Text Notes 750  650  0    31   ~ 0
Alkaline Battery\n0.9V to 1.7V\n
Text Notes 3900 700  0    31   ~ 0
3.6V @ 100mA
$Comp
L VCC #PWR?
U 1 1 54DDB101
P 4050 850
F 0 "#PWR?" H 4050 950 30  0001 C CNN
F 1 "VCC" H 4050 950 30  0000 C CNN
	1    4050 850 
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR?
U 1 1 54DDB059
P 4050 2300
F 0 "#PWR?" H 4050 2300 30  0001 C CNN
F 1 "GND" H 4050 2230 30  0001 C CNN
	1    4050 2300
	1    0    0    -1  
$EndComp
$Comp
L C C2
U 1 1 54DDB04B
P 4050 1650
F 0 "C2" H 4100 1750 40  0000 L CNN
F 1 "10uF" H 4100 1550 40  0000 L CNN
	1    4050 1650
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR?
U 1 1 54DDB023
P 3550 2300
F 0 "#PWR?" H 3550 2300 30  0001 C CNN
F 1 "GND" H 3550 2230 30  0001 C CNN
	1    3550 2300
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR?
U 1 1 54DDAFB7
P 850 2300
F 0 "#PWR?" H 850 2300 30  0001 C CNN
F 1 "GND" H 850 2230 30  0001 C CNN
	1    850  2300
	1    0    0    -1  
$EndComp
$Comp
L C C1
U 1 1 54DDABB5
P 850 1600
F 0 "C1" H 900 1700 40  0000 L CNN
F 1 "C4.7uF" H 900 1500 40  0000 L CNN
	1    850  1600
	1    0    0    -1  
$EndComp
$Comp
L R R2
U 1 1 54DDAB61
P 3550 1950
F 0 "R2" V 3630 1950 40  0000 C CNN
F 1 "510K" V 3550 1950 40  0000 C CNN
	1    3550 1950
	1    0    0    -1  
$EndComp
$Comp
L R R1
U 1 1 54DDAB5A
P 3550 1450
F 0 "R1" V 3630 1450 40  0000 C CNN
F 1 "1M" V 3550 1450 40  0000 C CNN
	1    3550 1450
	1    0    0    -1  
$EndComp
$Comp
L INDUCTOR L1
U 1 1 54DDAAAE
P 1800 1500
F 0 "L1" V 1750 1500 40  0000 C CNN
F 1 "4.7uH" V 1900 1500 40  0000 C CNN
	1    1800 1500
	0    -1   -1   0   
$EndComp
$Comp
L GND #PWR?
U 1 1 54DDA9D6
P 1400 2300
F 0 "#PWR?" H 1400 2300 30  0001 C CNN
F 1 "GND" H 1400 2230 30  0001 C CNN
	1    1400 2300
	1    0    0    -1  
$EndComp
$Comp
L +BATT #PWR?
U 1 1 54DDA9C2
P 850 850
F 0 "#PWR?" H 850 800 20  0001 C CNN
F 1 "+BATT" H 850 950 30  0000 C CNN
	1    850  850 
	1    0    0    -1  
$EndComp
$EndSCHEMATC
