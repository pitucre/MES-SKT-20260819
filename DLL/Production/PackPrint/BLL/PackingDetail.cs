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

using SKT.LeanMES.PackPrint.Model;

namespace SKT.LeanMES.PackPrint.BLL
{
  public  class PackingDetail
    {

        /// <summary>
        /// 取得出货清单配置
        /// </summary>
        /// <param name="ItemId"></param>
        /// <returns></returns>
      public List<PackingDetailInfo> GetPackingDetail(int ItemId)
        {
            List<PackingDetailInfo> list = new List<PackingDetailInfo>();
            PackingDetailInfo entity = null;
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ItemId", SqlDbType.Int)
            };
            parms[0].Value = ItemId;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "[uspGetPackShipmentDetail]",parms))
            {
                while (rdr.Read())
                {
                    entity = new PackingDetailInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetInt32(3));
                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }
    }
}
