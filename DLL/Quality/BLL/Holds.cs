using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SKT.LeanMES.Quality.Model;
using System.Data.SqlClient;
using System.Data;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using System.Text.RegularExpressions;

namespace SKT.LeanMES.Quality.BLL
{
    public class Hold
    {
        private Int32 recordCount = 0;

        /// <summary>
        /// Hold  Or UnHold
        /// </summary>
        /// <param name="objectNO"></param>
        /// <param name="objectFlag">1 工单， 2 产品 ，3 物料， 4 在制品</param>
        /// <param name="causeDescription"></param>
        /// <param name="userName"></param>
        /// <param name="tag">1 Hold 2 UnHold</param>
        /// <returns></returns>
        public HoldInfo ObjectHoldOrUnHold(string objectNO, int objectFlag, string causeDescription, string userName, int tag)
        {
            HoldInfo model = new HoldInfo();

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ObjectNO", SqlDbType.NVarChar, 500),
                new SqlParameter("@ObjectFlag", SqlDbType.Int),
                new SqlParameter("@CauseDescription", SqlDbType.NVarChar, 500),
                new SqlParameter("@User", SqlDbType.VarChar, 20),
                new SqlParameter("@Tag", SqlDbType.Int)
            };

            parms[0].Value = objectNO;
            parms[1].Value = objectFlag;
            parms[2].Value = causeDescription;
            parms[3].Value = userName;
            parms[4].Value = tag;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspHoldOrUnHold", parms))
            {
                if (rdr.HasRows)
                {
                    rdr.Read();

                    model.ObjectName = rdr.GetString(0);
                    model.ObjectCode = rdr.GetString(1);
                    model.OperatePerson = rdr.GetString(2);
                    model.OperateDateTime = rdr.GetDateTime(3);
                }

                rdr.Close();
            }

            return model;
        }



        /// <summary>
        /// 分页获取 WarnSettings 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="warnSettingsCount">warnSettings 总数。</param>
        /// <returns>WarnSettings 列表。</returns>
        public List<HoldInfo> GetHistoryAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<HoldInfo> list = new List<HoldInfo>();
            HoldInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwHoldAndUnHoldHistory", "HistoryId",
                "[HistoryId], [OperateType], [ObjectType], [ObjectName], [ObjectCode], [OperatePerson], [OperateDateTime], [Remark], [HoldOrUnHoldCause]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new HoldInfo();
                    entity.HistoryId = rdr.GetInt32(0);
                    entity.OperateType = rdr.GetString(1);
                    entity.ObjectName = rdr.GetString(3);
                    entity.ObjectCode = rdr.GetString(4);
                    entity.OperatePerson = rdr.GetString(5);
                    entity.OperateDateTime = rdr.GetDateTime(6);
                    entity.Remark = rdr.GetString(7);
                    entity.HoldOrUnHoldCause = rdr.GetString(8);

                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="xml">导入的xml</param>
        /// <param name="objectFlag">4在制品</param>
        /// <param name="userName"></param>
        /// <param name="tag">1=QHold</param>
        /// <returns></returns>
        public List<HoldInfo> ObjectHoldOrUnHold(string xml, int objectFlag, string userName, int tag, out string msg1, out string msg2)
        {
            msg1 = "";
            msg2 = "";
            List<HoldInfo> list = new List<HoldInfo>();
            try
            {
                SqlParameter[] parms = new SqlParameter[]{
                                new SqlParameter("@xml", SqlDbType.NVarChar),
                                new SqlParameter("@objectFlag", SqlDbType.Int),
                                new SqlParameter("@userName", SqlDbType.NVarChar),
                                new SqlParameter("@tag", SqlDbType.Int),
                                new SqlParameter("@msg1", SqlDbType.VarChar, 200),
                                new SqlParameter("@msg2", SqlDbType.VarChar, 200),
                                };
                parms[0].Value = xml;
                parms[1].Value = objectFlag;
                parms[2].Value = userName;
                parms[3].Value = tag;
                parms[4].Value = msg1;
                parms[4].Direction = ParameterDirection.InputOutput;
                parms[5].Value = msg2;
                parms[5].Direction = ParameterDirection.InputOutput;
                using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspImportQHold", parms))
                {
                    while (rdr.Read())
                    {
                        HoldInfo model = new HoldInfo();
                        model.ObjectName = rdr.GetString(0);
                        model.ObjectCode = rdr.GetString(1);
                        model.OperatePerson = rdr.GetString(2);
                        model.OperateDateTime = rdr.GetDateTime(3);
                        list.Add(model);
                    }

                }
                HoldInfo model2 = new HoldInfo();
                model2.Msg1 = parms[4].Value.ToString();
                model2.Msg2 = parms[5].Value.ToString();
                list.Add(model2);
            }
            catch (Exception)
            {

                throw;
            }

            return list;
        }

