using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.MaterialConfig.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;

namespace SKT.LeanMES.MaterialConfig.BLL
{
    public class MaterialSupplierConfig
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） MaterialSupplierConfig 信息。
        /// </summary>
        /// <param name="entity">MaterialSupplierConfig 实体对象。</param>
        public void Edit(MaterialSupplierConfigInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ID", SqlDbType.Int),
                new SqlParameter("@SupplierId", SqlDbType.Int),
                new SqlParameter("@VendorCode", SqlDbType.VarChar, 50),
                new SqlParameter("@ItemId", SqlDbType.Int),
                new SqlParameter("@ItemCode", SqlDbType.VarChar, 200),
                new SqlParameter("@PrintTypeId", SqlDbType.Int),
                new SqlParameter("@PrintType", SqlDbType.VarChar, 50),
                new SqlParameter("@Remark", SqlDbType.VarChar, 200),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20),
            };

            parms[0].Value = entity.ID;
            parms[1].Value = entity.SupplierId;
            parms[2].Value = entity.VendorCode;
            parms[3].Value = entity.ItemId;
            parms[4].Value = entity.ItemCode;
            parms[5].Value = entity.PrintTypeId;
            parms[6].Value = entity.PrintType;
            parms[7].Value = entity.Remark;
            parms[8].Value = entity.ModifyBy;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_MaterialSupplierConfig_Edit", parms);

        }

        /// <summary>
        /// 根据 MaterialSupplierConfigId 字符串删除 MaterialSupplierConfig 信息。
        /// </summary>
        /// <param name="idString">MaterialSupplierConfigId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_MaterialSupplierConfig_Delete", parms);
        }

        /// <summary>
        /// 根据 MaterialSupplierConfigId 获取实体信息。
        /// </summary>
        /// <param name="materialSupplierConfigId">MaterialSupplierConfigId。</param>
        /// <returns>MaterialSupplierConfig 实体对象。</returns>
        public MaterialSupplierConfigInfo GetInfo(Int32 materialSupplierConfigId)
        {
            MaterialSupplierConfigInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = materialSupplierConfigId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_MaterialSupplierConfig_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new MaterialSupplierConfigInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetInt32(3), rdr.GetString(4), 
                        rdr.GetInt32(5), rdr.GetString(6), rdr.GetString(7));
                }
                if (rdr.GetValue(8) != DBNull.Value)
                {
                    entity.VendorName = rdr.GetString(8);
                }
                if (rdr.GetValue(9) != DBNull.Value)
                {
                    entity.ItemName = rdr.GetString(9);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>MaterialSupplierConfig 实体对象。</returns>
        public MaterialSupplierConfigInfo GetInfo(String fieldValue)
        {
            MaterialSupplierConfigInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_MaterialSupplierConfig_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new MaterialSupplierConfigInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetInt32(3), rdr.GetString(4), 
                        rdr.GetInt32(5), rdr.GetString(6), rdr.GetString(7));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 MaterialSupplierConfig 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="materialSupplierConfigCount">materialSupplierConfig 总数。</param>
        /// <returns>MaterialSupplierConfig 列表。</returns>
        public List<MaterialSupplierConfigInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MaterialSupplierConfigInfo> list = new List<MaterialSupplierConfigInfo>();
            MaterialSupplierConfigInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows
                , "[vwMaterialSupplierConfig]"
                , "ID"
                , "[ID], [SupplierId], [VendorCode], [ItemId], [ItemCode], [PrintTypeId], [PrintType], [Remark], VendorName,ItemName,CreateBy,CreateDate,ModifyBy,ModifyDate", 
                searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaterialSupplierConfigInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetInt32(3), rdr.GetString(4), 
                        rdr.GetInt32(5), rdr.GetString(6), rdr.GetString(7));
                    if (rdr.GetValue(8) != DBNull.Value)
                    {
                        entity.VendorName = rdr.GetString(8);
                    }
                    if (rdr.GetValue(9) != DBNull.Value)
                    {
                        entity.ItemName = rdr.GetString(9);
                    }
                    entity.CreateBy = Convert.ToString(rdr[10]);
                    entity.CreateDateTime = Convert.ToDateTime(rdr[11]);
                    entity.ModifyBy = Convert.ToString(rdr[12]);
                    entity.ModifyDate = Convert.ToDateTime(rdr[13]);
                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        #region 获取离线标签配置信息LIST
        /// <summary>
        /// 获取离线标签配置信息LIST
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<MaterialSupplierConfigInfo> GetOffLineLabelConfigList(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MaterialSupplierConfigInfo> list = new List<MaterialSupplierConfigInfo>();
            //表名或者视图
            string strTb = "vwProd_OffLineLabelConfig";////Prod_OffLineLabelConfig
            //主键
            string strKey = "LabelID";
            //查询栏位字串
            string strColumns = @"LabelID,VendorID,VendorCode,VendorName,Delimiter,Remark,CreateBy,CreateDateTime,ModifyBy,ModifyTime";
            list = ComMethod.GetComList<MaterialSupplierConfigInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            return list;
        }
        #endregion

        #region 获取离线标签配置信息INFO
        /// <summary>
        /// 获取离线标签配置信息INFO
        /// </summary>
        /// <param name="LabelID"></param>
        /// <returns></returns>
        public MaterialSupplierConfigInfo GetOffLineLabelConfigInfo(Int32 LabelID)
        {
            //return ComMethod.GetInfo<MaterialSupplierConfigInfo>(LabelID, "uspGetOffLineLabelConfigInfo");
            MaterialSupplierConfigInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@LabelID", SqlDbType.Int)
            };
            parms[0].Value = LabelID;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetOffLineLabelConfigInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new MaterialSupplierConfigInfo();
                    entity.VendorID = rdr.GetInt32(0);
                    entity.VendorCode = rdr.GetString(1);
                    entity.VendorName = rdr.GetString(2);
                    entity.Delimiter = rdr.GetString(3);
                    entity.Remark = rdr.GetString(4);
                }
                rdr.Close();
            }

            return entity;
        }
        #endregion

        #region 保存离线标签配置信息
        /// <summary>
        /// 保存离线标签配置信息
        /// </summary>
        /// <param name="entity"></param>
        public void OffLineLabelConfigEdit(MaterialSupplierConfigInfo entity, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@LabelID", SqlDbType.Int),
                new SqlParameter("@VendorID", SqlDbType.Int),
                new SqlParameter("@VendorCode", SqlDbType.VarChar, 100),
                new SqlParameter("@VendorName", SqlDbType.VarChar, 100),
                new SqlParameter("@Delimiter", SqlDbType.VarChar, 10),
                new SqlParameter("@Remark", SqlDbType.VarChar, 100),
                new SqlParameter("@UserName", SqlDbType.VarChar, 100)
            };

            parms[0].Value = entity.LabelID;
            parms[1].Value = entity.VendorID;
            parms[2].Value = entity.VendorCode;
            parms[3].Value = entity.VendorName;
            parms[4].Value = entity.Delimiter;
            parms[5].Value = entity.Remark;
            parms[6].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspOffLineLabelConfigEdit", parms);

        }
        #endregion

        #region 删除离线标签配置信息
        /// <summary>
        /// 删除离线标签配置信息
        /// </summary>
        /// <param name="idString"></param>
        /// <param name="userName"></param>
        public void DeleteOffLineLabelConfig(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspDeleteOffLineLabelConfig", parms);
        }
        #endregion

        #region 获取离线标签配置明细信息LIST
        /// <summary>
        /// 获取离线标签配置明细信息LIST
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<MaterialSupplierConfigInfo> GetOffLineLabelConfigDetailList(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MaterialSupplierConfigInfo> list = new List<MaterialSupplierConfigInfo>();
            //表名或者视图
            string strTb = "VWOffLineLabelConfigDetail";
            //主键
            string strKey = "DetailID";
            //查询栏位字串
            string strColumns = @"DetailID,LabelID,DetailContent,Paragraph,CreateBy,CreateDateTime,ModifyBy,ModifyTime";
            list = ComMethod.GetComList<MaterialSupplierConfigInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            return list;
        }
        #endregion

        #region 获取离线标签配置明细信息INFO
        /// <summary>
        /// 获取离线标签配置明细信息INFO
        /// </summary>
        /// <param name="LabelID"></param>
        /// <returns></returns>
        public MaterialSupplierConfigInfo GetOffLineLabelConfigDetaiInfo(Int32 DetailID)
        {
            //return ComMethod.GetInfo<MaterialSupplierConfigInfo>(LabelID, "uspGetOffLineLabelConfigInfo");
            MaterialSupplierConfigInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@DetailID", SqlDbType.Int)
            };
            parms[0].Value = DetailID;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetOffLineLabelConfigDetaiInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new MaterialSupplierConfigInfo();
                    entity.Paragraph = rdr.GetInt32(0);
                    entity.DetailContent = rdr.GetString(1);
                }
                rdr.Close();
            }

            return entity;
        }
        #endregion

        #region 保存离线标签配置细项信息
        /// <summary>
        /// 保存离线标签配置细项信息
        /// </summary>
        /// <param name="entity"></param>
        public void OffLineLabelConfigDetaiEdit(MaterialSupplierConfigInfo entity, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@DetailID", SqlDbType.Int),
                new SqlParameter("@LabelID", SqlDbType.Int),
                new SqlParameter("@DetailContent", SqlDbType.VarChar, 100),
                new SqlParameter("@Paragraph", SqlDbType.Int),
                new SqlParameter("@UserName", SqlDbType.VarChar, 100)
            };

            parms[0].Value = entity.DetailID;
            parms[1].Value = entity.LabelID;
            parms[2].Value = entity.DetailContent;
            parms[3].Value = entity.Paragraph;
            parms[4].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspOffLineLabelConfigDetaiEdit", parms);

        }
        #endregion

        #region 删除离线标签配细项置信息
        /// <summary>
        /// 删除离线标签配细项置信息
        /// </summary>
        /// <param name="idString"></param>
        /// <param name="userName"></param>
        public void DeleteOffLineLabelConfigDetai(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspDeleteOffLineLabelConfigDetai", parms);
        }
        #endregion

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

    }
}