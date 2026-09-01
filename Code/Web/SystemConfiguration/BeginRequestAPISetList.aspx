<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/ListMaster.master" CodeBehind="BeginRequestAPISetList.aspx.cs" Inherits="SKT.LeanMES.Web.SystemConfiguration.BeginRequestAPISetList" %>


<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>

<asp:Content ID="Content3" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">API请求地址
            </td>
            <td class="Field2">
                <asp:TextBox ID="txttext" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label2">API请求方式
            </td>
            <td class="Field2">
                <asp:DropDownList runat="server" ID="ddlMethod">
                    <asp:ListItem Value="">请选择</asp:ListItem>
                    <asp:ListItem Value="GET">GET</asp:ListItem>
                    <asp:ListItem Value="POST">POST</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1"
        OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="RequestUrl" HeaderText="地址" />
            <asp:BoundField DataField="Deal_Param_Proc" HeaderText="处理参数存储过程" />
            <asp:BoundField DataField="APIUrl" HeaderText="API请求地址" />
            <asp:BoundField DataField="APIMethod" HeaderText="API请求方式" />
            <asp:BoundField DataField="Deal_Result_Proc" HeaderText="处理结果存储过程" />
            <asp:BoundField DataField="Application" HeaderText="请求节点" />
            <asp:BoundField DataField="DealError" HeaderText="异常处理" />
            <asp:BoundField DataField="Remark" HeaderText="备注" />
            <asp:BoundField DataField="ModifyDateTime" HeaderText="修改时间" />
            <asp:BoundField DataField="ModifyBy" HeaderText="修改人" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="创建时间" />
            <asp:BoundField DataField="CreateBy" HeaderText="创建人" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.CustomMenu.BLL.BeginRequestAPISet"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <script type="text/javascript">
        var openWinUrl = "";
        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SystemConfiguration/BeginRequestAPISetEdit.aspx?name=BeginRequestAPISetAdd&id=0";
            dialog({ title: "新增", src: openWinUrl, width: 800, height: 400 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (!idStr)
                return;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SystemConfiguration/BeginRequestAPISetEdit.aspx?name=BeginRequestAPISetEdit&id=" + idStr;
            dialog({ title: "编辑", src: openWinUrl, width: 800, height: 400 });
        }

        function View() {
            Edit();
        }
        function Delete() {
            var idStr = getOneRecordId();
            if (!idStr)
                return;
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialConfig.BeginRequestAPISetDelete(idStr);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            Refresh();
        }
        function Refresh() {
            document.forms[0].submit();
        }
    </script>
</asp:Content>
