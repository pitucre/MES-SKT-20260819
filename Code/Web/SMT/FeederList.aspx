<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true"
    CodeBehind="FeederList.aspx.cs" Inherits="SKT.LeanMES.Web.SMT.FeederList" Title="Feeder List Page" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">Feeder号
            </td>
            <td class="Field3">
                <input type="text" id="txtFeeder" class="TextBox" runat="server" />
            </td>
            <td class="Label3">
              <%--  <%=Resources.lang.MachineModelName%>--%>
                类型名称
            </td>
            <td class="Field3">
                <input type="text" id="txtModelName" class="TextBox" runat="server" />
            </td>
            <td class="Label3">
                <%= Resources.lang.Status%>
            </td>
            <td class="Field3">
                <asp:DropDownList ID="ddlStatus" runat="server">
                    <asp:ListItem Value="-1" Selected="True">All</asp:ListItem>
                    <asp:ListItem Value="35">Active</asp:ListItem>
                    <asp:ListItem Value="36">Created</asp:ListItem>
                    <asp:ListItem Value="37">Deleted</asp:ListItem>
                    <asp:ListItem Value="38">InActive</asp:ListItem>
                    <asp:ListItem Value="39">Issued</asp:ListItem>
                    <asp:ListItem Value="40">Maintenance</asp:ListItem>
                    <asp:ListItem Value="41">MaterialUnitMapped</asp:ListItem>
                    <asp:ListItem Value="42">OfflineMapped</asp:ListItem>
                    <asp:ListItem Value="43">OnlineMapped</asp:ListItem>
                    <asp:ListItem Value="44">Returned</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="searchConditions" runat="server" ContentPlaceHolderID="GridviewContent">
    <asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server">
        <Columns>
            <asp:BoundField DataField="SerialNumber" HeaderText="Feeder号" SortExpression="SerialNumber" />
            <asp:BoundField DataField="FeederType" HeaderText="<%$ Resources:lang,FeederTypeName %>"
                SortExpression="FeederTypeName" />
            <asp:BoundField DataField="FeederCategory" HeaderText="<%$ Resources:lang,FeederCategory %>"
                SortExpression="FeederCategory" />
            <%--<asp:BoundField DataField="ModelName" HeaderText="<%$ Resources:lang,MachineModelName %>"
                SortExpression="ModelName" />--%>
            <asp:BoundField DataField="Status" HeaderText="<%$ Resources:lang,Status %>" SortExpression="Status" />
            <asp:BoundField DataField="User" HeaderText="<%$ Resources:lang,CreateBy %>" SortExpression="User" />
            <asp:BoundField DataField="CreationTime" HeaderText="<%$ Resources:lang, CreateDateTime %>" HeaderStyle-Width="150px" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" SortExpression="CreationTime" />
            <asp:BoundField DataField="MaxUseDuration" HeaderText="<%$ Resources:lang,MaxUseDuration %>"
                SortExpression="MaxUseDuration" />
            <asp:BoundField DataField="MaxUnuseDuration" HeaderText="<%$ Resources:lang,MaxUnuseDuration %>"
                SortExpression="MaxUnuseDuration" />
            <asp:BoundField DataField="MaxPickUp" HeaderText="<%$ Resources:lang,MaxPickUp %>"
                SortExpression="MaxPickUp" />
            <asp:BoundField DataField="MaxPickUpErr" HeaderText="<%$ Resources:lang,MaxPickUpErr %>"
                SortExpression="MaxPickUpErr" />
            <asp:BoundField DataField="PickUpErrRatio" HeaderText="<%$ Resources:lang,MaxPickUpErrRatio %>"
                SortExpression="PickUpErrRatio" />
            <asp:BoundField DataField="Description" HeaderText="<%$ Resources:lang,Description %>" />
            <asp:BoundField DataField="ModifyBy" HeaderText="<%$Resources:lang,ModifyBy %>" HeaderStyle-Width="60px" />
            <asp:BoundField DataField="ModifyTime" HeaderText="<%$Resources:lang,ModifyDateTime %>"  DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" HeaderStyle-Width="150px" /> 
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.SMT.BLL.Feeder"
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
        //增加 
        function Add() {
            dialog({ title: "<%= Resources.Pages.FeederAdd %>", src: "FeederEdit.aspx?name=FeederAdd&ID=-1&rnd=" + Math.random(), width: 720, height: 450, resizeable: true });
        }
        //编辑
        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return;
            dialog({ title: "<%= Resources.Pages.FeederEdit %>", src: "FeederEdit.aspx?name=FeederEdit&ID=" + idStr + "&rnd=" + Math.random(), width: 720, height: 450, resizeable: true });
        }
        //查看
        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return;
            dialog({ title: mesLang("查看飞达信息"), src: "FeederView.aspx?name=FeederView&ID=" + idStr + "&rnd=" + Math.random(), width: 720, height: 450, resizeable: true });
        }
        //复制
        function Copy() {
            var idStr = getOneRecordId();
            if (idStr == "") return;
            dialog({ title: mesLang("复制飞达信息"), src: "FeederEdit.aspx?name=FeederEdit&ID=" + idStr + "&Action=Copy&rnd=" + Math.random(), width: 720, height: 450, resizeable: true });
        }
        //刷新 
        function refresh() {
            document.forms[0].submit();
        }

        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            $(hdnOperate).val("Delete");
            $(hdnIdString).val(idStr);
            document.forms[0].submit();
        }

        function UpdateList(ModelName) {
            $("#<%=this.txtModelName.ClientID %>").val(ModelName);
            document.forms[0].submit();
        }

        function Import() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SMT/FeederImport.aspx?name=FeederImport";
               dialog({ title: "<%=Resources.Pages.SMT_FeederImport %>", src: openWinUrl, width: 850, height: 450 });
           }
    </script>
</asp:Content>
