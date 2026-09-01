using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SKT.LeanMES.ESOP.Model;
using System.Data.SqlClient;
using System.Data;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;

namespace SKT.LeanMES.ESOP.BLL
{
    public class ESOPMac
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） ESOPMac 信息。
        /// </summary>
        /// <param name="entity">ESOPMac 实体对象。</param>
        public Int32 Edit(ESOPMacInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ESOPMacId", SqlDbType.Int),
                new SqlParameter("@MAC", SqlDbType.VarChar, 50),
                new SqlParameter("@MacName", SqlDbType.VarChar, 50),
                new SqlParameter("@StationId", SqlDbType.Int),
                new SqlParameter("@ResourceId", SqlDbType.Int),
                new SqlParameter("@IsSwitch", SqlDbType.Bit),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 100),
                new SqlParameter("@IsDefault", SqlDbType.Bit),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20)
            };

            parms[0].Value = entity.ESOPMacId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.MAC;
            parms[2].Value = entity.MacName;
            parms[3].Value = entity.StationId;
            parms[4].Value = entity.ResourceId;
            parms[5].Value = entity.IsSwitch;
            parms[6].Value = entity.Remark;
            parms[7].Value = entity.IsDefault;
            parms[8].Value = entity.CreateBy;
            parms[9].Value = entity.ModifyBy;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_ESOPMac_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 ESOPMacId 字符串删除 ESOPMac 信息。
        /// </summary>
        /// <param name="idString">ESOPMacId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_ESOPMac_Delete", parms);
        }

        /// <summary>
        /// 根据 ESOPMacId 获取实体信息。
        /// </summary>
        /// <param name="eSOPMacId">ESOPMacId。</param>
        /// <returns>ESOPMac 实体对象。</returns>
        public ESOPMacInfo GetInfo(Int32 eSOPMacId)
        {
            return CommonHelper.BLL.ComMethod.GetInfo<ESOPMacInfo>(eSOPMacId, "Prod_ESOPMac_GetInfo");
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>ESOPMac 实体对象。</returns>
        public ESOPMacInfo GetInfo(String fieldValue)
        {
            return CommonHelper.BLL.ComMethod.GetInfo<ESOPMacInfo>(fieldValue, "Prod_ESOPMac_GetInfo");            
        }

        /// <summary>
        /// 分页获取 ESOPMac 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="eSOPMacCount">eSOPMac 总数。</param>
        /// <returns>ESOPMac 列表。</returns>
        public List<ESOPMacInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ESOPMacInfo> list = new List<ESOPMacInfo>();
            //表名或者视图
            string strTb = "vwESOPMacInfo";
            //主键
            string strKey = "ESOPMacId";
            //查询栏位字串
            string strColumns = @"[ESOPMacId], [MAC],[MacName], [StationId], [Station], [ResourceId], [ResName], [IsSwitch], [Remark],[LineName],[IsDefault],CreateBy,CreateDateTime,ModifyBy,ModifyDateTime";

            return ComMethod.GetComList<ESOPMacInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);           
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

        /// <summary>
        /// 设置默认ESOP工序
        /// </summary>
        /// <param name="mac"></param>
        /// <param name="stationId"></param>
        /// <param name="resId"></param>
        public void SetDefaultEsopStation(string mac,int stationId, int resId)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@MAC", SqlDbType.VarChar, 50),
                new SqlParameter("@StationId", SqlDbType.Int),
                new SqlParameter("@ResourceId", SqlDbType.Int)
            };

            parms[0].Value = mac;
            parms[1].Value = stationId;
            parms[2].Value = resId;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSetDefaultEsopStation", parms);
        }

    }
}
