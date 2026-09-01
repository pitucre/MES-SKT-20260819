using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Web.Script.Serialization;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.Material.Model;
using SKT.LeanMES.CommonHelper.BLL;
using System.Collections;

namespace SKT.LeanMES.Material.BLL
{
    public class ProdMaterialTower
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 保存设备
        /// </summary>
        /// <param name="ItemStr"></param>
        /// <param name="Grn"></param>
        /// <returns></returns>
        public void EditMeterialTower(MeterialTower entity)
        {
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@ID",SqlDbType.Int),
                  new SqlParameter("@EquipmentCode",SqlDbType.NVarChar,30),
                  new SqlParameter("@EquipmentName",SqlDbType.NVarChar,30),
                  new SqlParameter("@WareHourseCode",SqlDbType.NVarChar,30),
                  new SqlParameter("@WareHourseName",SqlDbType.NVarChar,50),
                  new SqlParameter("@IP",SqlDbType.NVarChar,50),
                  new SqlParameter("@ApiKey",SqlDbType.NVarChar,50),
                  new SqlParameter("@CreateBy",SqlDbType.NVarChar,20),
                  new SqlParameter("@ModifyBy",SqlDbType.NVarChar,20)
            };
            parms[0].Value = entity.ID;
            parms[1].Value = entity.EquipmentCode;
            parms[2].Value = entity.EquipmentName;
            parms[3].Value = entity.WareHourseCode;
            parms[4].Value = entity.WareHourseName;
            parms[5].Value = entity.IP;
            parms[6].Value = entity.ApiKey;
            parms[7].Value = entity.CreateBy;
            parms[8].Value = entity.ModifyBy;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_MeterialTower_Edit", parms);
        }

        /// <summary>
        /// 通过料塔编码获取物料id
        /// </summary>
        /// <param name="materialNo"></param>
        /// <returns></returns>
        public Int32 GetMaterialId(string materialNo)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@MaterialNo",SqlDbType.NVarChar),
                new SqlParameter("@ID",SqlDbType.Int)
            };

            parms[0].Value = materialNo;
            parms[1].Direction = ParameterDirection.Output;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspGetMaterialIdByMaterialNo", parms);
            return Convert.ToInt32(parms[1].Value);
        }


        /// <summary>
        /// 根据 MaterialNO 获取实体信息。
        /// </summary>
        /// <param name="materialId">materialNO。</param>
        /// <returns>Material 实体对象。</returns>
        public MaterialInfo GetInfo(string materialNO)
        {
            MaterialInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@MaterialNO", SqlDbType.NVarChar, 50)
            };

            parms[0].Value = materialNO;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_Material_GetInfoByMaterialNO", parms))
            {
                if (rdr.Read())
                {
                    entity = new MaterialInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetInt32(5), rdr.GetString(6), rdr.GetDateTime(7), rdr.GetString(8), rdr.GetString(9),
                        rdr.GetDateTime(10), rdr.GetString(11), rdr.GetString(12), rdr.GetString(13), rdr.GetString(14),
                        rdr.GetString(15), rdr.GetString(16), rdr.GetString(17), rdr.GetString(18));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 PartNo 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="partNoCount">partNo 总数。</param>
        /// <returns>PartNo 列表。</returns>
        public List<ERPPartNoInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ERPPartNoInfo> list = new List<ERPPartNoInfo>();
            ERPPartNoInfo entity = null;

            //Add By Alen 2015-08-11 增加Site的过滤，如果site为空则获取全部数据，否则根据site过滤
            string site = System.Configuration.ConfigurationManager.AppSettings["Site"];
            if (!String.IsNullOrEmpty(site))
            {
                searchSettings.ExtensionCondition += String.IsNullOrEmpty(searchSettings.ExtensionCondition) ? " [Site] = '" + site + "' " : " and [Site] = '" + site + "' ";
            }

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "ERP_Item", "ErpItemId",
                " ErpItemId, Site, ItemCode, ItemName, ItemModel, StatusNo, Status, CreateDateTime, CreateBy, ModifyDateTime, ModifyBy, LastUpdateTime, Remark", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new ERPPartNoInfo();
                    entity.ErpItemId = rdr.GetInt32(0);
                    entity.Site = rdr.GetString(1);
                    entity.ItemCode = rdr.GetString(2);
                    entity.ItemName = rdr.GetString(3);
                    entity.ItemModel = rdr.GetString(4);


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