using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Material.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;
using static SKT.LeanMES.Material.Model.PurOrderInfo;
namespace SKT.LeanMES.Material.BLL
{
    public class PurOrder
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） PurOrder 信息。
        /// </summary>
        /// <param name="entity">PurOrder 实体对象。</param>
        public void PurOrderEdit(string strjson)
        {
            ComMethod.Edit(strjson, "ERP_PurOrder_Edit");
        }



        /// <summary>
        /// 根据采购单号返回收料明细数据 --字符流
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public byte[] GetPurchasePdfPrint(int id, string strXmlFilePath, string strImgPath)
        {
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@Id",SqlDbType.VarChar,50)
            };
            parms[0].Value = id;
            DataSet ds = ComMethod.GetListDataSet("upsGetPurchasePrint", parms, "dtDeliveryForm");

            //PDF产生
            return PDFHelper.getPDFByte(PDFHelper.Language.Simplified, strXmlFilePath, ds, strImgPath);
        }

        /// <summary>
        /// 根据 PurOrderId 字符串删除 PurOrder 信息。
        /// </summary>
        /// <param name="idString">PurOrderId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "ERP_PurOrder_Delete", parms);
        }

        /// <summary>
        /// 根据 PurOrderId 获取实体信息。
        /// </summary>
        /// <param name="purOrderId">PurOrderId。</param>
        /// <returns>PurOrder 实体对象。</returns>
        public PurOrderInfo GetInfo(Int32 purOrderId)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = purOrderId;
            parms[1].Value = false;
            return ComMethod.Get<PurOrderInfo>("ERP_PurOrder_GetInfo", parms);
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>PurOrder 实体对象。</returns>
        public PurOrderInfo GetInfo(String fieldValue)
        {

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;
            return ComMethod.Get<PurOrderInfo>("ERP_PurOrder_GetInfo", parms);
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>PurOrder 实体对象。</returns>
        public PurOrderDtlInfo GetPurOrderDtlInfo(String POID)
        {

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = POID;
            parms[1].Value = false;
            return ComMethod.Get<PurOrderDtlInfo>("ERP_PurOrderDtl_GetInfo", parms);
        }

        /// <summary>
        /// 查询采购单主表
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<PurOrderInfo> GetPurOrderList(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<PurOrderInfo> list = new List<PurOrderInfo>();
            //表名或者视图
            string strTb = "vwPurOrderList";
            //主键
            string strKey = "PurOrderId";
            //查询栏位字串
            string strColumns = @"[POCode],[VenID]
                                ,[VenCode],[VendorName],[VenUserName],[VenPhone]
                                ,[VendorAddress],[Remark],[ProjectNo]
                                ,[OrderDate],[TaxRate],[TaxRateTotal],[PaymentTerms]
                                ,[PaymentMethod],[DeliveryAddress],PurOrderId,IsMesAdd,CreateBy,ModifyBy,CreateDateTime,POTypeName,ReceiveType,CreateByCName,SupplierDelivery,OpenDataStatus,OpenDataStatusName,ModifyDateTime,IsMesAddName";
            list = ComMethod.GetComList<PurOrderInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            return list;
        }

        /// <summary>
        /// 查询采购单主表
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<PurOrderDtlInfo> GetPurOrderDtlAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            if (string.IsNullOrEmpty(sortExpression))
            {
                sortExpression = "POCode,AutoID";
            }
            List<PurOrderDtlInfo> list = new List<PurOrderDtlInfo>();
            //表名或者视图
            string strTb = "vwPurOrderDtlList";
            //主键
            string strKey = "";
            //查询栏位字串
            string strColumns = @"[POID]
                                  ,[POCode]
                                  ,[ItemID]
                                  ,[ItemCode]
                                  ,[ItemName]
                                  ,[ItemSpec]
                                  ,[SOCode]
                                  ,[PURQty]
                                  ,[Units]
                                  ,[UnitPrice]
                                  ,[TotalPrice]
                                  ,[DeliveryDate]
                                  ,[AutoID],[OpenDataStatus]";
            list = ComMethod.GetComList<PurOrderDtlInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            return list;
        }

        /// <summary>
        /// 获取采购单物料信息
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<PurOrderDtlInfo> GetPurOrderItem(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            //表名或者视图
            string strTb = "vwPurOrderItem";
            //主键
            string strKey = "AutoID";
            //查询栏位字串
            string strColumns = @"POCode,PURQty,AutoID,ItemID,ItemName,ItemCode,ItemSpec";
            var list = ComMethod.GetComList<PurOrderDtlInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);
            return list;
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }




        /// <summary>
        /// 查询报告列表信息
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<FileInfo> GetSysUpLoadFileList(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<FileInfo> list = new List<FileInfo>();
            //表名或者视图
            string strTb = "vwSysUpLoadFileList";
            //主键
            string strKey = "FileID";
            //查询栏位字串
            string strColumns = @"[FileID],[FileType],[FileName],[CreateBy],[CreateDateTime],FileSaveName,RowType,FileVersion";
            list = ComMethod.GetComList<FileInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            return list;
        }
    }
}
