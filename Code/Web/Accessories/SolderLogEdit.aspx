<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SolderLogEdit.aspx.cs"
    Inherits="SKT.LeanMES.Web.Accessories.SolderLogEdit" MasterPageFile="~/Masters/EditMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <table class="EditeContentTable" width="100%">
        <tr class="">
            <td class="infoTips" colspan="4">
                <%=Resources.Messages.WithAsteriskIsRequired %>
            </td>
            </tr>
            <tr class="clear5"></tr>
        <tr>
            <td class="Label1">
                <%= Resources.lang.Accessorie_BARCODE%>
            </td>
            <td class="Field1">
                <asp:Label ID="lblBarCode" runat="server" ClientIDMode="Static"></asp:Label>
            </td>
        </tr>
    </table>
    <div id="divUserHtml" runat="server">
        <table class="EditeContentTable" width="100%">
            <tr>
                <td class="Label1">
                    使用时间<em>*</em>
                </td>
                <td class="Field1">
                    <asp:TextBox ID="txtUseTime" runat="server" CssClass="DateTimeBox" ClientIDMode="Static"
                        IsRequired="1"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="Label1">
                    线别<em>*</em>
                </td>
                <td class="Field1">
                    <asp:TextBox ID="txtLine" runat="server" CssClass="TextBox" ClientIDMode="Static"
                        IsRequired="1" Enabled="false"></asp:TextBox>
                    <input type="button" value="..." onclick="selectLine()" class="ButtonBox" />
                    <asp:HiddenField runat="server" ID="hdnLine" />
                </td>
            </tr>
            <tr>
                <td class="Label1">
                    使用人<em>*</em>
                </td>
                <td class="Field1">
                    <asp:TextBox ID="txtUsePeople" runat="server" CssClass="TextBox" ClientIDMode="Static"
                        IsRequired="1" Enabled="false"></asp:TextBox>
                    <input type="button" value="..." onclick="selectUser()" class="ButtonBox" />
                    <asp:HiddenField runat="server" ID="hdnUsePeople" />
                </td>
            </tr>
            <tr>
                <td class="Label1">
                    工单<em>*</em>
                </td>
                <td class="Field1">
                    <asp:TextBox ID="txtOrder" runat="server" CssClass="TextBox" ClientIDMode="Static"
                        IsRequired="1" Enabled="false"></asp:TextBox>
                    <input type="button" value="..." onclick="selectOrder()" class="ButtonBox" />
                    <asp:HiddenField runat="server" ID="hdnOrder" />
                </td>
            </tr>
        </table>
    </div>
    <script type="text/javascript">
        _isHms = true;

        var barCodeId = '<%=Request.QueryString["ID"] %>';

        //解冻
        function SaveThaw() {

            var txtBarCode = $("#lblBarCode").text();
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxServiceSolderLog.AddThawInfo(txtBarCode);

            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert("<%=Resources.Messages.SaveInSuccess %>");
            parent.window.UpdateList();
        }

        function Save() {
            var txtBarCode = $("#lblBarCode").text();
            var hdnUsePeople = $("#hdnUsePeople").val();
            var hdnLine = $("#hdnLine").val();
            var hdnOrder = $("#hdnOrder").val();
            var useTime = $("#txtUseTime").val();

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxServiceSolderLog.AddUseOfInfo(txtBarCode, hdnUsePeople, hdnLine, hdnOrder, useTime);

            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert("<%=Resources.Messages.SaveInSuccess %>");
            parent.window.UpdateList();
        }

        //使用
        function SaveUseOf() {
            SavePlus()
        }


        /*选择人员*/
        function selectUser() {
            chooseFlag = 12;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=12&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }

        /*选择产线*/
        function selectLine() {
            chooseFlag = 21;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=21&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }

        /*选择工单*/
        function selectOrder() {
            chooseFlag = 44;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=44&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }

        function getChooseValue(list) {
            if (chooseFlag == 12) {
                $("#<%=this.txtUsePeople.ClientID %>").val(list[0][1]);
                $("#<%=this.hdnUsePeople.ClientID %>").val(list[0][0]);
            } else
                if (chooseFlag == 21) {
                    $("#<%=this.txtLine.ClientID %>").val(list[0][1]);
                    $("#<%=this.hdnLine.ClientID %>").val(list[0][0]);
                }
                else
                    if (chooseFlag == 44) {
                        $("#<%=this.txtOrder.ClientID %>").val(list[0][1]);
                        $("#<%=this.hdnOrder.ClientID %>").val(list[0][0]);
                    }

            chooseFlag = -1;
        }
    </script>
</asp:Content>
