using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using SKT.LeanMES.Plan.Model;
using System.Data;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;

namespace SKT.LeanMES.Plan.BLL
{
    public class StandardLaborTime
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） StandardLaborTime 信息。
        /// </summary>
        /// <param name="entity">StandardLaborTime 实体对象。</param>
        public Int32 Edit(StandardLaborTimeInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@StandardLaborTimeId", SqlDbType.Int),
                new SqlParameter("@LaborTimeType", SqlDbType.Int),
                new SqlParameter("@EquipmentLineId", SqlDbType.Int),
                new SqlParameter("@ItemId", SqlDbType.Int),
                new SqlParameter("@TableName", SqlDbType.NVarChar, 50),
                new SqlParameter("@StandardLaborTime", SqlDbType.Decimal),
                new SqlParameter("@StandardCapacity", SqlDbType.Int),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 50),
                new SqlParameter("@BottleneckHours", SqlDbType.Decimal)
            };

            parms[0].Value = entity.StandardLaborTimeId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.LaborTimeType;
            parms[2].Value = entity.EquipmentLineId;
            parms[3].Value = entity.ItemId;
            parms[4].Value = entity.TableName;
            parms[5].Value = entity.StandardLaborTime;
            parms[6].Value = entity.StandardCapacity;
            parms[7].Value = entity.CreateBy;
            parms[8].Value = entity.ModifyBy;
            parms[9].Value = entity.Remark;
            parms[10].Value = entity.BottleneckHours;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_StandardLaborTime_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 StandardLaborTimeId 字符串删除 StandardLaborTime 信息。
        /// </summary>
        /// <param name="idString">StandardLaborTimeId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_StandardLaborTime_Delete", parms);
        }

        /// <summary>
        /// 根据 StandardLaborTimeId 获取实体信息。
        /// </summary>
        /// <param name="standardLaborTimeId">StandardLaborTimeId。</param>
        /// <returns>StandardLaborTime 实体对象。</returns>
        public StandardLaborTimeInfo GetInfo(Int32 standardLaborTimeId)
        {
            return CommonHelper.BLL.ComMethod.GetInfo<StandardLaborTimeInfo>(standardLaborTimeId, "Prod_StandardLaborTime_GetInfo");
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>StandardLaborTime 实体对象。</returns>
        public StandardLaborTimeInfo GetInfo(String fieldValue)
        {
            return CommonHelper.BLL.ComMethod.GetInfo<StandardLaborTimeInfo>(fieldValue, "Prod_StandardLaborTime_GetInfo");
        }

        /// <summary>
        /// 分页获取 StandardLaborTime 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="standardLaborTimeCount">standardLaborTime 总数。</param>
        /// <returns>StandardLaborTime 列表。</returns>
        public List<StandardLaborTimeInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<StandardLaborTimeInfo> list = new List<StandardLaborTimeInfo>();
            //表名或者视图
            string strTb = "vwGetStandardLaborTimeList";
            //主键
            string strKey = "StandardLaborTimeId";
            //查询栏位字串
            string strColumns = @"[StandardLaborTimeId], [LaborTimeType], [EquipmentLineId],[LaborTimeTypeName],[EquipmentLineName], [ItemId],[ItemCode],[ItemName],[PanelQty], [TableName],[TableDesc], [StandardLaborTime], [StandardCapacity], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime], [Remark],[BottleneckHours]";

            return ComMethod.GetComList<StandardLaborTimeInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);
        }

        /// <summary>
        /// 获取标准产能
        /// </summary>
        /// <param name="itemId"></param>
        /// <param name="tableName"></param>
        /// <param name="equipmentLine"></param>
        /// <returns></returns>
        public int GetStandardCapacity(int itemId, string tableName, string equipmentLine)
        {
            int stantardCapacity = 0;
            string sql = String.Format(@"SELECT StandardCapacity FROM dbo.Prod_StandardLaborTime a 
	                    INNER JOIN dbo.Basal_EquipmentLineRelation b ON b.EquipmentLineId = a.EquipmentLineId 
	                    WHERE ItemId={0} AND TableName='{1}' AND  b.EquipmentLineType='{2}'",itemId,tableName,equipmentLine);
           DataTable dt = SQLHelper.ExcuteDataTableSqlText(SQLHelper.MESConnString, sql, null);
           if (dt.Rows.Count > 0)
           {
               stantardCapacity = Convert.ToInt16(dt.Rows[0][0]);
           }
            return stantardCapacity;
        }

        /// <summary>
        /// 获取标准产能 ZX  20201116
        /// </summary>
        /// <param name="itemId"></param>
        /// <param name="tableName"></param>
        /// <param name="lineId"></param>
        /// <returns></returns>
        public int GetStandardCapacity(int itemId, string tableName, int lineId)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ItemId", SqlDbType.Int),
                new SqlParameter("@TableName", SqlDbType.NVarChar, 50),
                new SqlParameter("@LineId", SqlDbType.Int),
                new SqlParameter("@StantardCapacity", SqlDbType.Int),
            };
            parms[0].Value = itemId;
            parms[1].Value = tableName;
            parms[2].Value = lineId;
            parms[3].Value = 0;
            parms[3].Direction = ParameterDirection.InputOutput;    
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspGetStandardCapacity", parms);
            return (Int32)parms[3].Value;
           
        }


        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

    }
}
