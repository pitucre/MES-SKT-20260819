using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Station.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Station.BLL
{
    public class Station
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） Station 信息。
        /// </summary>
        /// <param name="entity">Station 实体对象。</param>
        public void Edit(StationInfo entity, string certString,string childStationId)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@StationId", SqlDbType.Int),
                new SqlParameter("@Station", SqlDbType.VarChar, 50),
                new SqlParameter("@StationDesc", SqlDbType.NVarChar, 50),
                new SqlParameter("@StationTypeId", SqlDbType.Int),
                new SqlParameter("@StationStatus", SqlDbType.Int),
                new SqlParameter("@StationResTypeId", SqlDbType.Int),
                new SqlParameter("@StationDefaultResId", SqlDbType.Int),
                new SqlParameter("@StationRevision", SqlDbType.VarChar, 5),
                new SqlParameter("@StationIsCurrentRev", SqlDbType.Bit),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 50),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@CertIdString", SqlDbType.VarChar, 2000),
                new SqlParameter("@TmplID", SqlDbType.Int),
                new SqlParameter("@ShortLetter", SqlDbType.VarChar, 10),
                new SqlParameter("@ChildStationId", SqlDbType.VarChar, 2000),
                new SqlParameter("@IsCollectStation", SqlDbType.Int),
                new SqlParameter("@ModuleId",SqlDbType.Int)
            };

            parms[0].Value = entity.StationId;
            parms[1].Value = entity.Station;
            parms[2].Value = entity.StationDesc;
            parms[3].Value = entity.StationTypeId;
            parms[4].Value = entity.StationStatus;
            parms[5].Value = entity.StationResTypeId;
            parms[6].Value = entity.StationDefaultResId;
            parms[7].Value = entity.StationRevision;
            parms[8].Value = entity.StationIsCurrentRev;
            parms[9].Value = entity.Remark;
            parms[10].Value = entity.CreateBy;
            parms[11].Value = entity.ModifyBy;
            parms[12].Value = certString;
            parms[13].Value = entity.TmplID;
            parms[14].Value = entity.ShortLetter;
            parms[15].Value = childStationId;
            parms[16].Value = entity.IsCollectStation;
            parms[17].Value = entity.ModuleId;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_Station_Edit", parms);
        }

        /// <summary>
        /// 根据 StationId 字符串删除 Station 信息。
        /// </summary>
        /// <param name="idString">StationId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_Station_Delete", parms);
        }

        /// <summary>
        /// 根据 StationId 获取实体信息。
        /// </summary>
        /// <param name="stationId">StationId。</param>
        /// <returns>Station 实体对象。</returns>
        public StationInfo GetInfo(Int32 stationId)
        {
            StationInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = stationId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_Station_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new StationInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetInt32(3), rdr.GetInt32(4), 
                        rdr.GetInt32(5), rdr.GetInt32(6), rdr.GetString(7), rdr.GetBoolean(8), rdr.GetString(9), 
                        rdr.GetDateTime(10), rdr.GetString(11), rdr.GetDateTime(12), rdr.GetString(13), rdr.GetInt32(14));
                    entity.OpeType = rdr.GetString(15);
                    entity.ResTypeName = rdr.GetString(16);
                    entity.ResName = rdr.GetString(17);
                    entity.StatusStr = rdr.GetString(18);
                    entity.TempName = rdr.GetString(19);
                    entity.ShortLetter = rdr.GetString(20);
                    entity.IsCollectStation = rdr.GetInt32(21);
                    if (rdr.FieldCount == 24)
                    {
                        entity.ModuleId = rdr.GetInt32(22);
                        entity.ModuleName = rdr.GetString(23);
                    }
                }
                rdr.Close();
            }

            return entity;
        }

        public DataTable GetOperationByTypeId(Int32 opeTypeId)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@OpeTypeId", SqlDbType.Int)
            };

            parms[0].Value = opeTypeId;

            return SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "Basal_StationByTypeId", parms);
        }

        /// <summary>
        /// 根据标识和工序类型查询对应工序信息
        /// </summary>
        /// <param name="flage"></param>
        /// <param name="stationTypeId"></param>
        /// <returns></returns>
        public List<StationInfo> GetStationInfoByStationId(Int32  flage,Int32  stationTypeId) 
        {
            List<StationInfo> list = new List<StationInfo>();
            StationInfo entity = null;
            SqlParameter[] parms = new SqlParameter[]{
                 new SqlParameter("@Flage",SqlDbType.Int),
                 new SqlParameter("@StationTypeId",SqlDbType.Int)
            };
            parms[0].Value = flage;
            parms[1].Value = stationTypeId;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetStationInfoByStationId", parms))
            {
                while (rdr.Read())
                {
                    entity = new StationInfo();
                    entity.StationId = rdr.GetInt32(0);
                    entity.Station = rdr.GetString(1);
                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;    
        }
        /// <summary>
        /// 分页获取 Station 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="stationCount">station 总数。</param>
        /// <returns>Station 列表。</returns>
        public List<StationInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<StationInfo> list = new List<StationInfo>();
            StationInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwStationMember", "StationId",
                "StationId,Station,StationDesc,StationTypeId,StationStatus,StationResTypeId,StationDefaultResId,StationRevision,StationIsCurrentRev,Remark,CreateDateTime,CreateBy,ModifyDateTime,ModifyBy,TmplID,OpeType,ResTypeName,ResName,StatusStr,ShortLetter,certification", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new StationInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetInt32(3), rdr.GetInt32(4), 
                        rdr.GetInt32(5), rdr.GetInt32(6), rdr.GetString(7), rdr.GetBoolean(8), rdr.GetString(9), 
                        rdr.GetDateTime(10), rdr.GetString(11), rdr.GetDateTime(12), rdr.GetString(13), rdr.GetInt32(14));

                    entity.OpeType = rdr.GetString(15);
                    entity.ResTypeName = rdr.GetString(16);
                    entity.ResName = rdr.GetString(17);
                    entity.StatusStr = rdr.GetString(18);
                    entity.ShortLetter = rdr.GetString(19);
                    entity.certification=rdr.GetString(20).Length==0?"": rdr.GetString(20).Substring(0, rdr.GetString(20).Length-1);
                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        //用于获取工单、产品；绑定路由的可选工序
        public List<StationInfo> GetRouterDetail(string Type, string TypeValue)
        {
            StationInfo entity = null;
            List<StationInfo> list = new List<StationInfo>();

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@Type", SqlDbType.NVarChar, 200),
                new SqlParameter("@TypeValue", SqlDbType.NVarChar,200)
            };
            parms[0].Value = Type;          //ItemID or OrderID
            parms[1].Value = TypeValue;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetPassRouterDetail", parms))
            {
                while (rdr.Read())
                {
                    entity = new StationInfo();
                    entity.StationId = (int)rdr["StationID"];
                    entity.Station = rdr["Station"].ToString();
                    entity.StationDesc = rdr["StationDesc"].ToString();
                    entity.StatusStr = rdr["StationStatus"].ToString();
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

        /// <summary>
        /// 根据标识和工序类型查询对应工序信息
        /// </summary>
        /// <param name="flage"></param>
        /// <param name="stationTypeId"></param>
        /// <returns></returns>
        public List<StationInfo> GetChildStationInfo(Int32 flage, Int32 stationTypeId)
        {
            List<StationInfo> list = new List<StationInfo>();
            StationInfo entity = null;
            SqlParameter[] parms = new SqlParameter[]{
                 new SqlParameter("@Flage",SqlDbType.Int),
                 new SqlParameter("@StationId",SqlDbType.Int)
            };
            parms[0].Value = flage;
            parms[1].Value = stationTypeId;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetChildStationInfo", parms))
            {
                while (rdr.Read())
                {
                    entity = new StationInfo();
                    entity.StationId = rdr.GetInt32(0);
                    entity.Station = rdr.GetString(1);
                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }
    }
}