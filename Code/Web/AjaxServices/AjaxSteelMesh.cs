using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.SteelMesh.Model;
using System.Data;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxSteelMesh
    {
        //[AjaxMethod]
        //public void SteelMeshEdit(SteelMeshInfo entity,String enterFactory)
        //{
        //    try
        //    {
        //        SKT.LeanMES.SteelMesh.BLL.SteelMesh bll = new SKT.LeanMES.SteelMesh.BLL.SteelMesh();
        //        if (entity.SteelId == -1)
        //        {
        //            entity.CreateBy = AccountController.GetCurrentUser().UserName;
        //            entity.ModifyBy = "";
        //        }
        //        else
        //        {
        //            entity.ModifyBy = AccountController.GetCurrentUser().UserName;
        //            entity.CreateBy = "";
        //        }
        //        if (enterFactory == "")
        //        {
        //            enterFactory = "9999-12-31";
        //        }
        //        bll.Edit(entity, enterFactory);
        //    }
        //    catch (Exception ex)
        //    {
        //        WebHelper.HandleException(ex);
        //    }
        //}
    }
}