using SKT.LeanMES.Equipment.Model;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Text;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;

namespace SKT.LeanMES.Equipment.BLL
{
    public class MoldFixtureItem
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） EquipmentRepair 信息。
        /// </summary>
        /// <param name="entity">EquipmentRepair 实体对象。</param>
        public void Edit(int ItemId, int EquipmentId, decimal MoldCavity, decimal UseMoldCavity,int MoldFixtureId,string Username)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ItemId", SqlDbType.Int){ Value = ItemId},
                new SqlParameter("@EquipmentId", SqlDbType.Int){ Value = EquipmentId},
                new SqlParameter("@MoldCavity", SqlDbType.Decimal){ Value = MoldCavity},
                new SqlParameter("@UseMoldCavity", SqlDbType.Decimal){ Value = UseMoldCavity},
                new SqlParameter("@MoldFixtureId", SqlDbType.Int){ Value = MoldFixtureId},
                new SqlParameter("@CreateBy", SqlDbType.VarChar){ Value = Username},
            };

            ComMethod.Edit("Basal_MoldFixtureItem_Edit", parms);
        }

        /// <summary>
        /// 根据 EquipmentRepairId 字符串删除 EquipmentRepair 信息。
        /// </summary>
        /// <param name="idString">EquipmentRepairId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            ComMethod.Edit("Basal_MoldFixtureItem_Delete", parms);
        }

        /// <summary>
        /// 根据 cid 获取实体信息。
        /// </summary>
        /// <param name="cid">cid。</param>
        /// <returns>EquipmentRepair 实体对象。</returns>
        public MoldFixtureItemInfo GetInfo(Int32 cid)
        {
            MoldFixtureItemInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = cid;
            parms[1].Value = true;

            entity = ComMethod.Get<MoldFixtureItemInfo>("Basal_MoldFixtureItem_GetInfo", parms);

            return entity;
        }

        /// <summary>
        /// 分页获取 MoldFixtureItem 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="equipmentRepairCount">equipmentRepair 总数。</param>
        /// <returns>MoldFixtureItem 列表。</returns>
        public List<MoldFixtureItemInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            var columns = "MoldFixtureId,EquipmentName,EquipmentCode,EquipmentId,ItemID,ItemCode,ItemName,MoldCavity,ItemSpec,UseMoldCavity";
            var list = ComMethod.GetComList<MoldFixtureItemInfo>(ref recordCount, startRow, maxRows, "vwBasalMoldFixtureItem", "MoldFixtureId", columns, sortExpression, searchSettings);
            return list;
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return recordCount;
        }
    }
}
