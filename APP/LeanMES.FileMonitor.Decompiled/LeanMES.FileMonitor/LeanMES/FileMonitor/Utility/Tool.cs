using System;
using System.Collections;
using System.Configuration;
using System.Globalization;
using System.Net;
using System.Net.NetworkInformation;
using System.Net.Sockets;
using System.Security.Cryptography;
using System.Text;
using System.Xml;
using LeanMES.FileMonitor.Properties;

namespace LeanMES.FileMonitor.Utility;

public class Tool
{
	public static string MD5Encode(string strText)
	{
		MD5 mD = new MD5CryptoServiceProvider();
		byte[] array = mD.ComputeHash(Encoding.UTF8.GetBytes(strText));
		return BitConverter.ToString(array).Replace("-", "").ToLower();
	}

	public static byte[] GetByteData(string s)
	{
		byte[] array = new byte[s.Length / 2];
		for (int i = 0; i < s.Length / 2; i++)
		{
			if (s[i * 2] <= '9')
			{
				array[i] = (byte)((s[i * 2] - 48) * 16);
			}
			else if (s[i * 2] <= 'f' && s[i * 2] >= 'a')
			{
				array[i] = (byte)((s[i * 2] - 97 + 10) * 16);
			}
			else if (s[i * 2] <= 'F' && s[i * 2] >= 'A')
			{
				array[i] = (byte)((s[i * 2] - 65 + 10) * 16);
			}
			if (s[i * 2 + 1] <= '9')
			{
				array[i] += (byte)(s[i * 2 + 1] - 48);
			}
			else if (s[i * 2 + 1] <= 'f' && s[i * 2 + 1] >= 'a')
			{
				array[i] += (byte)(s[i * 2 + 1] - 97 + 10);
			}
			else if (s[i * 2 + 1] <= 'F' && s[i * 2 + 1] >= 'A')
			{
				array[i] += (byte)(s[i * 2 + 1] - 65 + 10);
			}
		}
		return array;
	}

	public static string GetHexString(string str)
	{
		int length = str.Length;
		string text = "";
		int num = 0;
		for (num = 0; num < length / 3; num++)
		{
			if (ishex(str[3 * num]) && ishex(str[3 * num + 1]) && str[3 * num + 2] == ' ')
			{
				text = text + str[3 * num] + str[3 * num + 1];
			}
			else if (ishex(str[3 * num]) && ishex(str[3 * num + 1]) && 3 * num + 2 == length)
			{
				text = text + str[3 * num] + str[3 * num + 1];
			}
		}
		if (length - num * 3 == 2 && ishex(str[length - 1]) && ishex(str[length - 2]))
		{
			text = text + str[length - 2] + str[length - 1];
		}
		return text;
	}

	public bool ishexstring(string strl)
	{
		string text = "  ";
		string text2 = strl.Trim(text.ToCharArray());
		int length = text2.Length;
		bool result = false;
		for (int i = 0; i < length / 3; i++)
		{
			result = (ishex(text2[3 * i]) && ishex(text2[3 * i + 1]) && text2[3 * i + 2] == ' ') || ((ishex(text2[3 * i]) && ishex(text2[3 * i + 1]) && 3 * i + 2 == length) ? true : false);
		}
		return result;
	}

	public static bool ishex(char x)
	{
		bool result = false;
		if (x <= '9' && x >= '0')
		{
			result = true;
		}
		else if (x <= 'F' && x >= 'A')
		{
			result = true;
		}
		else if (x <= 'f' && x >= 'a')
		{
			result = true;
		}
		return result;
	}

	public static string DecToBin(string x)
	{
		string text = null;
		int num = Convert.ToInt32(x);
		int num2 = 0;
		long num3 = 0L;
		while (num > 0)
		{
			long num4 = num % 2;
			num /= 2;
			num3 += num4 * Pow(10L, num2);
			num2++;
		}
		text = Convert.ToString(num3);
		if (text == "0")
		{
			text = "00";
		}
		return text;
	}

	public static string HexToAscii(string hexString)
	{
		StringBuilder stringBuilder = new StringBuilder();
		for (int i = 0; i <= hexString.Length - 2; i += 2)
		{
			stringBuilder.Append(Convert.ToString(Convert.ToChar(int.Parse(hexString.Substring(i, 2), NumberStyles.HexNumber))));
		}
		return stringBuilder.ToString();
	}

	public static string DecToOtc(string x)
	{
		string text = null;
		int num = Convert.ToInt32(x);
		int num2 = 0;
		long num3 = 0L;
		while (num > 0)
		{
			long num4 = num % 8;
			num /= 8;
			num3 += num4 * Pow(10L, num2);
			num2++;
		}
		return Convert.ToString(num3);
	}

