<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MaterialInStorage.aspx.cs"
    MasterPageFile="~/Masters/ListMaster.master" Inherits="SKT.LeanMES.Web.Material.MaterialInStorage" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">
                检验单号
            </td>
            <td class="Field3">
                <asp:TextBox runat="server" ID="txtIQCNo" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">
                物料编码
            </td>
            <td class="Field3">
                <asp:TextBox runat="server" ID="txtItemCode" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">
                采购单号
            </td>
            <td class="Field3">
                <asp:TextBox runat="server" ID="txtPOCode" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label3">
                IQC检验结果
            </td>
            <td class="Field3" >
                <select name="selInspectionResult" id="selInspectionResult" runat="server">
                    <option value="">全部</option>
                    <option value="0">不合格</option>
	                <option value="1">合格</option>
                </select>
            </td>
            <td class="Label3">
                IQC判定结果方式
            </td>
            <td class="Field3">
                <select name="selIQCType" id="ddlIQCStatus" runat="server">
                    <option value="-1">全部</option>
                    <option value="-3">待处理</option>
	                <option value="2">批量退货</option>
	                <option value="3">特采</option>
	                <option value="4">挑选</option>
                </select>
            </td>
            <td class="Label3">
            </td>
             <td class="Field3">
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server" OnRowDataBound="GridView1_RowDataBound" style="table-layout:fixed;word-wrap:break-word;word-break:break-all">
        <Columns>
            <asp:BoundField DataField="InspectionNo" HeaderText="检验单号" HeaderStyle-Width="140px"/>
            <asp:BoundField DataField="POCode" HeaderText="采购单号" HeaderStyle-Width="140px"/>
            <asp:BoundField DataField="DeliverNo" HeaderText="送货单" HeaderStyle-Width="140px"/>
            <asp:BoundField DataField="ItemCode" HeaderText="物料编码" HeaderStyle-Width="140px"/>
            <asp:BoundField DataField="ItemName" HeaderText="物料名称" HeaderStyle-Width="140px"/>
            <asp:BoundField DataField="ItemSpec" HeaderText="规格" HeaderStyle-Width="240px"/>
            
            <asp:TemplateField HeaderText="检验单数量" SortExpression="InspectionQty"  HeaderStyle-Width="80px">
                <ItemTemplate>
                      <%#Eval("InspectionQty","{0:G0}").ToString().IndexOf("E")>-1?Eval("InspectionQty","{0:G}").ToString():Eval("InspectionQty","{0:G0}").ToString() %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="合格数量" SortExpression="QualifiedQty"  HeaderStyle-Width="80px">
                <ItemTemplate>
                      <%#Eval("QualifiedQty","{0:G0}").ToString().IndexOf("E")>-1?Eval("QualifiedQty","{0:G}").ToString():Eval("QualifiedQty","{0:G0}").ToString() %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="入库数量" SortExpression="StorageQty"  HeaderStyle-Width="80px">
                <ItemTemplate>
                    <%#Eval("StorageQty","{0:G0}").ToString().IndexOf("E")>-1?Eval("StorageQty","{0:G}").ToString():Eval("StorageQty","{0:G0}").ToString() %>
                </ItemTemplate>
            </asp:TemplateField>
            
           <%-- <asp:TemplateField HeaderText="检验单数量" HeaderStyle-Width="80px">
                <ItemTemplate>
                    <%# float.Parse(Eval("InspectionQty").ToString()).ToString()%>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="合格数量" HeaderStyle-Width="80px">
                <ItemTemplate>
                    <%# float.Parse(Eval("QualifiedQty").ToString()).ToString()%>
                </ItemTemplate>
            </asp:TemplateField>--%>
            <asp:BoundField DataField="SuplierCode" HeaderText="供应商编码" HeaderStyle-Width="80px"/>
            <asp:BoundField DataField="VendorName" HeaderText="供应商名称" HeaderStyle-Width="170px"/>
            <%--<asp:BoundField DataField="IsGRN" HeaderText="是否条码管控" HeaderStyle-Width="90px"/>--%>
            <asp:BoundField DataField="InspectionResult" HeaderText="检验结果" HeaderStyle-Width="80px"/>
            <asp:BoundField DataField="CheckType" HeaderText="处理结果" HeaderStyle-Width="80px"/>
            <asp:BoundField DataField="StorageBy" HeaderText="最后操作人" HeaderStyle-Width="80px"/>
            <asp:BoundField DataField="StorageTime" HeaderText="最后操作时间" HeaderStyle-Width="140px"/>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Material.BLL.MaterialIQC"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <input type="hidden" id="isNeedConfirm" value="1" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.material.js"
        type="text/javascript"></script>
    <script language="javascript" type="text/javascript">

        $(function () {
            gridCellsChangeNo = true;
            $("#isNeedConfirm").val(IsStorageConfirm); //1需要入库确认  2：不需要
            $("#ckbMultipleSelected").parent().css("display", "none");//此列表去除多选
        });
        //数量入库
        //无GRN入库
        function Store() {
            var idStr = getOneRecordId();
            if (idStr == "") {
                return;
            }

            //xiang.yan 2024-4-28  列取值由索引改为列明,功能已去除
            // 11 改为 IsGRN 列已注释
            var result = getOneRecordCellTextByFiled("IsGRN");
            if (result == "是") {
                alert("该检验单需要扫描物料条码");
                return;
            }
            if (!checkmrbend(idStr)) {
                return;
            }
            if (!window.confirm("确定入库？")) {
                return "";
            }

            dialog({ title: "数量入库", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Material/MaterialStorageWriteLocation.aspx?name=Material_MaterialStorageWriteLocation&ID=" + idStr, width: 550, height: 600 });
        }

        //扫描GRN入库
        function WriteGRN() {
            var idStr = "";
            //var idStr = getOneRecordId();
            //if (idStr == "") {
            //    return;
            //}

            //var result = getOneRecordCellTextByFiled("IsGRN");
            //if (result == "否") {
            //    alert("该检验单不需要扫描物料条码");
            //    return;
            //}

            //if (!checkmrbend(idStr)) {
            //    return;
            //}

            //if (!window.confirm("确定入库？")) {
            //    return "";
            //}

            dialog({ title: mesLang("扫描物料条码入库"), src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Material/MaterialStorageGRNInput.aspx?name=Material_MaterialInStorageGRN&ID=" + idStr, width: 900, height: 800 });;
        }

        /*刷新页面*/
        function refresh() {
            document.forms[0].submit();
        }

        function checkmrbend(idStr) {
            debugger;
            var isResult = true;
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.CheckMRBEnd(idStr);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                isResult = false;
            }
            return isResult;
        }
    </script>
</asp:Content>
