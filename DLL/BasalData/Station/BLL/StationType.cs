using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Station.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Station.BLL
{
    public class StationType
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） StationType 信息。
        /// </summary>
        /// <param name="entity">StationType 实体对象。</param>
        public void  Edit(StationTypeInfo entity,string opeIdString)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@StationTypeId", SqlDbType.Int),
                new SqlParameter("@StationType", SqlDbType.NVarChar, 20),
                new SqlParameter("@StationDesc", SqlDbType.NVarChar, 50),
                new SqlParameter("@TempId", SqlDbType.Int),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 50),
                new SqlParameter("@OpeIdString", SqlDbType.VarChar, 2000)
            };

            parms[0].Value = entity.StationTypeId;
            parms[1].Value = entity.StationType;
            parms[2].Value = entity.StationDesc;
            parms[3].Value = entity.TempId;
            parms[4].Value = entity.CreateBy;
            parms[5].Value = entity.ModifyBy;
            parms[6].Value = entity.Remark;
            parms[7].Value = opeIdString;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_StationType_Edit", parms);
        }

        /// <summary>
        /// 根据UI获取配置了该UI的工序,如('FAIInspection,AgeingCollection')老化开始/老化结束
        /// </summary>
        /// <param name="UIModuleStr"></param>
        /// <returns></returns>
        public List<StationInfo> GetStationsByFixedUI(string UIModuleStr)
        {
            List<StationInfo> list = new List<StationInfo>();
            StationInfo entity = null;

            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@UIModuleStr",SqlDbType.VarChar,-1)
            };

            parms[0].Value = UIModuleStr;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetStationsByFixedUI", parms))
            {
                while (rdr.Read())
                {
                    entity = new StationInfo();
                    entity.StationId = rdr.GetInt32(0);
                    entity.StationTypeId = rdr.GetInt32(1);
                    entity.OpeType = rdr.GetString(2);
                    entity.Station = rdr.GetString(3);

                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }

        /// <summary>
        /// 根据 StationTypeId 字符串删除 StationType 信息。
        /// </summary>
        /// <param name="idString">StationTypeId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_StationType_Delete", parms);
        }

        /// <summary>
        /// 根据 StationTypeId 获取实体信息。
        /// </summary>
        /// <param name="stationTypeId">StationTypeId。</param>
        /// <returns>StationType 实体对象。</returns>
        public StationTypeInfo GetInfo(Int32 stationTypeId)
        {
            StationTypeInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = stationTypeId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_StationType_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new StationTypeInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetInt32(3), rdr.GetString(4), 
                        rdr.GetDateTime(5), rdr.GetString(6), rdr.GetDateTime(7), rdr.GetString(8));
                    //entity.TempName = rdr.GetString(9);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>StationType 实体对象。</returns>
        public StationTypeInfo GetInfo(String fieldValue)
        {
            StationTypeInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_StationType_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new StationTypeInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetInt32(3), rdr.GetString(4), 
                        rdr.GetDateTime(5), rdr.GetString(6), rdr.GetDateTime(7), rdr.GetString(8));
                    //entity.TempName = rdr.GetString(9);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 StationType 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="stationTypeCount">stationType 总数。</param>
        /// <returns>StationType 列表。</returns>
        public List<StationTypeInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<StationTypeInfo> list = new List<StationTypeInfo>();
            StationTypeInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwStationTypeMember", "StationTypeID",
                "[StationTypeId], [StationType], [StationDesc], [TempId], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime], [Remark]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new StationTypeInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetInt32(3), rdr.GetString(4), 
                        rdr.GetDateTime(5), rdr.GetString(6), rdr.GetDateTime(7), rdr.GetString(8));
                    //entity.TempName = rdr.GetString(9);
                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }
        /// <summary>
        /// 获取绑定Activity的工位类型
        /// </summary>
        /// <param name="AC_ID"></param>
        /// <returns></returns>
        public List<StationTypeInfo> GetActivityStation(Int32  AC_ID) 
        {
            List<StationTypeInfo> list = new List<StationTypeInfo>();
            StationTypeInfo entity = null;
            SqlParameter[] parms = new SqlParameter[] { 
                  new SqlParameter("@AC_ID",SqlDbType.Int)
            };
            parms[0].Value = AC_ID;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetActivityStation", parms))
            {
                while (rdr.Read())
                {
                    entity = new StationTypeInfo();
                    entity.StationTypeId = rdr.GetInt32(0);
                    entity.StationType = rdr.GetString(1);
                    entity.StationDesc = rdr.GetString(2);
                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }
        /// <summary>
        /// 根据登陆用户获取对应的工位
        /// </summary>
        /// <param name="username"></param>
        /// <param name="id"></param>
        /// <param name="isOperationType"></param>
        /// <returns></returns>
        public List<StationInfo> GetOperationTypeByUser(string username, int id, bool isOperationType)
        {
            List<StationInfo> list = new List<StationInfo>();
            StationInfo entity = null;

            SqlParameter[] parms = new SqlParameter[] { 
                new SqlParameter("@UserName",SqlDbType.VarChar,20),
                new SqlParameter("@ID",SqlDbType.Int),
                new SqlParameter("@IsGetOperationType",SqlDbType.Bit)
            };

            parms[0].Value = username;
            parms[1].Value = id;
            parms[2].Value = isOperationType;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetStationsByUser", parms))
            {
                while (rdr.Read())
                {
                    entity = new StationInfo();
                    entity.StationId = rdr.GetInt32(0);
                    entity.StationTypeId = rdr.GetInt32(1);
                    entity.OpeType = rdr.GetString(2);
                    entity.Station = rdr.GetString(3);

                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }
        /// <summary>
        /// 根据登陆用户 权限获取对应的工位
        /// </summary>
        /// <param name="username"></param>
        /// <param name="id"></param>
        /// <param name="isOperationType"></param>
        /// <returns></returns>
        public List<StationInfo> GetOperationTypeByUserRole(string username, int id, bool isOperationType)
        {
            List<StationInfo> list = new List<StationInfo>();
            StationInfo entity = null;

            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@UserName",SqlDbType.VarChar,20),
                new SqlParameter("@ID",SqlDbType.Int),
                new SqlParameter("@IsGetOperationType",SqlDbType.Bit)
            };

            parms[0].Value = username;
            parms[1].Value = id;
            parms[2].Value = isOperationType;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetStationsByUserRole", parms))
            {
                while (rdr.Read())
                {
                    entity = new StationInfo();
                    entity.StationId = rdr.GetInt32(0);
                    entity.StationTypeId = rdr.GetInt32(1);
                    entity.OpeType = rdr.GetString(2);
                    entity.Station = rdr.GetString(3);

                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }

        /// <summary>
        /// 获取ESOP工序信息
        /// </summary>
        /// <returns></returns>
        public List<StationInfo> GetESOPStationInfo()
        {
            List<StationInfo> list = new List<StationInfo>();
            StationInfo entity = null;

            SearchSettings searchSettings = new SearchSettings();

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(0, -1, "vwGetEsopStation",
                "StationId", "StationId,Station,StationTypeId,StationType", searchSettings, "StationId");

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new StationInfo();
                    entity.StationId = rdr.GetInt32(0);
                    entity.Station = rdr.GetString(1);
                    entity.StationTypeId = rdr.GetInt32(2);
                    entity.OpeType = rdr.GetString(3);
                    

                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

    }
}