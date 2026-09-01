<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/ListMaster.master"  CodeBehind="RouterList.aspx.cs" Inherits="SKT.LeanMES.Web.Router.RouterList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">
                <%=Resources.lang.RouterName%>
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtRouter" runat="server" CssClass="TextBox" patterns="AutoComplete" source="ROUTER" field="RouterName" minChars="3" ClientIDMode="Static"></asp:TextBox>
            </td>
            <td class="Label3">
             <%=Resources.lang.ItemName%>
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtItemName" runat="server" CssClass="TextBox" patterns="AutoComplete" source="ITEM" field="ItemName" minChars="3" ClientIDMode="Static"></asp:TextBox>
            </td>
            <td class="Label3">
            <%=Resources.lang.ItemCode%>
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtItemCode" runat="server" CssClass="TextBox" patterns="AutoComplete" source="ITEM" field="txtItemCode" minChars="3" ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false"  OnPreRender="GridView1_PreRender" OnRowDataBound="GridView1_OnRowDataBound" ClientIDMode="Static">
        <Columns>
            <asp:BoundField DataField="R_Name" HeaderText="<%$ Resources:lang,RouterName %>" HeaderStyle-Width="180px" SortExpression="R_Name"/>
            <asp:BoundField DataField="R_Status" HeaderText="<%$ Resources:lang,Status %>"  HeaderStyle-Width="95px" SortExpression="R_Status"/>
            <asp:BoundField DataField="R_Description" HeaderText="<%$ Resources:lang,Description %>" />
            <asp:BoundField DataField="ItemName" HeaderText="<%$ Resources:lang,ItemName %>"  HeaderStyle-Width="180px" SortExpression="ItemName"/>
            <asp:BoundField DataField="ItemCode" HeaderText="<%$ Resources:lang,ItemCode %>"  HeaderStyle-Width="180px" SortExpression="ItemCode"/>
            <asp:BoundField DataField="ItemRev" HeaderText="产品版本"  HeaderStyle-Width="65px" SortExpression="ItemRev"/>
            <asp:BoundField DataField="Site" HeaderText="<%$ Resources:lang,Site %>"  HeaderStyle-Width="65px" SortExpression="Site"/>
            <asp:BoundField DataField="CreateBy" HeaderText="创建人"  HeaderStyle-Width="65px" SortExpression="Site"/>
            <asp:BoundField DataField="CreateDateTime" HeaderText="创建时间"  HeaderStyle-Width="160px" SortExpression="Site" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
            <asp:BoundField DataField="ModifyBy" HeaderText="修改人"  HeaderStyle-Width="65px" SortExpression="Site"/>
            <asp:BoundField DataField="ModifyDateTime" HeaderText="修改时间"  HeaderStyle-Width="160px" SortExpression="Site" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Router.BLL.Router"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <asp:Button ID="btnDownload" runat="server" OnClick="Download_Click" ClientIDMode="Static"
         Style="display: none;" />  
    <script type="text/javascript">
        $(document).ready(function () {
            //有合并单元格，禁用隐藏列
            setTimeout(function () {
                $("#setGridColumn").hide();
                $(".ListTable tr[class*='Header']").unbind("dblclick");
            }, 100);
        })
        isMultiple = false;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");
        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Router/RouterEdit.aspx?name=Router_RouterAdd&ID=-1";
            dialog({ title: "<%=Resources.Pages.Router_RouterAdd %>", src: openWinUrl, width: 650, height: 350 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Router/RouterEdit.aspx?name=Router_RouterEdit&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.Router_RouterEdit %>", src: openWinUrl, width: 650, height: 350 });
        }

        function Copy() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Router/RouterEdit.aspx?name=Router_RouterCopy&ID=" + idStr + "&IsCopy=1";
            dialog({ title: "<%=Resources.Pages.Router_RouterEdit %>", src: openWinUrl, width: 650, height: 350 });
        }

        function Delete() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;

            if (window.confirm(ConfirmDelete)) {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxRouter.CheckRouterIsBindItemOrOrder(idStr);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                } 

                hdnOperate.val("delete");
                hdnIdString.val(idStr);
                document.forms[0].submit();
            }
        }

        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Router/RouterView.aspx?name=Router_RouterView&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.Router_RouterView %>", src: openWinUrl, width: 650, height: 400 });
        }

        function RouterDesign() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;

            //xiang.yan 2024-4-28  列取值由索引改为列明,功能已去除
            // 1 改为 r_name
            var r_name = getOneRecordCellTextByFiled("R_Name");
            r_name = r_name.replace(" ", "-").replace(" ", "-").replace(/\(/g,"（").replace(/\)/g,"）");/*Add By Alen 2017-09-28 路由名称如果有空格会导致路由设计打不开，因为在下面语句中使用到了路由名作为选项卡ID，如果有空格无法解析，故在此将名称中含有的空格替换为-，不影响功能使用和数据库*/
            window.parent.openLeftMenu(this, r_name + " [<%=Resources.Pages.Router_RouterDesign %>]", "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Router/RouterDesign.aspx?name=Router_RouterDesign&R_Id=" + idStr + "&R_Name=" + encodeURI(r_name) + "", idStr);
        }

        function RouterDesignB() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            //xiang.yan 2024-4-28  列取值由索引改为列明
            // 1 改为 r_name
            var r_name = getOneRecordCellTextByFiled("R_Name");
            r_name = r_name.replace(" ", "-").replace(" ", "-").replace(/\(/g,"（").replace(/\)/g,"）");
            window.parent.openLeftMenu(this, r_name + " [<%=Resources.Pages.Router_RouterDesign %>]", "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Router/RouterDesigns.aspx?name=Router_RouterDesingerEditB&R_Id=" + idStr + "&R_Name=" + encodeURI(r_name) + "", idStr );
        }

        function UpdateList(namestr) {
            $("#txtRouter").val(namestr);
            document.forms[0].submit();
        }    

        function Importroute() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Router/ImportRoute.aspx?name=Router_ImportRoute&ID=-1";
            dialog({ title: "导入路由", src: openWinUrl, width: 650, height: 350 });
        }
        function Download() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            hdnOperate.val("download");
            hdnIdString.val(idStr);
            $("#btnDownload").click();

        }
        
    </script>
</asp:Content>
