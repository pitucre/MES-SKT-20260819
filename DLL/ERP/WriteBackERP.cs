using Dapper;
using DapperExtensions;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Net;
using System.Reflection;
using System.Reflection.Emit;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Linq;
using static System.Runtime.CompilerServices.RuntimeHelpers;

//using System.Runtime.InteropServices;
//using UFIDA.U8.MomServiceCommon;
//using UFIDA.U8.U8MOMAPIFramework;
//using UFIDA.U8.U8APIFramework;
//using UFIDA.U8.U8APIFramework.Meta;
//using UFIDA.U8.U8APIFramework.Parameter;
//using MSXML2;
//using U8Login;

namespace SKT.LeanMES.ERP
{
    public class WriteBackERP
    {

        /// <summary>
        /// 回写ERP
        /// </summary>
        /// <param name="em"></param>
        /// <param name="dt"></param>
        /// <param name="billNo"></param>
        /// <param name="createBy"></param>
        /// <param name="dtEnterTime"></param>
        /// <param name="dtAfterExecProcTime"></param>
        /// <returns></returns>
        public static ERPReturnInfo SendPost(WriteBackEnum em, DataTable dt, string billNo, string createBy, DateTime dtEnterTime, DateTime dtAfterExecProcTime)
        {
            ERPResultEnum erpResultEnum = ERPResultEnum.NG;
            //string url = string.Empty;
            string statusCode = string.Empty;
            string mesMsg = string.Empty;//MES消息
            //StringBuilder postData = new StringBuilder();//传给ERP的数据（XML）
            string postDataActual = string.Empty;//传给ERP的数据（JSON）
            string postDataJson = string.Empty;//回写的数据(JSON格式)（此字段仅为更直观查看MES存储过程返回的数据，这些数据拼接成XML后(即WriteBackData字段的值)，传给ERP）
            //string receiveData = string.Empty;//接收到的ERP数据
            string erpMsg = string.Empty;//接收到的ERP数据
            //string md5 = string.Empty;//MD5
            ERPReturnInfo erpReturnInfo = new ERPReturnInfo();//ERP回传信息
            DateTime? dtAfterExecERPTime = null;    //调用ERP接口后时间
            try
            {
                if (dt == null || dt.Rows.Count <= 0)
                {
                    mesMsg = "回写ERP数据为空";
                    throw new Exception(mesMsg);
                }

                //回写配置信息
                var url = ConfigurationManager.AppSettings["ERPWriteUrl"];
                //var appid = ConfigurationManager.AppSettings["ERPWriteAppId"];
                //var secretkey = ConfigurationManager.AppSettings["ERPWriteSecretKey"];
                if (string.IsNullOrEmpty(url))// || string.IsNullOrEmpty(appid) || string.IsNullOrEmpty(secretkey))
                {
                    mesMsg = "未获取到回写配置URL信息，请检查配置文件";
                    throw new Exception(mesMsg);
                }

                postDataJson = JsonConvert.SerializeObject(dt);

                //获取Token
                //string token = GetToken(url, appid, secretkey);

                //获取实际回写数据
                erpMsg = WriteERP(em, dt, url, /*token,*/ out postDataActual);

                dtAfterExecERPTime = DateTime.Now; //调用ERP接口后时间

                erpReturnInfo = JsonConvert.DeserializeObject<ERPReturnInfo>(erpMsg);
                if (erpReturnInfo != null && erpReturnInfo.Result)
                {
                    //调用ERP成功
                    erpResultEnum = ERPResultEnum.OK;
                    var resdata = erpReturnInfo.resdata?.ToString();
                    if (!string.IsNullOrWhiteSpace(resdata))
                    {
                        //反序列化 resdata 字段
                        try
                        {
                            var erpReturnResDataInfo = JsonConvert.DeserializeObject<ERPReturnResDataInfo>(resdata);
                            erpReturnInfo.ERPNo = erpReturnResDataInfo.DocNo;
                        }
                        catch (Exception ex)
                        {
                            erpReturnInfo.ERPNo = string.Empty;
                            mesMsg = $"{em} 回写ERP成功，但解析resdata时失败：{ex.Message}；resdata：{erpReturnInfo.resdata}";
                        }
                    }
                    else
                    {
                        erpReturnInfo.ERPNo = string.Empty;
                    }
                    return erpReturnInfo;
                }
                else
                {
                    //调用ERP失败
                    erpResultEnum = ERPResultEnum.NG;
                    erpReturnInfo.msg = $"{em} 回写失败，错误消息：{erpReturnInfo.msg}";
                    return erpReturnInfo;
                }
            }
            catch (Exception ex)
            {
                mesMsg = $"{em} 回写ERP失败：{ex.Message}";
                erpReturnInfo.msg = mesMsg;
                return erpReturnInfo;
            }
            finally
            {
                if (erpResultEnum == ERPResultEnum.NG)
                {
                    //物料入库，是在MES生成单号，因此调用失败时，事务回滚，日志中不应该显示单号
                    if (em == WriteBackEnum.MaterialStorage)
                    {
                        billNo = string.Empty;
                    }
                }

                //记录日志
                AddWriteBackLog(new WriteBackLogInfo
                {
                    WriteBackCode = em.ToString(),
                    //MD5 = md5,
                    ERPResult = (int)erpResultEnum,
                    ERPNo = erpResultEnum == ERPResultEnum.OK ? erpReturnInfo.ERPNo : string.Empty,
                    ERPMsg = erpReturnInfo.msg,
                    MESMsg = mesMsg,
                    MESBillNo = billNo,
                    WriteBackData = postDataActual, //实际回写数据（传给ERP的数据）
                    WriteBackDataJSON = postDataJson,   //数据库返回的DataTable原始数据
                    ReceiveData = erpMsg,
                    CreateBy = createBy,
                    EnterTime = dtEnterTime,
                    AfterExecProcTime = dtAfterExecProcTime,
                    AfterExecERPTime = dtAfterExecERPTime
                });
            }
        }


        public static ERPU9ReturnInfo SendPostU9(IDbConnection conn, WriteBackEnum em, DataTable dt, string billNo, string createBy, DateTime dtEnterTime, DateTime dtAfterExecProcTime)
        {
            ERPResultEnum erpResultEnum = ERPResultEnum.NG;
            string statusCode = string.Empty;
            string mesMsg = string.Empty;//MES消息
            string postDataActual = string.Empty;//传给ERP的数据（JSON）
            string postDataJson = string.Empty;//回写的数据(JSON格式)（此字段仅为更直观查看MES存储过程返回的数据，这些数据拼接成XML后(即WriteBackData字段的值)，传给ERP）
            string erpMsg = string.Empty;//接收到的ERP数据
            //string md5 = string.Empty;//MD5
            ERPU9ReturnInfo erpReturnInfo = new ERPU9ReturnInfo();//ERP回传信息
            DateTime? dtAfterExecERPTime = null;    //调用ERP接口后时间
            try
            {
                if (dt == null || dt.Rows.Count <= 0)
                {
                    mesMsg = "回写ERP数据为空";
                    throw new Exception(mesMsg);
                }

                //回写配置信息
                var url = ConfigurationManager.AppSettings["ERPWriteUrl"];

                if (string.IsNullOrEmpty(url))
                {
                    mesMsg = "未获取到回写配置URL信息，请检查配置文件";
                    throw new Exception(mesMsg);
                }

                postDataJson = JsonConvert.SerializeObject(dt);

                //获取实际回写数据
                erpMsg = WriteERPU9(em, dt, url, out postDataActual);

                dtAfterExecERPTime = DateTime.Now; //调用ERP接口后时间

                erpReturnInfo = JsonConvert.DeserializeObject<ERPU9ReturnInfo>(erpMsg);

                erpReturnInfo.SendInfo = postDataActual;
                erpReturnInfo.dtAfterExecERPTime = dtAfterExecERPTime;
                erpReturnInfo.ReceiveData = erpMsg;

                if (erpReturnInfo != null && erpReturnInfo.Result)
                {
                    //调用ERP成功
                    erpResultEnum = ERPResultEnum.OK;
                    return erpReturnInfo;
                }
                else
                {
                    //调用ERP失败
                    erpResultEnum = ERPResultEnum.NG;
                    erpReturnInfo.Msg = $"{em} 回写失败，错误消息：{erpReturnInfo.resultMsg}";
                    return erpReturnInfo;
                }

                //if (erpReturnInfo == null)
                //{
                //    erpReturnInfo = new ERPU9ReturnInfo()
                //    {
                //        SendInfo = postDataActual,
                //        dtAfterExecERPTime = dtAfterExecERPTime,
                //        ReceiveData = erpMsg,
                //        Msg = $"{em} 回写失败，错误消息：{erpReturnInfo.resultMsg}"
                //    };
                //}
                //else
                //{
                //    erpReturnInfo.SendInfo = postDataActual;
                //    erpReturnInfo.dtAfterExecERPTime = dtAfterExecERPTime;
                //    erpReturnInfo.ReceiveData = erpMsg;
                //}

                //if (erpReturnInfo.Result)
                //{
                //    //调用ERP成功
                //    erpResultEnum = ERPResultEnum.OK;
                //    return erpReturnInfo;
                //}
                //else
                //{
                //    //调用ERP失败
                //    erpResultEnum = ERPResultEnum.NG;
                //    erpReturnInfo.Msg = $"{em} 回写失败，错误消息：{erpReturnInfo.resultMsg}";
                //    return erpReturnInfo;
                //}
            }
            catch (Exception ex)
            {
                mesMsg = $"{em} 回写ERP失败：{ex.Message}";
                erpReturnInfo.SendInfo = postDataActual;
                erpReturnInfo.dtAfterExecERPTime = dtAfterExecERPTime;
                erpReturnInfo.Msg = mesMsg;
                return erpReturnInfo;
            }
            finally
            {
                if (erpResultEnum == ERPResultEnum.NG)
                {
                    //物料入库，是在MES生成单号，因此调用失败时，事务回滚，日志中不应该显示单号
                    if (em == WriteBackEnum.MaterialStorage)
                    {
                        billNo = string.Empty;
                    }
                }
                //外部无事务时此参数设置为空
                //if (conn == null)
                //{
                //记录日志
                AddWriteBackLog(new WriteBackLogInfo
                {
                    WriteBackCode = em.ToString(),
                    //MD5 = md5,
                    ERPResult = (int)erpResultEnum,
                    ERPNo = erpResultEnum == ERPResultEnum.OK ? erpReturnInfo.ERPNo : string.Empty,
                    ERPMsg = erpReturnInfo.Msg,
                    MESMsg = mesMsg,
                    MESBillNo = billNo,
                    WriteBackData = postDataActual, //实际回写数据（传给ERP的数据）
                    WriteBackDataJSON = postDataJson,   //数据库返回的DataTable原始数据
                    ReceiveData = erpMsg,
                    CreateBy = createBy,
                    EnterTime = dtEnterTime,
                    AfterExecProcTime = dtAfterExecProcTime,
                    AfterExecERPTime = dtAfterExecERPTime
                });
                //}
            }
        }


