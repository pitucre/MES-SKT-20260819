using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SKT.LeanMES.PackPrint.Model;
using System.Data;
using System.Data.SqlClient;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using System.Web.Script.Serialization;
using System.Reflection;
using System.Text.RegularExpressions;


namespace SKT.LeanMES.PackPrint.BLL
{
  
    public class ListPrintHistory
    {
        /// <summary>Basal_ListingDetail 信息。
        /// </summary>
        /// <param name="entity">Basal_ListingDetail 实体对象。</param>
        public Int32 Edit(ListPrintHistoryInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                  new SqlParameter("@PrintHistoryId", SqlDbType.Int),
                  new SqlParameter("@ListingTypeId", SqlDbType.Int),
                  new SqlParameter("@ItemId", SqlDbType.Int),
                  new SqlParameter("@Operator", SqlDbType.VarChar,50)

            };
            parms[0].Value = entity.PrintHistoryId;
            parms[1].Value = entity.ListingTypeId;
            parms[2].Value = entity.ItemId;
            parms[3].Value = entity.Opertor;
            int num = SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "[uspEditListPrintHistory]", parms);
            return num;
        }


    }
}
