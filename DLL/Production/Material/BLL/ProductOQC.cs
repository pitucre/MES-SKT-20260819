using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Material.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;

namespace SKT.LeanMES.Material.BLL
{
    public class ProductOQC
    {
        private Int32 recordCount = 0;
        
        /// <summary>
        /// 根据 ProductOQCId 字符串删除 ProductOQC 信息。
        /// </summary>
        /// <param name="idString">ProductOQCId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_ProductOQC_Delete", parms);
        }

        /// <summary>
        /// 根据 ProductOQCId 获取实体信息。
        /// </summary>
        /// <param name="productOQCId">ProductOQCId。</param>
        /// <returns>ProductOQC 实体对象。</returns>
        public ProductOQCInfo GetInfo(Int32 productOQCId)
        {
            ProductOQCInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = productOQCId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_ProductOQC_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = ComMethod.ToEntity<ProductOQCInfo>(rdr);
                }
                rdr.Close();
            }

            return entity;
        }
        //OQC检验单列表
        public List<ProductOQCInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {

            //表名或者视图
            string strTb = "vwProductOQCList";
            //主键
            string strKey = "ProductOQCId";
            //查询栏位字串
            string strColumns = @"[ProductOQCId], [ProductOQCNo], [OrderType], [SourceNo], [Qty], [ItemID], [ItemCode], [ItemName], Statue, CreateBy, CreateDateTime";
            return ComMethod.GetComList<ProductOQCInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);
			
        }
        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

        /// <summary>
        /// OQC检验-选择出货单
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<ProductPrepareInfo> InspectionOQCRecord(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            //表名或者视图
            string strTb = "vwInspectionOQCRecord";
            //主键
            string strKey = "ID";
            //查询栏位字串
            string strColumns = @"[ID], [Code], [RdType], [Date], [CusCode]";
            return ComMethod.GetComList<ProductPrepareInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);
        }
        /// <summary>
        /// OQC检验-根据出货单ID获取产品信息
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public string GetInspectionOQC(int id, string code)
        {
            if (id != -1)
            {
                SqlParameter[] parms = new SqlParameter[] { 
                  new SqlParameter("@ID",SqlDbType.Int)
                };
                parms[0].Value = id;
                string strSql = "select AutoID,ItemID,ItemCode,ItemName,WhID,WhCode,Batch,Qty,Code,RdType,Date,CusCode,0 as InspectionQty,0 as FinishQty from vwProductPrepareItem where ID=@ID";
                return ComMethod.GetListBySql(strSql, parms);
            }
            else
            {
                SqlParameter[] parms = new SqlParameter[] { 
                  new SqlParameter("@Code",SqlDbType.VarChar,50)
                };
                parms[0].Value = code;
                string strSql = "select AutoID,ItemID,ItemCode,ItemName,WhID,WhCode,Batch,Qty,Code,RdType,Date,CusCode,0 as InspectionQty,0 as FinishQty from vwProductPrepareItem where Code=@Code";
                return ComMethod.GetListBySql(strSql, parms);
            }
        }
        /// <summary>
        /// OQC检验-扫描产品序列号或送检批号获取产品信息
        /// </summary>
        /// <param name="txtSn"></param>
        /// <param name="txtBatch"></param>
        /// <returns></returns>
        public string GetInspectionOQCSN(string txtSn, string txtBatch)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SerialNumber", SqlDbType.NVarChar, 50), 
                new SqlParameter("@InspectionNo", SqlDbType.NVarChar, 50)
            };

            parms[0].Value = txtSn;
            parms[1].Value = txtBatch;
            return ComMethod.GetList("uspGetInspectionOQCSN", parms);
        }

        /// <summary>
        /// 根据检验单ID获取模版信息
        /// </summary>
        /// <param name="intId"></param>
        /// <returns></returns>
        public string GetOqcFormModel(Int32 intId)
        {
            SqlParameter[] parms = new SqlParameter[]{
					new SqlParameter("@ProductOQCId", SqlDbType.Int)
				};
            parms[0].Value = intId;
            return ComMethod.GetList("upsGetOQCTemplateModel", parms);
        }

        /// <summary>
        /// 根据检验单ID获取模版检验项信息
        /// </summary>
        /// <param name="intIqcId">IQC单号</param>
        /// <param name="intTempId">模版ID</param>
        /// <returns></returns>
        public string GetOqcFormItem(Int32 intIqcId, Int32 intTempId)
        {
            SqlParameter[] parms = new SqlParameter[]{
					new SqlParameter("@InspectionId", SqlDbType.Int),
                    new SqlParameter("@TemplateId", SqlDbType.Int)
				};
            parms[0].Value = intIqcId;
            parms[1].Value = intTempId;
            return ComMethod.GetList("upsGetOQCTemplateItem", parms);
        }
        /// <summary>
        /// 根据检验单ID获取模版LCR检验项信息
        /// </summary>
        /// <param name="intIqcId">IQC单号</param>
        /// <returns></returns>
        public string GetOqcFormLcrItem(Int32 intIqcId)
        {
            SqlParameter[] parms = new SqlParameter[]{
					new SqlParameter("@InspectionId", SqlDbType.Int)
				};
            parms[0].Value = intIqcId;
            return ComMethod.GetList("upsGetOQCTemplateLcrItem", parms);
        }
        /// <summary>
        /// 保存OQC检验结果
        /// </summary>
        /// <param name="strJson"></param>
        public void SaveOqcCheck(string strJson)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ProductOQCId", SqlDbType.BigInt),
                new SqlParameter("@InspectionResult", SqlDbType.Int),
                new SqlParameter("@InspectionUser", SqlDbType.VarChar, 20),
                new SqlParameter("@Auditing", SqlDbType.NVarChar, 50),
                new SqlParameter("@PrintLv", SqlDbType.NVarChar, 50),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 500),
                new SqlParameter("@ModifyBy", SqlDbType.NVarChar, 50),
                new SqlParameter("@CheckList", SqlDbType.Structured),
                new SqlParameter("@LrcList", SqlDbType.Structured)
            };
            ComMethod.Edit<ProductOQCInfo>(strJson, "[upsSaveOQCCechkResult]", parms);
        }
        /// <summary>
        /// 获取OQC检验PDF报表文档
        /// </summary>
        /// <param name="intId"></param>
        /// <returns></returns>
        public string GetOQCFormPdf(int intId, string strTargetPath, string strXmlFilePath, string strImgPath)
        {
            try
            {
                DataSet ds = getOqcFormds(intId);
                //PDF产生
                return PDFHelper.ExportData(PDFHelper.Language.Simplified, strXmlFilePath, ds, strTargetPath, strImgPath);
            }
            catch
            {
                return "";
            }
        }
        //获取OQC送检单数据
        private static DataSet getOqcFormds(int intId)
        {
            string strSql = @"SELECT * FROM [dbo].[vwProductOQCList]
                            WHERE ProductOQCId = @ProductOQCId";

            SqlParameter[] parms = new SqlParameter[]{
					new SqlParameter("@ProductOQCId", SqlDbType.Int)
				};
            parms[0].Value = intId;
            DataSet ds = ComMethod.GetListDataSetBySql(strSql, parms, "dtOQCForm");
            return ds;
        }
        /// <summary>
        /// 获取IQC检验PDF报表文档
        /// </summary>
        /// <param name="intId"></param>
        /// <returns></returns>
        public string GetOQCReportPdf(int intId, string strTargetPath, string strXmlFilePath, string strImgPath)
        {
            try
            {
                DataSet ds = getOQCPdfReportDs(intId);
                if (ds == null) return "";
                //PDF产生
                return PDFHelper.ExportData(PDFHelper.Language.Simplified, strXmlFilePath, ds, strTargetPath, strImgPath);
            }
            catch
            {
                return "";
            }
        }
        private DataSet getOQCPdfReportDs(int intId)
        {
            SqlParameter[] parms = new SqlParameter[]{
					new SqlParameter("@ProductOQCId", SqlDbType.Int)
				};
            parms[0].Value = intId;
            DataSet ds = ComMethod.GetListDataSet("upsGetOQCTemplateModel", parms, "dtOQCReport");

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
                dsTemp = ComMethod.GetListDataSet("upsGetOQCTemplateItem", parms1, "dtItem");
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
            dsTemp = ComMethod.GetListDataSet("upsGetOQCTemplateLcrItem", parms2, "dtLrc");
            int a = 0;
            foreach (DataRow drTemp in dsTemp.Tables[1].Rows)
            {
                if (drTemp["IQCLcrItemType"].ToString() == "1")
                {
                    drTemp.BeginEdit();
                    for (int i = 1; i <= 10; i++)
                    {
                        drTemp["Value" + i.ToString()] = replaceResult(drTemp["Value" + i.ToString()].ToString());
                    }
                    drTemp.EndEdit();
                }
                else if (drTemp["IQCLcrItemType"].ToString() == "2")
                {
                    drTemp.BeginEdit();
                    for (int i = 1; i <= 10; i++)
                    {
                        a++;
                        drTemp["Value" + i.ToString()] = "(" + a.ToString() + ")";
                    }
                    drTemp.EndEdit();
                }
            }

            ds.Tables.Add(dt3);
            ds.Tables.Add(dt4);
            ds.Tables.Add(dsTemp.Tables[0].Copy());
            ds.Tables.Add(dsTemp.Tables[1].Copy());
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