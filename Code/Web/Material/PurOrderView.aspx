<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="true" CodeBehind="PurOrderView.aspx.cs" Inherits="SKT.LeanMES.Web.Material.PurOrderView" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ViewContent" runat="server">
    <table id="FTable" class="EditeContentTable" width="100%">
        <tr id="TrFrom" style="display: none">
            <td class="Label3">
                <%=Resources.lang.POCode%>
            </td>
            <td class="Field3" colspan='5'>
                <asp:Label ID="lblPOCode" runat="server" ClientIDMode="Static"></asp:Label>
                <asp:HiddenField runat="server" ID="hdnPoID" Value="-1" />
            </td>
        </tr>
        <tr style="display: none">
            <td class="Label3">税率</td>
            <td class="Field3">
                <asp:TextBox ID="txtTaxRate" runat="server" CssClass="TextBox" ClientIDMode="Static" IsNumber='1' ReadOnly="true"></asp:TextBox>
            </td>
            <td class="Label3">付款条件</td>
            <td class="Field3">
                <asp:TextBox ID="txtPaymentTerms" runat="server" CssClass="TextBox" ClientIDMode="Static" ReadOnly="true"></asp:TextBox>
            </td>
            <td class="Label3">交付方式
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtPaymentMethod" runat="server" CssClass="TextBox" ClientIDMode="Static" ReadOnly="true"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label3"><%=Resources.lang.SelectSupplier%>
                <em>*</em>
            </td>
            <td class="Field3">
                <input type="hidden" value="-1" id="hdnVenID" runat="server" />
                <input type="hidden" value="-1" id="hdnVendorCode" runat="server" />
                <input type="text" value="" id="txtVendorName" isrequired="1" runat="server" readonly="readonly" style="width: 160px;" disabled="disabled" />
            </td>
            <td class="Label3">
                <%=Resources.lang.SupplierUserName%>
            </td>
            <td class="Field3">
                <asp:Label ID="lblVenUserName" runat="server" ReadOnly="true"></asp:Label>
            </td>
            <td class="Label3"><%=Resources.lang.SupplierPhone%>
            </td>
            <td class="Field3">
                <asp:Label ID="lblVenPhone" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label3"><%=Resources.lang.OrderDate%><em>*</em>
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtOrderDate" runat="server" IsRequired="1" ClientIDMode="Static" Enabled="false"></asp:TextBox>
            </td>
            <td class="Label3">订单类型</td>
            <td class="Field3">
                <asp:DropDownList ID="selPoType" runat="server" ClientIDMode="Static" Enabled="false">
                    <asp:ListItem Value="1">采购订单</asp:ListItem>
                    <asp:ListItem Value="2">委外订单</asp:ListItem>
                    <asp:ListItem Value="3">客供料</asp:ListItem>
                </asp:DropDownList>  
            </td>
            <td class="Label3">收货方式
            </td>
            <td class="Field3">
                <asp:DropDownList ID="selReceiveType" runat="server" ClientIDMode="Static" Enabled="false">
                    <asp:ListItem Value="厂商直送">厂商直送</asp:ListItem>
                    <asp:ListItem Value="工厂自取">工厂自取</asp:ListItem>
                </asp:DropDownList>  
            </td>
        </tr>
        <tr>
           <td class="Label3">状态
            </td>
            <td class="Field3">
                <asp:DropDownList ID="ddlOpenDataStatus" runat="server" ClientIDMode="Static" Enabled="false">
                    <asp:ListItem Value="9">未关闭</asp:ListItem>
                    <asp:ListItem Value="10">已关闭</asp:ListItem>
                </asp:DropDownList>  
            </td>
            <td class="Label3">交货地址</td>
            <td class="Field3">
                <asp:TextBox ID="txtDeliveryAddress" runat="server" CssClass="TextBox" ClientIDMode="Static" Enabled="false"></asp:TextBox>
            </td>
            <td class="Label3">
                <%=Resources.lang.Remark%> 
            </td>
            <td class="Field3">
                 <asp:TextBox ID="txtRemark" CssClass="TextBox" runat="server"  ClientIDMode="Static" Enabled="false"></asp:TextBox>
            </td>
        </tr>
    </table>
    <table id="tblExpand" cellspacing="0" cellpadding="5" style="border-width: 0px; width: 100%; border-collapse: collapse; margin-top: 5px;"
        class="EditeContentTable">
        <tr class="ListTableHeader">
            
             <th scope="col" style="width: 3%;">
               序号
            </th>
            <th scope="col" style="width: 19%;">
                物料编码
            </th>
            <th scope="col" style="width: 3%;">行号
            </th>
             <th scope="col" style="width: 10%;">
                <%=Resources.lang.MaterialName%> 
            </th>
            <th scope="col" style="width: 15%;">型号规格
            </th>
            <th scope="col" style="width: 19%;">
              <%--  <%=Resources.lang.PartBrand%>  --%>
                订单号
            </th>
            <th scope="col" style="width: 7%;">
                <%=Resources.lang.Qty%>   
            </th>
            <th scope="col" style="width: 5%;">
                <%=Resources.lang.PartUnit%>     
            </th>
            <th scope="col" style="width: 5%;">单 价
            </th>
            <th scope="col" style="width: 5%;">总 价
            </th>
            <th scope="col" style="width: 10%;">交 期
            </th>
             <th scope="col" style="width: 6%;">状 态
            </th>
        </tr>
        <tr id="trNewInfo" class="ListTableOddRow">
            <td colspan="10" style="text-align: center;">
                <%=Resources.Messages.HaveNothingData%>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        var PurOrderId = '<%=Request.QueryString["ID"]%>'; //编辑时传过来的物料列表的ID

        var countRow = 0, moCount = 0;
        var listPurOrderDtl = [];
        var tab = document.getElementById("tblExpand");
        $(function () {

            Date.prototype.format = function (fmt) {
                var o = {
                    "M+": this.getMonth() + 1,                 //月份 
                    "d+": this.getDate(),                    //日 
                    "h+": this.getHours(),                   //小时 
                    "m+": this.getMinutes(),                 //分 
                    "s+": this.getSeconds(),                 //秒 
                    "q+": Math.floor((this.getMonth() + 3) / 3), //季度 
                    "S": this.getMilliseconds()             //毫秒 
                };
                if (/(y+)/.test(fmt)) {
                    fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
                }
                for (var k in o) {
                    if (new RegExp("(" + k + ")").test(fmt)) {
                        fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
                    }
                }
                return fmt;
            }
            var listArr = GetPurOrderDtlList();
            if (null != listArr) {
                for (var i = 0; i < listArr.length; i++) {
                    countRow = listArr.length;
                    addDetail(listArr[i], i);
                }
            }
        });

        //获取采购单明细列表
        function GetPurOrderDtlList() {
            if (PurOrderId == "" || parseInt(PurOrderId) == -1) {
                return null;
            }
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPurOrder.GetPurOrderDtlList($("#<%=lblPOCode.ClientID%>").text());

            if (ajax.error != null) {
                alert(ajax.error.Message);
                return null;
            }
            return ajax.value;
        }

        //绑定数据
        function addDetail(entity, i) {
            var PurOrderDtlinfo = {};
            //赋值行
            PurOrderDtlinfo.POID = entity.POID;
            PurOrderDtlinfo.POCode = entity.POCode;
            PurOrderDtlinfo.ItemID = entity.ItemID;
            PurOrderDtlinfo.ItemCode = entity.ItemCode;
            PurOrderDtlinfo.ItemName = entity.ItemName;
            PurOrderDtlinfo.ItemSpec = entity.ItemSpec;
            //PurOrderDtlinfo.BrandName = entity.BrandName;
            PurOrderDtlinfo.SOCode = entity.SOCode;
            PurOrderDtlinfo.PURQty = entity.PURQty;
            PurOrderDtlinfo.Units = entity.Units;
            PurOrderDtlinfo.UnitPrice = entity.UnitPrice;
            PurOrderDtlinfo.TotalPrice = entity.TotalPrice;
            PurOrderDtlinfo.DeliveryDate = entity.DeliveryDate;
            PurOrderDtlinfo.AutoID = entity.AutoID;
            PurOrderDtlinfo.OpenDataStatus = entity.OpenDataStatus;

            $("#trNewInfo").remove();
            var countRow = $("#tblExpand").find(".ListTableOddRow").length + 1;
            PurOrderDtlinfo.CountRow = moCount;
            listPurOrderDtl.push(PurOrderDtlinfo);

          
            var row, cell;
            rowNewIdx = tab.rows.length;
            row = tab.insertRow(rowNewIdx);
            row.className = "ListTableOddRow";

            PurOrderDtlinfo.tab = rowNewIdx;
            listPurOrderDtl.push(PurOrderDtlinfo);

            cell = row.insertCell(0);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = i + 1;

            cell = row.insertCell(1);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<input type=\"text\" name=\"hdItemCode\"  value='" + entity.ItemCode + "' class=\"TextBox hdItemCode\"  disabled=\"disabled\" style=\" width:85%;\"  />"
                //+ "<input type=\"button\" onclick=\"selectItemName(" + moCount + ",this);\" class=\"ButtonBox\" value=\"...\" />"
                //+ "<input type=\"hidden\" name=\"hdItemId\" class=\"hdItemId\" value='" + entity.ItemID + "'  />"
                ////+ "<input type=\"hidden\" name=\"hdItemCode\" class=\"hdItemCode\"  value='" + entity.ItemCode + "'/>"
                //+ "<input type=\"hidden\" name=\"hdAutoID\" class=\"hdAutoID\" value='" + entity.AutoID + "'  />";
            //行号
            cell = row.insertCell(2);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = entity.AutoID;

            cell = row.insertCell(3);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<input type=\"text\" name=\"txtItemName\" class=\"TextBox txtItemName\" disabled=\"disabled\"  value='" + entity.ItemName + "'   style=\"width:80%;text-align:right;\" />";


            cell = row.insertCell(4);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<input type=\"text\" name=\"ItemSpec\" class=\"ItemSpec\" disabled=\"disabled\"  value='" + entity.ItemSpec + "'   style=\"width:80%;text-align:right;\" />";

            //cell = row.insertCell(4);
            //cell.align = "center";
            //cell.className = "Field";
            //cell.innerHTML = " <input type=\"text\" name=\"BrandName\" class=\"BrandName\"  value='" + entity.BrandName + "' style=\"width:80%;text-align:right;\"  onchange='ChangeInsBrandName(" + moCount + ", $(this),this)' />";


            cell = row.insertCell(5);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<input type=\"text\" name=\"SOCode\"  value='" + entity.SOCode + "' class=\"TextBox txtSOCode\"  disabled=\"disabled\" style=\" width:85%;\"  />";

            cell = row.insertCell(6);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<input type=\"text\"   name=\"PURQty\"  class=\"PURQty\" value='" + entity.PURQty + "' style=\"width:80%;text-align:right; \"  IsRequired=\"1\" IsNumber=\"1\"  disabled=\"disabled\"/>";

            cell = row.insertCell(7);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<input type=\"text\" name=\"Units\" class=\"Units\" disabled=\"disabled\" value='" + entity.Units + "'    style=\"width:80%;text-align:right;\" />";

            cell = row.insertCell(8);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<input type=\"text\"  name=\"UnitPrice\"  class=\"UnitPrice\" value='" + entity.UnitPrice + "' style=\"width:80%;text-align:right;\"  IsRequired=\"1\" IsNumber=\"1\" disabled=\"disabled\" />";

            cell = row.insertCell(9);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<input type=\"text\"  name=\"TotalPrice\" class=\"TotalPrice\"  value='" + entity.TotalPrice + "' style=\"width:80%;text-align:right; \"  IsRequired=\"1\" IsNumber=\"1\"  disabled=\"disabled\" />";

            cell = row.insertCell(10);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<input type=\"text\" name=\"DeliveryDate\"  value='" + new Date(entity.DeliveryDate).format("yyyy-MM-dd") + "' style='width: 70%' class='DateTimeBox' readonly='readonly'  IsRequired='1' />";

            cell = row.insertCell(11);
            cell.align = "center";
            cell.className = "Field";
            var htmlstring = "<select id=\"seOpenDataStatus\" name=\"seOpenDataStatus\" disabled=\"disabled\">";
            if (entity.OpenDataStatus == "9") {
                htmlstring += "<option value=\"9\" selected=\"selected\">未关闭</option><option value=\"10\">已关闭</option></select>";
            }
            else {
                htmlstring += "<option value=\"9\">未关闭</option><option value=\"10\" selected=\"selected\">已关闭</option></select>";
            }
            cell.innerHTML = htmlstring;            

            var tdObj = $($("#tblExpand").find("tr")[$("#tblExpand").find("tr").length - 1]).find("td");            
        }       
    </script>
</asp:Content>


