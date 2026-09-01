<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="SupplierIQCList.aspx.cs" Inherits="SKT.LeanMES.Web.SuplyMaterial.SupplierIQCList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">采购订单号</td>
            <td class="Field3">
                <asp:TextBox ID="txtpOCode" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">
                物料编码
            </td>
           <%-- <td class="Field3">
                <asp:TextBox runat="server" ID="txtItemCode" CssClass="TextBox"></asp:TextBox>
                <input type="button" value="..." class="ButtonBox"
                            onclick="chooseMaterial()" />
            </td>--%>
            <td class="Field3">
                <asp:TextBox ID="txtItemCode" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">采购员</td>
            <td class="Field3">
                <asp:TextBox ID="txtLoweredUserName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>  
        </tr>
        <tr>
            <td class="Label3">
                送货单号
            </td>
            <td class="Field3">
                <asp:TextBox runat="server" ID="txtDeliNo" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3" name="supplier">
                供应商代码
            </td>
            <td class="Field3" name="supplier">
                <asp:TextBox runat="server" ID="txtSuplierCode" CssClass="TextBox" ></asp:TextBox>
                <input type="button" value="..." class="ButtonBox" onclick="chooseVendor(34)" />
            </td>
            <td class="Label3">
                IQC检验结果
            </td>
            <td class="Field3">
                <select name="selInspectionResult" id="selInspectionResult" runat="server">
                    <option value="" selected="selected">请选择</option>
                    <option value="1">合格</option>
                    <option value="0">不合格</option>
                </select>
            </td>
        </tr>
        <tr>
            <td class="Label3">
                IQC判定结果方式
            </td>
            <td class="Field3">
                <select name="selManageResult" id="selManageResult" runat="server">
                    <option value="-1" selected="selected">请选择</option>
                    <option value="-3">待处理</option>
                    <option value="2">批量退货</option>
                    <option value="3">特采</option>
                    <option value="4">挑选</option>
                </select>
            </td>
            <td class="Label3"></td>
            <td class="Field3"></td>
            <td class="Label3"></td>
            <td class="Field3"></td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
<div id="divList" style="overflow: auto;">
    <asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server">
        <Columns>
            <asp:BoundField DataField="POCode" HeaderText="采购订单号" SortExpression="POCode"/>
            <asp:BoundField DataField="DeliverNo" HeaderText="送货单号" SortExpression="DeliverNo"/>
            <asp:BoundField DataField="ItemCode" HeaderText="物料编码" SortExpression="ItemCode"/>
            <asp:BoundField DataField="ItemName" HeaderText="物料名称"/>
            <asp:BoundField DataField="VendorCode" HeaderText="供应商代码" SortExpression="VendorCode"/>
            <asp:BoundField DataField="VendorName" HeaderText="供应商名称"/>
              <asp:TemplateField HeaderText="收货数量" SortExpression="InspectionQty"  HeaderStyle-Width="100px">
                <ItemTemplate>
                    <%#Eval("InspectionQty","{0:G0}").ToString() %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="InspectionResultName" HeaderText="IQC检验结果" SortExpression="InspectionResult"/>
            <asp:BoundField DataField="ManageResultName" HeaderText="IQC判定结果方式" SortExpression="ManageResult"/>
                 <asp:TemplateField HeaderText="合格数量" SortExpression="ReceiveQty"  HeaderStyle-Width="100px">
                <ItemTemplate>
                    <%#Eval("ReceiveQty","{0:G0}").ToString() %>
                </ItemTemplate>
            </asp:TemplateField>
                 <asp:TemplateField HeaderText="不合格数量" SortExpression="NoQty"  HeaderStyle-Width="100px">
                <ItemTemplate>
                    <%#Eval("NoQty","{0:G0}").ToString() %>
                </ItemTemplate>
            </asp:TemplateField>
         
        </Columns>
    </asp:GridView>
    
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.AjaxCommon.DBService"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    </div>
    <asp:HiddenField ID="hdnOperate" runat="server" ClientIDMode="Static"/>
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script type="text/javascript">
        isMultiple = false;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");
        //$("#MultipleDiv").hide();
        $(function () {
            var divHeight = 0;
            divHeight = window.innerHeight;
            divHeight = divHeight - 150;
            $("#divList").css('height', divHeight + 'px');
            //$("#MultipleDiv").hide();

            if("<%= SKT.LeanMES.Web.AccountController.GetCurrentUser().UserType%>" != "-1"){
                $("td[name='supplier']").hide();
            }
        });
        //导出
        function Import() {
            hdnOperate.val("exportExcel");
            document.forms[0].submit();
            hdnOperate.val("");
        }
        //查看不良描述
        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            dialog({ title: mesLang("查看窗口"), src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Material/MaterialIQCView.aspx?IQCBatchId=" + idStr, width: 800, height: 300 });
        }

        //选中供应商
       function chooseVendor(falg) {
           dialog({
               title: "<%=Resources.Common.ChooseWindow %>",
               src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=" + falg + "&CallBackFunc=setVendor&Multiple=false&rnd=" + Math.random(), width: 650, height: 350
            });
        }
        //供应商返回的值
        function setVendor(list) {
            $("#<%=this.txtSuplierCode.ClientID %>").val(list[0][1]);
            
        }

        function chooseMaterial() {
            chooseFlag = 1;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=1&Multiple=false&rnd=" + Math.random(), width: 650, height: 350 });
        }

        /*获取物料信息*/
        function getChooseValue(list) {
            $("#<%=this.txtItemCode.ClientID %>").val(list[0][2]);
        }

    </script>
</asp:Content>

