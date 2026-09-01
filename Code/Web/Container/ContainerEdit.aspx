<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    Inherits="SKT.LeanMES.Web.Container.ContainerEdit" CodeBehind="ContainerEdit.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="wrap_tb" style="min-width: 780px;">
        <ul class="tb">
            <li class="current">基本信息</li>
            <li>包装内容</li>
            <li>包装箱标签</li>
        </ul>
        <div class="tb_c" >
            <div class="infoTips">
                <%=Resources.Messages.WithAsteriskIsRequired %></div>
            <table class="EditeContentTable" width="100%">
                <tr>
                    <td class="Label1">
                        包装箱名称
                    </td>
                    <td class="Field1">
                        <asp:TextBox ID="txtName" runat="server" CssClass="TextBox" IsRequired='1' MaxLength="50"></asp:TextBox><em>*</em>
                    </td>
                </tr>
                <tr>
                    <td class="Label1">
                        数据类型
                    </td>
                    <td class="Field1">
                        <asp:TextBox ID="txtDataTypeName" runat="server" IsRequired='1' CssClass="TextBox"
                            MaxLength="30" ReadOnly="true"></asp:TextBox><input type="button" id="btnDataType"
                                class="ButtonBox" value="..." title="" onclick="selectDateType();" /><em>*</em>
                        <asp:HiddenField ID="txtDataTypeID" runat="server" Value="-1" />
                    </td>
                </tr>
                <tr>
                    <td class="Label1">
                        <%= Resources.lang.Status %>
                    </td>
                    <td class="Field1">
                        <asp:DropDownList ID="ddlStatus" runat="server">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td class="Label1">
                        工单混合包装
                    </td>
                    <td class="Field1">
                        <asp:CheckBox ID="CbMixShopOrders" runat="server" Text="是"></asp:CheckBox>
                    </td>
                </tr>
                <tr>
                    <td class="Label1">
                        产品混合包装
                    </td>
                    <td class="Field1">
                        <asp:CheckBox ID="CbMixItems" runat="server" Text="是" ></asp:CheckBox>
                    </td>
                </tr>
                <tr>
                    <td class="Label1">
                        是否顺序包装
                    </td>
                    <td class="Field1">
                        <asp:CheckBox ID="CbSequence" runat="server" Text="是"></asp:CheckBox>
                    </td>
                </tr>
                <tr>
                    <td class="Label1">
                        高
                    </td>
                    <td class="Field1">
                        <asp:TextBox ID="textHeight" runat="server" CssClass="NumericBox50" Text="0" Width="60px"
                            MaxLength="30" onkeyup="this.value=this.value.replace(/[^\d.]/g,'')" onafterpaste="this.value=this.value.replace(/[^\d.]/g,'')"></asp:TextBox>(mm)
                    </td>
                </tr>
                <tr>
                    <td class="Label1">
                        宽
                    </td>
                    <td class="Field1">
                        <asp:TextBox ID="textWidth" runat="server" CssClass="NumericBox50" Text="0" Width="60px"
                            MaxLength="40" onkeyup="this.value=this.value.replace(/[^\d.]/g,'')" onafterpaste="this.value=this.value.replace(/[^\d.]/g,'')"></asp:TextBox>(mm)
                    </td>
                </tr>
                <tr>
                    <td class="Label1">
                        长
                    </td>
                    <td class="Field1">
                        <asp:TextBox ID="textLength" runat="server" CssClass="NumericBox50" Text="0" Width="60px"
                            onkeyup="this.value=this.value.replace(/[^\d.]/g,'')" onafterpaste="this.value=this.value.replace(/[^\d.]/g,'')"></asp:TextBox>(mm)
                    </td>
                </tr>
                <tr>
                    <td class="Label1">
                        最大重量
                    </td>
                    <td class="Field1">
                        <asp:TextBox ID="textMaxFillWeight" runat="server" CssClass="NumericBox50" Text="0"
                            Width="60px" MaxLength="50" onkeyup="this.value=this.value.replace(/[^\d.]/g,'')"
                            onafterpaste="this.value=this.value.replace(/[^\d.]/g,'')"></asp:TextBox>(kg)
                    </td>
                </tr>
                <tr>
                    <td class="Label1">
                        包装箱本身重量
                    </td>
                    <td class="Field1">
                        <asp:TextBox ID="textContainerWeight" runat="server" CssClass="NumericBox50" Text="0"
                            Width="60px" MaxLength="50" onkeyup="this.value=this.value.replace(/[^\d.]/g,'')"
                            onafterpaste="this.value=this.value.replace(/[^\d.]/g,'')"></asp:TextBox>(kg)
                    </td>
                </tr>
                <tr>
                    <td class="Label1">
                        <%= Resources.lang.Description%>
                    </td>
                    <td class="Field1">
                        <asp:TextBox ID="txtDescription" runat="server" CssClass="TextArea" MaxLength="50"
                            TextMode="MultiLine" Width="250px" Height="60px"></asp:TextBox>
                    </td>
                </tr>
            </table>
        </div>
       <%-- <div style="min-height: 600px; overflow: auto;">--%>
        <div>
            <table class="ListTable" cellspacing="0" cellpadding="4" style="border-width: 0px;
                min-width: 760px; width: 100%; overflow: auto; border-collapse: collapse;" id="tbPackLevel">
                <tr class="ListTableHeader">
                    <th scope="col" align="center">
                        包装类型
                    </th>
                    <th scope="col" align="center">
                        包装内容<em>*</em>
                    </th>
                    <th scope="col" align="center">
                        <%= Resources.lang.Revision%>
                    </th>
                    <th scope="col" align="center">
                        <%= Resources.lang.ShopOrder%>
                    </th>
                    <th scope="col" align="center">
                        最小数量<em>*</em>
                    </th>
                    <th scope="col" align="center">
                        最大数量<em>*</em>
                    </th>
                    <th scope="col" onclick="addPackLevelDetail(null,true);" style="color: #0066CC; cursor: pointer;
                        width: 100px; vertical-align: middle;" align="center">
                        <img src="../Content/images/icon/Add.png" class="imgText" />
                        <%= Resources.Buttons.COM_Add%>
                    </th>
                </tr>
            </table>
        </div>
         <div>
            <table class="ListTable" cellspacing="0" cellpadding="4" style="border-width: 0px;
                width: 100%; border-collapse: collapse;" id="Documents">
                <tr class="ListTableHeader">
                    <th scope="col" style="width: 60px" align="center">
                        <%=Resources.lang.Sequence%>
                    </th>
                    <th scope="col" align="center">
                        文档
                    </th>
                    <th scope="col" onclick="addContainerDocument(null,true);" style="color: #0066CC;
                        cursor: pointer; width: 60px" align="center">
                        <img src="../Content/images/icon/Add.png" class="imgText" />
                        <%= Resources.Buttons.COM_Add%>
                    </th>
                </tr>
            </table>
        </div>
    </div>
    <script type="text/javascript">
        var cONTAINERId = '<%= Request.QueryString["ID"] %>';
        var tab = document.getElementById("tbPackLevel");
        var tabDocument = document.getElementById("Documents");
        var condition = ""; //ShopOrderID查询条件
        var condition1 = ""; //Item查询条件

        $(function () {
            if (parseInt(cONTAINERId) > -1) {
                initItemOnHold(cONTAINERId);
            }
            if (tab.rows.length < 2) {
                addPackLevelDetail(null, false);
            }
            if (tabDocument.rows.length < 2) {
                addContainerDocument(null, false);
            }

            $("#<%=this.CbMixShopOrders.ClientID %>").change(function () {
                if (!$(this)[0].checked) {
                    var isMixShopOrder = false;
                    var shopOrder = -1;
                    if ($("#tbPackLevel tr").length > 1) {
                        if ($("#tbPackLevel tr").length > 2) {
                            shopOrder = $("#tbPackLevel tr:eq(1)").children("td:eq(3)").children("input[type=hidden]").val();
                            $("#tbPackLevel tr:gt(1)").each(function () {
                                if (shopOrder != $(this).children("td:eq(3)").children("input[type=hidden]").val()) {
                                    isMixShopOrder = true;
                                    return false;
                                }
                            });
                        }
                    }
                    if (isMixShopOrder) {
                        alert("当前包装箱为工单混合包装模式，如果要取消工单混合包装模式，请先在包装内容中删除不相同的工单。");
                        $(this)[0].checked = true;
                    }
                }
            });

            $("#<%=this.CbMixItems.ClientID %>").change(function () {
                if (!$(this)[0].checked) {
                    var isMixItem = false;
                    var itemCode = "";
                    if ($("#tbPackLevel tr").length > 1) {
                        if ($("#tbPackLevel tr").length > 2) {
                            itemCode = $("#tbPackLevel tr:eq(1)").children("td:eq(1)").children("input[type=text]").val();
                            $("#tbPackLevel tr:gt(1)").each(function () {
                                if (itemCode != $(this).children("td:eq(1)").children("input[type=text]").val()) {
                                    isMixItem = true;
                                    return false;
                                }
                            });
                        }
                    }
                    if (isMixItem) {
                        alert("当前包装箱为产品混合包装模式，如果要取消产品混合包装模式，请先在包装内容中删除不相同的产品。");
                        $(this)[0].checked = true;
                    }
                }
            });
        });

        function Save() {
            var txtName = $.trim($("#<%=this.txtName.ClientID %>").val());
            var txtDataTypeID = $("#<%=this.txtDataTypeID.ClientID %>").val();
            var ddlStatus = $("#<%=this.ddlStatus.ClientID %>").val();
            var CbMixShopOrders = ($("#<%=this.CbMixShopOrders.ClientID%>").prop("checked"));
            var textDesc = $("#<%=this.txtDescription.ClientID %>").val();
            var textHeight = $("#<%=this.textHeight.ClientID %>").val();
            var textWidth = $("#<%= this.textWidth.ClientID %>").val();
            var textLength = $("#<%=this.textLength.ClientID %>").val();
            var textWeight = $("#<%=this.textContainerWeight.ClientID %>").val();
            var textMaxFillWeight = $("#<%=this.textMaxFillWeight.ClientID %>").val();
            var CbMixItems = $("#<%=this.CbMixItems.ClientID %>")[0].checked;

            var CbSequence = $("#<%=this.CbSequence.ClientID %>")[0].checked;
            entityctr = {};
            var action = '<%=Request.QueryString["Action"] %>';
            if (action == "Copy") {
                entityctr.ContainerId = -1;
            }
            else {
                entityctr.ContainerId = parseInt(cONTAINERId);
            }
            entityctr.Name = txtName;
            entityctr.DataTypeId = parseInt(txtDataTypeID);
            entityctr.Status = ddlStatus;
            entityctr.MixShopOrders = CbMixShopOrders;
            entityctr.Description = textDesc;
            entityctr.Height = toDecimal(textHeight);
            entityctr.Width = toDecimal(textWidth);
            entityctr.Depth = toDecimal(textLength);
            entityctr.Weight = toDecimal(textWeight);
            entityctr.MaxFillWeight = toDecimal(textMaxFillWeight);
            entityctr.MixItems = CbMixItems;
            entityctr.Sequence = CbSequence;

            /*包装项*/

            var objPackingLeve = document.getElementsByName("option");
            var objPackingLevelValue = document.getElementsByName("txtPackingLevelValue");
            var objRevision = document.getElementsByName("txtRevision");
            var objShopOrderID = document.getElementsByName("txtShopOrderID");
            var objMinQty = document.getElementsByName("txtMinQty");
            var objMaxQty = document.getElementsByName("txtMaxQty");
            var objPackingLevelValueID = document.getElementsByName("txtContainerPackingLevelID");

            var PLString = "";
            var PLVString = "";
            var RevString = "";
            var SOIDString = "";
            var MinQString = "";
            var MaxQString = "";
            var PLVIDString = "";

            for (var i = 0; i < objPackingLevelValue.length; i++) {
                PLString += objPackingLeve[i].value + ",";
                PLVString += objPackingLevelValue[i].value + ",";
                RevString += objRevision[i].value + ",";
                SOIDString += objShopOrderID[i].value + ",";
                MinQString += objMinQty[i].value + ",";
                MaxQString += objMaxQty[i].value + ",";
                if (parseInt(MinQString) > parseInt(MaxQString)) {
                    alert("最小数量不能大于最大数量！");
                    $(objMinQty).focus();
                    return false;
                }
                PLVIDString += objPackingLevelValueID[i].value + ",";
            }

            /*文档项*/
            var objSeauence = document.getElementsByName("txtSeauence");
            var objDocumentID = document.getElementsByName("txtDocumentID");
            var objContainerDocumentID = document.getElementsByName("txtContainerDocumentID");

            var SeaString = "";
            var DIDString = "";
            var CDIDString = "";

            for (var i = 0; i < objDocumentID.length; i++) {
                if (parseInt(objDocumentID[i].value) != -1) {
                    SeaString += objSeauence[i].value + ",";
                    DIDString += objDocumentID[i].value + ",";
                    CDIDString += objContainerDocumentID[i].value + ",";
                }
            }

            var ajaxsave = SKT.LeanMES.Web.AjaxServices.AjaxContainer.EditContainer(entityctr, PLString, PLVString, RevString, SOIDString, MinQString, MaxQString, PLVIDString, SeaString, DIDString, CDIDString);

            if (ajaxsave.error == null) {
                alert('<%=Resources.Messages.SaveInSuccess %>');
                parent.window.UpdateList(txtName);
            }
            else {
                alert(ajaxsave.error.Message);
                return false;
            }
        }

        function selectDateType() {
            flag = 2;
            //dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=2&SearchCondition=Category='NC'&Multiple=false&rnd=" + Math.random(), width: 500, height: 300 });
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=2&Multiple=false&rnd=" + Math.random(), width: 650, height: 350 });
        }

        var option = 0;
        var flag = -1;
        var rowObj = null;
        //增加PackLevel
        function addPackLevelDetail(entity, callFromButton) {
            $("#tbPackLevel .ListTableEmptyDataRow").remove();
            if (entity == null) {
                entity = {};
                entity.ContainerPackingLevelId = -1;
                entity.ContainerID = -1;
                entity.Seauence = "";
                entity.PackingLevel = "Item";
                entity.PackingLevelValue = "";
                entity.Revision = "";
                entity.ProdOrderID = -1;
                entity.ProdOrderName = "";
                entity.MinQty = 1;
                entity.MaxQty = 1;
                if (!callFromButton)
                {
                    $("#tbPackLevel").append("<tr class='ListTableEmptyDataRow'><td colspan='7'>" + mesLang("该包装箱还没有设置任何包装内容，点击“新增”按钮来设置包装内容。")+"</td></tr>");
                    return false;
                }
            }

            var row, cell, optionvalue, disabled;
            rowNewIdx = tab.rows.length;
            row = tab.insertRow(rowNewIdx);
            row.className = "ListTableOddRow";

            optionvalue = entity.PackingLevel;

            cell = row.insertCell(0);
            cell.align = "center";
           
            if (entity.PackingLevel == "Item" || entity.PackingLevel == "") {
                cell.innerHTML = "<select onchange=\"change(this)\"  name=\"option\" ><option value =\"Item\"  selected=\"selected\">Item</option><option value =\"Box\" >Box</option><option value =\"Container\" >Container</option></select>";
            }
            else if (entity.PackingLevel == "Box") {
                cell.innerHTML = "<select onchange=\"change(this)\"   name=\"option\" ><option value =\"Item\" >Item</option><option value =\"Box\" selected=\"selected\">Box</option><option value =\"Container\">Container</option></select>";
            }
            else if (entity.PackingLevel == "Container") {               
                cell.innerHTML = "<select onchange=\"change(this)\"   name=\"option\" ><option value =\"Item\" >Item</option><option value =\"Box\">Box</option><option value =\"Container\" selected=\"selected\">Container</option></select>";
            }
             
            cell = row.insertCell(1);
            cell.align = "center";
            cell.innerHTML = "<input type=\"text\" name=\"txtPackingLevelValue\" IsRequired='1'  style=\"width:180px;float:left;\"   value=\"" + entity.PackingLevelValue + "\" disabled=\"disabled\">"
        + "<input type=\"button\" id=\"btnSelectItems\" onclick=\"selectItems(this);\" style='float:left' class=\"ButtonBox\"  value=\"...\"  />";

            cell = row.insertCell(2);
            cell.align = "center";
            if (entity.PackingLevel == "Item") {
                cell.innerHTML = "<input type=\"text\" name=\"txtRevision\" style=\"width:40px;\"   value=\"" + entity.Revision + "\"/>";
            }
            else {
                cell.innerHTML = "<input type=\"text\" name=\"txtRevision\"  style=\"width:40px;\" value=\"" + entity.Revision + "\"  disabled=\"disabled\" />";
            }


            cell = row.insertCell(3);
            cell.align = "center";
            if (entity.PackingLevel == "Item") {
                cell.innerHTML = "<input type=\"text\" name=\"txtShopOrderName\" style=\"width:100px;float:left\"   value=\"" + entity.ProdOrderName + "\" disabled=\"disabled\">"
            + "<input type=\"button\" id=\"btnSelectItems\" onclick=\"selectShopOrder(this);\" class=\"ButtonBox\" style='float:left'   value=\"...\"  /><input type=\"hidden\" name=\"txtShopOrderID\" value=\"" + entity.ProdOrderID + "\" />";
            }
            else {
                cell.innerHTML = "<input type=\"text\" name=\"txtShopOrderName\" style=\"width:100px;float:left\"   value=\"" + entity.ProdOrderName + "\" disabled=\"disabled\">"
             + "<input type=\"button\" id=\"btnSelectItems\" onclick=\"selectShopOrder(this);\" class=\"ButtonBox\" style='float:left'  value=\"...\"  disabled=\"disabled\"/><input type=\"hidden\" name=\"txtShopOrderID\" value=\"" + entity.ProdOrderID + "\" />";
            }


            cell = row.insertCell(4);
            cell.align = "center";
            cell.innerHTML = "<input type=\"text\" name=\"txtMinQty\" IsRequired='1' IsNumber='1'  style=\"width:60px;\" onkeyup=\"checkQty(this)\" value=\"" + entity.MinQty + "\" class=\"NumericBox50\" onkeyup=\"this.value=this.value.replace(/\\D/g,'')\" onafterpaste=\"this.value=this.value.replace(/\\D/g,'')\"/>";

            cell = row.insertCell(5);
            cell.align = "center";
            cell.innerHTML = "<input type=\"text\" name=\"txtMaxQty\" IsRequired='1' IsNumber='1'  style=\"width:60px;\" onkeyup=\"checkQty(this)\" value=\"" + entity.MaxQty + "\" class=\"NumericBox50\" onkeyup=\"this.value=this.value.replace(/\\D/g,'')\" onafterpaste=\"this.value=this.value.replace(/\\D/g,'')\"/>"
        + "<input type=\"hidden\" name=\"txtContainerPackingLevelID\" value=\"" + entity.ContainerPackingLevelId + "\"  />";

            cell = row.insertCell(6);
            cell.align = "center";
            cell.width = "60px";
            cell.innerHTML = "<span style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"deleteItem(this)\"><%= Resources.Buttons.COM_Delete %></span>";
        }

        var rowDocument = null;
        //增加ContainerDocument
        function addContainerDocument(entityDocument, callFromButton) {
            $("#Documents .ListTableEmptyDataRow").remove();
            if (entityDocument == null) {
                entityDocument = {};
                entityDocument.ContainerDocumentId = -1;
                entityDocument.ContainerId = "";
                entityDocument.DocumentID = "";
                entityDocument.DocumentName = "";
                entityDocument.Seauence = $("#Documents tr:gt(0)").length + 1;
                if (!callFromButton)
                {
                    $("#Documents").append("<tr class='ListTableEmptyDataRow'><td colspan='3'>" + mesLang("该包装箱还没有设置任何标签，点击“新增”按钮来设置包装的标签。")+"</td></tr>");
                    return false;
                }
            }

            var row, cell;
            rowNewIdx = tabDocument.rows.length;
            row = tabDocument.insertRow(rowNewIdx);
            row.className = "ListTableOddRow";

            cell = row.insertCell(0);
            cell.align = "center";
            cell.innerHTML = "<input type=\"text\" name=\"txtSeauence\" value=\"" + entityDocument.Seauence + "\" class=\"NumericBox50\" onkeyup=\"this.value=this.value.replace(/\\D/g,'')\" onafterpaste=\"this.value=this.value.replace(/\\D/g,'')\"/>"
        + "<input type=\"hidden\" name=\"txtContainerDocumentID\"   value=\"" + entityDocument.ContainerDocumentId + "\"  />";

            cell = row.insertCell(1);
            cell.align = "center";
            cell.innerHTML = "<input type=\"text\" name=\"txtDocumentName\" class=\"TextBox\" style=\"width:90%;\"  value=\"" + entityDocument.DocumentName + "\" disabled=\"disabled\">"
        + "<input type=\"button\" id=\"btnSelectItems\" onclick=\"selectDocuments(this);\" class=\"ButtonBox\"  value=\"...\" /><input type=\"hidden\" name=\"txtDocumentID\" value=\"" + entityDocument.DocumentID + "\" />";

            cell = row.insertCell(2);
            cell.align = "center";
            cell.innerHTML = "<span style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"deleteDocument(this)\"><%= Resources.Buttons.COM_Delete %></span>";
        }

        function initItemOnHold(ContainerId) {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxContainer.GetContainerPackingLevel(ContainerId.toString());
            if (ajax.error == null) {
                var entityAry = ajax.value;
                for (var i = 0; i < entityAry.length; i++) {
                    addPackLevelDetail(entityAry[i], false);
                }
            } else {
                alert(ajax.error.Message);
            }

            var ajaxDocument = SKT.LeanMES.Web.AjaxServices.AjaxContainer.GetContainerDocument(ContainerId.toString());
            if (ajaxDocument.error == null) {
                var entityAry = ajaxDocument.value;
                for (var i = 0; i < entityAry.length; i++) {
                    addContainerDocument(entityAry[i], false);
                }
            } else {
                alert(ajax.error.Message);
            }
        }

        function selectShopOrder(obj) {
            flag = 3;
            rowObj = obj.parentElement.parentElement;
            var CbMixShopOrders = $("#<%=this.CbMixShopOrders.ClientID%>")[0].checked;

            if (!CbMixShopOrders) {
                if ($("#tbPackLevel tr").length > 1) {
                    var choosedOrderId = -1;
                    $("#tbPackLevel tr:gt(0)").each(function () {
                        choosedOrderId = $(this).children("td:eq(3)").children("input[type=hidden]").val();
                        if (choosedOrderId != -1) {
                            return false;
                        }
                    });
                    condition = choosedOrderId;
                }
                if ($("#tbPackLevel tr").length == 2) {
                    condition = "";
                }

                if (condition != null && condition != "" && condition.length > 0) {
                    dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=44&SearchCondition=ProdOrderID=" + condition + "&Multiple=false&rnd=" + Math.random(), width: 650, height: 350 });
                }
                else {
                    dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=44&Multiple=false&rnd=" + Math.random(), width: 650, height: 350 });
                }
            }
            else {
                dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=44&Multiple=false&rnd=" + Math.random(), width: 650, height: 350 });
            }
        }

        function selectDocuments(obj) {
            flag = 4;
            rowObj = obj.parentElement.parentElement;
            var searchSettings = " Status ='Enabled' ";
            dialog({ title: "<%=Resources.Common.ChooseWindow %>"
            , src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=43&Multiple=false&PageCondition=" + escape(searchSettings) + "&rnd="
             + Math.random(), width: 650, height: 350 });
        }
        function selectItems(obj) {
            flag = 1;
            rowObj = obj.parentElement.parentElement;

            if (rowObj.cells[0].children[0].value == "Item") {
                /*选择产品*/
                var CbMixItems = $("#<%=this.CbMixItems.ClientID%>")[0].checked;
                if (!CbMixItems) {
                    /*产品不能混合包装*/
                    if ($("#tbPackLevel tr").length > 1) {
                        var choosedItem = "";
                        $("#tbPackLevel tr:gt(0)").each(function () {
                            choosedItem = $(this).children("td:eq(1)").children("input[type=text]").val();
                            if (choosedItem != "") {
                                return false;
                            }
                        });
                        condition1 = " ItemCode = '" + choosedItem + "' ";
                    }
                    if ($("#tbPackLevel tr").length == 2) {
                        condition1 = "";
                    }
                    dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=1&PageCondition=" + condition1 + "&Multiple=false&rnd=" + Math.random(), width: 650, height: 350 });
                }
                else {
                    dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=1&Multiple=false&rnd=" + Math.random(), width: 650, height: 350 });
                }
            }
            else {
                flag = 5;
                dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=42&Multiple=false&rnd=" + Math.random(), width: 650, height: 350 });
            }
        }

        function getChooseValue(list) {

            //检测重复项
            var isExsit = false;
            var packContent;
            if ((flag == 1 || flag == 5)) {
                var contentIndex = flag == 1 ? 2 : 1;
                if (list[0][contentIndex] != "") {
                    $("#tbPackLevel tr:gt(0)").each(function () {
                        packContent = $(this).children("td:eq(1)").children("input:eq(0)").val();
                        if (packContent == list[0][contentIndex]) {
                            isExsit = true;
                            return false;
                        }
                    });
                    if (isExsit) {
                        alert("包装内容 [" + list[0][contentIndex] + "] 已存在列表中！");
                        return;
                    }
                }
            }
            else if (flag == 4) {
                if (list[0][1] != "") {
                    $("#Documents tr:gt(0)").each(function () {
                        packContent = $(this).children("td:eq(1)").children("input:eq(0)").val();
                        if (packContent == list[0][1]) {
                            isExsit = true;
                            return false;
                        }
                    });
                    if (isExsit) {
                        alert("文档 [" + list[0][1] + "] 已存在列表中！");
                        return;
                    }
                }
            }
            switch (flag) {
                case 1:
                    rowObj.cells[1].children[0].value = list[0][2];
                    if (rowObj.cells[0].children[0].value != "Container") {
                        rowObj.cells[2].children[0].value = list[0][3];
                    }
                    condition1 = list[0][0];
                    break;
                case 2:
                    $("#<%=this.txtDataTypeName.ClientID %>").val(list[0][2]);
                    $("#<%=this.txtDataTypeID.ClientID %>").val(list[0][0]);
                    break;
                case 3:
                    rowObj.cells[3].children[0].value = list[0][1];
                    rowObj.cells[3].children[2].value = list[0][0];
                    condition = list[0][0];
                    break;
                case 4:
                    rowObj.cells[1].children[0].value = list[0][1];
                    rowObj.cells[1].children[2].value = list[0][0];
                    break;
                case 5:
                    rowObj.cells[1].children[0].value = list[0][1];
                    rowObj.cells[2].children[0].value = "";

                    break;
                default:
                    break;
            }
        }

        //删除容器信息包装列表信息
        function deleteItem(obj) {
            var action = '<%=Request.QueryString["Action"] %>';
            if (action == "Copy" || cONTAINERId == -1) {
                tab.deleteRow(obj.parentElement.parentElement.rowIndex);
            }
            else {
                if (!window.confirm("<%=Resources.Messages.ConfirmDelete %>")) {
                    return false;
                }
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxContainer.ContainerPackingLevelDelete(obj.parentElement.parentElement.cells[5].children[1].value);
                if (ajax) {
                    tab.deleteRow(obj.parentElement.parentElement.rowIndex);
                }
            }
        }

        //删除文档列表
        function deleteDocument(obj) {
            var action = '<%=Request.QueryString["Action"] %>';
            if (action == "Copy" || cONTAINERId == -1) {
                tabDocument.deleteRow(obj.parentElement.parentElement.rowIndex);
            }
            else {
                if (!window.confirm("<%=Resources.Messages.ConfirmDelete %>")) {
                    return false;
                }
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxContainer.ContainerDocumentDelete(obj.parentElement.parentElement.cells[0].children[1].value);
                if (ajax) {
                    tabDocument.deleteRow(obj.parentElement.parentElement.rowIndex);
                }
            }
            $("#Documents tr:gt(0)").each(function (i) {
                $(this).children("td:eq(0)").children("input[type='text']").val(i + 1);
            });
        }

        function change(obj) {
            rowObj = obj.parentElement.parentElement;
            if (rowObj.cells[0].children[0].value != "Item") {
                rowObj.cells[2].children[0].disabled = true;
                rowObj.cells[3].children[1].disabled = true;
            }
            else {
                rowObj.cells[2].children[0].disabled = false;
                rowObj.cells[3].children[1].disabled = false;
            }
            rowObj.cells[1].children[0].value = "";
        }

        function toDecimal(x) {
            var f = parseFloat(x);
            if (isNaN(f)) {
                return 0;
            }
            else {
                return f;
            }
        }

        /**
        *检测包装数量
        **/
        function checkQty(obj) {
            var minQty = $(obj).parent().parent().find("input[name=txtMinQty]:eq(0)").val();
            var maxQty = $(obj).parent().parent().find("input[name=txtMaxQty]:eq(0)").val();
            if (parseInt(minQty) > parseInt(maxQty)) {
                alert("最小数量不能大于最大数量！");
                $(obj).focus();
                //return false;
            }
        }
    </script>
</asp:Content>
