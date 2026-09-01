using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Resource.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using System.Linq;

namespace SKT.LeanMES.Resource.BLL
{
    public class Line
    {
        private Int32 recordCount = 0;

        /// <summary>
        /// 编辑（添加或更新） Line 信息。
        /// </summary>
        /// <param name="entity">Line 实体对象。</param>
        public void Edit(LineInfo entity, string resIdString, int appLineNum, string startDateStr, string endDateStr, string agvStr)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@LineId", SqlDbType.Int),
                new SqlParameter("@LineName", SqlDbType.NVarChar, 20),
                new SqlParameter("@LimitValue", SqlDbType.Int),
                new SqlParameter("@EcPatch", SqlDbType.Int),
                new SqlParameter("@LineDescription", SqlDbType.NVarChar, 50),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 50),
                new SqlParameter("@ResIdString", SqlDbType.VarChar, 2000),
                new SqlParameter("@StartTime", SqlDbType.VarChar, 2000),
                new SqlParameter("@EndTime", SqlDbType.VarChar, 2000),
                new SqlParameter("@LineMachineRelation", SqlDbType.VarChar, 2000),
                new SqlParameter("@WorkShopId", SqlDbType.Int),
                new SqlParameter("@LineCode", SqlDbType.VarChar, 50),
                new SqlParameter("@AgvStr", SqlDbType.NVarChar){ Value = agvStr}
               
            };

            parms[0].Value = entity.LineId;
            parms[1].Value = entity.LineName;
            parms[2].Value = entity.LimitValue;
            parms[3].Value = entity.EcPatch;
            parms[4].Value = entity.LineDescription;
            parms[5].Value = entity.CreateBy;
            parms[6].Value = entity.ModifyBy;
            parms[7].Value = entity.Remark;
            parms[8].Value = resIdString;
            parms[9].Value = startDateStr;
            parms[10].Value = endDateStr;
            parms[11].Value = entity.LineMachineRelation;
            parms[12].Value = entity.WorkShopId;
            parms[13].Value = entity.LineCode;
            //Modify By Alen 2016-06-20 判断线的数量限制
            if (!AddLineIsLimited(appLineNum, entity.LineId))
            {
                SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_Line_Edit", parms);
            }
            else
            {
                throw new MESException("Messages", "LineQtyLimit");
            }
        }

        /// <summary>
        /// 根据 LineId 字符串删除 Line 信息。
        /// </summary>
        /// <param name="idString">LineId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_Line_Delete", parms);
        }

        /// <summary>
        /// 根据 LineId 获取实体信息。
        /// </summary>
        /// <param name="lineId">LineId。</param>
        /// <returns>Line 实体对象。</returns>
        public LineInfo GetInfo(Int32 lineId)
        {
            LineInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = lineId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_Line_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new LineInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetDateTime(4),
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7));
                    entity.LimitValue = rdr.GetDecimal(8);
                    entity.EcPatch = rdr.GetDecimal(9);
                    entity.LineMachineRelation = rdr.GetString(10);
                    entity.PrincipalName = rdr.GetString(11);
                    entity.StandardHuman = rdr.GetDecimal(12);
                    entity.ActualNumber = rdr.GetDecimal(13);
                    entity.Principal = rdr.GetInt32(14);
                    entity.WorkShopId = rdr.GetInt32(15);
                    entity.WorkShopName = rdr.GetString(16);
                    entity.LineCode = rdr.GetString(17);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据登陆名查询相应数据
        /// </summary>
        /// <param name="userName"></param>
        /// <returns></returns>
        public List<LineInfo> GetLineNameByUserName(String userName)
        {
            List<LineInfo> list = new List<LineInfo>();
            LineInfo entity = null;
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@UserId",SqlDbType.VarChar,20),
                new SqlParameter("@IsByUserId",SqlDbType.Bit)
            };
            parms[0].Value = userName;
            parms[1].Value = false;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetLineByUser", parms))
            {
                while (rdr.Read())
                {
                    entity = new LineInfo(rdr.GetInt32(0), rdr.GetString(1));

                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>Line 实体对象。</returns>
        public LineInfo GetInfo(String fieldValue)
        {
            LineInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_Line_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new LineInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetDateTime(4),
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7));
                    entity.LineMachineRelation = rdr.GetString(10);
                    entity.PrincipalName = rdr.GetString(11);
                    entity.StandardHuman = rdr.GetInt32(12);
                    entity.ActualNumber = rdr.GetInt32(13);
                    entity.Principal = rdr.GetInt32(14);
                    entity.WorkShopId = rdr.GetInt32(15);
                    entity.WorkShopName = rdr.GetString(16);
                    entity.LineCode = rdr.GetString(17);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 Line 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="lineCount">line 总数。</param>
        /// <returns>Line 列表。</returns>
        public List<LineInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<LineInfo> list = new List<LineInfo>();
            LineInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "VWBasalLine", "LineId",
                "[LineId], [LineName], [LineDescription], [CreateBy], [CreateDateTime],  [ModifyBy], [ModifyDateTime], [Remark],LineMachineRelation, WorkShopId, WorkShopName,LineCode", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new LineInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetDateTime(4),
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7));
                    entity.LineMachineRelation = rdr.GetString(8);
                    entity.WorkShopId = rdr.GetInt32(9);
                    entity.WorkShopName = rdr.GetString(10);
                    entity.LineCode = rdr.GetString(11);
                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        /// <summary>
        /// 获取产线库存量
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<LineInfo> GetLineList(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<LineInfo> list = new List<LineInfo>();
            LineInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwGetLineQtyList", "LineId",
                "[LineId], [LineName], [LineDescription], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime], [Remark],[SerialNumber],[BalanceQty]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new LineInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetDateTime(4),
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7));
                    entity.SerialNumber = rdr.GetString(8);
                    entity.BalanceQty = rdr.GetDecimal(9);
                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        /// <summary>
        /// 添加工段与线别关系
        /// </summary>
        /// <param name="idString"></param>
        /// <param name="sectionId"></param>
        /// <param name="creater"></param>
        /// <param name="createrid"></param>
        /// <returns></returns>
        public Int32 InsertSectionLine(String idString, String workseq, String creater, Int32 createrid)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.NVarChar,50),
                new SqlParameter("@WorkSeq", SqlDbType.NVarChar, 50),
                new SqlParameter("@creater", SqlDbType.NVarChar,50),
                new SqlParameter("@createrid", SqlDbType.Int)
            };
            parms[0].Value = idString;
            parms[1].Value = workseq;
            parms[2].Value = creater;
            parms[3].Value = createrid;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspInsertSectionLineInfo", parms);

            return (Int32)parms[1].Value;
        }

        /// <summary>
        /// 移除工段与线别的关系
        /// </summary>
        /// <param name="idString"></param>
        /// <param name="sectionId"></param>
        /// <param name="creater"></param>
        /// <param name="createId"></param>
        /// <returns></returns>
        public Int32 DeleteSectionLineInfo(String idString, String workseq, String creater, Int32 createId)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.NVarChar,50),
                new SqlParameter("@WorkSeq", SqlDbType.NVarChar, 50),
                new SqlParameter("@creater", SqlDbType.NVarChar,50),
                new SqlParameter("@createrid", SqlDbType.Int)
            };
            parms[0].Value = idString;
            parms[1].Value = workseq;
            parms[2].Value = creater;
            parms[3].Value = createId;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspRemoveSectionLine", parms);

            return (Int32)parms[1].Value;
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

        /// <summary>
        /// 检查线
        /// </summary>
        /// <param name="appLinNum"></param>
        /// <returns></returns>
        public bool AddLineIsLimited(int appLinNum,int lineId)
        {
            bool isLimited = true;
            if (appLinNum > 0)
            {
                int lineNum = 0;
                string sql = "select LineId from dbo.Basal_Line where lineId>0";
                using (SqlDataReader rdr = SQLHelper.ExecuteReaderSqlText(SQLHelper.MESConnString, sql, null))
                {
                    while (rdr.Read())
                    {
                        lineNum++;
                    }
                }
                if (lineId > 0)
                {
                    if (lineNum < appLinNum)
                    {
                        isLimited = false;
                    }
                }
                else
                {
                    if (lineNum <= appLinNum)
                    {
                        isLimited = false;
                    }
                }
               
            }
            else
            {
                isLimited = false;
            }
            return isLimited;
        }
        /// <summary>
        /// 对比线别绑定的设备的设备类型和线别设备类型是否一致
        /// </summary>
        /// <param name="EquipmentLineDisplayName"></param>
        /// <param name="LineId"></param>
        public void CheckLineMachineTypeRelation(string EquipmentLineDisplayName, int LineId)
        {
            string[] nameArr = EquipmentLineDisplayName.Split(',');
            List<string> list1 = new List<string>(nameArr);
            List<string> list2 = new List<string>();
            string strsql = @"SELECT t1.EquipmentTypeCode,* FROM dbo.Basal_Equipment t
                            JOIN Basal_EquipmentType t1 ON t1.EquipmentTypeId=t.EquipmentTypeId
                            WHERE t.SequenceNo>0 and LineId=" + LineId;
            DataTable dt = SQLHelper.ExcuteDataTableSqlText(SQLHelper.MESConnString, strsql, null);
            if (dt.Rows.Count <= 0)
            {
                throw new Exception("线别未绑定设备");
            }
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                list2.Add(dt.Rows[i][0].ToString());
            }
            if (list1.Count != list2.Count)
            {
                throw new Exception("线别设备类型数量和线别绑定的设备数量不符");
            }
            else
            {
                var E = list1.Except(list2);
                if (E.Count() != 0)
                {
                    throw new Exception("线别设备类型和线别绑定的设备类型不符");
                }
            }
        }
        /// <summary>
        /// 获取检验模板版本号
        /// </summary>
        /// <param name="templateId"></param>
        /// <returns></returns>
        public int GetLineInfo(string LineName)
        {
            int LineId = -1;
            SqlParameter[] param = new SqlParameter[]{
                new SqlParameter("@LineName",SqlDbType.VarChar,50),
            };

            param[0].Value = LineName;

            string sql = "SELECT LineId  FROM basal_Line WHERE LineName=@LineName ";

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderSqlText(SQLHelper.MESConnString, sql, param))
            {
                if (rdr.Read())
                {
                    LineId = Convert.ToInt32(rdr["LineId"].ToString());
                }
                rdr.Close();
            }

            return LineId;
        }
    }
}