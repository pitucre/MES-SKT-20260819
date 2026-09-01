<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CheckListToChoose.aspx.cs"
    MasterPageFile="~/Masters/ViewMaster.master" Inherits="SKT.LeanMES.Web.MaterialCheck.CheckListToChoose" ValidateRequest="false" %>

<%@ MasterType VirtualPath="~/Masters/ViewMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="server">
    <table class="EditeContentTable" width="100%" id="searchField_content">
        <tr>
            <td class="Label2">
                <input type="checkbox" name="box" id="chkMatchWholeWord" />
            </td>
            <td class="Field2" colspan="3">物料款数
                <asp:TextBox ID="txtGetQty" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">仓库</td>
            <td class="Field2">
                <asp:TextBox ID="txtWhCodeOne" runat="server" CssClass="TextBox" Width="80%"></asp:TextBox><input id="button1" class="ButtonBox" type="button" onclick="selectWhCodeList()"
                    value="..." title="选择仓库" />
                <asp:HiddenField ID="hdnWhCodeOne" runat="server" Value="" ClientIDMode="Static" />
                <asp:HiddenField ID="hdnWhIDOne" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
            <td class="Label2">~</td>
            <td class="Field2">
                <asp:TextBox ID="txtWhCodeTwo" runat="server" CssClass="TextBox" Width="80%"></asp:TextBox><input id="button2" class="ButtonBox" type="button" onclick="selectWhCodeListTwo()"
                    value="..." title="选择仓库" />
                <asp:HiddenField ID="hdnWhCodeTwo" runat="server" Value="" ClientIDMode="Static" />
                <asp:HiddenField ID="hdnWhIDTwo" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
        </tr>
        <tr>
            <td class="Label2">库位条码
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtBarcode" runat="server" CssClass="TextBox"></asp:TextBox></td>
            <td class="Label2">~
            </td>
            <td>
                <asp:TextBox ID="txtBarcodeTwo" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">物料编码
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtItemCode" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>

            <td class="Label2">~
            </td>
            <td>
                <asp:TextBox ID="txtItemCodeTwo" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">供应商
            </td>
            <td class="Field2">
                <input type="text" id="txtVendorCode" class="TextBox" disabled="disabled" value="" /><input
                    type="button" id="btnSelectSupplier" class="ButtonBox" value="..." onclick="selectSupplier()" />
                <input type="hidden" value="" id="hdnVendorCode" />
            </td>

            <td class="Label2">ABC等级</td>
            <td class="Field2">
                <asp:DropDownList runat="server" ID="ddlItemABC" ClientIDMode="Static">
                    <asp:ListItem Value="" Selected="True">=请选择=</asp:ListItem>
                    <asp:ListItem Value="A">A</asp:ListItem>
                    <asp:ListItem Value="B">B</asp:ListItem>
                    <asp:ListItem Value="C">C</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="Label2" colspan="4" style="text-align: center">
                <input type="button" id="searchSubmit" value="查询" onclick="doSearch()"
                    class="SearchButton" title="<%=Resources.lang.Search %>" />&nbsp;&nbsp;
                <input type="button" id="Button1" value="清空" onclick="clearSearch()" class="SearchButton"
                    title="清空查询条件" />
            </td>
        </tr>
    </table>
    <div id="msg" style="text-align: left;">
        <span id="showMessage"></span>
    </div>
    <!--<div id="msg" style="text-align: left; font-size: 18px">
        物料条码明细&nbsp;&nbsp;<input type="button" id="searchSubmit" value="更多" onclick="GetAdd()"
            class="SearchButton" title="<%=Resources.lang.Search %>" />
        <span id="showMessage"></span>
    </div> -->
    <div class="EditeContentTable" id="infotab" width="100%">
    </div>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="search" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script type="text/javascript">
        var startRow = 0; //从第几行开始查询
        var maxRow = -1; //每次查询多少行
        var sortExpression = ""; //排序列
        var searchSettings = ""; //查询条件
        var searchCount = 0; //查询的记录
        var IsSearchComplety = 0;//0没有查询完成,1查询完成
        var SearchAllGRN = []; //查询数据
        var warehouseCheckOrderId = '<%=Request.QueryString["OrderID"]%>';
        $(function () {
            // doSearch();
            SearchAllGRN = [];
        });

        function clearSearch() {
            $("#searchField_content input[type=text]").val("");
            $("#searchField_content input[type=hidden]").val("");
            $("#searchField_content select option:first").prop("selected", "selected");
            doRefresh();
        }
        function getSelectedValues() {
            var selValues = "";
            var checkboxs = document.getElementsByName("chkSelect");
            var checkboxCount = checkboxs.length;

            for (var i = 0; i < checkboxCount; i++) {
                if (checkboxs[i].checked) {
                    if (selValues != "") {
                        selValues += ",";
                    }

                    selValues += checkboxs[i].value;
                }
            }
            return selValues;
        }

        //选择仓库One
        function selectWhCodeList() {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=14&Multiple=false&CallBackFunc=setWhCode&rnd=" + Math.random(), width: 500, height: 300 });
        }
        function setWhCode(list) {
            searchWhCodeId = list[0][0];
            var whCodes = list[0][1] + "|" + list[0][2];
            if (list[0][0] == "-1") {
                whCodes = "";
            }
            $("#<%=this.txtWhCodeOne.ClientID %>").val(whCodes);
            $("#hdnWhIDOne").val(list[0][0]);
            $("#hdnWhCodeOne").val(list[0][1]);
        }

        //选择仓库Two
        function selectWhCodeListTwo() {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=14&Multiple=false&CallBackFunc=setWhCodeTwo&rnd=" + Math.random(), width: 500, height: 300 });
        }
        function setWhCodeTwo(list) {
            var whCodes = list[0][1] + "|" + list[0][2];
            if (list[0][0] == "-1") {
                whCodes = "";
            }
            $("#<%=this.txtWhCodeTwo.ClientID %>").val(whCodes);
            $("#hdnWhIDTwo").val(list[0][0]);
            $("#hdnWhCodeTwo").val(list[0][1]);
        }

        function selectSupplier() {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=34&Multiple=false&rnd=" + Math.random(), width: 612, height: 300 });
        }

        function getChooseValue(list) {
            $("#txtVendorCode").val(list[0][1]);
            vendorCode = list[0][1];
            $("#hdnVendorCode").val(vendorCode);
        }
        //获取更多数据
        function GetAdd() {
            AddSearch();
        }
        var getQty = 0;
        function AddSearch() {
            var addHtmlStr = "";
            getQty = $("#<%=this.txtGetQty.ClientID %>").val();
            if (IsSearchComplety == 1) {
                $("#showMessage").html("数据已经全部加载完成");
            } else {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxWarehouseCheck.GetMaterialToChoose(startRow, maxRow, sortExpression, searchSettings);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                else {
                    $("#showMessage").html("");
                    var list = ajax.value;
                    startRow = startRow + list.length;
                    if (list.length < maxRow) {
                        IsSearchComplety = 1;
                    }
                    for (var i = 0; i < list.length; i++) {
                        if (i % 2 == 0) {
                            addHtmlStr += "<tr class='ListTableEvenRow' >";
                        }
                        else {

                            addHtmlStr += "<tr class='ListTableOddRow'>";
                        }
                        searchCount = searchCount + 1;
                        //填充数据
                        SearchAllGRN.push({ "GRN": list[i].GRN, "BarCode": list[i].WhBarcode, "ItemCode": list[i].ItemCode, "ItemDesc": list[i].Item, "RowId": searchCount });

                        //如果物料有数据


                        addHtmlStr += "<td>" + (searchCount) + "</td>"
                               + "<td>" + list[i].WhBarcode + "</td>"
                               + "<td>" + list[i].ItemCode + "</td>"
                               + "<td>" + list[i].Item + "</td>"
                               + "<td>" + list[i].GRN + "</td>"
                               + "<td>" + list[i].ABCCLass + "</td>"
                               + "<td>" + list[i].VendorCode + "</td>"
                             
                        + "</tr>";
                    }
                    $("#tbBuyOrderDetail tbody").append(addHtmlStr);
                }
            }
        }


        function Clear() {
            $("#infotab").html("");
            startRow = 0; //从第几行开始查询
            maxRow = 10000; //每次查询多少行
            sortExpression = ""; //排序列
            searchSettings = ""; //查询条件
            searchCount = 0; //查询的记录
            IsSearchComplety = 0;//0没有查询完成,1查询完成
            $("#showMessage").html("");
        }
        //查询加载数据
        var searchWhCodeId = -1; //仓库Id
        function doSearch() {
            Clear();
            GetSearchAll();
            getQty = $("#<%=this.txtGetQty.ClientID %>").val();
            if (whCodeOne == "") {
                alert("请选择仓库!");
                return false;
            }
            //chkMatchWholeWord   物料取数被选中了，需填写数量
            if ($('#chkMatchWholeWord').is(":checked")) {
                if (getQty == "") {
                    alert("请填写物料款数!");
                    return false;
                }
                if (searchWhCodeId == -1) {
                    alert("请选择对应的仓库!");
                    return false;
                }
            }
            if (getQty != "") {
                if (!isPositiveNum($("#<%=this.txtGetQty.ClientID %>"))) {
                    return false;
                }
                else {
                    maxRow = getQty;
                }
            }
            //  if (!$('#chkMatchWholeWord').is(":checked")) {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxWarehouseCheck.GetMaterialToChoose(startRow, maxRow, sortExpression, whCodeOne, whCodeTwo, BarCodeOne, BarCodeTwo, itemCodeOne, itemCodeTwo, warehouseCheckOrderId, venCode, itemLevel);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            else {
                var htmlstr = "<table width='100% ' class='ListTable' id='tbBuyOrderDetail'><thead><tr class='ListTableHeader'>"
                + "<th>行号</th><th>库位条码</th><th>物料编码</th><th>物料描述</th><th>GRN</th><th>ABC等级</th><th>供应商编码</th></tr></thead>";
                var list = ajax.value;
                $("#showMessage").html("当前记录数:" + list.length + "");
                startRow = startRow + list.length;
                //如果查询的条数<最大行数据，说明一次性已经查询出来，maxRow = 1
                if (list.length < maxRow) {
                    startRow = list.length;
                    IsSearchComplety = 1;
                }
                else {
                    startRow = list.length;
                }
                for (var i = 0; i < list.length; i++) {
                    if (i % 2 == 0) {
                        htmlstr += "<tr class='ListTableEvenRow'  id=" + list[i].GRN + ">";
                    }
                    else {

                        htmlstr += "<tr class='ListTableOddRow' id=" + list[i].GRN + ">";
                    }
                    searchCount = searchCount + 1;
                    SearchAllGRN.push({ "GRN": list[i].GRN, "BarCode": list[i].WhBarcode, "ItemCode": list[i].ItemCode, "ItemDesc": list[i].Item, "RowId": searchCount });
                    htmlstr += "<td>" + searchCount + "</td>"
                           + "<td  name ='barCode'>" + list[i].WhBarcode + "</td>"
                           + "<td  name ='itemCode'>" + list[i].ItemCode + "</td>"
                           + "<td  name ='item'>" + list[i].Item + "</td>"
                           + "<td  name ='grn'>" + list[i].GRN + "</td>"
                           + "<td>" + list[i].ABCCLass + "</td>"
                           + "<td>" + list[i].VendorCode + "</td>"
                         
                    + "</tr>";
                }
                $("#infotab").html(htmlstr + "</table>");
                /*  for (var i = 0; i < getQty; i++) {
                      $(":checkbox[id='checkBox" + (i + 1) + "']").prop("checked", true);
                  }*/
            }
            //  }
        }

        //获取查询条件
        var whCodeOne = "";
        var whCodeTwo = "";
        var BarCodeOne = "";
        var BarCodeTwo = "";
        var itemCodeOne = "";
        var itemCodeTwo = "";
        var venCode = "";
        var itemLevel = "";

        function GetSearchAll() {
            whCodeOne = $("#hdnWhCodeOne").val();
            whCodeTwo = $("#hdnWhCodeTwo").val();
            BarCodeOne = $("#<%=this.txtBarcode.ClientID %>").val();
            BarCodeTwo = $("#<%=this.txtBarcodeTwo.ClientID %>").val();
            itemCodeOne = $("#<%=this.txtItemCode.ClientID %>").val();
            itemCodeTwo = $("#<%=this.txtItemCodeTwo.ClientID %>").val();
            itemLevel = $("#<%=this.ddlItemABC.ClientID%>").val();
            venCode = $("#hdnVendorCode").val();
            SearchAllGRN = [];
        }

        function isPositiveNum(obj) {//是否为正整数
            var s = $(obj).val();
            var re = /^[0-9]*[0-9][0-9]*$/;
            if (!re.test(s)) {
                alert("请输入正整数！");
                $(obj).val("");
                $(obj).focus();
                return false;
            } else {
                return true;
            }
        }
    </script>
</asp:Content>
