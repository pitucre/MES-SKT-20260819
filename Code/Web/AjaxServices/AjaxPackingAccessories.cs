using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.Container.Model;
using SKT.LeanMES.Container.BLL;
using System.Data;
using SKT.Common.DAL.Marshal;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxPackingAccessories
    {
        /// <summary>
        /// 附件配置编辑
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
         [AjaxMethod]
        public Int32 PackingAccessoriesConfigEdit(PackingAccessoriesConfigInfo entity)
        {
            int pacId = -1;
            try
            {
                pacId = new PackingAccessories().Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return pacId;
        }

        [AjaxMethod]
        public List<PackingAccessoriesConfigInfo> GetMaskIdALL()
        {
            List<PackingAccessoriesConfigInfo> list = new List<PackingAccessoriesConfigInfo>();
            try
            {
                string sql = string.Format("SELECT MaskId,MaskGroup FROM Basal_Mask_Group where MaskId<>-1 ");
                DataTable dt = SQLHelper.ExcuteDataTableSqlText(SQLHelper.MESConnString, sql, null);
                if (dt != null && dt.Rows.Count > 0)
                {
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        PackingAccessoriesConfigInfo entity = new PackingAccessoriesConfigInfo();
                        entity.MaskId = Convert.ToInt32(dt.Rows[i][0]);
                        entity.MaskGroup = dt.Rows[i][1].ToString();
                        list.Add(entity);
                    }
                }
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }
    }
}