using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;

using SKT.LeanMES.CommonHelper.BLL;
using SKT.LeanMES.Quality.Model;

namespace SKT.LeanMES.Quality.BLL
{
    /// <summary>
    /// PQC检验
    /// </summary>
    public class InspectionPQC
    {
        /// <summary>
        /// 获取SN PQC的检验内容
        /// </summary>
        /// <param name="SN"></param>
        /// <returns></returns>
        public string GetInspectionTemplate(string SN, int StationId)
        {
            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@SN", SqlDbType.VarChar),
                    new SqlParameter("@StationId", SqlDbType.Int),
                };
            parms[0].Value = SN;
            parms[1].Value = StationId;
            return ComMethod.GetList("uspGetPQCInspectionTemplate", parms);
        }
    }
}
