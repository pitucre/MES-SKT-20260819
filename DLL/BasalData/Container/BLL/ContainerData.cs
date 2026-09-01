using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Container.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Container.BLL
{
    public class ContainerData
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） ContainerData 信息。
        /// </summary>
        /// <param name="entity">ContainerData 实体对象。</param>
        public Int32 Edit(ContainerDataInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@CCDataId", SqlDbType.Int),
                new SqlParameter("@ContainerNumber", SqlDbType.VarChar, 50),
                new SqlParameter("@CCID", SqlDbType.Int),
                new SqlParameter("@StatusId", SqlDbType.Int),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 50),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 50)
            };

            parms[0].Value = entity.CCDataId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.ContainerNumber;
            parms[2].Value = entity.CCID;
            parms[3].Value = entity.StatusId;
            parms[4].Value = entity.CreateBy;
            parms[5].Value = entity.ModifyBy;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_ContainerData_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 ContainerDataId 字符串删除 ContainerData 信息。
        /// </summary>
        /// <param name="idString">ContainerDataId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_ContainerData_Delete", parms);
        }

        /// <summary>
        /// 根据 ContainerDataId 获取实体信息。
        /// </summary>
        /// <param name="containerDataId">ContainerDataId。</param>
        /// <returns>ContainerData 实体对象。</returns>
        public ContainerDataInfo GetInfo(Int32 containerDataId)
        {
            ContainerDataInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = containerDataId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_ContainerData_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new ContainerDataInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetInt32(2), rdr.GetInt32(3), rdr.GetDateTime(4), 
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>ContainerData 实体对象。</returns>
        public ContainerDataInfo GetInfo(String fieldValue)
        {
            ContainerDataInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_ContainerData_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new ContainerDataInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetInt32(2), rdr.GetInt32(3), rdr.GetDateTime(4), 
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 ContainerData 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="containerDataCount">containerData 总数。</param>
        /// <returns>ContainerData 列表。</returns>
        public List<ContainerDataInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ContainerDataInfo> list = new List<ContainerDataInfo>();
            ContainerDataInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Prod_ContainerData as a INNER JOIN Prod_Order as b ON a.ProdOrderId = b.ProdOrderId", "CCDataId",
                "a.[CCDataId], a.[ContainerNumber], a.[CCID], a.[StatusId], a.[CreateDateTime], a.[CreateBy], a.[ModifyDateTime], a.[ModifyBy], OrderNO", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new ContainerDataInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetInt32(2), rdr.GetInt32(3), rdr.GetDateTime(4), 
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7));

                    entity.OrderNO = rdr.GetString(8);

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

    }
}