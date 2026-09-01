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
    public class ProductPQC
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） ProductPQC 信息。
        /// </summary>
        /// <param name="entity">ProductPQC 实体对象。</param>
        public Int32 Edit(ProductPQCInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ProductPQCId", SqlDbType.BigInt),
                new SqlParameter("@ProductPQCNo", SqlDbType.VarChar, 50),
                new SqlParameter("@ItemID", SqlDbType.BigInt),
                new SqlParameter("@ItemCode", SqlDbType.VarChar, 50),
                new SqlParameter("@OrderNO", SqlDbType.VarChar, 50),
                new SqlParameter("@InspectionQty", SqlDbType.Float),
                new SqlParameter("@LineId", SqlDbType.Int),
                new SqlParameter("@InspectionResult", SqlDbType.Int),
                new SqlParameter("@FinishResult", SqlDbType.Int),
                new SqlParameter("@ProdGroup", SqlDbType.VarChar, 50),
                new SqlParameter("@QualityQc", SqlDbType.VarChar, 50),
                new SqlParameter("@InspectionUser", SqlDbType.VarChar, 20),
                new SqlParameter("@Auditing", SqlDbType.VarChar, 20),
                new SqlParameter("@PrintLv", SqlDbType.VarChar, 50),
                new SqlParameter("@QualifiedQty", SqlDbType.Float),
                new SqlParameter("@CheckDate", SqlDbType.DateTime),
                new SqlParameter("@Statue", SqlDbType.Int),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 200),
                new SqlParameter("@ProdSign", SqlDbType.VarChar, 50),
                new SqlParameter("@TechSign", SqlDbType.VarChar, 50),
                new SqlParameter("@QualitySign", SqlDbType.VarChar, 50),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20)
            };

            parms[0].Value = entity.ProductPQCId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.ProductPQCNo;
            parms[2].Value = entity.ItemID;
            parms[3].Value = entity.ItemCode;
            parms[4].Value = entity.OrderNO;
            parms[5].Value = entity.InspectionQty;
            parms[6].Value = entity.LineId;
            parms[7].Value = entity.InspectionResult;
            parms[8].Value = entity.FinishResult;
            parms[9].Value = entity.ProdGroup;
            parms[10].Value = entity.QualityQc;
            parms[11].Value = entity.InspectionUser;
            parms[12].Value = entity.Auditing;
            parms[13].Value = entity.PrintLv;
            parms[14].Value = entity.QualifiedQty;
            parms[15].Value = entity.CheckDate;
            parms[16].Value = entity.Statue;
            parms[17].Value = entity.Remark;
            parms[18].Value = entity.ProdSign;
            parms[19].Value = entity.TechSign;
            parms[20].Value = entity.QualitySign;
            parms[21].Value = entity.CreateBy;
            parms[22].Value = entity.ModifyBy;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_ProductPQC_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 ProductPQCId 字符串删除 ProductPQC 信息。
        /// </summary>
        /// <param name="idString">ProductPQCId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_ProductPQC_Delete", parms);
        }

        /// <summary>
        /// 根据 ProductPQCId 获取实体信息。
        /// </summary>
        /// <param name="productPQCId">ProductPQCId。</param>
        /// <returns>ProductPQC 实体对象。</returns>
        public ProductPQCInfo GetInfo(Int32 productPQCId)
        {
            ProductPQCInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = productPQCId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_ProductPQC_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new ProductPQCInfo(rdr.GetInt64(0), rdr.GetString(1), rdr.GetInt64(2), rdr.GetString(3), rdr.GetString(4), 
                        rdr.GetDouble(5), rdr.GetInt32(6), rdr.GetInt32(7), rdr.GetInt32(8), rdr.GetString(9), 
                        rdr.GetString(10), rdr.GetString(11), rdr.GetString(12), rdr.GetString(13), rdr.GetDouble(14), 
                        rdr.GetDateTime(15), rdr.GetInt32(16), rdr.GetString(17), rdr.GetString(18), rdr.GetString(19), 
                        rdr.GetString(20), rdr.GetString(21), rdr.GetDateTime(22), rdr.GetString(23), rdr.GetDateTime(24));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>ProductPQC 实体对象。</returns>
        public ProductPQCInfo GetInfo(String fieldValue)
        {
            ProductPQCInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_ProductPQC_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new ProductPQCInfo(rdr.GetInt64(0), rdr.GetString(1), rdr.GetInt64(2), rdr.GetString(3), rdr.GetString(4), 
                        rdr.GetDouble(5), rdr.GetInt32(6), rdr.GetInt32(7), rdr.GetInt32(8), rdr.GetString(9), 
                        rdr.GetString(10), rdr.GetString(11), rdr.GetString(12), rdr.GetString(13), rdr.GetDouble(14), 
                        rdr.GetDateTime(15), rdr.GetInt32(16), rdr.GetString(17), rdr.GetString(18), rdr.GetString(19), 
                        rdr.GetString(20), rdr.GetString(21), rdr.GetDateTime(22), rdr.GetString(23), rdr.GetDateTime(24));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 ProductPQC 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="productPQCCount">productPQC 总数。</param>
        /// <returns>ProductPQC 列表。</returns>
        public List<ProductPQCInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            //表名或者视图
            string strTb = "vwProductPQCList";
            //主键
            string strKey = "ProductPQCId";
            //查询栏位字串
            string strColumns = @"[ProductPQCId], [ProductPQCNo], [ItemID], ItemCode, ItemName, OrderNO, InspectionQty, LineName, Statue, [CreateBy], [CreateDateTime]";
            return ComMethod.GetComList<ProductPQCInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);
        }				
			
        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }
        /// <summary>
        /// 根据检验单ID获取模版信息
        /// </summary>
        /// <param name="intId"></param>
        /// <returns></returns>
        public string GetPqcFormModel(Int32 intId)
        {
            SqlParameter[] parms = new SqlParameter[]{
					new SqlParameter("@ProductPQCId", SqlDbType.Int)
				};
            parms[0].Value = intId;
            return ComMethod.GetList("upsGetPQCTemplateModel", parms);
        }
        /// <summary>
        /// 根据检验单ID获取模版LCR检验项信息
        /// </summary>
        /// <param name="intIqcId">IQC单号</param>
        /// <returns></returns>
        public string GetPqcFormLcrItem(Int32 intIqcId)
        {
            SqlParameter[] parms = new SqlParameter[]{
					new SqlParameter("@InspectionId", SqlDbType.Int)
				};
            parms[0].Value = intIqcId;
            return ComMethod.GetList("upsGetPQCTemplateLcrItem", parms);
        }
        /// <summary>
        /// 保存PQC检验结果
        /// </summary>
        /// <param name="strJson"></param>
        public void SavePqcCheck(string strJson)
        {
            //ComMethod.Edit<ProductPQCInfo>(strJson, "[upsSavePQCCechkResult]");
            ComMethod.Edit(strJson, "[upsSavePQCCechkResult]");
        }
        /// <summary>
        /// 根据检验单ID获取模版检验项信息
        /// </summary>
        /// <param name="intIqcId">PQC单号</param>
        /// <param name="intTempId">模版ID</param>
        /// <returns></returns>
        public string GetPqcFormItem(Int32 intIqcId, Int32 intTempId)
        {
            SqlParameter[] parms = new SqlParameter[]{
					new SqlParameter("@InspectionId", SqlDbType.Int),
                    new SqlParameter("@TemplateId", SqlDbType.Int)
				};
            parms[0].Value = intIqcId;
            parms[1].Value = intTempId;
            return ComMethod.GetList("upsGetPQCTemplateItem", parms);
        }
        /// <summary>
        /// 获取PQC检验PDF报表文档
        /// </summary>
        /// <param name="intId"></param>
        /// <returns></returns>
        public string GetPQCFormPdf(int intId, string strTargetPath, string strXmlFilePath, string strImgPath)
        {
            try
            {
                DataSet ds = getPqcFormds(intId);
                //PDF产生
                return PDFHelper.ExportData(PDFHelper.Language.Simplified, strXmlFilePath, ds, strTargetPath, strImgPath);
            }
            catch
            {
                return "";
            }
        }
        //获取PQC送检单数据
        private static DataSet getPqcFormds(int intId)
        {
            string strSql = @"SELECT ProductPQCId,ProductPQCNo,ItemCode,ItemName,InspectionQty,ModifyDateTime FROM vwProductPQCList
                            WHERE ProductPQCId = @ProductPQCId";

            SqlParameter[] parms = new SqlParameter[]{
					new SqlParameter("@ProductPQCId", SqlDbType.Int)
				};
            parms[0].Value = intId;
            DataSet ds = ComMethod.GetListDataSetBySql(strSql, parms, "dtPQCForm");
            return ds;
        }
        /// <summary>
        /// 获取IQC检验PDF报表文档
        /// </summary>
        /// <param name="intId"></param>
        /// <returns></returns>
        public string GetPQCReportPdf(int intId, string strTargetPath, string strXmlFilePath, string strImgPath)
        {
            try
            {
                DataSet ds = getPQCPdfReportDs(intId);
                if (ds == null) return "";
                //PDF产生
                return PDFHelper.ExportData(PDFHelper.Language.Simplified, strXmlFilePath, ds, strTargetPath, strImgPath);
            }
            catch
            {
                return "";
            }
        }
        private DataSet getPQCPdfReportDs(int intId)
        {
            SqlParameter[] parms = new SqlParameter[]{
					new SqlParameter("@ProductPQCId", SqlDbType.Int)
				};
            parms[0].Value = intId;
            DataSet ds = ComMethod.GetListDataSet("upsGetPQCTemplateModel", parms, "dtPQCReport");

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
                dsTemp = ComMethod.GetListDataSet("upsGetPQCTemplateItem", parms1, "dtItem");
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
            dsTemp = ComMethod.GetListDataSet("upsGetPQCTemplateLcrItem", parms2, "dtLrc");
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

            //取得Lrc
            SqlParameter[] parms3 = new SqlParameter[]{
					new SqlParameter("@ProductPQCId", SqlDbType.Int)
				};
            parms3[0].Value = intId;
            DataSet dsDtl = new DataSet();
            dsDtl = ComMethod.GetListDataSet("upsGetProductPQCDtl", parms3, "dtDtl1");

            ds.Tables.Add(dt3);
            ds.Tables.Add(dt4);
            ds.Tables.Add(dsTemp.Tables[0].Copy());
            ds.Tables.Add(dsTemp.Tables[1].Copy());
            ds.Tables.Add(dsDtl.Tables[0].Copy());
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