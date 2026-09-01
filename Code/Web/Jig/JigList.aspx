<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true"
    CodeBehind="JigList.aspx.cs" Inherits="SKT.LeanMES.Web.Jig.JigList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">
                <%//= Resources.lang.JigName %>夹具名称
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtJigName" runat="server" CssClass="TextBox" Width="80%"></asp:TextBox>
            </td>
            <td class="Label3">
                <%//= Resources.lang.JigNickName %>夹具别名
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtJigNickName" runat="server" CssClass="TextBox" Width="80%"></asp:TextBox>
            </td>
            <td class="Label3">
                <%= Resources.lang.Status %>
            </td>
            <td class="Field3">
                <asp:DropDownList runat="server" ID="ddlJigStatus">
                    <asp:ListItem Value="0">所有</asp:ListItem>
                    <asp:ListItem Value="1">正常</asp:ListItem>
                    <asp:ListItem Value="2">报废</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="Label3">
                夹具编号
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtJigCode" runat="server" CssClass="TextBox" Width="80%"></asp:TextBox>
            </td>
            <td class="Label3">
                存放位置
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtPosition" runat="server" CssClass="TextBox" Width="80%"></asp:TextBox>
                <div style="display: none">
                    <asp:Button ID="btnImport" Text="导出到Excel" runat="server" OnClick="btnImport_Click" />
                </div>
            </td>
            <td class="Label3">
                入库日期
            </td>
            <td class="Field3">
                <input type="text" id="txtDateFrom" class="DateTimeBox" runat="server" readonly="true"/>
                -
                <input type="text" id="txtDateTo" class="DateTimeBox" runat="server"  readonly="true"/>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="JigCode" HeaderText="<%$ Resources:lang, Number %>" />
            <asp:BoundField DataField="JigName" HeaderText="<%$ Resources:lang, TheName %>" />
            <asp:BoundField DataField="JigNickName" HeaderText="<%$ Resources:lang, JigNickName %>" />
            <asp:BoundField DataField="TypeName" HeaderText="<%$ Resources:lang, Category %>" />
            <asp:BoundField DataField="ItemCode" HeaderText="<%$ Resources:lang, AC_OBA_Item %>" />
            <asp:BoundField DataField="ItemName" HeaderText="<%$ Resources:lang, ItemName %>" />
            <asp:BoundField DataField="VendorName" HeaderText="<%$ Resources:lang, Supplier %>" />
            <asp:BoundField DataField="VendorCode" HeaderText="<%$ Resources:lang, VendorCode %>" />
            <asp:BoundField DataField="Position" HeaderText="<%$ Resources:lang, PartLocation %>" />
            <asp:BoundField DataField="CurPosition" HeaderText="当前位置" />
            <asp:BoundField DataField="StandarLive" HeaderText="<%$ Resources:lang, StandarLive %>" />
            <asp:BoundField DataField="StandarMaint" HeaderText="<%$ Resources:lang, StandarMain %>" />
            <asp:BoundField DataField="UseCount" HeaderText="<%$ Resources:lang, UserCount %>" />
            <asp:BoundField DataField="JigStatus" HeaderText="<%$ Resources:lang, Status %>" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="入库日期" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Jig.BLL.Jig"
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
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Jig/JigEdit.aspx?name=JigAdd&ID=-1";
            dialog({ title: "<%=Resources.Pages.JigAdd %>", src: openWinUrl, width: 800, height: 430 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;

            //xiang.yan 2024-4-26  列取值由索引改为列明,菜单已无此页面
            // 14 改为 JigStatus
            if (getOneRecordCellTextByFiled("JigStatus") == "报废") {
                alert("夹具已报废，不能编辑！")
                return false;
            }

            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Jig/JigEdit.aspx?name=JigEdit&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.JigEdit %>", src: openWinUrl, width: 800, height: 430 });
        }

        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }
        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Jig/JigView.aspx?name=JigView&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.JigView %>", src: openWinUrl, width: 600, height: 330 });
        }
        function Refresh() {
            document.forms[0].submit();
        }
        function UpdateList(namestr) {
            $("#<%=this.txtJigName.ClientID %>").val(namestr);
            document.forms[0].submit();
        }
        //导出
        function Import() {
            $("#<%=this.btnImport.ClientID %>").click();
        }
        function In() {
            var idStr = getOneRecordId();
            if (idStr == "") {
                return false;
            }
            //xiang.yan 2024-4-26  列取值由索引改为列明,菜单已无此页面
            // 14 改为 JigStatus
            if (getOneRecordCellTextByFiled("JigStatus") == "报废") {
                alert("夹具已报废，不能编辑！")
                return false;
            }

            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Jig/JigIn.aspx?name=JigIn&ID=" + idStr;
            dialog({ title: "夹具归还", src: openWinUrl, width: 630, height: 420 });
        }

        function Out() {
            var idStr = getOneRecordId();
            if (idStr == "") {
                return false;
            }

            //xiang.yan 2024-4-26  列取值由索引改为列明,菜单已无此页面
            // 14 改为 JigStatus
            if (getOneRecordCellTextByFiled("JigStatus") == "报废") {
                alert("夹具已报废，不能编辑！")
                return false;
            }

            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Jig/JigOut.aspx?name=JigOut&ID=" + idStr;
            dialog({ title: "夹具借用", src: openWinUrl, width: 630, height: 420 });
        }

        function Scrap() {
            var idStr = getOneRecordId();
            if (idStr === "") return false;
            if (!confirm("确认报废？")) return false;
            hdnOperate.val("scrap");
            hdnIdString.val(idStr);
            document.forms[0].submit();
            hdnOperate.val("");

        }
    </script>
</asp:Content>
