using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.MobileMat.Model;
using System.Text.RegularExpressions;

namespace SKT.LeanMES.MobileMat.BLL
{
    public class FinishProdShipment
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） FinishProdOut 信息。
        /// </summary>
        /// <param name="entity">Shipment 实体对象。</param>
        public Int32 Edit(FinishProdShipmentInfo entity,string SNList)
        {
            DataTable dataT = JsonToDataTable(SNList);
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ShipmentId", SqlDbType.Int),
                new SqlParameter("@WorkOrderNo", SqlDbType.NVarChar, 30),
                new SqlParameter("@ErpCode", SqlDbType.VarChar,30),
                new SqlParameter("@ErpDate", SqlDbType.DateTime),
                new SqlParameter("@CusCode", SqlDbType.VarChar,30),                
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@SNList",SqlDbType.Structured)
            };
            parms[0].Value = entity.ShipmentId;
            parms[0].Direction = ParameterDirection.Output;
            parms[1].Value ="";//原来的工单在销售出货明细中，此处不能写到主表中，此字段多余
            parms[2].Value = entity.ErpCode;
            parms[3].Value = entity.ErpDate;
            parms[4].Value = entity.CusCode;
            parms[5].Value = entity.CreateBy;
            parms[6].Value = dataT;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_finishprodshipment_edit", parms);
            return (Int32)parms[0].Value;
        }
        #region 将 Json 解析成 DateTable
        /// <summary>    
        /// 将 Json 解析成 DateTable   
        /// Json 数据格式如:  
        ///     {table:[{column1:1,column2:2,column3:3},{column1:1,column2:2,column3:3}]} /// </summary>    
        /// <param name="strJson">要解析的 Json 字符串</param>    
        /// <returns>返回 DateTable</returns>    
        public static DataTable JsonToDataTable(string strJson)
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
        /// <summary>
        /// 根据 FinishProdOutID 字符串删除 FinishProdOut 信息。
        /// </summary>
        /// <param name="idString">ShipmentId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000)
            };
            parms[0].Value = idString;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_Shipment_Delete", parms);
        }
        /// <summary>
        /// 根据 ShipmentId 获取实体信息。
        /// </summary>
        /// <param name="ShipmentId">ShipmentId。</param>
        /// <returns>FinishProdOutInfo 实体对象。</returns>
        public FinishProdShipmentInfo GetInfo(Int32 ShipmentId)
        {
            FinishProdShipmentInfo entity = null;
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };
            parms[0].Value = ShipmentId;
            parms[1].Value = true;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_FinishProdShipment_getInfo", parms))
            {
                if (rdr.Read())
                {
                        entity = new FinishProdShipmentInfo(rdr.GetInt32(0), rdr.GetString(1),rdr.GetString(2), rdr.GetDateTime(3).ToShortDateString(),
                        rdr.GetString(4), rdr.GetDateTime(5), rdr.GetString(6), rdr.GetDateTime(7),
                        rdr.GetString(8), rdr.GetString(9),"");
                }
                rdr.Close();
            }
            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>FinishProdOutInfo 实体对象。</returns>
        public FinishProdShipmentInfo GetInfo(String fieldValue)
        {
            FinishProdShipmentInfo entity = null;
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50)
            };
            parms[0].Value = fieldValue;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "JqueryErp_record", parms))
            {
                if (rdr.Read())
                {
                    entity = new FinishProdShipmentInfo(rdr.GetInt32(2), "", rdr.GetString(0), rdr.GetString(1),
                        rdr.GetString(3), System.DateTime.Now, "", System.DateTime.Now,
                        "", "", "");
                }
                rdr.Close();
            }
            return entity;
        }
        /// <summary>
        /// 分页获取 FinishProdOutInfo 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="shipmentCount">shipment 总数。</param>
        /// <returns>Shipment 列表。</returns>
        public List<FinishProdShipmentInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            string whereStr = "  ";
            //把条件取出拼成字符串
            Dictionary<string, string> ds = searchSettings.Conditions;
            foreach (KeyValuePair<string ,string> item in ds)
            {
                whereStr += ( item.Key + "='" + item.Value+"'")+" and ";
            }
            //去掉最后面的and
            if (!string.IsNullOrEmpty(whereStr.Trim()))
            {
                whereStr = whereStr.Substring(0, whereStr.Length - 5);
            }
            else
            {
                whereStr = " 1=1";
            }
            //加上额外的条件
            if (!string.IsNullOrEmpty(searchSettings.ExtensionCondition.Trim()))
            {
                whereStr = whereStr + " and "+searchSettings.ExtensionCondition;
            }
            //把原条件置空传入
            SearchSettings SearchStr = new SearchSettings();
            List<FinishProdShipmentInfo> list = new List<FinishProdShipmentInfo>();
            FinishProdShipmentInfo entity = null;
            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows,
