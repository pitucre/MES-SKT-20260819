<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="True"
    CodeBehind="ItemList.aspx.cs" Inherits="SKT.LeanMES.Web.Product.ItemList" Title="Item List Page"
    ValidateRequest="false" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">
                 <%=Resources.lang.ProductCodeORName %>
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtItemName" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
            </td>
            <td class="Label3">
                  <%=Resources.lang.ProductSourceType %>
            </td>
            <td class="Field3">
                <asp:DropDownList ID="ddlItemType" runat="server">
                    <asp:ListItem Value="-1" Text=""> </asp:ListItem>
                    <asp:ListItem Value="1" Text="<%$ Resources:lang,Manufacture %>"> </asp:ListItem>
                    <asp:ListItem Value="2" Text="<%$ Resources:lang,Purchase %>"> </asp:ListItem>
                    <asp:ListItem Value="3" Text="<%$ Resources:lang,ManufacturingOrPurchasing %>"> </asp:ListItem>
                </asp:DropDownList>
            </td>
            <td class="Label3">
                MES/ERP
            </td>
            <td class="Field3">
                <asp:DropDownList ID="ddlIsMESadd" runat="server">
                 <asp:ListItem Value="-1" Text=""> </asp:ListItem>
                    <asp:ListItem Value="0" Text="ERP"> </asp:ListItem>
                    <asp:ListItem Value="1" Text="<%$ Resources:lang,MESCreation %>"> </asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
          <tr>
      <td class="Label3">
           <%=Resources.lang.CustomerPartNumber %>
      </td>
      <td class="Field3">
          <asp:TextBox ID="txtCPN" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
      </td>
      
  </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" OnRowDataBound="GridView1_OnRowDataBound" style="table-layout:fixed;word-wrap:break-word;word-break:break-all">
        <Columns>
            <asp:BoundField DataField="ItemCode" HeaderText="<%$ Resources:lang, ItemCode %>" HeaderStyle-Width="170px" SortExpression="ItemCode" />
            <asp:BoundField DataField="ItemName" HeaderText="<%$ Resources:lang, ItemsName %>" HeaderStyle-Width="170px" SortExpression="ItemName" />
            <asp:BoundField DataField="ItemSpec" HeaderText="<%$ Resources:lang, ItemModel %>" HeaderStyle-Width="320px" SortExpression="ItemSpec" />
            <asp:BoundField DataField="CPN" HeaderText="<%$ Resources:lang, CustomerPartNumber %>" HeaderStyle-Width="120px" SortExpression="CPN" />
            <asp:BoundField DataField="ShelfLife" HeaderText="质保期(天)" HeaderStyle-Width="80px" SortExpression="ShelfLife" />
            <asp:BoundField DataField="ItemType" HeaderText="产品来源类型" HeaderStyle-Width="90px" SortExpression="ItemType" />
            <asp:BoundField DataField="Site" HeaderText="<%$ Resources:lang, Site %>" HeaderStyle-Width="65px" SortExpression="Site" />
            <asp:BoundField DataField="ItemRev" HeaderText="<%$ Resources:lang, Revision %>" HeaderStyle-Width="50px" SortExpression="ItemRev" />
            <asp:BoundField DataField="LotSize" HeaderText="每批次数量" HeaderStyle-Width="60px" SortExpression="LotSize" />
            <asp:BoundField DataField="Status" HeaderText="<%$ Resources:lang, ItemStatus %>" HeaderStyle-Width="80px" SortExpression="Status" />
            <asp:BoundField DataField="IsMESadd" HeaderText="ERP/MES" HeaderStyle-Width="80px" SortExpression="IsMESadd" />
            <asp:BoundField DataField="CreateBy" HeaderText="<%$ Resources:lang,CreateBy %>" HeaderStyle-Width="70px" SortExpression="CreateBy" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="<%$ Resources:lang,CreateDateTime %>" HeaderStyle-Width="150px" SortExpression="CreateDateTime" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>    
            <asp:BoundField DataField="ModifyBy" HeaderText="<%$ Resources:lang,ModifyBy %>" HeaderStyle-Width="70px" SortExpression="ModifyBy" />
            <asp:BoundField DataField="ModifyDateTime" HeaderText="<%$ Resources:lang,ModifyDateTime %>" HeaderStyle-Width="150px" SortExpression="ModifyDateTime" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>             

        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Product.BLL.Item"
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
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Product/ItemEdit.aspx?name=Product_ItemAdd&ID=-1";
            dialog({ title: "<%=Resources.Pages.Product_ItemAdd %>", src: openWinUrl, width: 800, height: 550, resizeable: false });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;

            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Product/ItemEdit.aspx?name=Product_ItemEdit&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.Product_ItemEdit %>", src: openWinUrl, width: 800, height: 550, resizeable: false });
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
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Product/ItemView.aspx?name=Product_ItemView&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.Product_ItemView %>", src: openWinUrl, width: 730, height: 450,resizeable:false });
        }
         //数据下发
        function DataDistributionOperate() {
            var idStr = getRecordIdString();
            if (idStr == "") {
                return false;
            }
            var oname = $.trim(window.localStorage.getItem("OrganizationName"));
            if (oname != "集团总部") {
                alert("事业部不能下发数据!");
                return false;
            }
            //xiang.yan 2024-4-29 根据列号去值，改为根据列名取值
            // 1 改为 ItemCode
            var SerialNumberList = getRecordCellTextsByFiled("ItemCode"); 
            localStorage.setItem("SerialNumberList", SerialNumberList);
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/DataDistribution/CommonHelperDataDistribution.aspx?name=MaterialDataDistributionOperate&pra=1";
            dialog({ title: "数据下发", src: openWinUrl, width: 700, height: 400 });
        }

        function UpdateList(namestr) {
            $("#txtItemName").val(namestr);
            document.forms[0].submit();
        }
        function Refresh() {
            document.forms[0].submit();
        }
        $(function () {
            gridCellsChangeNo = true;
            var oname = $.trim(window.localStorage.getItem("OrganizationName"));
            if (oname) {
                if (oname != "集团总部") {
                    $('div.toolbar-btn[title="数据下发"]').hide();
                    $('div.toolbar-btn[title="数据下发"]').next("div.btn-line").hide();
                }
            } else {
                $('div.toolbar-btn[title="数据下发"]').hide();
                $('div.toolbar-btn[title="数据下发"]').next("div.btn-line").hide();
            }
        })
    </script>
</asp:Content>