        public static ERPU9InventoryListInfo SendPostU9InventoryList(WriteBackEnum em, DataTable dt, string billNo, string createBy, DateTime dtEnterTime, DateTime dtAfterExecProcTime)
        {
            ERPResultEnum erpResultEnum = ERPResultEnum.NG;
            string statusCode = string.Empty;
            string mesMsg = string.Empty;//MES消息
            string postDataActual = string.Empty;//传给ERP的数据（JSON）
            string postDataJson = string.Empty;//回写的数据(JSON格式)（此字段仅为更直观查看MES存储过程返回的数据，这些数据拼接成XML后(即WriteBackData字段的值)，传给ERP）
            string erpMsg = string.Empty;//接收到的ERP数据
            //string md5 = string.Empty;//MD5
            ERPU9InventoryListInfo erpReturnInfo = new ERPU9InventoryListInfo();//ERP回传信息
            DateTime? dtAfterExecERPTime = null;    //调用ERP接口后时间
            try
            {
                if (dt == null || dt.Rows.Count <= 0)
                {
                    mesMsg = "回写ERP数据为空";
                    throw new Exception(mesMsg);
                }
                //回写配置信息
                var url = ConfigurationManager.AppSettings["ERPWriteUrlInventoryList"];
                if (string.IsNullOrEmpty(url))
                {
                    mesMsg = "未获取到回写配置URL信息，请检查配置文件";
                    throw new Exception(mesMsg);
                }

                var orgCode = ConfigurationManager.AppSettings["orgCode"];
                if (string.IsNullOrEmpty(orgCode))
                {
                    mesMsg = "未获取到组织编码orgCode信息，请检查配置文件";
                    throw new Exception(mesMsg);
                }

                var orgID = ConfigurationManager.AppSettings["orgID"].ToString();
                if (string.IsNullOrEmpty(orgID))
                {
                    mesMsg = "未获取到组织IDorgID信息，请检查配置文件";
                    throw new Exception(mesMsg);
                }
                var userId = ConfigurationManager.AppSettings["userId"].ToString();
                if (string.IsNullOrEmpty(userId))
                {
                    mesMsg = "未获取到用户IDuserId信息，请检查配置文件";
                    throw new Exception(mesMsg);
                }
                var enterpriseID = ConfigurationManager.AppSettings["enterpriseID"].ToString();
                if (string.IsNullOrEmpty(enterpriseID))
                {
                    mesMsg = "未获取到企业IDenterpriseID信息，请检查配置文件";
                    throw new Exception(mesMsg);
                }

                postDataJson = JsonConvert.SerializeObject(dt);
                //获取实际回写数据
                erpMsg = WriteERPU9(em, dt, url, out postDataActual);
                dtAfterExecERPTime = DateTime.Now; //调用ERP接口后时间
                erpReturnInfo = JsonConvert.DeserializeObject<ERPU9InventoryListInfo>(erpMsg);

                if (erpReturnInfo != null && erpReturnInfo.ReturnSingleItems[0].ExecuteResult == "ok")
                {
                    //调用ERP成功
                    erpResultEnum = ERPResultEnum.OK;
                    return erpReturnInfo;
                }
                else
                {
                    //调用ERP失败
                    erpResultEnum = ERPResultEnum.NG;
                    return erpReturnInfo;
                }
            }
            catch (Exception ex)
            {
                InventoryResultItem inventoryResultItem = new InventoryResultItem();
                inventoryResultItem.ExecuteResult = "err";
                erpReturnInfo.ReturnSingleItems = new List<InventoryResultItem>
                {
                    inventoryResultItem
                };
                erpReturnInfo.ReturnSingleItems[0].PromptText = $"{em} 回写ERP失败：{ex.Message}";
                return erpReturnInfo;
            }
            finally
            {

                AddWriteBackLog(new WriteBackLogInfo
                {
                    WriteBackCode = em.ToString(),
                    //MD5 = md5,
                    ERPResult = (int)erpResultEnum,
                    ERPNo = erpResultEnum == ERPResultEnum.OK ? erpReturnInfo.ReturnSingleItems[0].PromptText : string.Empty,
                    ERPMsg = erpReturnInfo.ReturnSingleItems[0].PromptText,
                    MESMsg = mesMsg,
                    MESBillNo = billNo,
                    WriteBackData = postDataActual, //实际回写数据（传给ERP的数据）
                    WriteBackDataJSON = postDataJson,   //数据库返回的DataTable原始数据
                    ReceiveData = erpMsg,
                    CreateBy = createBy,
                    EnterTime = dtEnterTime,
                    AfterExecProcTime = dtAfterExecProcTime,
                    AfterExecERPTime = dtAfterExecERPTime
                });
            }
        }

