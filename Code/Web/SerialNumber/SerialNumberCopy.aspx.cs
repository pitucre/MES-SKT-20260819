using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.SerialNumber.BLL;
using SKT.LeanMES.SerialNumber.Model;
using AjaxPro;

namespace SKT.LeanMES.Web.SerialNumber
{
    public partial class SerialNumberCopy : BasePage
    {
        public int ruleType = 0;
        public string typeName = "";
        public string source = "0";
        public int NextID = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxSerialNumber));
            string strNextID = Request.QueryString["ID"];
            txtNumberSeq.Text = "";
            txtNumberSeq.Enabled = false;
            txtBase.Text = "10";
            NextID = Convert.ToInt32(strNextID);
            if (!IsPostBack)
            {
                BindNextNumberType();
                BindReset();
            }
            if (NextID > -1)
            {
                if (!IsPostBack)
                {
                    SKT.LeanMES.SerialNumber.BLL.SerialNumber bllHeader = new LeanMES.SerialNumber.BLL.SerialNumber();
                    SKT.LeanMES.SerialNumber.Model.SerialNumberInfo model = new SerialNumberInfo();
                    model = bllHeader.GetInfo(NextID);
                    this.NextNumber = model;
                }
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
            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            this.ddlNumberType.DataSource = new SerialNumberType().GetAll(0, 100, "SerialNumberTypeId", searchSettings);
            this.ddlNumberType.DataTextField = "SerialNumberType";
            this.ddlNumberType.DataValueField = "SerialNumberTypeId";
            this.ddlNumberType.DataBind();
            this.ddlNumberType.Items.Insert(0, new ListItem(Resources.lang.Choose, ""));
        }


        public void BindReset()
        {
            this.ddlReset.DataSource = new SKT.LeanMES.SerialNumber.BLL.ResetWay().GetAll(0, -1, "", new Common.Model.SearchSettings());
            this.ddlReset.DataTextField = "ResetWay";
            this.ddlReset.DataValueField = "ResetWayId";
            this.ddlReset.DataBind();
        }

        /// <summary>
        /// 编辑状态下获得对应的数据
        /// </summary>
        protected SKT.LeanMES.SerialNumber.Model.SerialNumberInfo NextNumber
        {
            set
            {
                ddlObjectType.SelectedValue = value.Apply_Type;
                txtValue.Text = value.Type_Value;
                txtVer.Text = value.Revision;
                txtPrefix.Text = value.Prefix;
                txtSuffix.Text = value.Suffix;
                txtSample.Text = value.SampleSerialNumber;
                txtDesc.Text = value.Description;
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
                    this.chkDefault.Checked = false;
                    txtBase.Text = value.Sequence_Base.ToString();
                }
                else
                {
                    chkDefault.Checked = true;
                    txtBase.Text = "";
                    txtBase.Enabled = false;
                    txtNumberSeq.Enabled = true;
                    txtNumberSeq.Text = value.Number_Sequence;
                    strDefaultDigitSet = value.Number_Sequence;
                }
                txtLength.Text = value.Sequence_Length.ToString();
                txtMax.Text = sampleSFC.formatInBase(value.Max_Seq, strDefaultDigitSet);
                txtMin.Text = sampleSFC.formatInBase(value.Min_Sequence, strDefaultDigitSet);
                txtIncrement.Text = sampleSFC.formatInBase(value.IncrementBy, strDefaultDigitSet);
                txtCurrent.Text = sampleSFC.formatInBase(value.Current_Sequence, strDefaultDigitSet);
                txtWarning.Text = sampleSFC.formatInBase(value.Warning, strDefaultDigitSet);
                if (ddlReset.Items.FindByValue(value.Reset) != null)
                {
                    ddlReset.SelectedValue = value.Reset;
                }
            }
        }
    }
}