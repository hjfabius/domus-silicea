public void Setup()
{
  
  	String strEmailFrom = "xxx@gmail.com";
    String strEmailTo = "xxx@gmail.com";
	String strUsername = "xxx@gmail.com";
	String strPassword = "xxx";
	String strCameraUrl = "http://192.168.0.14/cam.jpg";
	String strFileName = "cam.jpg";
  
	Console.WriteLine("Setup - Sensor Event Change Handler v2");
  

    //Console.WriteLine("SetupSmtp - Configuring Email ...");
    //EmailHelper.SetupSmtp(strUsername, strPassword, "smtp.gmail.com", 587, true);
    //Console.WriteLine("SetupSmtp - Done.");
  
   
    EventHelper.ModuleChangedHandler((o, m, p) =>
    {

      ModuleParameter 	alarm = ModuleHelper.GetProperty(Domains.VIRTUAL, "N1S0", "Sensor.DigitalValue");
      ModuleParameter 	alarmLightOn = ModuleHelper.GetProperty(Domains.VIRTUAL, "N2S0", "Sensor.DigitalValue");
      String 			strSubject = "";
	  Boolean			blnTurnedLightOn = false;
      
      if (
        	(m.Domain == Domains.VIRTUAL) && 
        	(m.Address == "N1S0") && 
        	(p.Property == "Sensor.DigitalValue") 
      	  )
      {
          strSubject =  "Action 01 - " + DateTime.Now + " - Alarm " + (p.Value == "1"?"Activated":"Deactivated");
      }
	  else if (
        	(m.Domain == Domains.MYSENSORS) && 
        	(
				(m.Address == "N3S2") || 
				(m.Address == "N4S2") || 
				(m.Address == "N5S2") || 
				(m.Address == "N86S2") 
			)&& 
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
				blnTurnedLightOn = true;
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

			
			
			//EmailHelper.SendEmail(strEmailFrom, strEmailTo, strSubject, strMessage);
			
			try
			{
				Console.WriteLine("Email Sender - Standard");  
			  
				System.Net.Mail.SmtpClient  	client 		= new System.Net.Mail.SmtpClient("smtp.gmail.com", 587);
				client.Credentials = new System.Net.NetworkCredential(strUsername, strPassword);
				client.EnableSsl = true;
				client.DeliveryMethod = System.Net.Mail.SmtpDeliveryMethod.Network;
			  
			  
				System.Net.Mail.MailAddress 	fromMail 	= new System.Net.Mail.MailAddress(strEmailFrom, "EasyIoT server",  System.Text.Encoding.UTF8);
				System.Net.Mail.MailAddress 	toMail 		= new System.Net.Mail.MailAddress(strEmailTo);
				System.Net.Mail.MailMessage 	message 	= new System.Net.Mail.MailMessage(fromMail, toMail);
				message.Body = strMessage;
				message.BodyEncoding =  System.Text.Encoding.UTF8;
				message.Subject = strSubject;
				message.SubjectEncoding = System.Text.Encoding.UTF8;  

				Console.WriteLine("Preparing attachment from url: ");  
				Console.WriteLine(strCameraUrl);  
				System.Net.WebRequest objWebRequest = System.Net.WebRequest.Create(strCameraUrl);
				System.Net.WebResponse objWebResponse = objWebRequest.GetResponse();		
				System.Net.Mail.Attachment objAttachment = new System.Net.Mail.Attachment(objWebResponse.GetResponseStream(), strFileName);
				
				// Add time stamp information for the file.
				System.Net.Mime.ContentDisposition objContentDisposition = objAttachment.ContentDisposition;
				// Add the file attachment to this e-mail message.
				message.Attachments.Add(objAttachment);  


				Console.WriteLine("Sending Message.");  
				client.Send(message);
				Console.WriteLine("Message Sent.");  
			}
			catch (Exception e)
			{
				Console.WriteLine("An Exception occurred: '{0}'", e);
			}			
			
			

			if(blnTurnedLightOn == true)
			{
				System.Threading.Thread.Sleep(10000);
				Console.WriteLine("Action 3 - " + DateTime.Now + " - Turn light OFF");
				DriverHelper.ProcessCommad(Domains.MYSENSORS, "N3S3", "ControlOff", "");
			}
			
			
		}

      return true;
    });
	
	Console.WriteLine("Setup - Sensor Event Change Handler v2 - Done.");
}


public void Run()
{
}