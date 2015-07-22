/*
  This code is running one time when program is enabled
*/
public void Setup()
{
	try
	{
		Console.WriteLine("Email Sender - Standard");  
	  
		System.Net.Mail.SmtpClient  	client 		= new System.Net.Mail.SmtpClient("smtp.gmail.com", 587);
		client.Credentials = new System.Net.NetworkCredential("hjfabius@gmail.com", "fabius_00");
		client.EnableSsl = true;
		client.DeliveryMethod = System.Net.Mail.SmtpDeliveryMethod.Network;
	  
	  
		System.Net.Mail.MailAddress 	fromMail 	= new System.Net.Mail.MailAddress("hjfabius@gmail.com", "hjfabius",  System.Text.Encoding.UTF8);
		System.Net.Mail.MailAddress 	toMail 		= new System.Net.Mail.MailAddress("fabio.cristini@gmail.com");
		System.Net.Mail.MailMessage 	message 	= new System.Net.Mail.MailMessage(fromMail, toMail);
		message.Body = "This is a test e-mail message sent by an application. ";
		message.BodyEncoding =  System.Text.Encoding.UTF8;
		message.Subject = "test message 2";
		message.SubjectEncoding = System.Text.Encoding.UTF8;  

		Console.WriteLine("Preparing Attachment");  
		string strFile = "http://192.168.0.14/cam.jpg";
		string strLocalFile = "/tmp/cam.jpg";
		
		using(System.Net.WebClient objWebClient = new System.Net.WebClient())
		{
			objWebClient.DownloadFile(strFile, strLocalFile);
		}
		
		System.Net.Mail.Attachment objAttachment = new System.Net.Mail.Attachment(strLocalFile, System.Net.Mime.MediaTypeNames.Image.Jpeg);
		// Add time stamp information for the file.
		System.Net.Mime.ContentDisposition objContentDisposition = objAttachment.ContentDisposition;
		objContentDisposition.CreationDate = System.IO.File.GetCreationTime(strFile);
		objContentDisposition.ModificationDate = System.IO.File.GetLastWriteTime(strFile);
		objContentDisposition.ReadDate = System.IO.File.GetLastAccessTime(strFile);
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
}

/*
  This code is running periodicaly when program is enabled. 
  Cron job detirmine running period.
*/
public void Run()
{
}
                