<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="True"
    CodeBehind="PurOrderList.aspx.cs" Inherits="SKT.LeanMES.Web.Material.PurOrderList" Title="PurOrder List" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" Runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
       <tr>
            <td class="Label3">
                <%=Resources.lang.POCode%>
            </td>
            <td class="Field3" >
                <asp:TextBox ID="txtPOCode" runat="server"></asp:TextBox>
            </td>
<%--           <td class="Label3">
                <%=Resources.lang.ProjectNo%>
            </td>
            <td class="Field3" >
                <asp:TextBox ID="txtProjectNo" runat="server"></asp:TextBox>
            </td>--%>
            <td class="Label3">
                状态
            </td>
            <td class="Field3" >
                <asp:DropDownList ID="ddlOpenDataStatus" runat="server" ClientIDMode="Static">
                    <asp:ListItem Value="">全部</asp:ListItem>
                    <asp:ListItem Value="9">未关闭</asp:ListItem>
                    <asp:ListItem Value="10">已关闭</asp:ListItem>
                </asp:DropDownList> 
            </td>
           <td class="Label3 Supplier">
                <%=Resources.lang.Supplier%>
            </td>
            <td class="Field3 Supplier" >
                <input type="text" value="" id="txtVendorName" isrequired="1" runat="server" readonly="readonly" style="width: 160px;" />
                <input type="button" value="..." class="ButtonBox" onclick="chooseVendor(34)" />
                  <input type="hidden" value="-1" id="hdnVenID" runat="server" />
                <input type="hidden" value="-1" id="hdnVendorCode" runat="server" />
            </td>
        </tr>
        <tr>
            <td class="Label3">
                订单类型
            </td>
            <td class="Field3">
                <asp:DropDownList ID="selPoType" runat="server" ClientIDMode="Static">
                    <asp:ListItem Value="">全部</asp:ListItem>
                    <asp:ListItem Value="采购订单">采购订单</asp:ListItem>
                    <asp:ListItem Value="委外订单">委外订单</asp:ListItem>
                    <asp:ListItem Value="客供料">客供料</asp:ListItem>
                </asp:DropDownList>  
            </td>
            <td class="Label3">
                收货方式
            </td>
            <td class="Field3">
                <asp:DropDownList ID="selReceiveType" runat="server" ClientIDMode="Static">
                    <asp:ListItem Value="">全部</asp:ListItem>
                    <asp:ListItem Value="厂商直送">厂商直送</asp:ListItem>
                    <asp:ListItem Value="工厂自取">工厂自取</asp:ListItem>
                </asp:DropDownList>  
            </td>
            <td class="Label3">
                来源
            </td>
            <td class="Field3" >
                <asp:DropDownList runat="server" ID="ddlIsMesAdd" ClientIDMode="Static">
                            <asp:ListItem Value="-1" Selected="True" Text="请选择"></asp:ListItem>
                            <asp:ListItem Value="0" Text="ERP"></asp:ListItem>
                            <asp:ListItem Value="1" Text="MES"></asp:ListItem>
                        </asp:DropDownList>

            </td>
        </tr>
        <tr>
            
             <td class="Label3">
                下单时间
            </td>
            <td class="Field3">
                <input type="text" id="txtDateFrom" class="DateTimeBox" runat="server" />
                -
                <input type="text" id="txtDateTo" class="DateTimeBox" runat="server" />
            </td>
           
            <td class="Label3">
                交期维护
            </td>
            <td class="Field3">
                <asp:DropDownList ID="ddlSupplierDelivery" runat="server" ClientIDMode="Static">
                    <asp:ListItem Value="">全部</asp:ListItem>
                    <asp:ListItem Value="未维护">未维护</asp:ListItem>
                    <asp:ListItem Value="已维护">已维护</asp:ListItem>
                </asp:DropDownList>   
            </td>
            <td class="Label3">
                创建人
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtUserName" runat="server"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" Runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" style="table-layout:fixed;word-wrap:break-word;word-break:break-all" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="POTypeName" HeaderText="采购类型"  SortExpression="POType"  HeaderStyle-Width="120px"/>
            <asp:BoundField DataField="ReceiveType" HeaderText="收货方式"  SortExpression="ReceiveType"  HeaderStyle-Width="100px"/>
            <asp:BoundField DataField="POCode" HeaderText="<%$Resources:lang,POCode %>"  SortExpression="POCode"  HeaderStyle-Width="170px"/>
            <asp:BoundField DataField="VenCode" HeaderText="<%$Resources:lang,SupplierCode %>"  SortExpression="VenCode" HeaderStyle-Width="100px"/>
        <asp:BoundField DataField="VendorName" HeaderText="<%$Resources:lang,Supplier %>"  SortExpression="VendorName" HeaderStyle-Width="180px"/>
        <asp:BoundField DataField="VenUserName" HeaderText="<%$Resources:lang,SupplierUserName %>" HeaderStyle-Width="100px"/>
        <asp:BoundField DataField="VenPhone" HeaderText="<%$Resources:lang,SupplierPhone %>" HeaderStyle-Width="100px"/>
       <%-- <asp:BoundField DataField="ProjectNo" HeaderText="<%$Resources:lang,ProjectNo %>" HeaderStyle-Width="80px"/>--%>
        <asp:BoundField DataField="OrderDate" HeaderText="<%$Resources:lang,OrderDate %>"  DataFormatString="{0:yyyy-MM-dd}" HeaderStyle-Width="100px"/> 
       <asp:BoundField DataField="CreateByCName" HeaderText="<%$Resources:lang,CreateBy %>" HeaderStyle-Width="60px" />
        <asp:BoundField DataField="CreateDateTime" HeaderText="<%$Resources:lang,CreateDateTime %>"  DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" HeaderStyle-Width="150px" /> 
            <asp:BoundField DataField="ModifyBy" HeaderText="<%$Resources:lang,ModifyBy %>" HeaderStyle-Width="60px" />
        <asp:BoundField DataField="ModifyDateTime" HeaderText="<%$Resources:lang,ModifyDateTime %>"  DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" HeaderStyle-Width="150px" /> 
           <asp:BoundField DataField="IsMesAddName" HeaderText="来源" HeaderStyle-Width="60px" SortExpression="IsMesAdd" />
 <%-- <asp:TemplateField HeaderText="" HeaderStyle-Width="60px" SortExpression="IsMesAdd">
     <ItemTemplate>
         <%#Eval("IsMesAdd").ToString()=="0"?"ERP":"MES" %>
     </ItemTemplate>
 </asp:TemplateField>--%>
            <asp:BoundField DataField="SupplierDelivery" HeaderText="交期维护"   HeaderStyle-Width="80px"/>
            <asp:BoundField DataField="OpenDataStatusName" HeaderText="状态"   HeaderStyle-Width="80px"/>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" 
        StartRowIndexParameterName="startRow" MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" 
        TypeName="SKT.LeanMES.Material.BLL.PurOrder" SelectMethod="GetPurOrderList" SelectCountMethod="GetCount">
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
        var isShowSupply=<%=new SKT.Common.Account.BLL.Users().GetByName(SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName).UserType%>;
        console.log(isShowSupply);
        $(function(){
            if(isShowSupply>0){
                $(".Supplier").remove();
            }
        })
        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Material/PurOrderEdit.aspx?name=Material_PurOrderAdd&ID=-1";
            dialog({ title: "<%= Resources.Pages.Material_PurOrderAdd %>", src: openWinUrl, width: 1000, height: 500 });
        }

        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") {
                return false;
            }
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Material/PurOrderView.aspx?name=PurOrderView&ID=" + idStr;
            dialog({ title: "<%= Resources.lang.PurOrderView%>", src: openWinUrl, width: 1300, height: 500 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Material/PurOrderEdit.aspx?name=Material_PurOrderEdit&ID=" + idStr;
            dialog({ title: "<%= Resources.Pages.Material_PurOrderEdit %>", src: openWinUrl, width: 1300, height: 500 });
        }

        function Delete() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            if (confirm('确定要删除吗？')) {
                hdnOperate.val("delete");
                hdnIdString.val(idStr);
                document.forms[0].submit();
            }
        }



       //选中供应商
       function chooseVendor(falg) {
           dialog({
               title: "<%=Resources.Common.ChooseWindow %>",
                src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=" + falg + "&Multiple=false&rnd=" + Math.random(), width: 650, height: 350
            });
        }
        //供应商返回的值
        function getChooseValue(list) {
            $("#<%=this.hdnVenID.ClientID %>").val(list[0][0]);
            $("#<%=this.hdnVendorCode.ClientID %>").val(list[0][1]);
            $("#<%=this.txtVendorName.ClientID %>").val(list[0][2]);
            
        }


        function Refresh(pocode) {
            $("#<%=this.txtPOCode.ClientID%>").val(pocode);
            document.forms[0].submit();
        }
             //导出PDF
        function PdfPrint() {

            var idStr = getRecordIdString();
            if (idStr == "") {
                return false;
            }
      
            window.open("<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Material/MaterialPurchaseDeliFormPrint.aspx?name=AllMaterialHistoryPDF&ID=" + idStr); 
        }
        
    </script>
</asp:Content>