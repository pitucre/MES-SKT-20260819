<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/ListMaster.master"
    CodeBehind="PickList.aspx.cs" Inherits="SKT.LeanMES.Web.SMT.PickList" %>


<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label4">
                <%=Resources.lang.SetupName %>
            </td>
            <td class="Field4">
                <asp:TextBox ID="txtSetupName" runat="server" CssClass="TextBox"
                    source="SetupName" field="SetupName" minChars="2"></asp:TextBox>
            </td>
            <td class="Label4">
                <%=Resources.lang.OrderNo %>
            </td>
            <td class="Field4">
                <asp:TextBox ID="txtOrderNo" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label4">
                <%=Resources.lang.ItemCode %>
            </td>
            <td class="Field4">
                <asp:TextBox ID="txtItemCode" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label4">状态
            </td>
            <td class="Field4">
                <asp:DropDownList ID="ddlStatus" runat="server">
                    <asp:ListItem Value="-1">全部</asp:ListItem>
                    <asp:ListItem Value="1" Selected="True">使用中</asp:ListItem>
                    <asp:ListItem Value="0">未使用</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <asp:BoundField DataField="ListName" HeaderText="上料清单名" SortExpression="ListName" />
            <asp:BoundField DataField="OrderNo" HeaderText="工单号" SortExpression="OrderNo" />
            <asp:BoundField DataField="ItemCode" HeaderText="<%$ Resources:lang,ItemCode %>" SortExpression="ItemCode" />
            <asp:BoundField DataField="Revision" HeaderText="版本" SortExpression="Revision" />
            <asp:BoundField DataField="StatusStr" HeaderText="状态" SortExpression="StatusStr" />
            <asp:BoundField DataField="CreateBy" HeaderText="创建人" SortExpression="CreateBy" ItemStyle-Width="100px" />
            <asp:BoundField DataField="CreationTime" HeaderText="<%$ Resources:lang,CreateTime %>" ItemStyle-Width="160px" />
            <asp:BoundField DataField="ModifyBy" HeaderText="修改人" SortExpression="ModifyDateTime" ItemStyle-Width="100px" />
            <asp:BoundField DataField="ModifyDateTime" HeaderText="<%$ Resources:lang,ModifyDateTime %>" ItemStyle-Width="160px" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.SMT.BLL.PickList"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script type="text/javascript">
        isMultiple = false;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");
        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SMT/PickListAdd.aspx?name=PickListAdd&ID=-1";
            dialog({ title: "<%=Resources.Pages.LoadingListAdd %>", src: openWinUrl, width: 850, height: 480 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            /* var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPickList.deletePickList(parseInt(idStr), 1,idStr);
             if (ajax.error != null) {
                 alert(ajax.error.Message);
                 return false;
             }*/

            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SMT/PickListEdit.aspx?name=PickListEdit&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.LoadingListEdit %>", src: openWinUrl, width: 850, height: 400 });
        }

        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;

            //var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPickList.deletePickList(-1,2,idStr);
            //if (ajax.error != null) {
            //    alert(ajax.error.Message);
            //    return false;
            //}

            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }

        function UpdateList(namestr) {
            $("#<%=this.txtSetupName.ClientID %>").val(namestr);
            document.forms[0].submit();
        }

        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SMT/PickListView.aspx?ID=" + idStr;
            dialog({ title: mesLang("查看手插清单"), src: openWinUrl, width: 650, height: 400 });
        }

        function Download() {
            return downLoadField('<%=SKT.LeanMES.Web.WebHelper.ExcelTemplateRoot+"手插上料清单.xlsx" %>');
        }

        function downLoadField(fieldPath) {
            window.open(fieldPath);
            return null;
        }

        function OrderPickList() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SMT/OrderPickListAdd.aspx?name=OrderPickListAdd&ID=-1";
             dialog({ title: "<%=Resources.Pages.OrderPickListAdd %>", src: openWinUrl, width: 850, height: 480 });
        }

        function Refresh() {
            document.forms[0].submit();
        }

        //启用
        function Start() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            var entity = {};
            entity.ListID = idStr;
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPickList.PickLoadingStart(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            document.forms[0].submit();
        }
    </script>
</asp:Content>
