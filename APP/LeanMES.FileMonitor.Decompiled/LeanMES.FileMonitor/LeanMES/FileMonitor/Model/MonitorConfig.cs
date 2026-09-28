namespace LeanMES.FileMonitor.Model;

public class MonitorConfig
{
	public string MonitorDir { get; set; }

	public int StationId { get; set; }

	public string Station { get; set; }

	public int ResourceId { get; set; }

	public string Resource { get; set; }

	public string UserName { get; set; }

	public DeviceInterface DeviceInterface { get; set; }
}
