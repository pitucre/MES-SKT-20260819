<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditHeadMaster.master"
    AutoEventWireup="true" CodeBehind="MateriaPOChoose.aspx.cs" Inherits="SKT.LeanMES.Web.Material.MateriaPOChoose" %>

<%@ MasterType VirtualPath="~/Masters/EditHeadMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label3">
                供应商编号:
            </td>
            <td class="Field3">
                <div style="display: inline-block;">
                    <asp:HiddenField runat="server" ID="hdnVendorCode" Value="" />
                    <asp:HiddenField runat="server" ID="hdnVendorName" Value="" />
                    <asp:TextBox ID="txtVendorCode" runat="server" CssClass="TextBox vendor"></asp:TextBox>
                    <input type="button" id="btnSelectVendor" class="ButtonBox vendor" value="..." title="选择供应商"
                        onclick="selectVendor();" />
                    <%if (SKT.LeanMES.Web.AccountController.GetCurrentUser().UserType == -1)
                      {%>
                    &nbsp;&nbsp;<a href="#" onclick="clearAll(this)">清空</a>
                    <%} %>
                </div>
                <div style="clear: both;">
                    <asp:Label ID="lblVendorName" runat="server" Text=""></asp:Label>
                </div>
            </td>
            <td class="Label3">
                采购单号:
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtPoNum" runat="server" CssClass="TextBox"></asp:TextBox>
                <input type="button" id="btnSelectPO" class="ButtonBox" value="..." title="选择采购订单"
                    onclick="selectPoList();" />
            </td>
            <td class="Label3">
                物料编号：
            </td>
            <td class="Field3">
                <div style="display: inline-block;">
                    <asp:HiddenField runat="server" ID="hdnItemCode" Value="" />
                    <asp:HiddenField runat="server" ID="hdnItemName" Value="" />
                    <asp:TextBox ID="txtItemCode" runat="server" CssClass="TextBox"></asp:TextBox>
                    <input type="button" id="btnItemCode" class="ButtonBox" value="..." title="选择物料"
                        onclick="selectItem();" />&nbsp;&nbsp;<a href="#" onclick="clearAll(this)">清空</a>
                </div>
                <div style="clear: both;">
                    <asp:Label ID="lblItemName" runat="server" Text=""></asp:Label>
                </div>
            </td>
        </tr>
        <tr>
            <td class="Label3">
                下单日期：
            </td>
            <td class="Field3">
                <div style="display:inline-block;">
                <asp:TextBox runat="server" ID="txtPODateFrom" CssClass="DateTimeBox"></asp:TextBox>
                -
                <asp:TextBox runat="server" ID="txtPODateTo" CssClass="DateTimeBox"></asp:TextBox>
                </div>
            </td>
            <td class="Label3">
                订单状态：
            </td>
            <td class="Field" align="center" colspan="3">
                <span style="float: left;">
                    <asp:CheckBox ID="ckbPOState" runat="server" Text="未完成" />
                </span><span style="width: 150px; text-align: center">
                    <input type="button" value="查询" class="SearchButton" onclick="Search()" />
                </span>
            </td>
        </tr>
        <tr style="display: none;">
            <td class="Label3">
                供应商:
            </td>
            <td class="Field3">
            </td>
            <td class="Label3">
                下单日期
            </td>
            <td class="Field3">
                <asp:Label ID="lbPoDate" runat="server"></asp:Label>
            </td>
            <td class="Label3">
                订单状态:
            </td>
            <td class="Field3">
                <asp:Label ID="lbState" runat="server"></asp:Label>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <div class="clear5">
    </div>
    <div class="ListTableTitle">
        <span>
            <img src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/images/icon/list.png" style="float: left;
                vertical-align: middle; margin-right: 5px;" />采购订单明细 </span><span style="float: right;
                    margin-right: 10px;">
                    <asp:Label ID="lbSuplier" runat="server"></asp:Label></span>
    </div>
    <asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <asp:BoundField DataField="FBILLNO" HeaderText="采购单号" />
            <asp:BoundField DataField="FEntryid" HeaderText="行号" />
            <asp:BoundField DataField="FPartNO" HeaderText="物料代码" />
            <asp:BoundField DataField="FName" HeaderText="物料名称" />
            <asp:BoundField DataField="PODate" HeaderText="下单日期" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
            <asp:BoundField DataField="FDATE" HeaderText="交货日期" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
            <asp:BoundField DataField="FQty" HeaderText="订单数量" DataFormatString="{0:F3}" />
            <asp:BoundField DataField="FMESQty" HeaderText="已打印物料数量" DataFormatString="{0:F3}" />
            <asp:BoundField DataField="FReturnQty" HeaderText="退货数量" DataFormatString="{0:F3}" />
            <asp:BoundField DataField="FSTATUS" HeaderText="行状态" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Material.BLL.ERPPOorderEntry"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <div class="clear5">
    </div>
    <div class="clear5">
    </div>
    <div class="ListTableTitle" id="divDetail" style="display: none;">
        <span>
            <img src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/images/icon/list.png" style="float: left;
                vertical-align: middle; margin-right: 5px;" />已生成GRN列表</span> <span style="float: right;
                    margin-right: 10px; font-weight: normal;"><span id="PageContent" style="display: none;">
                        共有 <span id="TotalCounts"></span>条记录，每页 <span id="PageSize"></span>条，共 <span id="TotalPages">
                        </span>页，当前第 <span id="CurrentPageIndex"></span>页 &nbsp;&nbsp;&nbsp;&nbsp;<span id="PageInfo"></span></span></span>
    </div>
    <div id="divChoosableData" style="overflow: auto; width: 100%; text-align: center;">
    </div>
    <asp:HiddenField ID="hdnVendorCodr" runat="server" Value="" />
    <asp:HiddenField ID="hdnPagenationBillNo" runat="server" Value="" />
    <asp:HiddenField ID="hdnPagenationItemCode" runat="server" Value="" />
    <script type="text/javascript">
        var vendorCode = $('#<%=this.hdnVendorCodr.ClientID%>').val();
        var supID = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserType %>';

        /*分页信息 每页显示的记录数*/
        var _PAGESIZE = 10;

        function selectPoList() {
            var selVendorCode = $("#<%=this.hdnVendorCode.ClientID %>").val();
            var searchCondition = "";
            /*如果是供应商则选择采购订单时只能选择本供应商自己的采购订单 Modify By Alen 2015-06-19*/
            if (supID > 0) {
                searchCondition = " vendorCode='" + vendorCode + "'";
                dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=36&PageCondition=" + escape(searchCondition) + "&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
            }
            else {
                if (selVendorCode != "") {
                    searchCondition = " vendorCode='" + selVendorCode + "'";
                    dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=36&PageCondition=" + escape(searchCondition) + "&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
                }
                else {
                    dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=36&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
                }
            }
        }

        /*选择供应商*/
        function selectVendor() {
            if (supID == -1) {
                dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=34&Multiple=false&CallBackFunc=setVendorInfo&rnd=" + Math.random(), width: 600, height: 300 });
            }
        }

        /*选择物料*/
        function selectItem() {
            if (supID == -1) {
                dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=46&Multiple=false&CallBackFunc=setItemInfo&rnd=" + Math.random(), width: 600, height: 300 });
            }
        }

        /*Add By Alen Liu 2015-07-30 根据供应商编码获取供应商信息*/
        function ValidateVedorInfo() {
            var vendorInfo = $("#<%=this.txtVendorCode.ClientID %>").val();
            if (vendorInfo == "") return false;
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.ValidateVedorInfo(vendorInfo);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var entity = ajax.value;

            if (entity == null) {
                alert("请输入正确的供应商编号或名称，您也可以点击右侧按钮选择供应商");
                $("#<%=this.hdnVendorCode.ClientID %>").val("");
                $("#<%=this.txtVendorCode.ClientID %>").val("");
                $("#<%=this.lblVendorName.ClientID %>").text("");
                $("#<%=this.hdnVendorName.ClientID %>").val("");
                $("#<%=this.txtVendorCode.ClientID %>").focus();
                return false;
            }

            $("#<%=this.hdnVendorCode.ClientID %>").val(entity.VendorCode);
            $("#<%=this.txtVendorCode.ClientID %>").val(entity.VendorCode);
            $("#<%=this.lblVendorName.ClientID %>").text(entity.VendorName);
            $("#<%=this.hdnVendorName.ClientID %>").val(entity.VendorName);
            $("#<%=this.txtPoNum.ClientID %>").focus();
        }

        /*Add By Alen Liu 2015-07-30 根据物料编码获取物料信息*/
        function ValidateItemInfo() {
            var itemInfo = $("#<%=this.txtItemCode.ClientID %>").val();
            if (itemInfo == "") return false;
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.ValidateItemInfo(itemInfo);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var entity = ajax.value;

            if (entity == null) {
                alert("请输入正确的物料编号或名称，您也可以点击右侧按钮选择物料");
                $("#<%=this.hdnItemCode.ClientID %>").val("");
                $("#<%=this.txtItemCode.ClientID %>").val("");
                $("#<%=this.lblItemName.ClientID %>").text("");
                $("#<%=this.hdnItemName.ClientID %>").val("");
                $("#<%=this.txtItemCode.ClientID %>").focus();
                return false;
            }

            $("#<%=this.hdnItemCode.ClientID %>").val(entity.ItemCode);
            $("#<%=this.txtItemCode.ClientID %>").val(entity.ItemCode);
            $("#<%=this.lblItemName.ClientID %>").text(entity.ItemName);
            $("#<%=this.hdnItemName.ClientID %>").val(entity.ItemName);
        }

        /*设置供应商信息*/
        function setVendorInfo(list) {
            $("#<%=this.hdnVendorCode.ClientID %>").val(list[0][1]);
            $("#<%=this.txtVendorCode.ClientID %>").val(list[0][1]);
            $("#<%=this.lblVendorName.ClientID %>").text(list[0][2]);
            $("#<%=this.hdnVendorName.ClientID %>").val(list[0][2]);
            $("#<%=this.txtPoNum.ClientID %>").focus();
        }

        /*设置物料信息*/
        function setItemInfo(list) {
            $("#<%=this.hdnItemCode.ClientID %>").val(list[0][1]);
            $("#<%=this.txtItemCode.ClientID %>").val(list[0][1]);
            $("#<%=this.lblItemName.ClientID %>").text(list[0][2]);
            $("#<%=this.hdnItemName.ClientID %>").val(list[0][2]);
        }

        /*生成GRN*/
        function GenerateGRN() {
            var pono = $("input:[name='chkSelect']:checked").val();
            var lineNo = $("input:[name='chkSelect']:checked").parent().next().next().text();

            //物料编码
            var materailCode = $.trim($("input:[name='chkSelect']:checked").parent().next().next().next().text());

            if (pono == "") {
                alert("请选择要生成GRN的物料！");
                return false;
            }

            if (lineNo == "") {
                alert("请至少选择一行采购订单的物料来生成GRN");
                return false;
            }

            dialog({ title: "<%= Resources.Pages.Material_GenerateGRN %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Material/GenerateGRN.aspx?name=Material_GenerateGRN&LineNo=" + lineNo + "&PONO=" + pono + "&MaterialCode=" + materailCode, width: 625, height: 300 });
        }

        function getChooseValue(list) {
            $("#<%=this.txtPoNum.ClientID%>").val(list[0][2]);
        }

        function Search() {
            document.forms[0].submit();
        }

        $(function () {
            $("#<%=this.txtPoNum.ClientID %>").enterKey("getPOInfo");
            $("#<%=this.txtVendorCode.ClientID %>").enterKey("ValidateVedorInfo");
            $("#<%=this.txtItemCode.ClientID %>").enterKey("ValidateItemInfo");

            $("#<%=this.txtPoNum.ClientID %>").change(function () { getPOInfo(); });
            $("#<%=this.txtVendorCode.ClientID %>").change(function () { ValidateVedorInfo(); });
            $("#<%=this.txtItemCode.ClientID %>").change(function () { ValidateItemInfo(); });

            $("#<%=this.txtVendorCode.ClientID %>").change(function () {
                if ($(this).val() == "") {
                    clearAll(this);
                }
            });

            /*如果是供应商则不允许选择供应商 Add By Alen 2015-07-30*/
            if (supID > 0) {
                $(".vendor").attr("disabled", "disabled");
            }
            else {
                $(".vendor").removeAttr("disabled");
            }

            $("#<%=this.lblVendorName.ClientID %>").text($("#<%=this.hdnVendorName.ClientID %>").val());
            $("#<%=this.lblItemName.ClientID %>").text($("#<%=this.hdnItemName.ClientID %>").val());
            $("#<%=this.txtVendorCode.ClientID %>").val($("#<%=this.hdnVendorCode.ClientID %>").val());
        });

        function getPOInfo() {
            $("#<%=this.txtItemCode.ClientID %>").focus();
            //document.forms[0].submit();
        }

        /*单击行 获取行对应的GRN信息*/
        function clk(obj) {
            $("#divDetail").css('display', 'block');
            $("#divChoosableData").html("<span class='Tips'>正在加载数据，请稍后...</span>");
            setTimeout(function () {
                $(".ListTable input[type=checkbox]").each(function () {
                    $(this)[0].checked = false;
                });

                $(obj).children("td:eq(0)").children("input[type=checkbox]")[0].checked = true;

                //采购单号
                var poCode = $(obj.cells[1]).text();
                //物料编码
                var itemCode = $(obj.cells[3]).text();
                //行号
                var lineno=$(obj.cells[2]).text();

                $("#<%=this.hdnPagenationBillNo.ClientID %>").val(poCode);
                $("#<%=this.hdnPagenationItemCode.ClientID %>").val(itemCode);

                var searchSettings = {};
                searchSettings.ExtensionCondition = " [FBILLNO] = '" + poCode + "' and [ItemCode] = '" + itemCode + "' and FEntryid = " + lineno ;
                var sortExpression = " CreationTime DESC ";
                var startRow = 0;
                var maxRows = _PAGESIZE;
                GetPoLineList(startRow, maxRows, sortExpression, searchSettings, 1);
            }, 100);
        }

        /*分页获取采购订单行对应的GRN*/
        function GetPoLineList(startRow, maxRows, sortExpression, searchSettings, pageIndex) {
            var ajax_table = SKT.LeanMES.Web.AjaxServices.AjaxERPPOorder.GetPOEntryByBillNum(startRow, maxRows, sortExpression, searchSettings);
            if (ajax_table.error != null) {
                alert(ajax_table.error.Message);
                return false;
            }

            var objArr = ajax_table.value;
            var list = objArr[0];
            var totalCount = objArr[1];

            var strHtml = "";
            if (list.length == 0) {
                $("#divDetail").show();
                $("#PageContent").hide(); /*没有数据则隐藏分页信息*/
                strHtml += "<table width='100%' class='ListTable'><tr class='ListTableEmptyDataRow'><td>该物料还没有生成任何GRN</td></tr></table>";
                $("#divChoosableData").html(strHtml);
                return false;
            }

            /*设置列表信息*/
            strHtml += "<table style='width:100%;height:auto;' id='leftTab' class='ListTable'>";
            strHtml += "<tr class='ListTableHeader'>"
                              + "<th>#</th>"
                              + "<th>GRN</th>"
                              + "<th>最小包装数量</th>"
                              + "<th>批次号</th>"
                              + "<th>供应商</th>"
                              + "<th>物料代码</th>"
                              + "<th>物料名称</th>"
                              + "</tr>";


            var strclass = "";
            for (var i = 0; i < list.length; i++) {
                if (i % 2 == 0) {
                    strclass = "ListTableOddRow";
                }
                else {
                    strclass = "ListTableEvenRow";
                }
                strHtml += "<tr class='" + strclass + "'>";
                strHtml += "<td>" + (i + 1) + "</td>";
                strHtml += "<td>" + list[i].SerialNumber + "</td>";
                strHtml += "<td>" + list[i].BalanceQty + "</td>";
                strHtml += "<td>" + list[i].LotCode + "</td>";
                strHtml += "<td>" + list[i].VendorCode + "</td>";
                strHtml += "<td>" + list[i].FPartNO + "</td>";
                strHtml += "<td>" + list[i].FName + "</td>";
                strHtml += "</tr>";
            }
            strHtml += "<table>";
            $("#divChoosableData").html(strHtml);

            /*设置分页信息*/
            if (totalCount > 0) {
                $("#PageContent").show(); /*显示分页信息*/
                $("#TotalCounts").html(totalCount); /*记录总数*/
                $("#PageSize").html(_PAGESIZE); /*每页显示的记录数*/
                $("#TotalPages").html((totalCount % _PAGESIZE == 0) ? (totalCount / _PAGESIZE) : (parseInt(totalCount / _PAGESIZE) + 1)); /*总页数*/
                $("#CurrentPageIndex").html(pageIndex); /*当前页索引*/
                /*设置分页连接*/
                var pageLink = "";
                var k = (parseInt(pageIndex / 10) <= 1 && (pageIndex % 10)==0) ? 1 : (parseInt(pageIndex / 10) * 10 + 1);
                if (k > 1) {
                    pageLink += "<a href='#' onclick='PageChanged(0," + _PAGESIZE + ",1)'>首页</a>&nbsp;&nbsp;"
                    pageLink += "<a href='#' onclick='PageChanged(" + (parseInt((k - 10) / 10) * _PAGESIZE + 1) + "," + _PAGESIZE + "," + (k - 10) + ")'>...</a>&nbsp;&nbsp;";
                }
                for (var i = k; i < (((k + 10) < (parseInt(totalCount / _PAGESIZE) + 1)) ? (k + 10) : (parseInt(totalCount / _PAGESIZE) + 2)); i++) {
                    
                    if (i == pageIndex) {
                        pageLink += "<span>" + i + "</span>&nbsp;&nbsp;";
                    }
                    else {

                        pageLink += "<a href='#' onclick='PageChanged(" + ((i - 1) * _PAGESIZE) + "," + _PAGESIZE + "," + i + ")'>" + i + "</a>&nbsp;&nbsp;";
                    }
                }
                if ((k + 10) < (parseInt(totalCount / _PAGESIZE) + 1)) {
                    pageLink += "<a href='#' onclick='PageChanged(" + (parseInt((k + 10) / 10) * _PAGESIZE + 1) + "," + _PAGESIZE + "," + (k + 10) + ")'>...</a>&nbsp;&nbsp;";
                    var totalPages = (totalCount % _PAGESIZE == 0) ? (totalCount / _PAGESIZE) : (parseInt(totalCount / _PAGESIZE) + 1);
                    pageLink += "<a href='#' onclick='PageChanged(" + (((totalPages/_PAGESIZE)-1)*_PAGESIZE) + "," + _PAGESIZE + "," + totalPages + ")'>尾页</a>";
                }

                $("#PageInfo").html(pageLink);
            }
        }

        function PageChanged(startRow, maxRows, pageIndex) {
            var poCode = $("#<%=this.hdnPagenationBillNo.ClientID %>").val();
            var itemCode = $("#<%=this.hdnPagenationItemCode.ClientID %>").val();

            var searchSettings = {};
            searchSettings.ExtensionCondition = " [FBILLNO] = '" + poCode + "' and [ItemCode] = '" + itemCode + "' ";
            var sortExpression = " CreationTime DESC ";
            GetPoLineList(startRow, maxRows, sortExpression, searchSettings, pageIndex);
        }

        //双击行
        function dblClk(obj) {
            //采购单代码
            var pono = $(obj).find('input[type=checkbox]').val();
            var lineNo = $(obj.cells[2]).text();

            if (pono == "") {
                alert("采购单号码为空，请选择采购单号重新获取采购订单内容！");
                return false;
            }

            //物料编码
            var materailCode = $(obj.cells[3]).text();

            dialog({ title: "<%= Resources.Pages.Material_GenerateGRN %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Material/GenerateGRN.aspx?name=Material_GenerateGRN&LineNo=" + lineNo + "&PONO=" + pono + "&MaterialCode=" + materailCode, width: 625, height: 300 });
        }
         
        //UTC时间转换为正常时间格式
        function utcToDate(utcCurrTime) {
            utcCurrTime = utcCurrTime + "";
            var date = "";
            var month = new Array();
            month["Jan"] = 1;
            month["Feb"] = 2;
            month["Mar"] = 3;
            month["Apr"] = 4;
            month["May"] = 5;
            month["Jun"] = 6;
            month["Jul"] = 7;
            month["Aug"] = 8;
            month["Sep"] = 9;
            month["Oct"] = 10;
            month["Nov"] = 11;
            month["Dec"] = 12;
            var week = new Array();
            week["Mon"] = "一";
            week["Tue"] = "二";
            week["Wed"] = "三";
            week["Thu"] = "四";
            week["Fri"] = "五";
            week["Sat"] = "六";
            week["Sun"] = "日";
            str = utcCurrTime.split(" ");
            date = str[5] + "-";
            date = date + month[str[1]] + "-" + str[2] + "-" + str[3];
            return date;
        }

        function CloseDlg() {
            document.forms[0].submit();
        }

        function clearAll(obj) {
            $(obj).parent().children("input").val("");
            $(obj).parent().next().children("span").html("");
            $(obj).parent().children("input[type=button]").val("...");
        }

        function Close() {
            try {
                closeDialog();
            }
            catch (e) { alert(e.Message) }
        }
    </script>
</asp:Content>