@"(select shipmentid,workorderno,erpcode,erpdate,cuscode,modifydatetime,modifyby,createdatetime,createby,remark
from   prod_finishprodshipment a
where  a.erpcode in(select b.code
                    from   interfaceerp_record b,
                           interfaceerp_records c,
                           basal_item d
                    where  b.id=c.id  
					       and c.itemid=d.itemid
and (" + whereStr + "))) a", "ShipmentId",
                "ShipmentId,WorkOrderNo,ErpCode,ErpDate,CusCode,ModifyDateTime,ModifyBy,CreateDateTime,CreateBy,Remark", SearchStr, sortExpression);
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new FinishProdShipmentInfo(rdr.GetInt32(0), rdr.GetString(1),rdr.GetString(2), rdr.GetDateTime(3).ToString(),
                        rdr.GetString(4), rdr.GetDateTime(5), rdr.GetString(6), rdr.GetDateTime(7),
                        rdr.GetString(8), rdr.GetString(9), "");
                    list.Add(entity);
                }
                rdr.Close();
            }
            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }
        /// <summary>
        /// 根据销售单号查询销售明细和相关的信息
        /// </summary>
        /// <param name="WorkOrderNo"></param>
        /// <param name="ShipMentNo"></param>
        /// <returns></returns>
        public List<FinishProdShipmentInfo> JqueryWorkOderInfo(string Code)
        {
            List<FinishProdShipmentInfo> list = new List<FinishProdShipmentInfo>();
            FinishProdShipmentInfo entity = null;
            SqlParameter[] parms = new SqlParameter[] { 
                  new SqlParameter("@Code",SqlDbType.VarChar,50)
            };
            parms[0].Value = Code;
            using (DataTable rdr = SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "JqueryWorkOderInfo", parms))
            {
                for(int i=0;i<rdr.Rows.Count;i++)
                {
                   entity = new FinishProdShipmentInfo();
                    //工单，销售出库号，销售出库单数量, 出库日期Date,  产品id，产品名称
                    entity.WorkOrder = rdr.Rows[i]["sourcebillno"].ToString();
                    int Qty = 0;
                    if (rdr.Rows[i]["qty"] != null)
                    {
                        Qty = Convert.ToInt32(rdr.Rows[i]["qty"].ToString());
                    }
                    entity.Qty = Qty;
                    entity.ErpCode =  rdr.Rows[i]["code"].ToString();
                    entity.ShipmentDateStr = rdr.Rows[i]["Date"].ToString();
                    int ItemId = 0;
                    if (rdr.Rows[i]["itemid"] != null)
                    {
                        ItemId = Convert.ToInt32(rdr.Rows[i]["itemid"].ToString());
                    }
                    entity.ItemName =  rdr.Rows[i]["itemname"].ToString();
                    entity.AutoId = Convert.ToInt32(rdr.Rows[i]["autoid"].ToString());
                    list.Add(entity);                
                }
            }
            return list;
        }
        /// <summary>
        /// 取得记录个数
        /// </summary>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }
        /// <summary>
        /// 成品出货时，刷条码带出正确的ItemId和SN。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>FinishProdOutInfo 实体对象。</returns>
        public FinishProdShipmentInfo GetShipmentItemIdSN(String SN)
        {
            FinishProdShipmentInfo entity = null;
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SN", SqlDbType.NVarChar, 50)
            };
            parms[0].Value = SN;
            using (DataTable rdr = SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "UspShipmentGetItemIdSN", parms))
            {
                for (int i = 0; i < rdr.Rows.Count; i++)
                {
                    entity =new FinishProdShipmentInfo();
                    //只可能返回一笔，所以不用Add
                    entity.ItemId = Convert.ToInt32(rdr.Rows[i]["ItemID"].ToString());
                    entity.SNValue = rdr.Rows[i]["value"].ToString();
                    entity.Qty = Convert.ToInt32(rdr.Rows[i]["Qty"].ToString());
                }
            }
            return entity;
        }
        /// <summary>
        /// 根据成品出货Id取得ItemCode列表
        /// </summary>
        /// <param name="shimpentId"></param>
        /// <returns></returns>
        public List<FinishProdShipmentInfo> GetFinishProdShipmentItem(int shimpentId)
        {
            List<FinishProdShipmentInfo> list = new List<FinishProdShipmentInfo>();
            FinishProdShipmentInfo entity = null;
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@shipmentId", SqlDbType.Int)
            };
            parms[0].Value = shimpentId;
            using (DataTable dt = SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "UspGetFinishProdShipmentDetail", parms))
            {
                for (int i = 0; i < dt.Rows.Count;i++ )
                {
                    entity = new FinishProdShipmentInfo();
                    entity.ItemId =Convert.ToInt32(dt.Rows[i]["itemId"]);
                    entity.ItemName = dt.Rows[i]["itemcode"].ToString();
                    entity.Qty = Convert.ToInt32(dt.Rows[i]["qty"]);
                    entity.SourceBillNo = dt.Rows[i]["sourcebillno"].ToString();
                    entity.SOCode = dt.Rows[i]["socode"].ToString();
                    list.Add(entity);
                }
            }
            return list;
        }
        /// <summary>
        /// 根据成品出货Id和ItemCode取得ItemCode和所刷的条码列表
        /// </summary>
        /// <param name="shimpentId"></param>
        /// <returns></returns>
        public List<FinishProdShipmentInfo> GetFinishProdShipmentDetailOld(int shimpentId)
        {
            List<FinishProdShipmentInfo> list = new List<FinishProdShipmentInfo>();
            FinishProdShipmentInfo entity = null;
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@shipmentId", SqlDbType.Int)
            };
            parms[0].Value = shimpentId;
            using (DataTable dt = SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "UspGetFinishProdShipmentDetail", parms))
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    entity = new FinishProdShipmentInfo();
                    entity.ItemName = dt.Rows[i]["itemcode"].ToString();
                    entity.SNValue = dt.Rows[i]["snvalue"].ToString();
                    list.Add(entity);
                }
            }
            return list;
        }

        /// <summary>
        /// 分页获取 FinishProdOutInfo 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="shipmentCount">shipment 总数。</param>
        /// <returns>Shipment 列表。</returns>
        public List<FinishProdShipmentDetailInfo> GetFinishProdShipmentDetail(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<FinishProdShipmentDetailInfo> list = new List<FinishProdShipmentDetailInfo>();
            FinishProdShipmentDetailInfo entity = null;
            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows,"Uspgetfinishprodshipmentdetail", "ShipmentId",
                "shipmentid, shipmentdetailid, itemid, itemcode, qty, sourcebillno, socode", searchSettings, sortExpression);
            using (DataTable dt = SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    entity = new FinishProdShipmentDetailInfo();
                    entity.ShipmentId = Convert.ToInt32(dt.Rows[i]["shipmentid"]);
                    entity.ShipmentDetailId = Convert.ToInt32(dt.Rows[i]["shipmentdetailid"]);
                    entity.ItemId = Convert.ToInt32(dt.Rows[i]["itemid"]);
                    entity.ItemCode = dt.Rows[i]["itemcode"].ToString();
                    entity.Qty = Convert.ToInt32(dt.Rows[i]["qty"]);
                    entity.SourceBillNo = dt.Rows[i]["sourcebillno"].ToString();
                    entity.SoCode = dt.Rows[i]["socode"].ToString();
                    list.Add(entity);
                }
            }            
            recordCount = list.Count;
            return list;
        }
        /// <summary>
        /// 分页获取 FinishProdOutInfo 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="shipmentCount">shipment 总数。</param>
        /// <returns>Shipment 列表。</returns>
        public List<FinishProdShipmentDetailInfo> GetFinishProdShipmentView(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<FinishProdShipmentDetailInfo> list = new List<FinishProdShipmentDetailInfo>();
            FinishProdShipmentDetailInfo entity = null;
            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Prod_ShipmentItemToSN", "ItemSNId",
                "ItemSNId,ShipmentDetailId,ItemId,SNValue", searchSettings, sortExpression);
            using (DataTable dt = SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    entity = new FinishProdShipmentDetailInfo();
                    entity.ItemSNId =Convert.ToInt32(dt.Rows[i]["ItemSNId"].ToString());
                    entity.ShipmentDetailId = Convert.ToInt32(dt.Rows[i]["ShipmentDetailId"].ToString());
                    entity.ItemId = Convert.ToInt32(dt.Rows[i]["ItemId"].ToString());    
                    entity.SN = dt.Rows[i]["SNValue"].ToString();                    
                    list.Add(entity);
                }
            }
            recordCount = list.Count;
            return list;
        }
    }
}
