using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;
using SKT.LeanMES.Detection.Model;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SKT.LeanMES.Detection.BLL
{
    public class DetectionRecords
    {
        private int recordCount;

        /// <summary>
        /// 分页获取 DetectionRecords 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="detectionRecordsCount">detectionRecords 总数。</param>
        /// <returns>DetectionRecords 列表。</returns>
        public List<DetectionRecordsInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<DetectionRecordsInfo> list = new List<DetectionRecordsInfo>();
            DetectionRecordsInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwGetDetectionRecordsInfo", "DetectionRecordsId",
                "[DetectionRecordsId], [ProdOrderId], [UnitId], [SN], [StationId], [DetectionItemId], [DetectionCode], [DetectionName], [EquipmentId], [LineId], [ResId], [Result], [Files], [CreateBy], [CreateTime],OrderNO ,Station,EquipmentCode,LineName,ResName", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new DetectionRecordsInfo();

                    entity.DetectionRecordsId = rdr.GetInt64(0);
                    entity.ProdOrderId = rdr.GetInt32(1);
                    entity.UnitId = rdr.GetInt64(2);
                    entity.SN = rdr.GetString(3);
                    entity.StationId = rdr.GetInt32(4);
                    entity.DetectionItemId = rdr.GetInt32(5);
                    entity.DetectionCode = rdr.GetString(6);
                    entity.DetectionName = rdr.GetString(7);
                    entity.EquipmentId = rdr.GetInt32(8);
                    entity.LineId = rdr.GetInt32(9);
                    entity.ResId = rdr.GetInt32(10);
                    entity.Result = rdr.GetString(11);
                    entity.Files = rdr.GetString(12);
                    entity.CreateBy = rdr.GetString(13);
                    entity.CreateTime = rdr.GetDateTime(14);
                    entity.OrderNO = rdr.GetString(15);
                    entity.Station = rdr.GetString(16);
                    entity.EquipmentCode = rdr.GetString(17);
                    entity.LineName = rdr.GetString(18);
                    entity.ResName = rdr.GetString(19);
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
    }
}
