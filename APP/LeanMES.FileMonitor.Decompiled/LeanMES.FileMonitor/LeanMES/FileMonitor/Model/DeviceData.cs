namespace LeanMES.FileMonitor.Model;

public class DeviceData
{
	public string DevId { get; set; } = "9";

	public string Topic { get; set; } = "all";

	public string SendTime { get; set; } = "2025-07-29 14:49:26";

	public long SendStamp { get; set; } = 1753771766000L;

	public string Time { get; set; } = "2025-07-29 14:49:18";

	public long Timestamp { get; set; } = 1753771758000L;

	public DeviceDataDetail Data { get; set; }
}
