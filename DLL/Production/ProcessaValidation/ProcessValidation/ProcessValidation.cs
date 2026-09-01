using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using System.Data;
using SKT.Common.DAL.Marshal;

namespace SKT.LeanMES.Process
{
    /// <summary>
    /// 流程验证以下逻辑：
    /// 1.序列号验证：是否存在；
    /// 2.Unit状态是否正常：Wip，Complete,Scrapped,OnHold.只有Wip状态下才可扫描；
    /// 3.操作工位是否正确；
    /// 4.路由是否正常；
    /// 5.产品状态是否正常；
    /// 6.工单状态是否正常；
    /// 7.产品Certification验证；
    /// </summary>
    public class ProcessValidation
    {        
        /// <summary>
        /// 操作界面传入序列号SN和操作工位ID，验证改序号流程是否正常
        /// </summary>
        /// <param name="strSN">产品序列号</param>
        /// <param name="OpeID">操作工位ID</param>
        /// <param name="UserID">操作员ID</param>
        /// <param name="ResID">资源ID</param>
        /// <returns>
        ///     0：正常；
        ///     1: 无工位操作资格；
        ///     2：无资源使用资格；
        ///     3：序号不存在；
        ///     4：Unit状态不正确；
        ///     5：关联的路由状态不正常；
        ///     6：所选工位不正确；
        ///     7：产品状态不正常；
        ///     8：工单状态不正常；
        ///     9：无产品操作资格
        /// </returns>
        public int SNProcessValidate(string strSN, int OpeID, int UserID, int ResID)
        {
            int blResult = 0;
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SN",SqlDbType.VarChar,50),
                new SqlParameter("@UserID",SqlDbType.Int),
                new SqlParameter("@OpeID",SqlDbType.Int),
                new SqlParameter("@ResID",SqlDbType.Int),
                new SqlParameter("@Result",SqlDbType.Int)
            };

            parms[0].Value = strSN;
            parms[1].Value = UserID;
            parms[2].Value = OpeID;
            parms[3].Value = ResID;
            parms[4].Value = blResult;
            parms[4].Direction = ParameterDirection.InputOutput;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspUnitProcessValidationBySN", parms);
            return (int)parms[4].Value;
        }
        #region 仅限于彩盒包装工位验证
        /// <summary>
        /// 彩盒包装工位验证
        /// </summary>
        /// <param name="strSN"></param>
        /// <param name="OpeID"></param>
        /// <param name="UserID"></param>
        /// <param name="ResID"></param>
        /// <returns></returns>
        public int SNColorPackValidate(string strSN, int OpeID, int UserID, int ResID)
        {
            int blResult = 0;
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SN",SqlDbType.VarChar,50),
                new SqlParameter("@UserID",SqlDbType.Int),
                new SqlParameter("@OpeID",SqlDbType.Int),
                new SqlParameter("@ResID",SqlDbType.Int),
                new SqlParameter("@Result",SqlDbType.Int)
            };

