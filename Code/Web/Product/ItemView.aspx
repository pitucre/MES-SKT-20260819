<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="True"
    CodeBehind="ItemView.aspx.cs" Inherits="SKT.LeanMES.Web.Product.ItemView" Title="View Item" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="wrap_tb">
        <ul class="tb">
            <li class="current">基本信息</li>
            <li>资格证书</li>
            <li>扩展信息</li>
        </ul>
        <div class="tb_c">
            <table class="EditeContentTable" width="100%">
                <tr>
                    <td class="Label2">产品编码
                    </td>
                    <td class="Field2" colspan="3">
                        <asp:Label ID="lblItemCode" runat="server" Text=""></asp:Label>
                    </td>

                </tr>
                <tr>
                    <td class="Label2">
                        <%=Resources.lang.ItemsName %>
                    </td>
                    <td class="Field2">
                        <asp:Label ID="txtItemsName" runat="server" Text=""></asp:Label>
                    </td>
                    <td class="Label2">
                        <%=Resources.lang.Revision%>
                    </td>
                    <td class="Field2">
                        <asp:Label ID="txtVersion" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="Label2">
                        <%=Resources.lang.InItemGroup %>
                    </td>
                    <td class="Field2">
                        <asp:Label ID="ddlItemGroup" runat="server" Text=""></asp:Label>
                    </td>
                    <td class="Label2">绑定路由
                    </td>
                    <td class="Field2">
                        <asp:Label ID="txtRouter" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="Label2">最小包装数量
                    </td>
                    <td class="Field2">
                        <asp:Label ID="minPackQty" runat="server" Text=""></asp:Label>

                    </td>
                    <td class="Label2">单位
                    </td>
                    <td class="Field2">
                        <asp:Label ID="txtUnits" runat="server" Text="Label"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="Label2">
                        <%=Resources.lang.InProject %>
                    </td>
                    <td class="Field2">
                        <asp:Label ID="txtProject" runat="server" Text="Label"></asp:Label>
                    </td>
                    <td class="Label2">
                        <%=Resources.lang.CustomerName %>
                    </td>
                    <td class="Field2">
                        <asp:Label ID="txtCustomer" runat="server" Text="Label"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="Label2">
                        <%=Resources.lang.CustomerPartNumber %>
                    </td>
                    <td class="Field2">
                        <asp:Label ID="txtCPN" runat="server" Text="Label"></asp:Label>
                    </td>
                    <td class="Label2">
                        <%=Resources.lang.CustomerPartRevision %>
                    </td>
                    <td class="Field2">
                        <asp:Label ID="txtCPR" runat="server" Text="Label"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="Label2">
                        <%=Resources.lang.ItemStatus %>
                    </td>
                    <td class="Field2">
                        <asp:Label ID="ddlItemStatus" runat="server" Text=""></asp:Label>
                    </td>
                    <td class="Label2">
                        <%-- <%=Resources.lang.ItemType %>--%>产品来源类型
                    </td>
                    <td class="Field2">
                        <asp:Label ID="ddlItemType" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="Label2">IQC检验类型
                    </td>
                    <td class="Field2">
                        <asp:Label ID="ddlIQCType" runat="server" Text=""></asp:Label>
                    </td>
                    <td class="Label2">产品BOM
                    </td>
                    <td class="Field2">
                        <asp:Label ID="txtItemBom" runat="server" Text="Label"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="Label2">采集模式
                    </td>
                    <td class="Field2">
                        <asp:Label ID="ddlAcquisitionMode" runat="server" Text="Label"></asp:Label>
                    </td>
                    <td class="Label2">每批次数量
                    </td>
                    <td class="Field2">
                        <asp:Label ID="txtLotSize" runat="server" Text="Label"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="Label2">
                        <%=Resources.lang.AsCurrentRevision %>
                    </td>
                    <td class="Field2">
                        <asp:Label ID="ckbCurrentVer" runat="server" Text=""></asp:Label>
                    </td>
                    <td class="Label2"></td>
                    <td class="Field2"></td>
                </tr>
                <tr>
                    <td class="Label2">是否打印GRN
                    </td>
                    <td class="Field2">
                        <asp:Label ID="chbIsNeedPrint" runat="server" Text=""></asp:Label>
                    </td>
                    <td class="Label2">是否可超发
                    </td>
                    <td class="Field2">
                        <asp:Label ID="chbIsVendorPrint" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="Label2">
                        <%=Resources.lang.DataCollectionOnAss%>
                    </td>
                    <td class="Field2" colspan="1">
                        <asp:Label ID="txtDataType" runat="server" Text="Label"></asp:Label>
                    </td>
                    <td class="Label2">所属工厂
                    </td>
                    <td class="Field2">
                        <asp:Label ID="lblFactoryName" runat="server" Text=""></asp:Label>
                    </td>
                </tr>

                <tr id="trIsPanel" runat="server">
                    <td class="Label2">
                        <%//=Resources.lang.Description %>拼板类型
                    </td>
                    <td class="Field2" colspan="3">拼板：
                        <asp:Label ID="lblPanelQty" runat="server"></asp:Label>
                        &nbsp;&nbsp;X&nbsp;&nbsp; 子板：
                        <asp:Label ID="lblChildQty" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="Label2">可超量完工类型
                    </td>
                    <td class="Field2">
                        <asp:Label ID="lblOverFinshType" runat="server"></asp:Label>
                    </td>
                    <td class="Label2">完工超额量
                    </td>
                    <td class="Field2">
                        <asp:Label ID="lblOverQty" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="Label2">完工超额比例
                    </td>
                    <td class="Field2">
                        <asp:Label ID="lblOverRate" runat="server"></asp:Label>
                    </td>
                    <td class="Label2"></td>
                    <td class="Field2"></td>
                </tr>
                <tr>
                    <td class="Label2">
                        <%=Resources.lang.Description %>
                    </td>
                    <td class="Field2" colspan="3">
                        <asp:Label ID="txtItemDesc" runat="server" Text="Label"></asp:Label>
                    </td>
                </tr>
            </table>
        </div>
        <div>
            <asp:Localize ID="llCerList" runat="server"></asp:Localize>
        </div>
        <div>
            <table id="tblExtensionInfos" class="EditeContentTable" width="100%">
                <tr id="trNewInfo">
                    <td colspan="4" style="text-align: center;">
                        <%=Resources.lang.NoExtendedInfos %>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <script type="text/javascript">
        function Edit() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Product/ItemEdit.aspx?name=Product_ItemEdit&ID=" + '<%= Request.QueryString["ID"] %>' + "&inMenu=true";
            location.href = openWinUrl;
        }

        /*加载扩展字段信息*/
        function loadExtsionInfos() {
            var itemId = '<%= Request.QueryString["ID"] %>';
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxBaseExt.GetExtsionInfoListByItemId(itemId, "Basal_Item");
            if (ajax.error != null) {
                return false;
            }
            var list = ajax.value;
            if (list != null && list != undefined && list.length > 0) {
                /*显示扩展字段信息*/
                var r = "";
                var listLength = list.length;
                for (var i = 0; i < listLength; i++) {
                    if (i % 2 == 0) {
                        r += "<tr>";
                    }
                    r += "<td class='Label2'><label id='lblExtFieldDescription" + i + "' name='ExtFieldDescription'>" + list[i].ExtFieldDescription + "</label>";
                    r += "<input type='hidden' id='txtExtId" + i + "' class='ExtId' value='" + (list[i].ExtId == null ? -1 : list[i].ExtId) + "' /><input type='hidden' id='txtExtFieldsId" + i + "' class='ExtFieldsId' value='" + list[i].ExtFieldsId + "' /><input type='hidden' id='txtSequence" + i + "' class='Sequence' value='" + list[i].Sequence + "' />";
                    r += "</td><td class='Field2'>";
                    //字段类型为布尔
                    if (list[i].ExtFieldType == "bit" || list[i].ExtFieldType == "bool") {
                        if (list[i].ExtFieldValue == "true" || list[i].ExtFieldValue == "True") {
                            r += "<%=Resources.lang.Yes %><input type='radio' id='radExtFieldValue" + i + "' tag='radExtFields' name='radExtFields" + list[i].ExtFieldName + "' class='ExtFieldValue' checked='checked' value='true' />&nbsp;&nbsp;&nbsp;&nbsp;<%=Resources.lang.No %><input type='radio' id='radExtFieldValue" + i + "" + i + "' tag='radExtFields' name='radExtFields" + list[i].ExtFieldName + "' value='false";
                        } else if (list[i].ExtFieldValue == "false" || list[i].ExtFieldValue == "False") {
                            r += "<%=Resources.lang.Yes %><input type='radio' id='radExtFieldValue" + i + "' tag='radExtFields' name='radExtFields" + list[i].ExtFieldName + "' value='true' />&nbsp;&nbsp;&nbsp;&nbsp;<%=Resources.lang.No %><input type='radio' id='radExtFieldValue" + i + "" + i + "' tag='radExtFields' name='radExtFields" + list[i].ExtFieldName + "' class='ExtFieldValue' value='false' checked='checked";
                        } else {
                            r += "<%=Resources.lang.Yes %><input type='radio' id='radExtFieldValue" + i + "' tag='radExtFields' name='radExtFields" + list[i].ExtFieldName + "' class='ExtFieldValue' value='true' />&nbsp;&nbsp;&nbsp;&nbsp;<%=Resources.lang.No %><input type='radio' id='radExtFieldValue" + i + "" + i + "' tag='radExtFields' name='radExtFields" + list[i].ExtFieldName + "' value='false";
                        }
                    } else if (list[i].ExtFieldType == "datetime") { //字段类型为时间
                        r += "<lable id='txtExtFieldValue" + i + "' name='dateExtFields' class='ExtFieldValue' >";
                        if (list[i].ExtFieldValue != null && list[i].ExtFieldValue != undefined && list[i].ExtFieldValue != "") {
                            r += list[i].ExtFieldValue;
                        }
                    } else { //字段类型为字符
                        r += "<lable id='txtExtFieldValue" + i + "' name='txtExtFields' class='ExtFieldValue' >";
                        if (list[i].ExtFieldValue != null && list[i].ExtFieldValue != undefined && list[i].ExtFieldValue != "") {
                            r += list[i].ExtFieldValue;
                        }
                    }

                    r += "</label></td>";
                    if (i % 2 == 0 && i == listLength - 1) {
                        r += "<td class='Label2'></td><td class='Field2'></td></tr>";
                    } else if (i % 2 != 0) {
                        r += "</tr>";
                    } else {
                        r += "";
                    }
                }
                $("#trNewInfo").remove();
                $("#tblExtensionInfos").append(r);
            } else {
                $("#tblExtensionInfos tr").remove();
                $("#tblExtensionInfos").append("<tr><td colspan='4' style='text-align:center;'><font color='red'><%=Resources.lang.NoExtendedInfos %>！</font></td>");
            }
        }

        $(function () {
            loadExtsionInfos();
            $("input[name='dateExtFields']").datepicker({
                showHms: false
            });
            changeRadioClass();
        });

        function changeRadioClass() {
            $('input[tag="radExtFields"]').click(function () {
                $(this).attr('class', 'ExtFieldValue');
                $(this).siblings().removeClass();
            });
        }
    </script>
</asp:Content>
