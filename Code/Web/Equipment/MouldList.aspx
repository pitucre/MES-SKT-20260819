<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MouldList.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.MouldList" MasterPageFile="~/Masters/ListMaster.master" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <style>
         .hidden { display:none;}
    </style>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label4"><%=Resources.lang.MouldCode%></td>
            <td class="Field4">
                <asp:TextBox ID="txtEquipmentCode" runat="server" minChars="1"></asp:TextBox>
            </td>
            <td class="Label4"><%=Resources.lang.MouldName%></td>
            <td class="Field4">
                <asp:TextBox ID="txtEquipmentName" runat="server" minChars="1"></asp:TextBox>
            </td>

            <td class="Label4">厂家模具编码</td>
            <td class="Field4">
                <asp:TextBox ID="txtFactoryMouldCode" runat="server" minChars="1"></asp:TextBox>
            </td>
            <td class="Label4">厂家模具名称</td>
            <td class="Field4">
                <asp:TextBox ID="txtFactoryMouldName" runat="server" minChars="1"></asp:TextBox>
            </td>
            
        </tr>
        <tr>
            <%-- <td class="Label2"><%=Resources.lang.ItemCode%></td>
            <td class="Field2">
                <asp:TextBox ID="txtItemCode" runat="server" minChars="1"></asp:TextBox>
                <input type="button" value="..." class="ButtonBox" onclick="selectItem()" />
            </td>--%>
            <td class="Label4">构件名称</td>
            <td class="Field4">
                <asp:TextBox ID="txtComponentName" runat="server" minChars="1"></asp:TextBox>
                <input type="button" value="..." class="ButtonBox" onclick="selectEqType()" />
            </td>
            <td class="Label4"><%=Resources.lang.Supplier%></td>
            <td class="Field4">
                <asp:TextBox ID="txtSupplier" runat="server" minChars="1"></asp:TextBox>
                <input type="button" value="..." class="ButtonBox" onclick="selectSupplier()" />
            </td>
            <td class="Label4">模具状态</td>
            <td class="Field4" colspan="1">
                <select id="sltMouldStatus" runat="server">
                    <option value="">全部</option>
                    <option value="正常">正常</option>
                    <option value="已报废">报废</option>
                </select>
            </td>
            <td class="Label4">是否关联产品</td>
            <td class="Field4" colspan="1">
                <select id="sltRealProduct" runat="server">
                    <option value="">全部</option>
                    <option value="是">是</option>
                    <option value="否">否</option>
                </select>
            </td>
        </tr>
        <tr>
            <td class="Label4">产品编码</td>
            <td class="Field4">
                <asp:TextBox ID="txtItemCode" runat="server" minChars="1"></asp:TextBox>
            </td>
            <td class="Label4">产品名称</td>
            <td class="Field4">
                <asp:TextBox ID="txtItemName" runat="server" minChars="1"></asp:TextBox>
            </td>

            <%--<td class="Label2"><%=Resources.lang.CustomerName%></td>
            <td class="Field2">
                <asp:TextBox ID="txtCustomer" runat="server" minChars="1"></asp:TextBox>
                <input type="button" value="..." class="ButtonBox" onclick="selectCustomer()" />

            </td>--%>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="searchConditions" runat="server" ContentPlaceHolderID="GridviewContent">
    <asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server"  OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <asp:BoundField DataField="EquipmentCode" HeaderText="<%$ Resources:lang,MouldCode %>" ItemStyle-Width="100px" />
            <asp:BoundField DataField="EquipmentName" HeaderText="<%$ Resources:lang,MouldName %>" ItemStyle-Width="100px" />
            <asp:BoundField DataField="FactoryMouldCode" HeaderText="厂家模具编码" ItemStyle-Width="100px" />
            <asp:BoundField DataField="FactoryMouldName" HeaderText="厂家模具名称" ItemStyle-Width="100px" />
            <%--  <asp:BoundField DataField="EquipmentModel" HeaderText="模具型号" ItemStyle-Width="90px" />--%>
            <%--<asp:BoundField DataField="ComponentName" HeaderText="构件名称" ItemStyle-Width="90px" />--%>
            <%--   <asp:BoundField DataField="ItemCode" HeaderText="<%$ Resources:lang,ItemCode %>" ItemStyle-Width="90px" />--%>
            <asp:TemplateField HeaderText="是否在库" SortExpression="InOrOut" ItemStyle-Width="50px">
                <ItemTemplate>
                    <asp:Label CLASS="InOrOut" runat="server"
                        Text='<%#Eval("InOrOut").ToString() == "1" ? "是" : "否"%>'></asp:Label>
                    <%-- <%#Eval("InOrOut").ToString() == "1" ? "是" : "否"%> Bind("InOrOut") --%>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="StoreName" HeaderText="位置" ItemStyle-Width="150px" />
            <asp:BoundField DataField="SupplierName" HeaderText="<%$ Resources:lang,Supplier %>" ItemStyle-Width="150px" />
            <asp:BoundField DataField="CompanyName" HeaderText="公司" ItemStyle-Width="150px" />
            <%--<asp:BoundField DataField="CustomerName" HeaderText="<%$ Resources:lang,CustomerName %>" ItemStyle-Width="90px" />--%>
            <asp:BoundField DataField="StandarLive" HeaderText="<%$ Resources:lang,StandarLive %>" ItemStyle-Width="80px" />

            <%-- <asp:BoundField DataField="StatusDesc" HeaderText="模具状态" ItemStyle-Width="70px" />--%>
            <asp:BoundField DataField="UseCount" HeaderText="累计使用寿命" ItemStyle-Width="80px" />
            <%--  <asp:BoundField DataField="ProduceDate" HeaderText="<%$ Resources:lang,ProduceDate %>" ItemStyle-Width="130px" />--%>
            <%--<asp:BoundField DataField="Price" HeaderText="价格" ItemStyle-Width="60px" />--%>
            <asp:BoundField DataField="CreateBy" HeaderText="<%$ Resources:lang, CreateBy %>" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="<%$ Resources:lang,CreateDateTime %>" ItemStyle-Width="140px" DataFormatString="{0:yyyy-MM-dd HH:MM:ss}" />
            <asp:BoundField DataField="ModifyBy" HeaderText="<%$ Resources:lang, ModifyBy %>" />
            <asp:BoundField DataField="ModifyDateTime" HeaderText="<%$ Resources:lang, ModifyDateTime %>" />
            <asp:TemplateField HeaderText="模具状态" ItemStyle-Width="50px">
                <ItemTemplate>
                    <asp:Label CLASS="StatusDesc" runat="server"
                        Text='<%#Eval("StatusDesc").ToString() == "已报废" ? "报废" : "正常"%>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <%-- <asp:TemplateField HeaderText="供应商交付日期" ItemStyle-Width="80px">
                <ItemTemplate >
                    <%#Eval("DeliveryTime").ToString() == "9999/12/31 0:00:00" ? "" : Convert.ToDateTime(Eval("DeliveryTime")).ToString("yyyy-MM-dd")%>
                </ItemTemplate>
            </asp:TemplateField>--%>
            <asp:BoundField DataField="Remark" HeaderText="备注" />
            <asp:BoundField DataField="PEId" HeaderText="关联产品">
                <HeaderStyle CssClass="hidden" />
                <ItemStyle  CssClass="hidden" />
                <FooterStyle CssClass="hidden" />
            </asp:BoundField>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Equipment.BLL.Equipments"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>

    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <%--  <object classid="clsid:62DEBC7F-D316-49E1-86EA-79B5D75E8A87" id="printerDemo" width="0"
        height="0" codebase="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/Component/RouterDesigner/RouterDesigner.cab#version=1,0,0,0">
    </object>--%>
    <script type="text/javascript">
        isMultiple = false;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");

        //增加 
        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/MouldEdit.aspx?name=Equipment_MouldAdd&Id=-1";
            dialog({ title: mesLang("新增模具"), src: openWinUrl, width: 950, height: 600, resizeable: false });
        }

        //编辑
        function Save() {
            var idStr = getOneRecordId();
            if (idStr == "") return;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/MouldEdit.aspx?name=Equipment_MouldEdit&Id=" + idStr;
            dialog({ title: mesLang("编辑模具"), src: openWinUrl, width: 950, height: 600, resizeable: false });
        }

        function Scrap() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            //xiang.yan 2024-4-28  列取值由索引改为列明
            // 12》15 改为 StatusDesc
            var statusStr = getItemTemplatebyClass("StatusDesc");
            if (statusStr == "报废") {
                alert("您选择的模具已报废！");
                return false;
            }

            //xiang.yan 2024-4-28  列取值由索引改为列明
            // 4 改为 InOrOut
            var isStock = getItemTemplatebyClass("InOrOut");
            if (isStock == "否") {
                alert("您选择的模具非在库状态,不能进行报废操作！");
                return false;
            }

            //xiang.yan 2024-4-28  列取值由索引改为列明
            // 1 改为 EquipmentCode
            var mouldCode = getOneRecordCellTextByFiled("EquipmentCode");
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/MouldScrap.aspx?name=Equipment_MouldScrap&MouldCode=" + mouldCode + "&Id=" + idStr;
            dialog({ title: mesLang("模具报废"), src: openWinUrl, width: 950, height: 400, resizeable: false });

        }

        function CancelScrap() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            //xiang.yan 2024-4-26  列取值由索引改为列明
            // 12》15 改为 StatusDesc
            var statusStr = getItemTemplatebyClass("StatusDesc");
            if (statusStr == "正常") {
                alert("您选择的模具非报废状态！");
                return false;
            }
            if (!confirm("是否确认取消报废？")) return false;
            hdnOperate.val("cancelscrap");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }
        //刷新 
        function refresh() {
            document.forms[0].submit();
        }



        //查看
        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/MouldView.aspx?name=Equipment_MouldView&Id=" + idStr;
            dialog({ title: mesLang("查看模具"), src: openWinUrl, width: 1000, height: 600, resizeable: false });
        }

        //模具保养
        function Maintenance() {
            var idStr = getOneRecordId();
            if (idStr == "") return;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/MouldMaintenance.aspx?name=Equipment_MouldMaintenance&Id=" + idStr;
            dialog({ title: mesLang("模具保养"), src: openWinUrl, width: 850, height: 650, resizeable: false });
        }

        //删除
        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            $(hdnOperate).val("Delete");
            $(hdnIdString).val(idStr);
            document.forms[0].submit();
        }

        function In() {
            var idStr = getRecordIdString();
            if (idStr == "") return;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/MouldInStock.aspx?name=Equipment_MouldIn&type=1&Id='" + idStr + "'";
            dialog({ title: mesLang("模具入库"), src: openWinUrl, width: 655, height: 555, resizeable: false });
        }

        function Out() {

            var idStr = getRecordIdString();
            if (idStr == "") return;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/MouldInStock.aspx?name=Equipment_MouldOut&type=0&Id='" + idStr + "'";
            dialog({ title: mesLang("模具出库"), src: openWinUrl, width: 655, height: 555, resizeable: false });
           <%-- var idStr = getRecordIdString();
            var equipmentCode = $('input[name="chkSelect"]:checked').parent().parent().find("td:eq(1)").html();
          
            if (idStr != "") {
                if (!window.confirm("确认出库？")) {
                    return "";
                }
            }

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipment.UpdateStock(idStr, 0);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
           alert('<%=Resources.Messages.SaveSuccess%>');
            window.UpdateList(equipmentCode);--%>
        }

        function SupplierDeliveryTime() {
            var idStr = getRecordIdString();
            if (idStr == "") return;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/MouldSupplierDeliveryTime.aspx?name=Equipment_SupplierDeliveryTime&Id=" + idStr;
            dialog({ title: mesLang("供应商交期维护"), src: openWinUrl, width: 400, height: 250, resizeable: false });
        }
        //更新列表
        function UpdateList(equipmentCode) {
            $("#<%=this.txtEquipmentCode.ClientID %>").val(equipmentCode);
            document.forms[0].submit();
        }
        function Import() {
            hdnOperate.val("ExportExcel");
            document.forms[0].submit();
            hdnOperate.val("");
        }
        function Export() {
            hdnOperate.val("exportexcel");
            document.forms[0].submit();
            hdnOperate.val("");
        }

        var chooseFlag = -1;

        /*选择供应商*/
        function selectSupplier() {
            chooseFlag = 34;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=34&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }
        /*单位*/
        function selectItem() {
            chooseFlag = 1;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=1&Multiple=false&rnd=" + Math.random(), width: 600, height: 400 });
        }
        function selectCustomer() {
            chooseFlag = 10;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=10&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }
        function selectEqType() {
            chooseFlag = 710
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=710&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }
        function getChooseValue(list) {
            if (chooseFlag == 710) {
                $("#<%=this.txtComponentName.ClientID %>").val(list[0][1]);
            } else if (chooseFlag == 34) {
                $("#<%=this.txtSupplier.ClientID %>").val(list[0][2]);
            }
        }


        //导入
        function Import() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/MouldListImport.aspx?name=Equipment_MouldAdd&ID=-1";
            dialog({ title: "导入模具", src: openWinUrl, width: (windowWidth - 200), height: (windowHeigth - 200) });
        }


        function Download() {
            return downLoadField('<%=SKT.LeanMES.Web.WebHelper.ExcelTemplateRoot+"模具列表导入.xlsx" %>');
        }

        function downLoadField(fieldPath) {
            window.open(fieldPath);
            return null;
        }

    </script>
</asp:Content>

