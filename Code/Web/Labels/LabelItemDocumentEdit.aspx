<%@ Page Title="Edit LabelItemDocuments" Language="C#" MasterPageFile="~/Masters/EditMaster.master"
    AutoEventWireup="true" CodeBehind="LabelItemDocumentEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Labels.LabelItemDocumentEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %>
    </div>
    <table width="100%" class="EditeContentTable">

        <tr>
            <td class="Label2">
                <%= Resources.lang.Item %><em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtItem" runat="server" CssClass="TextBox" Enabled="false" Text="ALL" IsRequired="1"></asp:TextBox><input type="button" id="btnSelectItem" onclick="openChoosePage(1);" class="ButtonBox" value="..." />
                <asp:HiddenField ID="hdnItemId" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
            <td class="Label2">
                <%= Resources.lang.RuleType %><em>*</em>
            </td>
            <td class="Field2">
                <asp:DropDownList ID="ddlType" runat="server">
                    <%--<asp:ListItem Text="<%$ Resources:Enum, Choose %>" Value="-1"></asp:ListItem>
                    <asp:ListItem Text="<%$ Resources:Enum, Item %>" Value="1"></asp:ListItem>
                    <asp:ListItem Text="<%$ Resources:Enum, Material %>" Value="2"></asp:ListItem>
                    <asp:ListItem Text="<%$ Resources:Enum, Pack %>" Value="3"></asp:ListItem>
                    <asp:ListItem Text="<%$ Resources:Enum, IQC %>" Value="4"></asp:ListItem>
                    <asp:ListItem Text="<%$ Resources:Enum, ReceiveOrder %>" Value="5"></asp:ListItem>
                    <asp:ListItem Text="<%$ Resources:Enum, Pallet %>" Value="6"></asp:ListItem>--%>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.Document %><em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtDoc" runat="server" CssClass="TextBox" Enabled="false" IsRequired="1"></asp:TextBox><input type="button" id="btnSelectDocument" onclick="openChoosePage(43);" class="ButtonBox" value="..." />
                <asp:HiddenField ID="hdnDocID" runat="server" Value="-1" ClientIDMode="Static" />
            </td>

            <td class="Label2">
                <%= Resources.lang.Sequence %><em>*</em>
            </td>
            <td class="Field2">
                <asp:DropDownList ID="ddlSequence" runat="server">
                    <asp:ListItem Text="1" Value="1"></asp:ListItem>
                    <asp:ListItem Text="2" Value="2"></asp:ListItem>
                    <asp:ListItem Text="3" Value="3"></asp:ListItem>
                    <asp:ListItem Text="4" Value="4"></asp:ListItem>
                    <asp:ListItem Text="5" Value="5"></asp:ListItem>
                    <asp:ListItem Text="6" Value="6"></asp:ListItem>
                    <asp:ListItem Text="7" Value="7"></asp:ListItem>
                    <asp:ListItem Text="8" Value="8"></asp:ListItem>
                    <asp:ListItem Text="9" Value="9"></asp:ListItem>
                    <asp:ListItem Text="10" Value="10"></asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.Station %>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtStation" runat="server" CssClass="TextBox" Enabled="false" ></asp:TextBox>
                <input type="button" id="btnSelectStation" onclick="openChoosePage(8);" class="ButtonBox" value="..." />
                <asp:HiddenField ID="hdnStationId" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
        </tr>

    </table>
    <script type="text/javascript">
        var itemDocumentsId = '<%=Request.QueryString["ID"]%>';
        var flag = -1;

        /*保存数据*/
        function Save() {
            var txtItemID = $("#<%=this.hdnItemId.ClientID %>").val();
            var txtDocID = $("#<%=this.hdnDocID.ClientID %>").val();
            
            var ddlTypeId = $("#<%=this.ddlType.ClientID%>").val();
            var ddlSequence = $("#<%=this.ddlSequence.ClientID%>").val();
            var txtCreateBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
            var txtModifyBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
            //huangliang 2017-11-13 增加工位和打印顺序
            var txtStationId = $("#<%=this.hdnStationId.ClientID %>").val();
            var PrintSort = 1;
            /*表单验证*/
            /*如需表单验证可以此处处理验证 开始*/
            if (ddlTypeId == 0) {
                alert("<%= Resources.Messages.TypeEmpty %>");
                return false;
            }

            var entity = {};

            entity.ItemDocId = itemDocumentsId
            entity.ItemID = txtItemID;
            entity.DocID = txtDocID;
            entity.StationId = txtStationId;
            entity.TypeId = ddlTypeId;
            entity.Sequence = ddlSequence;
            entity.CreateBy = txtCreateBy;
            entity.ModifyBy = txtModifyBy;
            entity.PrintSort = PrintSort;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxLabels.LabelItemDocumentEdit(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert('<%=Resources.Messages.SaveInSuccess%>')
            if ('<%=Request.QueryString["inMenu"] %>' == "true") {
                openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Labels/LabelItemDocumentEdit.aspx?name=Labels_ItemDocumentEdit&ID=" + parseInt(ajax.value);
                location.href = openWinUrl;
            }
            else {
                parent.window.Refresh();
            }
        }

        function openChoosePage(flags) {
            flag = flags;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=" + flags + "&Multiple=false&rnd=" + Math.random(), width: 650, height: 300 });
        }

        function getChooseValue(list) {
            if (flag == 1) {
                if (list[0][0] == "-1") {
                    $("#<%= this.txtItem.ClientID %>").val("ALL");
                }
                else {
                    $("#<%= this.txtItem.ClientID %>").val(list[0][2]);
                }
                $("#<%= this.hdnItemId.ClientID %>").val(list[0][0]);
            } else if (flag == 8) {
                $("#<%= this.txtStation.ClientID %>").val(list[0][1]);
                $("#<%= this.hdnStationId.ClientID %>").val(list[0][0]);
            } else if (flag == 43) {
                $("#<%= this.txtDoc.ClientID %>").val(list[0][1]);
                $("#<%= this.hdnDocID.ClientID %>").val(list[0][0]);
            }
            flag = -1;
        }
        /*是否是数字*/
        function isNumber(s) {
            var regu = "^[0-9]+$";
            var re = new RegExp(regu);
            if (s.search(re) != -1) {
                return true;
            } else {
                return false;
            }
        }
    </script>
</asp:Content>