        /// <summary>
        /// 回写ERP(K3云星空)
        /// </summary>
        /// <param name="em"></param>
        /// <param name="dt"></param>
        /// <returns></returns>
        private static string WriteERP(WriteBackEnum em, DataTable dt, string url, /*string token,*/ out string postDataActual)
        {
            //string u8Msg = string.Empty;
            string mesMsg = string.Empty;
            string erpMsg = string.Empty;
            postDataActual = string.Empty;

            //服务类型：1000测试通信，1001同步，2001异步无序，2002异步有序
            var ERPsType = ConfigurationManager.AppSettings["ERPsType"];
            int sType;
            if (string.IsNullOrEmpty(ERPsType))
            {
                mesMsg = $"请检查配置文件是否配置[{ERPsType}]节点数据";
                throw new Exception(mesMsg);
            }
            if (!int.TryParse(ERPsType, out sType))
            {
                mesMsg = $"配置文件[{ERPsType}]节点数据格式不正确{ERPsType}";
                throw new Exception(mesMsg);
            }
            //回写ERP：接口服务名（测试环境值为‘_Test’，生产环境值为空字符串‘’，用于区分ERP生产环境、测试环境接口地址！！！
            var ERPServerName = ConfigurationManager.AppSettings["ERPServerName"] ?? string.Empty;

            if (em == WriteBackEnum.WarehouseReceipt)
            {
                #region 仓库收料

                //调用api获取接口
                HttpClientHelper client = new HttpClientHelper();

                var poType = dt.Rows[0]["POType"].ToString();
                var userName = dt.Rows[0]["UserName"].ToString();//中文名

                string serverCode;//接口地址
                string serverName; //描述
                if (poType == "1")
                {
                    //1：采购单
                    serverCode = "MOM_PurRcv_ERP";
                    serverName = "采购收料";
                }
                else
                {
                    //2：委外采购单
                    serverCode = "MOM_OEMPurRcv_ERP";
                    serverName = "委外采购收料";
                }

                ESIPBean entity = new ESIPBean
                {
                    sName = $"{serverCode}{ERPServerName}",//服务名
                    sType = sType,//服务类型：1000测试通信，1001同步，2001异步无序，2002异步有序
                    bDesc = serverName,//业务描述
                    creator = userName,//创建人
                };

                /*
                {
                    "ML":{ //主表结构
                        "MESDocNO ":" //MOM 单号，必有
                        "BusinessDate ":"2021 07 01T15:13:05.527", 业务时间，需要
                        "UserCode ":" 业务操作人编号，需要
                        "UserName 管理员 业务操作人名称，需要
                        "Supplier":"供应商 供应商编码， K3C 必有
                        "DocType":" ",单据类型编码， K3C 需要，为空时按默认标准收料单
                        "SrcUniqueID":" 此次数据包唯一标识，成功后下次不会重复执行，必有，若无须验证传空
                        }
                    ,
                    "DL":[ //明细结构
                    {
                        "BusinessDate":"202107 01T15:13:05.527", 业务时间，需要
                        "ItemCode":"1001906270068615",料号，必有
                        "ItemERPID ":" 料品 ERP 唯一 ID ，必有，来源下载时约定的唯一值
                        "WhCode":"WC001", 存储地点，必有
                        "WhERPID":"100139902220",存储地点唯一 ID ，必有 ，来源下载时约定的唯一值
                        "AutoSeq ":" 采购订单行号，需要
                        "AutoERPID ":" 采购订单行 ERPID ，必有
                        "Qty": 数量，必有
                        "ERPOrderNO ":" 采购订单号，必有
                        "ERPOrderID ":" 采购订单 ERPID ，必有
                        "Memo":"",备注，可无
                        "MOMDocNO ":" //MES 单号，必有
                    }
                    ]
                    }
                */
                var mainInfo = new
                {
                    MESDocNO = dt.Rows[0]["MESDocNO"].ToString(),
                    BusinessDate = dt.Rows[0]["BusinessDate"].ToString(),
                    UserCode = dt.Rows[0]["UserCode"].ToString(),
                    UserName = dt.Rows[0]["UserName"].ToString(),
                    Supplier = dt.Rows[0]["Supplier"].ToString(),
                    DocType = dt.Rows[0]["DocType"].ToString(),
                    SrcUniqueID = dt.Rows[0]["SrcUniqueID"].ToString(),
                };
                //移除部分列
                dt.Columns.Remove("POType");
                dt.Columns.Remove("MESDocNO");
                dt.Columns.Remove("UserCode");
                dt.Columns.Remove("UserName");
                dt.Columns.Remove("Supplier");
                dt.Columns.Remove("DocType");
                dt.Columns.Remove("SrcUniqueID");

                var write = new
                {
                    ML = mainInfo,
                    DL = dt//JsonConvert.SerializeObject(dt)
                };
                entity.data = write;//JsonConvert.SerializeObject(write);

                postDataActual = JsonConvert.SerializeObject(entity);

                erpMsg = client.Post($"{url}", postDataActual);

                #endregion
            }
            else if (em == WriteBackEnum.MaterialStorage)
            {
                #region 物料入库（采购入库、委外采购入库）

                //调用api获取接口
                HttpClientHelper client = new HttpClientHelper();

                var poType = dt.Rows[0]["POType"].ToString();
                var userName = dt.Rows[0]["UserName"].ToString();//中文名

                string serverCode = "MOM_RcvTrans_ERP";//接口地址
                string serverName; //描述
                if (poType == "1")
                {
                    //1：采购单
                    serverName = "采购入库";
                }
                else
                {
                    //2：委外采购
                    serverName = "委外采购入库";
                }

                ESIPBean entity = new ESIPBean
                {
                    sName = $"{serverCode}{ERPServerName}",//服务名
                    sType = sType,//服务类型：1000测试通信，1001同步，2001异步无序，2002异步有序
                    bDesc = serverName,//业务描述
                    creator = userName,//创建人
                };

                var mainInfo = new
                {
                    MESDocNO = dt.Rows[0]["MESDocNO"].ToString(),
                    BusinessDate = dt.Rows[0]["BusinessDate"].ToString(),
                    UserCode = dt.Rows[0]["UserCode"].ToString(),
                    UserName = dt.Rows[0]["UserName"].ToString(),
                    Supplier = dt.Rows[0]["Supplier"].ToString(),
                    DocType = dt.Rows[0]["DocType"].ToString(),
                    SrcUniqueID = dt.Rows[0]["SrcUniqueID"].ToString(),
                };
                //移除部分列
                dt.Columns.Remove("POType");
                dt.Columns.Remove("MESDocNO");
                dt.Columns.Remove("UserCode");
                dt.Columns.Remove("UserName");
                dt.Columns.Remove("Supplier");
                dt.Columns.Remove("DocType");
                dt.Columns.Remove("SrcUniqueID");

                var write = new
                {
                    ML = mainInfo,
                    DL = dt //JsonConvert.SerializeObject(dt)
                };
                entity.data = write;    //JsonConvert.SerializeObject(write);

                postDataActual = JsonConvert.SerializeObject(entity);

                erpMsg = client.Post($"{url}", postDataActual);

                #endregion
            }
            else if (em == WriteBackEnum.IQCReturn)
            {
                #region IQC退料（采购入库、委外采购入库）

                //调用api获取接口
                HttpClientHelper client = new HttpClientHelper();

                var poType = dt.Rows[0]["POType"].ToString();
                var userName = dt.Rows[0]["UserName"].ToString();//中文名

                string serverCode;//接口地址
                string serverName; //描述
                if (poType == "1")
                {
                    //1：采购单
                    serverCode = "MOM_RejecPurRcv_ERP";
                    serverName = "采购IQC退料";
                }
                else
                {
                    //2：委外采购
                    serverCode = "MOM_OEMRejecPurRcv_ERP";
                    serverName = "委外采购IQC退料";
                }

                ESIPBean entity = new ESIPBean
                {
                    sName = $"{serverCode}{ERPServerName}",//服务名
                    sType = sType,//服务类型：1000测试通信，1001同步，2001异步无序，2002异步有序
                    bDesc = serverName,//业务描述
                    creator = userName,//创建人
                };

                var mainInfo = new
                {
                    MESDocNO = dt.Rows[0]["MESDocNO"].ToString(),
                    BusinessDate = dt.Rows[0]["BusinessDate"].ToString(),
                    UserCode = dt.Rows[0]["UserCode"].ToString(),
                    UserName = dt.Rows[0]["UserName"].ToString(),
                    Supplier = dt.Rows[0]["Supplier"].ToString(),
                    SrcUniqueID = dt.Rows[0]["SrcUniqueID"].ToString(),
                };
                //移除部分列
                dt.Columns.Remove("POType");
                dt.Columns.Remove("MESDocNO");
                dt.Columns.Remove("UserCode");
                dt.Columns.Remove("UserName");
                dt.Columns.Remove("Supplier");
                dt.Columns.Remove("SrcUniqueID");

                var write = new
                {
                    ML = mainInfo,
                    DL = dt //JsonConvert.SerializeObject(dt)
                };
                entity.data = write;    //JsonConvert.SerializeObject(write);

                postDataActual = JsonConvert.SerializeObject(entity);

                erpMsg = client.Post($"{url}", postDataActual);

                #endregion
            }
            else if (em == WriteBackEnum.WarehouseReturnSupplier)
            {
                #region 仓库退供应商

                //调用api获取接口
                HttpClientHelper client = new HttpClientHelper();

                var userName = dt.Rows[0]["UserName"].ToString();//中文名

                string serverCode = "MOM_ApprovedWarehouseReturn_ERP";//接口地址
                string serverName = "仓库退供应商"; //描述

                ESIPBean entity = new ESIPBean
                {
                    sName = $"{serverCode}{ERPServerName}",//服务名
                    sType = sType,//服务类型：1000测试通信，1001同步，2001异步无序，2002异步有序
                    bDesc = serverName,//业务描述
                    creator = userName,//创建人
                };

                /*{ 
		            "ML":{                                        //主表结构 
		            "MESDocNO":"RKD202107310001",  	 	 	 	//MES单号，必有 
		            "BusinessDate":"2021-07-01T15:13:05.527", 	 	 	//业务时间，需要 
		            "UserCode":"admin",  	 	 	 	 	//业务操作人编号，需要 
		            "UserName":"管理员",  	 	 	 	 	//业务操作人名称，需要 
		            "SrcUniqueID":" RKD202107310001"  	 	 	 	//此次数据包唯一标识，下次不会重复执行，必有，若无须验证传空 
		            } 
		            , 
		            "DL":                                     //明细结构//数组 
		            [ 
		            { 
			            "BusinessDate":"2021-07-01T15:13:05.527",  	//业务时间，需要 
			            "ERPOrderNO":"27PO2021001111",  	 	 	//杂收单单号，必有，K3C必有 ，其他入库单号（采购单号）
			            "ERPOrderID":"10028882888283",  	 	 	//杂发单ERPID，必有 EPRbillID
			            "Reviewer":"管理员",  	 	 	 	//审核人，可无 
			            "AuditDate":"2021-07-01T15:13:05.527" 	 	     //审核时间，可无 
		            } 
		            ] 
		            } 
                */
                var mainInfo = new
                {
                    MESDocNO = dt.Rows[0]["MESDocNO"].ToString(),
                    BusinessDate = dt.Rows[0]["BusinessDate"].ToString(),
                    UserCode = dt.Rows[0]["UserCode"].ToString(),
                    UserName = dt.Rows[0]["UserName"].ToString(),
                    SrcUniqueID = dt.Rows[0]["SrcUniqueID"].ToString(),
                };
                //移除部分列
                dt.Columns.Remove("MESDocNO");
                dt.Columns.Remove("UserCode");
                dt.Columns.Remove("UserName");
                dt.Columns.Remove("SrcUniqueID");

                var write = new
                {
                    ML = mainInfo,
                    DL = dt//JsonConvert.SerializeObject(dt)
                };
                entity.data = write;//JsonConvert.SerializeObject(write);

                postDataActual = JsonConvert.SerializeObject(entity);

                erpMsg = client.Post($"{url}", postDataActual);

                #endregion
            }
            else if (em == WriteBackEnum.OtherStorage)
            {
                #region 其它入库、受托加工入库

                //调用api获取接口
                HttpClientHelper client = new HttpClientHelper();

                var poType = dt.Rows[0]["POType"].ToString();
                var userName = dt.Rows[0]["UserName"].ToString();//中文名

                string serverCode = string.Empty;//接口地址
                string serverName = string.Empty; //描述
                if (poType == "4")
                {
                    serverCode = "MOM_ApprovedSTRcvTrans_ERP";    //受托加工入库
                    serverName = "受托加工入库";
                }
                else if (poType == "5")
                {
                    serverCode = "MOM_ApprovedMiscRcv_ERP";    //其它入库
                    serverName = "其它入库";
                }

                ESIPBean entity = new ESIPBean
                {
                    sName = $"{serverCode}{ERPServerName}",//服务名
                    sType = sType,//服务类型：1000测试通信，1001同步，2001异步无序，2002异步有序
                    bDesc = serverName,//业务描述
                    creator = userName,//创建人
                };

                /*
		        { 
			        "ML":
			        {                                        //主表结构 
			        "MESDocNO":"RKD202107310001",  	 	 	 	//MES单号，必有 
			        "BusinessDate":"2021-07-01T15:13:05.527", 	 	 	//业务时间，需要 
			        "UserCode":"admin",  	 	 	 	 	//业务操作人编号，需要 
			        "UserName":"管理员",  	 	 	 	 	//业务操作人名称，需要 
			        "SrcUniqueID":" RKD202107310001"  	 	 	 	//此次数据包唯一标识，下次不会重复执行，必有，若无须验证传空 
			        } , 
			        "DL":                                     //明细结构//数组 
			        [ 
			        { 
				        "BusinessDate":"2021-07-01T15:13:05.527",  	//业务时间，需要 
				        "ERPOrderNO":"27PO2021001111",  	 	 	//杂收单单号，必有，K3C必有 ，其他入库单号（采购单号）
				        "ERPOrderID":"10028882888283",  	 	 	//杂发单ERPID，必有 EPRbillID
				        "Reviewer":"管理员",  	 	 	 	//审核人，可无 
			            "AuditDate":"2021-07-01T15:13:05.527" 	 	     //审核时间，可无 
			        } 
			        ] } 
		        */
                var mainInfo = new
                {
                    MESDocNO = dt.Rows[0]["MESDocNO"].ToString(),
                    BusinessDate = dt.Rows[0]["BusinessDate"].ToString(),
                    UserCode = dt.Rows[0]["UserCode"].ToString(),
                    UserName = dt.Rows[0]["UserName"].ToString(),
                    SrcUniqueID = dt.Rows[0]["SrcUniqueID"].ToString(),
                };
                //移除部分列
                dt.Columns.Remove("POType");
                dt.Columns.Remove("MESDocNO");
                dt.Columns.Remove("UserCode");
                dt.Columns.Remove("UserName");
                dt.Columns.Remove("SrcUniqueID");

                var write = new
                {
                    ML = mainInfo,
                    DL = dt
                };
                entity.data = write;

                postDataActual = JsonConvert.SerializeObject(entity);

                erpMsg = client.Post($"{url}", postDataActual);

                #endregion
            }
            else if (em == WriteBackEnum.FinishStorage)
            {
                #region 成品入库

                //调用api获取接口
                HttpClientHelper client = new HttpClientHelper();

                var userName = dt.Rows[0]["UserName"].ToString();//中文名

                string serverCode = "MOM_CompRpt_ERP";//接口地址
                string serverName = "成品入库"; //描述

                ESIPBean entity = new ESIPBean
                {
                    sName = $"{serverCode}{ERPServerName}",//服务名
                    sType = sType,//服务类型：1000测试通信，1001同步，2001异步无序，2002异步有序
                    bDesc = serverName,//业务描述
                    creator = userName,//创建人
                };

                /*
               { 
		        "ML":{                                        //主表结构 
		        "MESDocNO":"MO202107310001", 	 	 	 	//MES单号，必有 入库单号
		        "BusinessDate":"2021-07-01T15:13:05.527", 	//业务时间，需要 
		        "UserCode":"admin",  	 	 	 	 	//业务操作人编号，需要 
		        "UserName":"管理员",  	 	 	 	 //业务操作人名称，需要 
		        "SrcUniqueID":" MO202107310001"  	 	 	//此次数据包唯一标识，下次不会重复执行，必有，若无须验证传空 
		        } 
		          , 
		        "DL":[                                     //明细结构 
		        { 
			        "BusinessDate":"2021-07-01T15:13:05.527",  	//业务时间，需要 
			        "ItemCode":"1001906270068615",  	 	 	//料号，必有 
			        "ItemERPID":"1002331999881",  	 	 	//料品ERPID，必有 
			        "WhCode":"WC-001",  	 	 	 	//存储地点，必有 仓库编码
			        "WhERPID":"100139902220",  	 	 //存储地点ID，必有 空
			        "LCCode":"A区-01",               //货位/仓位编码，若启用了货位管理必有，空
			        "LCERPID":"A001",              /货位/仓位编码，若启用了货位管理必有，空
			        "Qty":5,  	 	 	 	 	 //完工数量，必有 
			        "reMadeQty":5,  	 	 	 //返工数量，可无 
			        "ERPOrderNO":"MO2021001111",  	 	 	//生产订单号，必有 ，工单号
			        "ERPOrderID":"10028882888283",  	 	 	//生产订单ERPID，必有 ，ERPMOID
			        "Memo":"",  	 	 	 	 	//备注，可无 
			        "MOMDocNO":"MO202107310001",  	 	 	//MES单号，必有 
		        "CompleteDate":"2021-07-01T15:13:05.527", 	 	//完工日期，非必要，为空时取当前日期 
		        "ActualRcvTime":"2021-07-01T15:13:05.527", 	 	//实际入库时间，非必要，为空时取完工日期 
		        "CompleteDocTypeCode":"产品完工报告",  	 	//完工报告单据类型，必有，目前有‘返工产品完工报告’‘产品完工报告’两个单据类型，空
			          "LotCode":"Trans001", 	 	 	 	       	  //批号，需要（U9 如果启用的批号管理，则必传） 空
		        "AutoSeq":"01",  	 	 	 	 	//MES行号，需要（U9如果启用的批号管理，则必传） ，目前工单号与行号拼接，截取
		        "DocNo":"WG123456789"，  	 	 	 	//完工报告单号，必有，U9需要设置为手工编码，空
			        "BomMaster":"1.032_V1.0"  	 	        //BOM版本，K3必有 Basal_ItemBom,BomName
		        } 
		        ] 
		        } 
                */
                var mainInfo = new
                {
                    MESDocNO = dt.Rows[0]["MESDocNO"].ToString(),
                    BusinessDate = dt.Rows[0]["BusinessDate"].ToString(),
                    UserCode = dt.Rows[0]["UserCode"].ToString(),
                    UserName = dt.Rows[0]["UserName"].ToString(),
                    SrcUniqueID = dt.Rows[0]["SrcUniqueID"].ToString(),
                };
                //移除部分列
                dt.Columns.Remove("MESDocNO");
                dt.Columns.Remove("UserCode");
                dt.Columns.Remove("UserName");
                dt.Columns.Remove("SrcUniqueID");

                var write = new
                {
                    ML = mainInfo,
                    DL = dt //JsonConvert.SerializeObject(dt)
                };
                entity.data = write; // JsonConvert.SerializeObject(write);

                postDataActual = JsonConvert.SerializeObject(entity);

                erpMsg = client.Post($"{url}", postDataActual);

                #endregion
            }
            else if (em == WriteBackEnum.TransferStorage || em == WriteBackEnum.TransferConsignSale)
            {
                #region 调拨入库、寄售调拨

                //调用api获取接口
                HttpClientHelper client = new HttpClientHelper();

                var userName = dt.Rows[0]["UserName"].ToString();//中文名
                string serverCode = string.Empty; //"MOM_ApprovedTransferIn_ERP";//接口地址
                string serverName = string.Empty; //描述
                if (em == WriteBackEnum.TransferStorage)
                {
                    serverCode = "MOM_Transfer_ERP";
                    serverName = "调拨入库";
                }
                else
                {
                    serverCode = "MOM_TransferJS_ERP";
                    serverName = "寄售调拨";
                }

                ESIPBean entity = new ESIPBean
                {
                    sName = $"{serverCode}{ERPServerName}",//服务名
                    sType = sType,//服务类型：1000测试通信，1001同步，2001异步无序，2002异步有序
                    bDesc = serverName,//业务描述
                    creator = userName,//创建人
                };
                #region

                /*
                { 
                "ML":{                                        //主表结构 
                "MESDocNO":"DB202204010001", 	 	 	 	//MES调拨单号，必有 
                "BusinessDate":"2022-04-01T15:13:05.527", 	//业务时间，需要 
                "UserCode":"admin",  	 	 	 	 	//业务操作人编号，需要 
                "UserName":"管理员",  	 	 	 	 //业务操作人名称，需要 
                "DocType":"ZJDB01_SYS",               //单据类型，K3C需要,ZJDB01_SYS直接调拨,ZJDB02_SYS寄售调拨，空
                "SrcUniqueID":" DB202204010001"  	 //此次数据包唯一标识，下次不会重复执行，必有，若无须验证传空 
                } , 
                "DL":[                                     //明细结构 
                { 
	                "BusinessDate":"2021-04-01T15:13:05.527",  	//业务时间，需要 
                    "ItemCode":"1001906270068615",  	 	 	//料号，必有 
                    "ItemERPID":"1002331999881",  	 	 	//料品ERPID，必有 
                    "InWhouse":"001",  	 	 	 	 	//调入仓库编号，必有(U8明细行必须一致)   仓库编码
                    "InWhERPID":"001",  	 	 	 	//调入仓库ERPID，必有(U8明细行必须一致)    空
                    "OutWhouse":"002",  	 	 	 	//调出仓库编号，必有(U8明细行必须一致)    仓库编码
                    "OutWhERPID":"002",  	 	 	 	//调出仓库ERPID，必有(U8明细行必须一致)     空
                    "InDepCode":"01",  	 	 	 	//调入部门编号，若启用了部门核算则必有(U8明细行必须一致)  空42
                    "InDepERPID":"01",  	 	 	 	//调入部门ERPID，若启用了部门核算则必有(U8明细行必须一致)   空
                    "OutDepCode":"01",  	 	 	 	//调出部门编号，若启用了部门核算则必有(U8明细行必须一致)     空
                    "OutDepERPID":"01",  	 	 	 	//调出部门ERPID，若启用了部门核算则必有(U8明细行必须一致)    空
	                "InLCCode":"A区-01",             //货位/仓位编码，若启用了货位管理必有，若系统间没有用ID建立关联，可不传  空
	                "InLCERPID":"A001",               /货位/仓位编码，若启用了货位管理必有  空
                    "OutLCCode":"A区-01",   空
                    "OutLCERPID":"A001",      空
                    "ERPOrderNO":"27MO2021001111",  	 	 	//销售单号（寄售调拨），直接调拨为空
	                "AutoSeq":"10",  	 	 	 	 	//MES调拨单行号，需要 ，MES调拨行号
	                "Qty":3,  	 	 	 	 	 	//数量，必有 
	                "Units":"PSC",                            	//入库单位编码，金蝶K3WISE必有，单位 
                    "DocType":"TransIn001", 	 	 	 	//单据类型编码，必有  空
                    "LotCode":"Trans001",  	 	 	 	//批号，需要（U9如果启用的批号管理，则必传）空 
                    "Memo":"",  	 	 	 	 	//备注，非必有 
                    "MOMDocNO":"CZF202204010001"  	 	 	//MES单号，必有 调拨单号
                    } 
                ] } 
                */
                #endregion

                var mainInfo = new
                {
                    MESDocNO = dt.Rows[0]["MESDocNO"].ToString(),
                    BusinessDate = dt.Rows[0]["BusinessDate"].ToString(),
                    UserCode = dt.Rows[0]["UserCode"].ToString(),
                    UserName = dt.Rows[0]["UserName"].ToString(),
                    DocType = dt.Rows[0]["DocType"].ToString(),
                    SrcUniqueID = dt.Rows[0]["SrcUniqueID"].ToString(),
                };
                //移除部分列
                dt.Columns.Remove("MESDocNO");
                dt.Columns.Remove("UserCode");
                dt.Columns.Remove("UserName");
                dt.Columns.Remove("DocType");
                dt.Columns.Remove("SrcUniqueID");

                var write = new
                {
                    ML = mainInfo,
                    DL = dt
                };
                entity.data = write;

                postDataActual = JsonConvert.SerializeObject(entity);

                erpMsg = client.Post($"{url}", postDataActual);

                #endregion
            }
            else if (em == WriteBackEnum.MaterialPrepare)
            {
                /*
                 工单领料       生产领料单创建审核	                MOM_MaterialSupply_ERP
                 工单补料       生产补料单创建审核	                MOM_ReMaterialSupply_ERP
                 委外领料       委外生产领料单创建审核	MOM_OEMIssueDoc_ERP
                 委外补料       委外生产补料单创建审核	MOM_ReOEMIssueDoc_ERP
                 其它领料       其他出库单审核	                MOM_ApprovedMiscShip_ERP
                 */
                #region 工单领料、工单补料、委外领料、委外补料、其它领料

                //调用api获取接口
                HttpClientHelper client = new HttpClientHelper();

                var applyType = dt.Rows[0]["ApplyType"].ToString();//领料单类型（0：杂发审核(其他出库)  1：工单领料  2：委外领料  3：工单补料  4：委外补料）
                var userName = dt.Rows[0]["UserName"].ToString();//中文名

                dt.Columns.Remove("ApplyType");

                string serverCode = string.Empty;//接口地址
                string serverName = string.Empty; //描述
                switch (applyType)
                {
                    case "0": serverCode = "MOM_ApprovedMiscShip_ERP"; serverName = "其他出库"; break;
                    case "1": serverCode = "MOM_MaterialSupply_ERP"; serverName = "工单领料"; break;
                    case "2": serverCode = "MOM_OEMIssueDoc_ERP"; serverName = "委外领料"; break;
                    case "3": serverCode = "MOM_ReMaterialSupply_ERP"; serverName = "工单补料"; break;
                    case "4": serverCode = "MOM_ReOEMIssueDoc_ERP"; serverName = "委外补料"; break;
                }
                if (string.IsNullOrEmpty(serverCode))
                {
                    throw new Exception($"不存在的领料单类型[{applyType}]");
                }

                ESIPBean entity = new ESIPBean
                {
                    sName = $"{serverCode}{ERPServerName}",//服务名
                    sType = sType,//服务类型：1000测试通信，1001同步，2001异步无序，2002异步有序
                    bDesc = serverName,//业务描述
                    creator = userName,//创建人
                };

                var mainInfo = new
                {
                    MESDocNO = dt.Rows[0]["MESDocNO"].ToString(),
                    BusinessDate = dt.Rows[0]["BusinessDate"].ToString(),
                    UserCode = dt.Rows[0]["UserCode"].ToString(),
                    UserName = dt.Rows[0]["UserName"].ToString(),
                    SrcUniqueID = dt.Rows[0]["SrcUniqueID"].ToString(),
                    DepCode = dt.Columns.Contains("DepCode") ? dt.Rows[0]["DepCode"].ToString() : string.Empty,
                    DepERPID = dt.Columns.Contains("DepERPID") ? dt.Rows[0]["DepERPID"].ToString() : string.Empty,
                    cSource = dt.Columns.Contains("cSource") ? dt.Rows[0]["cSource"].ToString() : string.Empty,
                    Supplier = dt.Columns.Contains("Supplier") ? dt.Rows[0]["Supplier"].ToString() : string.Empty,
                    SrcDocType = dt.Columns.Contains("SrcDocType") ? dt.Rows[0]["SrcDocType"].ToString() : string.Empty,
                    F_SFDK_SGBFDH = dt.Columns.Contains("F_SFDK_SGBFDH") ? dt.Rows[0]["F_SFDK_SGBFDH"].ToString() : string.Empty,
                    DocType = dt.Columns.Contains("DocType") ? dt.Rows[0]["DocType"].ToString() : string.Empty,
                };
                //移除通用部分列
                dt.Columns.Remove("MESDocNO");
                dt.Columns.Remove("UserCode");
                dt.Columns.Remove("UserName");
                dt.Columns.Remove("SrcUniqueID");
                //移除不同领料单类型定制列部分
                if (dt.Columns.Contains("DepCode"))
                {
                    dt.Columns.Remove("DepCode");
                }
                if (dt.Columns.Contains("DepERPID"))
                {
                    dt.Columns.Remove("DepERPID");
                }
                if (dt.Columns.Contains("cSource"))
                {
                    dt.Columns.Remove("cSource");
                }
                if (dt.Columns.Contains("Supplier"))
                {
                    dt.Columns.Remove("Supplier");
                }
                if (dt.Columns.Contains("SrcDocType"))
                {
                    dt.Columns.Remove("SrcDocType");
                }
                if (dt.Columns.Contains("F_SFDK_SGBFDH"))
                {
                    dt.Columns.Remove("F_SFDK_SGBFDH");
                }
                if (dt.Columns.Contains("DocType"))
                {
                    dt.Columns.Remove("DocType");
                }

                var write = new
                {
                    ML = mainInfo,
                    DL = dt
                };
                entity.data = write;

                postDataActual = JsonConvert.SerializeObject(entity);

                erpMsg = client.Post($"{url}", postDataActual);

                #endregion
            }
            else if (em == WriteBackEnum.ProductReturn)
            {
                #region 生产退料、委外退料

                //调用api获取接口
                HttpClientHelper client = new HttpClientHelper();

                var userName = dt.Rows[0]["UserName"].ToString();//中文名

                //生产退料单创建审核 MOM_RecedeIssueDoc_ERP
                //委外生产退料单创建审核 MOM_OEMRecedeIssueDoc_ERP

                var orderType = dt.Rows[0]["OrderType"].ToString();
                string serverCode = string.Empty;//接口地址
                string serverName = string.Empty; //描述
                if (orderType == "1")
                {
                    serverCode = "MOM_RecedeIssueDoc_ERP";//接口地址
                    serverName = "生产退料"; //描述
                }
                else
                {
                    serverCode = "MOM_OEMRecedeIssueDoc_ERP";//接口地址
                    serverName = "委外生产退料"; //描述
                }

                ESIPBean entity = new ESIPBean
                {
                    sName = $"{serverCode}{ERPServerName}",//服务名
                    sType = sType,//服务类型：1000测试通信，1001同步，2001异步无序，2002异步有序
                    bDesc = serverName,//业务描述
                    creator = userName,//创建人
                };

                /*
                    "ML":{                                        //主表结构
                    "MESDocNO":"RKD202107310001",     //MES单号，必有
                    "BusinessDate":"2021-07-31T15:13:05.527",   //业务时间，需要
                    "UserCode":"370177",       //业务操作人编号，需要
                    "UserName":"管理员",       //业务操作人名称，需要
                    "SrcUniqueID":" RKD202107310001"     //此次数据包唯一标识，下次不会重复执行，必有
                    }
                    ,
                    "DL":[                                     //明细结构
                    {
                    "BusinessDate":"2021-07-31T15:13:05.527", //业务时间，需要
                    "ItemCode":"1001906270068615",				//料号，必有
                    "ItemERPID":"1002331999881",				//料品ERPID，必有
                    "WhCode":"WC-001",						//存储地点，必有
                    "WhERPID":"100139902220",					//存储地点ID，必有
                    "AutoSeq":"01",							//生产退料行号，需要
                    "AutoERPID":"1001999902220",				//生产退料行ERPID，必有
                    "Qty":5,									//数量，必有
                    "ERPOrderNO":"27PO2021001111",				//生产领料单号,必有
                    "ERPOrderID":"10028882888283",    //生产领料ERPID,必有
                    "Memo":"",        //备注，可无
                    "MOMDocNO":"RKD202107310001"    //MES单号，必有
                    }]}
                  */
                var mainInfo = new
                {
                    MESDocNO = dt.Rows[0]["MESDocNO"].ToString(),
                    BusinessDate = dt.Rows[0]["BusinessDate"].ToString(),
                    UserCode = dt.Rows[0]["UserCode"].ToString(),
                    UserName = dt.Rows[0]["UserName"].ToString(),
                    Supplier = dt.Columns.Contains("Supplier") ? dt.Rows[0]["Supplier"].ToString() : string.Empty,
                    SrcUniqueID = dt.Rows[0]["SrcUniqueID"].ToString(),
                };

                //移除部分列
                dt.Columns.Remove("OrderType");
                if (dt.Columns.Contains("Supplier"))
                {
                    dt.Columns.Remove("Supplier");
                }
                dt.Columns.Remove("MESDocNO");
                dt.Columns.Remove("UserCode");
                dt.Columns.Remove("UserName");
                dt.Columns.Remove("SrcUniqueID");

                var write = new
                {
                    ML = mainInfo,
                    DL = dt
                };
                entity.data = write;

                postDataActual = JsonConvert.SerializeObject(entity);

                erpMsg = client.Post($"{url}", postDataActual);

                #endregion
            }
            else if (em == WriteBackEnum.SaleExWarehouse)
            {
                #region 销售出货

                //调用api获取接口
                HttpClientHelper client = new HttpClientHelper();

                var userName = dt.Rows[0]["UserName"].ToString();//中文名

                string serverCode = "MOM_ApprovedShip_ERP";//接口地址
                string serverName = "销售出货"; //描述

                ESIPBean entity = new ESIPBean
                {
                    sName = $"{serverCode}{ERPServerName}",//服务名
                    sType = sType,//服务类型：1000测试通信，1001同步，2001异步无序，2002异步有序
                    bDesc = serverName,//业务描述
                    creator = userName,//创建人
                };

                /*
               { 
			    "ML":{                                         //主表结构 
				    "MESDocNO":"RKD202107310001",  	 	 	//MES单号，必有 
				    "BusinessDate":"2021-07-01T15:13:05.527",  	 	//业务时间，需要 
				    "UserCode":"admin",  	 	 	 	//业务操作人编号，需要 
				    "UserName":"管理员", 	 	 	 	 	//业务操作人名称，需要 
			      }, 
			    "DL": [{                                      	 	//明细结构(数组) 
			    "BusinessDate":"2021-07-01T15:13:05.527", 	 	//业务时间，需要 
				    "ERPOrderNO":"RKD202107310001",  	 	 	//出货单单号，必有，K3C必有 
				    "ERPOrderID":"10028882888283",  	 	 	//出货单ERPID，必有 
				    "Reviewer":"管理员",  	 	 	 	//审核人，非必要 
				    "AuditDate":"2021-07-01T15:13:05.527",  	 	//审核时间，非必要 
			    }] 
			    } 
                */
                var mainInfo = new
                {
                    MESDocNO = dt.Rows[0]["MESDocNO"].ToString(),
                    BusinessDate = dt.Rows[0]["BusinessDate"].ToString(),
                    UserCode = dt.Rows[0]["UserCode"].ToString(),
                    UserName = dt.Rows[0]["UserName"].ToString(),
                    SrcUniqueID = dt.Rows[0]["SrcUniqueID"].ToString(),
                };
                //移除部分列
                dt.Columns.Remove("MESDocNO");
                dt.Columns.Remove("UserCode");
                dt.Columns.Remove("UserName");
                dt.Columns.Remove("SrcUniqueID");

                var write = new
                {
                    ML = mainInfo,
                    DL = dt
                };
                entity.data = write;

                postDataActual = JsonConvert.SerializeObject(entity);

                erpMsg = client.Post($"{url}", postDataActual);

                #endregion
            }
            return erpMsg;
        }

