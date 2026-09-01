using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using SKT.LeanMES.Manufacture.Model;
using SKT.Common.DAL.Marshal;
using SKT.LeanMES.CommonHelper.BLL;

namespace SKT.LeanMES.Manufacture.BLL
{
    /// <summary>
    /// 信息中心模块--各类信息数据的源泉。
    /// 
    /// 创建于：2014-11-13
    /// 创建者：zhibin.Chen
    /// </summary>
    public class InfoCenter
    {

        private int productCountByOrderNo = 0;

        private string productOrderNo;

        private string panelNO="无";

        private string boxNumber;

        private string modelGroupName;

        private string modelCurrentName;

        #region 基本信息-页面

        #region 产品信息

        /// <summary>
        /// 根据序列号获取产品简要信息
        /// </summary>
        /// <param name="serialNumber">序列号</param>
        /// <returns>信息实体</returns>
        public VUnitHistoryInfo GetProductSummaryInfo(String serialNumber)
        {
            VUnitHistoryInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@SerialNumber", SqlDbType.NVarChar, 512)
                };

            parms[0].Value = serialNumber;

            using (SqlDataReader dr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspInfoCenterProductSummary", parms))
            {
                if (dr.HasRows)
                {
                    entity = new VUnitHistoryInfo();
                    dr.Read();
                    entity.Operation = dr.GetString(0);
                    entity.UnitStatus = dr.GetString(1);
                    entity.LineName = dr.GetString(2);
                    entity.LoginID = dr.GetString(3);
                    entity.EnterTimeStr = SKT.Common.Utility.TypeHelper.ToString(dr.GetDateTime(4));
                    entity.ExitTimeStr = SKT.Common.Utility.TypeHelper.ToString(dr.GetDateTime(5));
                    entity.ProductionOrder = dr.GetString(6);
                    entity.ItemName = dr.GetString(7);
                    entity.ITEM = dr.GetString(8);
                    entity.PanelNO = dr["PanelNo"].ToString();
                    panelNO = dr["PanelNo"].ToString();
                    entity.ItemModel= dr["ItemModel"].ToString();
                }
            }

            return entity;
        }

        public string GetPanelNO()
        {
            return panelNO;
        }

        /// <summary>
        /// 获取产品的生产历史记录
        /// </summary>
        /// <param name="serialNumber">序列号</param>
        /// <returns>历史记录实体集合。</returns>
        public List<VUnitHistoryInfo> GetProductHistory(String serialNumber)
        {
            VUnitHistoryInfo entity = null;
            List<VUnitHistoryInfo> list = new List<VUnitHistoryInfo>();

            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@SerialNumber", SqlDbType.NVarChar, 512)
                };

            parms[0].Value = serialNumber;

            using (SqlDataReader dr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspInfoCenterProductHistory", parms))
            {
                while (dr.Read())
                {
                    entity = new VUnitHistoryInfo();
                    entity.IsPass = dr.GetString(0);
                    entity.EnterTimeStr = SKT.Common.Utility.TypeHelper.ToString(dr.GetDateTime(1));
                    entity.ExitTimeStr = SKT.Common.Utility.TypeHelper.ToString(dr.GetDateTime(2));
                    entity.LoginID = dr.GetString(3);
                    entity.Operation = dr.GetString(4);
                    entity.LineName = dr.GetString(5);
                    entity.ResName = dr.GetString(6);
                    entity.CustomerSN = dr.GetString(7);
                    entity.CartonNo = dr.GetString(8);
                    entity.PalletNo = dr.GetString(9);
                    entity.QcLotNo = dr.GetString(10);
                    entity.ProdOrderNo = dr.GetString(11);
                    entity.ItemCode = dr.GetString(12);
                    entity.BoxSN = dr.GetString(13);
                    entity.CustomerSN2 = dr.GetString(14);
                    entity.Qty = dr.GetInt32(15);
                    list.Add(entity);
                }
            }

            return list;
        }        

        #endregion

        #region 物料信息


        /// <summary>
        /// 根据产品序列号获取该产品所使用的物料列表
        /// </summary>
        /// <param name="serialNumber">产品序列号</param>
        /// <param name="isAll">是否显示被移除组件</param>
        /// <returns>信息实体集合</returns>
        public List<ItemsInfo> GetUseItemList(String serialNumber, Int32 isAll)
        {
            ItemsInfo entity = null;
            List<ItemsInfo> list = new List<ItemsInfo>();

            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@SerialNumber", SqlDbType.NVarChar,512),
                    new SqlParameter("@IsAll", SqlDbType.Int)
                };

            parms[0].Value = serialNumber;
            parms[1].Value = isAll;

            using (SqlDataReader dr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspInfoCenterUseItemList", parms))
            {
                while (dr.Read())
                {
                    entity = new ItemsInfo();
                    entity.ItemID = dr.GetInt32(0);
                    entity.ItemName = dr.GetString(1);
                    entity.IsRemoved = dr.GetBoolean(2);
                    entity.Description = dr.GetString(3);
                    entity.ItemCode = dr.GetString(4);

                    list.Add(entity);
                }
            }

            return list;
        }


