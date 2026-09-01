using System;
using System.Collections.Generic;
using System.Web;
using AjaxPro;

using SAP.Middleware.Connector;
using System.Data;
using System.Data.SqlClient;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxSAP
    {

        #region 调RFC函数读取数据到目标数据库
        [AjaxMethod]
        public string APISyncRead(string sapFunc, string sapParams, string sapParamsVal, string sapTabName, string tarTabName, string tarTabFields)
        {
            string result = "";
            string ecode = "O_CODE"; //SAP RFC函数消息代码，如果没有可以赋空值""
            string emsg = "O_MSG";   //SAP RFC函数返回消息，如果没有可以赋空值""

            try
            {
                result = SKT.API.SAPRFC.ReadToDB(sapFunc, sapParams, sapParamsVal, sapTabName, tarTabName, tarTabFields, GetRfcrep(), GetDBConn(), ref ecode, ref emsg);
            }
            catch (Exception ex)
            {
                result = ex.Message;
            }

            /*保存同步日志*/
            SaveLog(sapFunc, sapParams, sapParamsVal, ecode, emsg, result);

            return result;
        }
        #endregion


        #region 调RFC函数回写数据到SAP
        [AjaxMethod]
        public string APISyncWrite(string sapFunc, string sapParams, string sapParamsVal)
        {
            string result = "";
            string ecode = "O_CODE"; //SAP RFC函数消息代码，如果没有可以赋空值""
            string emsg = "O_MSG";   //SAP RFC函数返回消息，如果没有可以赋空值""

            try
            {
                RfcDestination rfcDestion = GetRfcrep();

                result = SKT.API.SAPRFC.WriteToSAP(sapFunc, sapParams, sapParamsVal, rfcDestion, ref ecode, ref emsg);
            }
            catch (Exception ex)
            {
                result = ex.Message;
            }

            SaveLog(sapFunc, sapParams, sapParamsVal, ecode, emsg, result);

            return result;
        }
        #endregion


        /// <summary>
        /// add by Hanson.Lei on 2016.12.22
        /// </summary>
        /// <param name="sapFunc"></param>
        /// <param name="sapParams"></param>
        /// <param name="sapParamsVal"></param>
        /// <param name="RetResult"></param>
        /// <returns></returns>
        public bool ExecRfcFunction(string sapFunc, string sapParams, string sapParamsVal,
            Func<IRfcFunction, bool> RetResult = null)
        {
            bool blResult = false;
            string retResult = string.Empty;
            try
            {
                RfcDestination dest = GetRfcrep();
                RfcRepository rfcrep = dest.Repository;
                IRfcFunction rfcfn = rfcrep.CreateFunction(sapFunc);

                string[] keys = sapParams.Split(',');
                string[] values = sapParamsVal.Split(',');

                for (int i = 0; i < keys.Length; i++)
                    rfcfn.SetValue(keys[i], values[i]);

                rfcfn.Invoke(dest);

                /*返回值逻辑处理*/
                if (RetResult != null)
                    blResult = RetResult(rfcfn);
            }
            catch (Exception ex)
            {
                retResult = ex.Message;
            }
            finally
            {
                SaveLog(sapFunc, sapParams, sapParamsVal, "无", "无", retResult);
            }
            return blResult;
        }

        #region 检查SAP连接
        [AjaxMethod]
        public string CheckSapConn(string host, string client, string user, string pwd, string sysNum, string lang)
        {
            string result = "";
            try
            {
                SKT.API.SAPRFC.CheckConn(host, client, user, pwd, sysNum, lang);
            }
            catch (Exception ex)
            {
                result = ex.Message;
            }

            return result;
        }
        #endregion


        #region 检查目标库连接
        [AjaxMethod]
        public string CheckMesConn(string server, string user, string pwd, string dbname, string timeout)
        {
            string result = "";
            try
            {
                using (SqlConnection conn = new SqlConnection("server=" + server + ";uid=" + user + ";pwd=" + pwd + ";database=" + dbname + ";timeout=" + timeout + ""))
                {
                    conn.Open();
                }
            }
            catch (Exception ex)
            {
                result = ex.Message;
            }

            return result;
        }
        #endregion


        #region 创建RFC连接
        private RfcDestination GetRfcrep()
        {
            List<AJAXdataHelper.EntityInfo> list = (new AJAXdataHelper.AjaxHelper()).Search("iWT6BjVEZVzuPa5Ku12rVzqq13LQ04nJ", "59Re+XIyDOk=", "xC6Z47clZpIj+CZBODaWEGIE32GJIYGmJholinu0qq8MXf62QTi+AH5+w2yBISWqDaJFjjpv3v1otrriH8EVtnFTOZPs8Oxwhtoaik8KLEIb8g0qqoZsIQ==", "yy6rAkwTOTXCL1IA0vMsYA==", "+rp516xMJ2A=", SKT.Common.DAL.Marshal.SQLHelper.MESConnString);
            AJAXdataHelper.EntityInfo entity = list[0];

            RfcDestination dest = SKT.API.SAPRFC.GetConn(entity.Field1.ToString(), entity.Field2.ToString(), entity.Field3.ToString(), entity.Field4.ToString(), entity.Field5.ToString(), entity.Field6.ToString());

            return dest;
        }
        #endregion


        #region 创建目标库连接
        private SqlConnection GetDBConn()
        {
            List<AJAXdataHelper.EntityInfo> list = (new AJAXdataHelper.AjaxHelper()).Search("iWT6BjVEZVzuPa5Ku12rVzqq13LQ04nJ", "59Re+XIyDOk=", "g0Av8/IDFwzMmMhY8YDVLwNV93u7fx6ztHuR2PlYz+f7nNDtyfzWiZurHltYasiN1m5cJisZCPhJThE/yi40X8Ocy2I6zRiJpfg+zqIbqZY=", "yy6rAkwTOTXCL1IA0vMsYA==", "+rp516xMJ2A=", SKT.Common.DAL.Marshal.SQLHelper.MESConnString);
            AJAXdataHelper.EntityInfo entity = list[0];

            string connStr = "server=" + entity.Field1 + ";uid=" + entity.Field2 + ";pwd=" + entity.Field3 + ";database=" + entity.Field4 + ";timeout=" + entity.Field5 + "";
            SqlConnection conn = new SqlConnection(connStr);

            return conn;
        }
        #endregion


        #region 保存RFC函数调用日志
        private void SaveLog(string FuncName, string ParamName, string ParamValue, string SapCode, string SapMsg, string MesMsg)
        {
            try
            {
                string sql = "INSERT INTO [SAP_Execlog]([FuncName],[ParamName],[ParamValue],[SapCode] ,[SapMsg] ,[MesMsg] ,[ExecUser] )VALUES('" + FuncName + "','" + ParamName + "','" + ParamValue + "','" + SapCode + "','" + SapMsg + "','" + MesMsg + "','Admin')";

                using (SqlConnection conn = new SqlConnection(SKT.Common.DAL.Marshal.SQLHelper.MESConnString))
                {
                    SqlCommand cmd = new SqlCommand(sql, conn);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
            catch { }
        }
        #endregion



        [AjaxMethod]
        public void APIEdit(SKT.LeanMES.Synchronization.Model.APIInfo entity)
        {
            try
            {
                new SKT.LeanMES.Synchronization.BLL.API().Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
    }
}