        /// <summary>
        /// 回写ERP(用友U9)
        /// </summary>
        /// <param name="em"></param>
        /// <param name="dt"></param>
        /// <param name="url"></param>
        /// <param name="postDataActual"></param>
        /// <returns></returns>
        private static string WriteERPU9(WriteBackEnum em, DataTable dt, string url, out string postDataActual)
        {
            string mesMsg = string.Empty;
            string erpMsg = string.Empty;
            postDataActual = string.Empty;


            if (em == WriteBackEnum.WarehouseReceipt)
            {
                #region 仓库收料
                /*
                //调用api获取接口
                HttpClientHelper client = new HttpClientHelper();

                U9Bean entity = new U9Bean { };

                var mainInfo = new
                {
                    MESDocNO = dt.Rows[0]["MESDocNO"].ToString(),
                    BusinessDate = dt.Rows[0]["BusinessDate"].ToString(),
                    UserCode = dt.Rows[0]["UserCode"].ToString(),
                    UserName = dt.Rows[0]["UserName"].ToString(),
                    Supplier = dt.Rows[0]["Supplier"].ToString(),
                    DocType = dt.Rows[0]["DocType"].ToString(),
                    SrcUniqueID = dt.Rows[0]["SrcUniqueID"].ToString(),
                };
                //移除部分列
                dt.Columns.Remove("POType");
                dt.Columns.Remove("MESDocNO");
                dt.Columns.Remove("UserCode");
                dt.Columns.Remove("UserName");
                dt.Columns.Remove("Supplier");
                dt.Columns.Remove("DocType");
                dt.Columns.Remove("SrcUniqueID");

                var write = new
                {
                    ML = mainInfo,
                    DL = dt//JsonConvert.SerializeObject(dt)
                };
                entity.data = write;//JsonConvert.SerializeObject(write);

                postDataActual = JsonConvert.SerializeObject(entity);

                erpMsg = client.Post($"{url}", postDataActual);
                */
                #endregion
            }
            else if (em == WriteBackEnum.MaterialStorage)
            {
                #region 物料入库（采购入库、委外采购入库）

                //调用api获取接口
                HttpClientHelper client = new HttpClientHelper();

                U9Bean entity = new U9Bean
                {
                    requestId = "PO" + DateTime.Now.ToString("yyyyMMddHHmmssfff"), //PO202407130868970
                    requestTime = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"),
                    requestType = "add",
                    userId = dt.Rows[0]["userId"].ToString()
                };

                DataRow dr = dt.Copy().Rows[0];

                //移除部分列
                dt.Columns.Remove("POType");
                dt.Columns.Remove("userId");
                dt.Columns.Remove("billCode");
                dt.Columns.Remove("billDate");
                dt.Columns.Remove("supCode");
                dt.Columns.Remove("deptCode");
                dt.Columns.Remove("stockCode");
                dt.Columns.Remove("userCode");
                dt.Columns.Remove("ckUserCode");
                dt.Columns.Remove("remark");

                var data = new
                {
                    billCode = dr["billCode"].ToString(),
                    billDate = dr["billDate"].ToString(),
                    supCode = dr["supCode"].ToString(),
                    sourceCode = dr["sourceCode"].ToString(),
                    deptCode = dr["deptCode"].ToString(),
                    stockCode = dr["stockCode"].ToString(),
                    userCode = dr["userCode"].ToString(),
                    ckUserCode = dr["ckUserCode"].ToString(),
                    remark = dr["remark"].ToString(),
                    list = dt
                };

                entity.data = new List<dynamic> { data };

                postDataActual = JsonConvert.SerializeObject(entity);

                erpMsg = client.Post($"{url}?method=poin", postDataActual);

                #endregion
            }
            else if (em == WriteBackEnum.MiscellaneousInStorage)
            {
                #region 杂收单审核（物料入库时的采购订单的POType=3 ）

                //调用api获取接口
                HttpClientHelper client = new HttpClientHelper();

                U9Bean entity = new U9Bean
                {
                    requestId = "PR" + DateTime.Now.ToString("yyyyMMddHHmmssfff"), //PO202407130868970
                    requestTime = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"),
                    requestType = "check",
                    userId = dt.Rows[0]["userId"].ToString()
                };

                DataRow dr = dt.Copy().Rows[0];

                //移除部分列
                dt.Columns.Remove("POType");
                dt.Columns.Remove("userId");

                var data = new
                {
                    billCode = dr["billCode"].ToString(),
                    billDate = dr["billDate"].ToString(),
                    ckUserCode = dr["ckUserCode"].ToString(),
                };

                entity.data = new List<dynamic> { data };

                postDataActual = JsonConvert.SerializeObject(entity);

                erpMsg = client.Post($"{url}?method=otherin", postDataActual);

                #endregion
            }
            else if (em == WriteBackEnum.IQCReturn)
            {
                #region IQC退料（采购入库、委外采购入库）
                /*
                //调用api获取接口
                HttpClientHelper client = new HttpClientHelper();

                U9Bean entity = new U9Bean { };

                var mainInfo = new
                {
                    MESDocNO = dt.Rows[0]["MESDocNO"].ToString(),
                    BusinessDate = dt.Rows[0]["BusinessDate"].ToString(),
                    UserCode = dt.Rows[0]["UserCode"].ToString(),
                    UserName = dt.Rows[0]["UserName"].ToString(),
                    Supplier = dt.Rows[0]["Supplier"].ToString(),
                    SrcUniqueID = dt.Rows[0]["SrcUniqueID"].ToString(),
                };
                //移除部分列
                dt.Columns.Remove("POType");
                dt.Columns.Remove("MESDocNO");
                dt.Columns.Remove("UserCode");
                dt.Columns.Remove("UserName");
                dt.Columns.Remove("Supplier");
                dt.Columns.Remove("SrcUniqueID");

                var write = new
                {
                    ML = mainInfo,
                    DL = dt //JsonConvert.SerializeObject(dt)
                };
                entity.data = write;    //JsonConvert.SerializeObject(write);

                postDataActual = JsonConvert.SerializeObject(entity);

                erpMsg = client.Post($"{url}", postDataActual);
                */
                #endregion
            }
            else if (em == WriteBackEnum.WarehouseReturnSupplier)
            {
                #region 仓库退供应商（采购退货审核）

                //调用api获取接口
                HttpClientHelper client = new HttpClientHelper();

                U9Bean entity = new U9Bean
                {
                    requestId = "WR" + DateTime.Now.ToString("yyyyMMddHHmmssfff"), //PO202407130868970
                    requestTime = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"),
                    requestType = "check",
                    userId = dt.Rows[0]["userId"].ToString()
                };

                DataRow dr = dt.Copy().Rows[0];

                //移除部分列
                dt.Columns.Remove("userId");

                var data = new
                {
                    billCode = dr["billCode"].ToString(),
                    billDate = dr["billDate"].ToString(),
                    ckUserCode = dr["ckUserCode"].ToString(),
                };

                entity.data = new List<dynamic> { data };

                postDataActual = JsonConvert.SerializeObject(entity);

                erpMsg = client.Post($"{url}?method=poback", postDataActual);

                #endregion
            }
            else if (em == WriteBackEnum.OtherStorage)
            {
                #region 其它入库、受托加工入库
                /*
                //调用api获取接口
                HttpClientHelper client = new HttpClientHelper();

                U9Bean entity = new U9Bean { };

                var mainInfo = new
                {
                    MESDocNO = dt.Rows[0]["MESDocNO"].ToString(),
                    BusinessDate = dt.Rows[0]["BusinessDate"].ToString(),
                    UserCode = dt.Rows[0]["UserCode"].ToString(),
                    UserName = dt.Rows[0]["UserName"].ToString(),
                    SrcUniqueID = dt.Rows[0]["SrcUniqueID"].ToString(),
                };
                //移除部分列
                dt.Columns.Remove("POType");
                dt.Columns.Remove("MESDocNO");
                dt.Columns.Remove("UserCode");
                dt.Columns.Remove("UserName");
                dt.Columns.Remove("SrcUniqueID");

                var write = new
                {
                    ML = mainInfo,
                    DL = dt
                };
                entity.data = write;

                postDataActual = JsonConvert.SerializeObject(entity);

                erpMsg = client.Post($"{url}", postDataActual);
                */
                #endregion
            }
            else if (em == WriteBackEnum.FinishStorage)
            {
                #region 成品入库

                //调用api获取接口
                HttpClientHelper client = new HttpClientHelper();

                U9Bean entity = new U9Bean
                {
                    requestId = "FS" + DateTime.Now.ToString("yyyyMMddHHmmssfff"), //PO202407130868970
                    requestTime = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"),
                    requestType = "check",
                    userId = dt.Rows[0]["userId"].ToString()
                };

                DataRow dr = dt.Copy().Rows[0];

                //移除部分列
                dt.Columns.Remove("userId");
                //dt.Columns.Remove("billCode");
                dt.Columns.Remove("billDate");
                dt.Columns.Remove("billKind");
                dt.Columns.Remove("empCode");
                dt.Columns.Remove("userCode");
                dt.Columns.Remove("ckUserCode");
                dt.Columns.Remove("remark");
                dt.Columns.Remove("IsOver");

                var data = new
                {
                    billCode = dr["billCode"].ToString(),
                    billDate = dr["billDate"].ToString(),
                    billKind = dr["billKind"].ToString(),
                    empCode = dr["empCode"].ToString(),
                    userCode = dr["userCode"].ToString(),
                    ckUserCode = dr["ckUserCode"].ToString(),
                    remark = dr["remark"].ToString(),
                    list = dt
                };

                entity.data = new List<dynamic> { data };

                postDataActual = JsonConvert.SerializeObject(entity);

                erpMsg = client.Post($"{url}?method=prodin", postDataActual);

                #endregion
            }
            else if (em == WriteBackEnum.TransferStorage || em == WriteBackEnum.TransferConsignSale)
            {
                #region 调拨入库、寄售调拨

                //调用api获取接口
                HttpClientHelper client = new HttpClientHelper();

                U9Bean entity = new U9Bean
                {
                    requestId = "TS" + DateTime.Now.ToString("yyyyMMddHHmmssfff"), //PO202407130868970
                    requestTime = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"),
                    requestType = "add",
                    userId = dt.Rows[0]["userId"].ToString()
                };

                DataRow dr = dt.Copy().Rows[0];

                //移除部分列
                dt.Columns.Remove("userId");
                dt.Columns.Remove("billCode");
                dt.Columns.Remove("billDate");
                dt.Columns.Remove("billKind");
                //dt.Columns.Remove("stockInCode");
                //dt.Columns.Remove("stockOutCode");
                dt.Columns.Remove("userCode");
                dt.Columns.Remove("ckUserCode");
                dt.Columns.Remove("remark");

                var data = new
                {
                    billCode = dr["billCode"].ToString(),
                    billDate = dr["billDate"].ToString(),
                    billKind = dr["billKind"].ToString(),
                    stockInCode = dr["stockInCode"].ToString(),
                    stockOutCode = dr["stockOutCode"].ToString(),
                    userCode = dr["userCode"].ToString(),
                    ckUserCode = dr["ckUserCode"].ToString(),
                    remark = dr["remark"].ToString(),
                    list = dt
                };

                entity.data = new List<dynamic> { data };

                postDataActual = JsonConvert.SerializeObject(entity);

                erpMsg = client.Post($"{url}?method=mtrlinout", postDataActual);

                #endregion
            }
            else if (em == WriteBackEnum.MaterialPrepare)
            {
                #region 领料审核(工单领料、工单补料、委外领料、委外补料、其它领料)

                //调用api获取接口
                HttpClientHelper client = new HttpClientHelper();

                U9Bean entity = new U9Bean
                {
                    requestId = "MP" + DateTime.Now.ToString("yyyyMMddHHmmssfff"), //PO202407130868970
                    requestTime = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"),
                    requestType = "check",
                    userId = dt.Rows[0]["userId"].ToString()
                };

                DataRow dr = dt.Copy().Rows[0];

                //移除部分列
                dt.Columns.Remove("ApplyType");
                dt.Columns.Remove("userId");

                var data = new
                {
                    billCode = dr["billCode"].ToString(),
                    billDate = dr["billDate"].ToString(),
                    ckUserCode = dr["ckUserCode"].ToString(),
                };

                entity.data = new List<dynamic> { data };

                postDataActual = JsonConvert.SerializeObject(entity);

                erpMsg = client.Post($"{url}?method=moout", postDataActual);

                #endregion
            }
            else if (em == WriteBackEnum.MiscellaneousOutStorage)
            {
                #region 杂发单审核（仓库备料的ApplyType=0）

                //调用api获取接口
                HttpClientHelper client = new HttpClientHelper();

                U9Bean entity = new U9Bean
                {
                    requestId = "PR" + DateTime.Now.ToString("yyyyMMddHHmmssfff"), //PO202407130868970
                    requestTime = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"),
                    requestType = "check",
                    userId = dt.Rows[0]["userId"].ToString()
                };

                DataRow dr = dt.Copy().Rows[0];

                //移除部分列
                dt.Columns.Remove("ApplyType");
                dt.Columns.Remove("userId");

                var data = new
                {
                    billCode = dr["billCode"].ToString(),
                    billDate = dr["billDate"].ToString(),
                    ckUserCode = dr["ckUserCode"].ToString(),
                };

                entity.data = new List<dynamic> { data };

                postDataActual = JsonConvert.SerializeObject(entity);

                erpMsg = client.Post($"{url}?method=otherout", postDataActual);

                #endregion
            }
            else if (em == WriteBackEnum.ProductReturn)
            {
                #region 退料审核（生产退料、委外退料）

                //调用api获取接口
                HttpClientHelper client = new HttpClientHelper();

                U9Bean entity = new U9Bean
                {
                    requestId = "PR" + DateTime.Now.ToString("yyyyMMddHHmmssfff"), //PO202407130868970
                    requestTime = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"),
                    requestType = "check",
                    userId = dt.Rows[0]["userId"].ToString()
                };

                DataRow dr = dt.Copy().Rows[0];

                //移除部分列
                dt.Columns.Remove("userId");

                var data = new
                {
                    billCode = dr["billCode"].ToString(),
                    billDate = dr["billDate"].ToString(),
                    ckUserCode = dr["ckUserCode"].ToString(),
                };

                entity.data = new List<dynamic> { data };

                postDataActual = JsonConvert.SerializeObject(entity);

                erpMsg = client.Post($"{url}?method=moback", postDataActual);

                #endregion
            }
            else if (em == WriteBackEnum.SaleExWarehouse)
            {
                #region 销售出货

                //调用api获取接口
                HttpClientHelper client = new HttpClientHelper();

                U9Bean entity = new U9Bean
                {
                    requestId = "SW" + DateTime.Now.ToString("yyyyMMddHHmmssfff"), //PO202407130868970
                    requestTime = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"),
                    requestType = "add",
                    userId = dt.Rows[0]["userId"].ToString()
                };

                DataRow dr = dt.Copy().Rows[0];

                //移除部分列
                dt.Columns.Remove("userId");
                dt.Columns.Remove("billCode");
                dt.Columns.Remove("billDate");
                dt.Columns.Remove("billKind");
                dt.Columns.Remove("userCode");
                dt.Columns.Remove("ckUserCode");
                dt.Columns.Remove("remark");
                var data = new
                {
                    billCode = dr["billCode"].ToString(),
                    billDate = dr["billDate"].ToString(),
                    billKind = dr["billKind"].ToString(),
                    userCode = dr["userCode"].ToString(),
                    ckUserCode = dr["ckUserCode"].ToString(),
                    remark = dr["remark"].ToString(),
                    list = dt
                };

                entity.data = new List<dynamic> { data };

                postDataActual = JsonConvert.SerializeObject(entity);

                erpMsg = client.Post($"{url}?method=saleout", postDataActual);

                #endregion
            }
            else if (em == WriteBackEnum.FormChangeCheck)
            {
                #region 形态转换单审核

                //调用api获取接口
                HttpClientHelper client = new HttpClientHelper();

                U9Bean entity = new U9Bean
                {
                    requestId = "MS" + DateTime.Now.ToString("yyyyMMddHHmmssfff"), //PO202407130868970
                    requestTime = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"),
                    requestType = "check",
                    userId = dt.Rows[0]["userId"].ToString()
                };

                DataRow dr = dt.Copy().Rows[0];

                //移除部分列
                dt.Columns.Remove("userId");

                var data = new
                {
                    billCode = dr["billCode"].ToString(),
                    billDate = dr["billDate"].ToString(),
                    ckUserCode = dr["ckUserCode"].ToString(),
                };

                entity.data = new List<dynamic> { data };

                postDataActual = JsonConvert.SerializeObject(entity);

                erpMsg = client.Post($"{url}?method=mtrlchg", postDataActual);

                #endregion
            }
            else if (em == WriteBackEnum.MaterialMixStorage)
            {
                #region 物料入库（委外采购入库）

                //调用api获取接口
                HttpClientHelper client = new HttpClientHelper();

                U9Bean entity = new U9Bean
                {
                    requestId = "PO" + DateTime.Now.ToString("yyyyMMddHHmmssfff"), //PO202407130868970
                    requestTime = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"),
                    requestType = "add",
                    userId = dt.Rows[0]["userId"].ToString()
                };

                DataRow dr = dt.Copy().Rows[0];

                //移除部分列
                dt.Columns.Remove("IsStorage");
                dt.Columns.Remove("POType");
                dt.Columns.Remove("userId");
                dt.Columns.Remove("billCode");
                dt.Columns.Remove("billDate");
                dt.Columns.Remove("supCode");
                dt.Columns.Remove("deptCode");
                dt.Columns.Remove("stockCode");
                dt.Columns.Remove("userCode");
                dt.Columns.Remove("ckUserCode");
                dt.Columns.Remove("remark");

                var data = new
                {
                    billCode = dr["billCode"].ToString(),
                    billDate = dr["billDate"].ToString(),
                    supCode = dr["supCode"].ToString(),
                    sourceCode = dr["sourceCode"].ToString(),
                    deptCode = dr["deptCode"].ToString(),
                    stockCode = dr["stockCode"].ToString(),
                    userCode = dr["userCode"].ToString(),
                    ckUserCode = dr["ckUserCode"].ToString(),
                    remark = dr["remark"].ToString(),
                    list = dt
                };

                entity.data = new List<dynamic> { data };

                postDataActual = JsonConvert.SerializeObject(entity);

                erpMsg = client.Post($"{url}?method=wwin", postDataActual);

                #endregion
            }
            else if (em == WriteBackEnum.FinishedProductReturnReview)
            {
                #region 销售退货审核（成品退货）

                //调用api获取接口
                HttpClientHelper client = new HttpClientHelper();

                U9Bean entity = new U9Bean
                {
                    requestId = "PO" + DateTime.Now.ToString("yyyyMMddHHmmssfff"), //PO202407130868970
                    requestTime = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"),
                    requestType = "add",
                    userId = dt.Rows[0]["userId"].ToString()
                };

                DataRow dr = dt.Copy().Rows[0];

                //移除部分列
                dt.Columns.Remove("userId");
                dt.Columns.Remove("billCode");
                dt.Columns.Remove("billDate");
                dt.Columns.Remove("ckUserCode");
                var data = new
                {
                    billCode = dr["billCode"].ToString(),
                    billDate = dr["billDate"].ToString(),
                    billKind = "标准销售",
                    userCode = dr["ckUserCode"].ToString(),
                    ckUserCode = dr["ckUserCode"].ToString(),
                    remark = "",
                    list = dt
                };

                entity.data = new List<dynamic> { data };

                postDataActual = JsonConvert.SerializeObject(entity);

                //erpMsg = client.Post($"{url}?method=salereturn", postDataActual);
                erpMsg = client.Post($"{url}?method=saleback", postDataActual);
                #endregion
            }
            else if (em == WriteBackEnum.InventoryList)
            {
                #region 盘点单
                HttpClientHelper client = new HttpClientHelper();

                DataRow dr = dt.Copy().Rows[0];

                // 1. 创建主JSON对象
                JObject mainObj = new JObject();

                // 2. 设置固定字段（根据实际需求调整值）
                mainObj["接口配置编号"] = "直传";
                mainObj["yhbsp_session_uer_UAid"] = "特殊";
                mainObj["配置_OrgID"] = ConfigurationManager.AppSettings["orgID"].ToString(); //"1002407120110785";
                mainObj["配置_orgCode"] = ConfigurationManager.AppSettings["orgCode"].ToString();
                mainObj["配置_UserID"] = ConfigurationManager.AppSettings["userId"].ToString();//"1002508060015704";
                mainObj["配置_EnterpriseID"] = ConfigurationManager.AppSettings["enterpriseID"].ToString();// "001";
                mainObj["配置_CultureName"] = "zh-CN";
                mainObj["配置_DefaultCultureName"] = "zh-CN";
                mainObj["单据类型"] = "InvSheet001";
                mainObj["其他备注"] = "接口创建";
                mainObj["业务日期"] = dr["业务日期"].ToString();

                // 3. 动态构建盘点明细表JSON数组（从DataTable转换）
                JArray detailArray = new JArray();
                if (dt != null && dt.Rows.Count > 0)
                {
                    foreach (DataRow row in dt.Rows)
                    {
                        JObject detailItem = new JObject();
                        detailItem["存储地点编号"] = row["存储地点编号"]?.ToString() ?? "";
                        detailItem["库位编号"] = row["库位编号"]?.ToString() ?? "";
                        detailItem["物料编码"] = row["物料编码"]?.ToString() ?? "";
                        detailItem["批号"] = row["批号"]?.ToString() ?? "";
                        detailItem["实盘数量"] = row["实盘数量"]?.ToString() ?? "";

                        detailArray.Add(detailItem);
                    }
                }
                // 将动态生成的明细数组添加到主对象
                mainObj["盘点明细表"] = detailArray;

                postDataActual = mainObj.ToString(Formatting.Indented);

                erpMsg = client.Post($"{url}", postDataActual);

                #endregion
            }
            return erpMsg;
        }

