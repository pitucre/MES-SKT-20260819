using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.Common.Model;
using SKT.Common.DAL.Marshal;
using SKT.LeanMES.Equipment.Model;
using SKT.LeanMES.CommonHelper.BLL;
using System.Diagnostics;

namespace SKT.LeanMES.Equipment.BLL
{
    public class Equipments
    {
        private Int32 recordCount = 0;

        /// <summary>
        /// 编辑（添加或更新） Equipment 信息。
        /// </summary>
        /// <param name="entity">Equipment 实体对象。</param>
        public int Edit(EquipmentsInfo entity)
        {
            int EquipmentId = -1;
            try
            {
                SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@EquipmentId", SqlDbType.Int),
                new SqlParameter("@EquipmentCode", SqlDbType.VarChar, 20),
                new SqlParameter("@EquipmentName", SqlDbType.NVarChar, 50),
                new SqlParameter("@EquipmentTypeId", SqlDbType.Int),
                new SqlParameter("@EquipmentModel", SqlDbType.NVarChar, 150),
                new SqlParameter("@SupplierCode", SqlDbType.NVarChar,50),
                new SqlParameter("@Status", SqlDbType.Int),
                new SqlParameter("@LineId", SqlDbType.Int),
                new SqlParameter("@StationId", SqlDbType.Int),
                new SqlParameter("@FactoryDate", SqlDbType.DateTime),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 50),
                new SqlParameter("@VenCode",SqlDbType.NVarChar,50),
                new SqlParameter("@Position",SqlDbType.NVarChar,100),
                new SqlParameter("@VendorBarcode",SqlDbType.NVarChar,100),
                new SqlParameter("@Thick",SqlDbType.Decimal),
                new SqlParameter("@WarningCount",SqlDbType.Int),
                new SqlParameter("@UseCount",SqlDbType.Int),
                new SqlParameter("@StandarLive",SqlDbType.Int),
                new SqlParameter("@CurPosition",SqlDbType.NVarChar,100),
                new SqlParameter("@InOrOut",SqlDbType.Int),
                new SqlParameter("@IsClear",SqlDbType.Int),
                new SqlParameter("@SequenceNo",SqlDbType.Int),

                new SqlParameter("@Purchase",SqlDbType.Int),
                new SqlParameter("@UnitName",SqlDbType.NVarChar,50),
                new SqlParameter("@CareDepNo",SqlDbType.NVarChar,50),
                new SqlParameter("@CareBy",SqlDbType.NVarChar,50),
                new SqlParameter("@PictureName",SqlDbType.NVarChar,100),
                new SqlParameter("@ProduceDate",SqlDbType.DateTime),
                new SqlParameter("@GuaranteeDay",SqlDbType.Int),
                new SqlParameter("@OverGuaranteeTime",SqlDbType.DateTime),
                new SqlParameter("@AssetNumber",SqlDbType.NVarChar,100),
                new SqlParameter("@PCBModel",SqlDbType.NVarChar,100),
                new SqlParameter("@MKUsingTechnology",SqlDbType.NVarChar,100),
                new SqlParameter("@MKUsingType",SqlDbType.NVarChar,100),
                new SqlParameter("@MKTechnologyAsk",SqlDbType.NVarChar,100),
                new SqlParameter("@MKLand",SqlDbType.NVarChar,100),
                new SqlParameter("@StationName",SqlDbType.NVarChar,100),
                new SqlParameter("@EquipmentIP", SqlDbType.VarChar, 20),
                new SqlParameter("@EquipmentPort", SqlDbType.VarChar, 20)

                };

                parms[0].Value = entity.EquipmentId;
                parms[0].Direction = ParameterDirection.InputOutput;
                parms[1].Value = entity.EquipmentCode;
                parms[2].Value = entity.EquipmentName;
                parms[3].Value = entity.EquipmentTypeId;
                parms[4].Value = entity.EquipmentModel;
                parms[5].Value = entity.SupplierCode;
                parms[6].Value = entity.Status;
                parms[7].Value = entity.LineId;
                parms[8].Value = entity.StationId;
                parms[9].Value = entity.FactoryDate.ToString("yyyy-MM-dd hh:mm:ss") == "0001-01-01 12:00:00" ?
                    "9999-12-31 00:00:00" : entity.FactoryDate.ToString("yyyy-MM-dd hh:mm:ss");
                parms[10].Value = entity.CreateBy;
                parms[11].Value = entity.ModifyBy;
                parms[12].Value = entity.Remark;
                parms[13].Value = entity.VenCode;
                parms[14].Value = entity.Position;
                parms[15].Value = entity.VendorBarcode;
                parms[16].Value = entity.Thick;
                parms[17].Value = entity.WarningCount;
                parms[18].Value = entity.UseCount;
                parms[19].Value = entity.StandarLive;
                parms[20].Value = entity.CurPosition;
                parms[21].Value = entity.InOrOut;
                parms[22].Value = entity.IsClear;
                parms[23].Value = entity.SequenceNo;


                parms[24].Value = entity.Purchase;
                parms[25].Value = entity.UnitName;
                parms[26].Value = entity.CareDepNo;
                parms[27].Value = entity.CareBy;
                parms[28].Value = entity.PictureName;
                parms[29].Value = entity.ProduceDate.ToString("yyyy-MM-dd hh:mm:ss") == "0001-01-01 12:00:00" ?
                    "9999-12-31 00:00:00" : entity.ProduceDate.ToString("yyyy-MM-dd hh:mm:ss");
                parms[30].Value = entity.GuaranteeDay;
                parms[31].Value = entity.OverGuaranteeTime.ToString("yyyy-MM-dd hh:mm:ss") == "0001-01-01 12:00:00" ?
                    "9999-12-31 00:00:00" : entity.OverGuaranteeTime.ToString("yyyy-MM-dd hh:mm:ss");
                parms[32].Value = string.IsNullOrEmpty(entity.AssetNumber) ? "" : entity.AssetNumber;
                parms[33].Value = string.IsNullOrEmpty(entity.PCBModel) ? "" : entity.PCBModel;
                parms[34].Value = string.IsNullOrEmpty(entity.MKUsingTechnology) ? "" : entity.MKUsingTechnology;
                parms[35].Value = string.IsNullOrEmpty(entity.MKUsingType) ? "" : entity.MKUsingType;
                parms[36].Value = string.IsNullOrEmpty(entity.MKTechnologyAsk) ? "" : entity.MKTechnologyAsk;
                parms[37].Value = string.IsNullOrEmpty(entity.MKLand) ? "0" : entity.MKLand;
                parms[38].Value = entity.StationName;
                parms[39].Value = entity.EquipmentIP;
                parms[40].Value = entity.EquipmentPort;
                SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_Equipment_Edit", parms);

