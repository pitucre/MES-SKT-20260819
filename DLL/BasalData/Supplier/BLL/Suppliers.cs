using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.Supplier.Model;
using SKT.LeanMES.CommonHelper.BLL;
using System.Text;
using System.Web.SessionState;

namespace SKT.LeanMES.Supplier.BLL
{
    public class Suppliers:IRequiresSessionState
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） Basal_Supplier 信息。
        /// </summary>
        /// <param name="entity">Basal_Supplier 实体对象。</param>
        public void Edit(SuppliersInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SupplierId", SqlDbType.Int),
                new SqlParameter("@VendorCode", SqlDbType.NVarChar, 50),
                new SqlParameter("@VendorName", SqlDbType.NVarChar, 200),
                new SqlParameter("@Description", SqlDbType.NVarChar, 100),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@VendorSort",SqlDbType.NVarChar,15),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 50),
                new SqlParameter("@VenderAddress",SqlDbType.NVarChar,200),
                new SqlParameter("@IsMesAdd", SqlDbType.Int),
                new SqlParameter("@VenUserName", SqlDbType.NVarChar, 50),
                new SqlParameter("@VenPhone", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsShipmentReport", SqlDbType.Int),
                new SqlParameter("@IsLaboratoryReport", SqlDbType.Int)

            };

            parms[0].Value = entity.SupplierId;
            parms[1].Value = entity.VendorCode;
            parms[2].Value = entity.VendorName;
            parms[3].Value = entity.Description;
            parms[4].Value = entity.CreateBy;
            parms[5].Value = entity.ModifyBy;
            parms[6].Value = entity.VendorSort;
            parms[7].Value = entity.Remark;
            parms[8].Value = entity.VendorAddress;
            parms[9].Value = entity.IsMesAdd;
            parms[10].Value = entity.VenUserName;
            parms[11].Value = entity.VenPhone;
            parms[12].Value = entity.IsShipmentReport;
            parms[13].Value = entity.IsLaboratoryReport;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_Supplier_Edit", parms);
        }
        /// <summary>
        /// 查询供应商是否存在
        /// </summary>
        /// <param name="vendorCode"></param>
        public void VendorExist(string vendorCode)
        {

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@VendorCode", SqlDbType.NVarChar, 50)
            };
            parms[0].Value = vendorCode;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCheckVendorIsExist", parms);
        }
        /// <summary>
        /// 根据 SupplierId 字符串删除 Basal_Supplier 信息。
        /// </summary>
        /// <param name="idString">SupplierId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_Supplier_Delete", parms);
        }

        /// <summary>
        /// 根据 SupplierId 获取实体信息。
        /// </summary>
        /// <param name="SupplierId">SupplierId。</param>
        /// <returns>Basal_Supplier 实体对象。</returns>
        public SuppliersInfo GetInfo(Int32 sUPPLIERId)
        {
            SuppliersInfo entity = new SuppliersInfo();

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = sUPPLIERId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_Supplier_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new SuppliersInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetDateTime(5), rdr.GetString(6), rdr.GetDateTime(7), rdr.GetString(8));
                    entity.VendorSort = rdr.GetString(9);
                    entity.VendorAddress = rdr.GetString(10);
                    entity.IsMesAdd = rdr.GetInt32(11);
                    entity.VenUserName = Convert.ToString(rdr["VenUserName"]);
                    entity.VenPhone = Convert.ToString(rdr["VenPhone"]);
                    entity.IsShipmentReport= Convert.ToInt32(rdr["IsShipmentReport"]);
                    entity.IsLaboratoryReport = Convert.ToInt32(rdr["IsLaboratoryReport"]);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>Basal_Supplier 实体对象。</returns>
        public SuppliersInfo GetInfo(String fieldValue)
        {
            SuppliersInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_Supplier_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new SuppliersInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetDateTime(5), rdr.GetString(6), rdr.GetDateTime(7), rdr.GetString(8));
                    entity.VendorSort = rdr.GetString(9);
                    entity.VendorAddress = rdr.GetString(10);
                    entity.IsMesAdd = rdr.GetInt32(11);
                    entity.VenUserName = Convert.ToString(rdr["VenUserName"]);
                    entity.VenPhone = Convert.ToString(rdr["VenPhone"]);
                    entity.IsShipmentReport = Convert.ToInt32(rdr["IsShipmentReport"]);
                    entity.IsLaboratoryReport = Convert.ToInt32(rdr["IsLaboratoryReport"]);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 Basal_Supplier 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="Basal_SupplierCount">Basal_Supplier 总数。</param>
        /// <returns>Basal_Supplier 列表。</returns>
        public List<SuppliersInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            //List<SuppliersInfo> list = new List<SuppliersInfo>();
            //SuppliersInfo entity = null;

            //Add By Alen 2015-08-11 增加Site的过滤，如果site为空则获取全部数据，否则根据site过滤
            string site = System.Configuration.ConfigurationManager.AppSettings["Site"];
            if (!String.IsNullOrEmpty(site))
            {
                searchSettings.ExtensionCondition += String.IsNullOrEmpty(searchSettings.ExtensionCondition) ? " [Site] = '" + site + "' " : " and [Site] = '" + site + "' ";
            }

            string queryColumns = "[SupplierId], [VendorCode], [VendorName], [Description], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime], [Remark], [VendorSort],[Site], [VendorAddress],IsMesAdd,VenUserName,VenPhone,DataSource,IsShipmentReport,IsLaboratoryReport";
            var list = ComMethod.GetComList<SuppliersInfo>(ref this.recordCount, startRow, maxRows, "vwSuppliersInfo", "SupplierId", queryColumns, sortExpression, searchSettings);
            return list;
            //SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Basal_Supplier", "SupplierId",
            //    "[SupplierId], [VendorCode], [VendorName], [Description], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime], [Remark], [VendorSort],[Site], [VendorAddress],IsMesAdd,ISNULL(VenUserName,'') AS VenUserName,ISNULL(VenPhone,'') AS VenPhone", searchSettings, sortExpression);

            //using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            //{
            //    while (rdr.Read())
            //    {
            //        entity = new SuppliersInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
            //            rdr.GetDateTime(5), rdr.GetString(6), rdr.GetDateTime(7), rdr.GetString(8));
            //        entity.VendorSort = rdr.GetString(9);
            //        entity.Site = rdr.GetString(10);
            //        entity.VendorAddress = rdr.GetString(11);
            //        entity.IsMesAdd = rdr.GetInt32(12);
            //        entity.VenUserName = Convert.ToString(rdr["VenUserName"]);
            //        entity.VenPhone = Convert.ToString(rdr["VenPhone"]);
            //        list.Add(entity);
            //    }
            //    rdr.Close();
            //}

            //recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            //return list;
        }
        /// <summary>
        /// 分页获取 Basal_Supplier 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="Basal_SupplierCount">Basal_Supplier 总数。</param>
        /// <returns>Basal_Supplier 列表。</returns>
        public List<SuppliersInfo> GetAllGroup(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<SuppliersInfo> list = new List<SuppliersInfo>();
            SuppliersInfo entity = null;
            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Basal_Supplier", "SupplierId",
                "[SupplierId], [VendorCode], [VendorName], [Description], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime], [Remark], [VendorSort],[Site], [VendorAddress],IsMesAdd,ISNULL(VenUserName,'') AS VenUserName,ISNULL(VenPhone,'') AS VenPhone", searchSettings, sortExpression);

            string ConnStr = Convert.ToString(System.Web.HttpContext.Current.Session["ConnStr"]);
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(ConnStr, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new SuppliersInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetDateTime(5), rdr.GetString(6), rdr.GetDateTime(7), rdr.GetString(8));
                    entity.VendorSort = rdr.GetString(9);
                    entity.Site = rdr.GetString(10);
                    entity.VendorAddress = rdr.GetString(11);
                    entity.IsMesAdd = rdr.GetInt32(12);
                    entity.VenUserName = Convert.ToString(rdr["VenUserName"]);
                    entity.VenPhone = Convert.ToString(rdr["VenPhone"]);
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

        /// <summary>
        /// 分页获取 Basal_Supplier 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="Basal_SupplierCount">Basal_Supplier 总数。</param>
        /// <returns>Basal_Supplier 列表。</returns>
        public List<SuppliersInfo> GetSupplierList(string sortExpression)
        {
            List<SuppliersInfo> list = new List<SuppliersInfo>();
            SuppliersInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(0, -1, "Basal_Supplier", "SupplierId",
                "[SupplierId], [VendorCode], [VendorName], [Description], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime], [Remark], [VendorSort], [Site],IsMesAdd", null, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new SuppliersInfo();

                    entity.SupplierId = rdr.GetInt32(0);

                    entity.VendorCode = (String.IsNullOrEmpty(rdr.GetString(1))) ? ("[" + rdr.GetString(10) + "]" + rdr.GetString(2)) : ("[" + rdr.GetString(10) + "]" + rdr.GetString(1) + "-" + rdr.GetString(2));

                    entity.IsMesAdd = Convert.ToInt32(rdr["IsMesAdd"]);
                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        /// <summary>
        /// 根据供应商编号或名称验证供应商
        /// </summary>
        /// <param name="vendorInfo">vendorcode/vendorname</param>
        /// <returns></returns>
        public SuppliersInfo ValidateVedorInfo(string vendorInfo)
        {
            SuppliersInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@VendorInfo",SqlDbType.NVarChar,200)
            };

            parms[0].Value = vendorInfo;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspValidateVedorInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new SuppliersInfo();
                    entity.SupplierId = rdr.GetInt32(0);
                    entity.VendorCode = rdr.GetString(1);
                    entity.VendorName = rdr.GetString(2);
                    entity.VendorSort = rdr.GetString(3);
                    entity.Site = rdr.GetString(4);
                    entity.Remark = rdr.GetString(5);
                    entity.Description = rdr.GetString(6);
                }
                rdr.Close();
            }
            return entity;
        }

        /// <summary>
        /// 根据 UserID获取对应信息
        /// add by weixia on 2016.9.10
        /// </summary>
        /// <param name="SupplierId">SupplierId。</param>
        /// <returns>Basal_Supplier 实体对象。</returns>
        public SuppliersInfo GetVenCodeByUserId(Int32 userId)
        {
            SuppliersInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@UserId", SqlDbType.Int)
            };

            parms[0].Value = userId;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetVendorByUserId", parms))
            {
                if (rdr.Read())
                {
                    entity = new SuppliersInfo();
                    entity.SupplierId = rdr.GetInt32(0);
                    entity.VendorCode = rdr.GetString(1);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 供应商列表导出EXCEL获取数据的方法 Sperkey.Zhong
        /// </summary>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public DataTable ImportToExcel(string sortExpression, SearchSettings searchSettings)
        {
            //Add By Alen 2015-08-11 增加Site的过滤，如果site为空则获取全部数据，否则根据site过滤
            string site = System.Configuration.ConfigurationManager.AppSettings["Site"];
            if (!String.IsNullOrEmpty(site))
            {
                searchSettings.ExtensionCondition += String.IsNullOrEmpty(searchSettings.ExtensionCondition) ? " [Site] = '" + site + "' " : " and [Site] = '" + site + "' ";
            }
            StringBuilder sb = new StringBuilder();
            sb.Append("SELECT");
            sb.Append(" [SupplierId], [VendorCode], [VendorName], [Description], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime], [Remark], [VendorSort],[Site], [VendorAddress],IsMesAdd,VenUserName,VenPhone,DataSource");
            sb.Append(" FROM vwSuppliersInfo WHERE 1 = 1");
            //动态添加参数
            List<SqlParameter> list = new List<SqlParameter>();
            foreach (var item in searchSettings.Conditions)
            {
                if (!string.IsNullOrWhiteSpace(item.Value))
                {
                    list.Add(new SqlParameter() { ParameterName = "@" + item.Key, Value = item.Value });
                    sb.AppendFormat(" AND {0} {1} {2}",
                        item.Key,
                        searchSettings.IsMatchWholeWord ? " = " : " LIKE ",
                        searchSettings.IsMatchWholeWord ? " @" + item.Key : " @" + item.Key + "+'%'");
                }
            }
            if (!string.IsNullOrEmpty(searchSettings.ExtensionCondition))
            {
                sb.AppendFormat(" AND {0}", searchSettings.ExtensionCondition);
            }
            if (!string.IsNullOrWhiteSpace(sortExpression))
            {
                sb.AppendFormat(" ORDER BY {0}", sortExpression);
            }
            SqlParameter[] parms = list.ToArray();
            string sql = sb.ToString();
            DataTable dt = SQLHelper.ExcuteDataTableSqlText(SQLHelper.MESConnString, sql, parms);
            return dt;
            //DataSet ds = ComMethod.GetTbViewListDs("vwSuppliersInfo", searchSettings, sortExpression);
            //if (ds != null && ds.Tables.Count > 0)
            //{
            //    return ds.Tables[0];
            //}
            //return null;
        }

        /// <summary>
        /// 供应商列表导出EXCEL获取数据的方法
        /// </summary>
        /// <param name="sort">查询条件</param>
        /// <param name="name">查询条件</param>
        /// <param name="ismesadd">查询条件</param>
        /// <returns></returns>
        public DataTable ImportToExcel(String sort, String name, int ismesadd, string code)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@VendorSort", SqlDbType.NVarChar,50),
                new SqlParameter("@VendorName", SqlDbType.NVarChar,50),
                new SqlParameter("@VendorCode", SqlDbType.NVarChar,50),
                new SqlParameter("@IsMesAdd", SqlDbType.Int,4)
            };
            parms[0].Value = sort;
            parms[1].Value = name;
            parms[2].Value = code;
            parms[3].Value = ismesadd;
            return SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "uspSupplierImportEXCEL", parms);
        }

        /// <summary>
        /// 验证包装的GRN条码是否合法
        /// </summary>
        /// <param name="grn"></param>
        /// <returns>
        /// 数组，str[0]: 错误类型：
        /// -1 - 有错误信息，
        ///  0 - 数据库中没有未关闭的包装箱，系统生成carton箱条码并成功包装GRN，
        ///  1 - 数据库中还有未关闭的包装箱，用户需在前台页面弹出窗口中选择carton箱进行包装GRN
        /// </returns>
        public string[] FirstValidateGRN(string grn, string cartonsn, string vendorCode, string username)
        {
            string[] str = new string[4];
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@GRN",SqlDbType.VarChar,50),
                new SqlParameter("@ErrorType",SqlDbType.Int),
                new SqlParameter("@ErrorMessage",SqlDbType.NVarChar,200),
                new SqlParameter("@UserName",SqlDbType.VarChar,20),
                new SqlParameter("@CartonSN",SqlDbType.VarChar,50),
                new SqlParameter("@VendorCode",SqlDbType.VarChar,50),
                new SqlParameter("@returnVendorCode",SqlDbType.VarChar,50),
                new SqlParameter("@PackQty",SqlDbType.Decimal,13),
            };

            parms[0].Value = grn;
            parms[1].Direction = ParameterDirection.Output;
            parms[2].Direction = ParameterDirection.Output;
            parms[3].Value = username;
            parms[4].Value = cartonsn;
            parms[5].Value = vendorCode;
            parms[6].Direction = ParameterDirection.Output;
            parms[7].Direction = ParameterDirection.Output;
            parms[7].Precision = 28;
            parms[7].Scale = 6;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspValidatePackingGRNFirst", parms);

            str[0] = parms[1].Value.ToString();
            str[1] = parms[2].Value.ToString();
            str[2] = parms[6].Value.ToString();
            str[3] = parms[7].Value.ToString().TrimEnd(new char[] { '0' }).TrimEnd(new char[] { '.' });
            return str;
        }
    }
}