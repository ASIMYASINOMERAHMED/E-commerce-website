using Microsoft.Win32;
using OnlineStoreBusiness;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
//using System.Windows.Forms;
//using Microsoft.AspNet.SignalR;
using System.Security.Cryptography;
using Microsoft.AspNetCore.SignalR;

namespace Online_Store_Project
{
	public class clsGlobal
	{
		public static clsCustomer CurrentUser = null;
		public static clsShippers CurrentShipper = null;
		public static string pattern = @"^\w+(\s\w+)*$";



	public class MessageHub : Hub
	{
		public async Task SendMessage(string user, string message)
		{
			await Clients.All.SendAsync("ReceiveMessage", user, message);
		}
	}

	//public class ChatHub : Hub
	//{
	//	public async Task SendMessage(string senderName, string senderImageURL, DateTime dateTime, string message)
	//	{
	//		// Broadcast the message to all connected clients
	//		await Clients.All.SendAsync("ReceiveMessage", senderName, senderImageURL, dateTime, message);
	//	}
	//}
	public static bool RememberCredentialsInRegistry(string Credential1, string Credential2)
		{
			string KeyPath = @"HKEY_CURRENT_USER\SOFTWARE\Online_Store_App";
			string valueName = "Online_Store_Credentials";
			string valueData = Credential1 + "#//#" + Credential2;
			try
			{
				Registry.SetValue(KeyPath, valueName, valueData, RegistryValueKind.String);
				return true;

			}
			catch (Exception ex)
			{
				Console.WriteLine("Error:" + ex.Message);
				return false;
			}

		}
		public static bool GetStoredCredentialFromRegistery(ref string Credential1, ref string Credential2)
		{
			string KeyPath = @"HKEY_CURRENT_USER\SOFTWARE\Online_Store_App";
			string valueName = "Online_Store_Credentials";
			try
			{
				string line = Registry.GetValue(KeyPath, valueName, null) as string;
				if (line != "#//#")
				{
					string[] result = line.Split(new string[] { "#//#" }, StringSplitOptions.None);
					Credential1 = result[0];
					Credential2 = result[1];
					return true;
				}
				else
				{
					return false;
				}
			}
			catch (Exception ex)
			{
				return false;
			}

		}
		public static bool IsValidEmail(string email)
		{
			var trimmedEmail = email.Trim();

			// Check if the email address ends with a dot (which is invalid)
			if (trimmedEmail.EndsWith("."))
				return false;

			// Use MailAddress to validate the email format
			try
			{
				var addr = new System.Net.Mail.MailAddress(trimmedEmail);
				return addr.Address == trimmedEmail;
			}
			catch
			{
				return false;
			}
		}
		public static bool IsValidPassword(string input)
		{
			var hasNumber = new Regex(@"[0-9]+");
			var hasUpperChar = new Regex(@"[A-Z]+");
			var hasMinimum8Chars = new Regex(@".{8,}");

			bool isValid = hasNumber.IsMatch(input) && hasUpperChar.IsMatch(input) && hasMinimum8Chars.IsMatch(input);
			return isValid;
		}
		public static string ComputeHash(string Password)
		{
			//SHA is Secutred Hash Algorithm.
			// Create an instance of the SHA-256 algorithm
			using (SHA256 sha256 = SHA256.Create())
			{
				// Compute the hash value from the UTF-8 encoded input string
				byte[] hashBytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(Password));


				// Convert the byte array to a lowercase hexadecimal string
				return BitConverter.ToString(hashBytes).Replace("-", "").ToLower();
			}
		}
	}
}
