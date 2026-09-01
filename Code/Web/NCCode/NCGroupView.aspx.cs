using System;
using SKT.LeanMES.NCCode.BLL;
using SKT.LeanMES.NCCode.Model;
using System.Collections.Generic;
using System.Web.UI.WebControls;
namespace SKT.LeanMES.Web.NCCode
{
    public partial class NCGroupView : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxNCCode));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(NCGroupEdit));
            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];
                string[] Condition = new string[4];
                if (idString != null)
                {
                    NCGroupInfo NCGroup = (new NCGroup()).GetInfo(Convert.ToInt32(idString));
                    if (NCGroup != null)
                    {
                        this.PageData = NCGroup;
                        Condition[0] = "[NCCodeId] NOT IN (SELECT [NCCodeId] FROM [Basal_NCGroupMember] WHERE [NCGroupId] = '" + NCGroup.NCGroupId + "')";
                        Condition[1] = "[NCGroupId] = '" + NCGroup.NCGroupId + "'";
                        Condition[2] = "[StationId] NOT IN (SELECT [StationId] FROM [Basal_NCGroupStation] WHERE [NCGroupId] = '" + NCGroup.NCGroupId + "')";
                        Condition[3] = "[NCGroupId] = '" + NCGroup.NCGroupId + "'";
                    }
                    else
                    {
                        Condition[0] = "NCCodeId <>-1";
                        Condition[1] = "NCGroupMemberId =-1";
                        Condition[2] = "StationId <>-1";
                        Condition[3] = "NCGroupStationId = -1 ";
                    }
                    //BindGroup("NCCode", Condition[0], "NCCode", "NCCodeId");
                    BindGroup("NCGroupMember", Condition[1], "NCCode", "NCCodeId");
                    //BindGroup("Station", Condition[2], "Station", "StationId");
                    BindGroup("ValidOper", Condition[3], "StationName", "StationId");
                }
            }
        }
        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private NCGroupInfo PageData
        {
            set
            {
                this.lblNCGroupName.Text = value.NCGroupName;
                this.lblDescription.Text = value.Description;
                this.lblBindAllStation.Text = (value.IsAllOperations) ? (String)GetGlobalResourceObject("Common", "Yes") : (String)GetGlobalResourceObject("Common", "No");
                //this.CbIsall.Checked = value.IsAllOperations;
            }
        }

        public void BindGroup(string type, string Condition, string TextField, string ValueField)
        {
            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.ExtensionCondition = Condition;
            switch (type)
            {
                case "NCCode":
                    SKT.LeanMES.NCCode.BLL.NCCode code = new LeanMES.NCCode.BLL.NCCode();
                    List<NCCodeInfo> NCCodes = code.GetAll(0, -1, "NCCodeId", searchSettings);
                    //BindListBox(NCCodes, this.NCCodeList, TextField, ValueField);

                    break;
                case "NCGroupMember":
                    List<NCGroupMemberInfo> NCGroupMembers = (new NCGroupMember()).GetAll(0, -1, "NCGroupMemberId", searchSettings);
                    string shtml = "<table class='ListTable' width='100%'>";
                    shtml += "<tr class='ListTableHeader'>";
                    shtml += "<th>不良代码</th>";
                    shtml += "</tr>";
                    if (NCGroupMembers.Count == 0)
                    {
                        shtml += "<tr class='ListTableEmptyDataRow'><td colspan='2'>" + Resources.Messages.EmptyDataText + "</td></tr>";
                    }
                    for (int i = 0, j = NCGroupMembers.Count; i < j; i++)
                    {
                        if (i % 2 == 0)
                        {
                            shtml += "<tr class='ListTableOddRow'>";
                        }
                        else
                        {
                            shtml += "<tr class='ListTableEvenRow'>";
                        }
                        shtml += "<td>" + NCGroupMembers[i].NCCode + "</td>";
                    }
                    shtml += "</table>";
                    this.llNCCodeList.Text = shtml;
                    break;
                case "Station":
                    List<SKT.LeanMES.Station.Model.StationInfo> Stations = (new SKT.LeanMES.Station.BLL.Station()).GetAll(0, -1, "StationId", searchSettings);
                    //BindListBox(Stations, this.OperationList, TextField, ValueField);
                    
                    break;
                default:
                    List<NCGroupStationInfo> NCGroupStations = (new NCGroupStation()).GetAll(0, -1, "NCGroupStationId", searchSettings);
                    //BindListBox(NCGroupStations, this.assOperationsList, TextField, ValueField);
                    shtml = "<table class='ListTable' width='100%'>";
                    shtml += "<tr class='ListTableHeader'>";
                    shtml += "<th>工序名称</th>";
                    shtml += "</tr>";
                    if (NCGroupStations.Count == 0)
                    {
                        shtml += "<tr class='ListTableEmptyDataRow'><td colspan='2'>" + Resources.Messages.EmptyDataText + "</td></tr>";
                    }
                    for (int i = 0, j = NCGroupStations.Count; i < j; i++)
                    {
                        if (i % 2 == 0)
                        {
                            shtml += "<tr class='ListTableOddRow'>";
                        }
                        else
                        {
                            shtml += "<tr class='ListTableEvenRow'>";
                        }
                        shtml += "<td>" + NCGroupStations[i].StationName + "</td>";
                    }
                    shtml += "</table>";
                    this.llStationList.Text = shtml;
                    break;
            }
        }
        protected void BindListBox(Object obj, ListBox listBox, string textField, string valueField)
        {
            listBox.DataSource = obj;
            listBox.DataTextField = textField;
            listBox.DataValueField = valueField;
            listBox.DataBind();
        }
    }
}