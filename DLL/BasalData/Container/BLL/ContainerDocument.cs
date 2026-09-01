using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Container.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Container.BLL
{
    public class ContainerDocument
    {
        private Int32 recordCount = 0;
        ///// <summary>
        ///// 编辑（添加或更新） ContainerDocument 信息。
        ///// </summary>
        ///// <param name="entity">ContainerDocument 实体对象。</param>
        //public Int32 Edit(ContainerDocumentInfo entity)
        //{
        //    SqlParameter[] parms = new SqlParameter[]{
        //        new SqlParameter("@ContainerDocumentId", SqlDbType.Int),
        //        new SqlParameter("@ContainerId", SqlDbType.Int),
        //        new SqlParameter("@DocumentID", SqlDbType.Int),
        //        new SqlParameter("@Seauence", SqlDbType.Decimal),
        //        new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
        //        new SqlParameter("@CreateBy", SqlDbType.VarChar, 20)
        //    };

        //    parms[0].Value = entity.ContainerDocumentId;
        //    parms[0].Direction = ParameterDirection.InputOutput;
        //    parms[1].Value = entity.ContainerId;
        //    parms[2].Value = entity.DocumentID;
        //    parms[3].Value = entity.Seauence;
        //    parms[4].Value = entity.ModifyBy;
        //    parms[5].Value = entity.CreateBy;

        //    SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_ContainerDocument_Edit", parms);

        //    return (Int32)parms[0].Value;
        //}

        /// <summary>
        /// 根据 ContainerDocumentId 字符串删除 ContainerDocument 信息。
        /// </summary>
        /// <param name="idString">ContainerDocumentId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_ContainerDocument_Delete", parms);
        }

        /// <summary>
        /// 根据 ContainerDocumentId 获取实体信息。
        /// </summary>
        /// <param name="containerDocumentId">ContainerDocumentId。</param>
        /// <returns>ContainerDocument 实体对象。</returns>
        public ContainerDocumentInfo GetInfo(Int32 containerDocumentId)
        {
            ContainerDocumentInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = containerDocumentId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_ContainerDocument_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new ContainerDocumentInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetDecimal(3), rdr.GetDateTime(4), 
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7));
                    entity.DocumentName = rdr.GetString(8);
                  
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>ContainerDocument 实体对象。</returns>
        public  List<ContainerDocumentInfo> GetInfo(String fieldValue)
        {
            List<ContainerDocumentInfo> list = new List<ContainerDocumentInfo>();
            ContainerDocumentInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_ContainerDocument_GetInfo", parms))
            {
                while (rdr.Read())
                {
                    entity = new ContainerDocumentInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetDecimal(3), rdr.GetDateTime(4), 
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7));
                    entity.DocumentName = rdr.GetString(8);
                  
                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }


        /// <summary>
        /// 分页获取 ContainerDocument 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="containerDocumentCount">containerDocument 总数。</param>
        /// <returns>ContainerDocument 列表。</returns>
        //public List<ContainerDocumentInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        //{
        //    List<ContainerDocumentInfo> list = new List<ContainerDocumentInfo>();
        //    ContainerDocumentInfo entity = null;

        //    SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Basal_ContainerDocument", "ContainerDocumentId",
        //        "[ContainerDocumentId], [ContainerId], [DocumentID], [Seauence], [ModifyDateTime], [ModifyBy], [CreateDateTime], [CreateBy]", searchSettings, sortExpression);

        //    using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
        //    {
        //        while (rdr.Read())
        //        {
        //            entity = new ContainerDocumentInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetDecimal(3), rdr.GetDateTime(4), 
        //                rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7));

        //            list.Add(entity);
        //        }
        //        rdr.Close();
        //    }

        //    recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
        //    return list;
        //}

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

        ///// <summary>
        ///// 根据容器ID得到条码变量数据集
        ///// </summary>
        ///// <param name="fieldValue">字段值。</param>
        ///// <returns>DOCUMENT 实体对象。</returns>
        //public DataTable GetProcedureByContainerID(Int32 ConID, string strWO, string BoxSN)
        //{
        //    string udpName = "";
        //    DataTable dtResult = new DataTable();

        //    /*1.获取存储过程名称*/
        //    SqlParameter[] parms = new SqlParameter[]{
        //        new SqlParameter("@conID", SqlDbType.Int),
        //        new SqlParameter("@udpname", SqlDbType.VarChar,50)
        //    };
        //    parms[0].Value = ConID;
        //    parms[1].Value = udpName;
        //    parms[1].Direction = ParameterDirection.InputOutput;

        //    SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspGetProcedureByContainer", parms);
        //    udpName = (string)parms[1].Value;

        //    if (udpName != "")
        //    {
        //        /*2.获取标签变量值*/
        //        SqlParameter[] parms1 = new SqlParameter[]{
        //        new SqlParameter("@BoxSN", SqlDbType.VarChar,50),
        //        new SqlParameter("@OrderNO", SqlDbType.VarChar,50)
        //        };

        //        parms1[0].Value = BoxSN;
        //        parms1[1].Value = strWO;
        //        dtResult = SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, udpName, parms1);
        //    }
        //    else
        //    {
        //        dtResult = null;
        //    }
        //    /*3.返回结果*/
        //    return dtResult;
        //}

        ///// <summary>
        ///// 根据容器ID得到条码ZPL名称
        ///// </summary>
        ///// <param name="fieldValue">字段值。</param>
        ///// <returns>DOCUMENT 实体对象。</returns>
        //public string GetLabelNameByContainerID(Int32 ConID)
        //{
        //    string strName = "";
        //    SqlParameter[] parms = new SqlParameter[]{
        //        new SqlParameter("@conID", SqlDbType.Int),
        //        new SqlParameter("@LabelName", SqlDbType.VarChar,50)
        //    };
        //    parms[0].Value = ConID;
        //    parms[1].Value = strName;
        //    parms[1].Direction = ParameterDirection.InputOutput;

        //    SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspGetContainerLabelNameByID", parms);
        //    strName = (string)parms[1].Value;

        //    /*返回结果*/
        //    return strName;
        //}
    }
}