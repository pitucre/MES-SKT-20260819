<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true"
    CodeBehind="SupplierList.aspx.cs" Inherits="SKT.LeanMES.Web.Supplier.SupplierList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">
                <%=Resources.lang.VendorCode %>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtVendorCode" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label2">
                <%=Resources.lang.VendorName %>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtVendorName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
              <tr>
            <td class="Label2">
                <%=Resources.lang.VendorSort %>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtVendorSort" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label2">
               来源
            </td>
            <td class="Field2">
                <asp:DropDownList runat="server" ID="ddlIsMesAdd" ClientIDMode="Static">
                            <asp:ListItem Value="-1" Selected="True" Text="请选择"></asp:ListItem>
                            <asp:ListItem Value="0" Text="ERP"></asp:ListItem>
                            <asp:ListItem Value="1" Text="MES"></asp:ListItem>
                        </asp:DropDownList>

            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <asp:BoundField DataField="VendorCode" HeaderText="<%$Resources:lang,VendorCode %>" HeaderStyle-Width="160px" SortExpression="VendorCode"/>            
            <asp:BoundField DataField="VendorSort" HeaderText="<%$Resources:lang,VendorSort %>" HeaderStyle-Width="230px" SortExpression="VendorSort"/>
            <asp:BoundField DataField="VendorName" HeaderText="<%$Resources:lang,VendorName %>" HeaderStyle-Width="260px" SortExpression="VendorName"/>
            <asp:BoundField DataField="VendorAddress" HeaderText="<%$Resources:lang,VendorAddress %>"/>
            <asp:BoundField DataField="CreateBy" HeaderText="<%$Resources:lang,CreateBy %>" SortExpression="CreateBy"/>
            <asp:BoundField DataField="CreateDateTime" HeaderText="<%$Resources:lang,CreateDateTime %>" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" SortExpression="CreateDateTime"/>
            <asp:BoundField DataField="ModifyBy" HeaderText="<%$ Resources:lang, ModifyBy %>" />
            <asp:BoundField DataField="ModifyDateTime" HeaderText="<%$ Resources:lang, ModifyDateTime %>" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
            <asp:BoundField DataField="DataSource" HeaderText="来源"/>
            <%--<asp:TemplateField HeaderText="来源">
                <ItemTemplate>
                    <%#Eval("IsMesAdd").ToString()=="0"?"ERP":"MES" %>
                </ItemTemplate>
            </asp:TemplateField>--%>
            <asp:BoundField DataField="IsShipmentReport" HeaderText="<%$Resources:lang,IsShipmentReport %>" SortExpression="IsShipmentReport"/>
            <asp:BoundField DataField="IsLaboratoryReport" HeaderText="<%$Resources:lang,IsLaboratoryReport %>" SortExpression="IsLaboratoryReport"/>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Supplier.BLL.Suppliers"
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

        //新增
        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Supplier/SupplierEdit.aspx?name=Supplier_SupplierAdd&Id=-1";
            dialog({ title: "<%=Resources.Pages.Supplier_SupplierAdd %>", src: openWinUrl, width: 660, height: 500 });
        }

        //编辑
        function Edit() {
       
            //陆文元2016-01-13因为从ERP过来的数据暂时不允许修改，所以暂时屏蔽修改
            //zx 2018-06-11 放开编辑功能
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Supplier/SupplierEdit.aspx?name=Supplier_SupplierEdit&Id=" + idStr;
            dialog({ title: "<%=Resources.Pages.Supplier_SupplierEdit %>", src: openWinUrl, width: 660, height: 500 });
        }

        //查看
        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Supplier/SupplierView.aspx?name=Supplier_SupplierView&Id=" + idStr;
            dialog({ title: "<%=Resources.Pages.Supplier_SupplierView %>", src: openWinUrl, width: 670, height:500 });
        }


        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }

        function UpdateList(vendorCode) {
            $("#<%=this.txtVendorCode.ClientID %>").val(vendorCode);
            document.forms[0].submit();
        }

       ///导出
        function Export() {
            hdnOperate.val("exportexcel");
            document.forms[0].submit();
            hdnOperate.val("");
        }

        //分配用户
        function AssignUser() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Supplier/UsersInSupplier.aspx?name=Supplier_AssignUser&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.Supplier_AssignUser %>", src: openWinUrl, width: 750, height: 400 });
        }
        //分配物料
        function AssignItem() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Supplier/ItemsInSupplier.aspx?name=Supplier_AssignItem&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.Supplier_AssignItem %>", src: openWinUrl, width: 750, height: 400 });
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
            // 1 改为 VendorCode
            var SupplierNumberList = getRecordCellTextsByFiled("VendorCode"); 
            localStorage.setItem("SupplierNumberList", SupplierNumberList);
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/DataDistribution/CommonHelperDataDistribution.aspx?name=SupplierDataDistributionOperate&pra=1";
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
