using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SKT.LeanMES.Quantity.Model;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;
using System.Data.SqlClient;
using SKT.Common.DAL.Marshal;
using System.Data;

namespace SKT.LeanMES.Quality.BLL
{
    public class InspectionLot
    {
        private Int32 recordCount = 0;

        /// <summary>
        /// 获取送检批次信息
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<InspectionLotInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            //表名或者视图
            string strTb = "vwGetInspectionLotInfo";
            //主键
            string strKey = "InspectionLotId";
            //查询栏位字串
            string strColumns = @"[InspectionLotId], [InspectionLotNo], [State], LotQty, ItemCode, Result, CreateDateTime, CreateBy,ItemName,LineId,LineName,ActualQty,OrderNo,ProdOrderId,SystemType,SystemTypeName";
            return ComMethod.GetComList<InspectionLotInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);
        }

        /// <summary>
        /// 获取送检项信息
        /// </summary>
        /// <param name="inspectionLotId"></param>
        /// <returns></returns>
        public List<InspectionLotMemberInfo> GetAllMemberInfo(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            //表名或者视图
            string strTb = "vwGetInspectionLotMemberInfo";
            //主键
            string strKey = "InspectionLotMemberId";

            //查询栏位字串
            string strColumns = @"[InspectionLotId],[InspectionLotMemberId], [AQLSampleName], [AQLRule], [InspectionQty],[AcQty],[ReQty],[ActualQty],[NCCodeQty], [Result], [CreateDateTime], [CreateBy],"
            + "InspectionName,InspectionTemplateName,InspectionMethodId,InspectionMethodName,InspectionMethodValue,UnitName,CheckFashion";
            return ComMethod.GetComList<InspectionLotMemberInfo>(ref recordCount, 0, -1, strTb, strKey, strColumns, "", searchSettings);
        }

        /// <summary>
        /// 获取送检SN详情
        /// </summary>
        /// <param name="inspectionLotMemberId"></param>
        /// <returns></returns>
        public List<InspectionLotMemberSNInfo> GetAllMemberSNInfo(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            //表名或者视图
            string strTb = "vwGetInspectionMemberSNInfo";
            //主键
            string strKey = "InspectionLotMemberSNId";

            //查询栏位字串
            string strColumns = @"[InspectionLotMemberSNId],[SN], [CustomerSN], Result, CreateDateTime, CreateBy,InspectionMethodValue,Value,NCCodes";
            return ComMethod.GetComList<InspectionLotMemberSNInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);
        }
        /// <summary>
        /// 获取Qc批次号对应的所有SN数据
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<InspectionLotSNInfo> GetQcSNAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<InspectionLotSNInfo> list = new List<InspectionLotSNInfo>();
            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwProMaterialMemberSuply", "UID",
               "[UID], [SN], [QcLotNo],[ItemCode],[ItemName], [CustomerSN],[ProcessSN]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspQcSNListGetPageRecords", parms))
            {
                list = ComMethod.ToListEntity<InspectionLotSNInfo>(rdr);
            }
            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }
        /// <summary>
        /// 获取Qc批次号对应的所有SN数据导出EXCEL获取数据的方法
        /// </summary>
        /// <param name="QcLotNo">QcLotNo</param>
        /// <returns></returns>
        public DataTable GetQcLotSNImportToExcel(string QcLotNo)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@QcLotNo", SqlDbType.VarChar,50)
            };
            parms[0].Value = QcLotNo;

            return SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "uspQcLotSNToEXCEL", parms);
        }
        /// <summary>
        /// 获取Qc批次检验项 数据导出EXCEL获取数据的方法
        /// </summary>
        /// <param name="ItemBomId">ItemBomId</param>
        /// <returns></returns>
        public DataTable GetQcLotItemImportToExcel(int InspectionLotId)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@InspectionLotId", SqlDbType.Int)
            };
            parms[0].Value = InspectionLotId;

            return SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "uspQcLotItemToEXCEL", parms);
        }
        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }
    }
}
