<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true"
    CodeBehind="ItemBomList.aspx.cs" Inherits="SKT.LeanMES.Web.Product.ItemBomList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">
                BOM名称
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtItemBomName" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
            </td>
            <td class="Label3">
                <%=Resources.lang.ItemCode %>
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtItemCode" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
            </td>
            <td class="Label3">
                 <%=Resources.lang.Revision%>
            </td>
            <td class="Field3">
               <asp:TextBox ID="txtVersion" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label3">
                <%=Resources.lang.CurrentRevision %>
            </td>
            <td class="Field3">
                 <asp:DropDownList ID="ddlIsCurrentVer" runat="server">  
                 <asp:ListItem Value="-1" Text="所有"></asp:ListItem>               
                <asp:ListItem Value="1" Text="<%$ Resources:lang,Yes %>"></asp:ListItem>
                <asp:ListItem Value="0" Text="<%$ Resources:lang,No %>"></asp:ListItem>
                </asp:DropDownList>
            </td>
            <td class="Label3">
                <%=Resources.lang.Status %>
            </td>
            <td class="Field3">
                <asp:DropDownList ID="ddlStatus" runat="server">  
                <asp:ListItem Value="-1" Text="所有"></asp:ListItem>                
                <asp:ListItem Value="1" Text="<%$ Resources:lang,InUse %>"></asp:ListItem>
                <asp:ListItem Value="0" Text="<%$ Resources:lang,OutOfService %>"></asp:ListItem>
                </asp:DropDownList>
            </td>
            <td class="Label3">
                <%=Resources.lang.Source%>
            </td>
            <td class="Field3">
                 <asp:DropDownList ID="ddlIsMESadd" runat="server">
                    <asp:ListItem Value="-1" Text="所有"> </asp:ListItem>
                    <asp:ListItem Value="1" Text="ERP Down"> </asp:ListItem>
                    <asp:ListItem Value="2" Text="MES Import"> </asp:ListItem>
                    <asp:ListItem Value="3" Text="<%$ Resources:lang,MESCreation %>"> </asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="BomName" HeaderText="BOM名称" SortExpression="BomName" />
            <asp:BoundField DataField="Version" HeaderText="<%$ Resources:lang, Revision %>"
                HeaderStyle-Width="60px" SortExpression="Version" />
            <asp:BoundField DataField="ItemCode" HeaderText="<%$ Resources:lang, ItemCode %>"
                SortExpression="ItemCode" />
            <asp:BoundField DataField="ItemName" HeaderText="<%$ Resources:lang, ItemName %>"
                SortExpression="ItemName" />
            <asp:TemplateField HeaderText="<%$ Resources:lang, Status %>" HeaderStyle-Width="80px"
                SortExpression="State">
                <ItemTemplate>
                    <%#Eval("State").ToString() == "0" ? Resources.lang.OutOfService : Resources.lang.InUse %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="<%$ Resources:lang,CurrentVersion %>" HeaderStyle-Width="80px"
                SortExpression="IsCurrentVer">
                <ItemTemplate>
                    <%#Eval("IsCurrentVer").ToString().ToLower() == "true"? Resources.lang.Yes: Resources.lang.No %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Source" HeaderText="来源" HeaderStyle-Width="60px" SortExpression="Source" />
            <asp:BoundField DataField="CreateBy" HeaderText="<%$ Resources:lang, CreateBy %>" SortExpression="ModifyBy"/>
            <asp:BoundField DataField="CreateDateTime" HeaderText="<%$ Resources:lang, CreateDateTime %>" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" SortExpression="CreateDateTime" />
            <asp:BoundField DataField="ModifyBy" HeaderText="<%$ Resources:lang, ModifyBy %>" SortExpression="ModifyBy"/>
            <asp:BoundField DataField="ModifyDateTime" HeaderText="<%$ Resources:lang, ModifyDateTime %>" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" SortExpression="ModifyDateTime" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Product.BLL.ItemBom"
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
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Product/ItemBomEdit.aspx?name=Product_BomAdd&ID=-1";
            dialog({ title: "<%=Resources.Pages.Product_BomAdd %>", src: openWinUrl, width: 800, height: 500 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;

            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Product/ItemBomEdit.aspx?name=Product_BomEdit&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.Product_BomEdit %>", src: openWinUrl, width: 800, height: 500 });
        }

        function Import() {            
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Product/ItemBomImport.aspx?name=Product_BomImport";
            dialog({ title: "<%=Resources.Pages.Product_BomImport %>", src: openWinUrl, width: 800, height: 500 });
        }

        function Synchro() {            
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Product/ItemBomSynchro.aspx?name=Product_BomSynchro" ;
            dialog({ title: "<%=Resources.Pages.Product_BomSynchro %>", src: openWinUrl, width: 800, height: 500 });
        }

        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Product/ItemBomView.aspx?name=Product_BomView&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.Product_BomView %>", src: openWinUrl, width: 800, height: 500 });
        }

        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }

        function UpdateList(namestr) {
            $("#txtItemBomName").val(namestr);
            document.forms[0].submit();
        }

        function Struct() {
            var idStr = getOneRecordIdOnly();
            idStr = (idStr == "") ? -1 : idStr;        
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Product/ItemBomStrut.aspx?name=Product_BomStruct&ID=" + idStr;
            window.parent.openTab(this, '<%=Resources.Pages.Product_BomStruct %> ', openWinUrl, Date.parse(new Date()), '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/theme/Metro/Images/Icon/openrouter.png');
        }

        function Copy() {
            var idStr = getOneRecordId();
            if (idStr == "") return;
            dialog({ title: "<%=Resources.Pages.Product_BomCopy %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Product/ItemBomEdit.aspx?name=Product_BomEdit&ID=" + idStr + "&Action=Copy", width: 690, height: 400, resizeable: true });

        }

        function SusItemEdit() {
            var idStr = getOneRecordId();
            if (idStr == "") return;
            dialog({ title: "<%=Resources.Pages.Product_SubsItem %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Product/ItemBomSubsItemEdit.aspx?name=Product_SubsItem&ID=" + idStr, width: 690, height: 400, resizeable: true });
        }
    </script>
</asp:Content>
