using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using AjaxPro;
using SKT.Common.Organization.BLL;
using SKT.Common.Organization.Model;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxOrganization
    {
        /// <summary>
        /// 编辑部门
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [AjaxMethod]
        public Int32 OrganizationEdit(OrganizationInfo entity)
        {
            int organizationId = -1;
            try
            {
                organizationId = (new Common.Organization.BLL.Organization()).Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }

            return organizationId;
        }

        [AjaxMethod]
        public List<OrganizationInfo> GetAll()
        {
            List<OrganizationInfo> list = null;
            try
            {
                list = (new SKT.Common.Organization.BLL.Organization()).GetOrganizationTree(0, -1, "", null);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        [AjaxMethod]
        public void Delete(string idString)
        {
            try
            {
                (new SKT.Common.Organization.BLL.Organization()).Delete(idString, AccountController.GetCurrentUser().UserName);
                
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        [AjaxMethod]
        public List<SKT.Common.Account.Model.MembershipInfo> GetUserByOrganizationId(int organizationId)
        {
            List<SKT.Common.Account.Model.MembershipInfo> list = null;
            try
            {
                Common.Model.SearchSettings searchSettings = new Common.Model.SearchSettings();
                //searchSettings.AddCondition("DepartId", organizationId.ToString());
                searchSettings.ExtensionCondition += " 1=1 ";
                searchSettings.ExtensionCondition += " and DepartId=" + organizationId.ToString();
               // list = (new SKT.Common.Organization.BLL.Organization()).GetUserByOrganizationId(0, -1, "", searchSettings);
                list = (new SKT.Common.Account.BLL.Users()).GetUserByOrganizationId(0, -1, "", searchSettings);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }

            return list;
        }
        [AjaxMethod]
        public void EditDataDistribution(int ID, string DeapartCode, string DepartName, string MesUrl,string DataBaseName,string DBLinkName,Boolean ckIsEnabled)
        {
            SKT.LeanMES.DBservice.BLL.DbService bll = new DBservice.BLL.DbService();
            Dictionary<string, object> Params = new Dictionary<string, object>();
            Params["ID"] = ID;
            Params["DepartCode"] = DeapartCode;
            Params["DepartName"] = DepartName;
            Params["MesUrl"] = MesUrl;
            Params["DataBaseName"] = DataBaseName;
            Params["DBLinkName"] = DBLinkName;
            Params["UserName"] = AccountController.GetCurrentUser().UserName;
            Params["CkIsEnabled"] = ckIsEnabled;
            bll.ExecSpc("uspDataDistributionEdit", Newtonsoft.Json.JsonConvert.SerializeObject(Params));
        }
    }
}