using System;
using SKT.LeanMES.SerialNumber.BLL;
using SKT.LeanMES.SerialNumber.Model;
using System.Collections.Generic;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.SerialNumber
{
    public partial class SerialNumberView : BasePage
    {
        public int ruleType = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxSerialNumber));

            if (!IsPostBack)
            {
                BindNextNumberType();
                BindReset();
            }

            string strNextID = Request.QueryString["ID"];
            lblNumberSeq.Text = "";
            lblNumberSeq.Enabled = false;
            lblBase.Text = "10";
            int NextID = Convert.ToInt32(strNextID);
            if (NextID > -1)
            {
                SKT.LeanMES.SerialNumber.BLL.SerialNumber bllHeader = new LeanMES.SerialNumber.BLL.SerialNumber();
                SKT.LeanMES.SerialNumber.Model.SerialNumberInfo model = new SerialNumberInfo();
                model = bllHeader.GetInfo(NextID);
                this.NextNumber = model;
                SKT.LeanMES.SerialNumber.BLL.SerialNumberSeed bllDetail = new SerialNumberSeed();
                SKT.LeanMES.SerialNumber.Model.SerialNumberSeedInfo modelID = new SerialNumberSeedInfo();
                modelID = bllDetail.GetInfo(NextID);
                this.SequenceInfo = modelID;
            }
            
        }

        /// <summary>
        /// 绑定产生序列号事件
        /// </summary>
        protected void BindNextNumberType()
        {
            //this.ddlNumberType.DataSource = SKT.LeanMES.Web.Utility.EnumHelper.ParseEnumToList(typeof(SKT.LeanMES.SerialNumber.Model.EnumNextNumberType));
            //this.ddlNumberType.DataTextField = "text";
            //this.ddlNumberType.DataValueField = "value";
            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            this.ddlNumberType.DataSource = new SerialNumberType().GetAll(0, 100, "SerialNumberTypeId", searchSettings);
            this.ddlNumberType.DataTextField = "SerialNumberType";
            this.ddlNumberType.DataValueField = "SerialNumberTypeId";
            this.ddlNumberType.DataBind();
            this.ddlNumberType.Items.Insert(0, new ListItem(Resources.lang.Choose, "-1"));
        }


        public void BindReset()
        {
            this.ddlReset.DataSource = new SKT.LeanMES.SerialNumber.BLL.ResetWay().GetAll(0, -1, "", new Common.Model.SearchSettings());
            this.ddlReset.DataTextField = "ResetWay";
            this.ddlReset.DataValueField = "ResetWayId";
            this.ddlReset.DataBind();
        }

        /// <summary>
        /// 根据所选ddlNumberType类型 ddlItem跟着联动
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void ddlNumberType_SelectedIndexChanged(object sender, EventArgs e)
        {
            //ddlItem.Enabled = true;
            lblValue.Text = "";  //情况原有数据
            lblVer.Text = "";
            lblDesc.Text = "";
            //switch (ddlNumberType.SelectedItem.Text)
            //{
            //    case "Shop Order":
            //    case "IQC Number":
            //    case "OBA Batch":
            //    case "Material GRN":
            //        for (int i = 0; i < ddlItem.Items.Count; i++)
            //        {
            //            if (ddlItem.Items[i].Text == "Item")
            //            {
            //                ddlItem.SelectedIndex = i;
            //                ddlItem.Enabled = false;
            //                break;
            //            }
            //        }
            //        break;
            //    case "Container Number":
            //        for (int i = 0; i < ddlItem.Items.Count; i++)
            //        {
            //            if (ddlItem.Items[i].Text == "Container")
            //            {
            //                ddlItem.SelectedIndex = i;
            //                ddlItem.Enabled = false;
            //                break;
            //            }
            //        }
            //        break;
            //    default:
            //        break;
            //}

        }

        /// <summary>
        /// 根据所选ddlItem类型 ddlNumberType跟着联动
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        //protected void ddlItem_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //    lblValue.Text = "";//情况原有数据
        //    lblVer.Text = "";
        //    lblDesc.Text = "";
        //    switch (ddlItem.SelectedItem.Text)
        //    {
        //        case "Container":
        //            ddlItem.Enabled = false;
        //            for (int i = 0; i < ddlNumberType.Items.Count; i++)
        //            {
        //                if (ddlNumberType.Items[i].Text == "Container Number")
        //                {
        //                    ddlNumberType.SelectedIndex = i;
        //                    break;
        //                }
        //            }
        //            break;
        //        default:
        //            break;

        //    }
        //}

        /// <summary>
        /// 编辑状态下获得对应的数据
        /// </summary>
        protected SKT.LeanMES.SerialNumber.Model.SerialNumberInfo NextNumber
        {
            set
            {
                ddlNumberType.SelectedValue = value.Next_Number_Type;
                lblNumberType.Text = ddlNumberType.SelectedItem.Text;
                //for (int i = 0; i < ddlItem.Items.Count; i++)
                //{
                //    if (ddlItem.Items[i].Text == value.Apply_Type)
                //    {
                //        ddlItem.SelectedIndex = i;
                //        break;
                //    }
                //}
                lblValue.Text = value.Type_Value;
                lblVer.Text = value.Revision;
                lblPrefix.Text = value.Prefix;
                lblSuffix.Text = value.Suffix;
                lblSample.Text = value.SampleSerialNumber;
                lblDesc.Text = value.Description;
            }
        }

        /// <summary>
        /// 编辑状态下获得对应的数据
        /// </summary>
        protected SKT.LeanMES.SerialNumber.Model.SerialNumberSeedInfo SequenceInfo
        {
            set
            {
                string strDefaultDigitSet = "";
                SKT.LeanMES.SerialNumber.BLL.SerialNumber sampleSFC = new LeanMES.SerialNumber.BLL.SerialNumber(); ;
                if (value.Sequence_Base > 0)
                {
                    strDefaultDigitSet = sampleSFC.getDefaultDigitSet(value.Sequence_Base);
                    lblBase.Text = value.Sequence_Base.ToString();
                }
                else
                {
                    lblBase.Text = "";
                    lblBase.Enabled = false;
                    lblNumberSeq.Enabled = true;
                    lblNumberSeq.Text = value.Number_Sequence;
                    strDefaultDigitSet = value.Number_Sequence;
                }
                lblLength.Text = value.Sequence_Length.ToString();
                lblMax.Text = sampleSFC.formatInBase(value.Max_Seq, strDefaultDigitSet);
                lblMin.Text = sampleSFC.formatInBase(value.Min_Sequence, strDefaultDigitSet);
                lblIncrement.Text = sampleSFC.formatInBase(value.IncrementBy, strDefaultDigitSet);
                lblCurrent.Text = sampleSFC.formatInBase(value.Current_Sequence, strDefaultDigitSet);
                lblWarning.Text = sampleSFC.formatInBase(value.Warning, strDefaultDigitSet);
                ddlReset.SelectedValue = value.Reset;
                lblReset.Text = ddlReset.SelectedItem.Text;
            }
        }
    }
}