using System;
using System.Collections.Generic;
using AjaxPro;
using SKT.LeanMES.Quality.BLL;
using SKT.LeanMES.Quality.Model;

namespace SKT.LeanMES.Web.Quality
{
    public partial class RMAReciveManage : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(SKT.LeanMES.Web.Quality.RMAReciveManage));

            string RMAID = Request.QueryString["ID"];
            //GetNCCode();
            if (!string.IsNullOrEmpty(RMAID))
            {
                PageData = (new Rma()).GetInfo(Convert.ToInt32(RMAID));
            }

        }

        //public void GetNCCode()
        //{
        //    SKT.LeanMES.NCCode.BLL.NCCode code = new LeanMES.NCCode.BLL.NCCode();
        //    List<SKT.LeanMES.NCCode.Model.NCCodeInfo> codeList = code.GetAll(0, -1, "", (new Common.Model.SearchSettings()));
        //    codeList.Insert(0, new LeanMES.NCCode.Model.NCCodeInfo() { NCCodeId = -1, NCCode = "请选择" });
        //    ddlFailCode.DataSource = codeList;
        //    ddlFailCode.DataTextField = "NCCode";
        //    ddlFailCode.DataValueField = "NCCodeId";
        //    ddlFailCode.DataBind();
        //}

        public RmaInfo PageData
        {
            set
            {
                this.lblRMANo.InnerText = value.RmaNo;
                this.lblCustomerName.InnerText = value.CustomerName;
                this.lblItemName.InnerText = value.MachineTypeName;
                this.lblItemCode.InnerText = value.ItemCode;
                this.lblItemSpec.InnerText = value.ItemSpec;
                this.lblNumber.InnerText = value.Number.ToString();
                this.lblGoodNum.InnerText = value.GoodNum.ToString();
                this.lblFailNum.InnerText = value.FailNum.ToString();
                this.lblScrapNum.InnerText = value.ScrapNum.ToString();
            }
        }

        [AjaxMethod]
        public void AddReciveData(RMAUnitInfo entity)
        {
            try
            {
                entity.CreateBy = AccountController.GetCurrentUser().UserName;
                entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                (new RMAUnit()).Edit(entity);
            }
            catch(Exception ex)
            {
                WebHelper.HandleException(ex);
            }            
        }

        [AjaxMethod]
        public void DeleteReciveData(int RMAUnitID)
        {
            (new RMAUnit()).Delete(RMAUnitID, AccountController.GetCurrentUser().UserName);
        }
    }
}