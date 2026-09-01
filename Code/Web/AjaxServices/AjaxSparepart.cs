using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using AjaxPro;
using SKT.LeanMES.Sparepart.BLL;
using SKT.LeanMES.Sparepart.Model;
using System.Data.SqlClient;
using SKT.Common.DAL.Marshal;
using System.Text;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxSparepart
    {
        /// <summary>
        /// 添加或编辑备件清单
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void EditPart(SKT.LeanMES.Sparepart.Model.SparepartInfo entity) 
        {
            try
            {
                SKT.LeanMES.Sparepart.BLL.Sparepart sparepart = new SKT.LeanMES.Sparepart.BLL.Sparepart();
                if (entity.PartId == -1)//add new one record
                {
                    entity.CreateBy = AccountController.GetCurrentUser().UserName;
                    entity.ModifyBy = "";
                  
                }
                else// update selected record
                {
                    entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                    entity.CreateBy = "";
                   
                }
                sparepart.Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        /// <summary>
        /// 添加或编辑备件清单
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void CopyEditPart(SKT.LeanMES.Sparepart.Model.SparepartInfo entity, int oldID)
        {
            try
            {
                SKT.LeanMES.Sparepart.BLL.Sparepart sparepart = new SKT.LeanMES.Sparepart.BLL.Sparepart();
                if (entity.PartId == -1)//add new one record
                {
                    entity.CreateBy = AccountController.GetCurrentUser().UserName;
                    entity.ModifyBy = "";

                }
                else// update selected record
                {
                    entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                    entity.CreateBy = "";

                }
                sparepart.CopyEdit(entity, oldID);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        /// <summary>
        /// 添加出、入库信息
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void EditPartHistory(SKT.LeanMES.Sparepart.Model.PartsHistoryInfo entity)
        {
            try
            {
                SKT.LeanMES.Sparepart.BLL.PartsHistory history = new SKT.LeanMES.Sparepart.BLL.PartsHistory();
                entity.ModifyBy = "";
                history.Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        /// <summary>
        /// 添加出、入库信息
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void EditPartScrap(SKT.LeanMES.Sparepart.Model.SparepartInfo entity)
        {
            try
            {
                SKT.LeanMES.Sparepart.BLL.Sparepart history = new SKT.LeanMES.Sparepart.BLL.Sparepart();
                entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                history.EditPartScrap(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        /// <summary>
        /// 根据 PartsId 获取实体信息。
        /// </summary>
        /// <param name="partsId">PartsId。</param>
        /// <returns>Parts 实体对象。</returns>
        [AjaxMethod]
        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>Parts 实体对象。</returns>
        public SparepartInfo GetInfo(String fieldValue)
        {
            SparepartInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_Parts_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new SparepartInfo();
                    //entity.PartId = rdr.GetInt32(0); rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                    //    rdr.GetString(5), rdr.GetString(6), rdr.GetString(7), rdr.GetString(8), rdr.GetString(9),
                    //    rdr.GetDecimal(10), rdr.GetInt32(11), rdr.GetString(12), rdr.GetString(13), rdr.GetDateTime(14),
                    //    rdr.GetString(15), rdr.GetDateTime(16), rdr.GetString(17));
                    entity.PartId = Convert.ToInt32(rdr["PartId"]);
                    entity.PartName = Convert.ToString(rdr["PartName"]);
                    entity.PartNickName = Convert.ToString(rdr["PartNickName"]);

                    entity.PartNO = Convert.ToString(rdr["PartNO"]);
                    entity.PartCategory = Convert.ToString(rdr["PartCategory"]);
                    entity.PartMachine = Convert.ToString(rdr["PartMachine"]);
                    entity.PartLocation = Convert.ToString(rdr["PartLocation"]);

                    entity.PartBrand = Convert.ToString(rdr["PartBrand"]);
                    entity.PartStandard = Convert.ToString(rdr["PartStandard"]);
                    entity.PartParam = Convert.ToString(rdr["PartParam"]);

                    entity.PartQty = Convert.ToInt32(rdr["PartQty"]);
                    entity.PartSafeQty = Convert.ToInt32(rdr["PartSafeQty"]);
                    entity.PartUnit = Convert.ToString(rdr["PartUnit"]);

                    entity.CreateBy = Convert.ToString(rdr["CreateBy"]);
                    entity.CreateDateTime = Convert.ToDateTime(rdr["CreateDateTime"]);

                    entity.ModifyDateTime = Convert.ToDateTime(rdr["ModifyDateTime"]);
                    entity.Remark = Convert.ToString(rdr["Remark"]);
                    entity.VenName = Convert.ToString(rdr["VenName"]);
                    entity.SupplierName = Convert.ToString(rdr["SupplierName"]);  



                }
                rdr.Close();
            }

            return entity;
        }
         /// <summary>
         /// 添加预警信息
         /// </summary>
         /// <param name="entity"></param>
         [AjaxMethod]
         public void EditSetting(SKT.LeanMES.Sparepart.Model.PartsWarningSettingInfo entity)
         {
             try
             {
                 SKT.LeanMES.Sparepart.BLL.PartsWarningSetting setting = new SKT.LeanMES.Sparepart.BLL.PartsWarningSetting();

                 setting.Edit(entity);
             }
             catch (Exception ex)
             {
                 WebHelper.HandleException(ex);
             }
         }
        /// <summary>
        /// 获取预警信息
        /// </summary>
        /// <returns></returns>
        [AjaxMethod]
         public PartsWarningSettingInfo GetSetting()
         {
             PartsWarningSettingInfo setting = new PartsWarningSettingInfo();
             setting = new SKT.LeanMES.Sparepart.BLL.PartsWarningSetting().GetOneRecord();
             if (setting != null)
             {
                 return setting;
             }
             else
             {
                 return null;
             }
         }
        
    }
}