        #region UnQHold 导入
        /// <summary>
        /// 批量保存UnQHold
        /// </summary>
        /// <returns></returns>
        public List<HoldInfo> SaveImportUnHold(string objectNO, int objectFlag, string userName, int tag, string fileName)
        {
            List<HoldInfo> list = new List<HoldInfo>();
            SqlParameter[] parms = new SqlParameter[]{
                                new SqlParameter("@objectNO", SqlDbType.NVarChar),
                                new SqlParameter("@objectFlag", SqlDbType.Int),
                                new SqlParameter("@userName", SqlDbType.NVarChar),
                                new SqlParameter("@tag", SqlDbType.Int),
                                new SqlParameter("@fileName", SqlDbType.NVarChar)
                                };

            parms[0].Value = objectNO;
            parms[1].Value = objectFlag;
            parms[2].Value = userName;
            parms[3].Value = tag;
            parms[4].Value = fileName;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspImportUnHold", parms))
            {
                while (rdr.Read())
                {
                    HoldInfo model = new HoldInfo();
                    model.ObjectName = rdr.GetString(0);
                    model.ObjectCode = rdr.GetString(1);
                    model.OperatePerson = rdr.GetString(2);
                    model.OperateDateTime = rdr.GetDateTime(3);
                    list.Add(model);
                }
            }
            return list;
        }
        #endregion

