using System.Collections;
using System.Xml;

namespace LeanMES.FileMonitor.Utility
{
public class XMLHelper
{
public static XmlDocument ImportXMLToReader(string filePath)
{
	ArrayList arrayList = new ArrayList();
	XmlDocument xmlDocument = new XmlDocument();
	XmlReaderSettings xmlReaderSettings = new XmlReaderSettings();
	xmlReaderSettings.IgnoreComments = true;
	using (XmlReader xmlReader = XmlReader.Create(filePath, xmlReaderSettings))
	{
		xmlDocument.Load(xmlReader);
		xmlReader.Close();
	}
	return xmlDocument;
}

public static ArrayList ImportXML(string filePath)
{
	ArrayList Data = new ArrayList();
	XmlDocument xmlDocument = new XmlDocument();
	XmlReaderSettings xmlReaderSettings = new XmlReaderSettings();
	xmlReaderSettings.IgnoreComments = true;
	using (XmlReader xmlReader = XmlReader.Create(filePath, xmlReaderSettings))
	{
		xmlDocument.Load(xmlReader);
		xmlReader.Close();
	}
	GetNodesAttribute("", xmlDocument.ChildNodes, ref Data);
	return Data;
}

public static void GetNodesAttribute(string NodePath, XmlNodeList nodes, ref ArrayList Data)
{
	foreach (XmlNode node in nodes)
	{
		string[] array = new string[((node.Attributes != null) ? node.Attributes.Count : 0) + 1];
		array[0] = ((NodePath == "") ? "" : "/") + node.Name;
		if (node.Attributes != null)
		{
			int num = 1;
			foreach (XmlAttribute attribute in node.Attributes)
			{
				array[num] = ((NodePath == "") ? "" : "/") + node.Name + "@" + attribute.Name + "," + attribute.Name;
				num++;
			}
		}
		Data.Add(array);
		GetNodesAttribute("", node.ChildNodes, ref Data);
	}
}
}
}
