using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Product.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Product.BLL
{
    public class OrderParam
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） OrderParam 信息。
        /// </summary>
        /// <param name="entity">OrderParam 实体对象。</param>
        public void Edit(string obOrderNo, string obSeqStr, string opStationStr ,string opParaNameStr
            ,string opParaValueStr ,string opParaRemarkStr ,string CreateBy ,string opItemIDStr
            , int PrivacyItemFlag, int PrivacyOpeFlag)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@OrderNo", SqlDbType.VarChar, 100),
                new SqlParameter("@obSeqStr", SqlDbType.NVarChar,5000),
                new SqlParameter("@opStationStr", SqlDbType.NVarChar,5000),
                new SqlParameter("@opParaNameStr", SqlDbType.NVarChar,5000),
                new SqlParameter("@opParaValueStr", SqlDbType.NVarChar,5000),
                new SqlParameter("@opParaRemarkStr", SqlDbType.NVarChar,5000),
                new SqlParameter("@CreateBy", SqlDbType.NVarChar,100),
                new SqlParameter("@opItemIDStr", SqlDbType.NVarChar,5000)
                ,new SqlParameter("@PrivacyItemFlag", SqlDbType.Int)
                ,new SqlParameter("@PrivacyOpeFlag", SqlDbType.Int)
            };

            parms[0].Value = obOrderNo;
            parms[1].Value = obSeqStr;
            parms[2].Value = opStationStr;
            parms[3].Value = opParaNameStr;
            parms[4].Value = opParaValueStr;
            parms[5].Value = opParaRemarkStr;
            parms[6].Value = CreateBy;
            parms[7].Value = opItemIDStr;
            parms[8].Value = PrivacyItemFlag;
            parms[9].Value = PrivacyOpeFlag;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_OrderParam_Edit", parms);

        }

        /// <summary>
        /// 根据 OrderParamId 字符串删除 OrderParam 信息。
        /// </summary>
        /// <param name="idString">OrderParamId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String OrderNo, int StationID, String ParaName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@OrderNo", SqlDbType.NVarChar, 100),
                new SqlParameter("@StationID", SqlDbType.Int),
                new SqlParameter("@ParaName", SqlDbType.NVarChar, 100)
            };

            parms[0].Value = OrderNo;
            parms[1].Value = StationID;
            parms[2].Value = ParaName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_OrderParam_Delete", parms);
        }

        /// <summary>
        /// 根据 OrderParamId 获取实体信息。
        /// </summary>
        /// <param name="orderParamId">OrderParamId。</param>
        /// <returns>OrderParam 实体对象。</returns>
        //public OrderParamInfo GetInfo(Int32 orderParamId)
        //{
        //    OrderParamInfo entity = null;

        //    SqlParameter[] parms = new SqlParameter[]{
        //        new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
        //        new SqlParameter("@IsByID", SqlDbType.Bit)
        //    };

        //    parms[0].Value = orderParamId;
        //    parms[1].Value = true;

        //    using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_OrderParam_GetInfo", parms))
        //    {
        //        if (rdr.Read())
        //        {
        //            entity = new OrderParamInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetInt32(2), rdr.GetInt32(3), rdr.GetString(4), 
        //                rdr.GetString(5), rdr.GetInt32(6), rdr.GetString(7), rdr.GetString(8), rdr.GetDateTime(9), 
        //                rdr.GetString(10), rdr.GetDateTime(11));
        //        }
        //        rdr.Close();
        //    }

        //    return entity;
        //}

         //<summary>
         //根据 字段值 获取实体信息。
         //</summary>
         //<param name="fieldValue">字段值。</param>
         //<returns>OrderParam 实体对象。</returns>
        public List<OrderParamInfo> GetInfo(int OrderID, int StationID, int ItemID)
        {
            List<OrderParamInfo> list = new List<OrderParamInfo>();
            OrderParamInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@OrderID", SqlDbType.Int), 
                new SqlParameter("@StationID", SqlDbType.Int), 
                new SqlParameter("@ItemID", SqlDbType.Int), 
            };

            parms[0].Value = OrderID;
            parms[1].Value = StationID;
            parms[2].Value = ItemID;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_OrderParam_GetInfo", parms))
            {
                while (rdr.Read())
                {
                    entity = new OrderParamInfo();
                    entity.ItemId = (int)rdr["ItemId"];
                    entity.StationId = (int)rdr["StationId"];
                    entity.ParamSeq = (int)rdr["ParamSeq"];
                    entity.ParamName = rdr["ParamName"].ToString();
                    entity.ParamValue = rdr["ParamValue"].ToString();
                    entity.Remark = rdr["Remark"].ToString();
                    entity.Station = rdr["Station"].ToString();
                    //entity.ItemCode = rdr["ItemCode"].ToString();
                    //entity.ItemName = rdr["ItemName"].ToString();
                    list.Add(entity);
                }
                rdr.Close();
            }
            //recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        /// <summary>
        /// 分页获取 OrderParam 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="orderParamCount">orderParam 总数。</param>
        /// <returns>OrderParam 列表。</returns>
        public List<OrderParamInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<OrderParamInfo> list = new List<OrderParamInfo>();
            OrderParamInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Prod_OrderParam", "OrderParamId",
                "[OrderParamId], [OrderNo], [ItemId], [StationId], [ParamName], [ParamValue], [ParamSeq], [Remark], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new OrderParamInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetInt32(2), rdr.GetInt32(3), rdr.GetString(4), 
                        rdr.GetString(5), rdr.GetInt32(6), rdr.GetString(7), rdr.GetString(8), rdr.GetDateTime(9), 
                        rdr.GetString(10), rdr.GetDateTime(11));

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