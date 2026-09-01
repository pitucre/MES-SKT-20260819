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
    public class ListingConfig
    {
        /// <summary>
        /// 取得出货清单配置
        /// </summary>
        /// <param name="ItemCode"></param>
        /// <returns></returns>
        public List<ListingConfigInfo> GetListingConfigInfos(int ItemId,int listType)
        {
            List<ListingConfigInfo> list = new List<ListingConfigInfo>();
            ListingConfigInfo entity = null;
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ItemId", SqlDbType.Int),
                new SqlParameter("@ListingTypeId", SqlDbType.Int)
            };
            parms[0].Value = ItemId;
            parms[1].Value = listType;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "[uspGetListConfigs]", parms))
            {
                while (rdr.Read())
                {
                    entity = new ListingConfigInfo(rdr.GetInt32(0),rdr.GetInt32(1),rdr.GetString(2), rdr.GetInt32(3), rdr.GetString(4), rdr.GetString(5), rdr.GetInt32(6), rdr.GetString(7), rdr.GetDateTime(8), rdr.GetString(9), rdr.GetDateTime(10), rdr.GetString(11),rdr.GetString(12),rdr.GetInt32(13),rdr.GetInt32(14));
                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }

    }
}
