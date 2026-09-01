using System;
using System.Collections.Generic;
using System.Text;
using SKT.LeanMES.Resource.Model;
using System.Data.SqlClient;
using System.Data;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;

namespace SKT.LeanMES.Resource.BLL
{

    public class LineProdDatePeriod
    {
        private Int32 recordCount = 0;

        public DataTable GetLineProdDateList(int lineId)
        {

            DataTable table = new DataTable();

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@LineId", SqlDbType.Int, 4)

            };
            parms[0].Value = lineId;
            try
            {
                table = SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "uspGetLineProdDateList", parms);
            }
            catch (Exception)
            {

                throw;
            }
            return table;
        }

        public DataSet GetLineProdList(int lineId)
        {

            DataSet ds = new DataSet();
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@LineId", SqlDbType.Int, 4)
            };
            parms[0].Value = lineId;
            try
            {
                ds = ComMethod.GetListDataSet("uspGetLineProdList", parms);
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

    }
}