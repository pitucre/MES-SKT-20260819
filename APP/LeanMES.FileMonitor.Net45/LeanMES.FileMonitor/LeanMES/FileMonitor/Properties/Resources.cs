using System;
using System.CodeDom.Compiler;
using System.ComponentModel;
using System.Diagnostics;
using System.Drawing;
using System.Globalization;
using System.IO;
using System.Reflection;
using System.Resources;
using System.Runtime.CompilerServices;

namespace LeanMES.FileMonitor.Properties
{
[GeneratedCode("System.Resources.Tools.StronglyTypedResourceBuilder", "17.0.0.0")]
[DebuggerNonUserCode]
[CompilerGenerated]
internal class Resources
{
private const string ImagePrefix = "Resources.";

private static ResourceManager resourceMan;

private static CultureInfo resourceCulture;

[EditorBrowsable(EditorBrowsableState.Advanced)]
internal static ResourceManager ResourceManager
{
	get
	{
		if (resourceMan == null)
		{
			ResourceManager resourceManager = new ResourceManager("LeanMES.FileMonitor.Properties.Resources", typeof(Resources).Assembly);
			resourceMan = resourceManager;
		}
		return resourceMan;
	}
}

[EditorBrowsable(EditorBrowsableState.Advanced)]
internal static CultureInfo Culture
{
	get
	{
		return resourceCulture;
	}
	set
	{
		resourceCulture = value;
	}
}

internal static Bitmap down
{
	get
	{
		return LoadBitmap("down_2.png");
	}
}

internal static Bitmap skt_logo
{
	get
	{
		return LoadBitmap("skt_logo_1.png");
	}
}

internal static Bitmap pictureBox1_image
{
	get
	{
		return LoadBitmap("pictureBox1.Image_3.png");
	}
}

internal static Icon this_icon
{
	get
	{
		return LoadIcon("_this.Icon_1.ico");
	}
}

internal static Icon notifyIcon_icon
{
	get
	{
		return LoadIcon("notifyIcon.Icon_2.ico");
	}
}

private static Stream OpenImage(string fileName)
{
	Assembly asm = typeof(Resources).Assembly;
	Stream s = asm.GetManifestResourceStream(ImagePrefix + fileName);
	if (s != null)
	{
		return s;
	}
	string[] names = asm.GetManifestResourceNames();
	for (int i = 0; i < names.Length; i++)
	{
		if (names[i].EndsWith(fileName, StringComparison.OrdinalIgnoreCase))
		{
			return asm.GetManifestResourceStream(names[i]);
		}
	}
	throw new FileNotFoundException("Embedded resource not found: " + ImagePrefix + fileName);
}

private static byte[] ReadAll(Stream s)
{
	using (MemoryStream ms = new MemoryStream())
	{
		byte[] buffer = new byte[8192];
		int read;
		while ((read = s.Read(buffer, 0, buffer.Length)) > 0)
		{
			ms.Write(buffer, 0, read);
		}
		return ms.ToArray();
	}
}

private static Bitmap LoadBitmap(string fileName)
{
	using (Stream s = OpenImage(fileName))
	{
		byte[] data = ReadAll(s);
		using (MemoryStream ms = new MemoryStream(data))
		{
			return new Bitmap(ms);
		}
	}
}

private static Icon LoadIcon(string fileName)
{
	using (Stream s = OpenImage(fileName))
	{
		byte[] data = ReadAll(s);
		using (MemoryStream ms = new MemoryStream(data))
		{
			return new Icon(ms);
		}
	}
}

internal Resources()
{
}
}
}
