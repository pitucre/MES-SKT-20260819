<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/ListMaster.master"
    CodeBehind="CustomerList.aspx.cs" Inherits="SKT.LeanMES.Web.Customer.CustomerList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">
                客户简称
            </td>
            <td class="Field2">
                <input type="text" id="txtCustomerName" class="TextBox" runat="server" />
            </td>
            <td class="Label2">
                客户编码
            </td>
            <td class="Field2">
                <input type="text" id="txtCustomerCode" class="TextBox" runat="server" />
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server">
        <Columns>
            <asp:BoundField DataField="CustomerName" HeaderText="客户简称" HeaderStyle-Width="160px"
                SortExpression="CustomerName" />
            <asp:BoundField DataField="Remark" HeaderText="客户全称" HeaderStyle-Width="160px" />
            <asp:BoundField DataField="CustomerCode" HeaderText="客户编码" HeaderStyle-Width="160px" SortExpression="CustomerCode"/>
            <asp:BoundField DataField="Country" HeaderText="国籍" HeaderStyle-Width="70px" SortExpression="Country" />
            <asp:BoundField DataField="StateProvince" HeaderText="省" HeaderStyle-Width="70px"
                SortExpression="StateProvince" />
            <asp:BoundField DataField="City" HeaderText="城市" HeaderStyle-Width="90px" SortExpression="City" />
            <asp:BoundField DataField="Postal" HeaderText="邮编" HeaderStyle-Width="70px" />
            <asp:BoundField DataField="EmailAddress" HeaderText="电子邮箱" SortExpression="EmailAddress" HeaderStyle-Width="130px"/>
            <asp:BoundField DataField="ModifyBy" HeaderText="修改人" SortExpression="ModifyBy" />
            <asp:BoundField DataField="ModifyDateTime" HeaderText="修改时间" SortExpression="ModifyDateTime" HeaderStyle-Width="140px"  DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Customer.BLL.Customer"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script language="javascript" type="text/javascript">
        isMultiple = false;
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");
        var dialogWith = 620;
        var dialogHeight = 450;

        //增加 
        function Add()
        {
            dialog({ title: mesLang("新增客户信息"), src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Customer/CustomerEdit.aspx?name=Customer_CustomerAdd&ID=-1", width: dialogWith, height: dialogHeight, resizeable: true });
        }

        //编辑
        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return;
            dialog({ title: mesLang("编辑客户信息"), src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Customer/CustomerEdit.aspx?name=Customer_CustomerEdit&ID=" + idStr, width: dialogWith, height: dialogHeight, resizeable: true });
        }

        //删除
        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }

        //查看
        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return;
            dialog({ title: mesLang("查看客户信息"), src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Customer/CustomerView.aspx?name=Customer_CustomerView&ID=" + idStr, width: dialogWith, height: dialogHeight, resizeable: true });
        }

        function UpdateList(strName) {
            $("#<%=this.txtCustomerName.ClientID %>").val(strName);
            document.forms[0].submit();
        }

        function Copy() {
            var idStr = getOneRecordId();
            if (idStr == "") return;
            dialog({ title: mesLang("复制客户信息"), src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Customer/CustomerEdit.aspx?name=Customer_CustomerEdit&ID=" + idStr + "&Action=Copy", width: dialogWith, height: dialogHeight, resizeable: true });

        }
        function Refresh() {
            document.forms[0].submit();
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
            // 3 改为 CustomerCode
            var CustomerNumberList = getRecordCellTextsByFiled("CustomerCode"); 
            localStorage.setItem("CustomerNumberList", CustomerNumberList);
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/DataDistribution/CommonHelperDataDistribution.aspx?name=CustomerDataDistributionOperate&pra=1";
            dialog({ title: "数据下发", src: openWinUrl, width: 700, height: 400 });
        }
        $(function () {
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