	public static string DecToHex(string x)
	{
		if (string.IsNullOrEmpty(x))
		{
			return "0";
		}
		string text = null;
		int num = Convert.ToInt32(x);
		Stack stack = new Stack();
		int num2 = 0;
		while (num > 0)
		{
			stack.Push(Convert.ToString(num % 16));
			num /= 16;
			num2++;
		}
		while (stack.Count != 0)
		{
			text += ToHex(Convert.ToString(stack.Pop()));
		}
		if (string.IsNullOrEmpty(text))
		{
			text = "0";
		}
		return text;
	}

	public static string BinToDec(string x)
	{
		string text = null;
		if (string.IsNullOrEmpty(x))
		{
			x = "00";
		}
		long num = Convert.ToInt64(x);
		int num2 = 0;
		long num3 = 0L;
		while (num > 0)
		{
			long num4 = num % 10;
			num /= 10;
			num3 += num4 * Pow(2L, num2);
			num2++;
		}
		return Convert.ToString(num3);
	}

	public static string BinToDec(string x, short iLength)
	{
		StringBuilder stringBuilder = new StringBuilder();
		int num = 0;
		num = x.Length / iLength;
		if (x.Length % iLength > 0)
		{
			num++;
		}
		int num2 = 0;
		for (int i = 0; i < num; i++)
		{
			num2 = (((i + 1) * iLength <= x.Length) ? Convert.ToInt32(x.Substring(i * iLength, iLength)) : Convert.ToInt32(x.Substring(i * iLength, x.Length - iLength)));
			int num3 = 0;
			long num4 = 0L;
			while (num2 > 0)
			{
				long num5 = num2 % 10;
				num2 /= 10;
				num4 += num5 * Pow(2L, num3);
				num3++;
			}
			stringBuilder.AppendFormat("{0:D2}", num4);
		}
		return stringBuilder.ToString();
	}

	public static string BinToHex(string x, short iLength)
	{
		StringBuilder stringBuilder = new StringBuilder();
		int num = 0;
		num = x.Length / iLength;
		if (x.Length % iLength > 0)
		{
			num++;
		}
		int num2 = 0;
		for (int i = 0; i < num; i++)
		{
			num2 = (((i + 1) * iLength <= x.Length) ? Convert.ToInt32(x.Substring(i * iLength, iLength)) : Convert.ToInt32(x.Substring(i * iLength, x.Length - iLength)));
			int num3 = 0;
			long num4 = 0L;
			while (num2 > 0)
			{
				long num5 = num2 % 10;
				num2 /= 10;
				num4 += num5 * Pow(2L, num3);
				num3++;
			}
			stringBuilder.Append(DecToHex(num4.ToString()));
		}
		return stringBuilder.ToString();
	}

	public static string OctToDec(string x)
	{
		string text = null;
		int num = Convert.ToInt32(x);
		int num2 = 0;
		long num3 = 0L;
		while (num > 0)
		{
			long num4 = num % 10;
			num /= 10;
			num3 += num4 * Pow(8L, num2);
			num2++;
		}
		return Convert.ToString(num3);
	}

	public static string HexToDec(string x)
	{
		if (string.IsNullOrEmpty(x))
		{
			return "0";
		}
		string text = null;
		Stack stack = new Stack();
		int i = 0;
		int num = 0;
		int length = x.Length;
		long num2 = 0L;
		for (; i < length; i++)
		{
			stack.Push(ToDec(Convert.ToString(x[i])));
		}
		while (stack.Count != 0)
		{
			num2 += Convert.ToInt64(stack.Pop()) * Pow(16L, num);
			num++;
		}
		return Convert.ToString(num2);
	}

	private static long Pow(long x, long y)
	{
		int i = 1;
		long num = x;
		if (y == 0)
		{
			return 1L;
		}
		for (; i < y; i++)
		{
			x *= num;
		}
		return x;
	}

	private static string ToDec(string x)
	{
		return x switch
		{
			"A" => "10", 
			"B" => "11", 
			"C" => "12", 
			"D" => "13", 
			"E" => "14", 
			"F" => "15", 
			_ => x, 
		};
	}

	private static string ToHex(string x)
	{
		return x switch
		{
			"10" => "A", 
			"11" => "B", 
			"12" => "C", 
			"13" => "D", 
			"14" => "E", 
			"15" => "F", 
			_ => x, 
		};
	}

	public static string ToHexString(byte[] bytes)
	{
		string result = string.Empty;
		if (bytes != null)
		{
			StringBuilder stringBuilder = new StringBuilder();
			for (int i = 0; i < bytes.Length; i++)
			{
				stringBuilder.Append(bytes[i].ToString("X2"));
			}
			result = stringBuilder.ToString();
		}
		return result;
	}

	public static string GetAppSeting(string key)
	{
		try
		{
			return ConfigurationSettings.AppSettings[key];
		}
		catch (Exception ex)
		{
			Log.info(key + "没有配置:" + ex.Message);
			return string.Empty;
		}
	}

