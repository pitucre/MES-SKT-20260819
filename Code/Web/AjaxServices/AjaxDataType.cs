using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.DataType.Model;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxDataType
    {
        /// <summary>
        /// 根据数据类型息更新或新增数据
        /// </summary>
        /// <param name="pageName"></param>
        /// <returns></returns>
        [AjaxMethod]
        public int EditDataType(DataTypeInfo entity,String action, Int32 oldRecordId)
        {
            try
            {
                SKT.LeanMES.DataType.BLL.DataType bllData = new SKT.LeanMES.DataType.BLL.DataType();
                return bllData.Edit(entity, action, oldRecordId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return 0;
            }
        }


        /// <summary>
        /// 根据数据字段信息更新或新增数据
        /// </summary>
        /// <param name="pageName"></param>
        /// <returns></returns>
        [AjaxMethod]
        public int EditDataField(DataFieldInfo entity)
        {
            try
            {
                SKT.LeanMES.DataType.BLL.DataField bllData = new SKT.LeanMES.DataType.BLL.DataField();
                if (entity.DataFieldId == -1) //add new one record
                {
                    entity.CreateBy = AccountController.GetCurrentUser().UserName;
                    entity.ModifyBy = "";
                }
                else // update selected record
                {
                    entity.CreateBy = "";
                    entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                }
                return bllData.Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return 0;
            }
        }
        /// <summary>
        /// 根据数据类型ID查询数据
        /// </summary>
        /// <param name="pageName"></param>
        /// <returns></returns>
        [AjaxMethod]
        public DataTypeInfo GetDataTypeByID(int intTID)
        {
            try
            {
                SKT.LeanMES.DataType.BLL.DataType bllData = new SKT.LeanMES.DataType.BLL.DataType();
                return bllData.GetInfo(intTID);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }

        /// <summary>
        ///通过ID得到Data Type Name
        /// </summary>
        /// <param name="intTID"></param>
        /// <returns></returns>
        [AjaxMethod]
        public String GetTypeNameByID(int intTID)
        {
            try
            {
                DataTypeInfo model;
                model = GetDataTypeByID(intTID);
                return model.DataTypeName;
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return "";
            }
        }
    }
}