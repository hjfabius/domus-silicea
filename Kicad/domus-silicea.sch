EESchema Schematic File Version 2  date 2/16/2015 17:59:50
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
Date "16 feb 2015"
Rev ""
Comp ""
Comment1 "Format: PDIP"
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Wire Wire Line
	1850 1700 1150 1700
Connection ~ 600  1200
Wire Wire Line
	600  1750 600  1000
Connection ~ 4900 1600
Wire Wire Line
	4900 1000 4900 1600
Wire Wire Line
	4250 1200 3150 1200
Wire Wire Line
	4250 1000 4250 1700
Wire Wire Line
	4250 1700 5000 1700
Connection ~ 4800 1600
Wire Wire Line
	1750 1800 1850 1800
Wire Wire Line
	600  1200 3000 1200
Wire Wire Line
	4900 2400 4900 1800
Wire Wire Line
	4900 1800 5000 1800
Wire Wire Line
	6400 1600 6800 1600
Wire Wire Line
	6800 1600 6800 1700
Wire Wire Line
	1150 1700 1150 2400
Wire Wire Line
	600  2150 600  2400
Connection ~ 3800 1200
Wire Wire Line
	3800 1550 3800 950 
Wire Wire Line
	2900 1800 3300 1800
Wire Wire Line
	1250 1600 1150 1600
Connection ~ 1150 1600
Wire Wire Line
	3300 2400 3300 2300
Wire Wire Line
	3800 2400 3800 1950
Connection ~ 1150 1200
Connection ~ 900  1200
Wire Wire Line
	2900 1600 3000 1600
Wire Wire Line
	3000 1600 3000 1200
Wire Wire Line
	2900 1700 3150 1700
Wire Wire Line
	3150 1700 3150 1200
Wire Wire Line
	3300 1200 3300 1300
Connection ~ 3300 1200
Wire Wire Line
	6800 2100 6800 2400
Wire Wire Line
	6500 2400 6500 1800
Wire Wire Line
	6500 1800 6400 1800
Connection ~ 4250 1200
Wire Wire Line
	1150 1600 1150 1200
Wire Wire Line
	5000 1600 4800 1600
Wire Wire Line
	900  950  900  1200
Text HLabel 1750 1800 0    40   Input ~ 0
Wake
Text HLabel 4800 1600 0    40   Input ~ 0
Wake
$Comp
L MOSFET_P Q?
U 1 1 54E2206B
P 1150 2950
F 0 "Q?" H 1150 3140 60  0000 R CNN
F 1 "MOSFET_P" H 1150 2770 60  0000 R CNN
	1    1150 2950
	1    0    0    -1  
$EndComp
Text Notes 5650 2050 0    30   ~ 0
 NCP302LSN20T1\nThreshold detection at 2V
$Comp
L TST P1
U 1 1 54E1F74F
P 600 1000
F 0 "P1" H 600 1300 30  0000 C CNN
F 1 "Battery" H 600 1250 30  0000 C CNN
	1    600  1000
	1    0    0    -1  
$EndComp
$Comp
L TST P2
U 1 1 54E1F73D
P 4250 1000
F 0 "P2" H 4250 1300 30  0000 C CNN
F 1 "Power" H 4250 1250 30  0000 C CNN
	1    4250 1000
	1    0    0    -1  
$EndComp
$Comp
L TST P3
U 1 1 54E1F729
P 4900 1000
F 0 "P3" H 4900 1300 30  0000 C CNN
F 1 "Wake" H 4900 1250 30  0000 C CNN
	1    4900 1000
	1    0    0    -1  
$EndComp
$Comp
L CP1 C3
U 1 1 54E1F57F
P 6800 1900
F 0 "C3" H 6850 2000 40  0000 L CNN
F 1 "0.1 uF" H 6850 1800 40  0000 L CNN
	1    6800 1900
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR?
U 1 1 54E1F526
P 6800 2400
F 0 "#PWR?" H 6800 2400 30  0001 C CNN
F 1 "GND" H 6800 2330 30  0001 C CNN
	1    6800 2400
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR?
U 1 1 54E1F521
P 6500 2400
F 0 "#PWR?" H 6500 2400 30  0001 C CNN
F 1 "GND" H 6500 2330 30  0001 C CNN
	1    6500 2400
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR?
U 1 1 54E1F508
P 4900 2400
F 0 "#PWR?" H 4900 2400 30  0001 C CNN
F 1 "GND" H 4900 2330 30  0001 C CNN
	1    4900 2400
	1    0    0    -1  