                EquipmentId = Convert.ToInt32(parms[0].Value);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return EquipmentId;
        }
        /// <summary>
        /// 编辑（添加或更新） Equipment 信息。
        /// </summary>
        /// <param name="entity">Equipment 实体对象。</param>
        public int EditNew(EquipmentsInfo entity)
        {
            int EquipmentId = -1;
            try
            {
                SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@EquipmentId", SqlDbType.Int){ Value = entity.EquipmentId,Direction=ParameterDirection.InputOutput},
                new SqlParameter("@EquipmentCode", SqlDbType.VarChar){ Value = entity.EquipmentCode},
                new SqlParameter("@EquipmentName", SqlDbType.NVarChar){ Value = entity.EquipmentName},
                new SqlParameter("@EquipmentTypeId", SqlDbType.Int){ Value = entity.EquipmentTypeId},
                new SqlParameter("@EquipmentModel", SqlDbType.NVarChar){ Value = entity.EquipmentModel},
                new SqlParameter("@SupplierCode", SqlDbType.NVarChar){ Value=entity.SupplierCode},
                new SqlParameter("@Status", SqlDbType.Int){ Value = entity.Status},
                new SqlParameter("@LineId", SqlDbType.Int){ Value = entity.LineId},
                new SqlParameter("@StationId", SqlDbType.Int){ Value = entity.StationId},
                new SqlParameter("@FactoryDate", SqlDbType.DateTime){ Value = entity.FactoryDate.ToString("yyyy-MM-dd hh:mm:ss") == "0001-01-01 12:00:00" ?"9999-12-31 00:00:00" : entity.FactoryDate.ToString("yyyy-MM-dd hh:mm:ss")},
                new SqlParameter("@CreateBy", SqlDbType.VarChar){ Value = entity.CreateBy},
                new SqlParameter("@ModifyBy", SqlDbType.VarChar){ Value = entity.ModifyBy},
                new SqlParameter("@Remark", SqlDbType.NVarChar){ Value = entity.Remark},
                new SqlParameter("@VenCode",SqlDbType.NVarChar){ Value = entity.VenCode},
                new SqlParameter("@Position",SqlDbType.NVarChar){ Value = entity.Position},
                new SqlParameter("@VendorBarcode",SqlDbType.NVarChar){ Value = entity.VendorBarcode},
                new SqlParameter("@Thick",SqlDbType.Decimal){ Value = entity.Thick},
                new SqlParameter("@WarningCount",SqlDbType.Int){ Value = entity.WarningCount},
                new SqlParameter("@UseCount",SqlDbType.Int){ Value = entity.UseCount},
                new SqlParameter("@StandarLive",SqlDbType.Int){ Value = entity.StandarLive},
                new SqlParameter("@CurPosition",SqlDbType.NVarChar,100){ Value = entity.CurPosition},
                new SqlParameter("@InOrOut",SqlDbType.Int){ Value = entity.InOrOut},
                new SqlParameter("@IsClear",SqlDbType.Int){ Value = entity.IsClear},
                new SqlParameter("@SequenceNo",SqlDbType.Int){ Value =  entity.SequenceNo},

                new SqlParameter("@Purchase",SqlDbType.Int){ Value = entity.Purchase},
                new SqlParameter("@UnitName",SqlDbType.NVarChar){ Value = entity.UnitName},
                new SqlParameter("@CareDepNo",SqlDbType.NVarChar){ Value = entity.CareDepNo},
                new SqlParameter("@CareBy",SqlDbType.NVarChar){ Value = entity.CareBy},
                new SqlParameter("@PictureName",SqlDbType.NVarChar){ Value = entity.PictureName},
                new SqlParameter("@ProduceDate",SqlDbType.DateTime){ Value = entity.ProduceDate.ToString("yyyy-MM-dd hh:mm:ss") == "0001-01-01 12:00:00" ?"9999-12-31 00:00:00" : entity.ProduceDate.ToString("yyyy-MM-dd hh:mm:ss")},
                new SqlParameter("@GuaranteeDay",SqlDbType.Int){ Value = entity.GuaranteeDay},
                new SqlParameter("@OverGuaranteeTime",SqlDbType.DateTime){ Value = entity.OverGuaranteeTime.ToString("yyyy-MM-dd hh:mm:ss") == "0001-01-01 12:00:00" ?"9999-12-31 00:00:00" : entity.OverGuaranteeTime.ToString("yyyy-MM-dd hh:mm:ss")},
                new SqlParameter("@AssetNumber",SqlDbType.NVarChar){ Value =  string.IsNullOrEmpty(entity.AssetNumber) ? "" : entity.AssetNumber},
                new SqlParameter("@PCBModel",SqlDbType.NVarChar){ Value = string.IsNullOrEmpty(entity.PCBModel) ? "" : entity.PCBModel},
                new SqlParameter("@MKUsingTechnology",SqlDbType.NVarChar){ Value = string.IsNullOrEmpty(entity.MKUsingTechnology) ? "" : entity.MKUsingTechnology},
                new SqlParameter("@MKUsingType", SqlDbType.NVarChar) { Value = string.IsNullOrEmpty(entity.MKUsingType) ? "" : entity.MKUsingType },
                new SqlParameter("@MKTechnologyAsk", SqlDbType.NVarChar) { Value = string.IsNullOrEmpty(entity.MKTechnologyAsk) ? "" : entity.MKTechnologyAsk},
                new SqlParameter("@MKLand", SqlDbType.NVarChar) { Value = string.IsNullOrEmpty(entity.MKLand) ? "0" : entity.MKLand},
                new SqlParameter("@EquNoodles",SqlDbType.NVarChar){ Value = entity.EquNoodles},
                new SqlParameter("@Attribute",SqlDbType.VarChar){ Value = entity.Attribute},

                new SqlParameter("@WarehouseLocationId",SqlDbType.Int){ Value = entity.WarehouseLocationId},
                new SqlParameter("@ComponentId",SqlDbType.Int){ Value = entity.ComponentId},
                new SqlParameter("@Price",SqlDbType.Decimal){ Value = entity.Price},
                new SqlParameter("@Consignee",SqlDbType.VarChar){ Value = entity.Consignee},
                new SqlParameter("@CompanyCode",SqlDbType.NVarChar){ Value =  entity.CompanyCode},
                new SqlParameter("@CustomName",SqlDbType.NVarChar){ Value = entity.CustomName},
                new SqlParameter("@Model",SqlDbType.NVarChar){ Value = entity.Model},
                new SqlParameter("@MachineTonnage",SqlDbType.NVarChar){ Value = entity.MachineTonnage},
                new SqlParameter("@MoldTonnage",SqlDbType.NVarChar){ Value = entity.MoldTonnage},
                new SqlParameter("@Size",SqlDbType.NVarChar){ Value = entity.Size},
                new SqlParameter("@Matrix",SqlDbType.NVarChar){ Value = entity.Matrix},
                new SqlParameter("@Cavity",SqlDbType.Int){ Value = entity.Cavity},
                new SqlParameter("@ModleTimes",SqlDbType.NVarChar){ Value = entity.MoldTimes},
                new SqlParameter("@FactoryMouldCode", SqlDbType.VarChar){ Value = entity.FactoryMouldCode},
                new SqlParameter("@FactoryMouldName", SqlDbType.NVarChar){ Value = entity.FactoryMouldName}
                };

                //parms[0].Value = entity.EquipmentId;
                //parms[0].Direction = ParameterDirection.InputOutput;
                //parms[1].Value = entity.EquipmentCode;
                //parms[2].Value = entity.EquipmentName;
                //parms[3].Value = entity.EquipmentTypeId;
                //parms[4].Value = entity.EquipmentModel;
                //parms[5].Value = entity.SupplierCode;
                //parms[6].Value = entity.Status;
                //parms[7].Value = entity.LineId;
                //parms[8].Value = entity.StationId;
                //parms[9].Value = entity.FactoryDate.ToString("yyyy-MM-dd hh:mm:ss") == "0001-01-01 12:00:00" ?
                //    "9999-12-31 00:00:00" : entity.FactoryDate.ToString("yyyy-MM-dd hh:mm:ss");
                //parms[10].Value = entity.CreateBy;
                //parms[11].Value = entity.ModifyBy;
                //parms[12].Value = entity.Remark;
                //parms[13].Value = entity.VenCode;
                //parms[14].Value = entity.Position;
                //parms[15].Value = entity.VendorBarcode;
                //parms[16].Value = entity.Thick;
                //parms[17].Value = entity.WarningCount;
                //parms[18].Value = entity.UseCount;
                //parms[19].Value = entity.StandarLive;
                //parms[20].Value = entity.CurPosition;
                //parms[21].Value = entity.InOrOut;
                //parms[22].Value = entity.IsClear;
                //parms[23].Value = entity.SequenceNo;


                //parms[24].Value = entity.Purchase;
                //parms[25].Value = entity.UnitName;
                //parms[26].Value = entity.CareDepNo;
                //parms[27].Value = entity.CareBy;
                //parms[28].Value = entity.PictureName;
                //parms[29].Value = entity.ProduceDate.ToString("yyyy-MM-dd hh:mm:ss") == "0001-01-01 12:00:00" ?
                //    "9999-12-31 00:00:00" : entity.ProduceDate.ToString("yyyy-MM-dd hh:mm:ss");
                //parms[30].Value = entity.GuaranteeDay;
                //parms[31].Value = entity.OverGuaranteeTime.ToString("yyyy-MM-dd hh:mm:ss") == "0001-01-01 12:00:00" ?
                //    "9999-12-31 00:00:00" : entity.OverGuaranteeTime.ToString("yyyy-MM-dd hh:mm:ss");
                //parms[32].Value = string.IsNullOrEmpty(entity.AssetNumber) ? "" : entity.AssetNumber;
                //parms[33].Value = string.IsNullOrEmpty(entity.PCBModel) ? "" : entity.PCBModel;
                //parms[34].Value = string.IsNullOrEmpty(entity.MKUsingTechnology) ? "" : entity.MKUsingTechnology;
                //parms[35].Value = string.IsNullOrEmpty(entity.MKUsingType) ? "" : entity.MKUsingType;
                //parms[36].Value = string.IsNullOrEmpty(entity.MKTechnologyAsk) ? "" : entity.MKTechnologyAsk;
                //parms[37].Value = string.IsNullOrEmpty(entity.MKLand) ? "0" : entity.MKLand;
                //parms[38].Value = entity.EquNoodles;
                //parms[39].Value = entity.Attribute;



                //parms[40].Value = entity.WarehouseLocationId;
                //parms[41].Value = entity.ComponentId;
                //parms[42].Value = entity.Price;
                //parms[43].Value = entity.Consignee;
                //parms[44].Value = entity.CompanyCode;

                //parms[45].Value = entity.FactoryMouldCode;
                //parms[46].Value = entity.FactoryMouldName;


                SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_Equipment_EditNew", parms);

                EquipmentId = Convert.ToInt32(parms[0].Value);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return EquipmentId;
        }