        /// <summary>
        /// 根据物料ID获取物料详细信息
        /// </summary>
        /// <returns>信息实体</returns>
        public ItemsInfo GetItemDetailInfo(String serialNumber, Int32 itemId)
        {
            ItemsInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@SerialNumber", SqlDbType.NVarChar,512),
                    new SqlParameter("@ItemID", SqlDbType.Int)
                };

            parms[0].Value = serialNumber;
            parms[1].Value = itemId;

            using (SqlDataReader dr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspInfoCenterItemDetail", parms))
            {
                if (dr.HasRows)
                {
                    dr.Read();
                    entity = new ItemsInfo();
                    entity.CreateBy = dr.GetString(0);
                    entity.InsertOperation = dr.GetString(1);
                    entity.CreateDateTime = dr.GetDateTime(2);
                    entity.RemoveUserName = dr.GetString(3);
                    entity.RemoveOperation = dr.GetString(4);
                    entity.RemoveTime = dr.GetValue(5).ToString();
                    entity.CreateTimeStr = dr.GetValue(2).ToString();
                }
            }

            return entity;
        }


        /// <summary>
        /// 获取该产品所使用的物料记录
        /// </summary>
        /// <returns>UNIT 实体对象。</returns>
        public List<ItemsInfo> GetItemUseHistory(String serialNumber)
        {
            ItemsInfo entity = null;
            List<ItemsInfo> list = new List<ItemsInfo>();

            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@SerialNumber", SqlDbType.NVarChar, 512)
                };

            parms[0].Value = serialNumber;

            using (SqlDataReader dr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspInfoCenterItemHistory", parms))
            {
                while (dr.Read())
                {
                    entity = new ItemsInfo();
                    entity.ItemName = dr.GetString(0);
                    entity.CreateBy = dr.GetString(1);
                    entity.InsertOperation = dr.GetString(2);
                    entity.CreateDateTime = dr.GetDateTime(3);
                    entity.Remark = dr.GetString(4);
                    entity.SerialNumber = dr.GetString(5);
                    entity.Qty = dr.GetDecimal(6);
                    entity.VendorName = dr.GetString(7);
                    entity.ItemCode = dr.GetString(8);
                    entity.LotCode = dr.GetString(9);
                    entity.DateCode = dr.GetString(10);
                    list.Add(entity);
                }
            }

            return list;
        }

        #endregion

        #region 组装信息

        public List<AssemblesInfo> GetAssemblesList(string sn)
        {
            AssemblesInfo entity = null;
            List<AssemblesInfo> list = new List<AssemblesInfo>();

            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@SerialNumber", SqlDbType.NVarChar,512),
                };

            parms[0].Value = sn;

            using (SqlDataReader dr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspInfoCenterAssemblesList", parms))
            {
                while (dr.Read())
                {
                    entity = new AssemblesInfo();
                    entity.MainItemCode = dr["MainItemCode"].ToString();
                    entity.MainItemName = dr["MainItemName"].ToString();
                    entity.ItemCode = dr["ItemCode"].ToString();
                    entity.ItemName = dr["ItemName"].ToString();
                    entity.SerialNumber = dr["FieldValue"].ToString();
                    entity.CompCount = Convert.ToDecimal(dr["CompCount"]);
                    entity.HasCompCount = Convert.ToInt32(dr["HasCompCount"]);

                    list.Add(entity);
                }
            }

            return list;
        }

        /// <summary>
        /// 获取产品离线条码组装信息
        /// </summary>
        /// <param name="sn"></param>
        /// <returns></returns>
        public List<AssemblesInfo> GetOfflineSNList(string sn)
        {
            AssemblesInfo entity = null;
            List<AssemblesInfo> list = new List<AssemblesInfo>();

            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@SerialNumber", SqlDbType.NVarChar,512),
                    new SqlParameter("@StationId", SqlDbType.Int),
                };

            parms[0].Value = sn;
            parms[1].Value = 0;
            using (SqlDataReader dr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspInfoCenterOfflineSNList", parms))
            {
                while (dr.Read())
                {
                    entity = new AssemblesInfo();
                    entity.MainItemCode = dr["MainItemCode"].ToString();
                    entity.MainItemName = dr["MainItemName"].ToString();
                    entity.ItemCode = dr["ItemCode"].ToString();
                    entity.ItemName = dr["ItemName"].ToString();
                    entity.SerialNumber = dr["FieldValue"].ToString();

                    list.Add(entity);
                }
            }

            return list;
        }

        #endregion

        #region 包装信息

        /// <summary>
        /// 根据产品序列号或者箱号，获取该箱和该箱内的产品。
        /// </summary>
        /// <param name="Number">序列号或者箱号</param>
        /// <param name="isPackNo">是否箱号</param>
        /// <returns>信息实体</returns>
        public List<InfoCenterInfo> GetInPackProductList(String number, Int32 isPackNo)
        {
            InfoCenterInfo entity = null;
            List<InfoCenterInfo> list = new List<InfoCenterInfo>();

            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@SerialNumber", SqlDbType.NVarChar,512),
                    new SqlParameter("@IsPackNo", SqlDbType.Int)
                };

            parms[0].Value = number;
            parms[1].Value = isPackNo;

            parms[0].Direction = ParameterDirection.InputOutput;