        /// <summary>
        /// 是否需要回写
        /// </summary>
        /// <param name="em"></param>
        /// <returns></returns>
        public static bool IsWriteBack(WriteBackEnum em)
        {
            string sql = "SELECT ewc.WriteBackFlag FROM ERP_WriteBackConfig ewc WHERE ewc.WriteBackCode = @WriteBackCode";
            var obj = DBHelper.ExecuteScalar(sql, new { WriteBackCode = em.ToString() });
            if (obj == null)
            {
                throw new Exception(string.Format("请先配置{0}回写开关", em.ToString()));
            }
            return string.Equals(obj.ToString(), "1") ? true : false;
        }

        #region 其他不用的方法


        ///// <summary>
        ///// 获取Web.Config ERP回写配置
        ///// </summary>
        ///// <returns></returns>
        //public static string GetERPWriteStringConfig(string erpBusinessName, string acct)
        //{
        //    string ERPWriteString = string.Empty;
        //    string ip = System.Configuration.ConfigurationManager.AppSettings["ERPWriteStringIP"];
        //    string db = System.Configuration.ConfigurationManager.AppSettings["ERPWriteStringDB"];
        //    if (string.IsNullOrWhiteSpace(ip) || string.IsNullOrWhiteSpace(db))
        //    {
        //        throw new Exception("未获取到ERP回写配置信息，请检查config配置");
        //    }
        //    ip = ip.Trim();
        //    db = db.Trim();
        //    acct = System.Text.RegularExpressions.Regex.Replace(acct, @"[^\d]*", "");

