using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SKT.LeanMES.ProdUnit.Model;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;
using System.Data.SqlClient;
using System.Data;
using SKT.Common.DAL.Marshal;

namespace SKT.LeanMES.ProdUnit.BLL
{
    public class SNScrap
    {
        private Int32 recordCount = 0;
        public List<SNScrapInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<SNScrapInfo> list = new List<SNScrapInfo>();
            //表名或者视图
            string strTb = "vwSNScrapInfo";
            //主键
            string strKey = "ID";
            //查询栏位字串
            string strColumns = @"  ID, SN, OrderNO, ItemCode, ItemName, ItemSpec, NcUserName, NcDateTime, ScrapReson, ScrapUserName, ScrapTime, ScrapType ";

            return ComMethod.GetComList<SNScrapInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);
        }

        public void RegainSNScrapt(Int32 Id, Int32 userId)
        {
            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@ID",System.Data.SqlDbType.Int),
                    new SqlParameter("@UserId",System.Data.SqlDbType.Int)
                };

            parms[0].Value = Id;
            parms[1].Value = userId;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspRegainSNScrapt", parms);
        }
        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }
    }
}