            using (SqlDataReader dr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspInfoCenterPackProductList", parms))
            {
                while (dr.Read())
                {
                    entity = new InfoCenterInfo();
                    entity.ContainerSN = dr.GetString(0);
                    entity.SerialNumber = dr.GetString(1);
                    entity.BoxSN = string.IsNullOrEmpty(dr.GetString(3))?"":dr.GetString(3);
                    list.Add(entity);
                }
            }

            boxNumber = parms[0].Value.ToString();
            return list;
        }


        /// <summary>
        /// 根据产品序列号或者箱号，获取该箱的详细信息。
        /// </summary>
        /// <param name="Number">序列号或者箱号</param>
        /// <param name="isPackNo">是否箱号</param>
        /// <returns>信息实体</returns>
        public ContainerInfo GetPackDetailInfo(String number, Int32 isPackNo)
        {
            //CIR_CONTAINERInfo entity = new CIR_CONTAINERInfo();
            ContainerInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@SerialNumber", SqlDbType.NVarChar,512),
                    new SqlParameter("@IsPackNo", SqlDbType.Int)
                };

            parms[0].Value = number;
            parms[1].Value = isPackNo;

            using (SqlDataReader dr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspInfoCenterPackDetail", parms))
            {
                if (dr.HasRows)
                {
                    entity = new ContainerInfo();
                    dr.Read();

                    entity.Status = dr.GetString(0);
                    entity.OPeration = dr.GetString(1);
                    entity.UserName = dr.GetString(2);
                    entity.CreateDateTime = dr.GetDateTime(3);
                    entity.ModifyDateTime = dr.GetDateTime(4);
                    entity.Name = dr.GetString(5);
                    entity.Height = dr.GetDecimal(6);
                    entity.Width = dr.GetDecimal(7);
                    entity.Depth = dr.GetDecimal(8);
                    entity.Weight = dr.GetDecimal(9);
                    entity.MaxFillWeight = dr.GetDecimal(10);
                }
            }

            return entity;
        }

        /// <summary>
        /// 根据产品序列号或者箱号，获取该箱的包装历史记录。
        /// </summary>
        /// <param name="Number">序列号或者箱号</param>
        /// <param name="isPackNo">是否箱号</param>
        /// <returns>UNIT 实体对象。</returns>
        public List<InfoCenterInfo> GetPackHistory(String number, Int32 isPackNo)
        {
            InfoCenterInfo entity = null;
            List<InfoCenterInfo> list = new List<InfoCenterInfo>();

            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@SerialNumber", SqlDbType.NVarChar,512),
                    new SqlParameter("@IsPackNo", SqlDbType.Int)
                };

            parms[0].Value = number;
            parms[1].Value = isPackNo;

            using (SqlDataReader dr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspInfoCenterPackHistory", parms))
            {
                while (dr.Read())
                {
                    entity = new InfoCenterInfo();
                    entity.SerialNumber = dr.GetString(0);
                    entity.OperaterPerson = dr.GetString(1);
                    entity.OperaterTime = dr.GetDateTime(2);
                    entity.OperaterDesc = dr.GetString(3);

                    list.Add(entity);
                }
            }

            return list;
        }

        /// <summary>
        /// 返回通过序列号查询后，返回这个产品所在的箱号。
        /// </summary>
        /// <returns>包装箱号码</returns>
        public string GetPackNumberBySN()
        {
            return boxNumber;
        }

        #endregion

        #region 包装附件信息

        /// <summary>
        /// 获取包装附件信息
        /// </summary>
        /// <param name="sn"></param>
        /// <returns></returns>
        public List<PackingAccessoriesInfo> GetPackingAccessoriesInfo(string sn)
        {
            PackingAccessoriesInfo entity = null;
            List<PackingAccessoriesInfo> list = new List<PackingAccessoriesInfo>();

            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@SN", SqlDbType.NVarChar),               
                };

            parms[0].Value = sn;            
            using (SqlDataReader dr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetPackingAccessoriesInfo", parms))
            {
                while (dr.Read())
                {
                    entity = new PackingAccessoriesInfo();
                    entity.AccessoriesName = dr["AccessoriesName"].ToString();
                    entity.SN = dr["SN"].ToString();
                    entity.AccessoriesSN = dr["AccessoriesSN"].ToString();
                    entity.Station = dr["Station"].ToString();
                    entity.LineName = dr["LineName"].ToString();
                    entity.ResName = dr["ResName"].ToString();
                    entity.CreateBy = dr["CreateBy"].ToString();
                    entity.CreateDateTime = dr["CreateDateTime"].ToString();

                    list.Add(entity);
                }
            }

            return list;
        }


        #endregion

        #region 型号信息

        /// <summary>
        /// 根据产品序列号或者型号版本号，获取型号信息。
        /// </summary>
        /// <param name="searchString">序列号或者型号版本号</param>
        /// <param name="isModelNo">是否型号版本号</param>
        /// <returns>信息实体</returns>
        public ItemsInfo GetModelSummaryInfo(String searchString, Int32 isModelNo)
        {
            ItemsInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@SearchString", SqlDbType.NVarChar,512),
                    new SqlParameter("@IsModelNo", SqlDbType.Int)
                };

            parms[0].Value = searchString;
            parms[1].Value = isModelNo;

