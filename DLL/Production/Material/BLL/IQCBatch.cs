using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;
using SKT.LeanMES.Material.Model;

namespace SKT.LeanMES.Material.BLL
{
    public class IQCBatch
    {
        public static System.Resources.ResourceManager RM = new System.Resources.ResourceManager("Resources.Enum", global::System.Reflection.Assembly.Load("App_GlobalResources"));

        private Int32 recordCount = 0;

        /// <summary>
        /// 根据 IQCBatchId 字符串删除 Prod_MaterialIQCBatch 信息。
        /// </summary>
        /// <param name="idString">IQCBatchId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            ComMethod.Delete(idString, userName, "Prod_MaterialIQCBatch_Delete");
        }

        /// <summary>
        /// 根据 IQCBatchId 字符串删除 Prod_MaterialIQCBatch 信息。
        /// </summary>
        /// <param name="idString">IQCBatchId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void IQCDelete(String idString, String userName)
        {
            ComMethod.Delete(idString, userName, "Prod_MaterialIQC_Delete");
        }

        /// <summary>
        /// 根据 IQCBatchId 获取实体信息。
        /// </summary>
        /// <param name="bATCHId">IQCBatchId。</param>
        /// <returns>Prod_MaterialIQCBatch 实体对象。</returns>
        public IQCBatchInfo GetInfo(Int64 bATCHId)
        {
            return ComMethod.GetInfo<IQCBatchInfo>(bATCHId, "Prod_MaterialIQCBatch_GetInfo");
        }

