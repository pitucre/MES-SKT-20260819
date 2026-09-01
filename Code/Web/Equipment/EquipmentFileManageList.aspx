<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="True"
    CodeBehind="EquipmentFileManageList.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.EquipmentFileManageList" Title="EquipmentFileManage List Page" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" Runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1"><%=Resources.lang.EquipmentCode%></td>
            <td class="Field1">
                <asp:TextBox ID="txtEquipmentCode" runat="server" patterns="AutoComplete" source="SPM_PARTS" field="PartNO" minChars="1"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" Runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1">
        <Columns>
            <%-- To Do --%>

            <asp:BoundField DataField="EqCode" HeaderText="<%$ Resources:lang, EquipmentCode %>" />
           <%-- <asp:BoundField DataField="FileName" HeaderText="<%$ Resources:lang, FileName %>" />--%>
            <asp:TemplateField HeaderText="<%$ Resources:lang, FileName %>">  
                <ItemTemplate>
                   <a href='javascript:void(0);' onclick="LoadZhenShu('<%#Eval("FileName")%>')"><%# Eval("FileName") %> </a>  
                </ItemTemplate>  
            </asp:TemplateField>
            <asp:BoundField DataField="CreateBy" HeaderText="<%$ Resources:lang, CreateBy %>" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="创建时间"  DataFormatString="{0:yyyy-MM-dd hh:mm:ss}" />
            <asp:BoundField DataField="ModifyBy" HeaderText="<%$ Resources:lang, ModifyBy %>" />
            <asp:BoundField DataField="ModifyTime" HeaderText="修改时间"  DataFormatString="{0:yyyy-MM-dd hh:mm:ss}" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" 
        StartRowIndexParameterName="startRow" MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" 
        TypeName="SKT.LeanMES.Equipment.BLL.EquipmentFileManage" SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value=""/>
    <input type="hidden" id="hdnIdString" name="hdnIdString"  value=""/>

    <script type="text/javascript">
        isMultiple = false;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");
        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/EquipmentFileManageEdit.aspx?name=EquipmentFileManageListAdd&ID=-1";
            dialog({ title: "<%=Resources.Pages.EquipmentFileManageListAdd %>", src: openWinUrl, width: 700, height: 400});
        }

        function Save() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/EquipmentFileManageEdit.aspx?name=EquipmentFileManageListEdit&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.EquipmentFileManageListEdit %>", src: openWinUrl, width: 700, height: 400 });
        }

        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }

        function Refresh() {
            document.forms[0].submit();
        }
        function LoadZhenShu(data) {
            if (data == "未载入") {
                alert("未上传文件!");
                return false;
            }
            var path = GetFilePath("EquFile", data);
         
            window.open(path);
        }
    </script>
</asp:Content>