            using (SqlDataReader dr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspInfoCenterModelSummary", parms))
            {
                if (dr.HasRows)
                {
                    entity = new ItemsInfo();
                    dr.Read();
                    entity.ItemName = dr.GetString(0);
                    entity.ItemRev = dr.GetString(1);
                    entity.Description = dr.GetString(2);
                    entity.ItemGroupName = dr.GetString(3);
                    entity.ItemStatus_Choose = dr.GetString(4);
                    entity.ItemType_Choose = dr.GetString(5);
                }
            }

            return entity;
        }


        /// <summary>
        /// 根据产品序列号或者型号版本号，获取型号详细信息。
        /// </summary>
        /// <param name="searchString">序列号或者型号版本号</param>
        /// <param name="isModelNo">是否型号版本号</param>
        /// <returns>信息实体</returns>
        public ItemsInfo GetModelDetailInfo(String searchString, Int32 isModelNo)
        {
            ItemsInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@SearchString", SqlDbType.NVarChar,512),
                    new SqlParameter("@IsModelNo", SqlDbType.Int)
                };

            parms[0].Value = searchString;
            parms[1].Value = isModelNo;

            using (SqlDataReader dr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspInfoCenterModelDetail", parms))
            {
                if (dr.HasRows)
                {
                    entity = new ItemsInfo();
                    dr.Read();
                    entity.ProjectName = dr.GetString(0);
                    entity.BomName = dr.GetString(1);
                    entity.IsCurrentRev = dr.GetBoolean(2);
                    entity.IsPanel = dr.GetBoolean(3);
                    entity.IsCPSFC = dr.GetBoolean(4);
                    entity.IsRoHS = dr.GetBoolean(5);
                    entity.TrackableComp = dr.GetBoolean(6);
                    entity.MaxUsageAsComp = dr.GetDouble(7);
                    entity.QtyRestriction = dr.GetInt32(8);
                }
            }

            return entity;
        }

        /// <summary>
        /// 根据产品序列号或者型号版本号，获取型号的分组信息。
        /// </summary>
        /// <param name="searchString">序列号或者型号版本号</param>
        /// <param name="isModelNo">是否型号版本号</param>
        /// <returns>信息实体</returns>
        public List<ItemsInfo> GetModelGroupList(String searchString, Int32 isModelNo)
        {
            ItemsInfo entity = null;
            List<ItemsInfo> list = new List<ItemsInfo>();

            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@SearchString", SqlDbType.NVarChar,512),
                    new SqlParameter("@IsModelNo", SqlDbType.Int),
                    new SqlParameter("@CurrentItem", SqlDbType.VarChar , 100)
                };

            parms[0].Value = searchString;
            parms[1].Value = isModelNo;

            parms[0].Direction = ParameterDirection.InputOutput;
            parms[2].Direction = ParameterDirection.Output;

            using (SqlDataReader dr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspInfoCenterModelStruct", parms))
            {
                while (dr.Read())
                {
                    entity = new ItemsInfo();
                    entity.ItemID = dr.GetInt32(0);
                    entity.ItemName = dr.GetString(1);

                    list.Add(entity);
                }
            }
            modelCurrentName = parms[2].Value.ToString();
            modelGroupName = parms[0].Value.ToString();
            return list;
        }


        /// <summary>
        /// 根据产品序列号或者型号版本号，获取型号依赖信息。
        /// </summary>
        /// <param name="searchString">序列号或者型号版本号</param>
        /// <param name="isModelNo">是否型号版本号</param>
        /// <returns>信息实体</returns>
        public ItemsInfo GetModelRelyOnInfo(String searchString, Int32 isModelNo)
        {
            ItemsInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@SearchString", SqlDbType.NVarChar,512),
                    new SqlParameter("@IsModelNo", SqlDbType.Int)
                };

            parms[0].Value = searchString;
            parms[1].Value = isModelNo;

            using (SqlDataReader dr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspInfoCenterModelRelyOn", parms))
            {
                if (dr.HasRows)
                {
                    entity = new ItemsInfo();
                    dr.Read();
                    entity.ItemGroupName = dr.GetString(0);
                    entity.ItemGroupDesc = dr.GetString(1);
                    entity.CreateBy = dr.GetString(2);
                    entity.CreateDateTime = dr.GetDateTime(3);

                }
            }

            return entity;
        }
        #endregion

        #region 流程信息

        /// <summary>
        /// 根据产品序列号，获取该产品的下一道工序信息。
        /// </summary>
        /// <param name="serialNumber">产品序列号</param>
        /// <returns></returns>
        public InfoCenterInfo GetFlowPathInfo(String serialNumber)
        {
            InfoCenterInfo entity = new InfoCenterInfo();

            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@SerialNumber", SqlDbType.VarChar,100)
                };

            parms[0].Value = serialNumber;

            using (SqlDataReader dr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspInfoCenterFlowPath", parms))
            {
                if (dr.HasRows)
                {
                    dr.Read();
                    entity.NextOperation = dr.GetString(0);
                    entity.RouterName = dr.GetString(1);
                }
            }

            return entity;
        }

        #endregion

        #region 工单信息

