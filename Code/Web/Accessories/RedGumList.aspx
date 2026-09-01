<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RedGumList.aspx.cs" Inherits="SKT.LeanMES.Web.Accessories.RedGumList" MasterPageFile="~/Masters/ListMaster.master" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">
                <%=Resources.lang.Accessorie_BARCODE%>
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtAccessorie_BARCODE" runat="server" patterns="AutoComplete" 
                    field="PartNO" minChars="1"></asp:TextBox>
            </td>
            <td class="Label3">
                <%=Resources.lang.Accessorie_PN%>
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtAccessorie_PN" runat="server" patterns="AutoComplete" 
                    field="PartName" minChars="1"></asp:TextBox>
            </td>
            <td class="Label3">
                状态
            </td>
            <td class="Field3">
                <asp:DropDownList runat="server" ID="ddlAccessorieStatus">
                    <asp:ListItem Value="0">所有</asp:ListItem>
                    <asp:ListItem  Value="1">登记</asp:ListItem>
                    <asp:ListItem  Value="2">解冻</asp:ListItem>
                    <asp:ListItem  Value="3">使用</asp:ListItem>
                    <asp:ListItem  Value="4">报废</asp:ListItem>
                    <asp:ListItem  Value="5">回冻</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="searchConditions" runat="server" ContentPlaceHolderID="GridviewContent">
    <asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server">
        <Columns>
            <asp:BoundField DataField="BARCODE" HeaderText="<%$ Resources:lang,Accessorie_BARCODE %>"
                ItemStyle-Width="90px" />
            <asp:BoundField DataField="CREATEDTIME" HeaderText="登记时间"
                ItemStyle-Width="90px" />
            <asp:BoundField DataField="EXPIREDDATE" HeaderText="<%$ Resources:lang,Accessorie_EXPIREDDATE %>"
                ItemStyle-Width="90px" />
            <asp:BoundField DataField="CUR_STATUS" HeaderText="<%$ Resources:lang,Accessorie_CUR_STATUS %>"
                ItemStyle-Width="90px" />
            <asp:BoundField DataField="ItemName" HeaderText="<%$ Resources:lang,Accessorie_PN %>"
                ItemStyle-Width="90px" />
            <asp:BoundField DataField="SoldType" HeaderText="<%$ Resources:lang,Accessorie_SOLD_TYPE %>"
                ItemStyle-Width="90px" />
            <asp:BoundField DataField="QUANTITY" HeaderText="<%$ Resources:lang,Accessorie_QUANTITY %>"
                ItemStyle-Width="90px" />
        </Columns>
    </asp:GridView>

    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Accessories.BLL.SOLDBARCODE"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>

    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script type="text/javascript">

        //登记
        function Register() {
            dialog({ title: "<%= Resources.lang.Accessories_Register %>", src: "RedGumEdit.aspx?name=Accessories_Register&ID=-1", width: 700, height: 350, resizeable: true });
        }


        //解冻
        function Thaw() {
            ///xiang.yan 2024-4-26  列取值由索引改为列明,菜单已无此页面
            //4改为CUR_STATUS
            var nowstatus = getOneRecordCellTextByFiled("CUR_STATUS");
            if (nowstatus == "使用") {
                alert("使用状态时不能再进行解冻.");
                return;
            }

            var idStr = getOneRecordId();
            if (idStr == "") return;
            dialog({ title: "<%= Resources.lang.Accessories_Thaw %>", src: "SolderLogEdit.aspx?name=Accessories_Thaw&ID=" + idStr, width: 500, height: 200, resizeable: true });
        }

        //使用
        function MakeUseOf() {
            var idStr = getOneRecordId();
            if (idStr == "") return;
            dialog({ title: "<%= Resources.lang.Accessories_MakeUseOf %>", src: "SolderLogEdit.aspx?name=Accessories_MakeUseOf&ID=" + idStr, width: 500, height: 360, resizeable: true });
        }

        //冰冻
        function Frost() {
            //xiang.yan 2024-4-26  列取值由索引改为列明,菜单已无此页面
            //1改为BARCODE
            var barcode = getOneRecordCellTextByFiled("BARCODE");

            if (barcode == "") return;
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxServiceSolderLog.AddFrostInfo(barcode);

            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert("回冻成功！");
        }

        function UpdateList() {
            //$("#<%=this.txtAccessorie_BARCODE.ClientID %>").val(DepartmentName);
            document.forms[0].submit();
        }
    </script>
    </asp:Content>