<%@ Page Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="True"
    CodeBehind="MaintenanceDemoView.aspx.cs" Inherits="SKT.LeanMES.Web.Maintenance.MaintenanceDemoView"
    Title="View MaintenanceDemo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="Server">
    <table width="100%" class="ContentTable">
        <tr>
            <td class="Label2">
                <%= Resources.lang.MaintenanceDemoNO%>
            </td>
            <td class="Field2">
                <asp:Label ID="lblDemoCode" runat="server"></asp:Label>
            </td>
            <td class="Label2">
                <%= Resources.lang.MaintenanceDemoName%>
            </td>
            <td class="Field2">
                <asp:Label ID="lblDemoName" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.Description %>
            </td>
            <td class="Field2">
                <asp:Label ID="lblDescription" runat="server"></asp:Label>
            </td>
            <td class="Label2">
            </td>
            <td class="Field2">
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.Remark %>
            </td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtRemark" runat="server" CssClass="TextArea" TextMode="MultiLine"
                    MaxLength="50" Width="99%" Height="50"></asp:TextBox>
            </td>
        </tr>
    </table>
     <table class="ListTable" cellspacing="0" cellpadding="4" style="border-width: 0px;
        width: 100%; overflow: auto; border-collapse: collapse;" id="tbPackLevel">
        <tr class="ListTableHeader">
            <th scope="col" align="center" width="10%">
                作业编号
            </th>
            <th scope="col" align="center"  width="25%">
                作业名称
            </th>
            <th scope="col" align="center"  width="45%">
                作业说明
            </th>
        </tr>
    </table>
    <script type="text/javascript">
        function Edit() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Maintenance/MaintenanceDemoEdit.aspx?name=Maintenance_MaintenanceDemoEdit&ID=" + '<%= Request.QueryString["ID"] %>';
            location.href = openWinUrl;
        }

        var tab = document.getElementById("tbPackLevel");
        var Id = <%= Request.QueryString["ID"] == null ? -1 : Convert.ToInt32(Request.QueryString["ID"].ToString())%>;
        $(document).ready(function () {
            if (Id > 0) {
                GetDemoSubList(Id);
            }
        });
        function GetDemoSubList(demoId){
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaintenanceDemoSub.GetDemoSubList(demoId);
            if(ajax.error == null){
                var entityAry = ajax.value;
                for(var i=0; i < entityAry.length; i++){
                    addPackLevelDetail(entityAry[i]);
                }
            }
            else{
                alert(ajax.error.Message);
            }
        }
        /*添加行*/
        function addPackLevelDetail(entity) {
        
        if(entity == null){
            entity = {};
            entity.DemoSubId = -1;
            entity.DemoId =Id;
            entity.DemoSubCode = "";
            entity.DemoSubName = "";
            entity.Remark = "";
        }

        var row, cell,optionvalue,disabled;
        rowNewIdx = tab.rows.length;
        row = tab.insertRow(rowNewIdx);
        row.className = "ListTableOddRow";

        optionvalue=entity.PackingLevel;

        cell = row.insertCell(0);
        cell.align = "center";
        cell.innerHTML =entity.DemoSubCode;

        cell = row.insertCell(1);
        cell.align = "center";
        cell.innerHTML = entity.DemoSubName;

        cell = row.insertCell(2);
        cell.align = "center";
        cell.innerHTML=entity.Remark;

      }
    </script>
</asp:Content>
