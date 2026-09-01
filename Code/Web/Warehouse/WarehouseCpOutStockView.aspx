<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true"
    CodeBehind="WarehouseCpOutStockView.aspx.cs" Inherits="SKT.LeanMES.Web.Warehouse.WarehouseCpOutStockView" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
        <link href="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/css/layui.css" rel="stylesheet" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/layui.all.js"></script>
    <table width="100%" class="ContentTable">
        <tr>
            <td class="Label3">备货单号</td>
            <td class="Field3">
                <asp:TextBox CssClass="TextBox" runat="server" ID="DNCode"></asp:TextBox>
            </td>
            <td class="Label3">订单号</td>
            <td class="Field3">
                <asp:TextBox CssClass="TextBox" runat="server" ID="txtCustomerOrder"></asp:TextBox>
            </td>
            <td class="Label3"><%=Resources.lang.SalOrder %></td>
            <td class="Field3">
                <asp:TextBox CssClass="TextBox" runat="server" ID="txtSalOrderNo"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label3">客户编码</td>
            <td class="Field3">
                <asp:TextBox CssClass="TextBox" runat="server" ID="txtsup"></asp:TextBox>
            </td>
            <td class="Label3">产品编码</td>
            <td class="Field3">
                <asp:TextBox CssClass="TextBox" runat="server" ID="txtmat"></asp:TextBox>
            </td>
            <td class="Label3">状态</td>
            <td class="Field3">
                <asp:DropDownList runat="server" ID="ddlStatus" ClientIDMode="Static">
                    <asp:ListItem Value="-1">请选择</asp:ListItem>
                    <asp:ListItem Value="1">备货中</asp:ListItem>
                    <asp:ListItem Value="2">备货完成</asp:ListItem>
                    <asp:ListItem Value="3">已检验</asp:ListItem>
                    <asp:ListItem Value="4">已出货</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="Label3">备货日期
            </td>
            <td class="Field3">
                <input type="text" id="txtStrDate" class="DateTimeBox" runat="server" readonly />
                -
                <input type="text" id="txtEndDate" class="DateTimeBox" runat="server" readonly />
            </td>
            <td class="Label3">
            </td>
            <td class="Field3" >
            </td>
            <td class="Label3">
            </td>
            <td class="Field3">
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" Style="table-layout: fixed; word-wrap: break-word; word-break: break-all" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="DNCode" HeaderText="<%$Resources:lang,DNCode %>" HeaderStyle-Width="120px" SortExpression="DNCode" />
            <asp:BoundField DataField="SalOrderDate" HeaderText="备货日期" HeaderStyle-Width="130px" DataFormatString="{0:yyyy-MM-dd}" SortExpression="SalOrderDate" />
            <asp:BoundField DataField="SalOrderNo" HeaderText="<%$Resources:lang,SalOrder %>" HeaderStyle-Width="120px" SortExpression="SalOrderDate"/>
            <asp:BoundField DataField="StatusName" HeaderText="<%$Resources:lang,Status %>" HeaderStyle-Width="70px" SortExpression="StatusName"/>
            <asp:BoundField DataField="ItemCode" HeaderText="<%$Resources:lang,ItemCode %>" HeaderStyle-Width="140px" SortExpression="ItemCode"/>
            <asp:BoundField DataField="CustomerOrder" HeaderText="订单号" HeaderStyle-Width="120px" SortExpression="CustomerOrder"/>
            <asp:BoundField DataField="SalorderItem" HeaderText="项次" HeaderStyle-Width="120px"/>
            <asp:BoundField DataField="ItemName" HeaderText="<%$Resources:lang,ItemName %>" HeaderStyle-Width="140px" />
            <asp:BoundField DataField="PlanQty" HeaderText="<%$Resources:lang,PlanOutQty %>" HeaderStyle-Width="80px"  DataFormatString="{0:G0}" />
            <asp:BoundField DataField="CurrentQty" HeaderText="<%$Resources:lang,CurrentQty %>" HeaderStyle-Width="80px" DataFormatString="{0:G0}" />
            <asp:BoundField DataField="CusCode" HeaderText="<%$Resources:lang,ClientCode %>" HeaderStyle-Width="140px" />
            <asp:BoundField DataField="CusName" HeaderText="<%$Resources:lang,ClientName %>" HeaderStyle-Width="220px" />
            <asp:BoundField DataField="Address" HeaderText="<%$Resources:lang,ClientAddress %>" HeaderStyle-Width="140px" />
            <asp:BoundField DataField="CreateBy" HeaderText="<%$Resources:lang,CreateBy %>" HeaderStyle-Width="70px" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="<%$Resources:lang,CreateDateTime %>" HeaderStyle-Width="140px" SortExpression="CreateDateTime" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
            <asp:BoundField DataField="ModifyBy" HeaderText="<%$Resources:lang,ModifyBy %>" HeaderStyle-Width="70px" />
            <asp:BoundField DataField="ModifyDateTime" HeaderText="<%$Resources:lang,ModifyDateTime %>" HeaderStyle-Width="140px" SortExpression="ModifyDateTime" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
            <asp:BoundField DataField="FinishBy" HeaderText="<%$Resources:lang,DNFinishBy %>" HeaderStyle-Width="80px" />
            <asp:BoundField DataField="FinishDateTime" HeaderText="出货确认日期" HeaderStyle-Width="140px" DataFormatString="{0:yyyy-MM-dd}" ItemStyle-CssClass="date" SortExpression="FinishDateTime" />
            <asp:BoundField DataField="BackERPStatus" HeaderText="<%$Resources:lang,BackERPStatus %>" HeaderStyle-Width="80px" />
            <asp:TemplateField HeaderText="明细ID">
                <ItemStyle HorizontalAlign="Center" CssClass="hide" />
                <HeaderStyle HorizontalAlign="Center" CssClass="hide"/>
                <ItemTemplate>
                    <input type="hidden" name="SalOrderDtlID" value='<%#Eval("SalOrderDtlID") %>' />
                    <input type="hidden" name="SalOrderID" value='<%#Eval("SalOrderID") %>' />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true"
        StartRowIndexParameterName="startRow" MaximumRowsParameterName="maxRows" SortParameterName="sortExpression"
        TypeName="SKT.LeanMES.Warehouse.BLL.WarehouseCpOutStock" SelectMethod="GetStockOrderAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
 
   <%-- <script type="text/javascript" src="../Content/plugin/jquery-easyui-1.4.2/layer/layer.js"></script>--%>