        #region 查询物料条码信息
        /// <summary>
        /// 查询物料条码信息
        /// </summary>
        /// <param name="itemcode"></param>
        /// <param name="datecode"></param>
        /// <param name="lotcode"></param>
        /// <param name="vendorcode"></param>
        /// <returns></returns>
        public List<HoldInfo> GetQueryGRN(string itemcode, string datecode, string lotcode, string vendorcode)
        {
            List<HoldInfo> list = new List<HoldInfo>();
            HoldInfo entity = null;
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@ItemCode",SqlDbType.VarChar,50),
                  new SqlParameter("@DateCode",SqlDbType.VarChar,50),
                  new SqlParameter("@LotCode",SqlDbType.VarChar,50),
                  new SqlParameter("@VendorCode",SqlDbType.VarChar,100)
            };
            parms[0].Value = itemcode;
            parms[1].Value = datecode;
            parms[2].Value = lotcode;
            parms[3].Value = vendorcode;
            using (DataTable dt = SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "uspGetGRNInfo", parms))
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    entity = new HoldInfo();
                    entity.SerialNumber = dt.Rows[i]["SerialNumber"].ToString();
                    entity.States = dt.Rows[i]["States"].ToString();
                    entity.ErrorMessage = dt.Rows[i]["ErrorMessage"].ToString();
                    entity.SignId = int.Parse(dt.Rows[i]["SignId"].ToString());
                    list.Add(entity);
                }
            }
            return list;
        }
        #endregion

        #region 保存导入QHold的GRN信息
        /// <summary>
        /// 保存导入QHold的GRN信息
        /// </summary>
        /// <param name="GRNList"></param>
        /// <param name="UserName"></param>
        public void SaveImportGRN(String GRNList, string UserName)
        {
            DataTable dt = JsonToDataTable(GRNList);
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@UserName",SqlDbType.VarChar,20),
                new SqlParameter("@QHoldGrnList",SqlDbType.Structured)
            };
            parms[0].Value = UserName;
            parms[1].Value = dt;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSaveQHoldGrn", 2000000, parms);
        }
        #endregion

        #region 校验导入QHold的GRN是否合格
        /// <summary>
        /// 校验导入QHold的GRN是否合格
        /// </summary>
        /// <param name="dt"></param>
        public List<HoldInfo> VerifyQHoldGrn(DataTable dt)
        {
            List<HoldInfo> list = new List<HoldInfo>();
            HoldInfo entity = null;
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@QHoldGrnList",SqlDbType.Structured)
            };
            parms[0].Value = dt;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspVerifyQHoldGrn", parms))
            {
                while (rdr.Read())
                {
                    entity = new HoldInfo();
                    entity.SignId = rdr.GetInt32(0);
                    entity.SerialNumber = rdr.GetString(1);
                    entity.Cause = rdr.GetString(2);
                    entity.States = rdr.GetString(3);
                    entity.ErrorMessage = rdr.GetString(4);
                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }
        #endregion

        #region 将 Json 解析成 DateTable
        /// <summary>    
        /// 将 Json 解析成 DateTable   
        /// Json 数据格式如:  
        ///{table:[{column1:1,column2:2,column3:3},{column1:1,column2:2,column3:3}]} 
        /// </summary>    
        /// <param name="strJson">要解析的 Json 字符串</param>    
        /// <returns>返回 DateTable</returns>    
        public static DataTable JsonToDataTable(string strJson)
        {
            // 取出表名    
            var rg = new Regex(@"(?<={)[^:]+(?=:\[)", RegexOptions.IgnoreCase);
            string strName = rg.Match(strJson).Value;
            DataTable tb = null;
            // 去除表名    
            strJson = strJson.Substring(strJson.IndexOf("[") + 1);
            strJson = strJson.Substring(0, strJson.IndexOf("]"));
            // 获取数据    
            rg = new Regex(@"(?<={)[^}]+(?=})");
            MatchCollection mc = rg.Matches(strJson);
            for (int i = 0; i < mc.Count; i++)
            {
                string strRow = mc[i].Value;
                string[] strRows = strRow.Split(',');
                // 创建表    
                if (tb == null)
                {
                    tb = new DataTable();
                    tb.TableName = strName;
                    foreach (string str in strRows)
                    {
                        var dc = new DataColumn();
                        string[] strCell = str.Split(':');
                        dc.ColumnName = strCell[0].Replace("\"", "");
                        tb.Columns.Add(dc);
                    }
                    tb.AcceptChanges();
                }
                // 增加内容    
                DataRow dr = tb.NewRow();
                for (int j = 0; j < strRows.Length; j++)
                {
                    dr[j] = strRows[j].Split(':')[1].Replace("\"", "");
                }
                tb.Rows.Add(dr);
                tb.AcceptChanges();
            }
            return tb;
        }
        #endregion

        #region 查询QHold的工单信息
        /// <summary>
        /// 查询QHold的工单信息
        /// </summary>
        /// <param name="OrderNo"></param>
        /// <returns></returns>
        public List<HoldInfo> GetQueryQHold(string objectNo)
        {
            List<HoldInfo> list = new List<HoldInfo>();
            HoldInfo entity = null;
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@objectNo",SqlDbType.VarChar,100)
            };
            parms[0].Value = objectNo;
            using (DataTable dt = SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "uspGetQueryQHold", parms))
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    entity = new HoldInfo();
                    entity.SerialNumber = dt.Rows[i]["objectNo"].ToString();
                    entity.Cause = dt.Rows[i]["Cause"].ToString();
                    entity.OperatePerson = dt.Rows[i]["CreateBy"].ToString();
                    entity.OperateDateTime = Convert.ToDateTime(dt.Rows[i]["CreateDateTime"]);
                    list.Add(entity);
                }
            }
            return list;
        }
        #endregion

        #region 保存UnHold信息
        /// <summary>
        /// 保存UnHold信息
        /// </summary>
        /// <param name="entityList"></param>
        /// <param name="objectFlag"></param>
        /// <param name="causeDescription"></param>
        /// <param name="UserName"></param>
        public void SaveObjectUnHold(string objectString, int objectFlag, string causeDescription, string UserName)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@objectString",SqlDbType.VarChar,-1),
                new SqlParameter("@objectFlag",SqlDbType.Int),
                new SqlParameter("@causeDescription",SqlDbType.VarChar,200),
                new SqlParameter("@UserName",SqlDbType.VarChar,50),
            };
            parms[0].Value = objectString;
            parms[1].Value = objectFlag;
            parms[2].Value = causeDescription;
            parms[3].Value = UserName;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSaveObjectUnHold", 2000000, parms);
        }
        #endregion
    }
}
