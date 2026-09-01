using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Customer.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;

namespace SKT.LeanMES.Customer.BLL
{
    public class Project
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） Project 信息。
        /// </summary>
        /// <param name="entity">Project 实体对象。</param>
        public void Edit(ProjectInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ProjectId", SqlDbType.Int),
                new SqlParameter("@ProName", SqlDbType.NVarChar, 50),
                new SqlParameter("@ProDesc", SqlDbType.NVarChar, 50),
                new SqlParameter("@CustomerID", SqlDbType.Int),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 50)
            };

            parms[0].Value = entity.ProjectId;
            parms[1].Value = entity.ProName;
            parms[2].Value = entity.ProDesc;
            parms[3].Value = entity.CustomerID;
            parms[4].Value = entity.CreateBy;
            parms[5].Value = entity.ModifyBy;
            parms[6].Value = entity.Remark;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_Project_Edit", parms);
        }

        /// <summary>
        /// 根据 ProjectId 字符串删除 Project 信息。
        /// </summary>
        /// <param name="idString">ProjectId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_Project_Delete", parms);
        }

        /// <summary>
        /// 根据 ProjectId 获取实体信息。
        /// </summary>
        /// <param name="projectId">ProjectId。</param>
        /// <returns>Project 实体对象。</returns>
        public ProjectInfo GetInfo(Int32 projectId)
        {
            ProjectInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = projectId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_Project_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new ProjectInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetInt32(3), rdr.GetString(4), 
                        rdr.GetDateTime(5), rdr.GetString(6), rdr.GetDateTime(7), rdr.GetString(8));
                    entity.CustomerName = rdr.GetString(9);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>Project 实体对象。</returns>
        public ProjectInfo GetInfo(String fieldValue)
        {
            ProjectInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_Project_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new ProjectInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetInt32(3), rdr.GetString(4), 
                        rdr.GetDateTime(5), rdr.GetString(6), rdr.GetDateTime(7), rdr.GetString(8));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 Project 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="projectCount">project 总数。</param>
        /// <returns>Project 列表。</returns>
        public List<ProjectInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ProjectInfo> list = new List<ProjectInfo>();
            ProjectInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwProjectMember", "ProjectId",
                "[ProjectId], [ProName], [ProDesc], [CustomerID], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime], [Remark],[CustomerName]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new ProjectInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetInt32(3), rdr.GetString(4), 
                        rdr.GetDateTime(5), rdr.GetString(6), rdr.GetDateTime(7), rdr.GetString(8));
                    entity.CustomerName = rdr.GetString(9);
                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        #region 获取订单列表
        /// <summary>
        /// 获取订单列表
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<ProjectInfo> GetCustomerOrderAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ProjectInfo> list = new List<ProjectInfo>();
            //表名或者视图
            string strTb = "vwCustomerOrder";
            //主键
            string strKey = "CustomerOrderID";
            //查询栏位字串
            string strColumns = @"CustomerOrderID,CustomerOrder, CustomerOrder_LOT, ItemCode,ItemName,ItemSpec,Qty, CustomerCode, CustomerName, CreateBy, CreateDateTime,OrderDateTime,OpenDataStatus,OpenDataStatusName,SourceType,IsMesAdd,OrderRem,ModifyDateTime,ModifyBy";

            return ComMethod.GetComList<ProjectInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);
        }

        /// <summary>
        /// 获取订单明细列表
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<CustomerOrderDtlInfo> GetCustomerOrderDtlAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<CustomerOrderDtlInfo> list = new List<CustomerOrderDtlInfo>();
            //表名或者视图
            string strTb = "vwCustomerOrderDtl";
            //主键
            string strKey = "CusDtlId";
            //查询栏位字串
            string strColumns = @"[CusDtlId]
                                  ,[AutoID]
                                  ,[CustomerOrderID]
                                  ,[CustomerOrder]
                                  ,[ItemID]
                                  ,[ItemCode]
                                  ,[ItemName]
                                  ,[ItemSpec]
                                  ,[Qty]
                                  ,[SODType]
                                  ,[CreateBy]
                                  ,[CreateDateTime]
                                  ,[OpenDataStatus]
                                  ,[OpenDataStatusName]
                                  ,[CusDtlRem]";
            return ComMethod.GetComList<CustomerOrderDtlInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);
        }
        #endregion

        #region 获取单条订单信息
        /// <summary>
        /// 获取单条订单信息
        /// </summary>
        /// <param name="ScopeId"></param>
        /// <returns></returns>
        public ProjectInfo GetCustomerOrderInfo(Int32 ScopeId)
        {
            return CommonHelper.BLL.ComMethod.GetInfo<ProjectInfo>(ScopeId, "uspGetCustomerOrderInfo");
        }
        #endregion

        #region 保存订单信息
        /// <summary>
        /// 保存订单信息
        /// </summary>
        /// <param name="entity"></param>
        public void CustomerOrderEdit(ProjectInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@CustomerOrderID", SqlDbType.Int),
                new SqlParameter("@CustomerID", SqlDbType.Int),
                new SqlParameter("@CustomerCode", SqlDbType.VarChar, 50),
                new SqlParameter("@CustomerName", SqlDbType.VarChar, 100),
                new SqlParameter("@CustomerOrder", SqlDbType.VarChar, 100),
                new SqlParameter("@CustomerOrder_LOT", SqlDbType.VarChar, 50),
                new SqlParameter("@ItemCode", SqlDbType.VarChar, 50),
                new SqlParameter("@Qty", SqlDbType.Int),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 50)
            };

            parms[0].Value = entity.CustomerOrderID;
            parms[1].Value = entity.CustomerID;
            parms[2].Value = entity.CustomerCode;
            parms[3].Value = entity.CustomerName;
            parms[4].Value = entity.CustomerOrder;
            parms[5].Value = entity.CustomerOrder_LOT;
            parms[6].Value = entity.ItemCode;
            parms[7].Value = entity.Qty;
            parms[8].Value = entity.CreateBy;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSaveCustomerOrder", parms);

        }


        /// <summary>
        /// 编辑（添加或更新） CustomerOrder 信息。
        /// </summary>
        /// <param name="strjson">CustomerOrder json。</param>
        public void CustomerOrderEditNew(string strjson)
        {
            ComMethod.Edit(strjson, "uspSaveCustomerOrderNew");
        }

        #endregion

        #region 删除订单信息
        /// <summary>
        /// 删除订单信息
        /// </summary>
        /// <param name="idString"></param>
        /// <param name="userName"></param>
        public void DeleteCustomerOrder(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspDeleteCustomerOrder", parms);
        }
        #endregion

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

    }
}