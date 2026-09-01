<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PackageBoxList.aspx.cs" Inherits="SKT.LeanMES.Web.Product.PackageBoxList" MasterPageFile="~/Masters/ListMaster.master" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <div style="text-align: center;">
        <div id="noprtplg" class="Tips">
        </div>
    </div>
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">


        <tr>
            <td class="Label2">
                工单号码
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtShopOrderNo" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
            </td>

            <td class="Label2">
                包装箱号
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtBoxNO" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <div style="text-align: center;">
        <div id="lblMessage" class="Tips">
        </div>
        <div id="lblPt" class="Tips" style="text-align: center">
        </div>
        <div id="info">
        </div>
        <div id="printerHolder">
        </div>
    </div>
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" 
        onrowdatabound="GridView1_RowDataBound">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="ContainerNumber" HeaderText="箱号" ControlStyle-Width="30%" />
            <asp:BoundField DataField="OrderNO" HeaderText="工单号" ControlStyle-Width="30%" />
            <asp:BoundField DataField="StatusId" HeaderText="状态" ControlStyle-Width="10%"/>
            <asp:BoundField DataField="CreateDateTime" HeaderText="创建时间" ControlStyle-Width="30%"/>
            <asp:BoundField DataField="CreateBy" HeaderText="创建人" ControlStyle-Width="30%"/>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Container.BLL.ContainerData"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <asp:HiddenField ID="hdnItemSNTemplate" runat="server" Value="" />
    <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.printer.js"></script>
    <script type="text/javascript">
        isMultiple = false;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");
        NoPrinterPlugin = "<%=Resources.Messages.NoPrinterPlugin %>";
        var labelPrintingPlugin;

        $(document).ready(function () {
            pendPrintPluginDom($("#printerHolder"));
            checkPrintPlugin($("#noprtplg"));
        });

        /*重打印条码*/
        function printBoxSn() {
            $("#lblPt").html("正在打印条码，请稍后...");
            setTimeout(function () {
                var snStr = "";
                if (!isMultiple) {
                    //xiang.yan 2024-4-28  列取值由索引改为列明,菜单已无此页面
                    // 1 改为 ContainerNumber
                    snStr = getOneRecordCellTextByFiled("ContainerNumber");
                }
                else {
                    $("input[name='chkSelect']:checked").each(function () {
                        snStr += $(this)[0].parentElement.parentElement.cells[1].innerText + ",";
                    });
                }
                if (snStr == "") return false;

                var labelContent = $("#<%=this.hdnItemSNTemplate.ClientID %>").val();
                if ($.trim(labelContent) == "") {
                    alert("标签模板加载失败，您将无法打印条码!");
                    return false;
                }
                labelPrintingPlugin = document.getElementById("labelPrintingPlugin");

                if (snStr.indexOf(",") > -1) {
                    snStr = snStr.substring(0, snStr.length - 1);
                    var lableArr = snStr.split(",");
                    for (var i = 0; i < lableArr.length; i++) {

                        labelContent = $("#<%=this.hdnItemSNTemplate.ClientID %>").val();
                        labelContent = labelContent.replace("%SN1%", lableArr[i]).replace("%SN1_1%", lableArr[i]);

                        labelContent = labelContent.replace("%SN1BEGIN%", "");
                        labelContent = labelContent.replace("%SN1END%", "");

                        doPrintGrn(labelPrintingPlugin, labelContent);
                    }
                }
                else {
                    labelContent = $("#<%=this.hdnItemSNTemplate.ClientID %>").val();
                    labelContent = labelContent.replace("%SN1%", snStr).replace("%SN1_1%", snStr);

                    labelContent = labelContent.replace("%SN1BEGIN%", "");
                    labelContent = labelContent.replace("%SN1END%", "");

                    doPrintGrn(labelPrintingPlugin, labelContent);
                }

                $("#lblPt").html(snStr + "打印条码完成");
                setTimeout(function () { $("#lblPt").html(""); }, 2000);
            }, 100);
        }
    </script>
</asp:Content>
