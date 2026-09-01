<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="ContainerWeightList.aspx.cs" Inherits="SKT.LeanMES.Web.Container.ContainerWeightList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
             <td class="Label3">工单号：
            </td>
            <td class="Field3">
                   <asp:TextBox ID="txtOrderNo" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>                    
            </td>
            <td class="Label3">产品编码：
            </td>
            <td class="Field3">

                   <asp:TextBox ID="txtMainItemCode" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox><input
                    type="button" id="btnSelectItem" class="ButtonBox" value="..." title="<%=Resources.lang.ChooseItem %>"
                    onclick="ChoosePage(1);" /> 
                <asp:HiddenField ID="hdnMainItemId" runat="server" Value="-1" />
            </td>
            <td class="Label3">包装类型：
            </td>
            <td class="Field3">
                <asp:DropDownList ID="ddlType" runat="server">
                    <asp:ListItem Value="-1" Text="--请选择--"> </asp:ListItem>
                    <asp:ListItem Value="Item" Text="Item"> </asp:ListItem>
                    <asp:ListItem Value="Box" Text="Box"> </asp:ListItem>
                    <asp:ListItem Value="Container" Text="Container"> </asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
              <asp:BoundField DataField="OrderNO" HeaderText="工单号"  SortExpression="OrderNO" />
            <asp:BoundField DataField="ItemCode" HeaderText="产品编码" SortExpression="ItemCode" />
            <asp:BoundField DataField="PackingType" HeaderText="类型" HeaderStyle-Width="100px" SortExpression="PackingType"   />
            <asp:BoundField DataField="MinWeight" HeaderText="重量最小值" HeaderStyle-Width="140px" />
            <asp:BoundField DataField="MaxWeight" HeaderText="重量最大值" HeaderStyle-Width="140px" />
            <asp:BoundField DataField="UnitName" HeaderText="单位" HeaderStyle-Width="80px" />
            <asp:BoundField DataField="CreateBy" HeaderText="创建人" HeaderStyle-Width="100px" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="创建时间" HeaderStyle-Width="140px" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>
            <asp:BoundField DataField="ModifyBy" HeaderText="修改人" HeaderStyle-Width="100px" />
            <asp:BoundField DataField="ModifyDateTime" HeaderText="修改时间" HeaderStyle-Width="140px" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Container.BLL.ContainerWeight"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script type="text/javascript">
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");
        function ChoosePage(flag) {
            chooseFlag = flag;
            if (chooseFlag == 1) {
                flag = "1";
            }
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=" + flag + "&Multiple=false&rnd=" + Math.random(), width: 550, height: 350 });
        }

        function getChooseValue(list) {
            if (chooseFlag == 1) {
             $("#<%=this.txtMainItemCode.ClientID %>").val(list[0][2]);
                $("#hdnMainItemId").val(list[0][0]);               
            }
        }

        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Container/ContainerWeightEdit.aspx?name=ContainerWeightAdd&ID=-1";
            dialog({ title: mesLang("新增包装重量"), src: openWinUrl, width: 800, height: 400 });
        }


        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return;
            dialog({ title: mesLang("编辑包装重量"), src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Container/ContainerWeightEdit.aspx?name=ContainerWeightEdit&ID=" + idStr, width: 800, height: 400, resizeable: true });
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
    </script>

</asp:Content>
