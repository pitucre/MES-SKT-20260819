using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Text.RegularExpressions;
using SKT.LeanMES.Product.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.CommonLibrary.Common;
using SKT.LeanMES.CommonHelper.BLL;

namespace SKT.LeanMES.Product.BLL
{
    public class Item
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） Item 信息。
        /// </summary>
        /// <param name="entity">Item 实体对象。</param>
        public void Edit(ItemInfo entity, String certificationList, String printDocList)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ItemID", SqlDbType.Int),
                new SqlParameter("@ItemName", SqlDbType.NVarChar, 255),
                new SqlParameter("@ItemRev", SqlDbType.VarChar, 10),
                new SqlParameter("@Description", SqlDbType.NVarChar, 200),
                new SqlParameter("@CPN", SqlDbType.NVarChar, 50),
                new SqlParameter("@CustomerID", SqlDbType.Int),
                new SqlParameter("@CPR", SqlDbType.VarChar, 10),
                new SqlParameter("@Status", SqlDbType.Int),
                new SqlParameter("@ProjectID", SqlDbType.Int),
                new SqlParameter("@ItemType", SqlDbType.Int),
                new SqlParameter("@RouterID", SqlDbType.Int),
                new SqlParameter("@BomId", SqlDbType.Int),
                new SqlParameter("@LotSize", SqlDbType.Float),
                new SqlParameter("@MaxUsageAsComp", SqlDbType.Float),
                new SqlParameter("@QtyRestriction", SqlDbType.Int),
                new SqlParameter("@QtyMultiplier", SqlDbType.Float),
                new SqlParameter("@IsCurrentRev", SqlDbType.Bit),
                new SqlParameter("@IsPanel", SqlDbType.Bit),
                new SqlParameter("@IsCPSFC", SqlDbType.Bit),
                new SqlParameter("@IsRoHS", SqlDbType.Bit),
                new SqlParameter("@DCOAssembly", SqlDbType.Int),
                new SqlParameter("@DCORemoval", SqlDbType.Int),
                new SqlParameter("@DCOInveRec", SqlDbType.Int),
                new SqlParameter("@RecInveWhenAss", SqlDbType.Bit),
                new SqlParameter("@VMGroup", SqlDbType.Int),
                new SqlParameter("@TrackableComp", SqlDbType.Bit),
                new SqlParameter("@ItemGroupID", SqlDbType.Int),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 50),
                new SqlParameter("@CertList",SqlDbType.VarChar,2000),
                new SqlParameter("@PrintDocList",SqlDbType.VarChar,2000),
                new SqlParameter("@IQCType",SqlDbType.Int),
                new SqlParameter("@Units",SqlDbType.NVarChar,20),
                new SqlParameter("@PackQty",SqlDbType.Decimal),
                new SqlParameter("@ItemCode",SqlDbType.VarChar,50),
                new SqlParameter("@SteelId",SqlDbType.Int),
                new SqlParameter("@ParentNumber",SqlDbType.Int),
                new SqlParameter("@ChildrenNumber",SqlDbType.Int),
                new SqlParameter("@ItemModel", SqlDbType.NVarChar,500),
                new SqlParameter("@LabelFirmware", SqlDbType.NVarChar,50),
                new SqlParameter("@IsNeedPrint", SqlDbType.Int),
                new SqlParameter("@IsItemOver", SqlDbType.Bit),
                new SqlParameter("@PutStation", SqlDbType.Int),
                new SqlParameter("@YieldStation", SqlDbType.Int),
                new SqlParameter("@CategoryOne", SqlDbType.NVarChar,30),
                new SqlParameter("@CategoryTwo", SqlDbType.NVarChar,30),
                new SqlParameter("@CategoryThree", SqlDbType.NVarChar,30),
                new SqlParameter("@IsMSD", SqlDbType.Bit),
                new SqlParameter("@MSL",SqlDbType.VarChar,50),
                new SqlParameter("@FloorLife", SqlDbType.Int),
                new SqlParameter("@ShelfLife", SqlDbType.Int),
                new SqlParameter("@BakeCount", SqlDbType.Int),
                new SqlParameter("@Site", SqlDbType.VarChar,20),
                new SqlParameter("@MaskId", SqlDbType.Int),
                new SqlParameter("@AgeingType", SqlDbType.Int),
                new SqlParameter("@AgeingTime", SqlDbType.Decimal),
                new SqlParameter("@ABCClass", SqlDbType.VarChar,10),
                new SqlParameter("@ExpirationDateId", SqlDbType.Int),
                new SqlParameter("@IssueWay", SqlDbType.Int),
                new SqlParameter("@IsPrintPanel", SqlDbType.Bit),
                new SqlParameter("@ProductionFace", SqlDbType.Int),
                new SqlParameter("@Priority", SqlDbType.Int),
                new SqlParameter("@IsUpTestExport", SqlDbType.Bit),
                new SqlParameter("@IsShipmentReport", SqlDbType.Bit),
                new SqlParameter("@IsSmt", SqlDbType.Bit),
                new SqlParameter("@QcMinNum",SqlDbType.Decimal),
                new SqlParameter("@AcquisitionMode", SqlDbType.Int),
                new SqlParameter("@IsSeniorBatch", SqlDbType.Int),
                new SqlParameter("@Colour", SqlDbType.VarChar,200),
                new SqlParameter("@TextureOfMaterial", SqlDbType.VarChar,200),
                new SqlParameter("@FlameRetardantLevel", SqlDbType.VarChar,200),
                new SqlParameter("@IsMaterialHandle",  SqlDbType.Bit),
                new SqlParameter("@OverFinshType", SqlDbType.Int),
                new SqlParameter("@OverRate", SqlDbType.Decimal),
                new SqlParameter("@OverQty", SqlDbType.Decimal),
                new SqlParameter("@MaterialPartNumberCode",SqlDbType.VarChar),
                new SqlParameter("@MaterialHandleNumberCode",SqlDbType.VarChar),
                new SqlParameter("@ScrapMaterialNumberCode",SqlDbType.VarChar)
            };

            parms[0].Value = entity.ItemID;
            parms[1].Value = entity.ItemName;
            parms[2].Value = entity.ItemRev;
            parms[3].Value = entity.Description;
            parms[4].Value = entity.CPN;
            parms[5].Value = entity.CustomerID;
            parms[6].Value = entity.CPR;
            parms[7].Value = entity.Status;
            parms[8].Value = entity.ProjectID;
            parms[9].Value = entity.ItemType;
            parms[10].Value = entity.RouterID;
            parms[11].Value = entity.BomId;
            parms[12].Value = entity.LotSize;
            parms[13].Value = entity.MaxUsageAsComp;
            parms[14].Value = entity.QtyRestriction;
            parms[15].Value = entity.QtyMultiplier;
            parms[16].Value = entity.IsCurrentRev;
            parms[17].Value = entity.IsPanel;
            parms[18].Value = entity.IsCPSFC;
            parms[19].Value = entity.IsRoHS;
            parms[20].Value = entity.DCOAssembly;
            parms[21].Value = entity.DCORemoval;
            parms[22].Value = entity.DCOInveRec;
            parms[23].Value = entity.RecInveWhenAss;
            parms[24].Value = entity.VMGroup;
            parms[25].Value = entity.TrackableComp;
            parms[26].Value = entity.ItemGroupID;
            parms[27].Value = entity.CreateBy;
            parms[28].Value = entity.ModifyBy;
            parms[29].Value = entity.Remark;
            parms[30].Value = certificationList;
            parms[31].Value = printDocList;
            parms[32].Value = entity.IQCType;
            parms[33].Value = entity.Units;
            parms[34].Value = entity.MinPackQty;
            parms[35].Value = entity.ItemCode;
            parms[36].Value = entity.SteelId;
            parms[37].Value = entity.ParentNumber;
            parms[38].Value = entity.ChildrenNumber;
            parms[39].Value = entity.ItemModel;
            parms[40].Value = entity.LabelFirmware;
            parms[41].Value = entity.IsNeedPrint;
            parms[42].Value = entity.IsItemOver;
            parms[43].Value = entity.PutStation;
            parms[44].Value = entity.YieldStation;
            parms[45].Value = entity.CategoryOne;
            parms[46].Value = entity.CategoryTwo;
            parms[47].Value = entity.CategoryThree;
            parms[48].Value = entity.IsMSD;
            parms[49].Value = entity.MSL;
            parms[50].Value = entity.FloorLife;
            parms[51].Value = entity.ShelfLife;
            parms[52].Value = entity.BakeCount;
            parms[53].Value = entity.Site;
            parms[54].Value = entity.MaskId;
            parms[55].Value = entity.AgeingType;
            parms[56].Value = entity.AgeingTime;
            parms[57].Value = entity.ABCClass;
            parms[58].Value = entity.ExpirationDateId;
            parms[59].Value = entity.IssueWay;
            parms[60].Value = entity.IsPanelPrint;
            parms[61].Value = entity.ProductionFace;
            parms[62].Value = entity.Priority;
            parms[63].Value = entity.IsUpTestExport;
            parms[64].Value = entity.IsShipmentReport;
            parms[65].Value = entity.IsSmt;
            parms[66].Value = entity.QcMinNum;
            parms[67].Value = entity.AcquisitionMode;
            parms[68].Value = entity.IsSeniorBatch;
            parms[69].Value = entity.Colour;
            parms[70].Value = entity.TextureOfMaterial;
            parms[71].Value = entity.FlameRetardantLevel;
            parms[72].Value = entity.IsMaterialHandle;
            parms[73].Value = entity.OverFinshType;
            parms[74].Value = entity.OverRate;
            parms[75].Value = entity.OverQty;
            parms[76].Value = entity.MaterialPartNumberCode;
            parms[77].Value = entity.MaterialHandleNumberCode;
            parms[78].Value = entity.ScrapMaterialNumberCode;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_Item_Edit", parms);
        }

        /// <summary>
        /// 根据 ItemId 字符串删除 Item 信息。
        /// </summary>
        /// <param name="idString">ItemId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_Item_Delete", parms);
        }
        /// <summary>
        /// 获取证书信息
        /// </summary>
        /// <param name="itemId"></param>
        /// <returns></returns>
        public DataTable GetQualCertByItemID(Int32 itemId)
        {
            SqlParameter[] parameter = new SqlParameter[] { 
                new SqlParameter("@ItemID",SqlDbType.Int)
            };
            parameter[0].Value = itemId;

            DataTable dt = SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "uspGetQualByItemID", parameter);
            return dt;
        }
        /// <summary>
        /// 获取打印文档信息
        /// </summary>
        /// <param name="itemId"></param>
        /// <returns></returns>
        public DataTable GetPrintDocByItemID(Int32 itemId)
        {
            SqlParameter[] parameter = new SqlParameter[] { 
                new SqlParameter("@ItemID",SqlDbType.Int)
            };
            parameter[0].Value = itemId;

            DataTable dt = SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "uspGetPrintDocByItemID", parameter);
            return dt;
        }
        /// <summary>
        /// 根据 ItemId 获取实体信息。
        /// </summary>
        /// <param name="itemId">ItemId。</param>
        /// <returns>Item 实体对象。</returns>
        public ItemInfo GetInfo(Int32 itemId)
        {
            ItemInfo entity = new ItemInfo();
            entity = ComMethod.GetInfo<ItemInfo>(itemId, "Basal_Item_GetInfo", SQLHelper.MESConnString);
           /* using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_Item_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new ItemInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetInt32(5), rdr.GetString(6), rdr.GetInt32(7), rdr.GetInt32(8), rdr.GetInt32(9),
                        rdr.GetInt32(10), rdr.GetInt32(11), rdr.GetDouble(12), rdr.GetDouble(13), rdr.GetInt32(14),
                        rdr.GetDouble(15), rdr.GetBoolean(16), rdr.GetBoolean(17), rdr.GetBoolean(18), rdr.GetBoolean(19),
                        rdr.GetInt32(20), rdr.GetInt32(21), rdr.GetInt32(22), rdr.GetBoolean(23), rdr.GetInt32(24),
                        rdr.GetBoolean(25), rdr.GetInt32(26), rdr.GetString(27), rdr.GetDateTime(28), rdr.GetString(29),
                        rdr.GetDateTime(30), rdr.GetString(31));

                    entity.ProjectName = rdr.GetString(32);
                    entity.CustomerName = rdr.GetString(33);
                    entity.BomName = rdr.GetString(34);
                    entity.DataTypeName = rdr.GetString(35);
                    entity.ParentNumber = rdr.GetInt32(36);
                    entity.ChildrenNumber = rdr.GetInt32(37);
                    entity.IQCTypeName = rdr.GetString(38);
                    entity.Units = rdr.GetString(39);
                    entity.MinPackQty = rdr.GetDecimal(40);
                    entity.RouterName = rdr.GetString(41);
                    entity.IQCType = rdr.GetInt32(42);
                    entity.ItemCode = rdr.GetString(43);

                    entity.SteelId = rdr.GetInt32(44);

                    entity.ParentNumber = rdr.GetInt32(45);
                    entity.ChildrenNumber = rdr.GetInt32(46);

                    entity.ItemModel = rdr.GetString(47);
                    entity.LabelFirmware = rdr.GetString(48);

                    entity.IsMESadd = rdr.GetString(49);
                    //IsNeedPrint是否需要打印；IsItemOver是否可超发
                    entity.IsNeedPrint = rdr.GetInt32(50);
                    entity.IsItemOver = rdr.GetBoolean(51);
                    entity.PutStation = rdr.GetInt32(52);
                    entity.YieldStation = rdr.GetInt32(53);
                    entity.CategoryOne = rdr.GetString(54);
                    entity.CategoryTwo = rdr.GetString(55);
                    entity.CategoryThree = rdr.GetString(56);
                    entity.IsMSD = rdr.GetBoolean(57);
                    entity.MSL = rdr.GetString(58);
                    entity.FloorLife = rdr.GetInt32(59);
                    entity.BakeCount = rdr.GetInt32(60);
                    entity.ShelfLife = rdr.GetInt32(61);
                    entity.FactoryName = rdr.GetString(62);
                    entity.Site = rdr.GetString(63);
                    entity.MaskId = rdr.GetInt32(64);
                    entity.MaskGroupName = rdr.GetString(65);
                    entity.AgeingType = rdr.GetInt32(66);
                    entity.AgeingTime = rdr.GetDecimal(67);
                    entity.ABCClass = rdr.GetString(68);//Modify by zhiman.yuan 2017-10-12

                    //保质期方案信息 zhuchenglong 2017-11-09
                    entity.ExpirationDateId= rdr.GetInt32(69);
                    entity.ExpirationDateName = rdr.GetString(70);
                    entity.IssueWay = rdr.GetInt32(71);//发料方式
                    entity.IsPrintPanel = rdr.GetBoolean(72);
                }
                rdr.Close();
            }*/

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>Item 实体对象。</returns>
        public ItemInfo GetInfo(String fieldValue)
        {
            ItemInfo entity = new ItemInfo();
            entity = ComMethod.GetInfo<ItemInfo>(fieldValue, "Basal_Item_GetInfo", SQLHelper.MESConnString);
            /*SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_Item_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new ItemInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetInt32(5), rdr.GetString(6), rdr.GetInt32(7), rdr.GetInt32(8), rdr.GetInt32(9),
                        rdr.GetInt32(10), rdr.GetInt32(11), rdr.GetDouble(12), rdr.GetDouble(13), rdr.GetInt32(14),
                        rdr.GetDouble(15), rdr.GetBoolean(16), rdr.GetBoolean(17), rdr.GetBoolean(18), rdr.GetBoolean(19),
                        rdr.GetInt32(20), rdr.GetInt32(21), rdr.GetInt32(22), rdr.GetBoolean(23), rdr.GetInt32(24),
                        rdr.GetBoolean(25), rdr.GetInt32(26), rdr.GetString(27), rdr.GetDateTime(28), rdr.GetString(29),
                        rdr.GetDateTime(30), rdr.GetString(31));

                    entity.ProjectName = rdr.GetString(32);
                    entity.CustomerName = rdr.GetString(33);
                    entity.BomName = rdr.GetString(34);
                    entity.DataTypeName = rdr.GetString(35);
                    entity.ParentNumber = rdr.GetInt32(36);
                    entity.ChildrenNumber = rdr.GetInt32(37);
                    entity.IQCTypeName = rdr.GetString(38);
                    entity.Units = rdr.GetString(39);
                    entity.MinPackQty = rdr.GetDecimal(40);
                    entity.RouterName = rdr.GetString(41);
                    entity.IQCType = rdr.GetInt32(42);
                    entity.ItemCode = rdr.GetString(43);

                    entity.SteelId = rdr.GetInt32(44);

                    entity.ParentNumber = rdr.GetInt32(45);
                    entity.ChildrenNumber = rdr.GetInt32(46);

                    entity.ItemModel = rdr.GetString(47);
                    entity.LabelFirmware = rdr.GetString(48);

                    entity.IsMESadd = rdr.GetString(49);
                    //IsNeedPrint是否需要打印；IsItemOver是否可超发
                    entity.IsNeedPrint = rdr.GetInt32(50);
                    entity.IsItemOver = rdr.GetBoolean(51);
                    entity.PutStation = rdr.GetInt32(52);
                    entity.YieldStation = rdr.GetInt32(53);
                    entity.CategoryOne = rdr.GetString(54);
                    entity.CategoryTwo = rdr.GetString(55);
                    entity.CategoryThree = rdr.GetString(56);
                    entity.IsMSD = rdr.GetBoolean(57);
                    entity.MSL = rdr.GetString(58);
                    entity.FloorLife = rdr.GetInt32(59);
                    entity.BakeCount = rdr.GetInt32(60);
                    entity.ShelfLife = rdr.GetInt32(61);
                    entity.FactoryName = rdr.GetString(62);
                    entity.Site = rdr.GetString(63);
                    entity.MaskId = rdr.GetInt32(64);
                    entity.MaskGroupName = rdr.GetString(65);

                    entity.AgeingType = rdr.GetInt32(66);
                    entity.AgeingTime = rdr.GetDecimal(67);
                    entity.ABCClass = rdr.GetString(68);//Modify by zhiman.yuan 2017-10-12

                    //保质期方案信息 zhuchenglong 2017-11-09
                    entity.ExpirationDateId = rdr.GetInt32(69);
                    entity.ExpirationDateName = rdr.GetString(70);
                    entity.IssueWay = rdr.GetInt32(71);//发料方式
                }
                rdr.Close();
            }*/

            return entity;
        }
        /// <summary>
        /// 获取物料信息
        /// </summary>
        /// <param name="itemCode">物料编码</param>
        /// <returns></returns>
        public string GetItemInfo(string itemCode)
        {
            SqlParameter[] paras = new SqlParameter[]{
               new SqlParameter("@ItemCode",SqlDbType.NVarChar)
            };
            paras[0].Value = itemCode;

            string sql = "select ItemID,ItemCode,ItemName from Basal_Item where ItemCode=@ItemCode ";
            return ComMethod.GetBySql(sql, paras);
        }
        /// <summary>
        /// 分页获取 Item 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="itemCount">item 总数。</param>
        /// <returns>Item 列表。</returns>
        public List<ItemInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ItemInfo> list = new List<ItemInfo>();
            //表名或者视图
            string strTb = "vwBasal_ItemNew";////Basal_Item
            //主键
            string strKey = "ItemID";
            //查询栏位字串
            string strColumns = @" [ItemID], [ItemName], [ItemRev], [Description], [CPN], [CustomerID], [CPR], [Status], [ProjectID], [ItemType], [RouterID], [BomId], [LotSize], [MaxUsageAsComp], [QtyRestriction], [QtyMultiplier], [IsCurrentRev], [IsPanel], [IsCPSFC], [IsRoHS], [DCOAssembly], [DCORemoval], [DCOInveRec], [RecInveWhenAss], [VMGroup], [TrackableComp], [ItemGroupID], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime], [Remark],[Units], [ItemCode], [Site], CASE IsMESadd WHEN 0 THEN 'ERP' WHEN 1 THEN 'MES' ELSE '' END AS IsMESadd,isnull(IsNeedPrint,0)IsNeedPrint,isnull(IsItemOver,0)IsItemOver,isnull(CategoryOne,'') CategoryOne,isnull(CategoryTwo,'') CategoryTwo,isnull(CategoryThree,'') CategoryThree,ISNULL(IsMSD,0) IsMSD,ISNULL(MSL,'') MSL,ISNULL(FloorLife,0) FloorLife,ISNULL(BakeCount,0) BakeCount,ISNULL(ShelfLife,0) ShelfLife,ISNULL(ItemModel,'') ItemModel,isnull(ItemSpec,'')ItemSpec,SmtIndustry,MaskId,MaskGroupName,AcquisitionMode,AcquisitionModeString,IsSeniorBatch,IsSeniorBatchName ";
            list = ComMethod.GetComList<ItemInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            return list;
            /*  using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
              {
                  while (rdr.Read())
                  {
                      entity = new ItemInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                          rdr.GetInt32(5), rdr.GetString(6), rdr.GetInt32(7), rdr.GetInt32(8), rdr.GetInt32(9),
                          rdr.GetInt32(10), rdr.GetInt32(11), rdr.GetDouble(12), rdr.GetDouble(13), rdr.GetInt32(14),
                          rdr.GetDouble(15), rdr.GetBoolean(16), rdr.GetBoolean(17), rdr.GetBoolean(18), rdr.GetBoolean(19),
                          rdr.GetInt32(20), rdr.GetInt32(21), rdr.GetInt32(22), rdr.GetBoolean(23), rdr.GetInt32(24),
                          rdr.GetBoolean(25), rdr.GetInt32(26), rdr.GetString(27), rdr.GetDateTime(28), rdr.GetString(29),
                          rdr.GetDateTime(30), rdr.GetString(31));
                      entity.Units = rdr.GetString(32);
                      entity.ItemCode = rdr.GetString(33);
                      entity.Site = rdr.GetString(34);
                      entity.IsMESadd = rdr.GetString(35);
                      //新增的字段
                      entity.IsNeedPrint = rdr.GetInt32(36);
                      entity.IsItemOver = rdr.GetBoolean(37);
                      entity.CategoryOne = rdr.GetString(38);
                      entity.CategoryTwo = rdr.GetString(39);
                      entity.CategoryThree = rdr.GetString(40);
                      entity.IsMSD = rdr.GetBoolean(41);
                      entity.MSL = rdr.GetString(42);
                      entity.FloorLife = rdr.GetInt32(43);
                      entity.BakeCount = rdr.GetInt32(44);
                      entity.ShelfLife = rdr.GetInt32(45);
                      entity.ItemModel = rdr.GetString(46);
                      entity.ItemSpec = rdr.GetString(47);
                      list.Add(entity);
                  }
                  rdr.Close();
              }

              recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;*/
        }
        #region 获取物料类型信息
        /// <summary>
        /// 获取物料类型信息
        /// </summary>
        /// <param name="ProductBarCode"></param>
        /// <param name="ProductCode"></param>
        /// <param name="MoCode"></param>
        /// <returns></returns>
        public DataSet GetItemTypeInfo(string ItemTypeCode, string ItemTypeName)
        {
            DataSet ds = new DataSet();
            DataSqlParamters dPsrams = new DataSqlParamters();
            dPsrams.Commandtype = CommandType.StoredProcedure;
            dPsrams.CommandText = "uspGetItemTypeInfo";
            dPsrams.Add(new SqlParameter("@ItemTypeCode", SqlDbType.VarChar, 100), ItemTypeCode);
            dPsrams.Add(new SqlParameter("@ItemTypeName", SqlDbType.VarChar, 100), ItemTypeName);
            SqlDataReaderAPI.DataSqlSelect(ref ds, dPsrams);
            return ds;
        }

        #endregion

        #region 删除物料类型信息
        /// <summary>
        /// 删除物料类型信息
        /// </summary>
        /// <param name="idString"></param>
        /// <param name="userName"></param>
        public void DeleteItemTypeInfo(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000)
            };
            parms[0].Value = idString;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_DeleteItemTypeInfo", parms);
        }
        #endregion

        #region 新增/修改物料类型信息
        /// <summary>
        /// 新增/修改物料类型信息
        /// </summary>
        /// <param name="entity"></param>
        /// <param name="userName"></param>
        public void SaveItemTypeInfo(ItemInfo entity, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ItemTypeID", SqlDbType.Int),
                new SqlParameter("@ItemTypeCode", SqlDbType.VarChar, 50),
                new SqlParameter("@ItemTypeName", SqlDbType.VarChar,200),
                new SqlParameter("@Remark", SqlDbType.VarChar, 200),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20)
            };
            parms[0].Value = entity.ItemTypeID;
            parms[1].Value = entity.ItemTypeCode;
            parms[2].Value = entity.ItemTypeName;
            parms[3].Value = entity.Remark;
            parms[4].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_SaveItemTypeInfo", parms);
        }

        #endregion

        #region 根据物料类型ID获取物料类型详细信息
        /// <summary>
        /// 根据物料类型ID获取物料类型详细信息
        /// </summary>
        /// <param name="id">物料类型ID</param>
        /// <returns></returns>
        public ItemInfo GetItemTypeInfo(Int32 id)
        {
            ItemInfo entity = null;
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@id", SqlDbType.Int)
            };
            parms[0].Value = id;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_GetItemTypeInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new ItemInfo();
                    entity.ItemTypeID = rdr.GetInt32(0);
                    entity.ItemTypeCode = rdr.GetString(1);
                    entity.ItemTypeName = rdr.GetString(2);
                    entity.Remark = rdr.GetString(3);
                }
                else
                {
                    entity = new ItemInfo();
                    entity.ItemTypeID = -1;
                    entity.ItemTypeCode = "";
                    entity.ItemTypeName = "";
                    entity.Remark = "";
                }
                rdr.Close();
            }
            return entity;
        }
        #endregion
        #region 确认叫料信息
        /// <summary>
        /// 确认叫料信息
        /// </summary>
        /// <param name="idString"></param>
        /// <param name="userName"></param>
        public void ConfirmCryMaterialInfo(String idString, String userName)
        {
            DataTable dt = JsonToDataTable(idString);
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@userName", SqlDbType.VarChar, 50),
                new SqlParameter("@ConfirmCryList",SqlDbType.Structured)
            };
            parms[0].Value = userName;
            parms[1].Value = dt;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_ConfirmCryMaterialInfo", parms);
        }
        #endregion

        #region 保存刷新时间
        /// <summary>
        /// 保存刷新时间
        /// </summary>
        /// <param name="TimeType"></param>
        /// <param name="TimeVaule"></param>
        public void SaveRefreshTime(string TimeType, string TimeVaule)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@TimeType", SqlDbType.VarChar, 50),
                new SqlParameter("@TimeVaule", SqlDbType.VarChar, 50)
            };
            parms[0].Value = TimeType;
            parms[1].Value = TimeVaule;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSaveRefreshTime", parms);
        }
        #endregion

        #region 将 Json 解析成 DateTable
        /// <summary>    
        /// 将 Json 解析成 DateTable   
        /// Json 数据格式如:  
        ///{table:[{column1:1,column2:2,column3:3},{column1:1,column2:2,column3:3}]} 
        /// </summary>    
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

        #region 获取叫料信息
        /// <summary>
        /// 获取物料类型信息
        /// </summary>
        /// <param name="ProductBarCode"></param>
        /// <param name="ProductCode"></param>
        /// <param name="MoCode"></param>
        /// <returns></returns>
        public DataSet GetCryMaterialInfo(string ItemTypeCode, string ItemTypeName, string StationId, string ResourceId, string MoCode, string ItemCode, string States, string DateTimeStart, string DateTimeEnd)
        {
            DataSet ds = new DataSet();
            DataSqlParamters dPsrams = new DataSqlParamters();
            dPsrams.Commandtype = CommandType.StoredProcedure;
            dPsrams.CommandText = "uspGetCryMaterialInfo";
            dPsrams.Add(new SqlParameter("@ItemTypeCode", SqlDbType.VarChar, 100), ItemTypeCode);
            dPsrams.Add(new SqlParameter("@ItemTypeName", SqlDbType.VarChar, 100), ItemTypeName);
            dPsrams.Add(new SqlParameter("@StationId", SqlDbType.VarChar, 100), StationId);
            dPsrams.Add(new SqlParameter("@ResourceId", SqlDbType.VarChar, 100), ResourceId);
            dPsrams.Add(new SqlParameter("@MoCode", SqlDbType.VarChar, 100), MoCode);
            dPsrams.Add(new SqlParameter("@ItemCode", SqlDbType.VarChar, 100), ItemCode);
            dPsrams.Add(new SqlParameter("@States", SqlDbType.VarChar, 100), States);
            dPsrams.Add(new SqlParameter("@DateTimeStart", SqlDbType.VarChar, 100), DateTimeStart);
            dPsrams.Add(new SqlParameter("@DateTimeEnd", SqlDbType.VarChar, 100), DateTimeEnd);
            SqlDataReaderAPI.DataSqlSelect(ref ds, dPsrams);
            return ds;
        }

        #endregion

        #region 获取工单产品信息
        /// <summary>
        /// 获取工单产品信息
        /// </summary>
        /// <param name="ProductBarCode"></param>
        /// <param name="ProductCode"></param>
        /// <param name="MoCode"></param>
        /// <returns></returns>
        public DataSet GetMoProductInfo(string ProductCode, string ProductBarCode, string MoCode, string TurnoverBar)
        {
            DataSet ds = new DataSet();
            DataSqlParamters dPsrams = new DataSqlParamters();
            dPsrams.Commandtype = CommandType.StoredProcedure;
            dPsrams.CommandText = "uspGetMoProductInfos";
            dPsrams.Add(new SqlParameter("@ProductBarCode", SqlDbType.VarChar, 100), ProductBarCode);
            dPsrams.Add(new SqlParameter("@ProductCode", SqlDbType.VarChar, 100), ProductCode);
            dPsrams.Add(new SqlParameter("@MoCode", SqlDbType.VarChar, 100), MoCode);
            dPsrams.Add(new SqlParameter("@TurnoverBar", SqlDbType.VarChar, 100), TurnoverBar);
            SqlDataReaderAPI.DataSqlSelect(ref ds, dPsrams);
            return ds;
        }

        #endregion
        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

        public List<ItemInfo> GetESOPItems(SearchSettings searchSettings)
        {
            List<ItemInfo> list = new List<ItemInfo>();
            ItemInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(0, -1, " dbo.Basal_Item bi INNER JOIN dbo.Prod_ESOPFileItemRelation pei ON bi.ItemID = pei.ItemID INNER JOIN dbo.Prod_ESOPFile pef ON pei.ESOPFileID=pef.ESOPFileID ", "bi.ItemID",
                " DISTINCT bi.[ItemID], bi.[ItemName], bi.[ItemCode],bi.ItemModel ", searchSettings, "");
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new ItemInfo();
                    entity.ItemID = rdr.GetInt32(0);
                    entity.ItemName = rdr.GetString(1);
                    entity.ItemCode = rdr.GetString(2);
                    entity.ItemModel = rdr.GetString(3);
                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }

    }
}