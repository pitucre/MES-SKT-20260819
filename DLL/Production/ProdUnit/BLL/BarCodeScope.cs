using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;
using SKT.LeanMES.ProdUnit.Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;

namespace SKT.LeanMES.ProdUnit.BLL
{
    public class BarCodeScope
    {
        private Int32 recordCount = 0;

        #region 获取号码范围信息
        /// <summary>
        /// 获取条码列表信息
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<BarCodeScopeInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<BarCodeScopeInfo> list = new List<BarCodeScopeInfo>();
            //表名或者视图
            string strTb = "vwProd_BarCodeScope";////Prod_BarCodeScope
            //主键
            string strKey = "ScopeId";
            //查询栏位字串
            string strColumns = @" ScopeId, NumberType, OrderNo, CustomerOrder, NumberBegin, NumberEnd,
					 Prefix, Suffix, SerialBegin, SerialEnd, SerialLength, Qty,
					 SpecialStr, Increase,IsMain,Fixed, CreateBy, CreateDateTime,ModifyBy,ModifyTime";

            return ComMethod.GetComList<BarCodeScopeInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);
        }
        #endregion

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

        #region 保存号码范围信息
        /// <summary>
        /// 保存号码范围信息
        /// </summary>
        /// <param name="entity"></param>
        public void BarCodeScopeSetEdit(int ScopeId, string OrderNo, string CustomerOrder, int Qty, DataTable dt,string UserName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ScopeId", SqlDbType.Int),
                new SqlParameter("@OrderNo", SqlDbType.VarChar, 100),
                new SqlParameter("@CustomerOrder", SqlDbType.VarChar, 100),
                new SqlParameter("@Qty", SqlDbType.Int),
                new SqlParameter("@NumberTypeList",SqlDbType.Structured),
                new SqlParameter("@UserName", SqlDbType.VarChar, 50)
            };

            parms[0].Value = ScopeId;
            parms[1].Value = OrderNo;
            parms[2].Value = CustomerOrder;
            parms[3].Value = Qty;
            parms[4].Value = dt;
            parms[5].Value = UserName;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSaveBarCodeScopeSet", 20000000,parms);

        }
        #endregion

        #region 获取单条号码范围信息
        /// <summary>
        /// 获取单条号码范围信息
        /// </summary>
        /// <param name="ScopeId"></param>
        /// <returns></returns>
        public BarCodeScopeInfo GetBarCodeScopeSetInfo(Int32 ScopeId)
        {
            return CommonHelper.BLL.ComMethod.GetInfo<BarCodeScopeInfo>(ScopeId, "uspGetBarCodeScopeSetInfo");
        }
        #endregion

        #region 删除条码范围信息
        /// <summary>
        /// 删除条码范围信息
        /// </summary>
        /// <param name="idString"></param>
        /// <param name="userName"></param>
        public void DeleteBarCodeScopeSet(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspDeleteBarCodeScopeSet", parms);
        }
        #endregion

        #region 获取号码范围条码列表
        /// <summary>
        /// 获取号码范围条码列表
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<BarCodeScopeInfo> GetSerialNumberAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<BarCodeScopeInfo> list = new List<BarCodeScopeInfo>();
            //表名或者视图
            string strTb = "vwProd_BarCodeScopeDtl";////Prod_BarCodeScopeDtl
            //主键
            string strKey = "SerialNumberID";
            //查询栏位字串
            string strColumns = @"SerialNumberID, NumberType, ScopeId, OrderNo, CustomerOrder, SerialNumber, CreateBy, CreateDateTime,NumberID,Status";

            return ComMethod.GetComList<BarCodeScopeInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);
        }
        #endregion

        #region 获取号码类型
        /// <summary>
        /// 获取号码类型
        /// </summary>
        /// <returns></returns>
        public List<BarCodeScopeInfo> GeNumberTypeALL()
        {
            List<BarCodeScopeInfo> entity = new List<BarCodeScopeInfo>();
            try
            {
                string cmdTxt = string.Format("SELECT BarCodeType FROM dbo.Basal_BarCodeType GROUP BY BarCodeType");
                DataTable dt = SQLHelper.ExcuteDataTableSqlText(SQLHelper.MESConnString, cmdTxt, null);
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    BarCodeScopeInfo t = new BarCodeScopeInfo();
                    t.NumberType = dt.Rows[i][0].ToString();
                    entity.Add(t);
                }
            }
            catch (Exception ex)
            {
            }
            return entity;

        }
        #endregion

        #region 根据工单号查询号码类型
        /// <summary>
        /// 根据工单号查询号码类型
        /// </summary>
        /// <param name="OrderNo"></param>
        /// <returns></returns>
        public List<BarCodeScopeInfo> QueryBarType(string OrderNo)
        {
            List<BarCodeScopeInfo> list = new List<BarCodeScopeInfo>();
            BarCodeScopeInfo entity = null;
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@OrderNo",SqlDbType.VarChar,100)
            };
            parms[0].Value = OrderNo;
            using (DataTable dt = SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "uspQueryBarType", parms))
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    entity = new BarCodeScopeInfo();
                    entity.ScopeId = int.Parse(dt.Rows[i]["ScopeId"].ToString());
                    entity.NumberType = dt.Rows[i]["NumberType"].ToString();
                    entity.OrderNo = dt.Rows[i]["OrderNo"].ToString();
                    entity.CustomerOrder = dt.Rows[i]["CustomerOrder"].ToString();
                    entity.NumberBegin = dt.Rows[i]["NumberBegin"].ToString();
                    entity.NumberEnd = dt.Rows[i]["NumberEnd"].ToString();
                    entity.Prefix = dt.Rows[i]["Prefix"].ToString();
                    entity.Suffix = dt.Rows[i]["Suffix"].ToString();
                    entity.SerialBegin = dt.Rows[i]["SerialBegin"].ToString();
                    entity.SerialEnd = dt.Rows[i]["SerialEnd"].ToString();
                    entity.SerialLength = int.Parse(dt.Rows[i]["SerialLength"].ToString());
                    entity.Qty = int.Parse(dt.Rows[i]["Qty"].ToString());
                    entity.SpecialStr = dt.Rows[i]["SpecialStr"].ToString();
                    entity.Increase = int.Parse(dt.Rows[i]["Increase"].ToString());
                    entity.NumberClass = dt.Rows[i]["NumberClass"].ToString();
                    entity.IsMain = dt.Rows[i]["IsMain"].ToString();
                    entity.Fixed = dt.Rows[i]["Fixed"].ToString();
                    list.Add(entity);
                }
            }
            return list;
        }
        #endregion

        #region 获取包装对应关系信息
        /// <summary>
        /// 获取包装对应关系信息
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<BarCodeScopeInfo> GetPackRelationAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<BarCodeScopeInfo> list = new List<BarCodeScopeInfo>();
            //表名或者视图
            string strTb = "vwProd_PackRelation";////Prod_PackRelation
            //主键
            string strKey = "ScopeId";
            //查询栏位字串
            string strColumns = @" ScopeId, NumberType, OrderNo, CustomerOrder,
					 Prefix, Suffix, SerialBegin, SerialEnd, SerialLength, Qty,
					 NumberBegin, NumberEnd, CreateBy, CreateDateTime,Increase,ModifyBy,ModifyTime";

            return ComMethod.GetComList<BarCodeScopeInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);
        }
        #endregion

        #region 保存包装对应关系
        /// <summary>
        /// 保存包装对应关系
        /// </summary>
        /// <param name="entity"></param>
        public void PackRelationEdit(int ScopeId, string OrderNo, string CustomerOrder, int Qty, DataTable dt, string UserName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ScopeId", SqlDbType.Int),
                new SqlParameter("@OrderNo", SqlDbType.VarChar, 100),
                new SqlParameter("@CustomerOrder", SqlDbType.VarChar, 100),
                new SqlParameter("@Qty", SqlDbType.Int),
                new SqlParameter("@NumberTypeList",SqlDbType.Structured),
                new SqlParameter("@UserName", SqlDbType.VarChar, 50)
            };

            parms[0].Value = ScopeId;
            parms[1].Value = OrderNo;
            parms[2].Value = CustomerOrder;
            parms[3].Value = Qty;
            parms[4].Value = dt;
            parms[5].Value = UserName;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSavePackRelationEdit", parms);

        }
        #endregion

        #region 根据工单号查询号码类型
        /// <summary>
        /// 根据工单号查询号码类型
        /// </summary>
        /// <param name="OrderNo"></param>
        /// <returns></returns>
        public List<BarCodeScopeInfo> QueryPackRelation(string OrderNo)
        {
            //List<BarCodeScopeInfo> list = new List<BarCodeScopeInfo>();
            //BarCodeScopeInfo entity = null;
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@OrderNo",SqlDbType.VarChar,100)
            };
            parms[0].Value = OrderNo;
            //using (DataTable dt = SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "uspQueryPackRelation", parms))
            //{
            //    for (int i = 0; i < dt.Rows.Count; i++)
            //    {
            //        entity = new BarCodeScopeInfo();
            //        entity.ScopeId = int.Parse(dt.Rows[i]["ScopeId"].ToString());
            //        entity.NumberType = dt.Rows[i]["NumberType"].ToString();
            //        entity.OrderNo = dt.Rows[i]["OrderNo"].ToString();
            //        entity.CustomerOrder = dt.Rows[i]["CustomerOrder"].ToString();
            //        entity.NumberBegin = dt.Rows[i]["NumberBegin"].ToString();
            //        entity.NumberEnd = dt.Rows[i]["NumberEnd"].ToString();
            //        entity.Prefix = dt.Rows[i]["Prefix"].ToString();
            //        entity.Suffix = dt.Rows[i]["Suffix"].ToString();
            //        entity.SerialBegin = dt.Rows[i]["SerialBegin"].ToString();
            //        entity.SerialEnd = dt.Rows[i]["SerialEnd"].ToString();
            //        entity.SerialLength = int.Parse(dt.Rows[i]["SerialLength"].ToString());
            //        entity.Qty = int.Parse(dt.Rows[i]["Qty"].ToString());
            //        entity.Increase = int.Parse(dt.Rows[i]["Increase"].ToString());
            //        list.Add(entity);
            //    }
            //}
            return ComMethod.GetList<BarCodeScopeInfo>("uspQueryPackRelation", parms);
        }
        #endregion

        #region 获取包装对应关系条码列表
        /// <summary>
        /// 获取包装对应关系条码列表
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<BarCodeScopeInfo> GetPackSerialNumberAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<BarCodeScopeInfo> list = new List<BarCodeScopeInfo>();
            //表名或者视图
            string strTb = "vwProd_PackRelationDtl";////Prod_PackRelationDtl
            //主键
            string strKey = "SerialNumberID";
            //查询栏位字串
            string strColumns = @"SerialNumberID, NumberType, OrderNo, CustomerOrder, SerialNumber,SerialNumber1, CreateBy, CreateDateTime,NumberID,Status";

            return ComMethod.GetComList<BarCodeScopeInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);
        }
        #endregion

        #region 获取单条对应关系信息
        /// <summary>
        /// 获取单条对应关系信息
        /// </summary>
        /// <param name="ScopeId"></param>
        /// <returns></returns>
        public BarCodeScopeInfo GetPackRelationInfo(Int32 ScopeId)
        {
            return CommonHelper.BLL.ComMethod.GetInfo<BarCodeScopeInfo>(ScopeId, "uspGetPackRelationInfo");
        }
        #endregion

        #region 删除包装对应关系
        /// <summary>
        /// 删除条码范围信息
        /// </summary>
        /// <param name="scopeId"></param>
        /// <param name="userName"></param>
        public void DeletePackRelation(int scopeId, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ScopeId", SqlDbType.Int),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20)
            };

            parms[0].Value = scopeId;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspDeletePackRelationByScopeId", parms);
        }
        #endregion

        #region 根据工单号查询条码列表
        /// <summary>
        /// 根据工单号查询条码列表
        /// </summary>
        /// <param name="OrderNo"></param>
        /// <returns></returns>
        public List<BarCodeScopeInfo> QueryPackBarCodeList(string OrderNo)
        {
            List<BarCodeScopeInfo> list = new List<BarCodeScopeInfo>();
            BarCodeScopeInfo entity = null;
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@OrderNo",SqlDbType.VarChar,100)
            };
            parms[0].Value = OrderNo;
            using (DataTable dt = SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "uspQueryPackBarCodeList", parms))
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    entity = new BarCodeScopeInfo();
                    entity.OrderNo = dt.Rows[i]["OrderNo"].ToString();
                    entity.ProdOrderID = int.Parse(dt.Rows[i]["ProdOrderID"].ToString());
                    entity.ItemId = int.Parse(dt.Rows[i]["ItemId"].ToString());
                    entity.SerialNumber = dt.Rows[i]["SerialNumber"].ToString();
                    list.Add(entity);
                }
            }
            return list;
        }
        #endregion

        #region 根据订单号查询该订单是否已经生成过条码
        /// <summary>
        /// 根据订单号查询该订单是否已经生成过条码
        /// </summary>
        /// <param name="CustomerOrder"></param>
        /// <param name="NumberType"></param>
        /// <returns></returns>
        public BarCodeScopeInfo GetCustomerOrderBarCode(string CustomerOrder,string OrderNo, string NumberType)
        {
            BarCodeScopeInfo entity = null;
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@CustomerOrder", SqlDbType.VarChar,100),
                new SqlParameter("@OrderNo", SqlDbType.VarChar,100),
                new SqlParameter("@NumberType", SqlDbType.VarChar,50)
            };

            parms[0].Value = CustomerOrder;
            parms[1].Value = OrderNo;
            parms[2].Value = NumberType;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetCustomerOrderBarCode", parms))
            {
                if (rdr.Read())
                {
                    entity = new BarCodeScopeInfo();
                    entity.ScopeId = rdr.GetInt32(0);
                    entity.NumberType = rdr.GetString(1);
                    entity.OrderNo = rdr.GetString(2);
                    entity.CustomerOrder = rdr.GetString(3);
                    entity.Prefix = rdr.GetString(4);
                    entity.Suffix = rdr.GetString(5);
                    entity.SerialBegin = rdr.GetString(6);
                    entity.SerialEnd = rdr.GetString(7);
                    entity.SerialLength = rdr.GetInt32(8);
                    entity.Qty = rdr.GetInt32(9);
                    entity.NumberBegin = rdr.GetString(10);
                    entity.NumberEnd = rdr.GetString(11);
                    entity.Increase = rdr.GetInt32(12);
                }
                rdr.Close();
            }
            return entity;

        }
        #endregion

        #region 判断是否有主条码进入生产
        /// <summary>
        /// 判断是否有主条码进入生产
        /// </summary>
        /// <param name="entity"></param>
        public void IsBarCodeExists(string OrderNo)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@OrderNo", SqlDbType.VarChar, 100),
            };

            parms[0].Value = OrderNo;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspIsBarCodeExists", 200000, parms);

        }
        #endregion

        #region 保存数据到数据库
        /// <summary>
        /// 保存数据到数据库
        /// </summary>
        /// <param name="dt"></param>
        public List<BarCodeScopeInfo> SaveBarCodeImport(string OrderNo, string CustomerOrder,string NumberType, string NumberClass, string IsMain, string UserName, DataTable dt)
        {
            List<BarCodeScopeInfo> list = new List<BarCodeScopeInfo>();
            BarCodeScopeInfo entity = null;
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@OrderNo", SqlDbType.VarChar, 100),
                new SqlParameter("@CustomerOrder", SqlDbType.VarChar, 100),
                new SqlParameter("@NumberType", SqlDbType.VarChar, 100),
                new SqlParameter("@NumberClass", SqlDbType.VarChar, 100),
                new SqlParameter("@IsMain", SqlDbType.VarChar, 100),
                new SqlParameter("@UserName", SqlDbType.VarChar, 50),
                new SqlParameter("@BarCodeImportList",SqlDbType.Structured)
            };
            parms[0].Value = OrderNo;
            parms[1].Value = CustomerOrder;
            parms[2].Value = NumberType;
            parms[3].Value = NumberClass;
            parms[4].Value = IsMain;
            parms[5].Value = UserName;
            parms[6].Value = dt;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspSaveBarCodeImport", parms))
            {
                while (rdr.Read())
                {
                    entity = new BarCodeScopeInfo();
                    entity.SerialNumber = rdr.GetString(0);
                    entity.ErrorMessage = rdr.GetString(1);
                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }
        #endregion

        #region 保存数据到数据库
        /// <summary>
        /// 保存数据到数据库
        /// </summary>
        /// <param name="dt"></param>
        public List<BarCodeScopeInfo> SavePackRelationImport(string OrderNo, string CustomerOrder, string UserName, DataTable dt)
        {
            List<BarCodeScopeInfo> list = new List<BarCodeScopeInfo>();
            BarCodeScopeInfo entity = null;
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@OrderNo", SqlDbType.VarChar, 100),
                new SqlParameter("@CustomerOrder", SqlDbType.VarChar, 100),
                new SqlParameter("@UserName", SqlDbType.VarChar, 50),
                new SqlParameter("@PackRelationList",SqlDbType.Structured)
            };
            parms[0].Value = OrderNo;
            parms[1].Value = CustomerOrder;
            parms[2].Value = UserName;
            parms[3].Value = dt;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspSavePackRelationImport", parms))
            {
                while (rdr.Read())
                {
                    entity = new BarCodeScopeInfo();
                    entity.SerialNumber = rdr.GetString(0);
                    entity.SerialNumber1 = rdr.GetString(1);
                    entity.ErrorMessage = rdr.GetString(2);
                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }
        #endregion

        /// <summary>
        /// 获取工单号获取包对应关系
        /// </summary>
        /// <param name="serialNumberID"></param>
        /// <returns></returns>
        public BarCodeScopeInfo GetPackRelationBySNId(long serialNumberID)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@SerialNumberID", SqlDbType.BigInt)
            };
            parms[0].Value = serialNumberID;
            return ComMethod.Get<BarCodeScopeInfo>("uspGetPackRelationBySNId", parms);
        }

        /// <summary>
        /// 删除号码段
        /// </summary>
        /// <param name="entity"></param>
        public void DeletePackRelation(BarCodeScopeInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@ScopeId", SqlDbType.Int),
                new SqlParameter("@StartIndex", SqlDbType.VarChar, 50),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20)
            };
            parms[0].Value = entity.ScopeId;
            parms[1].Value = entity.SerialBegin;
            parms[2].Value = entity.ModifyBy;
            ComMethod.Edit("uspDeletePackRelation", parms);
        }

        /// <summary>
        /// 包装对应关系—编辑—验证是否允许删除条码规则
        /// </summary>
        /// <param name="entity"></param>
        public void IsAllowDeletePackRelation(BarCodeScopeInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@ScopeId", SqlDbType.Int)
            };
            parms[0].Value = entity.ScopeId;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspIsAllowDeletePackRelation", parms);
        }
        
    }
}
