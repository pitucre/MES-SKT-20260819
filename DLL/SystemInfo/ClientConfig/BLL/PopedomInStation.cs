using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.ClientConfig.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;

namespace SKT.LeanMES.ClientConfig.BLL
{
    public class PopedomInStation
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） PopedomInStation 信息。
        /// </summary>
        /// <param name="entity">PopedomInStation 实体对象。</param>
        public Int32 Edit(PopedomInStationInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@PopedomInStationId", SqlDbType.Int),
                new SqlParameter("@StationId", SqlDbType.Int),
                new SqlParameter("@Popedom", SqlDbType.Int),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@StationTypeId", SqlDbType.Int),
            };

            parms[0].Value = entity.PopedomInStationId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.StationId;
            parms[2].Value = entity.Popedom;
            parms[3].Value = entity.CreateBy;
            parms[4].Value = entity.ModifyBy;
            parms[5].Value = entity.StationTypeId;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "SYS_PopedomInStation_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 PopedomInStationId 字符串删除 PopedomInStation 信息。
        /// </summary>
        /// <param name="idString">PopedomInStationId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "SYS_PopedomInStation_Delete", parms);
        }

        /// <summary>
        /// 根据 PopedomInStationId 获取实体信息。
        /// </summary>
        /// <param name="popedomInStationId">PopedomInStationId。</param>
        /// <returns>PopedomInStation 实体对象。</returns>
        public PopedomInStationInfo GetInfo(Int32 popedomInStationId)
        {
            PopedomInStationInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = popedomInStationId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "SYS_PopedomInStation_GetInfo", parms))
            {
                if (rdr.HasRows)
                {
                    entity = Helper.SqlDataReaderConverToList <PopedomInStationInfo>(rdr)[0];
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>PopedomInStation 实体对象。</returns>
        public PopedomInStationInfo GetInfo(String fieldValue)
        {
            PopedomInStationInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "SYS_PopedomInStation_GetInfo", parms))
            {
                if (rdr.HasRows)
                {
                    entity = Helper.SqlDataReaderConverToList<PopedomInStationInfo>(rdr)[0];
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 ClientProInfoConfig 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <returns>PopedomInStationInfo 列表。</returns>
        public List<PopedomInStationInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<PopedomInStationInfo> list = new List<PopedomInStationInfo>();

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwSYSPopedomInStation", "PopedomInStationId",
                "[PopedomInStationId], [StationId], [StationName], [StationTypeId], [StationTypeName], [Popedom], [PopedomName],[CreateBy],[CreateDateTime],ModifyBy,ModifyDateTime", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                if (rdr.HasRows)
                {
                    list = Helper.SqlDataReaderConverToList<PopedomInStationInfo>(rdr);
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
        /// 切换工位获取跳转相关路径
        /// </summary>
        /// <param name="stationId"></param>
        /// <param name="resourceId"></param>
        /// <returns></returns>
        public string GetLocationByStationId(int stationId,int resourceId)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@StationId", SqlDbType.Int), 
                new SqlParameter("@ResourceId", SqlDbType.Int)
            };

            parms[0].Value = stationId;
            parms[1].Value = resourceId;

            object result = SQLHelper.ExecuteScalarStoredProcedure(SQLHelper.MESConnString, "SYS_PopedomInStation_GetLocation", parms);
            if (result != null)
            {
                return result.ToString();
            }
            return "";
        }

        /// <summary>
        /// 获取当前工序前后站位
        /// </summary>
        /// <param name="stationId"></param>
        /// <param name="routeId"></param>
        /// <returns></returns>
        public DataTable GetLastNextStation(int stationId, int routeId)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@StationId",SqlDbType.Int),
                new SqlParameter("@RouteId",SqlDbType.Int)
            };

            parms[0].Value = stationId;
            parms[1].Value = routeId;

            return SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "uspGetLastNextStation", parms);
        }

        public DataTable GetNearStationBySN(int currStationId, string serialNumber)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@StationId",SqlDbType.Int),
                new SqlParameter("@SN",SqlDbType.VarChar,200)
            };

            parms[0].Value = currStationId;
            parms[1].Value = serialNumber;

            return SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "uspGetNearStationBySN", parms);

        }

        /// <summary>
        /// 根据StationId及SN 获取当前工序前五个过站成功的条码
        /// </summary>
        public string GetPassStationBySN(int StationId)
        {
            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@StationId", SqlDbType.Int)
                };
            parms[0].Value = StationId;
            return ComMethod.GetList("uspGetPassStationBySN_PDA", parms);
        }

        public DataTable GetNearStationBySNPDA(int currStationId, string serialNumber)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@StationId",SqlDbType.Int),
                new SqlParameter("@SN",SqlDbType.VarChar,200)
            };

            parms[0].Value = currStationId;
            parms[1].Value = serialNumber;

            return SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "uspGetNearStationBySN_PDA", parms);

        }

        /// <summary>
        /// 获取路由明细的设置
        /// </summary>
        /// <param name="routeId">路由ID</param>
        /// <param name="stationId">工序ID</param>
        /// <returns></returns>
        public RouteDetailSetting GetRouteOperationSetting(int routeId, int stationId)
        {
            RouteDetailSetting setting = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@RouteId",SqlDbType.Int),
                new SqlParameter("@StationId",SqlDbType.Int)
            };
            parms[0].Value = routeId;
            parms[1].Value = stationId;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspRouteOperationSetting", parms))
            {
                while (rdr.Read())
                {
                    setting = new RouteDetailSetting(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetString(5), rdr.GetString(6), rdr.GetString(7), rdr.GetInt32(8), rdr.GetInt32(9), rdr.GetInt32(10),
                        rdr.GetInt32(11), rdr.GetInt32(12), rdr.GetInt32(13));//, rdr.GetString(14), rdr.GetInt32(15));
                  
                }
                rdr.Close();
            }            
            return setting;
        }
    }
}