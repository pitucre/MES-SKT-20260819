using System;
using System.Collections.Generic;
using System.Text;
using System.Data.SqlClient;
using SKT.LeanMES.MobileMat.Model;
using SKT.Common.Model;
using SKT.Common.DAL.Marshal;

namespace SKT.LeanMES.MobileMat.BLL
{
    public class Material
    {

        /// <summary>
        /// 分页获取物料的先进先出列表
        /// </summary>
        /// <param name="startRow">开始行</param>
        /// <param name="maxRows">每次取多少行</param>
        /// <param name="itemId">ItemId</param>
        /// <returns>料的先进先出列表</returns>
        public List<MaterialInfo> GetFirstInFirstOutList(Int64 itemId, Int32 startRow, Int32 maxRows)
        {
            List<MaterialInfo> list = new List<MaterialInfo>();
            MaterialInfo entity = null;

            String sortExpression = " StorageDate  ASC ";
            SearchSettings searchSettings = new SearchSettings();
            searchSettings.ExtensionCondition = " PartId =" + itemId + " And  [Status] = 4  And  BalanceQty > 0 ";

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwMaterialUnitItem", "MaterialUnitId",
                "[MaterialUnitId], [SerialNumber], [BalanceQty], [StorageDate]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaterialInfo(rdr.GetInt64(0), rdr.GetString(1), rdr.GetDecimal(2), rdr.GetDateTime(3).ToString("yyyyMMdd HH:mm:ss"));

                    list.Add(entity);
                }
                rdr.Close();
            }

            if(list.Count > 0)
            {
                list[0].Count = Convert.ToInt32(parms[parms.Length - 1].Value);
            }

            return list;
        }
    }
}
