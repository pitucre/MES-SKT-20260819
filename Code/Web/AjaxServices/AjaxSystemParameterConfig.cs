using AjaxPro;
using SKT.LeanMES.Lookup.BLL;
using SKT.LeanMES.Lookup.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxSystemParameterConfig
    {

        /// <summary>
        /// 根据 LookupDefId 获取实体信息。
        /// </summary>
        /// <param name="lookupDefId">LookupDefId。</param>
        /// <returns>LookupDef 实体对象。</returns>
        [AjaxMethod]
        public LookupDefInfo GetInfo(string tableName, bool isId)
        {
            try
            {
                LookupDef bll = new LookupDef();
                return bll.GetInfo(tableName, isId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }

        /// <summary>
        /// 根据条件查询Lookup表内容
        /// </summary>
        /// <param name="tableName">表名</param>
        /// <param name="conditionDic">条件</param>
        /// <returns></returns>
        [AjaxMethod]
        public List<LookupInfo> GetLookupByCondition(string tableName, Dictionary<string, object> conditionDic = null)
        {
            try
            {
                SKT.LeanMES.Lookup.BLL.Lookup bll = new SKT.LeanMES.Lookup.BLL.Lookup();
                return bll.GetLookupByCondition(tableName, conditionDic);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }

        /// <summary>
        /// 编辑Lookup记录
        /// </summary>
        /// <param name="tableName"></param>
        /// <param name="ids"></param>
        /// <param name="value"></param>
        /// <param name="userName"></param>
        [AjaxMethod]
        public void Edit(string tableName, string[] ids, string[] value, string userName)
        {
            try
            {
                SKT.LeanMES.Lookup.BLL.Lookup bll = new SKT.LeanMES.Lookup.BLL.Lookup();
                bll.Edit(tableName, ids, value, AccountController.GetCurrentUser().UserName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

    }

    public class EditInfo
    {
        public int MyProperty { get; set; }
    }
}