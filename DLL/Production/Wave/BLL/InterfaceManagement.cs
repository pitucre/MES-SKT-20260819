using SKT.LeanMES.Wave.Model;
using SKT.Common.DAL.Marshal;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using SKT.Common.Model;
using System.Data;

namespace SKT.LeanMES.Wave.BLL
{
    public class InterfaceManagement
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 分页获取 FurnaceTemperatureCollction 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="furnaceTemperatureCollctionCount">furnaceTemperatureCollction 总数。</param>
        /// <returns>FurnaceTemperatureCollction 列表。</returns>
        public List<InterfaceManagementListInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<InterfaceManagementListInfo> list = new List<InterfaceManagementListInfo>();
            InterfaceManagementListInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwProd_InterfaceManagementList", "ID",////Prod_InterfaceManagementList
                "[ID],[DeviceType],[BrandType],[Split],[FileType],[CreateBy],[CreateTime],OKStr,NGStr,ModifyBy,ModifyTime", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new InterfaceManagementListInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2),
                        rdr.GetString(3), rdr.GetString(4), rdr.GetString(5), rdr.GetDateTime(6));
                    entity.OKStr = rdr.GetString(7);
                    entity.NGStr = rdr.GetString(8);
                    entity.ModifyBy = rdr.GetString(9);
                    entity.ModifyTime = rdr.GetDateTime(10);
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


        public Int32 Edit(InterfaceManagementListInfo entity)
        {

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ID", SqlDbType.NVarChar, 20),
                new SqlParameter("@DeviceType", SqlDbType.NVarChar, 50),
                new SqlParameter("@BrandType", SqlDbType.NVarChar, 50),
                new SqlParameter("@Split", SqlDbType.NVarChar, 50),
                new SqlParameter("@FileType", SqlDbType.NVarChar, 200),
                new SqlParameter("@CreateBy", SqlDbType.NVarChar, 50),
                new SqlParameter("@ModifyBy", SqlDbType.NVarChar, 50),
                new SqlParameter("@OKStr", SqlDbType.NVarChar, 50),
                new SqlParameter("@NGStr", SqlDbType.NVarChar, 50)
            };

            parms[0].Value = entity.ID;
            parms[1].Value = entity.DeviceType;
            parms[2].Value = entity.BrandType;
            parms[3].Value = entity.Split;
            parms[4].Value = entity.FileType;
            parms[5].Value = entity.CreateBy;
            parms[6].Value = entity.ModifyBy;
            parms[7].Value = entity.OKStr;
            parms[8].Value = entity.NGStr;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_InterfaceManagementList_Edit", parms);
            return (Int32)parms[0].Value;

        }

        #region 设备接口详情
        public List<InterfaceManagementDefInfo> GetInterfaceManagementDef(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<InterfaceManagementDefInfo> list = new List<InterfaceManagementDefInfo>();
            InterfaceManagementDefInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwInterfaceManagementDef", "ID",
                "[ID],[InterfaceManagementId],[Rows],[Segment],[Contents],[CreateBy],[CreateTime] ", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new InterfaceManagementDefInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2),
                        rdr.GetInt32(3), rdr.GetString(4), rdr.GetString(5), rdr.GetDateTime(6));
                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        public Int32 InterfaceManagementDefUpdateOrSave(InterfaceManagementDefInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ID", SqlDbType.Int, 20),
                new SqlParameter("@InterfaceManagementId", SqlDbType.NVarChar, 20),
                new SqlParameter("@Rows", SqlDbType.Int, 20),
                new SqlParameter("@Segment", SqlDbType.Int, 50),
                new SqlParameter("@Contents", SqlDbType.NVarChar, 200),
                new SqlParameter("@CreateBy", SqlDbType.NVarChar, 50),
                new SqlParameter("@ModifyBy", SqlDbType.NVarChar, 50)
            };

            parms[0].Value = entity.ID;
            parms[1].Value = entity.InterfaceManagementId;
            parms[2].Value = entity.Rows;
            parms[3].Value = entity.Segment;
            parms[4].Value = entity.Contents;
            parms[5].Value = entity.CreateBy;
            parms[6].Value = entity.ModifyBy;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_InterfaceManagementDef_Edit", parms);
            return (Int32)parms[0].Value;
        }

        #endregion

        /// <summary>
        /// 设备接口类型型号维护
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public Int32 InterfaceTypeModelEdit(InterfaceManagementListInfo entity)
        {

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ID", SqlDbType.NVarChar, 20),
                new SqlParameter("@DeviceType", SqlDbType.NVarChar, 50),
                new SqlParameter("@BrandType", SqlDbType.NVarChar, 50),
                new SqlParameter("@CreateBy", SqlDbType.NVarChar, 50),
                new SqlParameter("@ModifyBy", SqlDbType.NVarChar, 50)
            };

            parms[0].Value = entity.ID;
            parms[1].Value = entity.DeviceType;
            parms[2].Value = entity.BrandType;
            parms[3].Value = entity.CreateBy;
            parms[4].Value = entity.ModifyBy;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_InterfaceTypeModelEdit_Edit", parms);
            return (Int32)parms[0].Value;

        }
    }
}
