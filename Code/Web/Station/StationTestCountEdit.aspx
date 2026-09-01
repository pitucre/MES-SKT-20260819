<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="StationTestCountEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Station.StationTestCountEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <div class="infoTips">
        <%= Resources.Messages.WithAsteriskIsRequired %>
    </div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label1">
                工序名称<em>*</em>
            </td>
            <td class="Field1">
                <asp:HiddenField ID="hdnStationId" Value="-1" runat="server" />
                <asp:TextBox ID="txtStation" runat="server" Enabled="false" CssClass="TextBox" IsRequired='1' ></asp:TextBox><input type="button" id="btnSelectStation" onclick="selectStation();" class="ButtonBox"
                    value="..." />
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%= Resources.lang.ItemCode%>
            </td>
            <td class="Field1">
                <asp:HiddenField ID="hdnItemId" Value="-1" runat="server" />
                <asp:TextBox ID="txtItemCode" runat="server" CssClass="TextBox"></asp:TextBox><input type="button" id="btnSelectItem" onclick="selectItem();" class="ButtonBox"
                    value="..." />
            </td>
        </tr>
        <tr>
            <td class="Label1">
                最大通过次数(Pass次数)<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtPassTimes" runat="server" IsRequired="1" CssClass="TextBox NumericBox50" value="1" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                最大失败次数(Fail次数)<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtFailTimes" runat="server" IsRequired="1" CssClass="TextBox NumericBox50" value="1" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%= Resources.lang.Description %>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" CssClass="TextArea"
                    Width="350" Height="70"></asp:TextBox>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        var stationTestCountId = '<%=Request.QueryString["ID"]%>';
        if (stationTestCountId == "-1") {
            $("#btnSelectStation").removeAttr("disabled");
        } else {
            $("#btnSelectStation").attr("disabled", "disabled");
        }
        /*保存数据*/
        function Save() {
            var userName = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>';
            var stationId = $("#<%=this.hdnStationId.ClientID%>").val();
            var txtDescription = $("#<%=this.txtDescription.ClientID%>").val();
            var itemId = $("#<%=this.hdnItemId.ClientID%>").val();
            var passTimes = $("#<%=this.txtPassTimes.ClientID%>").val();
            var faliTimes = $("#<%=this.txtFailTimes.ClientID%>").val();
            /*表单验证*/
            var errStr = "";

            //验证必填项
            if (isNull(stationId) || stationId == "-1") {
                errStr += "工序为必选项\n";
            }
            if (!isNull(errStr)) {
                alert(errStr);
                return false;
            }

            var entity = {};
            entity.StationTestCountId = stationTestCountId;
            entity.StationId = stationId;
            entity.Description = txtDescription;
            entity.ItemId = itemId;
            entity.MaxPassTimes = parseInt(passTimes);
            entity.MaxFailTimes = parseInt(faliTimes);
            entity.CreateBy = userName;
            entity.ModifyBy = userName;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxStation.EdtiStationTestCount(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert('<%=Resources.Messages.SaveInSuccess%>')
            if ('<%=Request.QueryString["inMenu"] %>' == "true") {
                openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Station/StationTestCountEdit.aspx?name=Station_StationTestCountEdit&ID=" + parseInt(ajax.value);
                location.href = openWinUrl;
            }
            else {
                parent.window.Refresh();
            }
        }

        var falge = -1;
        function selectStation() {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=8&Multiple=false&rnd=" + Math.random(), width: 650, height: 350 });
        }

        function selectStation() {
            falge = 8;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=8&Multiple=false&rnd=" + Math.random(), width: 650, height: 350 });
        }

        function selectItem() {
            falge = 1;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=1&Multiple=false&rnd=" + Math.random(), width: 650, height: 350 });
        }

        function getChooseValue(list) {
            if (falge == 8) {
                $("#<%= this.txtStation.ClientID %>").val(list[0][1]);
                $("#<%= this.hdnStationId.ClientID %>").val(list[0][0]);
            }
            else if (falge == 1) {
                $("#<%= this.txtItemCode.ClientID %>").val(list[0][1]);
                $("#<%= this.hdnItemId.ClientID %>").val(list[0][0]);
            }
        }
    </script>
</asp:Content>
