<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/ListMaster.master"
    CodeBehind="ResourceList.aspx.cs" Inherits="SKT.LeanMES.Web.Resource.ResourceList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2" >
                <%=Resources.lang.ResName %>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtResName" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
            </td>
             
            <td class="Label2" >
                线别
            </td>
            <td class="Field2">
                 <asp:TextBox ID="txtLineName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>                  
            
        </tr>
        <tr>
            <td class="Label2" >
                资源类型
            </td>
             <td class="Field2">
                 <asp:TextBox ID="txtResTypeName" runat="server" CssClass="TextBox"></asp:TextBox>
             </td>

            <td class="Label2" >
                <%=Resources.lang.Status %>
            </td>
            <td class="Field2" style="width:40px;">
                <asp:DropDownList runat="server" ID="ddlStatus">
                </asp:DropDownList>
            </td> 
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" OnRowDataBound="GridView1_OnRowDataBound">
        <Columns>
            <asp:BoundField DataField="ResName" HeaderText="<%$ Resources:lang,ResName %>" SortExpression="ResName"
                HeaderStyle-Width="180px" />
            <asp:BoundField DataField="ResTypeName" HeaderText="<%$ Resources:lang,ResTypeName %>" SortExpression="ResTypeName"
                HeaderStyle-Width="180px" />
            <asp:BoundField DataField="ResStatus" HeaderText="<%$ Resources:lang,Status %>" SortExpression="ResStatus"
                HeaderStyle-Width="80px" />
            <asp:BoundField DataField="LineName" HeaderText="<%$ Resources:lang,Line %>" SortExpression="LineName"
                HeaderStyle-Width="120px" />
            <asp:BoundField DataField="Face" HeaderText="面别" SortExpression="Face"
                HeaderStyle-Width="120px" />
            <asp:BoundField DataField="EquipmentName" HeaderText="设备名称" SortExpression="EquipmentName"
                HeaderStyle-Width="120px" />
            <asp:BoundField DataField="ValidStartTime" HeaderText="资源有效期"
                DataFormatString="{0:d}" HtmlEncode="false" HeaderStyle-Width="180px" />
            <asp:BoundField DataField="CreateBy" HeaderText="<%$ Resources:lang, CreateBy %>" HeaderStyle-Width="120px"/>
            <asp:BoundField DataField="CreateDateTime" HeaderText="<%$ Resources:lang, CreateDateTime %>" HeaderStyle-Width="150px" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>
            <asp:BoundField DataField="ResDescription" HeaderText="<%$ Resources:lang,Description %>" />
            <asp:BoundField DataField="ModifyBy" HeaderText="<%$ Resources:lang, ModifyBy %>" HeaderStyle-Width="120px"/>
            <asp:BoundField DataField="ModifyDateTime" HeaderText="<%$ Resources:lang, ModifyDateTime %>" HeaderStyle-Width="150px" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Resource.BLL.Resource"
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
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Resource/ResourceEdit.aspx?name=Resource_ResourceAdd&ID=-1";
            dialog({ title: "<%=Resources.Pages.Resource_ResourceAdd %>", src: openWinUrl, width: 750, height: 450 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Resource/ResourceEdit.aspx?name=Resource_ResourceEdit&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.Resource_ResourceEdit %>", src: openWinUrl, width: 750, height: 450 });
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
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Resource/ResourceView.aspx?name=Resource_ResourceView&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.Resource_ResourceView %>", src: openWinUrl, width: 650, height: 450 });
        }
        function UpdateList(namestr) {
            $("#txtResName").val(namestr);
            document.forms[0].submit();
        }

        function Copy() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Resource/ResourceEdit.aspx?name=Resource_ResourceEdit&ID=" + idStr + "&Action=Copy&rnd=" + Math.random();
            dialog({ title: "<%=Resources.Buttons.COM_Copy %>资源", src: openWinUrl, width: 650, height: 450 });
        }

    
    </script>
</asp:Content>