        //    var dt = DateTime.Now;
        //    string timeStamp = dt.ToString("yyyyMMddHHmmss") + dt.Millisecond.ToString().PadLeft(3, '0'); // GetTimeStamp();//获取时间戳

        //    ERPWriteString += "<host prod=\"XThirdParty\" ver=\"6.0.0.0\" ip=\"" + ip + "\" id=\"\" lang=\"zh_CN\" timestamp=\"" + timeStamp + "\" acct=\"" + acct + "\" /><service prod=\"E10\" id=\"" + db + "\" name=\"" + erpBusinessName + ".ImportData\" />";

        //    return ERPWriteString;
        //}

        ///// <summary>
        ///// 转义XML特殊字符
        ///// </summary>
        ///// <returns></returns>
        //public static string FormatXMLChar(string str)
        //{
        //    if (!string.IsNullOrWhiteSpace(str))
        //    {
        //        return str.Replace("<", "&lt;").Replace(">", "&gt;").Replace("&", "&amp;").Replace("\"", "&quot;").Replace("'", "&apos;");
        //    }
        //    else
        //    {
        //        return string.Empty;
        //    }
        //} 
        #endregion

        /// <summary>
        /// 回写日志
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public static int AddWriteBackLog(WriteBackLogInfo entity)
        {
            string sql = @"INSERT INTO dbo.ERP_WriteBackLog (WriteBackCode,MD5,ERPResult,ERPNo,ERPMsg,MESMsg,MESBillNo,WriteBackData,WriteBackDataJSON,ReceiveData,CreateBy,CreateDateTime,EnterTime,AfterExecProcTime,AfterExecERPTime) 
                           VALUES 
                           (@WriteBackCode,@MD5,@ERPResult,@ERPNo,@ERPMsg,@MESMsg,@MESBillNo,@WriteBackData,@WriteBackDataJSON,@ReceiveData,@CreateBy,GETDATE(),@EnterTime,@AfterExecProcTime,@AfterExecERPTime)";
            return DBHelper.Execute(sql, entity);
        }

