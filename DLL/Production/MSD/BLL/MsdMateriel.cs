using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.MSD.Model;

namespace SKT.LeanMES.MSD.BLL
{
   public class MsdMateriel
    {


        private Int32 recordCount = 0;

        /// <summary>
        /// 分页获取MSD 物料信息资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>

        /// <returns>Item 列表。</returns>
        public List<MsdMeterielInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MsdMeterielInfo> list = new List<MsdMeterielInfo>();
            MsdMeterielInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows
                , "vwGetMsdMateriel", "ItemID",
                @"[ItemID], [ItemCode], [BakeCount], [MSL], [ItemName], [FloorLife]"
                , searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new MsdMeterielInfo();
                    entity.ItemId = Convert.ToInt32(rdr["ItemID"]);
                    entity.ItemCode =Convert.ToString(rdr["ItemCode"]);
                    entity.BakeCount = Convert.ToInt32(rdr["BakeCount"]);
                    entity.MsdLevel = Convert.ToString(rdr["MSL"]);
                    entity.ItemName = Convert.ToString(rdr["ItemName"]);
                    entity.FloorLife = Convert.ToInt32(rdr["FloorLife"]);
                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        /// <summary>
        /// 编辑（添加或更新） MsdMetriel 信息。
        /// </summary>
        /// <param name="entity">MsdMetriel 实体对象。</param>
        public Int32 Edit(MsdMeterielInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ItemId", SqlDbType.Int),
                new SqlParameter("@MsdLevel", SqlDbType.VarChar,20),
                new SqlParameter("@BakeCount", SqlDbType.Int),
                new SqlParameter("@FloorLife", SqlDbType.Int),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 100)
               
            };

            parms[0].Value = entity.ItemId;
            parms[1].Value = entity.MsdLevel;
            parms[2].Value = entity.BakeCount;
            parms[3].Value = entity.FloorLife;
            parms[4].Value = entity.Remark;
        
            return SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Msd_MsdMeteriel_Edit", parms);

        }

        /// <summary>
        /// 删除 MsdMetriel 信息。
        /// </summary>
        /// <param name="itemId">MsdMetriel 实体对象。</param>
        public Int32 Delele(int itemId)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ItemId", SqlDbType.Int)

            };

            parms[0].Value = itemId;

            return SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Msd_MsdMeteriel_Delete", parms);

        }

        /// <summary>
        /// 获取 MsdMetriel 信息。
        /// </summary>
        /// <param name="itemId">MsdMetriel 实体对象。</param>
        public MsdMeterielInfo GetInfo(int itemId)
        {
            MsdMeterielInfo entity = new MsdMeterielInfo();

            SqlParameter[] parms = new SqlParameter[]{
         
                new SqlParameter("@ItemId", SqlDbType.Int,4)
            };
            parms[0].Value = itemId;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_Item_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity.ItemId = Convert.ToInt32(rdr["ItemID"]);
                    entity.ItemCode = Convert.ToString(rdr["ItemCode"]);
                    entity.BakeCount = Convert.ToInt32(rdr["BakeCount"]);
                    entity.MsdLevel = Convert.ToString(rdr["MSL"]);
                    entity.ItemName = Convert.ToString(rdr["ItemName"]);
                    entity.FloorLife = Convert.ToInt32(rdr["FloorLife"]);

                }
                rdr.Close();
            }
            return entity;
        }


        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }
    }
}
