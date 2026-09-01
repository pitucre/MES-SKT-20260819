using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Router.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using System.Text.RegularExpressions;
using Newtonsoft.Json;

namespace SKT.LeanMES.Router.BLL
{
    public class Router
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） ROUTER 信息。
        /// </summary>
        /// <param name="entity">ROUTER 实体对象。</param>
        public Int32 Edit(RouterInfo entity, String itemIdString)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@R_ID", SqlDbType.Int),
                new SqlParameter("@R_Name", SqlDbType.VarChar, 50),
                new SqlParameter("@R_Description", SqlDbType.NVarChar, 50),
                new SqlParameter("@R_Status", SqlDbType.Int),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 50),
                new SqlParameter("@ItemIdString", SqlDbType.VarChar,2000),
                new SqlParameter("@Action", SqlDbType.Int)
            };

            parms[0].Value = entity.R_ID;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.R_Name;
            parms[2].Value = entity.R_Description;
            parms[3].Value = entity.R_Status;
            parms[4].Value = entity.CreateBy;
            parms[5].Value = entity.ModifyBy;
            parms[6].Value = entity.Remark;
            parms[7].Value = itemIdString;
            parms[8].Value = entity.Action;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_Router_Edit", parms);
            return (Int32)parms[0].Value;
        }



        public void UpdateLayout(Int32 R_id, String JSON, String linkString, string userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@R_ID", SqlDbType.Int),
                new SqlParameter("@JSON", SqlDbType.Text),
                new SqlParameter("@LinkString", SqlDbType.VarChar,8000),
                new SqlParameter("@userName", SqlDbType.VarChar,50)
            };

            parms[0].Value = R_id;
            parms[1].Value = JSON;
            parms[2].Value = linkString;
            parms[3].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_Router_UpdateLayout", parms);
        }

        public void UpdateLayoutNew(Int32 R_id, String JSON, String linkString, string userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@R_ID", SqlDbType.Int),
                new SqlParameter("@JSON", SqlDbType.Text),
                new SqlParameter("@LinkString", SqlDbType.VarChar,8000),
                new SqlParameter("@userName", SqlDbType.VarChar,50)
            };

            parms[0].Value = R_id;
            parms[1].Value = JSON;
            parms[2].Value = linkString;
            parms[3].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_Router_UpdateLayoutNew", parms);
        }

        // 多出，待处理存储过程
        public void  CreateLayout(Int32  select_RID,Int32 R_id)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SelectR_ID", SqlDbType.Int),
                new SqlParameter("@R_ID", SqlDbType.Int)
            };

            parms[0].Value = select_RID;
            parms[1].Value = R_id;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_Router_CreateLayout", parms);
        }

        /// <summary>
        /// 根据 ROUTERId 字符串删除 ROUTER 信息。
        /// </summary>
        /// <param name="idString">ROUTERId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_Router_Delete", parms);
        }


        /// <summary>
        /// 删除路由前，判断该路由相关的工单是否完全释放
        /// </summary>
        /// <param name="idString">ROUTERId 字符串。</param>
        /// <returns>日志内容。</returns>
        public int uspIsAllReleased(String idString)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@result", SqlDbType.Int)
            };

            parms[0].Value = idString;
            parms[1].Direction = ParameterDirection.Output;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "[uspIsAllReleased]", parms);
            return Convert.ToInt32(parms[1].Value);
        }


        /// <summary>
        /// 删除路由前，判断该路由是否存在建立关系的产品或者工单。
        /// zhibin.chen 2016-03-08
        /// </summary>
        /// <param name="ROUTERId">ROUTERId</param>
        public void CheckRouterIsBindItemOrOrder(int routerId)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@RouterId", SqlDbType.Int)
            };

            parms[0].Value = routerId;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "[uspCheckRouterIsUsing]", parms);

        }
        


        /// <summary>
        /// 根据 ROUTERId 获取实体信息。
        /// </summary>
        /// <param name="rOUTERId">ROUTERId。</param>
        /// <returns>ROUTER 实体对象。</returns>
        public RouterInfo GetInfo(Int32 r_Id)
        {
            RouterInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@R_Id", SqlDbType.Int)
            };

            parms[0].Value = r_Id;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_Router_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new RouterInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetInt32(4),
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7), rdr.GetDateTime(8), rdr.GetString(9), rdr.GetString(10));
                    entity.Url = rdr.GetString(11);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 ROUTER 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="rOUTERCount">rOUTER 总数。</param>
        /// <returns>ROUTER 列表。</returns>
        public List<RouterInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<RouterInfo> list = new List<RouterInfo>();
            RouterInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwRouterMember", "R_ID",
                "[R_ID], [R_Name], [R_Description], [R_JSON], [R_Status], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime], [Remark],[ItemId],[ItemName],[ItemRev], [ItemCode], [Site]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new RouterInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetInt32(4),
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7), rdr.GetDateTime(8), rdr.GetString(9));

                    entity.ItemId = rdr.GetInt32(10);
                    entity.ItemName = rdr.GetString(11);
                    entity.ItemRev = rdr.GetString(12);
                    entity.ItemCode = rdr.GetString(13);
                    entity.Site = rdr.GetString(14);
                   
                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        /// <summary>
        /// 分页获取 ROUTER 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="rOUTERCount">rOUTER 总数。</param>
        /// <returns>ROUTER 列表。</returns>
        public List<RouterInfo> GetAllChoose(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<RouterInfo> list = new List<RouterInfo>();
            RouterInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Basal_Router", "R_ID",
                "[R_ID], [R_Name], [R_Description], [R_Status]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new RouterInfo();

                    entity.R_ID = rdr.GetInt32(0);
                    entity.R_Name = rdr.GetString(1);
                    entity.R_Description = rdr.GetString(2);
                    entity.Remark = Enum.Parse(typeof(EnumRouterStatus), rdr.GetInt32(3).ToString()).ToString(); //for choose R_Status

                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        public RouterInfo GetLayout(Int32 r_Id)
        {
            RouterInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@R_Id", SqlDbType.Int)
            };

            parms[0].Value = r_Id;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_Router_GetLayout", parms))
            {
                if (rdr.Read())
                {
                    entity = new RouterInfo();
                    entity.R_JSON = rdr.GetString(0);
                    entity.RouterJson = rdr.GetString(1);
                }
                rdr.Close();
            }

            return entity;
        }

        public List<RouterInfo> GetItemBindByRId(int rId)
        {
            List<RouterInfo> list = new List<RouterInfo>();
            RouterInfo entity = null;

            SearchSettings searchSettings = new SearchSettings();
            searchSettings.ExtensionCondition = " RouterID=" + rId.ToString();

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(0, -1, "Basal_Item", "ItemId", "distinct ItemId,ItemRev,ItemName, ItemCode", searchSettings, "ItemId");

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new RouterInfo();
                    entity.ItemId = rdr.GetInt32(0);
                    entity.ItemRev = rdr.GetString(1);
                    entity.ItemName = rdr.GetString(2);
                    entity.ItemCode = rdr.GetString(3);
                     

                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }

        /// <summary>
        /// zhibin.chen 2016-03-08 获取与此路由建立关系的工单
        /// </summary>
        /// <param name="rId"></param>
        /// <returns></returns>
        public List<String> GetOrderBind(int rId)
        {
            List<String> list = new List<String>();

            SearchSettings searchSettings = new SearchSettings();
            searchSettings.ExtensionCondition = " RouterID=" + rId.ToString();

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(0, -1, "Prod_Order", "ProdOrderId", "ProdOrderId, OrderNO", searchSettings, "OrderNO");

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {                  

                    list.Add(rdr.GetString(1));
                }
                rdr.Close();
            }
            return list;
        }

        

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

        public bool OperationIsInRouter(Int32 operationId, Int32 routerId)
        {
            bool isInRouter = false;

            SqlParameter[] parameters = new SqlParameter[] { 
                new SqlParameter("@OperationId",SqlDbType.Int),
                new SqlParameter("@RouterId",SqlDbType.Int)
            };

            parameters[0].Value = operationId;
            parameters[1].Value = routerId;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_Router_StationIsInRouter", parameters))
            {
                if (rdr.Read())
                {
                    isInRouter = rdr.GetBoolean(0);
                }
                rdr.Close();
            }
            return isInRouter;
        }

       public List<ActivityInfo> GetRouterActivities(int operationId, int routerId)
        {
            List<ActivityInfo> list = new List<ActivityInfo>();
            ActivityInfo model = null;
            SqlParameter[] parameters = new SqlParameter[] { 
                new SqlParameter("@OperationId",SqlDbType.Int),
                new SqlParameter("@RouterId",SqlDbType.Int)
            };

            parameters[0].Value = operationId;
            parameters[1].Value = routerId;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_Router_GetRouterActivities", parameters))
            {
                while (rdr.Read())
                {
                    model = new ActivityInfo();
                    model.AC_ID = rdr.GetInt32(0);
                    model.AC_Name = rdr.GetString(1);

                    list.Add(model);
                }
                rdr.Close();
            }
            return list;
        }

        public List<ActivityInfo> GetRutActOptionsByActId(int actId, int operationId, int routerId)
        {
            List<ActivityInfo> list = new List<ActivityInfo>();
            ActivityInfo model = null;
            SqlParameter[] parameters = new SqlParameter[] { 
                new SqlParameter("@ActId",SqlDbType.Int),
                new SqlParameter("@OperationId",SqlDbType.Int),
                new SqlParameter("@RouterId",SqlDbType.Int)
            };

            parameters[0].Value = actId;
            parameters[1].Value = operationId;
            parameters[2].Value = routerId;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_Router_GetRutActOptionsByActId", parameters))
            {
                while (rdr.Read())
                {
                    model = new ActivityInfo();
                    model.AC_Param_Name = rdr.GetString(0);
                    model.ROAOID = rdr.GetInt32(1);
                    model.AC_Param_Value = rdr.GetString(2);
                    model.AC_Param_Remark = rdr.GetString(3);

                    list.Add(model);
                }
                rdr.Close();
            }
            return list;
        }

        public void AddRouterActivity(int acId, int routerId, int operationId)
        {
            SqlParameter[] parameters = new SqlParameter[] { 
                new SqlParameter("@ActId",SqlDbType.Int) ,
                new SqlParameter("@RouterId",SqlDbType.Int),
                new SqlParameter("@OperationId",SqlDbType.Int)
            };
            parameters[0].Value = acId;
            parameters[1].Value = routerId;
            parameters[2].Value = operationId;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_Router_AddRouterActivity", parameters);
        }

        public void DeleteRouterActivity(int acId, int operationId, int routerId)
        {
            SqlParameter[] parameters = new SqlParameter[] { 
                new SqlParameter("@ActId",SqlDbType.Int) ,
                new SqlParameter("@RouterId",SqlDbType.Int),
                new SqlParameter("@OperationId",SqlDbType.Int)
            };
            parameters[0].Value = acId;
            parameters[1].Value = routerId;
            parameters[2].Value = operationId;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_Router_DeleteRouterActivity", parameters);
        }

        public void SortRouterActivity(int acId, int operationId, int routerId, int up)
        {
            SqlParameter[] parameters = new SqlParameter[] { 
                new SqlParameter("@ActId",SqlDbType.Int) ,
                new SqlParameter("@RouterId",SqlDbType.Int),
                new SqlParameter("@OperationId",SqlDbType.Int),
                new SqlParameter("@Up",SqlDbType.Int)
            };
            parameters[0].Value = acId;
            parameters[1].Value = routerId;
            parameters[2].Value = operationId;
            parameters[3].Value = up;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_Router_SortRouterActivity", parameters);
        }

        public void SaveRouterActivityValue(string routerActIdStr, string routerActValueStr)
        {
            SqlParameter[] parameters = new SqlParameter[] { 
                new SqlParameter("@RouterActIdStr",SqlDbType.NVarChar,2000) ,
                new SqlParameter("@RouterActValueStr",SqlDbType.NVarChar,2000) 
            };
            parameters[0].Value = routerActIdStr;
            parameters[1].Value = routerActValueStr;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_Router_SaveRouterActivityValue", parameters);
        }

        /// <summary>
        /// zhibin.chen 2016-02-29  判断所绑定的产品中，是否存在
        /// </summary>
        /// <param name="itemId"></param>
        /// <param name="rId">路由</param>
        /// <returns></returns>
        public int CheckedItemIsBindOtherRouter(int itemId, int rId)
        {

            SqlParameter[] parameters = new SqlParameter[] { 
                new SqlParameter("@ItemId",SqlDbType.Int) ,
                new SqlParameter("@RId",SqlDbType.Int) ,
                new SqlParameter("@Result",SqlDbType.Int)
            };
            parameters[0].Value = itemId;
            parameters[1].Value = rId;
            parameters[2].Direction = ParameterDirection.Output; ;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCheckedItemIsBindOtherRouter", parameters);

            return Convert.ToInt32(parameters[2].Value);
        }

        public void ImportRouter(string DrawingNo, string Version, string AttributionCode, string CreateBy, string BomChildJson)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@DrawingNo", SqlDbType.VarChar, 100) { Value = DrawingNo},
                new SqlParameter("@Version", SqlDbType.VarChar, 20) { Value = Version },
                new SqlParameter("@AttributionCode", SqlDbType.VarChar, 20) { Value = AttributionCode},
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20) { Value = CreateBy},
                new SqlParameter("@BomChildJsons", SqlDbType.Structured) { Value = JsonConvert.DeserializeObject<DataTable>(BomChildJson)},
            };

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_Router_Import", parms);

        }

        public void ImportRouterurl(string url, string DrawingNo, string Version)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@Url", SqlDbType.VarChar, 200){ Value = url},
                new SqlParameter("@DrawingNo", SqlDbType.VarChar, 100){ Value = DrawingNo},
                new SqlParameter("@Version", SqlDbType.VarChar, 20){ Value = Version}
            };
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_Router_UpdateUrl", parms);

        }

        #region 将 Json 解析成 DateTable
        /// <summary>    
        /// 将 Json 解析成 DateTable   
        /// Json 数据格式如:  
        ///     {table:[{column1:1,column2:2,column3:3},{column1:1,column2:2,column3:3}]}///</summary>    
        /// <param name="strJson">要解析的 Json 字符串</param>    
        /// <returns>返回 DateTable</returns>    
        public  DataTable JsonToDataTable(string strJson)
        {
            // 取出表名    
            var rg = new Regex(@"(?<={)[^:]+(?=:\[)", RegexOptions.IgnoreCase);
            string strName = rg.Match(strJson).Value;
            DataTable tb = null;
            // 去除表名    
            strJson = strJson.Substring(strJson.IndexOf("[") + 1);
            strJson = strJson.Substring(0, strJson.IndexOf("]"));
            // 获取数据    
            rg = new Regex(@"(?<={)[^}]+(?=})");
            MatchCollection mc = rg.Matches(strJson);
            for (int i = 0; i < mc.Count; i++)
            {
                string strRow = mc[i].Value;
                string[] strRows = strRow.Split(',');
                // 创建表    
                if (tb == null)
                {
                    tb = new DataTable();
                    tb.TableName = strName;
                    foreach (string str in strRows)
                    {
                        var dc = new DataColumn();
                        string[] strCell = str.Split(':');
                        dc.ColumnName = strCell[0].Replace("\"", "");
                        tb.Columns.Add(dc);
                    }
                    tb.AcceptChanges();
                }
                // 增加内容    
                DataRow dr = tb.NewRow();
                for (int j = 0; j < strRows.Length; j++)
                {
                    dr[j] = strRows[j].Split(':')[1].Replace("\"", "");
                }
                tb.Rows.Add(dr);
                tb.AcceptChanges();
            }
            return tb;
        }
        #endregion
    }
}