mysql -u openhab -h localhost openhab -p

Water: 4987.422 = 0

SELECT * FROM Items ORDER BY ItemName;

SELECT * FROM Item26;

+--------+----------------------------------------+
| ItemId | ItemName                               |
+--------+----------------------------------------+
|     28 | Arduino                                |
|     13 | ds_Contact_A_Playroom                  |
|     51 | ds_Contact_A_Playroom_Changed          |
|     11 | ds_Contact_FF_BedroomChildren          |
|     48 | ds_Contact_FF_BedroomChildren_Changed  |
|     12 | ds_Contact_FF_Kitchen                  |
|      9 | ds_Contact_FF_LivingRoom               |
|     29 | ds_Contact_FF_LivingRoom_Changed       |
|     14 | ds_Contact_GF_Bathroom                 |
|      1 | ds_Date                                |
|     43 | ds_Dimmer_FF_LivingRoom_Ceiling        |
|     53 | ds_Energy_ChartPeriod                  |
|     52 | ds_Gas_GF_Alarm                        |
|     40 | ds_Gas_GF_Bathroom                     |
|     21 | ds_Gas_GF_Bathroom_Changed             |
|     26 | ds_Gas_GF_Bathroom_Hour                |
|     18 | ds_Gas_GF_Bathroom_Minute              |
|     10 | ds_Gas_GF_Bathroom_Pulse               |
|     19 | ds_Humidity                            |
|     36 | ds_Humidity_A_Playroom                 |
|     37 | ds_Humidity_A_Playroom_Changed         |
|     49 | ds_Humidity_FF_Bedroom                 |
|     46 | ds_Humidity_FF_BedroomChildren         |
|     47 | ds_Humidity_FF_BedroomChildren_Changed |
|     50 | ds_Humidity_FF_Bedroom_Changed         |
|     20 | ds_Humidity_GF_Bathroom                |
|      6 | ds_KODI_Status                         |
|      7 | ds_KODI_Title                          |
|      8 | ds_KODI_Volume                         |
|     42 | ds_Light                               |
|     30 | ds_Motion                              |
|      2 | ds_Presences                           |
|      3 | ds_Presence_AG                         |
|      5 | ds_Presence_EA                         |
|      4 | ds_Presence_FC                         |
|     15 | ds_Sketch_GF_Bathroom                  |
|     25 | ds_Sunrise_Sunset                      |
|     38 | ds_Sunrise_Time                        |
|     39 | ds_Sunset_Time                         |
|     16 | ds_Temperature                         |
|     33 | ds_Temp_A_Playroom                     |
|     34 | ds_Temp_A_Playroom_Changed             |
|     35 | ds_Temp_ChartPeriod                    |
|     31 | ds_Temp_FF_Bedroom                     |
|     44 | ds_Temp_FF_BedroomChildren             |
|     45 | ds_Temp_FF_BedroomChildren_Changed     |
|     32 | ds_Temp_FF_Bedroom_Changed             |
|     17 | ds_Temp_GF_Bathroom                    |
|     41 | ds_Water_GF_Bathroom                   |
|     24 | ds_Water_GF_Bathroom_Changed           |
|     27 | ds_Water_GF_Bathroom_Hour              |
|     23 | ds_Water_GF_Bathroom_Minute            |
|     22 | ds_Water_GF_Bathroom_Pulse             |




CREATE OR REPLACE VIEW V_WATER AS 
	SELECT 	Sysdate() 		AS SYSDATE, 
			Item41.Time 	AS TIME, 
			Item41.Value 	AS WATER_41, 
			Item23.Value 	AS WATER_MINUTE_23  
	FROM 	Item41, 
			Item23 
	WHERE 	Item41.Time=Item23.Time 
   ORDER BY Item41.Time DESC LIMIT 0,20;

CREATE OR REPLACE VIEW V_GAS AS 
	SELECT 	Sysdate() 		AS SYSDATE, 
			Item40.Time 	AS TIME, 
			Item40.Value 	AS GAS_40, 
			Item18.Value 	AS GAS_MINUTE_18  
	 FROM 	Item40, 
			Item18 
	WHERE 	Item40.Time=Item18.Time 
  ORDER BY 	Item40.Time DESC LIMIT 0,20;