        public static int AddWriteBackLog(IDbConnection conn, WriteBackLogInfo entity)
        {
            string sql = @"INSERT INTO dbo.ERP_WriteBackLog (WriteBackCode,MD5,ERPResult,ERPNo,ERPMsg,MESMsg,MESBillNo,WriteBackData,WriteBackDataJSON,ReceiveData,CreateBy,CreateDateTime,EnterTime,AfterExecProcTime,AfterExecERPTime) 
                           VALUES 
                           (@WriteBackCode,@MD5,@ERPResult,@ERPNo,@ERPMsg,@MESMsg,@MESBillNo,@WriteBackData,@WriteBackDataJSON,@ReceiveData,@CreateBy,GETDATE(),@EnterTime,@AfterExecProcTime,@AfterExecERPTime)";
            return conn.Execute(sql, entity);
        }

        #region DataTable转List

        /// <summary>
        /// DataTable转List
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="table"></param>
        /// <returns></returns>
        public static IList<T> ConvertDataTableToList<T>(DataTable table)
        {
            if (table == null)
            {
                return null;
            }
            List<DataRow> rows = new List<DataRow>();
            foreach (DataRow row in table.Rows)
            {
                rows.Add(row);
            }
            return ConvertTo<T>(rows);
        }

        public static IList<T> ConvertTo<T>(IList<DataRow> rows)
        {
            IList<T> list = null;
            if (rows != null)
            {
                list = new List<T>();
                foreach (DataRow row in rows)
                {
                    T item = CreateItem<T>(row);
                    list.Add(item);
                }
            }
            return list;
        }

        public static T CreateItem<T>(DataRow row)
        {
            T obj = default(T);
            if (row != null)
            {
                obj = Activator.CreateInstance<T>();
                foreach (DataColumn column in row.Table.Columns)
                {
                    PropertyInfo prop = obj.GetType().GetProperty(column.ColumnName);
                    try
                    {
                        object value = row[column.ColumnName];
                        prop.SetValue(obj, value, null);
                    }
                    catch (Exception ex)
                    {
                        throw ex;
                    }
                }
            }
            return obj;
        }

        #endregion


        #region 洲钜调用API获取Token
        ///// <summary>
        ///// 获取Token
        ///// </summary>
        ///// <param name="url"></param>
        ///// <param name="appid"></param>
        ///// <param name="secretkey"></param>
        ///// <returns></returns>
        ///// <exception cref="Exception"></exception>
        //private static string GetToken(string url, string appid, string secretkey)
        //{
        //    string mesMsg = string.Empty;
        //    var tokenJson = string.Empty;
        //    ERPReturnInfo tokenEntity = null;

        //    try
        //    {
        //        var tokenConfig = new ERPTokenConfig() { appid = appid, secretkey = secretkey };
        //        var configJson = JsonConvert.SerializeObject(tokenConfig);

        //        //调用api获取接口
        //        HttpClientHelper client = new HttpClientHelper();
        //        tokenJson = client.Post($"{url}Api/Base/GetToken", configJson);

        //        tokenEntity = JsonConvert.DeserializeObject<ERPReturnInfo>(tokenJson);
        //    }
        //    catch (Exception ex)
        //    {
        //        mesMsg = $"获取Token失败，tokenJson：{tokenJson}，错误消息：{ex.Message}";
        //        throw new Exception(mesMsg);
        //    }

        //    if (tokenEntity == null)
        //    {
        //        mesMsg = "未获取到Token信息";
        //        throw new Exception(mesMsg);
        //    }
        //    if (tokenEntity.Flag != 1)
        //    {
        //        mesMsg = $"获取Token失败，错误码：{tokenEntity.Flag}，错误码说明：{GetERPErrorCode(tokenEntity.Flag)}，消息：{tokenEntity.Msg}";
        //        throw new Exception(mesMsg);
        //    }
        //    if (string.IsNullOrEmpty(tokenEntity.DataOne))
        //    {
        //        mesMsg = $"未获取到Token信息";
        //        throw new Exception(mesMsg);
        //    }

        //    return tokenEntity.DataOne;
        //} 

        ///// <summary>
        ///// 获取错误码对应的消息
        ///// </summary>
        ///// <param name="code"></param>
        ///// <returns></returns>
        //private static string GetERPErrorCode(int code)
        //{
        //    Dictionary<int, string> dir = new Dictionary<int, string>();
        //    dir.Add(1, "请求成功");
        //    dir.Add(0, "异常");
        //    dir.Add(-1, "接口调用失败");
        //    dir.Add(1001, "帐套号为空，无法获取帐套数据库");
        //    dir.Add(1002, "Token失效，请重新登陆获取");
        //    dir.Add(5000, "数据为空");
        //    dir.Add(5001, "帐号不存在");
        //    dir.Add(5002, "操作员密码错误");
        //    dir.Add(5003, "该操作员账号已停用");
        //    dir.Add(5006, "数据库连接失败");
        //    dir.Add(5100, "入库失败，列表(子表/主表)数据为空");
        //    return dir[code];
        //}


        #endregion



        public static MODocCompleteMoResponse CallMODocCompleteMoApi(List<string> docNos)
        {
            var responseObj = new MODocCompleteMoResponse();
            var requestList = new List<MODocCompleteMoRequest>();
            DateTime dtEnterTime = DateTime.Now;
            DateTime? dtAfterExecERPTime = null;
            string responseStr = string.Empty;
            try
            {
                string token = GetU9Token();
                var url = ConfigurationManager.AppSettings["U9ApiUrl_MODoc_CompleteMo"];
                var code = ConfigurationManager.AppSettings["U9OrgCode"];

                if (string.IsNullOrEmpty(url) || string.IsNullOrEmpty(code))
                {
                    throw new Exception("未获取到回写配置URL信息，请检查配置文件");
                }

                foreach (var docNo in docNos)
                {
                    var req = new MODocCompleteMoRequest
                    {
                        OtherID = "",
                        ID = 0,
                        Org = new OrgInfo { ID = 0, Code = code, Name = "" },
                        DocNo = docNo,
                        OperateType = false,
                        OperateResult = true,
                        OperateOn = DateTime.Now.ToString("yyyy-MM-dd"),
                        OperateBy = ""
                    };
                    requestList.Add(req);
                }


                var json = JsonConvert.SerializeObject(requestList);

                var request = (HttpWebRequest)WebRequest.Create(url);
                request.Method = "POST";
                request.ContentType = "application/json";
                request.Headers["token"] = token;

                using (var stream = request.GetRequestStream())
                {
                    var data = Encoding.UTF8.GetBytes(json);
                    stream.Write(data, 0, data.Length);
                }


                using (var response = (HttpWebResponse)request.GetResponse())
                using (var reader = new StreamReader(response.GetResponseStream()))
                {
                    responseStr = reader.ReadToEnd();
                }

                responseObj = JsonConvert.DeserializeObject<MODocCompleteMoResponse>(responseStr);

                dtAfterExecERPTime = DateTime.Now;
            }
            catch (Exception ex)
            {
                dtAfterExecERPTime = DateTime.Now;
                responseObj.ResCode = -1;
                responseObj.ResMsg = "接口调用异常：" + ex.Message;
                responseObj.Exception = ex.ToString();
                responseObj.Data = new List<MODocCompleteMoData>();
            }
            finally
            {
                AddWriteBackLog(new WriteBackLogInfo
                {
                    WriteBackCode = WriteBackEnum.FinishStorage.ToString(),
                    //MD5 = md5,
                    ERPResult = responseObj.ResCode == 0 ? 1 : 0,
                    ERPNo = string.Empty,
                    ERPMsg = responseObj.ResMsg,
                    MESMsg = "打开ERP工单",
                    MESBillNo = string.Join(",", docNos),
                    WriteBackData = JsonConvert.SerializeObject(requestList), //实际回写数据（传给ERP的数据）
                    WriteBackDataJSON = JsonConvert.SerializeObject(requestList),   //数据库返回的DataTable原始数据
                    ReceiveData = responseStr,
                    CreateBy = "ERP",
                    EnterTime = dtEnterTime,
                    AfterExecProcTime = dtEnterTime,
                    AfterExecERPTime = dtAfterExecERPTime
                });
            }
            return responseObj;
        }

