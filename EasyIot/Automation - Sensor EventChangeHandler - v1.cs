public void Setup()
{
  
  	String strEmailFrom = "hjfabius@gmail.com";
    String strEmailTo = "fabio.cristini@gmail.com";
	String strUsername = "hjfabius@gmail.com";
	String strPassword = "fabius_00";
  
    Console.WriteLine("SetupSmtp - Configuring Email ...");
    EmailHelper.SetupSmtp(strUsername, strPassword, "smtp.gmail.com", 587, true);
    Console.WriteLine("SetupSmtp - Done.");
  
   
    EventHelper.ModuleChangedHandler((o, m, p) =>
    {

      ModuleParameter 	alarm = ModuleHelper.GetProperty(Domains.VIRTUAL, "N1S0", "Sensor.DigitalValue");
      ModuleParameter 	alarmLightOn = ModuleHelper.GetProperty(Domains.VIRTUAL, "N2S0", "Sensor.DigitalValue");
      String 			strSubject = "";
      
      if (
        	(m.Domain == Domains.VIRTUAL) && 
        	(m.Address == "N1S0") && 
        	(p.Property == "Sensor.DigitalValue") 
      	  )
      {
          strSubject =  "EasyIoT - Action 01 - " + DateTime.Now + " - Alarm " + (p.Value == "1"?"Activated":"Deactivated");
      }
	  else if (
        	(m.Domain == Domains.MYSENSORS) && 
        	((m.Address == "N3S2") || (m.Address == "N4S2") || (m.Address == "N5S2") )&& 
        	(p.Property == "Sensor.Motion") && 
        	(p.Value == "1") &&
            (alarm.Value == "1")
      	  )
      {
          strSubject =  "Action 02 - " + DateTime.Now + " - PIR Motion Detected";
      }
      /*else
      {
          Console.WriteLine("Address   : " + m.Address + "\n" +
                            "Domain    : " + m.Domain + "\n" +
                            "Program ID: "+ Program.ProgramId.ToString() + "\n" +
                            "Property  : "+ p.Property + "\n" +
                            "Value     : " + p.Value);
      
      }*/
      
      if (strSubject != "")
      {
			if(alarmLightOn.Value == "1")
			{
				Console.WriteLine("Action 3 - " + DateTime.Now + " - Turn light ON");
				DriverHelper.ProcessCommad(Domains.MYSENSORS, "N3S3", "ControlOn", "");
			}
				
	  
			strSubject = "DOMUS SILICIEA - EasyIoT - " + strSubject;

			String strMessage =  strSubject + "\n\n" +
						"Time        : " + DateTime.Now + "\n" +
						"Address     : " + m.Address + "\n" +
						"Description : " + m.Description + "\n" +
						"Domain      : " + m.Domain + "\n" +
						"Program ID  : "+ Program.ProgramId.ToString() + "\n" +
						"Property    : "+ p.Property + "\n" +
						"Value       : " + p.Value;

			Console.WriteLine("\n\n"+strMessage);

			EmailHelper.SendEmail(strEmailFrom, strEmailTo, strSubject, strMessage);

			if(alarmLightOn.Value=="1")
			{
				System.Threading.Thread.Sleep(10000);
				Console.WriteLine("Action 3 - " + DateTime.Now + " - Turn light OFF");
				DriverHelper.ProcessCommad(Domains.MYSENSORS, "N3S3", "ControlOff", "");
			}
			
			
		}

      return true;
    });
}


public void Run()
{
}