<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/ListMaster.master" CodeBehind="FinishProductInStorageList.aspx.cs" Inherits="SKT.LeanMES.Web.Material.FinishProductInStorageList" %>

 <%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" Runat="Server" >
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
            <tr>
                <td class="Label1">
                    产品序列号：
                </td>
                <td class="Field1" colspan=3>
                    <asp:TextBox ID="txtSN" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
                </td>
             </tr>
               <tr>
                <td class="Label1">
                  入库时间：
                </td>
                <td class="Field1">
                 从<asp:TextBox ID="txtCreateDateTimeStart" runat="server" CssClass="DateTimeBox"></asp:TextBox>
                 到
                <asp:TextBox ID="txtCreateDateTimeEnd" runat="server" CssClass="DateTimeBox"></asp:TextBox>
                </td>
             </tr>

    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" Runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="SN" HeaderText="序列号" />
            <asp:BoundField DataField="Status_cn" HeaderText="状态"/>
            <asp:BoundField DataField="CreateBy" HeaderText="操作人"/>
            <asp:BoundField DataField="createDate" HeaderText="入库时间"/>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" 
        StartRowIndexParameterName="startRow" MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" 
        TypeName="SKT.LeanMES.Material.BLL.FinishProductInStorage" SelectMethod="GetAll" SelectCountMethod="GetCount">
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
        $(document).ready(function () {
            $("#ckbMultipleSelected").parent().hide();
        })
        //入库, 弹出入库页面
        function Add(){
           dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/FinishedProductInStorage/FinishProductInStorageAdd.aspx", width: 350, height: 150 });
          //dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Mobile/FinishedProductInStorage/FinishedProductInStorageAdd.aspx", width: 350, height: 600 });
        }


        var chooseFlag = 0;

        function UpdateList(namestr, station) {
        }

        </script>
</asp:Content>