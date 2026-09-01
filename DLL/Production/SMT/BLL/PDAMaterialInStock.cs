using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using SKT.LeanMES.SMT.Model;
using SKT.LeanMES.CommonHelper.BLL;
using SKT.Common.DAL.Marshal;
using SKT.LeanMES.Material.Model;

namespace SKT.LeanMES.SMT.BLL
{
    public class PDAMaterialInStock
    {
        /// <summary>
        /// 生产物料入库
        /// 'a','b','c',0,'2021/1/24','micro'
        /// </summary>
        /// <param name="entity"></param>
        /// <param name="json"></param>
        /// <param name="flag"></param>
        public int MaterialInStockEdit(PDAMaterialInStockInfo entity, int flag)
        {
            SqlParameter[] parms = new SqlParameter[]
            {
                new SqlParameter("@Id", SqlDbType.Int) { Value = entity.Id },
                new SqlParameter("@EquipmentId", SqlDbType.Int) { Value = entity.EquipmentId },
                new SqlParameter("@EquipmentCode", SqlDbType.VarChar, 50) { Value = entity.EquipmentCode },
                new SqlParameter("@MaterialGRN", SqlDbType.VarChar, 50) { Value = entity.MaterialGRN },
                new SqlParameter("@MaterialCode", SqlDbType.VarChar, 50) { Value = entity.MaterialCode },
                new SqlParameter("@MaterialQty", SqlDbType.Int) { Value = entity.MaterialQty },
                new SqlParameter("@CallbackUrl", SqlDbType.NVarChar, 550) { Value = entity.CallbackUrl },
                new SqlParameter("@CallbackResult", SqlDbType.NText) { Value = entity.CallbackResult },
                new SqlParameter("@ServerNo", SqlDbType.VarChar, 50) { Value = entity.ServerNo },
                new SqlParameter("@LayerNo", SqlDbType.Int) { Value = entity.LayerNo },
                new SqlParameter("@PositionNo", SqlDbType.Int) { Value = entity.PositionNo },
                new SqlParameter("@Status", SqlDbType.Int) { Value = entity.Status },
                new SqlParameter("@flag", SqlDbType.Int) { Value = flag },
                new SqlParameter("@CreateBy", SqlDbType.NVarChar, 50) { Value = entity.CreateBy },
                new SqlParameter("@ModifyBy", SqlDbType.NVarChar, 50) { Value = entity.ModifyBy },
            };
            parms[0].Value = entity.Id;
            parms[0].Direction = ParameterDirection.InputOutput;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspPDAMaterialInStockEdit", parms);

            return Convert.ToInt32(parms[0].Value);
        }
        /// <summary>
        /// 获取领料单信息
        /// </summary>
        /// <param name="No"></param>
        /// <returns></returns>
        public List<ApplyDtlInfo> GetMaterialPrepareInfo(string WorkOrderNo)
        {
            String sqlstr = @"SELECT
                                A.[ApplyDtlId], A.[ApplyId], A.[ApplyNo], A.[ItemId], A.[ItemCode], A.[ItemName],
                                A.[Statue], A.[SourceQty], A.[ApplyQty], A.[StockQty], A.[ActiQty],
                                CASE
                                (select COUNT(1) from Prod_MaterialUnit B where B.Status=15 and B.PartId = A.ItemId)
                                WHEN 0 THEN '0' ELSE '1' END AS IsGrn,
                                A.FeatureCode,ISNULL(A.FeatureSPC,'') FeatureSPC
                                FROM  Prod_ApplyDtl A 
                                JOIN Prod_Apply B ON B.ApplyId=A.ApplyId
                                WHERE (A.Statue=0 or A.Statue=4) AND B.MOCode=@WorkOrderNo";

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@WorkOrderNo", SqlDbType.VarChar)
            };
            parms[0].Value = WorkOrderNo;
            List<ApplyDtlInfo> list = ComMethod.GetListBySql<ApplyDtlInfo>(sqlstr, parms);
            return list;
        }
    }
}
