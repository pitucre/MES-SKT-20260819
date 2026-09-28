using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography.X509Certificates;
using System.Threading.Tasks;
using Opc.Ua;
using Opc.Ua.Client;
using OpcUaHelper;

namespace LeanMES.FileMonitor
{
public class OPCUAHelper
{
private OpcUaClient opcUaClient;

public bool ConnectStatus => opcUaClient.Connected;

public OPCUAHelper()
{
	opcUaClient = new OpcUaClient();
}

public async void OpenConnectOfAnonymous(string serverUrl)
{
	if (!string.IsNullOrEmpty(serverUrl))
	{
		try
		{
			opcUaClient.UserIdentity = new UserIdentity(new AnonymousIdentityToken());
			await opcUaClient.ConnectServer(serverUrl);
		}
		catch (Exception e)
		{
			ClientUtils.HandleException("连接失败！！！", e);
		}
	}
}

public async void OpenConnectOfAccount(string serverUrl, string userName, string userPwd)
{
	if (!string.IsNullOrEmpty(serverUrl) && !string.IsNullOrEmpty(userName) && !string.IsNullOrEmpty(userPwd))
	{
		try
		{
			opcUaClient.UserIdentity = new UserIdentity(userName, userPwd);
			await opcUaClient.ConnectServer(serverUrl);
		}
		catch (Exception e)
		{
			ClientUtils.HandleException("连接失败！！！", e);
		}
	}
}

public async void OpenConnectOfCertificate(string serverUrl, string certificatePath, string secreKey)
{
	if (!string.IsNullOrEmpty(serverUrl) && !string.IsNullOrEmpty(certificatePath) && !string.IsNullOrEmpty(secreKey))
	{
		try
		{
			X509Certificate2 certificate = new X509Certificate2(certificatePath, secreKey, X509KeyStorageFlags.MachineKeySet | X509KeyStorageFlags.Exportable);
			opcUaClient.UserIdentity = new UserIdentity(certificate);
			await opcUaClient.ConnectServer(serverUrl);
		}
		catch (Exception e)
		{
			ClientUtils.HandleException("连接失败！！！", e);
		}
	}
}

public void CloseConnect()
{
	if (opcUaClient != null)
	{
		try
		{
			opcUaClient.Disconnect();
		}
		catch (Exception e)
		{
			ClientUtils.HandleException("关闭连接失败！！！", e);
		}
	}
}

public T GetCurrentNodeValue<T>(string nodeId)
{
	T result = default(T);
	if (!string.IsNullOrEmpty(nodeId) && ConnectStatus)
	{
		try
		{
			result = opcUaClient.ReadNode<T>(nodeId);
			return result;
		}
		catch (Exception e)
		{
			ClientUtils.HandleException("读取失败！！！", e);
		}
	}
	return result;
}

public DataValue GetCurrentNodeValue(string nodeId)
{
	DataValue result = null;
	if (!string.IsNullOrEmpty(nodeId) && ConnectStatus)
	{
		try
		{
			result = opcUaClient.ReadNode(nodeId);
		}
		catch (Exception e)
		{
			ClientUtils.HandleException("读取失败！！！", e);
		}
	}
	return result;
}

public Dictionary<string, DataValue> GetBatchNodeDatasOfSync(List<NodeId> nodeIdList)
{
	Dictionary<string, DataValue> dictionary = new Dictionary<string, DataValue>();
	if (nodeIdList != null && nodeIdList.Count > 0 && ConnectStatus)
	{
		try
		{
			List<DataValue> list = opcUaClient.ReadNodes(nodeIdList.ToArray());
			int count = nodeIdList.Count;
			for (int i = 0; i < count; i++)
			{
				AddInfoToDic(dictionary, nodeIdList[i].ToString(), list[i]);
			}
		}
		catch (Exception e)
		{
			ClientUtils.HandleException("读取失败！！！", e);
		}
	}
	return dictionary;
}

public async Task<T> GetCurrentNodeValueOfAsync<T>(string nodeId)
{
	T value = default(T);
	if (!string.IsNullOrEmpty(nodeId) && ConnectStatus)
	{
		try
		{
			value = await opcUaClient.ReadNodeAsync<T>(nodeId);
		}
		catch (Exception ex)
		{
			Exception ex2 = ex;
			ClientUtils.HandleException("读取失败！！！", ex2);
		}
	}
	return value;
}

public async Task<Dictionary<string, DataValue>> GetBatchNodeDatasOfAsync(List<NodeId> nodeIdList)
{
	Dictionary<string, DataValue> dicNodeInfo = new Dictionary<string, DataValue>();
	if (nodeIdList != null && nodeIdList.Count > 0 && ConnectStatus)
	{
		try
		{
			List<DataValue> dataValues = await opcUaClient.ReadNodesAsync(nodeIdList.ToArray());
			int count = nodeIdList.Count;
			for (int i = 0; i < count; i++)
			{
				AddInfoToDic(dicNodeInfo, nodeIdList[i].ToString(), dataValues[i]);
			}
		}
		catch (Exception ex)
		{
			Exception ex2 = ex;
			ClientUtils.HandleException("读取失败！！！", ex2);
		}
	}
	return dicNodeInfo;
}

public ReferenceDescription[] GetAllRelationNodeOfNodeId(string nodeId)
{
	ReferenceDescription[] result = null;
	if (!string.IsNullOrEmpty(nodeId) && ConnectStatus)
	{
		try
		{
			result = opcUaClient.BrowseNodeReference(nodeId);
		}
		catch (Exception e)
		{
			string caption = "获取当前： " + nodeId + "  节点的相关节点失败！！！";
			ClientUtils.HandleException(caption, e);
		}
	}
	return result;
}

public OpcNodeAttribute[] GetCurrentNodeAttributes(string nodeId)
{
	OpcNodeAttribute[] result = null;
	if (!string.IsNullOrEmpty(nodeId) && ConnectStatus)
	{
		try
		{
			result = opcUaClient.ReadNoteAttributes(nodeId);
		}
		catch (Exception e)
		{
			string caption = "读取节点；" + nodeId + "  的所有属性失败！！！";
			ClientUtils.HandleException(caption, e);
		}
	}
	return result;
}

public bool WriteSingleNodeId<T>(string nodeId, T value)
{
	bool result = false;
	if (opcUaClient != null && ConnectStatus && !string.IsNullOrEmpty(nodeId))
	{
		try
		{
			result = opcUaClient.WriteNode(nodeId, value);
		}
		catch (Exception e)
		{
			string caption = "当前节点：" + nodeId + "  写入失败";
			ClientUtils.HandleException(caption, e);
		}
	}
	return result;
}

public bool BatchWriteNodeIds(string[] nodeIdArray, object[] nodeIdValueArray)
{
	bool result = false;
	if (nodeIdArray != null && nodeIdArray.Length != 0 && nodeIdValueArray != null && nodeIdValueArray.Length != 0)
	{
		try
		{
			result = opcUaClient.WriteNodes(nodeIdArray, nodeIdValueArray);
		}
		catch (Exception e)
		{
			ClientUtils.HandleException("批量写入节点失败！！！", e);
		}
	}
	return result;
}

public async Task<bool> WriteSingleNodeIdOfAsync<T>(string nodeId, T value)
{
	bool success = false;
	if (opcUaClient != null && ConnectStatus && !string.IsNullOrEmpty(nodeId))
	{
		try
		{
			success = await opcUaClient.WriteNodeAsync(nodeId, value);
		}
		catch (Exception ex)
		{
			Exception ex2 = ex;
			string str = "当前节点：" + nodeId + "  写入失败";
			ClientUtils.HandleException(str, ex2);
		}
	}
	return success;
}

public List<T> ReadSingleNodeIdHistoryDatas<T>(string nodeId, DateTime startTime, DateTime endTime)
{
	List<T> result = null;
	if (!string.IsNullOrEmpty(nodeId) && endTime > startTime)
	{
		try
		{
			result = opcUaClient.ReadHistoryRawDataValues<T>(nodeId, startTime, endTime).ToList();
		}
		catch (Exception e)
		{
			ClientUtils.HandleException("读取失败", e);
		}
	}
	return result;
}

public List<DataValue> ReadSingleNodeIdHistoryDatas(string nodeId, DateTime startTime, DateTime endTime)
{
	List<DataValue> result = null;
	if (!string.IsNullOrEmpty(nodeId) && endTime > startTime && ConnectStatus)
	{
		try
		{
			result = opcUaClient.ReadHistoryRawDataValues(nodeId, startTime, endTime).ToList();
		}
		catch (Exception e)
		{
			ClientUtils.HandleException("读取失败", e);
		}
	}
	return result;
}

public void SingleNodeIdDatasSubscription(string key, string nodeId, Action<string, MonitoredItem, MonitoredItemNotificationEventArgs> callback)
{
	if (ConnectStatus)
	{
		try
		{
			opcUaClient.AddSubscription(key, nodeId, callback);
		}
		catch (Exception e)
		{
			string caption = "订阅节点：" + nodeId + " 数据失败！！！";
			ClientUtils.HandleException(caption, e);
		}
	}
}

public bool CancelSingleNodeIdDatasSubscription(string key)
{
	bool result = false;
	if (!string.IsNullOrEmpty(key) && ConnectStatus)
	{
		try
		{
			opcUaClient.RemoveSubscription(key);
			result = true;
		}
		catch (Exception e)
		{
			string caption = "取消 " + key + " 的订阅失败";
			ClientUtils.HandleException(caption, e);
		}
	}
	return result;
}

public void BatchNodeIdDatasSubscription(string key, string[] nodeIds, Action<string, MonitoredItem, MonitoredItemNotificationEventArgs> callback)
{
	if (!string.IsNullOrEmpty(key) && nodeIds != null && nodeIds.Length != 0 && ConnectStatus)
	{
		try
		{
			opcUaClient.AddSubscription(key, nodeIds, callback);
		}
		catch (Exception e)
		{
			string caption = "批量订阅节点数据失败！！！";
			ClientUtils.HandleException(caption, e);
		}
	}
}

public bool CancelAllNodeIdDatasSubscription()
{
	bool result = false;
	if (ConnectStatus)
	{
		try
		{
			opcUaClient.RemoveAllSubscription();
			result = true;
		}
		catch (Exception e)
		{
			ClientUtils.HandleException("取消所有的节点数据订阅失败！！！", e);
		}
	}
	return result;
}

public bool CancelNodeIdDatasSubscription(string key)
{
	bool result = false;
	if (ConnectStatus)
	{
		try
		{
			opcUaClient.RemoveSubscription(key);
			result = true;
		}
		catch (Exception e)
		{
			ClientUtils.HandleException("取消节点数据订阅失败！！！", e);
		}
	}
	return result;
}

private void AddInfoToDic(Dictionary<string, DataValue> dic, string key, DataValue dataValue)
{
	if (dic != null)
	{
		if (!dic.ContainsKey(key))
		{
			dic.Add(key, dataValue);
		}
		else
		{
			dic[key] = dataValue;
		}
	}
}
}
}