	public static bool PingIp(string strIP)
	{
		bool result = false;
		try
		{
			Ping ping = new Ping();
			PingReply pingReply = ping.Send(strIP, 1000);
			if (pingReply.Status == IPStatus.Success)
			{
				result = true;
			}
		}
		catch (Exception)
		{
			result = false;
		}
		return result;
	}

	public static bool CheckConnect(string ipString, int port)
	{
		bool flag = false;
		TcpClient tcpClient = new TcpClient
		{
			SendTimeout = 1000
		};
		try
		{
			IPAddress address = IPAddress.Parse(ipString);
			IAsyncResult asyncResult = tcpClient.BeginConnect(address, port, null, null);
			bool flag2 = asyncResult.AsyncWaitHandle.WaitOne(2000);
			flag = tcpClient.Connected;
		}
		catch (Exception)
		{
			return false;
		}
		tcpClient.Close();
		return flag;
	}

	public static bool IsValidUrl(string url)
	{
		try
		{
			HttpWebRequest httpWebRequest = (HttpWebRequest)WebRequest.Create(url);
			httpWebRequest.Method = "HEAD";
			using HttpWebResponse httpWebResponse = (HttpWebResponse)httpWebRequest.GetResponse();
			return httpWebResponse.StatusCode == HttpStatusCode.OK;
		}
		catch (Exception)
		{
			return false;
		}
	}

	public static void SaveConfig(string AppKey, string AppValue)
	{
		try
		{
			XmlDocument xmlDocument = new XmlDocument();
			string baseDirectory = AppDomain.CurrentDomain.BaseDirectory;
			string filename = baseDirectory + "EquimentCollection.exe.Config";
			xmlDocument.Load(filename);
			Configuration configuration = ConfigurationManager.OpenExeConfiguration(ConfigurationUserLevel.None);
			XmlNode xmlNode = xmlDocument.SelectSingleNode("//appSettings");
			XmlElement xmlElement = (XmlElement)xmlNode.SelectSingleNode("//add[@key='" + AppKey + "']");
			if (xmlElement != null)
			{
				xmlElement.SetAttribute("value", AppValue);
				configuration.AppSettings.Settings[AppKey].Value = AppValue;
			}
			else
			{
				XmlElement xmlElement2 = xmlDocument.CreateElement("add");
				xmlElement2.SetAttribute("key", AppKey);
				xmlElement2.SetAttribute("value", AppValue);
				xmlNode.AppendChild(xmlElement2);
				configuration.AppSettings.Settings.Add(AppKey, AppValue);
			}
			configuration.Save();
			ConfigurationManager.RefreshSection("appSettings");
			xmlDocument.Save(filename);
			Settings.Default.Reload();
		}
		catch (Exception ex)
		{
			Log.info("配置写入：" + ex.Message);
			string message = ex.Message;
		}
	}

	public static void SetAppSeting(string key, string value)
	{
		try
		{
			Configuration configuration = ConfigurationManager.OpenExeConfiguration(ConfigurationUserLevel.None);
			AppSettingsSection appSettings = configuration.AppSettings;
			appSettings.Settings[key].Value = value;
			configuration.Save(ConfigurationSaveMode.Modified);
			ConfigurationManager.RefreshSection("appSettings");
		}
		catch (Exception ex)
		{
			Log.info(key + "没有配置:" + ex.Message);
		}
	}

	public static string GetInternalIp()
	{
		NetworkInterface[] allNetworkInterfaces = NetworkInterface.GetAllNetworkInterfaces();
		NetworkInterface[] array = allNetworkInterfaces;
		foreach (NetworkInterface networkInterface in array)
		{
			foreach (UnicastIPAddressInformation unicastAddress in networkInterface.GetIPProperties().UnicastAddresses)
			{
				if (unicastAddress.Address.AddressFamily == AddressFamily.InterNetwork)
				{
					return unicastAddress.Address.ToString();
				}
			}
		}
		return "";
	}

	public static string GetMacAddress()
	{
		string text = "";
		NetworkInterface[] allNetworkInterfaces = NetworkInterface.GetAllNetworkInterfaces();
		NetworkInterface[] array = allNetworkInterfaces;
		foreach (NetworkInterface networkInterface in array)
		{
			if (networkInterface.Description == "en0")
			{
				text = networkInterface.GetPhysicalAddress().ToString();
				break;
			}
			text = networkInterface.GetPhysicalAddress().ToString();
			if (text != "")
			{
				break;
			}
		}
		string text2 = "";
		for (int j = 0; j < text.Length; j++)
		{
			if (j % 2 == 0)
			{
				text2 = ((j != 10) ? (text2 + text.Substring(j, 2) + "-") : (text2 + text.Substring(j, 2)));
			}
		}
		return text2;
	}
}
