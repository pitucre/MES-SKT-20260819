<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true"
    Inherits="SKT.LeanMES.Web.SMT.LoadingList" CodeBehind="LoadingList.aspx.cs" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">
                <%=Resources.lang.SetupName %>
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtSetupName" runat="server" CssClass="TextBox" patterns="AutoComplete"
                    source="SetupName" field="SetupName" minChars="2"></asp:TextBox>
            </td>
            <td class="Label3">产品编码
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtItemCode" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">状态
            </td>
            <td class="Field3">
                <asp:DropDownList ID="ddlStatus" runat="server">
                    <asp:ListItem Value="-1" Selected="True">全部</asp:ListItem>
                    <asp:ListItem Value="1">使用中</asp:ListItem>
                    <asp:ListItem Value="0">未使用</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1">
        <Columns>
            <asp:BoundField DataField="setupName" HeaderText="<%$ Resources:lang,setupName %>"
                SortExpression="setupName" />
            <asp:BoundField DataField="ItemCode" HeaderText="<%$ Resources:lang,ItemCode %>" />
            <asp:BoundField DataField="Revision" HeaderText="<%$ Resources:lang,revision %>" SortExpression="Revision" />
            <asp:BoundField DataField="StatusStr" HeaderText="<%$ Resources:lang,status %>" />
            <asp:BoundField DataField="SmtLayout" HeaderText="面别" />
            <asp:BoundField DataField="EquipmentLineType" HeaderText="线别设备类型" />
            <asp:BoundField DataField="SequenceNo" HeaderText="线别设备序号" />
            <asp:BoundField DataField="TypeName" HeaderText="模板类型" />
            <asp:BoundField DataField="CLNumber" HeaderText="扣料基数" />
            <asp:BoundField DataField="CreateBy" HeaderText="创建人" SortExpression="CreateBy" />
            <asp:BoundField DataField="creationTime" HeaderText="<%$ Resources:lang,CreateTime %>" SortExpression="creationTime" /> 
            <asp:BoundField DataField="ModifyBy" HeaderText="修改人" SortExpression="ModifyBy" />
            <asp:BoundField DataField="ModifyTime" HeaderText="<%$ Resources:lang,ModifyDateTime %>" SortExpression="ModifyTime" /> 
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.SMT.BLL.Loadinglist"
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
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SMT/LoadingListAdd.aspx?name=LoadingListAdd&ID=-1";
            dialog({ title: "<%=Resources.Pages.LoadingListAdd %>", src: openWinUrl, width: 850, height: 480 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SMT/LoadingListEdit.aspx?name=LoadingListEdit&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.LoadingListEdit %>", src: openWinUrl, width: 850, height: 550 });
        }

        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            if ($('input[name="chkSelect"]:checked').parent().parent().find("td:eq(4)").html() != "未使用") {
                alert("当前上料清单状态不能删除");
                return false;
            }
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }

        //启用
        function Start() {
            //var idStr = getDeletingRecordIdString1();
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxServicesLoadingList.LoadingStatusStart(idStr);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            document.forms[0].submit();
        }
        function UpdateList(namestr) {
            $("#<%=this.txtSetupName.ClientID %>").val(namestr);
            document.forms[0].submit();
        }

        function Download() {
            return downLoadField('<%=SKT.LeanMES.Web.WebHelper.ExcelTemplateRoot+"SMT上料清单.xlsx" %>');
        }
        function downLoadField(fieldPath) {
            window.open(fieldPath);
            return null;
        }
        //重写
        function getDeletingRecordIdString1() {
            //var idStr = getRecordIdString();

            var idStr = getOneRecordId();
            if (idStr != "") {
                if (!window.confirm("是否启用上料清单")) {
                    return "";
                }
            }
            return idStr;
        }


        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SMT/LoadingListView.aspx?name=LoadingListView&ID=" + idStr;
                    dialog({ title: "<%=Resources.Pages.LoadingListView %>", src: openWinUrl, width: 850, height: 400 });
                }
    </script>
</asp:Content>
