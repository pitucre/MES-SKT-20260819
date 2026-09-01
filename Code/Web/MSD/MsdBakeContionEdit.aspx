<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="MsdBakeContionEdit.aspx.cs" Inherits="SKT.LeanMES.Web.MSD.MsdBakeContionEdit" %>

<%@ Import Namespace="Resources" %>
<%@ Import Namespace="SKT.LeanMES.Web" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %>
    </div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label1">MSD等级<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtMsl" runat="server" CssClass="TextBox" Enabled="false" ClientIDMode="Static" Width="64%">
                </asp:TextBox><input type="button" id="btnSelectItem" runat="server" class="ButtonBox" value="..."
                    title="Select" onclick="openChoosePage(604);" /><em>*</em>
                <asp:HiddenField ID="hdnItemId" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
        </tr>
         <tr>
            <td class="Label1">
              封装厚度(mm)<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtHoursNumber" runat="server" ClientIDMode="Static" IsRequired="1"
                    CssClass="TextBox" MaxLength="30"></asp:TextBox>
            </td>
        </tr>
         <tr>
            <td class="Label1">
                暴露时长(h)<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtOverrunExposureTime" runat="server" ClientIDMode="Static" IsRequired="1"
                    CssClass="TextBox" MaxLength="30"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">
              烘烤时长(h)<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtHoursNumber2" runat="server" ClientIDMode="Static" IsRequired="1"
                    CssClass="TextBox" MaxLength="30"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">烘烤上限温度(℃)<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtTemperature2" runat="server" ClientIDMode="Static" IsRequired="1"
                    CssClass="TextBox" MaxLength="30"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">烘烤下限温度(℃)<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtTemperature" runat="server" ClientIDMode="Static" IsRequired="1"
                    CssClass="TextBox" MaxLength="30"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">备注
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtRemark" runat="server" TextMode="MultiLine" CssClass="TextArea"
                    ClientIDMode="Static" MaxLength="100"></asp:TextBox>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        var msdContainerId = '<%=Request.QueryString["ID"]%>';

        $().ready(function () {

        });


        function openChoosePage(flags) {
            var condition = "";
            dialog({
                title: "<%= Common.ChooseWindow %>",
                src: "<%= WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=" +
                    flags +
                    "&Multiple=false&SearchCondition=" +
                    condition +
                    "&rnd=" +
                    Math.random(),
                width: 600,
                height: 300

            });
        }

        function getChooseValue(list) {

            $("#txtMsl").val(list[0][1]);


            //自动绑定当前版本产品BOM
        }

        /*保存数据*/
        function Save() {
            var hdnItemId = $("#<%=this.hdnItemId.ClientID%>").val();

            var txtMsl = $.trim($("#<%=this.txtMsl.ClientID%>").val());
            var txtTemperature = $.trim($("#<%=this.txtTemperature.ClientID%>").val());
            var txtTemperature2 = $.trim($("#<%=this.txtTemperature2.ClientID%>").val());
            var txtHoursNumber = $("#<%=this.txtHoursNumber.ClientID%>").val();
            var txtRemark = $.trim($("#<%=this.txtRemark.ClientID%>").val());
            //增加字段txtOverrunExposureTime和txtHoursNumber2 by lizhi 20180605
            var txtOverrunExposureTime =$("#<%=this.txtOverrunExposureTime.ClientID%>").val(); 
            var txtHoursNumber2 = $("#<%=this.txtHoursNumber2.ClientID%>").val();

            /*表单验证*/
            /*如需表单验证可以此处处理验证 开始*/

            var entity = {};
            entity.Bid = hdnItemId;
            entity.Msl = txtMsl;
            entity.HoursNum = txtHoursNumber;
            entity.Temperature = parseInt(txtTemperature);
            entity.TemperatureTwo = parseInt(txtTemperature2);
            entity.Remark = txtRemark;
            entity.HoursNum2 = parseInt(txtHoursNumber2);
            entity.OverrunExposureTime = txtOverrunExposureTime;

            var ajax = SKT.LeanMES.Web.MSD.MsdBakeContionEdit.Edit(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert('<%=Resources.Messages.SaveInSuccess%>')
            parent.window.UpdateList();

        }
    </script>
</asp:Content>
