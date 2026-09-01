using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using System.Data.SqlClient;
using System.Data;

namespace SKT.LeanMES.WebService.BLL
{

    public class BasalWebService
    {
        /// <summary>
        /// 检查用户是否存在,状态是否可用
        /// </summary>
        /// <param name="userName">用户登入名</param>
        /// <param name="Result">检查返回的结果</param>
        /// <param name="ErrorMsg">检查返回的消息</param>
        public void UserVoid(string userName, out bool Result, out string ErrorMsg)
        {
            Result = true; ErrorMsg = "";
            try
            {
                SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@UserId",SqlDbType.Int),
                    new SqlParameter("@UserName", SqlDbType.NVarChar, 50),
                    new SqlParameter("@Msg", SqlDbType.VarChar, 200),
                    new SqlParameter("@Result", SqlDbType.Bit)
                };
                parms[0].Value = -1;
                parms[1].Value = userName;
                parms[2].Value = ErrorMsg;
                parms[2].Direction = ParameterDirection.InputOutput;
                parms[3].Value = Result;
                parms[3].Direction = ParameterDirection.InputOutput;

                SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCheckUser", parms);

                Result = Convert.ToBoolean(parms[3].Value);
                ErrorMsg = parms[2].Value.ToString();
            }
            catch (Exception ex)
            {
                Result = false;
                ErrorMsg = ex.Message;
            }
        }

        /// <summary>
        /// 测试SN过站前检查
        /// </summary>
        /// <param name="Barcode">序列号</param>
        /// <param name="StationName">工位号</param>
        /// <param name="RscName">资源名称</param>
        /// <param name="IsMultiPlate">是否多板</param>
        /// <param name="Result">检查返回的结果</param>
        /// <param name="ErrorMsg">检查返回的消息</param>
        public void UnitCompleteValid(string Barcode, string StationName, string RscName, string UserName, bool IsMultiPlate, out bool Result, out string ErrorMsg)
        {
            Result = true; ErrorMsg = "";
            try
            {
                SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@Barcode",SqlDbType.NVarChar,100),
                    new SqlParameter("@StationName", SqlDbType.NVarChar, 50),
                    new SqlParameter("@RscName",SqlDbType.NVarChar,40),
                    new SqlParameter("@UserName",SqlDbType.NVarChar,20),
                    new SqlParameter("@IsMultiPlate", SqlDbType.Bit),
                    new SqlParameter("@Result", SqlDbType.Bit),
                    new SqlParameter("@ErrorMsg", SqlDbType.NVarChar,200)
                };
                parms[0].Value = Barcode;
                parms[1].Value = StationName;
                parms[2].Value = RscName;
                parms[3].Value = UserName;
                parms[4].Value = IsMultiPlate;
                parms[5].Value = Result;                
                parms[5].Direction = ParameterDirection.InputOutput;
                parms[6].Value = ErrorMsg;
                parms[6].Direction = ParameterDirection.InputOutput;
                SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCheckWSInputData", parms);

                Result = Convert.ToBoolean(parms[5].Value);
                ErrorMsg = parms[6].Value.ToString();
            }
            catch (Exception ex)
            {
                Result = false;
                ErrorMsg = ex.Message;
            }
        }

        public void WSBarcodeComplete(string Barcode, string StationName, string RscName, bool IsMultiPlate, bool IsPass,
            string DefectCode, string TestDataXml, string UserName, out bool Result, out string ErrorMsg)
        {
            Result = true; ErrorMsg = "";
            try
            {
                SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@Barcode",SqlDbType.NVarChar,100),
                    new SqlParameter("@StationName", SqlDbType.NVarChar, 50),
                    new SqlParameter("@RscName",SqlDbType.NVarChar,40),
                    new SqlParameter("@IsMultiPlate", SqlDbType.Bit),
                    new SqlParameter("@IsPass", SqlDbType.Bit),
                    new SqlParameter("@DefectCode", SqlDbType.NVarChar,50),
                    new SqlParameter("@TestDataXml", SqlDbType.Xml),
                    new SqlParameter("@UserName", SqlDbType.NVarChar,50),
                    new SqlParameter("@Result", SqlDbType.Bit),
                    new SqlParameter("@ErrorMsg", SqlDbType.NVarChar,200)
                };
                parms[0].Value = Barcode;
                parms[1].Value = StationName;
                parms[2].Value = RscName;
                parms[3].Value = IsMultiPlate;
                parms[4].Value = IsPass;
                parms[5].Value = DefectCode;
                using (System.IO.TextReader trdXml = new System.IO.StringReader(TestDataXml))
                {
                    using (System.Xml.XmlTextReader rdr = new System.Xml.XmlTextReader(trdXml))
                    {
                        System.Data.SqlTypes.SqlXml sqlXml = new System.Data.SqlTypes.SqlXml(rdr);
                        parms[6].Value = sqlXml;
                    }
                }
                parms[7].Value = UserName;
                parms[8].Value = Result;
                parms[8].Direction = ParameterDirection.InputOutput;
                parms[9].Value = ErrorMsg;
                parms[9].Direction = ParameterDirection.InputOutput;

                SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspWSBarcodeComplete", parms);

                Result = Convert.ToBoolean(parms[8].Value);
                ErrorMsg = parms[9].Value.ToString();
            }
            catch (Exception ex)
            {
                Result = false;
                ErrorMsg = ex.Message;
            }
        }
    }
}
