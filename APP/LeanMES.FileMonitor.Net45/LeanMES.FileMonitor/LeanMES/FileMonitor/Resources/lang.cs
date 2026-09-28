using System.CodeDom.Compiler;
using System.ComponentModel;
using System.Diagnostics;
using System.Globalization;
using System.Resources;
using System.Runtime.CompilerServices;

namespace LeanMES.FileMonitor.Resources
{
[GeneratedCode("System.Resources.Tools.StronglyTypedResourceBuilder", "17.0.0.0")]
[DebuggerNonUserCode]
[CompilerGenerated]
internal class lang
{
private static ResourceManager resourceMan;

private static CultureInfo resourceCulture;

[EditorBrowsable(EditorBrowsableState.Advanced)]
internal static ResourceManager ResourceManager
{
	get
	{
		if (resourceMan == null)
		{
			ResourceManager resourceManager = new ResourceManager("LeanMES.FileMonitor.Resources.lang", typeof(lang).Assembly);
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

internal static string PleaseChoose => ResourceManager.GetString("PleaseChoose", resourceCulture);

internal lang()
{
}
}
}
