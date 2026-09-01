using SKT.Common.DAL.Marshal;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.ProductionCollection.WebService
{
    public class ATEWebService
    {
        #region ATE相关数据检查

        /// <summary>
        /// 检测员工工号信息
        /// </summary>
        /// <param name="empNo"></param>
        /// <returns></returns>
        public string CheckEmployeeNo(string empNo)
        {
            string msg = "";
            bool result = false;
            try
            {
                SqlParameter[] param = new SqlParameter[]
                {
                new SqlParameter("@EmployeeNo",SqlDbType.VarChar),
                new SqlParameter("@Msg",SqlDbType.VarChar,200),
                new SqlParameter("@Result",SqlDbType.Bit)
                };
                param[0].Value = empNo;
                param[1].Value = "";
                param[1].Direction = ParameterDirection.InputOutput;
                param[2].Value = 1;
                param[2].Direction = ParameterDirection.InputOutput;

                SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCheckEmployeeNo", param);

                msg = param[1].Value.ToString();
                result = Convert.ToBoolean(param[2].Value);
            }
            catch (Exception ex)
            {
                if (ex.Message == "DBAccessError")
                {
                    msg = ex.InnerException.Message;
                }
                else
                {
                    msg = ex.Message;
                }
            }
            if (result)
            {
                msg = "OK;";
            }
            else
            {
                msg = "NG;" + msg;
            }
            return msg;
        }

        /// <summary>
        /// 检查SN信息
        /// </summary>
        /// <param name="sn"></param>
        /// <returns></returns>
        public string CheckSerialNumber(string sn)
        {
            string msg = "";
            bool result = false;
            try
            {
                SqlParameter[] param = new SqlParameter[]
                {
                new SqlParameter("@UnitId",SqlDbType.BigInt),
                new SqlParameter("@SerialNumber",SqlDbType.NVarChar),
                new SqlParameter("@IsRepair",SqlDbType.Bit),
                new SqlParameter("@Msg",SqlDbType.VarChar,200),
                new SqlParameter("@Result",SqlDbType.Bit)
                };
                param[0].Value = -1;
                param[1].Value = sn;
                param[2].Value = 1;
                param[3].Value = "";
                param[3].Direction = ParameterDirection.InputOutput;
                param[4].Value = 1;
                param[4].Direction = ParameterDirection.InputOutput;

                SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCheckSerialNumber", param);

                msg = param[3].Value.ToString();
                result = Convert.ToBoolean(param[4].Value);
            }
            catch (Exception ex)
            {
                if (ex.Message == "DBAccessError")
                {
                    msg = ex.InnerException.Message;
                }
                else
                {
                    msg = ex.Message;
                }
            }
            if (result)
            {
                msg = "OK;";
            }
            else
            {
                msg = "NG;" + msg;
            }
            return msg;
        }

        /// <summary>
        /// 检测工号和序列号信息
        /// </summary>
        /// <param name="empNo"></param>
        /// <param name="sn"></param>
        /// <returns></returns>
        public string CheckEmployeeNo_SN(string empNo, string sn)
        {
            string msg = "";
            bool result = false;
            try
            {
                SqlParameter[] param = new SqlParameter[]
                {
                new SqlParameter("@EmployeeNo",SqlDbType.VarChar),
                new SqlParameter("@SN",SqlDbType.VarChar),
                new SqlParameter("@Msg",SqlDbType.VarChar,200),
                new SqlParameter("@Result",SqlDbType.Bit)
                };
                param[0].Value = empNo;
                param[1].Value = sn;
                param[2].Value = "";
                param[2].Direction = ParameterDirection.InputOutput;
                param[3].Value = 1;
                param[3].Direction = ParameterDirection.InputOutput;

                SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCheckEmployeeNo_SN", param);

                msg = param[2].Value.ToString();
                result = Convert.ToBoolean(param[3].Value);
            }
            catch (Exception ex)
            {
                if (ex.Message == "DBAccessError")
                {
                    msg = ex.InnerException.Message;
                }
                else
                {
                    msg = ex.Message;
                }
            }
            if (result)
            {
                msg = "OK;";
            }
            else
            {
                msg = "NG;" + msg;
            }
            return msg;
        }

        /// <summary>
        /// 检测工号和序列号和资源/设备
        /// </summary>
        /// <param name="empNo"></param>
        /// <param name="sn"></param>
        /// <param name="resource"></param>
        /// <returns></returns>
        public string CheckEmployeeNo_SN_Res(string empNo, string sn, string resource)
        {
            string msg = "";
            bool result = false;
            try
            {
                SqlParameter[] param = new SqlParameter[]
                {
                new SqlParameter("@EmployeeNo",SqlDbType.VarChar),
                new SqlParameter("@SN",SqlDbType.VarChar),
                new SqlParameter("@Resource",SqlDbType.VarChar),
                new SqlParameter("@Msg",SqlDbType.VarChar,200),
                new SqlParameter("@Result",SqlDbType.Bit)
                };
                param[0].Value = empNo;
                param[1].Value = sn;
                param[2].Value = resource;
                param[3].Value = "";
                param[3].Direction = ParameterDirection.InputOutput;
                param[4].Value = 1;
                param[4].Direction = ParameterDirection.InputOutput;

                SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCheckEmployeeNo_SN_Res", param);

                msg = param[3].Value.ToString();
                result = Convert.ToBoolean(param[4].Value);
            }
            catch (Exception ex)
            {
                if (ex.Message == "DBAccessError")
                {
                    msg = ex.InnerException.Message;
                }
                else
                {
                    msg = ex.Message;
                }
            }
            if (result)
            {
                msg = "OK;";
            }
            else
            {
                msg = "NG;" + msg;
            }
            return msg;
        }

        /// <summary>
        /// 检测工号和序列号和资源、工序
        /// </summary>
        /// <param name="empNo"></param>
        /// <param name="sn"></param>
        /// <param name="resource"></param>
        /// <param name="station"></param>
        /// <returns></returns>
        public string CheckEmployeeNo_SN_Res_Station(string empNo, string sn, string resource, string station)
        {
            string msg = "";
            bool result = false;
            try
            {
                SqlParameter[] param = new SqlParameter[]
                {
                new SqlParameter("@EmployeeNo",SqlDbType.VarChar),
                new SqlParameter("@SN",SqlDbType.VarChar),
                new SqlParameter("@Resource",SqlDbType.VarChar),
                new SqlParameter("@Station",SqlDbType.VarChar),
                new SqlParameter("@Msg",SqlDbType.VarChar,200),
                new SqlParameter("@Result",SqlDbType.Bit)
                };
                param[0].Value = empNo;
                param[1].Value = sn;
                param[2].Value = resource;
                param[3].Value = station;
                param[4].Value = "";
                param[4].Direction = ParameterDirection.InputOutput;
                param[5].Value = 1;
                param[5].Direction = ParameterDirection.InputOutput;

                SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCheckEmployeeNo_SN_Res_Station", param);

                msg = param[4].Value.ToString();
                result = Convert.ToBoolean(param[5].Value);
            }
            catch (Exception ex)
            {
                if (ex.Message == "DBAccessError")
                {
                    msg = ex.InnerException.Message;
                }
                else
                {
                    msg = ex.Message;
                }
            }
            if (result)
            {
                msg = "OK;";
            }
            else
            {
                msg = "NG;" + msg;
            }
            return msg;
        }

        #endregion

        #region ATE数据保存

        /// <summary>
        /// 检查ATE数据信息，保存测试数据
        /// </summary>
        /// <param name="empNo"></param>
        /// <param name="sn"></param>
        /// <param name="resource"></param>
        /// <param name="station"></param>
        /// <param name="ateData"></param>
        /// <returns></returns>
        public string CollectATEData(string empNo, string sn, string resource, string station, string ateData)
        {
            string msg = "";
            bool result = false;
            try
            {
                SqlParameter[] param = new SqlParameter[]
                {
                new SqlParameter("@EmployeeNo",SqlDbType.VarChar),
                new SqlParameter("@SN",SqlDbType.VarChar),
                new SqlParameter("@Resource",SqlDbType.VarChar),
                new SqlParameter("@Station",SqlDbType.VarChar),
                new SqlParameter("@ATEData",SqlDbType.VarChar),
                new SqlParameter("@Msg",SqlDbType.VarChar,200),
                new SqlParameter("@Result",SqlDbType.Bit)
                };
                param[0].Value = empNo;
                param[1].Value = sn;
                param[2].Value = resource;
                param[3].Value = station;
                param[4].Value = ateData;
                param[5].Value = "";
                param[5].Direction = ParameterDirection.InputOutput;
                param[6].Value = 1;
                param[6].Direction = ParameterDirection.InputOutput;

                SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCollectATEData", param);

                msg = param[5].Value.ToString();
                result = Convert.ToBoolean(param[6].Value);
            }
            catch (Exception ex)
            {
                if (ex.Message == "DBAccessError")
                {
                    msg = ex.InnerException.Message;
                }
                else
                {
                    msg = ex.Message;
                }
            }
            if (result)
            {
                msg = "OK;";
            }
            else
            {
                msg = "NG;" + msg;
            }
            return msg;
        }

        /// <summary>
        /// 更新测试数据的文件信息
        /// </summary>
        /// <param name="empNo"></param>
        /// <param name="sn"></param>
        /// <param name="resource"></param>
        /// <param name="station"></param>
        /// <param name="fileInfo"></param>
        /// <returns></returns>
        public string CollectATEFileInfo(string empNo, string sn, string resource, string station, string fileInfo)
        {
            string msg = "";
            bool result = false;
            try
            {
                SqlParameter[] param = new SqlParameter[]
                {
                new SqlParameter("@EmployeeNo",SqlDbType.VarChar),
                new SqlParameter("@SN",SqlDbType.VarChar),
                new SqlParameter("@Resource",SqlDbType.VarChar),
                new SqlParameter("@Station",SqlDbType.VarChar),
                new SqlParameter("@FileInfo",SqlDbType.VarChar),
                new SqlParameter("@Msg",SqlDbType.VarChar,200),
                new SqlParameter("@Result",SqlDbType.Bit)
                };
                param[0].Value = empNo;
                param[1].Value = sn;
                param[2].Value = resource;
                param[3].Value = station;
                param[4].Value = fileInfo;
                param[5].Value = "";
                param[5].Direction = ParameterDirection.InputOutput;
                param[6].Value = 1;
                param[6].Direction = ParameterDirection.InputOutput;

                SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCollectATEFileInfo", param);

                msg = param[5].Value.ToString();
                result = Convert.ToBoolean(param[6].Value);
            }
            catch (Exception ex)
            {
                if (ex.Message == "DBAccessError")
                {
                    msg = ex.InnerException.Message;
                }
                else
                {
                    msg = ex.Message;
                }
            }
            if (result)
            {
                msg = "OK;";
            }
            else
            {
                msg = "NG;" + msg;
            }
            return msg;
        }

        /// <summary>
        /// 检查ATE数据信息，采集不良记录 并过站
        /// </summary>
        /// <param name="empNo"></param>
        /// <param name="sn"></param>
        /// <param name="resource"></param>
        /// <param name="station"></param>
        /// <param name="ateNcData"></param>
        /// <param name="isPass"></param>
        /// <returns></returns>
        public string CollectATESN(string empNo, string sn, string resource, string station, string ateNcData, bool isPass)
        {
            string msg = "";
            bool result = false;
            try
            {
                SqlParameter[] param = new SqlParameter[]
                {
                new SqlParameter("@EmployeeNo",SqlDbType.VarChar),
                new SqlParameter("@SN",SqlDbType.VarChar),
                new SqlParameter("@Resource",SqlDbType.VarChar),
                new SqlParameter("@Station",SqlDbType.VarChar),
                new SqlParameter("@ATENCData",SqlDbType.VarChar),
                new SqlParameter("@IsPass",SqlDbType.Bit),
                new SqlParameter("@Msg",SqlDbType.VarChar,200),
                new SqlParameter("@Result",SqlDbType.Bit)
                };
                param[0].Value = empNo;
                param[1].Value = sn;
                param[2].Value = resource;
                param[3].Value = station;
                param[4].Value = ateNcData;
                param[5].Value = isPass;
                param[6].Value = "";
                param[6].Direction = ParameterDirection.InputOutput;
                param[7].Value = 1;
                param[7].Direction = ParameterDirection.InputOutput;

                SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCollectATESN", param);

                msg = param[6].Value.ToString();
                result = Convert.ToBoolean(param[7].Value);
            }
            catch (Exception ex)
            {
                if (ex.Message == "DBAccessError")
                {
                    msg = ex.InnerException.Message;
                }
                else
                {
                    msg = ex.Message;
                }
            }
            if (result)
            {
                msg = "OK;";
            }
            else
            {
                msg = "NG;" + msg;
            }
            return msg;
        }

        #endregion

        #region ATE自定义功能

        /// <summary>
        /// ATE自定义功能
        /// </summary>
        /// <param name="commandString"></param>
        /// <returns></returns>
        public string ATECommandCode(string commandString)
        {
            string msg = "";
            bool result = false;

            try
            {
                SqlParameter[] param = new SqlParameter[]
                {
                new SqlParameter("@CommandCode",SqlDbType.VarChar),
                new SqlParameter("@Msg",SqlDbType.VarChar,200),
                new SqlParameter("@Result",SqlDbType.Bit)
                };
                param[0].Value = commandString;
                param[1].Value = "";
                param[1].Direction = ParameterDirection.InputOutput;
                param[2].Value = 1;
                param[2].Direction = ParameterDirection.InputOutput;

                SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "SP_ATE_COMMANDCODE", param);

                msg = param[1].Value.ToString();
                result = Convert.ToBoolean(param[2].Value);
            }
            catch (Exception ex)
            {
                if (ex.Message == "DBAccessError")
                {
                    msg = ex.InnerException.Message;
                }
                else
                {
                    msg = ex.Message;
                }
            }
            //if (result)
            //{
            //    msg = "OK;";
            //}
            //else
            //{
            //    msg = "NG;" + msg;
            //}
            return msg;
        }

        #endregion
    }
}
