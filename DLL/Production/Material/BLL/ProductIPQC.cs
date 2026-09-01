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
    public class ProductIPQC
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） ProductIPQC 信息。
        /// </summary>
        /// <param name="entity">ProductIPQC 实体对象。</param>
        public Int32 Edit(ProductIPQCInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ProductIPQCId", SqlDbType.BigInt),
                new SqlParameter("@ProductIPQCNo", SqlDbType.VarChar, 50),
                new SqlParameter("@ItemID", SqlDbType.BigInt),
                new SqlParameter("@ItemCode", SqlDbType.VarChar, 50),
                new SqlParameter("@OrderNO", SqlDbType.VarChar, 50),
                new SqlParameter("@OrderQty", SqlDbType.Float),
                new SqlParameter("@InspectionQty", SqlDbType.Float),
                new SqlParameter("@NgQty", SqlDbType.Float),
                new SqlParameter("@ShiftType", SqlDbType.Int),
                new SqlParameter("@ProdUser", SqlDbType.VarChar, 50),
                new SqlParameter("@InspectionUser", SqlDbType.VarChar, 20),
                new SqlParameter("@Auditing", SqlDbType.VarChar, 20),
                new SqlParameter("@PrintLv", SqlDbType.VarChar, 50),
                new SqlParameter("@CheckDate", SqlDbType.DateTime),
                new SqlParameter("@Statue", SqlDbType.Int),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 200),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20)
            };

            parms[0].Value = entity.ProductIPQCId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.ProductIPQCNo;
            parms[2].Value = entity.ItemID;
            parms[3].Value = entity.ItemCode;
            parms[4].Value = entity.OrderNO;
            parms[5].Value = entity.OrderQty;
            parms[6].Value = entity.InspectionQty;
            parms[7].Value = entity.NgQty;
            parms[8].Value = entity.ShiftType;
            parms[9].Value = entity.ProdUser;
            parms[10].Value = entity.InspectionUser;
            parms[11].Value = entity.Auditing;
            parms[12].Value = entity.PrintLv;
            parms[13].Value = entity.CheckDate;
            parms[14].Value = entity.Statue;
            parms[15].Value = entity.Remark;
            parms[16].Value = entity.CreateBy;
            parms[17].Value = entity.ModifyBy;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_ProductIPQC_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 ProductIPQCId 字符串删除 ProductIPQC 信息。
        /// </summary>
        /// <param name="idString">ProductIPQCId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_ProductIPQC_Delete", parms);
        }

        /// <summary>
        /// 根据 ProductIPQCId 获取实体信息。
        /// </summary>
        /// <param name="productIPQCId">ProductIPQCId。</param>
        /// <returns>ProductIPQC 实体对象。</returns>
        public ProductIPQCInfo GetInfo(Int32 productIPQCId)
        {
            ProductIPQCInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = productIPQCId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_ProductIPQC_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new ProductIPQCInfo(rdr.GetInt64(0), rdr.GetString(1), rdr.GetInt64(2), rdr.GetString(3), rdr.GetString(4), 
                        rdr.GetDouble(5), rdr.GetDouble(6), rdr.GetDouble(7), rdr.GetInt32(8), rdr.GetString(9), 
                        rdr.GetString(10), rdr.GetString(11), rdr.GetString(12), rdr.GetDateTime(13), rdr.GetInt32(14), 
                        rdr.GetString(15), rdr.GetString(16), rdr.GetDateTime(17), rdr.GetString(18), rdr.GetDateTime(19));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>ProductIPQC 实体对象。</returns>
        public ProductIPQCInfo GetInfo(String fieldValue)
        {
            ProductIPQCInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_ProductIPQC_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new ProductIPQCInfo(rdr.GetInt64(0), rdr.GetString(1), rdr.GetInt64(2), rdr.GetString(3), rdr.GetString(4), 
                        rdr.GetDouble(5), rdr.GetDouble(6), rdr.GetDouble(7), rdr.GetInt32(8), rdr.GetString(9), 
                        rdr.GetString(10), rdr.GetString(11), rdr.GetString(12), rdr.GetDateTime(13), rdr.GetInt32(14), 
                        rdr.GetString(15), rdr.GetString(16), rdr.GetDateTime(17), rdr.GetString(18), rdr.GetDateTime(19));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 ProductIPQC 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="productIPQCCount">productIPQC 总数。</param>
        /// <returns>ProductIPQC 列表。</returns>
        public List<ProductPQCInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            //表名或者视图
            string strTb = "vwProductIPQCList";
            //主键
            string strKey = "ProductPQCId";
            //查询栏位字串
            string strColumns = @"[ProductIPQCId], [ProductIPQCNo], [ItemID], ItemCode, ItemName, OrderNO, InspectionQty, Statue, [CreateBy], [CreateDateTime]";
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
        public string GetFormModel(Int32 intId)
        {
            SqlParameter[] parms = new SqlParameter[]{
					new SqlParameter("@ProductIPQCId", SqlDbType.Int)
				};
            parms[0].Value = intId;
            return ComMethod.GetList("upsGetIPQCTemplateModel", parms);
        }

        /// <summary>
        /// 获取IQC检验PDF报表文档
        /// </summary>
        /// <param name="intId"></param>
        /// <returns></returns>
        public string GetIPQCReportPdf(int intId, string strTargetPath, string strXmlFilePath, string strImgPath)
        {
            try
            {
                DataSet ds = getIPQCPdfReportDs(intId);
                if (ds == null) return "";
                //PDF产生
                return PDFHelper.ExportData(PDFHelper.Language.Simplified, strXmlFilePath, ds, strTargetPath, strImgPath);
            }
            catch (Exception ex)
            {
                return "";
            }
        }
        private DataSet getIPQCPdfReportDs(int intId)
        {
            SqlParameter[] parms = new SqlParameter[]{
					new SqlParameter("@ProductIPQCId", SqlDbType.Int)
				};
            parms[0].Value = intId;
            DataSet ds = ComMethod.GetListDataSet("upsGetIPQCTemplateModel", parms, "dtIPQCReport");

            if (ds.Tables.Count == 0) return null;

            //检验项获取
            DataTable dt3 = null;
            DataTable dt4 = null;

            DataTable dt5 = null;
            DataTable dt6 = null;
            DataSet dsTemp = new DataSet();

            //获取检验项信息ITEM
            foreach (DataRow dr in ds.Tables[1].Rows)
            {
                if (Convert.ToString(dr["InspectionTemplateName"]).IndexOf("常规生产") > -1)
                {
                    SqlParameter[] parms1 = new SqlParameter[]{
					new SqlParameter("@InspectionId", SqlDbType.Int),
                    new SqlParameter("@TemplateId", SqlDbType.Int)
				    };
                    parms1[0].Value = intId;
                    parms1[1].Value = Convert.ToInt32(dr["InspectionTemplateId"]);
                    dsTemp = ComMethod.GetListDataSet("upsGetIPQCTemplateItemS", parms1, "dtItem");
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
                else if (Convert.ToString(dr["InspectionTemplateName"]).IndexOf("生产过程") > -1)
                {
                    SqlParameter[] parms1 = new SqlParameter[]{
					new SqlParameter("@InspectionId", SqlDbType.Int),
                    new SqlParameter("@TemplateId", SqlDbType.Int)
				    };
                    parms1[0].Value = intId;
                    parms1[1].Value = Convert.ToInt32(dr["InspectionTemplateId"]);
                    dsTemp = ComMethod.GetListDataSet("upsGetIPQCTemplateItemSN", parms1, "dtSN");
                    //表结构复制
                    if (dt5 == null) dt5 = dsTemp.Tables[0].Clone();
                    if (dt6 == null) dt6 = dsTemp.Tables[1].Clone();
                    //添加Item头
                    foreach (DataRow dr3 in dsTemp.Tables[0].Rows)
                    {
                        dt5.Rows.Add(dr3.ItemArray);
                    }
                    //添加Item身
                    foreach (DataRow dr4 in dsTemp.Tables[1].Rows)
                    {
                        dt6.Rows.Add(dr4.ItemArray);
                    }
                }
            }
            ds.Tables.Add(dt3);
            ds.Tables.Add(dt4);
            ds.Tables.Add(dt5);
            ds.Tables.Add(dt6);
            //ds.Tables.Add(dsTemp.Tables[0].Copy());
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