        public static U9ApiResponse<T> HttpPostU9Api<T>(WriteBackEnum em, DataTable dt, string billNo, string createBy, DateTime dtEnterTime, DateTime dtAfterExecProcTime) where T : class, new()
        {
            string json = string.Empty;
            var responseObj = new U9ApiResponse<T>();
            DateTime? dtAfterExecERPTime = null;
            string responseStr = string.Empty;
            string ERPMsg = string.Empty;
            try
            {
                string token = GetU9Token();
                var url = ConfigurationManager.AppSettings["U9CUrl"];
                var code = ConfigurationManager.AppSettings["U9OrgCode"];

                if (string.IsNullOrEmpty(url) || string.IsNullOrEmpty(code))
                {
                    throw new Exception("未获取到回写配置URL信息，请检查配置文件");
                }


                if (em == WriteBackEnum.FinishedProductReturnReview)
                {
                    url = url + "/webapi/Receivement/CreateSaleRcvBySrc";

                    var write = new JArray();
                    var mainObject = new JObject();

                    mainObject["sMToRcvDTOs"] = new JArray();
                    mainObject["DocStatus"] = 2;

                    // 获取 sMToRcvDTOs 数组
                    JArray sMToRcvDTOs = (JArray)mainObject["sMToRcvDTOs"];

                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        DataRow row = dt.Rows[i];

                        var item = new JObject
                        {
                            ["BusinessDate"] = row["BusinessDate"]?.ToString() ?? string.Empty,
                            ["TransQty"] = new JObject
                            {
                                ["Amount1"] = Convert.ToDecimal(row["TransQty"] ?? 0)
                            }
                            ,
                            ["SrcDocType"] = Convert.ToInt32(row["SrcDocType"] ?? 8),
                            ["SrcDocNo"] = row["SrcDocNo"]?.ToString() ?? string.Empty,
                            ["SrcLineID"] = row["SrcLineID"]?.ToString() ?? string.Empty,
                            ["SrcDocLineNo"] = row["SrcDocLineNo"]?.ToString() ?? string.Empty,
                            ["ConfirmDate"] = row["BusinessDate"]?.ToString() ?? string.Empty,
                            ["WhCode"] = row["WhCode"]?.ToString() ?? string.Empty,
                            ["StorageType"] = Convert.ToInt32(row["StorageType"] ?? 4),
                            ["RejectMode"] = Convert.ToInt32(row["RejectMode"] ?? 0)
                        };

                        sMToRcvDTOs.Add(item);
                    }
                    write.Add(mainObject);
                    json = JsonConvert.SerializeObject(write);
                }
                else if (em == WriteBackEnum.OtherWarehousing)
                {
                    #region 料把其他入库

                    url = url + "/webapi/MiscRcvTrans/Create";

                    DataRow dr = dt.Copy().Rows[0];

                    JArray mainArray = new JArray();

                    JObject mainObj = new JObject
                    {
                        ["DocTypeCode"] = dr["DocTypeCode"].ToString(),
                        ["BusinessDate"] = dr["BusinessDate"].ToString(),
                        ["BenefitOrgCode"] = code,
                        ["Memo"] = dr["Memo"].ToString(),
                        ["DocStatus"] = Convert.ToInt32(dr["DocStatus"].ToString())
                    };

                    // 组装 MiscRcvLines
                    JArray linesArray = new JArray();
                    JObject lineObj = new JObject
                    {
                        ["ItemInfo"] = new JObject
                        {
                            ["ItemCode"] = dr["ItemCode"].ToString()
                        },
                        ["StoreUOMQty"] = Convert.ToDecimal(dr["StoreUOMQty"].ToString()),
                        ["StoreType"] = dr["StoreType"].ToString(),
                        ["WhCode"] = dr["WhCode"].ToString(),
                        ["WhMan_Code"] = dr["WhMan_Code"].ToString(),
                        ["CostMny"] = Convert.ToInt32(dr["CostMny"].ToString()),
                        ["CostPrice"] = Convert.ToInt32(dr["CostPrice"].ToString()),
                        ["BenefitWhCode"] = dr["BenefitWhCode"].ToString(),
                        ["BenefitOwnerOrg_Code"] = code,
                        ["BenefitOrg_Code"] = code,
                        ["OwnerOrg_Code"] = code,
                        ["BenefitDept_Code"] = dr["BenefitDept_Code"].ToString(),
                        ["Meno"] = dr["Meno"].ToString(),
                        ["IsZeroCost"] = Convert.ToBoolean(dr["IsZeroCost"].ToString()),
                        ["MoDocNo"] = dr["MoDocNo"].ToString(),
                        ["IsTally"] = Convert.ToBoolean(dr["IsTally"].ToString())
                    };
                    linesArray.Add(lineObj);

                    // 添加明细到主对象
                    mainObj["MiscRcvLines"] = linesArray;

                    // 添加主对象到主数组
                    mainArray.Add(mainObj);

                    // 序列化为json字符串
                    json = mainArray.ToString(Formatting.Indented);

                    #endregion
                }
                else if (em == WriteBackEnum.FormChangeCheck)
                {
                    #region 形态转换单审核
                    url = url + "/webapi/TransferForm/Create";
                    DataRow dr = dt.Copy().Rows[0];

                    JArray mainArray = new JArray();

                    JObject mainObj = new JObject
                    {
                        ["TransferFormTransType_Code"] = dr["TransferFormTransType_Code"].ToString(),
                        ["BussinessDate"] = dr["BussinessDate"].ToString(),
                        ["DocStatus"] = Convert.ToInt32(dr["DocStatus"].ToString()),
                        ["DocNo"] = ""
                    };

                    //组装 TransferFormLines
                    JArray linesArray = new JArray();
                    JObject lineObj = new JObject
                    {
                        ["TransferType"] = 0,
                        ["ItemInfo"] = new JObject
                        {
                            ["ItemCode"] = dr["ItemCode"].ToString(),
                        },
                        ["Wh_Code"] = dr["Wh_Code"].ToString(),
                        ["StoreUOMQty"] = Convert.ToDecimal(dr["StoreUOMQty"].ToString()),
                        ["CostUOMQty"] = Convert.ToDecimal(dr["CostUOMQty"].ToString()),
                        //["CostPrice"] = 1,
                        ["IsCostDependent"] = Convert.ToBoolean(dr["IsCostDependent"].ToString()),
                        ["StoreType"] = Convert.ToInt32(dr["StoreType"].ToString()),
                        ["OwnOrg_Code"] = code
                    };

                    // 组装 TransferFormSubLines
                    JArray subLinesArray = new JArray();
                    JObject subLineObj = new JObject
                    {
                        ["TransferType"] = 1,
                        ["ItemInfo"] = new JObject
                        {
                            ["ItemCode"] = dr["TransferItemCode"].ToString(),
                        },
                        ["Wh_Code"] = dr["TransferWh_Code"].ToString(),
                        ["StoreUOMQty"] = Convert.ToDecimal(dr["TransferStoreUOMQty"].ToString()),
                        ["CostUOMQty"] = Convert.ToDecimal(dr["TransferCostUOMQty"].ToString()),
                        //["CostPrice"] = 2.5,
                        ["StoreType"] = Convert.ToInt32(dr["TransferStoreType"].ToString()),
                        ["OwnOrg_Code"] = code
                    };
                    subLinesArray.Add(subLineObj);

                    // 添加子明细到明细
                    lineObj["TransferFormSubLines"] = subLinesArray;

                    // 添加明细到明细数组
                    linesArray.Add(lineObj);

                    // 添加明细数组到主对象
                    mainObj["TransferFormLines"] = linesArray;

                    // 添加主对象到主数组
                    mainArray.Add(mainObj);

                    // 序列化为json字符串
                    json = mainArray.ToString(Formatting.Indented);

                    #endregion
                }

                var request = (HttpWebRequest)WebRequest.Create(url);
                request.Method = "POST";
                request.ContentType = "application/json";
                request.Headers["token"] = token;

                using (var stream = request.GetRequestStream())
                {
                    var data = Encoding.UTF8.GetBytes(json);
                    stream.Write(data, 0, data.Length);
                }
                using (var response = (HttpWebResponse)request.GetResponse())
                using (var reader = new StreamReader(response.GetResponseStream()))
                {
                    responseStr = reader.ReadToEnd();
                }

                #region 测试
                //responseStr = @"{
                //                  ""ResCode"": 0,
                //                  ""Success"": true,
                //                  ""ResMsg"": null,
                //                  ""Data"": [
                //                    {
                //                      ""IsSucess"": false,
                //                      ""U9CVersion"": null,
                //                      ""OtherID"": null,
                //                      ""ID"": 0,
                //                      ""Code"": """",
                //                      ""ErrorMsg"": ""找不到单号SM2025120203行号160的退回处理单行""
                //                    }
                //                  ]
                //                }";


                //responseStr = @"{
                //      ""ResCode"": 0,
                //      ""Success"": true,
                //      ""ResMsg"": null,
                //      ""Data"": [
                //        {
                //          ""IsSucess"": true,
                //          ""U9CVersion"": null,
                //          ""OtherID"": null,
                //          ""ID"": 1002603100000524,
                //          ""Code"": ""RCV2603100002"",
                //          ""ErrorMsg"": null
                //        }
                //      ]
                //    }";
                #endregion

                responseObj = JsonConvert.DeserializeObject<U9ApiResponse<T>>(responseStr);

                dtAfterExecERPTime = DateTime.Now;
                if (responseObj != null && responseObj.Data.Count > 0)
                {
                    var firstObject = responseObj.Data.FirstOrDefault();
                    PropertyInfo isSuccessProperty = firstObject.GetType().GetProperty("IsSucess");
                    ERPMsg = firstObject.GetType().GetProperty("ErrorMsg") != null ? firstObject.GetType().GetProperty("ErrorMsg").GetValue(firstObject)?.ToString() : string.Empty;
                    if (isSuccessProperty != null)
                    {
                        object isSuccessValue = isSuccessProperty.GetValue(firstObject);
                        bool isSuccess = Convert.ToBoolean(isSuccessValue);
                        if (!isSuccess)
                        {
                            responseObj.ResCode = -1;
                        }
                    }
                }

            }
            catch (Exception ex)
            {
                dtAfterExecERPTime = DateTime.Now;
                responseObj.ResCode = -1;
                responseObj.ResMsg = "接口调用异常：" + ex.Message;
                responseObj.Exception = ex.ToString();
                responseObj.Data = new List<T>();
            }
            finally
            {
                AddWriteBackLog(new WriteBackLogInfo
                {
                    WriteBackCode = em.ToString(),
                    //MD5 = md5,
                    ERPResult = responseObj.ResCode == 0 ? 1 : 0,
                    ERPNo = string.Empty,
                    ERPMsg = ERPMsg,
                    MESMsg = string.Empty,
                    MESBillNo = billNo,
                    WriteBackData = json, //实际回写数据（传给ERP的数据）
                    WriteBackDataJSON = JsonConvert.SerializeObject(dt),   //数据库返回的DataTable原始数据
                    ReceiveData = responseStr,
                    CreateBy = "ERP",
                    EnterTime = dtEnterTime,
                    AfterExecProcTime = dtAfterExecProcTime,
                    AfterExecERPTime = dtAfterExecERPTime
                });
            }
            return responseObj;
        }
        public static string GetU9Token()
        {
            var url = ConfigurationManager.AppSettings["U9TokenUrl"];
            var clientId = ConfigurationManager.AppSettings["U9ClientId"];
            var clientSecret = ConfigurationManager.AppSettings["U9ClientSecret"];
            var entCode = ConfigurationManager.AppSettings["U9EntCode"];
            var userCode = ConfigurationManager.AppSettings["U9UserCode"];
            var orgCode = ConfigurationManager.AppSettings["U9OrgCode"];

            // 拼接GET参数
            var query = $"clientid={Uri.EscapeDataString(clientId)}" +
                        $"&clientsecret={Uri.EscapeDataString(clientSecret)}" +
                        $"&entCode={Uri.EscapeDataString(entCode)}" +
                        $"&userCode={Uri.EscapeDataString(userCode)}" +
                        $"&orgCode={Uri.EscapeDataString(orgCode)}";
            var requestUrl = url.Contains("?") ? $"{url}&{query}" : $"{url}?{query}";

            var request = (HttpWebRequest)WebRequest.Create(requestUrl);
            request.Method = "GET";
            request.ContentType = "application/json; charset=utf-8";

            string responseStr;
            using (var response = (HttpWebResponse)request.GetResponse())
            using (var reader = new StreamReader(response.GetResponseStream()))
            {
                responseStr = reader.ReadToEnd();
            }

            // 解析XML，获取<Data>节点内容
            var token = JObject.Parse(responseStr)["Data"]?.ToString();
            if (string.IsNullOrEmpty(token))
                throw new Exception("未获取到Token");
            return token;
        }

    }
}