            parms[0].Value = strSN;
            parms[1].Value = UserID;
            parms[2].Value = OpeID;
            parms[3].Value = ResID;
            parms[4].Value = blResult;
            parms[4].Direction = ParameterDirection.InputOutput;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspUnitColorPackValidationBySN", parms);
            return (int)parms[4].Value;
        } 
        #endregion

        #region 暂不使用，以后要用再开启 Alen 2015-07-15
        /// <summary>
        /// 操作界面传入序列号SN、工单ID、路由ID
        /// </summary>
        /// <param name="strSN"></param>
        /// <param name="OrderID"></param>
        /// <param name="UserID"></param>
        /// <param name="RouterID"></param>
        /// <returns>0：正常；
        /// </returns>
        public int UnitBindRMAOrder(string strSN, int OrderID, int UserID, int RouterID, int resId, string dipType)
        {
            int blResult = 0;
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SN",SqlDbType.VarChar,50),
                new SqlParameter("@userID",SqlDbType.Int),
                new SqlParameter("@R_ID",SqlDbType.Int),
                new SqlParameter("@prodOrderID",SqlDbType.Int),
                new SqlParameter("@ResId",SqlDbType.Int),
                new SqlParameter("@DIPType",SqlDbType.VarChar,20),
                new SqlParameter("@Result",SqlDbType.Int)
            };

            parms[0].Value = strSN;
            parms[1].Value = UserID;
            parms[2].Value = RouterID;
            parms[3].Value = OrderID;
            parms[4].Value = resId;
            parms[5].Value = dipType;
            parms[6].Value = blResult;
            parms[6].Direction = ParameterDirection.InputOutput;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "UnitBindRMAOrder", parms);
            return (int)parms[6].Value;
        }
        #endregion

        /// <summary>
        /// 扫描完成后最后执行的操作
        /// </summary>
        /// <param name="UnitID"></param>
        /// <param name="OpeID"></param>
        /// <param name="IsPass"></param>
        /// <param name="LineID"></param>
        /// <param name="UserID"></param>
        /// <param name="ResID"></param>
        /// <param name="EnterTime"></param>
        /// <param name="LoopCount"></param>
        /// <param name="Qty"></param>
        public void UnitComplete(Int64 UnitID, int OpeID, bool IsPass, int LineID, int UserID, int ResID, DateTime EnterTime)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@UnitID",SqlDbType.BigInt),
                new SqlParameter("@OpeID",SqlDbType.Int),
                new SqlParameter("@IsPass",SqlDbType.Bit),
                new SqlParameter("@LineID",SqlDbType.Int),
                new SqlParameter("@UserID",SqlDbType.Int),
                new SqlParameter("@ResID",SqlDbType.Int),
                new SqlParameter("@EnterTime",SqlDbType.DateTime)                
            };

            parms[0].Value = UnitID;
            parms[1].Value = OpeID;
            parms[2].Value = IsPass;
            parms[3].Value = LineID;
            parms[4].Value = UserID;
            parms[5].Value = ResID;
            parms[6].Value = EnterTime;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspUnitComplete", parms);

        }

        /// <summary>
        /// 获取序列号状态
        /// </summary>
        /// <param name="SerialNumber">序列号</param>
        /// <returns>WIP;COMPLETE;SCRAPPED;ONHOLD</returns>
        public string GetUnitStatus(string SerialNumber)
        {
            string strStatus = "";
            /*Modify By Alen Liu 2015-07-15
            string strSQL;
            DataSet ds = new DataSet();
            SqlConnection sqlConn = new SqlConnection(SQLHelper.MESConnString);
            strSQL = "select StatusID from UNIT u inner join SERIAL_NUMBER s on s.UID=u.UID where s.Value='" + SerialNumber + "'";
            SqlCommand sqlCmd = new SqlCommand(strSQL, sqlConn);
            SqlDataAdapter adapt = new SqlDataAdapter(sqlCmd);
            adapt.Fill(ds);
            */
            SqlParameter[] parms = new SqlParameter[] { 
                new SqlParameter("@SerialNumber",SqlDbType.VarChar,50)
            };

            parms[0].Value = SerialNumber;

            string cmdText = "select StatusID from Prod_Unit u inner join Prod_SerialNumber s on s.UID = u.UID where s.Value = @SerialNumber ";

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderSqlText(SQLHelper.MESConnString, cmdText, parms))
            {
                if (rdr.Read())
                {
                    switch (rdr.GetInt32(0))
                    {
                        case 1:
                            strStatus = "WIP";
                            break;
                        case 2:
                            strStatus = "COMPLETE";
                            break;
                        case 3:
                            strStatus = "SCRAPPED";
                            break;
                        case 4:
                            strStatus = "ONHOLD";
                            break;
                        default:
                            break;
                    }
                }
                
                rdr.Close();
            }

            /*Modify By Alen Liu 2015-07-15
            if (ds == null || ds.Tables[0].Rows.Count == 0)
            {
                strStatus = "";
                return strStatus;
            }
            else
            {
                switch (Int64.Parse(ds.Tables[0].Rows[0][0].ToString()))
                {
                    case 1:
                        strStatus = "WIP";
                        break;
                    case 2:
                        strStatus = "COMPLETE";
                        break;
                    case 3:
                        strStatus = "SCRAPPED";
                        break;
                    case 4:
                        strStatus = "ONHOLD";
                        break;
                    default:
                        break;
                }
            }
             * */
            return strStatus;
        }

        /// <summary>
        /// 获取序列号状态
        /// </summary>
        /// <param name="UnitID">序列号ID</param>
        /// <returns>WIP;COMPLETE;SCRAPPED;ONHOLD</returns>
        public string GetUnitStatus(Int64 UnitID)
        {
            string strStatus = "";

            SqlParameter[] parms = new SqlParameter[] { 
                new SqlParameter("@UnitId",SqlDbType.BigInt)
            };

            parms[0].Value = UnitID;

            string cmdText = "select StatusID from UNIT where UID = @UnitId";

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderSqlText(SQLHelper.MESConnString, cmdText, parms))
            {
                if (rdr.Read())
                {
                    switch (rdr.GetInt64(0))
                    {
                        case 1:
                            strStatus = "WIP";
                            break;
                        case 2:
                            strStatus = "COMPLETE";
                            break;
                        case 3:
                            strStatus = "SCRAPPED";
                            break;
                        case 4:
                            strStatus = "ONHOLD";
                            break;
                        default:
                            break;
                    }
                }
                rdr.Close();
            }

            /*Modify By Alen Liu 2015-07-15
            string strSQL;
            DataSet ds = new DataSet();
            SqlConnection sqlConn = new SqlConnection(SQLHelper.MESConnString);
            strSQL = "select StatusID from UNIT where UID=" + UnitID;
            SqlCommand sqlCmd = new SqlCommand(strSQL, sqlConn);
            SqlDataAdapter adapt = new SqlDataAdapter(sqlCmd);
            adapt.Fill(ds);
            if (ds == null || ds.Tables[0].Rows.Count == 0)
            {
                strStatus = "";
                return strStatus;
            }
            else
            {
                switch (Int64.Parse(ds.Tables[0].Rows[0][0].ToString()))
                {
                    case 1:
                        strStatus = "WIP";
                        break;
                    case 2:
                        strStatus = "COMPLETE";
                        break;
                    case 3:
                        strStatus = "SCRAPPED";
                        break;
                    case 4:
                        strStatus = "ONHOLD";
                        break;
                    default:
                        break;
                }
            }*/
            return strStatus;
        }

        /// <summary>
        /// 得到数据库时间
        /// </summary>
        /// <returns></returns>
        public DateTime getDBDateTime()
        {
            SqlParameter[] parms = new SqlParameter[]{                
                new SqlParameter("@Datetime",SqlDbType.DateTime)                
            };

            parms[0].Direction = ParameterDirection.Output;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspGetDBDateTime", parms);

            return (DateTime)parms[0].Value;
        }
    }       
}
