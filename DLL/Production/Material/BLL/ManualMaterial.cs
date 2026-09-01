using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.Material.Model;
using System.Data;

namespace SKT.LeanMES.Material.BLL
{
    public class ManualMaterial
    {
        private int recordCount = 0;
        public List<ManualMaterialInfo> GetALL(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ManualMaterialInfo> list = new List<ManualMaterialInfo>();
            ManualMaterialInfo entity = null;
            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwProd_MaterialCallRecord", "ProdOrderID",
                "[ProdOrderID],[OrderNO],[LineName],[ItemCode],[NeedQty],[SMTMachinePos]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new ManualMaterialInfo();
                    entity.ProdOrderID = rdr.GetInt32(0);
                    entity.OrderNO = rdr.GetString(1);
                    entity.LineName = rdr.GetString(2);
                    entity.ItemCode = rdr.GetString(3);
                    entity.NeedQty = rdr.GetDouble(4);
                    entity.SmtMachinePos = rdr.GetString(5);
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
        public List<ManualMaterialInfo> GetSubList(int id)
        {
            List<ManualMaterialInfo> list = new List<ManualMaterialInfo>();

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ID", SqlDbType.Int),
                };
            parms[0].Value = id;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetProd_MaterialCallRecord", parms))
            {
                while (rdr.Read())
                {
                    var entity = new ManualMaterialInfo();
                    entity.ItemID = rdr.IsDBNull(0) ? 0 : rdr.GetInt32(0);
                    entity.ItemCode = rdr.IsDBNull(1) ? "" : rdr.GetString(1);
                    entity.NeedQty = rdr.IsDBNull(2) ? 0 : rdr.GetDouble(2);
                    entity.SmtMachinePos = rdr.IsDBNull(3) ? "" : rdr.GetString(3);
                    entity.LineName = rdr.IsDBNull(4) ? "" : rdr.GetString(4);
                    entity.LineID = rdr.IsDBNull(5) ? 0 : rdr.GetInt32(5);
                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }
        public ManualMaterialInfo GetParentById(int id)
        {

            ManualMaterialInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ID",SqlDbType.Int)
                };

            parms[0].Value = id;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetParentInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new ManualMaterialInfo();
                    entity.OrderNO = rdr.GetString(0);
                }
                rdr.Close();
            }

            return entity;
        }
        /// <summary>
        /// 编辑（添加或更新） ManualMaterialInfo 信息。
        /// </summary>
        /// <param name="entity">ManualMaterialInfo 实体对象。</param>
        public void Edit(ManualMaterialInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ID",SqlDbType.Int),
                new SqlParameter("@ProdOrderID", SqlDbType.Int),
                new SqlParameter("@ItemId", SqlDbType.Int),
                new SqlParameter("@LineId", SqlDbType.Int),
                new SqlParameter("@NeedQty", SqlDbType.Decimal),
                new SqlParameter("@SMTMachinePos", SqlDbType.VarChar, 200)
           };
            parms[0].Value = entity.ID;
            parms[1].Value = entity.ProdOrderID;
            parms[2].Value = entity.ItemID;
            parms[3].Value = entity.LineID;
            parms[4].Value = entity.NeedQty;
            parms[5].Value = entity.SmtMachinePos;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_MaterialCallRecord_Edit", parms);
        }
        public void Delete(string Ids, string userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString",SqlDbType.VarChar,1000),
                new SqlParameter("@UserName",SqlDbType.VarChar,20)
            };
            parms[0].Value = Ids;
            parms[1].Value = userName;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_MaterialCallRecord_Delete", parms);
        }
    }
}