<%--    <script type="text/javascript" src="../Content/js/layui.js"></script>--%>
    <script type="text/javascript">
        isMultiple = false;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");
        var gridId = "<%=this.GridView1.ClientID%>";
        $(function () {
  
            gridCellsChangeNo = true;

            //处理日期 0001-01-01
            $("#" + gridId + " td.date").each(function () {
                var val = $.trim($(this).text());
                if (val == "0001-01-01") {
                    $(this).text("");
                }
            });

        });
        var state = "";

        function encodeHtml(s) {
            return (typeof s != "string") ? s :
                s.replace(this.REGX_HTML_ENCODE,
                          function($0){
                              var c = $0.charCodeAt(0), r = ["&#"];
                              c = (c == 0x20) ? 0xA0 : c;
                              r.push(c); r.push(";");
                              return r.join("");
                          });
        };
        function View() {


            layui.use('layer', function () {


                var trObj = $("input[type=checkbox][name=chkSelect]:checked").parent().parent();
                var SalOrderDtlID = trObj.find("td input[type=hidden][name='SalOrderDtlID']").val();
                var SalOrderID = trObj.find("td input[type=hidden][name='SalOrderID']").val();

                //var No = $('input[name="chkSelect"]:checked').val();
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxCpOutStock.GetSalOrderMemberListDetails(SalOrderID);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                }
             
                var htmlstr = '<table class="ListTable" style="width:100%"><tbody><tr class="ListTableHeader"><th>' + mesLang('备货单号') + '</th><th>' + mesLang('数量') + '</th><th>' + mesLang('序列号') + '</th><th>' + mesLang('客户号码') + '</th><th>' + mesLang('包装箱号码') + '</th><th>' + mesLang('栈板号码') + '</th><th>' + mesLang('批次号') + '</th><th>' + mesLang('出货人') + '</th><th>' + mesLang('扫描时间') +'</th></tr>';

                if (ajax.value.length <= 0) {
                    htmlstr += '<tr class="ListTableEmptyDataRow"><td colspan=9>没有记录。</td></tr>';
                }
                for (var i = 0; i < ajax.value.length; i++) {

                    if (i % 2 == 0) {
                        htmlstr += '<tr class="ListTableEvenRow" id="' + ajax.value[i].DNCode + '"><td>' + ajax.value[i].DNCode + '</td><td>'+ ajax.value[i].Qty + "</td><td>" + ajax.value[i].SerialNumber + '</td><td>' + ajax.value[i].CustomerSN + '</td><td>' + ajax.value[i].CartonNo + '</td><td>' + ajax.value[i].PalletNo + '</td><td>' + ajax.value[i].QcLotNo + '</td><td>' + ajax.value[i].CreateBy + '</td><td>' + Format(ajax.value[i].CreateDateTime, "yyyy-MM-dd HH:mm") + '</td></tr>';
                    } else {

                        htmlstr += '<tr class="ListTableOddRow" id="' + ajax.value[i].DNCode + '"><td>' + ajax.value[i].DNCode + '</td><td>' + ajax.value[i].Qty + "</td><td>" + ajax.value[i].SerialNumber + '</td><td>' + ajax.value[i].CustomerSN + '</td><td>' + ajax.value[i].CartonNo + '</td><td>' + ajax.value[i].PalletNo + '</td><td>' + ajax.value[i].QcLotNo + '</td><td>' + ajax.value[i].CreateBy + '</td><td>' + Format(ajax.value[i].CreateDateTime, "yyyy-MM-dd HH:mm") + '</td></tr>';
                    }

                }
                state = getOneRecordCellTextByFiled("StatusName");
                if (state == "已出货") {
                    htmlstr += "<tr style='background: rgb(248,248,248);' ><td colspan='9' style='text-align: center;' >";
                    htmlstr += "<input type='button'  value='" + mesLang("导出明细") + "' onclick='ImportToExcel()'>";
                    htmlstr += "</td></tr>";
                   
                }
                htmlstr += "</tbody></table>";
                state = "";
                var attachHtml = '';
                var tbodyHtml = '';

                attachHtml = ' <table id="tbAttach" class="ListTable" style="width: 100%;"><tbody>' +
                    '<tr class="ListTableHeader"><th style="width:80px;text-align:center;" >' + mesLang('序号') + '</th><th style="text-align:center;">' + mesLang('附件名') +'</th><th style="width:100px;text-align:center;">' + mesLang('操作') +'</th></tr></tbody>' +
                         '<tbody id="tbodyAttach">';

                tbodyHtml = GetAttachFileInfo(SalOrderID);

                attachHtml = attachHtml + tbodyHtml + '</tbody></table>';


                var  layer = layui.layer; 
                layer.tab({
                    type:1,
                    area: ['85%', '85%'],
                    shadeClose: true, //点击遮罩关闭
                    tab: [{
                        title: mesLang('出货信息'),
                        content: htmlstr
                    }, {
                        title: mesLang('附件信息'),
                        content: attachHtml
                    }
                    ]
                });
                layer.render();
            });


         
            /*多语初始化*/
            initPageLang();
        }

        function GetAttachFileInfo(SalOrderID) {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxCpOutStock.GetAttachFileInfo(SalOrderID);
            if (ajax.error != null) {
                alert(ajax.error.Message);
            }

            var html = "";

            for (var i = 0; i < ajax.value.length; i++) {
                var entity = ajax.value[i];
                  var entity = ajax.value[i];
                var n = entity.FilePath.lastIndexOf("/");
                var fileUrl = GetFilePath("SalOrder", entity.FilePath.substring(n + 1, entity.FilePath.length));
                html += "<tr class='ListTableOddRow'><td align='center'>" + (i + 1) + "</td><td>" + entity.FileUpName + "</td><td align='center'><a href='" + fileUrl + "' target='_blank' > 下 载 </a></td></tr>";
            }


            return html;
        }

        function Format(now, mask) {
            var d = now;
            var zeroize = function (value, length) {
                if (!length) length = 2;
                value = String(value);
                for (var i = 0, zeros = ''; i < (length - value.length); i++) {
                    zeros += '0';
                }
                return zeros + value;
            };

            return mask.replace(/"[^"]*"|'[^']*'|\b(?:d{1,4}|m{1,4}|yy(?:yy)?|([hHMstT])\1?|[lLZ])\b/g, function ($0) {
                switch ($0) {
                    case 'd': return d.getDate();
                    case 'dd': return zeroize(d.getDate());
                    case 'ddd': return ['Sun', 'Mon', 'Tue', 'Wed', 'Thr', 'Fri', 'Sat'][d.getDay()];
                    case 'dddd': return ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'][d.getDay()];
                    case 'M': return d.getMonth() + 1;
                    case 'MM': return zeroize(d.getMonth() + 1);
                    case 'MMM': return ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'][d.getMonth()];
                    case 'MMMM': return ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'][d.getMonth()];
                    case 'yy': return String(d.getFullYear()).substr(2);
                    case 'yyyy': return d.getFullYear();
                    case 'h': return d.getHours() % 12 || 12;
                    case 'hh': return zeroize(d.getHours() % 12 || 12);
                    case 'H': return d.getHours();
                    case 'HH': return zeroize(d.getHours());
                    case 'm': return d.getMinutes();
                    case 'mm': return zeroize(d.getMinutes());
                    case 's': return d.getSeconds();
                    case 'ss': return zeroize(d.getSeconds());
                    case 'l': return zeroize(d.getMilliseconds(), 3);
                    case 'L': var m = d.getMilliseconds();
                        if (m > 99) m = Math.round(m / 10);
                        return zeroize(m);
                    case 'tt': return d.getHours() < 12 ? 'am' : 'pm';
                    case 'TT': return d.getHours() < 12 ? 'AM' : 'PM';
                    case 'Z': return d.toUTCString().match(/[A-Z]+$/);
                    // Return quoted strings with the surrounding quotes removed
                    default: return $0.substr(1, $0.length - 2);
                }
            });
        };
        function Refresh() {
            document.forms[0].submit();
        }

        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Warehouse/StockOrderEdit.aspx?name=StockOrderAdd&ID=-1";
            dialog({ title: mesLang("新增备货单信息"), src: openWinUrl, width: 750, height: 400 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            var statusName = getOneRecordCellTextByFiled("StatusName");
            if(statusName !="备货中"){
                alert("只允许编辑备货中状态的单据");
                return false;
            }
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Warehouse/StockOrderEdit.aspx?name=StockOrderEdit&ID=" + idStr;
            dialog({ title: mesLang("编辑备货单信息"), src: openWinUrl, width: 750, height: 400 });
        }
        function EditDetail() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            var statusName = getOneRecordCellTextByFiled("StatusName");
            if(statusName !="备货中"){
                alert("只允许编辑备货中状态的单据");
                return false;
            }
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Warehouse/StockOrderDtlList.aspx?name=StockOrderDtlList&ID=" + idStr;
            dialog({ title: mesLang("备货单细项列表"), src: openWinUrl, width: 750, height: 400 });
        }
        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }

        //导出到EXCEL
        function ImportToExcel() {

            var trObj = $("input[type=checkbox][name=chkSelect]:checked").parent().parent();
            var SalOrderID = trObj.find("td input[type=hidden][name='SalOrderID']").val();
            if (SalOrderID == "") return false;
 
            hdnOperate.val("exportexcel");
            hdnIdString.val(SalOrderID);
            document.forms[0].submit();
            hdnOperate.val("");
            hdnIdString.val("");


        }

        function PrintPdf() {
            var idStr = getOneRecordId();
            if (idStr == "") {
                return false;
            }
            window.open("<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Warehouse/CpOutStockPrint.aspx?name=StockOrderPrint&ID=" + idStr);
        }
        //同步ERP标准出货单据
        function SyncErpData() {
            hdnOperate.val("syncShipData");           
            document.forms[0].submit();
            hdnOperate.val("");
            hdnIdString.val("");
        }
    </script>
</asp:Content>