        /// <summary>
        /// 根据产品序列号或者工单号，获取该工单的历史记录。
        /// </summary>
        /// <param name="Number">序列号或者工单号</param>
        /// <param name="isPackNo">是否工单号</param>
        /// <returns>信息实体</returns>
        public List<InfoCenterInfo> GetProductOrderHistory(String number, Int32 isProductOrderNo)
        {
            InfoCenterInfo entity = null;
            List<InfoCenterInfo> list = new List<InfoCenterInfo>();

            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@SearchString", SqlDbType.NVarChar,512),
                    new SqlParameter("@IsProductOrderNo", SqlDbType.Int)
                };

            parms[0].Value = number;
            parms[1].Value = isProductOrderNo;

            using (SqlDataReader dr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspInfoCenterPOHistory", parms))
            {
                while (dr.Read())
                {
                    entity = new InfoCenterInfo();
                    entity.ProdOrderHistoryTime = dr.GetValue(0).ToString();
                    entity.ProdOrderAction = dr.GetString(1);

                    list.Add(entity);
                }
            }

            return list;
        }


        /// <summary>
        /// 根据产品序列号或者工单号，获取该工单的详细信息。
        /// </summary>
        /// <param name="Number">序列号或者工单号</param>
        /// <param name="isPackNo">是否工单号</param>
        /// <returns>信息实体</returns>
        public ProductOrderInfo GetProductOrderDetailInfo(String number, Int32 isProductOrderNo)
        {
            ProductOrderInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@SearchString", SqlDbType.NVarChar,512),
                    new SqlParameter("@IsProductOrderNo", SqlDbType.Int)
                };

            parms[0].Value = number;
            parms[1].Value = isProductOrderNo;

            using (SqlDataReader dr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspInfoCenterPODetail", parms))
            {
                if (dr.HasRows)
                {
                    entity = new ProductOrderInfo();
                    dr.Read();
                    entity.StatusStr = dr.GetString(0);
                    entity.CreateTime = dr.GetDateTime(1);
                    entity.ModifyTime = dr.GetDateTime(2);
                    entity.Priority = dr.GetInt32(3);
                    entity.ItemName = dr.GetString(4);
                    entity.Qty_to_Build = dr.GetInt32(5);
                    entity.Qty_Released = dr.GetInt32(6);
                    entity.Qty_Done = dr.GetInt32(7);
                    entity.Qty_Scrapped = dr.GetInt32(8);
                    entity.Scheduled_Start_Date = dr.GetDateTime(9);
                    entity.Scheduled_Completed_Time = dr.GetDateTime(10);
                    entity.Actual_Start_Date = dr.GetDateTime(11);
                    entity.Actual_Completed_Date = dr.GetDateTime(12);
                }
            }

            return entity;
        }

        /// <summary>
        /// 根据工单号，获取该工单所包含的产品。  此方法在通过序列号查询时，不启用！
        /// </summary>
        /// <param name="productOrderNumber">工单号或序列号 输出工单号</param>
        /// <param name="startRow">从第几行开始获取</param>
        /// <param name="maxRows">获取多少行</param>
        /// <param name="isPO">是否按工单号</param>
        /// <returns>UNIT 实体对象。</returns>
        public List<InfoCenterInfo> GetProductListByOrderNo(String productOrderNumber, Int32 startRow, Int32 maxRows, Int32 isPO)
        {
            InfoCenterInfo entity = null;
            List<InfoCenterInfo> list = new List<InfoCenterInfo>();

            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@ProductOrderNumber", SqlDbType.NVarChar,512),
                    new SqlParameter("@startRow", SqlDbType.Int),
                    new SqlParameter("@maxRows", SqlDbType.Int),
                    new SqlParameter("@isPO", SqlDbType.Int),
                    new SqlParameter("@productCountByOrderNo",SqlDbType.Int)
                };

            parms[0].Value = productOrderNumber;
            parms[1].Value = startRow;
            parms[2].Value = maxRows;
            parms[3].Value = isPO;
            parms[4].Value = productCountByOrderNo;

            parms[0].Direction = ParameterDirection.InputOutput;
            parms[4].Direction = ParameterDirection.Output;

            using (SqlDataReader dr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspInfoCenterPOproductlist", parms))
            {
                while (dr.Read())
                {
                    entity = new InfoCenterInfo();
                    entity.SerialNumber = dr.GetString(0);

                    list.Add(entity);
                }
            }
            productOrderNo = parms[0].Value.ToString();
            productCountByOrderNo = Convert.ToInt32(parms[4].Value);
            return list;
        }

        /// <summary>
        /// 通过序列号获取拼板的所有产品序列号
        /// </summary>
        /// <param name="SerialNumber"></param>
        /// <returns></returns>
        public List<InfoCenterInfo> GetPanelSN(String SerialNumber)
        {
            InfoCenterInfo entity = null;
            List<InfoCenterInfo> list = new List<InfoCenterInfo>();

            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@SerialNumber", SqlDbType.NVarChar,512)
                };

            parms[0].Value = SerialNumber;

            using (SqlDataReader dr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspInfoCenterPanelSN", parms))
            {
                while (dr.Read())
                {
                    entity = new InfoCenterInfo();
                    entity.SerialNumber = dr.GetString(0);
                    entity.Location = dr.GetString(1);

                    list.Add(entity);
                }
            }
            return list;
        }

