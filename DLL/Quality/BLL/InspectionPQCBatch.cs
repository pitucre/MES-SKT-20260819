using System.Data.SqlClient;

using SKT.LeanMES.CommonHelper.BLL;
using SKT.LeanMES.Quality.Model;
using System.Data;
using SKT.Common.DAL.Marshal;

namespace SKT.LeanMES.Quality.BLL
{
    public class InspectionPQCBatch
    {
        public void Inspect(string PQCBatchNo, int lineId, int opeId, int resId, int userId)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@PQCBatchNo",PQCBatchNo),
                new SqlParameter("@LineId",lineId),
                new SqlParameter("@OpeId",opeId),
                new SqlParameter("@ResId",resId),
                new SqlParameter("@UserID",userId)
            };

            SKT.Common.DAL.Marshal.SQLHelper.ExecuteNonQueryStoredProcedure(SKT.Common.DAL.Marshal.SQLHelper.MESConnString, "uspPQCBatchComplete", parms);
        }

        public void ValidPQCSN(string sn, int lineId)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@SN",sn),
                new SqlParameter("@LineId",lineId)
            };

            SKT.Common.DAL.Marshal.SQLHelper.ExecuteNonQueryStoredProcedure(SKT.Common.DAL.Marshal.SQLHelper.MESConnString, "uspValidPQCSN", parms);
        }

        public InspectionPQCBatchInfo GetOrGeneratePQCBatch(string sn, int lineId, string username, int prodOrderId, int IsMuiltOrder, string MuiltBatchNo)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@SN",sn),
                new SqlParameter("@LineId",lineId),
                new SqlParameter("@Username",username),
                new SqlParameter("@sProdOrderId",prodOrderId),
                new SqlParameter("@IsMuiltOrder",IsMuiltOrder),
                new SqlParameter("@MuiltBatchNo",MuiltBatchNo)
            };
            return ComMethod.Get<InspectionPQCBatchInfo>("uspGetOrGeneratePQCBatch", parms);
        }

        public void PQCBatchPushSN(string pqcBatchNo, int lineId, string sn, int opeId, int resId, string username)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@PQCBatchNo",pqcBatchNo),
                new SqlParameter("@LineId",lineId),
                new SqlParameter("@SN",sn),
                new SqlParameter("@OpeId",opeId),
                new SqlParameter("@ResId",resId),
                new SqlParameter("@Username",username)
            };

            SKT.Common.DAL.Marshal.SQLHelper.ExecuteNonQueryStoredProcedure(SKT.Common.DAL.Marshal.SQLHelper.MESConnString, "uspPQCBatchPushSN", parms);
        }

        public pInspectionInfo GetInspectByScanSN(string sn, int opeId, int resId, string username)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@SN",sn),
                new SqlParameter("@OpeId",opeId),
                new SqlParameter("@ResId",resId),
                new SqlParameter("@Username",username)
            };
            return ComMethod.Get<pInspectionInfo>("uspInspectScanSN", parms, SKT.Common.DAL.Marshal.SQLHelper.MESConnString);
        }

    }
}
