using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.Molding.Model;

namespace SKT.LeanMES.Molding.BLL
{
    /// <summary>
    /// Des:物料烧录(IC烧录)
    /// Author:Hanson.Lei
    /// Date:2017.8.14
    /// </summary>
    public class MaterialBurn
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） MaterialBurn 信息。
        /// </summary>
        /// <param name="entity">MaterialBurn 实体对象。</param>
        public Int32 Edit(MaterialBurnInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@BurnId", SqlDbType.Int),
                new SqlParameter("@SoftName", SqlDbType.VarChar, 50),
                new SqlParameter("@SoftCreator", SqlDbType.NVarChar, 20),
                new SqlParameter("@TestMachine", SqlDbType.VarChar, 50),
                new SqlParameter("@Customer", SqlDbType.VarChar, 50),
                new SqlParameter("@Filename", SqlDbType.VarChar, 50),
                new SqlParameter("@VerifyCode", SqlDbType.VarChar, 50),
                new SqlParameter("@ReceiveDate", SqlDbType.DateTime),
                new SqlParameter("@UpdateContent", SqlDbType.VarChar, 50),
                new SqlParameter("@SoftPath", SqlDbType.VarChar, 200),
                new SqlParameter("@DownloadDir", SqlDbType.VarChar, 200),
                new SqlParameter("@Remark", SqlDbType.VarChar, 200),
                new SqlParameter("@CreateBy", SqlDbType.VarChar,20),
                new SqlParameter("@CreateTime", SqlDbType.DateTime),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar,20),
                new SqlParameter("@ModifyTime", SqlDbType.DateTime)
            };

            parms[0].Value = entity.BurnId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.SoftName;
            parms[2].Value = entity.SoftCreator;
            parms[3].Value = entity.TestMachine;
            parms[4].Value = entity.Customer;
            parms[5].Value = entity.Filename;
            parms[6].Value = entity.VerifyCode;
            parms[7].Value = entity.ReceiveDate;
            parms[8].Value = entity.UpdateContent;
            parms[9].Value = entity.SoftPath;
            parms[10].Value = entity.DownloadDir;
            parms[11].Value = entity.Remark;
            parms[12].Value = entity.CreateByName;
            parms[13].Value = entity.CreateTime;
            parms[14].Value = entity.ModifyByName;
            parms[15].Value = entity.ModifyTime;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_MaterialBurn_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 MaterialBurnId 字符串删除 MaterialBurn 信息。
        /// </summary>
        /// <param name="idString">MaterialBurnId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_MaterialBurn_Delete", parms);
        }

        /// <summary>
        /// 根据 MaterialBurnId 获取实体信息。
        /// </summary>
        /// <param name="materialBurnId">MaterialBurnId。</param>
        /// <returns>MaterialBurn 实体对象。</returns>
        public MaterialBurnInfo GetInfo(Int32 materialBurnId)
        {
            MaterialBurnInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = materialBurnId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_MaterialBurn_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new MaterialBurnInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4), rdr.GetString(5),
                        rdr.GetString(6), rdr.GetDateTime(7), rdr.GetString(8), rdr.GetString(9), rdr.GetString(10), rdr.GetString(11), rdr.GetString(12),
                        rdr.GetDateTime(13), rdr.GetString(14), rdr.GetDateTime(15));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>MaterialBurn 实体对象。</returns>
        public MaterialBurnInfo GetInfo(String fieldValue)
        {
            MaterialBurnInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_MaterialBurn_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new MaterialBurnInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4), rdr.GetString(5),
                        rdr.GetString(6), rdr.GetDateTime(7), rdr.GetString(8), rdr.GetString(9), rdr.GetString(10), rdr.GetString(11), rdr.GetString(12),
                        rdr.GetDateTime(13), rdr.GetString(14), rdr.GetDateTime(15));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 MaterialBurn 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="materialBurnCount">materialBurn 总数。</param>
        /// <returns>MaterialBurn 列表。</returns>
        public List<MaterialBurnInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MaterialBurnInfo> list = new List<MaterialBurnInfo>();
            MaterialBurnInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwProd_MaterialBurn", "BurnId",////Prod_MaterialBurn
                "BurnId, [SoftName], SoftCreator, [TestMachine], [Customer], [Filename], [VerifyCode], [ReceiveDate], [UpdateContent], [SoftPath], [DownloadDir], [Remark], [CreateBy], [CreateTime], [ModifyBy], [ModifyTime],CreateByName,ModifyByName", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaterialBurnInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4), rdr.GetString(5),
                        rdr.GetString(6), rdr.GetDateTime(7), rdr.GetString(8), rdr.GetString(9), rdr.GetString(10), rdr.GetString(11), rdr.GetString(12),
                        rdr.GetDateTime(13), rdr.GetString(14), rdr.GetDateTime(15));

                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        public List<MaterialBurnInfoDetail> GetMaterialBurnInfoDetail(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            return CommonHelper.BLL.ComMethod.GetComList<MaterialBurnInfoDetail>
                (ref recordCount,
                startRow,
                maxRows,
                "vwMaterialBurnInfoDetail",
                "BurnId",
                @"BurnId,SoftName,TestMachine,Customer,Filename,ReceiveDate,UpdateContent,SoftPath,VerifyCode,DownloadDir,SoftCreator,ItemCode,ItemName,MItemCode,MItemName",
                sortExpression,
                searchSettings);
        }
        public DataTable GetMaterialBurnInfoDetailExcle()
        {
         return SQLHelper.ExcuteDataTableSqlText(SQLHelper.MESConnString, @"select SoftName as 软件名称,TestMachine as 测试仪器,Customer as 适用客户,
                    ItemCode as 产品编码,ItemName as 产品名称,MItemCode as 物料编码,MItemName as 物料名称  from vwMaterialBurnInfoDetail");
         
        }
        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }
    }
}