        /// <summary>
        /// 获取该工单下产品总个数
        /// </summary>
        /// <returns></returns>
        public int GetProductCountByOrderNo()
        {
            return productCountByOrderNo;
        }

        /// <summary>
        /// 获取工单号
        /// </summary>
        /// <returns></returns>
        public string GetProductOrderNo()
        {
            return productOrderNo;
        }

        /// <summary>
        /// 获取根据产品搜索时的箱号
        /// </summary>
        /// <returns></returns>
        public string GetBoxNumber()
        {
            return boxNumber;
        }

        /// <summary>
        /// 获取型号分组名称
        /// </summary>
        /// <returns></returns>
        public string GetModelGroupName()
        {
            return modelGroupName;
        }

        /// <summary>
        /// 获取当前查询的型号名称
        /// </summary>
        /// <returns></returns>
        public string GetModelCurrentName()
        {
            return modelCurrentName;
        }

        #endregion

        #region 不良维修信息

        /// <summary>
        /// 获取不良维修记录
        /// </summary>
        /// <param name="sn"></param>
        /// <returns></returns>
        public List<NCCodeRepairInfo> GetNCCodeList(string sn)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SN", SqlDbType.NVarChar, 512)
            };
            parms[0].Value = sn;
            return ComMethod.GetList<NCCodeRepairInfo>("uspInfoCenterGetNCCodeList", parms, null);
        }

        #endregion

        /// <summary>
        /// 入库信息
        /// </summary>
        /// <param name="sn"></param>
        /// <returns></returns>
        public WarehouseStorageInfo GetStorageInfo(string sn)
        {
            string str = @"SELECT    t.OrderNO AS WorkOrderNo, t5.StorageNumber AS InStockNo, t1.ItemCode, 
                t1.ItemName,t7.CWhCode,t7.CWhName, ISNULL(m1.CName,'') AS CreateBy,t5.CreateDateTime,t1.ItemModel,t4.BarCode,t4.CustomerSN
FROM      dbo.Prod_Order AS t LEFT OUTER JOIN
                dbo.Basal_Item AS t1 ON t1.ItemID = t.ItemId INNER JOIN
                dbo.Prod_StorageMember AS t4 ON t4.OrderNo = t.OrderNO INNER JOIN
                dbo.Prod_Storage AS t5 ON t5.StorageID = t4.StorageID
				JOIN dbo.Basal_WarehouseLocation t6 ON t6.cBarCode=t4.BarCode
				JOIN dbo.Basal_Warehouse t7 ON t7.WarehouseId=t6.cWhId
				LEFT JOIN SYS_Users m1 ( NOLOCK ) ON RTRIM(LTRIM(t5.CreateBy)) = m1.UserName
               WHERE t4.SerialNumber=@SN  or t4.CustomerSN=@SN 
GROUP BY t.OrderNO, t1.ItemCode, t1.ItemName, t5.StorageNumber, t5.CreateBy,t5.CreateDateTime,t4.BarCode,t7.CWhCode,t7.CWhName,m1.CName,t1.ItemModel,t4.BarCode,t4.CustomerSN
";
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SN", SqlDbType.NVarChar, 512)
            };
            parms[0].Value = sn;
            return ComMethod.GetBySql<WarehouseStorageInfo>(str, parms, null);

        }
        /// <summary>
        /// 出库信息
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="code"></param>
        /// <returns></returns>
        public WarehouseOutStockInfo GetOutStockInfo(string sn,string code)
        {
            //     string str = @"SELECT tt.DNCode,m3.CName,tt.FinishDateTime FROM dbo.Prod_SalOrder tt
            //                     JOIN dbo.Prod_SalOrderDtl t ON t.SalOrderID=tt.SalOrderID
            //                     JOIN dbo.Prod_SalOrderDtlMember t1 ON t1.SalOrderDtlID=t.SalOrderDtlID
            //                     LEFT JOIN dbo.Prod_SalOrderDtlMemberHistory t2 ON t2.ID=t1.ID
            //                     JOIN dbo.Basal_Item t3 ON t3.ItemCode=t.ItemCode
            //LEFT JOIN SYS_Users m3 ( NOLOCK ) ON RTRIM(LTRIM(tt.FinishBy)) = m3.UserName
            //                     WHERE t1.Number=@SN OR  t1.Number=@SN1 OR  t2.Code=@Code ";
            string str = @"SELECT ps.DNCode,m3.CName,ps.FinishDateTime 
                           FROM dbo.Prod_SalOrder ps
                           JOIN dbo.Prod_SalOrderDtl pd ON ps.SalOrderID=pd.SalOrderID
                           INNER JOIN dbo.Prod_SalOrderSN pn WITH(NOLOCK) ON pd.SalOrderDtlID = pn.SalOrderDtlId
                           JOIN dbo.Basal_Item t3 ON t3.ItemCode=pd.ItemCode
                           LEFT JOIN SYS_Users m3 ( NOLOCK ) ON RTRIM(LTRIM(ps.FinishBy)) = m3.UserName
                           WHERE pn.SerialNumber = @SN";
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SN", SqlDbType.NVarChar, 512),
                new SqlParameter("@Code", SqlDbType.NVarChar, 512),
                new SqlParameter("@SN1", SqlDbType.NVarChar, 512)

            };
            parms[0].Value = sn;
            parms[1].Value = sn;
            parms[2].Value = code;
            return ComMethod.GetBySql<WarehouseOutStockInfo>(str, parms, null);
        }
        #region 出货详情信息
        public StockInfo.WarehouseCpOutStockInfo GetDNInfo(string sn)
        {
            /*string str = @"SELECT tt.SalOrderID,tt.DNCode,tt.SalOrderDate,tt.CusCode,tt.CusName,tt.Address,tt.Status,ISNULL(s.CName,'') CreateBy,tt.CreateDateTime,ISNULL(s1.CName,'') ModifyBy,tt.ModifyDateTime,ISNULL(s2.CName,'') FinishBy,tt.FinishDateTime,tt.BackERPStatus,tt.BackERPDateTime,ISNULL(s3.CName,'') StockConfirmBy,tt.StockConfirmTime FROM dbo.Prod_SalOrder tt
                            JOIN dbo.Prod_SalOrderDtl t ON t.SalOrderID=tt.SalOrderID
                            JOIN dbo.Prod_SalOrderDtlMember t1 ON t1.SalOrderDtlID=t.SalOrderDtlID
                            LEFT JOIN dbo.Prod_SalOrderDtlMemberHistory t2 ON t2.ID=t1.ID
                            JOIN dbo.Basal_Item t3 ON t3.ItemCode=t.ItemCode
							LEFT JOIN dbo.SYS_Users s ON tt.CreateBy=s.UserName
							LEFT JOIN dbo.SYS_Users s1 ON tt.ModifyBy=s1.UserName
							LEFT JOIN dbo.SYS_Users s2 ON tt.FinishBy=s2.UserName
							LEFT JOIN dbo.SYS_Users s3 ON tt.StockConfirmBy=s3.UserName
                            WHERE t1.Number=@SN 
                            UNION ALL
                            SELECT tt.SalOrderID,tt.DNCode,tt.SalOrderDate,tt.CusCode,tt.CusName,tt.Address,tt.Status,ISNULL(s.CName,'') CreateBy,tt.CreateDateTime,ISNULL(s1.CName,'') ModifyBy,tt.ModifyDateTime,ISNULL(s2.CName,'') FinishBy,tt.FinishDateTime,tt.BackERPStatus,tt.BackERPDateTime,ISNULL(s3.CName,'') StockConfirmBy,tt.StockConfirmTime FROM dbo.Prod_SalOrder tt
                            JOIN dbo.Prod_SalOrderDtl t ON t.SalOrderID=tt.SalOrderID
                            JOIN dbo.Prod_SalOrderDtlMember t1 ON t1.SalOrderDtlID=t.SalOrderDtlID
                            JOIN dbo.Prod_SalOrderDtlMemberHistory t2 ON t2.ID=t1.ID
                            JOIN dbo.Basal_Item t3 ON t3.ItemCode=t.ItemCode
							LEFT JOIN dbo.SYS_Users s ON tt.CreateBy=s.UserName
							LEFT JOIN dbo.SYS_Users s1 ON tt.ModifyBy=s1.UserName
							LEFT JOIN dbo.SYS_Users s2 ON tt.FinishBy=s2.UserName
							LEFT JOIN dbo.SYS_Users s3 ON tt.StockConfirmBy=s3.UserName
                            WHERE t2.Code= @SN";*/
            //     string str = @"SELECT tt.SalOrderID,tt.DNCode,tt.SalOrderDate,tt.CusCode,tt.CusName,tt.Address,tt.Status,ISNULL(s.CName,'') CreateBy,tt.CreateDateTime,ISNULL(s1.CName,'') ModifyBy,tt.ModifyDateTime,ISNULL(s2.CName,'') FinishBy,tt.FinishDateTime,tt.BackERPStatus,tt.BackERPDateTime,ISNULL(s3.CName,'') StockConfirmBy,tt.StockConfirmTime FROM dbo.Prod_SalOrder tt
            //                     JOIN dbo.Prod_SalOrderDtl t ON t.SalOrderID=tt.SalOrderID
            //                     JOIN dbo.Prod_SalOrderSN t1 ON t1.SalOrderDtlID=t.SalOrderDtlID
            //                     JOIN dbo.Basal_Item t3 ON t3.ItemCode=t.ItemCode
            //LEFT JOIN dbo.SYS_Users s ON tt.CreateBy=s.UserName
            //LEFT JOIN dbo.SYS_Users s1 ON tt.ModifyBy=s1.UserName
            //LEFT JOIN dbo.SYS_Users s2 ON tt.FinishBy=s2.UserName
            //LEFT JOIN dbo.SYS_Users s3 ON tt.StockConfirmBy=s3.UserName
            //                     WHERE t1.SerialNumber=@SN";
            string str = @"SELECT
                ps.SalOrderID,ps.DNCode,ps.SalOrderDate,ps.CusCode,ps.CusName,Address=IIF(ISNULL(ps.Address,'')='',cu.Address1,ps.Address),ps.Status,ISNULL(s.CName, '') CreateBy,
	            ps.CreateDateTime,ISNULL(s1.CName, '') ModifyBy,ps.ModifyDateTime,
	            ISNULL(s2.CName, '') FinishBy,ps.FinishDateTime,ps.BackERPStatus,
	            ps.BackERPDateTime,ISNULL(s3.CName, '') StockConfirmBy,ps.StockConfirmTime
             FROM dbo.Prod_SalOrder ps WITH(NOLOCK)
            INNER JOIN dbo.Prod_SalOrderDtl pd WITH(NOLOCK) ON ps.SalOrderID = pd.SalOrderID
            INNER JOIN dbo.Prod_SalOrderSN pn WITH(NOLOCK) ON pd.SalOrderDtlID = pn.SalOrderDtlId
            LEFT JOIN dbo.SYS_Users s ON ps.CreateBy = s.UserName
            LEFT JOIN dbo.SYS_Users s1 ON ps.ModifyBy = s1.UserName
            LEFT JOIN dbo.SYS_Users s2 ON ps.FinishBy = s2.UserName
            LEFT JOIN dbo.SYS_Users s3 ON ps.StockConfirmBy = s3.UserName
			LEFT JOIN dbo.Basal_Customer cu ON cu.CustomerCode=ps.CusCode
            WHERE pn.SerialNumber = @SN
            UNION ALL
            SELECT
                ps.SalOrderID,ps.DNCode,ps.SalOrderDate,ps.CusCode,ps.CusName,Address=IIF(ISNULL(ps.Address,'')='',cu.Address1,ps.Address),ps.Status,ISNULL(s.CName, '') CreateBy,
	            ps.CreateDateTime,ISNULL(s1.CName, '') ModifyBy,ps.ModifyDateTime,
	            ISNULL(s2.CName, '') FinishBy,ps.FinishDateTime,ps.BackERPStatus,
	            ps.BackERPDateTime,ISNULL(s3.CName, '') StockConfirmBy,ps.StockConfirmTime
             FROM dbo.Prod_SalOrder ps WITH(NOLOCK)
            INNER JOIN dbo.Prod_SalOrderDtl pd WITH(NOLOCK) ON ps.SalOrderID = pd.SalOrderID
            INNER JOIN dbo.Prod_SalOrderSN pn WITH(NOLOCK) ON pd.SalOrderDtlID = pn.SalOrderDtlId
            INNER JOIN dbo.Prod_Unit pu WITH(NOLOCK) ON pn.SerialNumber = pu.SN
            LEFT JOIN dbo.SYS_Users s ON ps.CreateBy = s.UserName
            LEFT JOIN dbo.SYS_Users s1 ON ps.ModifyBy = s1.UserName
            LEFT JOIN dbo.SYS_Users s2 ON ps.FinishBy = s2.UserName
            LEFT JOIN dbo.SYS_Users s3 ON ps.StockConfirmBy = s3.UserName
			LEFT JOIN dbo.Basal_Customer cu ON cu.CustomerCode=ps.CusCode
            WHERE pu.CartonNo = @SN";
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SN", SqlDbType.NVarChar, 512)
            };
            parms[0].Value = sn;
            return ComMethod.GetBySql<StockInfo.WarehouseCpOutStockInfo>(str, parms, null);
        }
        #endregion

        #region 出货详情信息
        public List<StockInfo.WarehouseCpOutStockDtlInfo> GetDNDtlInfo(string sn)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SN", SqlDbType.NVarChar, 512)
            };
            parms[0].Value = sn;
            return ComMethod.GetList<StockInfo.WarehouseCpOutStockDtlInfo>("uspInfoOutSotckList", parms, null);
        }
        public List<StockInfo.WarehouseCpOutStockDtlInfo> GetMemberHistoryList(int id)
        {
            string str = @"SELECT  Number,ISNULL(CartonCode,'') AS CartonCode ,ISNULL(Code,'')AS Code FROM dbo.Prod_SalOrderDtlMember t
                        LEFT JOIN  Prod_SalOrderDtlMemberHistory t1 ON t1.ID=t.ID WHERE t.SalOrderDtlID=@ID ORDER BY  t.CreateDateTime DESC ";
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ID", SqlDbType.Int)
            };
            parms[0].Value = id;
            return ComMethod.GetListBySql<StockInfo.WarehouseCpOutStockDtlInfo>(str, parms, null);
        }
        #endregion

        #region 测试数据
        /// <summary>
        /// 测试数据
        /// </summary>
        /// <param name="SN"></param>
        /// <returns></returns>
        public DataTable GetTestDate(string SN)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SN", SqlDbType.NVarChar, 100)
            };
            parms[0].Value = SN;

            return SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "uspInfoCenterGetTestData", parms);
        }

        /// <summary>
        /// 通过ID获取测试数据
        /// </summary>
        /// <param name="RecordID">行ID</param>
        /// <returns>测试数据XML字符串</returns>
        public string GetTextDataXMLByID(string RecordID)
        {
            string testDataXml = string.Empty;
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@RecordID", SqlDbType.VarChar,20)
            };
            parms[0].Value = RecordID;

            DataTable dt = SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "uspGetTestDataXML", parms);
            if (dt != null && dt.Rows.Count > 0)
            {
                testDataXml = dt.Rows[0]["TestXMLData"].ToString();
            }
            return testDataXml;
        }
        #endregion
        #endregion







    }
}