        /// <summary>
        /// 根据 EquipmentId 字符串删除 Equipment 信息。
        /// </summary>
        /// <param name="idString">EquipmentId 字符串。</param>
        /// <returns></returns>
        public void Delete(String idString, String userName)
        {
            try
            {
                SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
                };

                parms[0].Value = idString;
                parms[1].Value = userName;

                SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_Equipment_Delete", parms);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        /// <summary>
        /// 通过设备编号获取产线名和工位名
        /// </summary>
        /// <param name="EquiCode"></param>
        /// <returns></returns>
        public String[] GetLineAndStation(String EquiCode)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@EquiCode", SqlDbType.VarChar, 20)
            };
            parms[0].Value = EquiCode;
            String[] returnValue = new String[2];

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_GetLineStationByEquiID", parms))
            {
                if (rdr.Read())
                {
                    returnValue[0] = rdr.GetValue(0).ToString();
                    returnValue[1] = rdr.GetValue(1).ToString();
                }
                rdr.Close();
            }

            return returnValue;
        }

        /// <summary>
        /// 根据 EquipmentId 获取实体信息。
        /// </summary>
        /// <param name="eQUIPMENTId">EquipmentId。</param>
        /// <returns>Equipment 实体对象。</returns>
        public EquipmentsInfo GetInfo(string equipmentId, bool isById = true)
        {
            EquipmentsInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = equipmentId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_Equipment_GetInfo", parms))
            {

                if (rdr.Read())
                {
                    entity = new EquipmentsInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4), rdr.GetDateTime(5),
                        rdr.GetString(6), rdr.GetString(7), rdr.GetString(8), rdr.GetDateTime(9), rdr.GetString(10), rdr.GetDateTime(11), rdr.GetString(12),
                        rdr.GetDateTime(13), rdr.GetString(14), rdr.GetString(15), rdr.GetString(16), rdr.GetString(17), rdr.GetString(18), rdr.GetDecimal(19),
                        rdr.GetInt32(20), rdr.GetInt32(21), rdr.GetInt32(22), rdr.GetString(23), rdr.GetInt32(24), rdr.GetInt32(25), rdr.GetString(26), rdr.GetInt32(27),
                        rdr.GetInt32(28), rdr.GetInt32(29));

                    entity.ParentTypeId = rdr.GetInt32(30);
                    entity.Status = rdr.GetInt32(31);
                    entity.SequenceNo = rdr.GetInt32(32);

                    entity.Purchase = rdr.GetInt32(33);
                    entity.UnitName = rdr.GetString(34);
                    entity.DepartName = rdr.GetString(35);
                    entity.CareBy = rdr.GetString(36);

                    entity.PictureName = rdr.GetString(37);
                    entity.CareBy = rdr.GetString(38);
                    entity.CareDepNo = rdr.GetString(39);
                    entity.PositionName = rdr.GetString(40);

                    entity.SupplierCode = rdr.GetString(41);  //新增 20171018 zx
                    entity.SupplierName = rdr.GetString(42);
                    entity.GuaranteeDay = rdr.GetInt32(43);
                    entity.OverGuaranteeTime = rdr.GetDateTime(44);
                    entity.AssetNumber = rdr.GetString(45);
                    entity.MKSpec = rdr.GetString(46);
                    entity.MKQTY = rdr.GetString(47);
                    entity.MKUsingTechnology = rdr.GetString(48);
                    entity.MKUsingType = rdr.GetString(49);
                    entity.MKTechnologyAsk = rdr.GetString(50);
                    entity.MKLand = rdr.GetString(51);
                    entity.PCBModel = rdr.GetString(52);
                    entity.EquNoodles = rdr.GetString(53);
                    entity.Attribute = rdr.GetString(54);
                    entity.ComponentId = Convert.ToInt32(rdr["ComponentId"]);
                    entity.ComponentName = Convert.ToString(rdr["ComponentName"]);
                    entity.Company = Convert.ToString(rdr["Company"]);
                    entity.CompanyName = Convert.ToString(rdr["CompanyName"]);
                    entity.cBarCode = Convert.ToString(rdr["cBarCode"]);
                    entity.Price = Convert.ToDecimal(rdr["Price"]);
                    entity.Consignee = Convert.ToString(rdr["Consignee"]);
                    entity.WarehouseLocationId = Convert.ToInt32(rdr["WarehouseLocationId"]);
                    entity.DeliveryTime = Convert.ToDateTime(rdr["DeliveryTime"]);
                    entity.StoreName = Convert.ToString(rdr["StoreName"]);
                    entity.MouldBomId = Convert.ToInt32(rdr["MouldBomId"]);

                    entity.EquipmentOwner = Convert.ToString(rdr["EquipmentOwner"]);
                    entity.ProjectName = Convert.ToString(rdr["ProjectName"]);
                    entity.WorkshopSection = Convert.ToString(rdr["WorkshopSection"]);
                    entity.EquipmentCategory = Convert.ToString(rdr["EquipmentCategory"]);
                    entity.IsFixedAssets = Convert.ToInt32(rdr["IsFixedAssets"]);
                    entity.MaxOnlineTime = Convert.ToDecimal(rdr["MaxOnlineTime"]);
                    entity.Value01 = Convert.ToString(rdr["Value01"]);
                    entity.Value02 = Convert.ToString(rdr["Value02"]);
                    entity.Value03 = Convert.ToString(rdr["Value03"]);
                    entity.Value04 = Convert.ToString(rdr["Value04"]);

                    entity.Customerseries = Convert.ToString(rdr["Customerseries"]);
                    entity.CustomerCode = Convert.ToString(rdr["CustomerCode"]);
                    entity.ProductType = Convert.ToString(rdr["ProductType"]);

                    entity.MouldType = Convert.ToString(rdr["MouldType"]);


                    entity.Waterinlet = Convert.ToDecimal(rdr["Waterinlet"]);
                    entity.BOAItem = Convert.ToString(rdr["BOAItem"]);
                    entity.ReplaceINSERT = Convert.ToBoolean(rdr["ReplaceINSERT"]);
                    entity.Waterremoval = Convert.ToBoolean(rdr["Waterremoval"]);
                    entity.Irrigationtype = Convert.ToString(rdr["Irrigationtype"]);
                    entity.Rawmaterial = Convert.ToString(rdr["Rawmaterial"]);
                    entity.Productweight = Convert.ToDecimal(rdr["Productweight"]);
                    entity.Waterweight = Convert.ToDecimal(rdr["Waterweight"]);
                    entity.Productallweight = Convert.ToDecimal(rdr["Productallweight"]);
                    entity.Cycle = Convert.ToDecimal(rdr["Cycle"]);
                    entity.Singleweight = Convert.ToDecimal(rdr["Singleweight"]);
                    entity.Priority = Convert.ToInt32(rdr["Priority"]);

                    entity.Tonnage = Convert.ToDecimal(rdr["Tonnage"]);

                    entity.BU = Convert.ToString(rdr["BU"]);
                    entity.ModuleProductQty = Convert.ToDecimal(rdr["ModuleProductQty"]);
                    entity.Capacity = Convert.ToDecimal(rdr["Capacity"]);
                    entity.IsMachinedInjection = Convert.ToInt32(rdr["IsMachinedInjection"]);
                    entity.IsBOA = Convert.ToBoolean(rdr["IsBOA"]);
                    entity.Area = rdr["Area"].ToString();

                    entity.CustomName = rdr["CustomName"].ToString();
                    entity.Model = rdr["Model"].ToString();
                    entity.MachineTonnage = rdr["MachineTonnage"].ToString();
                    entity.MoldTonnage = Convert.ToString(rdr["MoldTonnage"]);
                    entity.Size = rdr["Size"].ToString();
                    entity.Cavity = Convert.ToInt32(rdr["Cavity"]);
                    entity.Matrix = rdr["Matrix"].ToString();
                    entity.MoldTimes = rdr["MoldTimes"].ToString();

                    entity.EquipmentIP = rdr["EquipmentIP"].ToString();
                    entity.EquipmentPort = rdr["EquipmentPort"].ToString();

                    entity.FactoryMouldCode = rdr["FactoryMouldCode"].ToString();
                    entity.FactoryMouldName = rdr["FactoryMouldName"].ToString();
                }
                rdr.Close();
            }

            return entity;
        }


        /// <summary>
        /// 根据 EquipmentId 获取实体信息。
        /// </summary>
        /// <param name="eQUIPMENTId">EquipmentId。</param>
        /// <returns>Equipment 实体对象。</returns>
        public EquipmentsInfo GetViewInfo(Int32 equipmentId)
        {
            EquipmentsInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = equipmentId;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_Equipment_GetInfo", parms))
            {

                if (rdr.Read())
                {
                    entity = new EquipmentsInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4), rdr.GetDateTime(5),
                        rdr.GetString(6), rdr.GetString(7), rdr.GetString(8), rdr.GetDateTime(9), rdr.GetString(10), rdr.GetDateTime(11), rdr.GetString(12),
                        rdr.GetDateTime(13), rdr.GetString(14), rdr.GetString(15), rdr.GetString(16), rdr.GetString(17), rdr.GetString(18), rdr.GetDecimal(19),
                        rdr.GetInt32(20), rdr.GetInt32(21), rdr.GetInt32(22), rdr.GetString(23), rdr.GetInt32(24), rdr.GetInt32(25), rdr.GetString(26), rdr.GetInt32(27),
                        rdr.GetInt32(28), rdr.GetInt32(29));

                    entity.ParentTypeId = rdr.GetInt32(30);
                    entity.Status = rdr.GetInt32(31);
                    entity.SequenceNo = rdr.GetInt32(32);

                    entity.Purchase = rdr.GetInt32(33);
                    entity.UnitName = rdr.GetString(34);
                    entity.DepartName = rdr.GetString(35);
                    entity.CareBy = rdr.GetString(36);

                    entity.PictureName = rdr.GetString(37);
                    entity.CareBy = rdr.GetString(38);
                    entity.CareDepNo = rdr.GetString(39);
                    entity.PositionName = rdr.GetString(40);

                    entity.SupplierCode = rdr.GetString(41);
                    entity.SupplierName = rdr.GetString(42);
                    entity.GuaranteeDay = rdr.GetInt32(43);
                    entity.OverGuaranteeTime = rdr.GetDateTime(44);
                    entity.AssetNumber = rdr.GetString(45);

                    entity.MKSpec = rdr.GetString(46);
                    entity.MKQTY = rdr.GetString(47);
                    entity.MKUsingTechnology = rdr.GetString(48);
                    entity.MKUsingType = rdr.GetString(49);
                    entity.MKTechnologyAsk = rdr.GetString(50);
                    entity.MKLand = rdr.GetString(51);
                    entity.PCBModel = rdr.GetString(52);
                    entity.EquNoodles = rdr.GetString(53);
                    entity.Attribute = rdr.GetString(54);
                    entity.ComponentId = Convert.ToInt32(rdr["ComponentId"]);
                    entity.ComponentName = Convert.ToString(rdr["ComponentName"]);
                    entity.Company = Convert.ToString(rdr["Company"]);
                    entity.CompanyName = Convert.ToString(rdr["CompanyName"]);
                    entity.cBarCode = Convert.ToString(rdr["cBarCode"]);
                    entity.Price = Convert.ToDecimal(rdr["Price"]);
                    entity.Consignee = Convert.ToString(rdr["Consignee"]);
                    entity.WarehouseLocationId = Convert.ToInt32(rdr["WarehouseLocationId"]);
                    entity.DeliveryTime = Convert.ToDateTime(rdr["DeliveryTime"]);
                }
                rdr.Close();
            }

            return entity;
        }


        /// <summary>
        /// 分页获取 Equipment 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="eQUIPMENTCount">Equipment 总数。</param>
        /// <returns>Equipment 列表。</returns>
        public List<EquipmentsInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<EquipmentsInfo> list = new List<EquipmentsInfo>();
            EquipmentsInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows,
                "vwEquipment", "EquipmentId", @"EquipmentId, [EquipmentCode], [EquipmentName], [EquipmentTypeName], [EquipmentModel], 
             [ProduceDate],   Status, [LineName], [Station] , [FactoryDate], [CreateBy], [CreateDateTime], [ModifyBy],[ModifyDateTime], [Remark], VenCode,ParentTypeName, Position, VendorBarcode, Thick, WarningCount,UseCount, StandarLive, CurPosition, InOrOut, IsClear,VendorName, [EquipmentTypeId], [LineId], [StationId],EquipmentStatus,SequenceNo,SupplierCode,SupplierName,PositionName,GuaranteeDay,OverGuaranteeTime,AssetNumber,MKSpec , MKQTY, MKUsingTechnology, MKUsingType, MKTechnologyAsk, MKLand,PCBModel,StoreName,CompanyName,ComponentName,Value01,Value02,Value03,Value04,Cavity,BU,ModuleProductQty,Tonnage,Customerseries,Cycle,DepartName,CareBy,FactoryMouldCode,FactoryMouldName,EquimentExtNo,PEId,ItemCodes,ItemNames", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new EquipmentsInfo(rdr.GetInt32(0), rdr[1] == DBNull.Value ? "" : rdr.GetString(1),
                        rdr[2] == DBNull.Value ? "" : rdr.GetString(2),
                        rdr[3] == DBNull.Value ? "" : rdr.GetString(3),
                        rdr[4] == DBNull.Value ? "" : rdr.GetString(4), rdr.GetDateTime(5),
                        rdr[6] == DBNull.Value ? "" : rdr.GetString(6),
                        rdr[7] == DBNull.Value ? "" : rdr.GetString(7),
                        rdr[8] == DBNull.Value ? "" : rdr.GetString(8), rdr.GetDateTime(9),
                        rdr[10] == DBNull.Value ? "" : rdr.GetString(10), rdr.GetDateTime(11),
                        rdr[12] == DBNull.Value ? "" : rdr.GetString(12),
                        rdr.GetDateTime(13),
                        rdr[14] == DBNull.Value ? "" : rdr.GetString(14),
                        rdr[15] == DBNull.Value ? "" : rdr.GetString(15),
                        rdr[16] == DBNull.Value ? "" : rdr.GetString(16),
                        rdr[17] == DBNull.Value ? "" : rdr.GetString(17),
                        rdr[18] == DBNull.Value ? "" : rdr.GetString(18), rdr.GetDecimal(19),
                        rdr.GetInt32(20), rdr.GetInt32(21), rdr.GetInt32(22),
                        rdr[23] == DBNull.Value ? "" : rdr.GetString(23), rdr.GetInt32(24), rdr.GetInt32(25),
                        rdr[26] == DBNull.Value ? "" : rdr.GetString(26), rdr.GetInt32(27),
                        rdr.GetInt32(28), rdr.GetInt32(29));


                    entity.Status = rdr.GetInt32(30);
                    entity.SequenceNo = rdr.GetInt32(31);
                    entity.SupplierCode = rdr[32] == DBNull.Value ? "" : rdr.GetString(32);
                    entity.SupplierName = rdr[33] == DBNull.Value ? "" : rdr.GetString(33);
                    entity.PositionName = rdr[34] == DBNull.Value ? "" : rdr.GetString(34);
                    entity.GuaranteeDay = rdr.GetInt32(35);
                    entity.OverGuaranteeTime = rdr.GetDateTime(36);
                    entity.AssetNumber = rdr[37] == DBNull.Value ? "" : rdr.GetString(37);
                    entity.MKSpec = rdr[38] == DBNull.Value ? "" : rdr.GetString(38);
                    entity.MKQTY = rdr[39] == DBNull.Value ? "" : rdr.GetString(39);
                    entity.MKUsingTechnology = rdr[40] == DBNull.Value ? "" : rdr.GetString(40);
                    entity.MKUsingType = rdr[41] == DBNull.Value ? "" : rdr.GetString(41);
                    entity.MKTechnologyAsk = rdr[42] == DBNull.Value ? "" : rdr.GetString(42);
                    entity.MKLand = rdr[43] == DBNull.Value ? "" : rdr.GetString(43);
                    entity.PCBModel = rdr[44] == DBNull.Value ? "" : rdr.GetString(44);

                    entity.ComponentName = Convert.ToString(rdr["ComponentName"]);
                    entity.CompanyName = Convert.ToString(rdr["CompanyName"]);
                    entity.StoreName = Convert.ToString(rdr["StoreName"]);
                    entity.Value01 = Convert.ToString(rdr["Value01"]);
                    entity.Value02 = Convert.ToString(rdr["Value02"]);
                    entity.Value03 = Convert.ToString(rdr["Value03"]);
                    entity.Value04 = Convert.ToString(rdr["Value04"]);

                    entity.Cavity = Convert.ToInt32(rdr["Cavity"]);
                    entity.BU = Convert.ToString(rdr["BU"]);
                    entity.ModuleProductQty = Convert.ToDecimal(rdr["ModuleProductQty"]);
                    entity.Tonnage = Convert.ToDecimal(rdr["Tonnage"]);
                    entity.Cycle = Convert.ToDecimal(rdr["Cycle"]);
                    entity.Customerseries = Convert.ToString(rdr["Customerseries"]);
                    entity.DepartName = Convert.ToString(rdr["DepartName"]);
                    entity.CareBy = Convert.ToString(rdr["CareBy"]);
                    entity.FactoryMouldCode = Convert.ToString(rdr["FactoryMouldCode"]);
                    entity.FactoryMouldName = Convert.ToString(rdr["FactoryMouldName"]);
                    entity.EquimentExtNo = Convert.ToString(rdr["EquimentExtNo"]);
                    entity.PEId= Convert.ToInt32(rdr["PEId"]);
                    entity.ItemCodes = Convert.ToString(rdr["ItemCodes"]);
                    entity.ItemNames = Convert.ToString(rdr["ItemNames"]);
                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }




        /// <summary>
        /// 分页获取 Equipment 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="eQUIPMENTCount">Equipment 总数。</param>
        /// <returns>Equipment 列表。</returns>
        public List<CollectionEquiConfigInfo> GetCollectionEquiConfigList(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {

            List<CollectionEquiConfigInfo> list = new List<CollectionEquiConfigInfo>();
            //表名或者视图
            string strTb = "vwCollectionEngelDataHistory";
            //主键
            string strKey = "HisDataId";
            //查询栏位字串
            string strColumns =@"HisDataId,CollectionDate,CollectionTime,EquipmentType,EquipmentCode,Status,ShotCounter,PerformanceTest,ProcessFormulaName,InjectionForce,MoldProtectionTime, ActualProtectionTime,CycleTimeSetValue,MaximumCycleTime,PreviousCycleTime,CoolingTime,ActualBasketballTimeValue,ActualValueOfMoldClosingTime,RotationPositionMoldRotationCycleTime,ConfirmCycleInsertTime,ConfirmTheRemovalOfPositionCycleTime, DryCycleTime,ClosingTime,ShutdownTimeBeforeRestartingProduction,UnlockTime,MoldOpeningTime,LockingForceAndUnloadingTime,ConstructionTimeOfLockingForce,MoldOpeningCycleTime, LockTime, NeutronMotionTime, MoldPauseTime, UntilTheCompletionTimeOfDemolding, TopOutTime,NozzleAdvanceCycleTime,ActualValueOfCleaningTime,PressureHoldingCycleTime, PressureHoldingCycleTimeSettingValue,MoldNumber, MachineNumber, AutomatedProductionOfFirstPiece,TotalProductionQuantity,ActualValueOfProductCounter,Temperature,InternalCavityPressureDuringPressureConversion,ReasonForShutdown,OrderNo,MouldCode,MoldCavity";
            list = ComMethod.GetComList<CollectionEquiConfigInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            return list;

//            List<CollectionEquiConfigInfo> list = new List<CollectionEquiConfigInfo>();
//            CollectionEquiConfigInfo entity = null;

//            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows,
//                "vwCollectionEngelDataHistory",
//                "HisDataId", @"HisDataId, 
//      CollectionDate,
//	    CollectionTime,
//		EquipmentType,
//	    EquipmentCode,
//	    Status,
//	    ShotCounter,
//		PerformanceTest,
//	    ProcessFormulaName,
//	    InjectionForce,
//	    MoldProtectionTime,
//	    ActualProtectionTime,
//	    CycleTimeSetValue,
//	    MaximumCycleTime,
//	    PreviousCycleTime,
//	    CoolingTime,
//	    ActualBasketballTimeValue,
//	    ActualValueOfMoldClosingTime,
//	    RotationPositionMoldRotationCycleTime,
//	    ConfirmCycleInsertTime,
//	    ConfirmTheRemovalOfPositionCycleTime,
//	    DryCycleTime,
//	    ClosingTime,
//	    ShutdownTimeBeforeRestartingProduction,
//	    UnlockTime,
//	    MoldOpeningTime,
//	    LockingForceAndUnloadingTime,
//	    ConstructionTimeOfLockingForce,
//	    MoldOpeningCycleTime,
//	    LockTime,
//	    NeutronMotionTime,
//	    MoldPauseTime,
//	    UntilTheCompletionTimeOfDemolding,
//	    TopOutTime,
//	    NozzleAdvanceCycleTime,
//	    ActualValueOfCleaningTime,
//	    PressureHoldingCycleTime,
//	    PressureHoldingCycleTimeSettingValue,
//	    MoldNumber,
//	    MachineNumber,
//	    AutomatedProductionOfFirstPiece,
//	    TotalProductionQuantity,
//	    ActualValueOfProductCounter,
//	    Temperature,
//	    InternalCavityPressureDuringPressureConversion,
//	    ReasonForShutdown
//", searchSettings, sortExpression);

//            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
//            {
//                while (rdr.Read())
//                {
//                    entity = new CollectionEquiConfigInfo();

//                    entity.HisDataId = Convert.ToInt32(rdr["HisDataId"]);
//                    entity.CollectionDate = Convert.ToString(rdr["CollectionDate"]);
//                    entity.CollectionTime = Convert.ToString(rdr["CollectionTime"]);
//                    entity.EquipmentType = Convert.ToString(rdr["EquipmentType"]);
//                    entity.EquipmentCode = Convert.ToString(rdr["EquipmentCode"]);
//                    entity.Status = Convert.ToString(rdr["Status"]);
//                    entity.ShotCounter = Convert.ToString(rdr["ShotCounter"]);
//                    entity.PerformanceTest = Convert.ToString(rdr["PerformanceTest"]);
//                    entity.ProcessFormulaName = Convert.ToString(rdr["ProcessFormulaName"]);
//                    entity.InjectionForce = Convert.ToString(rdr["InjectionForce"]);
//                    entity.MoldProtectionTime = Convert.ToString(rdr["MoldProtectionTime"]);
//                    entity.ActualProtectionTime = Convert.ToString(rdr["ActualProtectionTime"]);
//                    entity.CycleTimeSetValue = Convert.ToString(rdr["CycleTimeSetValue"]);
//                    entity.MaximumCycleTime = Convert.ToString(rdr["MaximumCycleTime"]);
//                    entity.PreviousCycleTime = Convert.ToString(rdr["PreviousCycleTime"]);
//                    entity.CoolingTime = Convert.ToString(rdr["CoolingTime"]);
//                    entity.ActualBasketballTimeValue = Convert.ToString(rdr["ActualBasketballTimeValue"]);
//                    entity.ActualValueOfMoldClosingTime = Convert.ToString(rdr["ActualValueOfMoldClosingTime"]);
//                    entity.RotationPositionMoldRotationCycleTime = Convert.ToString(rdr["RotationPositionMoldRotationCycleTime"]);
//                    entity.ConfirmCycleInsertTime = Convert.ToString(rdr["ConfirmCycleInsertTime"]);
//                    entity.ConfirmTheRemovalOfPositionCycleTime = Convert.ToString(rdr["ConfirmTheRemovalOfPositionCycleTime"]);
//                    entity.DryCycleTime = Convert.ToString(rdr["DryCycleTime"]);
//                    entity.ClosingTime = Convert.ToString(rdr["ClosingTime"]);
//                    entity.ShutdownTimeBeforeRestartingProduction = Convert.ToString(rdr["ShutdownTimeBeforeRestartingProduction"]);
//                    entity.UnlockTime = Convert.ToString(rdr["UnlockTime"]);
//                    entity.MoldOpeningTime = Convert.ToString(rdr["MoldOpeningTime"]);
//                    entity.LockingForceAndUnloadingTime = Convert.ToString(rdr["LockingForceAndUnloadingTime"]);
//                    entity.ConstructionTimeOfLockingForce = Convert.ToString(rdr["ConstructionTimeOfLockingForce"]);
//                    entity.MoldOpeningCycleTime = Convert.ToString(rdr["MoldOpeningCycleTime"]);
//                    entity.LockTime = Convert.ToString(rdr["LockTime"]);
//                    entity.NeutronMotionTime = Convert.ToString(rdr["NeutronMotionTime"]);
//                    entity.MoldPauseTime = Convert.ToString(rdr["MoldPauseTime"]);
//                    entity.UntilTheCompletionTimeOfDemolding = Convert.ToString(rdr["UntilTheCompletionTimeOfDemolding"]);
//                    entity.TopOutTime = Convert.ToString(rdr["TopOutTime"]);
//                    entity.NozzleAdvanceCycleTime = Convert.ToString(rdr["NozzleAdvanceCycleTime"]);
//                    entity.ActualValueOfCleaningTime = Convert.ToString(rdr["ActualValueOfCleaningTime"]);
//                    entity.PressureHoldingCycleTime = Convert.ToString(rdr["PressureHoldingCycleTime"]);
//                    entity.PressureHoldingCycleTimeSettingValue = Convert.ToString(rdr["PressureHoldingCycleTimeSettingValue"]);
//                    entity.MoldNumber = Convert.ToString(rdr["MoldNumber"]);
//                    entity.MachineNumber = Convert.ToString(rdr["MachineNumber"]);
//                    entity.AutomatedProductionOfFirstPiece = Convert.ToString(rdr["AutomatedProductionOfFirstPiece"]);
//                    entity.TotalProductionQuantity = Convert.ToString(rdr["TotalProductionQuantity"]);
//                    entity.ActualValueOfProductCounter = Convert.ToString(rdr["ActualValueOfProductCounter"]);
//                    entity.Temperature = Convert.ToString(rdr["Temperature"]);
//                    entity.InternalCavityPressureDuringPressureConversion = Convert.ToString(rdr["InternalCavityPressureDuringPressureConversion"]);
//                    entity.ReasonForShutdown = Convert.ToString(rdr["ReasonForShutdown"]);



//                    list.Add(entity);
//                }
//                rdr.Close();
//            }

//            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
//            return list;
        }


        /// <summary>
        /// 分页获取 Equipment 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="eQUIPMENTCount">Equipment 总数。</param>
        /// <returns>Equipment 列表。</returns>
        public List<EquipmentsInfo> GetAllNew(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<EquipmentsInfo> list = new List<EquipmentsInfo>();
            EquipmentsInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows,
                "vwEquipmentNew", "EquipmentId", @"EquipmentId, [EquipmentCode], [EquipmentName], [EquipmentTypeName], [EquipmentModel], 
         [ProduceDate],   Status, [LineName], [Station] , [FactoryDate], [CreateBy], [CreateDateTime], [ModifyBy],
          [ModifyDateTime], [Remark], VenCode, ParentTypeName, Position, VendorBarcode, Thick, WarningCount,
		 UseCount, StandarLive, CurPosition, InOrOut, IsClear,VendorName, [EquipmentTypeId], [LineId], [StationId],EquipmentStatus,SequenceNo,SupplierCode,SupplierName,PositionName,GuaranteeDay,OverGuaranteeTime,AssetNumber,MKSpec , MKQTY, MKUsingTechnology, MKUsingType, MKTechnologyAsk, MKLand,PCBModel
        ,[InspectionStatus]
      ,[InspectionStatusName]
      ,[InspectionUserName]
      ,[InspectionDateTime]
      ,[StartInspectionDateTime],[EquNoodles],[UsableCount],ParentTypeId,EquimentExtNo", searchSettings, sortExpression);



            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new EquipmentsInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4), rdr.GetDateTime(5),
                        rdr.GetString(6), rdr.GetString(7), rdr.GetString(8), rdr.GetDateTime(9), rdr.GetString(10), rdr.GetDateTime(11), rdr.GetString(12),
                        rdr.GetDateTime(13), rdr.GetString(14), rdr.GetString(15), rdr.GetString(16), rdr.GetString(17), rdr.GetString(18), rdr.GetDecimal(19),
                        rdr.GetInt32(20), rdr.GetInt32(21), rdr.GetInt32(22), rdr.GetString(23), rdr.GetInt32(24), rdr.GetInt32(25), rdr.GetString(26), rdr.GetInt32(27),
                        rdr.GetInt32(28), rdr.GetInt32(29));
                    entity.Status = rdr.GetInt32(30);
                    entity.SequenceNo = rdr.GetInt32(31);
                    entity.SupplierCode = rdr.GetString(32);
                    entity.SupplierName = rdr.GetString(33);
                    entity.PositionName = rdr.GetString(34);
                    entity.GuaranteeDay = rdr.GetInt32(35);
                    entity.OverGuaranteeTime = rdr.GetDateTime(36);
                    entity.AssetNumber = rdr.GetString(37);
                    entity.MKSpec = rdr.GetString(38);
                    entity.MKQTY = rdr.GetString(39);
                    entity.MKUsingTechnology = rdr.GetString(40);
                    entity.MKUsingType = rdr.GetString(41);
                    entity.MKTechnologyAsk = rdr.GetString(42);
                    entity.MKLand = rdr.GetString(43);
                    entity.PCBModel = rdr.GetString(44);
                    entity.InspectionStatus = rdr.GetInt32(45);
                    entity.InspectionStatusName = rdr.GetString(46);
                    entity.InspectionUserName = rdr.GetString(47);
                    entity.InspectionDateTime = rdr.GetDateTime(48);
                    entity.StartInspectionDateTime = rdr.GetDateTime(49);
                    entity.EquNoodles = rdr.GetString(50);
                    entity.UsableCount = rdr.GetInt32(51);
                    entity.ParentTypeId = rdr.GetInt32(52);
                   
                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }


        /// <summary>
        /// 设备列表导出EXCEL获取数据的方法
        /// </summary>
        /// <param name="strWhere">查询条件</param>
        /// <returns></returns>
        public DataTable ImportToExcel(String code, String name, int status)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@steelCode", SqlDbType.NVarChar,50),
                new SqlParameter("@steelName", SqlDbType.NVarChar,50),
                new SqlParameter("@steelStatus", SqlDbType.Int,4)
            };
            parms[0].Value = code;
            parms[1].Value = name;
            parms[2].Value = status;
            return SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "uspEquipmentImportEXCEL", parms);
        }
        /// <summary>
        /// 模具列表导出Excel
        /// </summary>
        /// <param name="code"></param>
        /// <param name="name"></param>
        /// <param name="status"></param>
        /// <returns></returns>
        public DataTable ImportToExcelEx(String code, String name,string fcode,string fname,string compname, int status,int peid)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@steelCode", SqlDbType.NVarChar,50),
                new SqlParameter("@steelName", SqlDbType.NVarChar,50),
                new SqlParameter("@ComponentName", SqlDbType.NVarChar,50),
                new SqlParameter("@FactoryMouldCode", SqlDbType.NVarChar,50),
                new SqlParameter("@FactoryMouldName", SqlDbType.NVarChar,50),
                new SqlParameter("@steelStatus", SqlDbType.Int,4),
                 new SqlParameter("@PEId", SqlDbType.Int,4)
            };
            parms[0].Value = code;
            parms[1].Value = name;
            parms[2].Value = compname;
            parms[3].Value = fcode;
            parms[4].Value = fname;
            parms[5].Value = status;
            parms[6].Value = peid;
            return SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "uspEquipmentImportEXCELEx", parms);
        }
        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

        /// <summary>
        /// 钢网刮刀入库
        /// </summary>
        /// <param name="equipmentId"></param>
        /// <returns></returns>
        public bool EquiepmentInStock(int equipmentId, string userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@equipmentId", SqlDbType.Int),
                new SqlParameter("@UserName",SqlDbType.NVarChar,20)
            };
            parms[0].Value = equipmentId;
            parms[1].Value = userName;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspEquipmentInStock", parms);
            return true;
        }
        /// <summary>
        /// 钢网刮刀入库
        /// </summary>
        /// <param name="equipmentId"></param>
        /// <returns></returns>
        public bool EquiepmentInStockNew(int equipmentId, string userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@equipmentId", SqlDbType.Int),
                new SqlParameter("@UserName",SqlDbType.NVarChar,20)
            };
            parms[0].Value = equipmentId;
            parms[1].Value = userName;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspEquipmentInStockNew", parms);
            return true;
        }

        /// <summary>
        /// 钢网刮刀出库
        /// </summary>
        /// <param name="equipmentId"></param>
        /// <returns></returns>
        public bool EquiepmentOutStock(int equipmentId, string userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@equipmentId", SqlDbType.Int),
                new SqlParameter("@UserName",SqlDbType.NVarChar,20)
            };
            parms[0].Value = equipmentId;
            parms[1].Value = userName;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspEquipmentOutStock", parms);
            return true;
        }
        /// <summary>
        /// 钢网刮刀出库
        /// </summary>
        /// <param name="equipmentId"></param>
        /// <returns></returns>
        public bool EquiepmentOutStockNew(int equipmentId, string userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@equipmentId", SqlDbType.Int),
                new SqlParameter("@UserName",SqlDbType.NVarChar,20)
            };
            parms[0].Value = equipmentId;
            parms[1].Value = userName;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspEquipmentOutStockNew", parms);
            return true;
        }

        public string Search()
        {
            //表名或者视图
            //string strTb = "vwPoCpInStock";
            string strTb = "vwEquipmentEarlyWarning";
            SearchSettings search = new SearchSettings();
            string list = ComMethod.GetTbViewList(strTb, search);

            return list;
        }

        /// <summary>
        /// 模具报废
        /// </summary>
        /// <param name="entity">模具报废实体</param>
        /// <returns></returns>
        public void MouldScrap(MouldScrapRecordInfo entity)
        {
            try
            {
                SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@MouldId", SqlDbType.Int, 4),
                    new SqlParameter("@EquipmentId", SqlDbType.Int, 4),
                    new SqlParameter("@ScrapType", SqlDbType.VarChar, 30),
                    new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                    new SqlParameter("@Remark", SqlDbType.VarChar, 1000),
                    new SqlParameter("@DepartmentId", SqlDbType.Int),
                    new SqlParameter("@PersonInCharge", SqlDbType.NVarChar)
                };

                parms[0].Value = entity.MouldId;
                parms[1].Value = entity.EquipmentId;
                parms[2].Value = entity.ScrapType;
                parms[3].Value = entity.CreateBy;
                parms[4].Value = entity.Remark;
                parms[5].Value = entity.DepartmentId;
                parms[6].Value = entity.PersonInCharge;

                SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspScrapMould", parms);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        /// <summary>
        /// 更新交付日期
        /// </summary>
        /// <param name="time"></param>
        /// <param name="id"></param>
        public void MouldSupplierDeliveryTime(int mouldId, string deliveryTime, decimal maintenanceCosts)
        {

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@MouldId", SqlDbType.Int),
                new SqlParameter("@DeliveryTime", SqlDbType.NVarChar),
                new SqlParameter("@MaintenanceCosts", SqlDbType.Decimal),

            };
            parms[0].Value = mouldId;
            parms[1].Value = deliveryTime;
            parms[2].Value = maintenanceCosts;

            ComMethod.Edit("uspCollectMouldSupplierInfo", parms);
        }

        /// <summary>
        /// 更新模具是否在库
        /// </summary>
        /// <param name="mouldIdArr"></param>
        /// <param name="isStock">1=入库  </param>
        /// outStockType 出库类型 :产线  供应商
        /// <returns></returns>
        public void UpdateStock(string mouldIdArr, int isStock, string createBy, int WarehouseLocationId, string outStockType, int SupplierId)
        {

            try
            {
                SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@EquipmentIdArr", SqlDbType.VarChar),
                    new SqlParameter("@InOrOut",SqlDbType.Int),
                    new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                    new SqlParameter("@WarehouseLocationId",SqlDbType.Int,4),
                    new SqlParameter("@OutStockType", SqlDbType.VarChar, 20),
                    new SqlParameter("@SupplierId",SqlDbType.Int,4),
                };

                parms[0].Value = mouldIdArr;
                parms[1].Value = isStock;
                parms[2].Value = createBy;
                parms[3].Value = WarehouseLocationId;
                parms[4].Value = outStockType;
                parms[5].Value = SupplierId;

                SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "usp_MouldOutorInStock", parms);
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }


        /// <summary>
        /// 根据模具ID数组获取历史库位列表信息
        /// </summary>
        /// <param name="mouldArr"></param>
        /// <returns></returns>
        public List<string> GetMouldHistoryOutStockRecord(string mouldArr)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@MouldArr", SqlDbType.VarChar, 500)
            };
            parms[0].Value = mouldArr;
            List<string> list = new List<string>();

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "usp_GetMouldHistoryOutStockRecord", parms))
            {
                while (rdr.Read())
                {
                    list.Add(rdr.GetValue(0).ToString());

                }
                rdr.Close();
            }

            return list;
        }

        public DataTable GetMachineUser(string OrderID, string MachineID, int UserId, string UserName)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@OrderID",SqlDbType.Int),
                new SqlParameter("@MachineID",SqlDbType.Int),
                new SqlParameter("@UserId",SqlDbType.Int),
                new SqlParameter("@UserName",SqlDbType.NVarChar,200)
            };

            parms[0].Value = OrderID;
            parms[1].Value = MachineID;
            parms[2].Value = UserId;
            parms[3].Value = UserName;

            return SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "uspGetMachineUser", parms);
        }

        /// <summary>
        /// 获取手动录入的工艺参数数据
        /// </summary>
        /// <returns></returns>
        public DataTable GetTechnologyParam(string LinePlanCode)
        {
            SqlParameter[] array = new SqlParameter[1] {
               new SqlParameter("@LinePlanCode",SqlDbType.NVarChar,200){Value=LinePlanCode }
            };
            return SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "Prod_TechnologyParam_GetInfo", array);
        }

        /// <summary>
        /// 获取注塑控制台工艺参数数据
        /// </summary>
        /// <returns></returns>
        public DataTable GetOpcPointData(string LinePlanCode)
        {
            SqlParameter[] array = new SqlParameter[1] {
               new SqlParameter("@LinePlanCode",SqlDbType.NVarChar,50){Value=LinePlanCode }
            };

            return SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "Prod_OpcPointData_GetInfo", array);
        }


        /// <summary>
        /// 获取工艺参数数据
        /// </summary>
        /// <param name="data"></param>
        public void SaveTechnologyParam(string data)
        {
            SqlParameter[] array = new SqlParameter[1] {
               new SqlParameter("@TechnologyParamSave",SqlDbType.Structured)
            };
            array[0].Value = ComMethod.ToDataTable(data);
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspTechnologyParamSave", array);
        }


        /// <summary>
        /// 校验导入的数据
        /// </summary>
        /// <param name="dt"></param>
        public List<EquipmentsMoudleInfo> CheckImportEquipmentsMoudle(DataTable dt)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@EquipmentMoudle",SqlDbType.Structured){ Value = dt}
            };
            return ComMethod.GetList<EquipmentsMoudleInfo>("uspCheckImportEquipmentMoudle", parms);
        }

    }
}