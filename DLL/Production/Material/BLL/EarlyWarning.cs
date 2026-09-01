using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using SKT.Common.DAL.Marshal;
using System.Data;
using SKT.LeanMES.Material.Model;
using SKT.Common.Model;

namespace SKT.LeanMES.Material.BLL
{
    public class EarlyWarning
    {
        private int recordCount = 0;
        public void Edit(int ID, string ItemCode, string LibraryCollar, string SafetyStock, string userName)
        {
            SqlParameter[] parms = new SqlParameter[] {
                 new SqlParameter("@ID",SqlDbType.Int),
                new SqlParameter("@ItemCode",SqlDbType.NVarChar,50),
                new SqlParameter("@LibraryCollar",SqlDbType.Int),
                new SqlParameter("@SafetyStock",SqlDbType.Int),
                new SqlParameter("@UserName",SqlDbType.VarChar)
               };
            parms[0].Value = ID;
            parms[1].Value = ItemCode;
            parms[2].Value = LibraryCollar;
            parms[3].Value = SafetyStock;
            parms[4].Value = userName;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_SaveEarlyWarning", parms);
        }
        public List<EarlyWarningInfo> GetALL(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<EarlyWarningInfo> list = new List<EarlyWarningInfo>();
            EarlyWarningInfo entity = null;
            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwBasal_EarlyWarningNew", "ID",////Basal_EarlyWarning
                "[ID],[ItemCode], [LibraryCollar], [SafetyStock],isnull(CreateBy,'') as CreateBy,isnull(CreateDateTime,getdate()) as CreateDateTime,isnull(ModifyBy,'') as ModifyBy,isnull(ModifyDateTime,getdate()) as ModifyDateTime,ItemName", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new EarlyWarningInfo();
                    entity.ID = rdr.GetInt32(0);
                    entity.ItemCode = rdr.GetString(1);
                    entity.LibraryCollar = rdr.GetInt32(2);
                    entity.SafetyStock = rdr.GetInt32(3);
                    entity.CreateBy = Convert.ToString(rdr[4]);
                    entity.CreateDateTime = Convert.ToDateTime(rdr[5]);
                    entity.ModifyBy = Convert.ToString(rdr[6]);
                    entity.ModifyDateTime = Convert.ToDateTime(rdr[7]);
                    entity.ItemName = rdr.GetString(8);
                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }
        public List<EarlyWarningInfo> GetSafetyStockAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<EarlyWarningInfo> list = new List<EarlyWarningInfo>();
            EarlyWarningInfo entity = null;
            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwBasal_EarlyWarning", "ID",
                "[ID],[ItemCode], [ItemName], [BalanceQty]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new EarlyWarningInfo();
                    entity.ID = rdr.GetInt64(0);
                    entity.ItemCode = rdr.GetString(1);
                    entity.ItemName = rdr.GetString(2);
                    entity.BalanceQty = rdr.GetDecimal(3);
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
        public EarlyWarningInfo GetInfo(int ID)
        {
            EarlyWarningInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ID",SqlDbType.Int)
                };

            parms[0].Value = ID;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_EarlyWarning_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new EarlyWarningInfo();
                    entity.ItemCode = rdr.GetString(0);
                    entity.LibraryCollar = rdr.GetInt32(1);
                    entity.SafetyStock = rdr.GetInt32(2);
                }
                rdr.Close();
            }

            return entity;
        }
    }
}