$EndComp
$Comp
L NCP302 U2
U 1 1 54E1F4D1
P 5350 1700
F 0 "U2" H 5350 1950 39  0000 C CNN
F 1 "NCP302" H 5900 1450 39  0000 C CNN
	1    5350 1700
	1    0    0    -1  
$EndComp
$Comp
L MCP1640 U1
U 1 1 54DDB2F2
P 2350 1700
F 0 "U1" H 2200 1950 39  0000 C CNN
F 1 "MCP1640" H 2400 1450 39  0000 C CNN
	1    2350 1700
	1    0    0    -1  
$EndComp
Text Notes 750  750  0    31   ~ 0
Alkaline Battery\n0.9V to 1.7V\n
Text Notes 3650 800  0    31   ~ 0
3.6V @ 100mA
$Comp
L VCC #PWR?
U 1 1 54DDB101
P 3800 950
F 0 "#PWR?" H 3800 1050 30  0001 C CNN
F 1 "VCC" H 3800 1050 30  0000 C CNN
	1    3800 950 
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR?
U 1 1 54DDB059
P 3800 2400
F 0 "#PWR?" H 3800 2400 30  0001 C CNN
F 1 "GND" H 3800 2330 30  0001 C CNN
	1    3800 2400
	1    0    0    -1  
$EndComp
$Comp
L C C2
U 1 1 54DDB04B
P 3800 1750
F 0 "C2" H 3850 1850 50  0000 L CNN
F 1 "10uF" H 3850 1650 50  0000 L CNN
	1    3800 1750
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR?
U 1 1 54DDB023
P 3300 2400
F 0 "#PWR?" H 3300 2400 30  0001 C CNN
F 1 "GND" H 3300 2330 30  0001 C CNN
	1    3300 2400
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR?
U 1 1 54DDAFB7
P 600 2400
F 0 "#PWR?" H 600 2400 30  0001 C CNN
F 1 "GND" H 600 2330 30  0001 C CNN
	1    600  2400
	1    0    0    -1  
$EndComp
$Comp
L C C1
U 1 1 54DDABB5
P 600 1950
F 0 "C1" H 650 2050 40  0000 L CNN
F 1 "C4.7uF" H 650 1850 40  0000 L CNN
	1    600  1950
	1    0    0    -1  
$EndComp
$Comp
L R R2
U 1 1 54DDAB61
P 3300 2050
F 0 "R2" V 3380 2050 40  0000 C CNN
F 1 "510K" V 3300 2050 40  0000 C CNN
	1    3300 2050
	1    0    0    -1  
$EndComp
$Comp
L R R1
U 1 1 54DDAB5A
P 3300 1550
F 0 "R1" V 3380 1550 40  0000 C CNN
F 1 "1M" V 3300 1550 40  0000 C CNN
	1    3300 1550
	1    0    0    -1  
$EndComp
$Comp
L INDUCTOR L1
U 1 1 54DDAAAE
P 1550 1600
F 0 "L1" V 1500 1600 40  0000 C CNN
F 1 "4.7uH" V 1650 1600 40  0000 C CNN
	1    1550 1600
	0    -1   -1   0   
$EndComp
$Comp
L GND #PWR?
U 1 1 54DDA9D6
P 1150 2400
F 0 "#PWR?" H 1150 2400 30  0001 C CNN
F 1 "GND" H 1150 2330 30  0001 C CNN
	1    1150 2400
	1    0    0    -1  
$EndComp
$Comp
L +BATT #PWR?
U 1 1 54DDA9C2
P 900 950
F 0 "#PWR?" H 900 900 20  0001 C CNN
F 1 "+BATT" H 900 1050 30  0000 C CNN
	1    900  950 
	1    0    0    -1  
$EndComp
$EndSCHEMATC
