using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using System.Configuration;
using SKT.Common.DAL.Marshal;
using System.IO;
using SKT.Common.Utility;
using SKT.LeanMES.CommonDataSource.BLL;
using SKT.LeanMES.CommonDataSource.Model;
using System.Data.SqlClient;
using System.Xml;
using System.Data;
using SKT.LeanMES.Language.Model;
using SKT.LeanMES.Web.AppCode.Utility;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxLanguage
    {
        /// <summary>
        /// 获取数据
        /// </summary>
        /// <param name=""></param>
        [AjaxMethod]
        public int Edit(LanguageInfo entity)
        {
            int id = -1;
            try
            {
                entity.CreateBy = AccountController.GetCurrentUser().UserName;
                entity.ModifyBy = entity.CreateBy;
                id = new Language.BLL.Language().Edit(entity);
                //重新加载资源包
                LanguageHelper.LoadLanguages(true);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return id;
        }
    }
}