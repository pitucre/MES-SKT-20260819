using System;
using System.Collections.Generic;
using System.Web;
using SKT.LeanMES.SerialNumber.BLL;
using SKT.LeanMES.SerialNumber.Model;
using AjaxPro;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxDictionary
    {
        [AjaxMethod]
        public List<DictionaryInfo> GetAQLLotAuditList()
        {
            return new Dictionary().GetAllByProperty(" DicProperty = 'AQLLotAudit' ");
          
        }
    }
}