        /// <summary>
        /// 根据批量检验单Id,获取对应的检验单号以及入库总数量
        /// </summary>
        /// <param name="bATCHId">IQCBatchId。</param>
        /// <returns>Prod_MaterialIQCBatch 实体对象。</returns>
        public IQCBatchInfo GetInfoForBatch(string IQCBatchIds)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IQCBatchIds", SqlDbType.NVarChar, 8000)
            };
            parms[0].Value = IQCBatchIds;
            return ComMethod.Get<IQCBatchInfo>("Prod_MaterialIQCBatch_GetInfo", parms);
        }

        /// <summary>
        /// 根据 字段值 获取实体Prod_MaterialIQCBatch信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>Prod_MaterialIQCBatch 实体对象。</returns>
        public IQCBatchInfo GetInfo(String fieldValue)
        {
            return ComMethod.GetInfo<IQCBatchInfo>(fieldValue, "Prod_MaterialIQCBatch_GetInfo");
        }

        /// <summary>
        /// 查询可入库的的检验单
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<IQCBatchInfo> GetIQCBatchNoBySearch(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {

            List<IQCBatchInfo> list = new List<IQCBatchInfo>();
            //表名或者视图
            string strTb = "vwGetDistinctPO";
            //主键
            string strKey = "POId";
            //查询栏位字串
            string strColumns = @"[PO],[POId]";
            list = ComMethod.GetComList<IQCBatchInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            return list;
        }


        /// <summary>
        /// 分页获取检验单信息
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="U811PU_ArrivalVouchCount">ERPArrivalVouchInfo(U811PU_ArrivalVouch) 总数。</param>
        /// <returns>ERPArrivalVouchInfo(U811PU_ArrivalVouch) 列表。</returns>
        public List<IQCBatchInfo> GetAllForIQCBatchInfo(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<IQCBatchInfo> list = new List<IQCBatchInfo>();
            //表名或者视图
            string strTb = "vwMaterialIQCBatch";
            //主键
            string strKey = "IQCBatchId";
            //查询栏位字串
            string strColumns = @"[IQCBatchId], [IQCBatchNO], [ItemName],[PO],[CreateDateTime],[ItemCode],[FlagName],[Qty],[QualifiedQty],[IsNeedPrintcChar],[IsVendorPrintChar],[PrintGrnQty],[GRNGetQty],[ManageResult_CN],VenCode,VenName,FlagName,ERPQty";
            list = ComMethod.GetComList<IQCBatchInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            return list;
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

        /// <summary>
        /// IQC更新批次检验结果：批过，批退，让步使用
        /// </summary>
        /// <param name="flag">0:批退，1:批过, 2:让步</param>
        /// <param name="batchNO">检验批次号</param>
        /// <param name="valueString">检验记录字符串</param>
        public void IQCBatchDeal(Int32 flag, String batchNO, String valueString)
        {
            SqlParameter[] parms = new SqlParameter[] { 
                new SqlParameter("@Flag",SqlDbType.Int),
                new SqlParameter("@BatchNO",SqlDbType.VarChar,30),
                new SqlParameter("@ValueString",SqlDbType.NText)
            };

            parms[0].Value = flag;
            parms[1].Value = batchNO;
            parms[2].Value = valueString;
            ComMethod.Edit("uspIQCBatchDeal", parms);
        }


        /// <summary>
        /// 获取IQC检验PDF报表文档
        /// </summary>
        /// <param name="intId"></param>
        /// <returns></returns>
        public string GetIQCFormPdf(int intId, string strTargetPath, string strXmlFilePath, string strImgPath)
        {
            DataSet ds = getIqcFormds(intId);
            //PDF产生
            return PDFHelper.ExportData(PDFHelper.Language.Simplified, strXmlFilePath, ds, strTargetPath, strImgPath);
        }

        /// <summary>
        /// 获取IQC检验PDF 字符流
        /// </summary>
        /// <param name="intId"></param>
        /// <returns></returns>
        public byte[] GetIQCFormByte(int intId, string strXmlFilePath, string strImgPath)
        {
            DataSet ds = getIqcFormds(intId);
            //PDF文件流
            return PDFHelper.getPDFByte(PDFHelper.Language.Simplified, strXmlFilePath, ds, strImgPath);
        }

        //获取IQC送检单数据
        private static DataSet getIqcFormds(int intId)
        {
            string strSql = @"SELECT distinct A.InspectionId, A.InspectionNo, A.POCode, A.DeliverNo, A.DeliverDtlId, A.ItemId, A.ItemCode, A.SuplierCode, A.InspectionResult, 
	                            A.InspectionUser, CONVERT(float, A.InspectionQty)InspectionQty, CONVERT(float, A.QualifiedQty) QualifiedQty, A.Status, 
	                            A.UrgentLevel, A.Remark, A.CreateBy, A.CreateDateTime, A.ModifyBy,  A.ModifyDateTime, A.IsGRN, B.ItemName, C.VendorName, 
	                            B.ItemGroupID, C.VendorCode, B.Units, '' AS Position
                            FROM Prod_MaterialIQC A INNER JOIN Basal_Item B ON A.ItemId = B.ItemId
	                            INNER JOIN Basal_Supplier C ON A.SuplierCode = C.VendorCode 
	                            LEFT JOIN ERP_PurOrderDtl D ON A.POCode = D.POCode
                            WHERE A.InspectionId = @InspectionId";

            SqlParameter[] parms = new SqlParameter[]{
					new SqlParameter("@InspectionId", SqlDbType.Int)
				};
            parms[0].Value = intId;
            DataSet ds = ComMethod.GetListDataSetBySql(strSql, parms, "dtIQCForm");
            return ds;
        }

        /// <summary>
        /// 获取IQC检验PDF报表文档
        /// </summary>
        /// <param name="intId"></param>
        /// <returns></returns>
        public string GetIQCReportPdf(int intId, string strTargetPath, string strXmlFilePath, string strImgPath)
        {
            DataSet ds = getIQCPdfReportDs(intId);
            if (ds == null) return "";
            //PDF产生
            return PDFHelper.ExportData(PDFHelper.Language.Simplified, strXmlFilePath, ds, strTargetPath, strImgPath);
        }

        /// <summary>
        /// 获取IQC检验PDF报表文档--获取PDF字符流
        /// </summary>
        /// <param name="intId"></param>
        /// <returns></returns>
        public byte[] GetIQCReportPdfByte(int intId, string strXmlFilePath, string strImgPath)
        {
            DataSet ds = getIQCPdfReportDs(intId);
            if (ds == null) return null;
            //PDF产生
            return PDFHelper.getPDFByte(PDFHelper.Language.Simplified, strXmlFilePath, ds, strImgPath);
        }

        public DataSet getIQCPdfReportDs(int intId)
        {
            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@InspectionId", SqlDbType.Int)
                };
            parms[0].Value = intId;
            DataSet ds = ComMethod.GetListDataSet("upsGetIQCTemplateModel", parms, "dtIQCReport");

            if (ds.Tables.Count == 0) return null;

            //检验项获取
            DataTable dt3 = null;
            DataTable dt4 = null;

            DataSet dsTemp = new DataSet();

            //获取检验项信息ITEM
            foreach (DataRow dr in ds.Tables[1].Rows)
            {
                SqlParameter[] parms1 = new SqlParameter[]{
                    new SqlParameter("@InspectionId", SqlDbType.Int),
                    new SqlParameter("@TemplateId", SqlDbType.Int)
                };
                parms1[0].Value = intId;
                parms1[1].Value = Convert.ToInt32(dr["InspectionTemplateId"]);
                dsTemp = ComMethod.GetListDataSet("upsGetIQCTemplateItem", parms1, "dtItem");
                //表结构复制
                if (dt3 == null) dt3 = dsTemp.Tables[0].Clone();
                if (dt4 == null) dt4 = dsTemp.Tables[1].Clone();
                //添加Item头
                foreach (DataRow dr3 in dsTemp.Tables[0].Rows)
                {
                    dt3.Rows.Add(dr3.ItemArray);
                }
                //添加Item身
                foreach (DataRow dr4 in dsTemp.Tables[1].Rows)
                {
                    dt4.Rows.Add(dr4.ItemArray);
                }
            }
            //取得Lrc
            SqlParameter[] parms2 = new SqlParameter[]{
                    new SqlParameter("@InspectionId", SqlDbType.Int)
                };
            parms2[0].Value = intId;
            //dsTemp = ComMethod.GetListDataSet("upsGetIQCTemplateLcrItem", parms2, "dtLrc");
            dsTemp = ComMethod.GetListDataSet("uspGetIQCItemDetail", parms2, "dtLrc");

            //循环取出每个检验项的检验记录
            //string[] whereArr = new string[2] { "InspectionTemplateName", "InspectionItemName" };
            //DataSet dss = new DataSet();
            //var ListTable = GroupDataRows(dsTemp.Tables[0], "", "", dss, 0);

            if (dt3 != null) {
                ds.Tables.Add(dt3);
            }
            if (dt4 != null)
            {
                ds.Tables.Add(dt4);
            }            
            ds.Tables.Add(dsTemp.Tables[0].Copy());
            ds.Tables.Add(dsTemp.Tables[1].Copy());
            //for (int i = 0; i < ListTable.Tables.Count; i++)
            //{
            //    ds.Tables.Add(ListTable.Tables[i].Copy());
            //}
            return ds;
        }

        //替换结果
        private string replaceResult(string str)
        {
            switch (str)
            {
                case "0": str = "□OK ■NG"; break;
                case "1": str = "■OK □NG"; break;
                default: str = "□OK □NG"; break;
            }
            return str;
        }
    }
}