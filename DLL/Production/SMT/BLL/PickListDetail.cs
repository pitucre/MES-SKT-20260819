using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using SKT.LeanMES.SMT.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.SMT.BLL
{
    public class PickListDetail
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） PickListDetail 信息。
        /// </summary>
        /// <param name="entity">PickListDetail 实体对象。</param>
        public void Edit(PickListDetailInfo entity,String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@DetailID", SqlDbType.Int),
                new SqlParameter("@Qty", SqlDbType.Decimal),
                new SqlParameter("@GroupCode", SqlDbType.VarChar, 100),
                new SqlParameter("@GroupDesc", SqlDbType.VarChar, 3950),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 200),
                new SqlParameter("@PickListId",SqlDbType.Int),
                new SqlParameter("@ItemId",SqlDbType.Int),
                new SqlParameter("@UserName",SqlDbType.VarChar,20)
            };

            parms[0].Value = entity.DetailID;
            parms[1].Value = entity.Qty;
            parms[1].Precision = 28;
            parms[1].Scale = 18;
            parms[2].Value = entity.GroupCode;
            parms[3].Value = entity.GroupDesc;
            parms[4].Value = entity.Remark;
            parms[5].Value = entity.ListID;
            parms[6].Value = entity.ItemID;
            parms[7].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSavePickListDetail", parms);
        }

        /// <summary>
        /// 根据 PickListDetailId 字符串删除 PickListDetail 信息。
        /// </summary>
        /// <param name="idString">PickListDetailId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName,Int32  listId)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@PickListDetailIdStr", SqlDbType.VarChar,2000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20),
                new SqlParameter("@ListId", SqlDbType.Int)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;
            parms[2].Value = listId;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspDeletePickListDetail", parms);
        }

        /// <summary>
        /// 根据 PickListDetailId 获取实体信息。
        /// </summary>
        /// <param name="pickListDetailId">PickListDetailId。</param>
        /// <returns>PickListDetail 实体对象。</returns>
        public PickListDetailInfo GetInfo(Int32 pickListDetailId)
        {
            PickListDetailInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@DetailId", SqlDbType.Int)
            };

            parms[0].Value = pickListDetailId;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_PickListDetailGetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new PickListDetailInfo();
                    entity.ItemID = rdr.GetInt32(0);
                    entity.ItemCode = rdr.GetString(1);
                    entity.Qty = rdr.GetDecimal(2);
                    entity.GroupCode = rdr.GetString(3);
                    entity.GroupDesc = rdr.GetString(4);
                    entity.Remark = rdr.GetString(5);

                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>PickListDetail 实体对象。</returns>
        public  List<PickListDetailInfo> GetPickListDetailInfo(Int32 pickListId)
        {
            List<PickListDetailInfo> list = new List<PickListDetailInfo>();
            PickListDetailInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@PickListId", SqlDbType.Int)
            };

            parms[0].Value = pickListId;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspPickListDetailInfo", parms))
            {
                while (rdr.Read())
                {
                    entity = new PickListDetailInfo();
                    entity.ItemCode = rdr.GetString(0);
                    entity.Qty = rdr.GetDecimal(1);
                    entity.GroupCode = rdr.GetString(2);
                    entity.GroupDesc = rdr.GetString(3);
                    entity.Remark = rdr.GetString(4);
                    list.Add(entity);
                }
                rdr.Close();
            }

            return list;
        }

        /// <summary>
        /// 分页获取 PickListDetail 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="pickListDetailCount">pickListDetail 总数。</param>
        /// <returns>PickListDetail 列表。</returns>
        public List<PickListDetailInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<PickListDetailInfo> list = new List<PickListDetailInfo>();
            PickListDetailInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, " Prod_PickListDetail  AS A left JOIN Basal_Item AS B ON A.ItemID = B.ItemID", "DetailID",
                "[DetailID], [ListID], A.[ItemID], CAST(ROUND(Qty,6) AS DECIMAL(28,6)) [Qty], [GroupCode], [GroupDesc], [StatusID], A.[Remark],IsNull(B.ItemCode,'') ItemCode ", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new PickListDetailInfo();
                    entity.DetailID = rdr.GetInt32(0);
                    entity.ListID = rdr.GetInt32(1);
                    entity.ItemID = rdr.GetInt32(2);
                    entity.Qty = rdr.GetDecimal(3);
                    entity.GroupCode = rdr.GetString(4);
                    entity.GroupDesc = rdr.GetString(5);
                    entity.StatusID = rdr.GetByte(6);
                    entity.Remark = rdr.GetString(7);
                    entity.ItemCode = rdr.GetString(8);

                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>PickListDetail 实体对象。</returns>
        public List<PickListDetailInfo> GetOrderBomInfo(string orderNo)
        {
            List<PickListDetailInfo> list = new List<PickListDetailInfo>();
            PickListDetailInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@OrderNo", SqlDbType.NVarChar)
            };

            parms[0].Value = orderNo;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetOrderBomInfo", parms))
            {
                while (rdr.Read())
                {
                    entity = new PickListDetailInfo();
                    entity.ItemID = Convert.ToInt32(rdr["ItemId"]);
                    entity.ItemCode = Convert.ToString(rdr["ItemCode"]);
                    entity.ItemName = Convert.ToString(rdr["ItemName"]);
                    entity.ItemSpec = Convert.ToString(rdr["ItemSpec"]);
                    entity.Qty = Convert.ToDecimal(rdr["PerNum"]);
                    entity.GroupCode = Convert.ToString(rdr["GroupCode"]);

                    list.Add(entity);
                }
                rdr.Close();
            }

            return list;
        }

        public void CollectOrderPickList(string OrderNo,string PickListName,string Rev,string Remark,string DeatailJSON,string UserName,int UserID)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@OrderNo", SqlDbType.VarChar),
                new SqlParameter("@PickListName", SqlDbType.VarChar),
                new SqlParameter("@Rev", SqlDbType.VarChar),
                new SqlParameter("@Remark", SqlDbType.VarChar),
                new SqlParameter("@DeatailJSON", SqlDbType.VarChar),
                new SqlParameter("@UserName", SqlDbType.VarChar),
                new SqlParameter("@UserId", SqlDbType.Int)
            };

            parms[0].Value = OrderNo;
            parms[1].Value = PickListName;
            parms[2].Value = Rev;
            parms[3].Value = Remark;
            parms[4].Value = DeatailJSON;
            parms[5].Value = UserName;
            parms[6].Value = UserID;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCollectOrderPickList", parms);
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="usetype">0为使用粉碎料/1为使用原材料</param>
        /// <param name="userName"></param>
        /// <param name="listId"></param>
        public void UsedCrushRawMat(int usetype, String userName, Int32 listId)
        {
            //获取当前上料清单的所有数据
            SearchSettings searchSettings = new SearchSettings();
            searchSettings.ExtensionCondition = "ListID =" + listId + "";
            var list = GetAll(0, 10000, "", searchSettings);
            //循环处理使用粉碎料/原材料
            if(usetype ==0)
            {
                foreach(var itm in list)
                {
                    if(itm.ItemCode.Substring(0,2)=="06")
                    {
                        foreach(var li in list)
                        {
                            if(li.ItemCode=="03"+itm.ItemCode.Substring(2))
                            {
                                itm.Qty = itm.Qty + li.Qty;
                            }
                        }
                    }
                }
                string idstring = "";
                foreach(var li in list)
                {
                    if(li.ItemCode.Substring(0,2)=="03")
                    {
                        if(idstring=="")
                        {
                            idstring = li.DetailID.ToString();
                        }
                        else
                        {
                            idstring= idstring+","+ li.DetailID.ToString();
                        }
                    }
                }
                Delete(idstring, userName, listId);
                foreach(var itm in list)
                {
                    if(itm.ItemCode.Substring(0,2)=="06")
                    {
                        Edit(itm, userName);
                    }
                }
            }
            if (usetype == 1)
            {
                foreach (var itm in list)
                {
                    if (itm.ItemCode.Substring(0, 2) == "03")
                    {
                        foreach (var li in list)
                        {
                            if (li.ItemCode == "06" + itm.ItemCode.Substring(2))
                            {
                                itm.Qty = itm.Qty + li.Qty;
                            }
                        }
                    }
                }
                string idstring = "";
                foreach (var li in list)
                {
                    if (li.ItemCode.Substring(0, 2) == "06")
                    {
                        if (idstring == "")
                        {
                            idstring = li.DetailID.ToString();
                        }
                        else
                        {
                            idstring = idstring + "," + li.DetailID.ToString();
                        }
                    }
                }
                Delete(idstring, userName, listId);
                foreach (var itm in list)
                {
                    if (itm.ItemCode.Substring(0, 2) == "03")
                    {
                        Edit(itm, userName);
                    }
                }
            }
        }
    }
}