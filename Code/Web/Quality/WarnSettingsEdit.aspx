<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="True"
    CodeBehind="WarnSettingsEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Quality.WarnSettingsEdit"
    Title="Edit WarnSettings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label2">
                产品<em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtItem" runat="server" CssClass="TextBox" Enabled="false" IsRequired='1'></asp:TextBox><input
                    type="button" id="btnSelectItem" class="ButtonBox" value="..." title="<%=Resources.lang.ChooseItem %>"
                    onclick="selectItem(1);" />
                <asp:HiddenField ID="hdnItemId" runat="server" Value="-1" />
            </td>
        </tr>
        <tr>
            <td class="Label2">
                线别<em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtLineName" runat="server" CssClass="TextBox" Enabled="false" ClientIDMode="Static"
                    IsRequired='1'></asp:TextBox>
                <input type="button" id="btnSelectDefaultOpt" class="ButtonBox" value="..." title="Select"
                    onclick="selectLine();" />
                <asp:HiddenField ID="hdnLineId" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
        </tr>
        <tr>
            <td class="Label2">
                操作工位<em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtStation" runat="server" CssClass="TextBox" Enabled="false" IsRequired='1'></asp:TextBox><input
                    type="button" id="Button1" class="ButtonBox" value="..." title="Select" onclick="selectItem(8);" />
                <asp:HiddenField ID="hdnStationId" runat="server" Value="-1" />
            </td>
        </tr>
        <tr>
            <td class="Label2">
                预警类型<em>*</em>
            </td>
            <td class="Field2">
                <asp:DropDownList ID="ddlWarnType" runat="server" ClientIDMode="Static" IsRequired='1'>
                    <asp:ListItem Value="1">班次</asp:ListItem>
                    <asp:ListItem Value="2">天</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                预警等级<em>*</em>
            </td>
            <td class="Field2">
                <asp:DropDownList ID="ddlWarnLevel" runat="server" ClientIDMode="Static" IsRequired='1'>
                    <asp:ListItem Value="1">1</asp:ListItem>
                    <asp:ListItem Value="2">2</asp:ListItem>
                    <asp:ListItem Value="3">3</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                良品率(%)<em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtYield" runat="server" CssClass="TextBox" IsRequired='1' IsNumber='1'
                    MinValue='1' MaxValue='100'></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                接收人<em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtReciveUsers" runat="server" CssClass="TextBox" Enabled="false"
                    ClientIDMode="Static" IsRequired='1'></asp:TextBox>
                <input type="button" id="Button2" class="ButtonBox" value="..." title="Select" onclick="selectRecive();" />
                <asp:HiddenField ID="hdnReciyeId" runat="server" Value="" ClientIDMode="Static" />
            </td>
        </tr>
        <tr>
            <td class="Label2">
                备注
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtContents" runat="server" CssClass="TextArea" MaxLength="500"
                    TextMode="MultiLine"></asp:TextBox>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        var warnSettingsId = '<%=Request.QueryString["ID"]%>';
        var chooseFlag = 0;
        var receiveId = "";
        var receiveIdVal = "";

        function selectItem(i) {
            chooseFlag = i;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=" + i.toString() + "&Multiple=false&rnd=" + Math.random(), width: 550, height: 280 });
        }

        function selectRecive() {
            chooseFlag = 12;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=12&Multiple=true&rnd=" + Math.random(), width: 550, height: 280 });
        }

        function selectLine() {
            chooseFlag = 3;
            var searchCondition = "";
            var count = '<%=Application["LineQty"].ToString() %>';
            if (count != "0") {
                searchCondition = "&SearchCondition=<%=GetConditions() %>";
            }
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=21&Multiple=false" + searchCondition + "&rnd=" + Math.random(), width: 600, height: 300 });
        }

        function getChooseValue(list) {
            if (chooseFlag == 8) {
                $("#<%=this.txtStation.ClientID %>").val(list[0][1]);
                $("#<%=this.hdnStationId.ClientID %>").val(list[0][0]);
            }
            else if (chooseFlag == 1) {
                $("#<%=this.txtItem.ClientID %>").val(list[0][1] + "(" + list[0][2] + ")");
                $("#<%=this.hdnItemId.ClientID %>").val(list[0][0]);
            }
            else if (chooseFlag == 3) {
                $("#hdnLineId").val(list[0][0]);
                $("#txtLineName").val(list[0][1]);
            }
            else if (chooseFlag == 12) {
                if (list[0][0] == -1) {
                    $("#hdnReciyeId").val("");
                    $("#txtReciveUsers").val("");
                    receiveId = "";
                    receiveIdVal = "";
                    return false;
                }
                var isExsit = false;
                var reciyeIdArr = $("#hdnReciyeId").val().split(",");
                $.each(reciyeIdArr, function () {
                    if (this == list[0][0]) {
                        alert("<%=Resources.Messages.RecordExists %>");
                        isExsit = true;
                        return;
                    }
                });
                if (!isExsit) {
                    receiveId = $("#hdnReciyeId").val() + list[0][0] + ",";
                    receiveIdVal = $("#txtReciveUsers").val() + list[0][2] + ",";

                    $("#hdnReciyeId").val(receiveId);
                    $("#txtReciveUsers").val(receiveIdVal);
                }    
            }
        }

        /*保存数据*/
        function Save() {
            var txtItemId = $("#<%=this.hdnItemId.ClientID%>").val();
            var txtLineId = $("#<%=this.hdnLineId.ClientID%>").val();
            var txtStationId = $("#<%=this.hdnStationId.ClientID%>").val();
            var txtWarnType = $("#<%=this.ddlWarnType.ClientID%>").val();
            var txtWarnLevel = $("#<%=this.ddlWarnLevel.ClientID%>").val();
            var txtYield = $("#<%=this.txtYield.ClientID%>").val();
            var txtReciveUsers = $("#<%=this.hdnReciyeId.ClientID%>").val();
            var txtContents = $("#<%=this.txtContents.ClientID%>").val();
            var txtCreateBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
            var txtModifyBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';

            var entity = {};

            entity.WarnSettingsId = warnSettingsId
            entity.ItemId = parseInt(txtItemId);
            entity.LineId = parseInt(txtLineId);
            entity.StationId = parseInt(txtStationId);
            entity.WarnType = parseInt(txtWarnType);
            entity.WarnLevel = parseInt(txtWarnLevel);
            entity.Yield = parseFloat(txtYield);
            entity.ReciveUsers = txtReciveUsers;
            entity.Contents = txtContents;
            entity.CreateBy = txtCreateBy;
            entity.ModifyBy = txtModifyBy;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxQuality.WarnSettingsEdit(entity);
            if (ajax.error == null) {
                alert('<%=Resources.Messages.SaveInSuccess%>')
                parent.window.UpdateList();
            } else {
                alert(ajax.error.Message);
                return false;
            }
        }
    </script>
</asp:Content>
