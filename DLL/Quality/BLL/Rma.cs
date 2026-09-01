using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;
using SKT.LeanMES.Quality.Model;

namespace SKT.LeanMES.Quality.BLL
{
    public class Rma
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） InspectionTemplate 信息。
        /// </summary>
        /// <param name="entity">InspectionTemplate 实体对象。</param>
        public Int32 Edit(string strJson)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@RmaId", SqlDbType.Int),
                new SqlParameter("@RmaNo", SqlDbType.NVarChar, 50),
                new SqlParameter("@RTypeId", SqlDbType.NVarChar, 50),
                new SqlParameter("@CancelTime", SqlDbType.DateTime),
                new SqlParameter("@CustomerId", SqlDbType.Int,4),
                new SqlParameter("@MachineTypeId", SqlDbType.Int,4),
                new SqlParameter("@Number", SqlDbType.Int,4),
                new SqlParameter("@Remark", SqlDbType.NVarChar,100),
                new SqlParameter("@CreateBy", SqlDbType.NVarChar, 20),
                new SqlParameter("@FilePath", SqlDbType.NVarChar, 100),
                new SqlParameter("@RmaDetails", SqlDbType.Structured)
            };
            parms[0].Direction = ParameterDirection.InputOutput;
            ComMethod.Edit<RmaInfo>(strJson, "uspQualityRmaEidt", parms);
            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 RmaId 字符串删除 Rma 信息。
        /// </summary>
        /// <param name="idString">InspectionTemplateId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            ComMethod.Delete(idString, userName, "Quality_InspectionTemplate_Delete");
        }


        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="rmaId">字段值。</param>
        /// <returns>InspectionTemplate 实体对象。</returns>
        public RmaInfo GetInfo(int rmaId)
        {
            RmaInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@RmaId", SqlDbType.Int, 4)

            };

            parms[0].Value = rmaId;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Quality_RmaOrder_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new RmaInfo();
                    entity.RmaId = Convert.ToInt32(rdr["RmaId"]);
                    entity.RmaNo = Convert.ToString(rdr["RmaNo"]);
                    entity.RTypeId = Convert.ToInt32(rdr["RTypeId"]);
                    entity.CancelTime = Convert.ToDateTime(rdr["CancelTime"]);
                    entity.CustomerId = Convert.ToInt32(rdr["CustomerId"]);
                    entity.CustomerName = Convert.ToString(rdr["CustomerName"]);
                    entity.MachineTypeId = Convert.ToInt32(rdr["MachineTypeId"]);
                    entity.Number = Convert.ToInt32(rdr["Number"]);
                    entity.CreateBy = Convert.ToString(rdr["CreateBy"]);
                    entity.Status = Convert.ToInt32(rdr["Status"]);
                    entity.Remark = Convert.ToString(rdr["Remark"]);
                    entity.CreateTime = Convert.ToDateTime(rdr["CreateTime"]);
                    entity.MachineTypeName = Convert.ToString(rdr["ItemName"]);
                    entity.ItemCode = Convert.ToString(rdr["ItemCode"]);
                    entity.FilePath = Convert.ToString(rdr["FilePath"]);
                    entity.GoodNum = Convert.ToInt32(rdr["GoodNum"]);
                    entity.FailNum = Convert.ToInt32(rdr["FailNum"]);
                    entity.ScrapNum = Convert.ToInt32(rdr["ScrapNum"]);
                }
                rdr.Close();
            }

            return entity;

        }

        /// <summary>
        /// 分页获取 Rma 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="eQUIPMENTCount">Equipment 总数。</param>
        /// <returns>Equipment 列表。</returns>
        public List<RmaInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<RmaInfo> list = new List<RmaInfo>();
            RmaInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows,
                "vwRmaOrderList", "RmaId", @"RmaId,RmaNo ,
        RTypeId ,StatusName,
        CancelTime ,
        CustomerId ,
        MachineTypeId ,
        Number ,
        Remark ,
        Status ,
        CreateBy ,
        CreateTime ,
        IsDelete ,
        CustomerName ,
        ItemName,ItemSpec,ItemCode,FilePath,ModifyBy,ModifyTime", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new RmaInfo();

                    entity.RmaId = Convert.ToInt32(rdr["RmaId"]);
                    entity.RmaNo = Convert.ToString(rdr["RmaNo"]);
                    entity.RTypeId = Convert.ToInt32(rdr["RTypeId"]);
                    entity.StatusName = Convert.ToString(rdr["StatusName"]);

                    entity.CancelTime = Convert.ToDateTime(rdr["CancelTime"]);
                    entity.CustomerId = Convert.ToInt32(rdr["CustomerId"]);
                    entity.CustomerName = Convert.ToString(rdr["CustomerName"]);
                    entity.MachineTypeId = Convert.ToInt32(rdr["MachineTypeId"]);
                    entity.Number = Convert.ToInt32(rdr["Number"]);
                    entity.CreateBy = Convert.ToString(rdr["CreateBy"]);
                    entity.Status = Convert.ToInt32(rdr["Status"]);
                    entity.Remark = Convert.ToString(rdr["Remark"]);
                    entity.CreateTime = Convert.ToDateTime(rdr["CreateTime"]);
                    entity.MachineTypeName = Convert.ToString(rdr["ItemName"]);
                    entity.ItemCode = Convert.ToString(rdr["ItemCode"]);
                    entity.FilePath = Convert.ToString(rdr["FilePath"]);
                    entity.ItemSpec = Convert.ToString(rdr["ItemSpec"]);
                    if (!rdr.IsDBNull(rdr.GetOrdinal("ModifyTime")))
                    {
                        entity.ModifyBy = rdr["ModifyBy"].ToString();
                        entity.ModifyTime = Convert.ToDateTime(rdr["ModifyTime"]);
                    }



                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        /// <summary>
        /// 导出RMA单数据 
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        //public DataTable DtGetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        //{

        //    return ComMethod.ConvertToDataTable(GetAll(startRow, maxRows, sortExpression, searchSettings));
        //}
        public DataTable DtGetAll(string rmaNo, string cancelTime, string customerName, string itemCode, int rmaType)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@rmaNo", SqlDbType.NVarChar,50),
                new SqlParameter("@cancelTime", SqlDbType.NVarChar,50),
                new SqlParameter("@customerName", SqlDbType.NVarChar,50),
                new SqlParameter("@itemCode", SqlDbType.NVarChar,50),
                new SqlParameter("@rmaType",SqlDbType.Int,4)

            };
            parms[0].Value = rmaNo;
            parms[1].Value = cancelTime;
            parms[2].Value = customerName;
            parms[3].Value = itemCode;
            parms[4].Value = rmaType;
            return SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "uspRMAImportEXCEL", parms);
        }




        /// <summary>
        /// 获取RMA单PDF报表文档  added by zhi.li 201880807
        /// </summary>
        /// <param name="intId"></param>
        /// <returns></returns>
        public string GetRMAReportPdf(int intId, string rmaNo, string strTargetPath, string strXmlFilePath, string strImgPath)
        {
            DataSet ds = getRMAPdfReportDs(intId,rmaNo);
            if (ds == null) return "";
            //PDF产生
            return PDFHelper.ExportData(PDFHelper.Language.Simplified, strXmlFilePath, ds, strTargetPath, strImgPath);
        }

        private DataSet getRMAPdfReportDs(int intId,string rmaNo)
        {
            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@RmaId", SqlDbType.Int)
                };
            parms[0].Value = intId;
            DataSet ds = ComMethod.GetListDataSet("upsGetRMATemplateModel", parms, "dtRMAReport");

            if (ds.Tables.Count == 0) return null;

            DataSet dsTemp = new DataSet();
            //取得RMA明细信息
            SqlParameter[] parms2 = new SqlParameter[]{
                    new SqlParameter("@RmaNo", SqlDbType.VarChar,50)
                };
            parms2[0].Value = rmaNo;
            dsTemp = ComMethod.GetListDataSet("uspGetRMAItemDetail", parms2, "dtRMADtl");

            ds.Tables.Add(dsTemp.Tables[0].Copy());
            return ds;
        }


        /// <summary>
        /// 分页获取 RmaDetail 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="eQUIPMENTCount">Equipment 总数。</param>
        /// <returns>Equipment 列表。</returns>
        public List<RmaDetailInfo> GetAllDetail(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<RmaDetailInfo> list = new List<RmaDetailInfo>();
            RmaDetailInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows,
                "Basal_ReturnMaterialOrderDetail", "RmaDetailId", @"RmaDetailId,RmaNo ,
        SerialNumber ,
        RejectsDesc ,
        Remark", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new RmaDetailInfo();

                    entity.RmaDetailId = Convert.ToInt32(rdr["RmaDetailId"]);
                    entity.RmaNo = Convert.ToString(rdr["RmaNo"]);
                    entity.SerialNumber = Convert.ToString(rdr["SerialNumber"]);
                    entity.RejectsDesc = Convert.ToString(rdr["RejectsDesc"]);
                    entity.Remark = Convert.ToString(rdr["Remark"]);

                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }


        /// <summary>
        /// 获取RMA单号 
        /// </summary>
        /// <returns></returns>
        public string GetRmaNo(int serialNumberType)
        {
            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@NextNumberType", SqlDbType.Int),
                    new SqlParameter("@ItemId", SqlDbType.Int),
                    new SqlParameter("@WOID", SqlDbType.Int),
                    new SqlParameter("@SN",SqlDbType.VarChar,50)
                };
            parms[0].Value = serialNumberType;
            parms[1].Value = -1;
            parms[2].Value = -1;
            parms[3].Value = -1;
            parms[3].Direction = ParameterDirection.InputOutput;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspGenerateItemSN", parms);

            return parms[3].Value.ToString();
        }
        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

    }
}