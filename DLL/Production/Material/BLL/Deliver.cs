using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;
using SKT.LeanMES.Material.Model;
using SKT.Common.DAL.Marshal;

namespace SKT.LeanMES.Material.BLL
{
    public class Deliver
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） Deliver 信息。
        /// </summary>
        /// <param name="entity">Deliver 实体对象。</param>
        public string Edit(string strJson)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@DeliverId", SqlDbType.Int),                
                new SqlParameter("@VenderNo", SqlDbType.NVarChar, 50),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 50),
                new SqlParameter("@tbDtl", SqlDbType.Structured),
                new SqlParameter("@tbGRNDtl", SqlDbType.Structured)
            };
            parms[0].Direction = ParameterDirection.InputOutput;
            ComMethod.Edit<DeliverInfo>(strJson, "upsDeliverSave", parms);
            return parms[0].Value.ToString();
        }

        /// <summary>
        /// 编辑（添加或更新） Deliver 信息。  PDA
        /// </summary>
        /// <param name="entity">Deliver 实体对象。</param>
        public string EditToPDA(string strJson) 
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@DeliverId", SqlDbType.Int),
                new SqlParameter("@VenderNo", SqlDbType.NVarChar, 50),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 50),
                new SqlParameter("@tbDtl", SqlDbType.Structured),
                new SqlParameter("@tbGRNDtl", SqlDbType.Structured)
            };
            parms[0].Direction = ParameterDirection.InputOutput;
            ComMethod.Edit<DeliverInfo>(strJson, "upsDeliverSaveToPDA", parms);
            return parms[0].Value.ToString();
        }

        public void Edit(int DeliverId, string VenderNo, string Remark, string CreateBy, string JSONtbDtl, string JSONtbGRNDtl)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@DeliverId", SqlDbType.Int),
                new SqlParameter("@VenderNo", SqlDbType.NVarChar, 50),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 50),
                new SqlParameter("@JSONtbDtl", SqlDbType.NVarChar,-1),
                new SqlParameter("@JSONtbGRNDtl", SqlDbType.NVarChar,-1)
            };
            parms[0].Value = DeliverId;
            parms[1].Value = VenderNo;
            parms[2].Value = Remark;
            parms[3].Value = CreateBy;
            parms[4].Value = JSONtbDtl;
            parms[5].Value = JSONtbGRNDtl;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "upsDeliverSaveEWMS", parms);
 
        }
        /// <summary>
        /// 根据 DeliverId 字符串删除 Deliver 信息。
        /// </summary>
        /// <param name="idString">DeliverId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            ComMethod.Delete(idString, userName, "Prod_Deliver_Delete");
        }

        /// <summary>
        /// 根据 DeliverId 获取实体信息。
        /// </summary>
        /// <param name="deliverId">DeliverId。</param>
        /// <returns>Deliver 实体对象。</returns>
        public DeliverInfo GetInfo(Int32 deliverId)
        {
            return ComMethod.GetInfo<DeliverInfo>(deliverId, "Prod_Deliver_GetInfo");
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>Deliver 实体对象。</returns>
        public DeliverInfo GetInfo(String fieldValue)
        {
            return ComMethod.GetInfo<DeliverInfo>(fieldValue, "Prod_Deliver_GetInfo");
        }

        /// <summary>
        /// 分页获取 Deliver 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="deliverCount">deliver 总数。</param>
        /// <returns>Deliver 列表。</returns>
        public List<DeliverInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<DeliverInfo> list = new List<DeliverInfo>();
            //表名或者视图
            string strTb = "Prod_Deliver";
            //主键
            string strKey = "DeliverId";
            //查询栏位字串
            string strColumns = @"[DeliverId], [DeliverNo], [VenderNo], [DeliState], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime], [Remark]";
            list = ComMethod.GetComList<DeliverInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            return list;
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

        /// <summary>
        /// 根据采购单号返回收料明细数据
        /// </summary>
        /// <param name="buyOrder"></param>
        /// <returns></returns>
        public string GetDeliverInfo(string buyOrder,string sPoCode, bool cbShowAll)
        {
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@BuyOrder",SqlDbType.NVarChar,50),
                  new SqlParameter("@AllPOCode",SqlDbType.NVarChar,2000),
                  new SqlParameter("@ShowAll",SqlDbType.Bit)
            };
            parms[0].Value = buyOrder;
            parms[1].Value = sPoCode;
            parms[2].Value = cbShowAll;
            return ComMethod.GetList("uspGetMaterialPurchaseInfo", parms);
        }

        /// <summary>
        /// 送货单生成，GRN检查和返回信息
        /// </summary>
        public string CheckAndGetGrnInfo(string grn, string po, string itemCode)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@GRN",SqlDbType.NVarChar,100),
                new SqlParameter("@PORDER",SqlDbType.NVarChar,100),
                new SqlParameter("@PItemCode",SqlDbType.NVarChar,100),
            };
            parms[0].Value = grn;
            parms[1].Value = po;
            parms[2].Value = itemCode;
            return ComMethod.GetList("uspCheckDeliverAndGetGrnInfo", parms);
        }

        /// <summary>
        /// 根据GRN返回收料明细数据
        /// </summary>
        /// <param name="buyOrder"></param>
        /// <returns></returns>
        public string GetDeliverByGrn(string strGRN, string strVender, string po,string UserName)
        {
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@GRN",SqlDbType.NVarChar,50),
                  new SqlParameter("@Vender",SqlDbType.NVarChar,50),
                  new SqlParameter("@AllBuyOrder",SqlDbType.VarChar,-1),
                  new SqlParameter("@UserName",SqlDbType.VarChar,50),
            };
            parms[0].Value = strGRN;
            parms[1].Value = string.IsNullOrEmpty(strVender) ? "" : strVender;
            parms[2].Value = po;
            parms[3].Value = UserName;
            return ComMethod.GetList("uspGetDeliverByGRN", parms);
        }

        /// <summary>
        /// 分页获取 Deliver 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="deliverCount">deliver 总数。</param>
        /// <returns>Deliver 列表。</returns>
        public List<DeliverDtlInfo> GetList(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<DeliverDtlInfo> list = new List<DeliverDtlInfo>();
            //表名或者视图
            string strTb = "vwDeliverDtlList";
            //主键
            string strKey = "DeliverDtlId";
            //查询栏位字串
            string strColumns = @"DeliverId, DeliverDtlId, DeliverNo, Remark, DeliState, CreateBy, CreateDateTime, VendorName,
		            ItemCode, ItemName, SentQty, AbleSentQty, SupplierId, VenderNo, POCode";
            list = ComMethod.GetComList<DeliverDtlInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            return list;
        }

        /// <summary>
        /// 根据采购单号返回收料明细数据
        /// </summary>
        /// <param name="buyOrder"></param>
        /// <returns></returns>
        public string GetDeliverPrint(int intId)
        {
            //string DeliverNo = "";
            SqlParameter[] parms = new SqlParameter[] { 
                  new SqlParameter("@DeliverId",SqlDbType.Int),
                  new SqlParameter("@DeliverNo",SqlDbType.VarChar,50)
            };
            parms[0].Value = intId;
            parms[1].Direction = ParameterDirection.InputOutput;
            return ComMethod.GetList("upsGetDeliverPrint", parms);
        }
        /// <summary>
        /// 根据采购单号返回收料明细数据
        /// </summary>
        /// <param name="buyOrder"></param>
        /// <returns></returns>
        public string GetDeliverPdfPrint(int intId, string strTargetPath, string strXmlFilePath, string strImgPath)
        {
            string DeliverNo = "";
            SqlParameter[] parms = new SqlParameter[] { 
                  new SqlParameter("@DeliverId",SqlDbType.Int),
                  new SqlParameter("@DeliverNo",SqlDbType.VarChar,50)
            };
            parms[0].Value = intId;
            parms[1].Direction = ParameterDirection.InputOutput;
            DataSet ds = ComMethod.GetListDataSet("upsGetDeliverPrint", parms, "dtDeliveryForm");
            if (ds.Tables.Count > 0)
            {
                DeliverNo = parms[1].Value.ToString();
                foreach (DataRow row in ds.Tables[1].Rows)
                {
                    row["SentQty"] =Convert.ToDecimal(row["SentQty"]);
                }
            }
            //PDF产生
            return PDFHelper.ExportData(PDFHelper.Language.Simplified, strXmlFilePath, ds, strTargetPath, strImgPath);
        }

        /// <summary>
        /// 根据采购单号返回收料明细数据 --字符流
        /// </summary>
        /// <param name="buyOrder"></param>
        /// <returns></returns>
        public byte[] GetDeliverPdfByte(int intId, string strXmlFilePath, string strImgPath,out string DeliverNo)
        {
            DeliverNo ="";
            SqlParameter[] parms = new SqlParameter[] { 
                  new SqlParameter("@DeliverId",SqlDbType.Int),
                  new SqlParameter("@DeliverNo",SqlDbType.VarChar,50)
                  
            };
            parms[0].Value = intId;
            parms[1].Direction = ParameterDirection.InputOutput;
            DataSet ds = ComMethod.GetListDataSet("upsGetDeliverPrint", parms, "dtDeliveryForm");
            //if (ds.Tables.Count > 0)
            //{
            //    DeliverNo= parms[1].Value.ToString();
            //    foreach (DataRow row in ds.Tables[1].Rows)
            //    {
            //        row["SentQty"] = Convert.ToDecimal(row["SentQty"]);
            //    }
            //}
            //PDF产生
            return PDFHelper.getPDFByte(PDFHelper.Language.Simplified, strXmlFilePath, ds, strImgPath);
        }

        /// <summary>
        /// 检查PO行是否可以在送货单的时候删除
        /// </summary>
        public void checkPOLineCanRemove(string pocode, string rowid,string grns)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@POCode", SqlDbType.NVarChar,200),
                new SqlParameter("@RowID", SqlDbType.NVarChar, 20),
                new SqlParameter("@Grns", SqlDbType.NVarChar,4000)
            };
            parms[0].Value = pocode;
            parms[1].Value = rowid;
            parms[2].Value = grns;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspPOLineCanRemove", parms);
        }

        /// <summary>
        /// 检查PO行是否可以在送货单的时候删除
        /// </summary>
        public void checkGrnCanRemove(string grn)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@Grn", SqlDbType.NVarChar,100)
            };
            parms[0].Value = grn;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspGrnCanRemove", parms);
        }


        /// <summary>
        /// 调拨单打印
        /// </summary>
        /// <param name="buyOrder"></param>
        /// <returns></returns>
        public byte[] GetTransfersPdfByte(int intId, int transfersCate, string strXmlFilePath, string strImgPath)
        {
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@TransfersId",SqlDbType.Int),
                  new SqlParameter("@TransfersType",SqlDbType.Int)
            };
            parms[0].Value = intId;
            parms[1].Value = transfersCate;
            DataSet ds = ComMethod.GetListDataSet("upsGetTransfersPrint", parms, "dtTransfersForm");
            //if (ds.Tables.Count > 0)
            //{
            //    foreach (DataRow row in ds.Tables[1].Rows)
            //    {
            //        if (row["SentQty"].ToString() != "0.000")
            //            row["SentQty"] = Convert.ToDecimal(row["SentQty"]).ToString("#.##");
            //        else
            //            row["SentQty"] = 0;
            //    }
            //}
            //PDF产生
            return PDFHelper.getPDFByte(PDFHelper.Language.Simplified, strXmlFilePath, ds, strImgPath);
        }

        /// <summary>
        /// 检验送货单是否已存在扫描GRN记录且不存在确认收料记录
        /// </summary>
        /// <param name="deliverNo"></param>
        /// <returns></returns>
        public bool CheckDeliverNoIsScanGRN(string deliverNo)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@DeliverNo", SqlDbType.NVarChar),
                new SqlParameter("@IsScanGRN", SqlDbType.Bit)
            };
            parms[0].Value = deliverNo;
            parms[1].Value = 0;
            parms[1].Direction = ParameterDirection.InputOutput;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCheckDeliverNoIsScanGRN", parms);

            return Convert.ToBoolean(parms[1].Value);
        }

        /// <summary>
        /// 撤销送货单
        /// </summary>
        /// <param name="deliverNo"></param>
        /// <param name="userName"></param>
        public void RevocationDeliverNo(string deliverNo, string userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@DeliverNo", SqlDbType.NVarChar),
                new SqlParameter("@UserName", SqlDbType.NVarChar)
            };
            parms[0].Value = deliverNo;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspRevocationDeliverNo", parms);
        }
    }
}