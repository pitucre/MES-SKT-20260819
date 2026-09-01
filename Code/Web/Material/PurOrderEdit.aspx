<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="PurOrderEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Material.PurOrderEdit" %>


<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
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
                <asp:TextBox ID="txtTaxRate" runat="server" CssClass="TextBox" ClientIDMode="Static" IsNumber='1'></asp:TextBox>
            </td>
            <td class="Label3">付款条件</td>
            <td class="Field3">
                <asp:TextBox ID="txtPaymentTerms" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
            </td>
            <td class="Label3">交付方式
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtPaymentMethod" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label3"><%=Resources.lang.SelectSupplier%>
                <em>*</em>
            </td>
            <td class="Field3">
                <input type="hidden" value="-1" id="hdnVenID" runat="server" />
                <input type="hidden" value="-1" id="hdnVendorCode" runat="server" />
                <input type="text" value="" id="txtVendorName" isrequired="1" runat="server" readonly="readonly" style="width: 160px;" />
                <input type="button" value="..." class="ButtonBox" onclick="chooseVendor(34)" />
            </td>
            <td class="Label3">
                <%=Resources.lang.SupplierUserName%>
            </td>
            <td class="Field3">
                <asp:Label ID="lblVenUserName" runat="server"></asp:Label>
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
                <asp:TextBox ID="txtOrderDate" runat="server" IsRequired="1" CssClass="DateTimeBox" ClientIDMode="Static"></asp:TextBox>
            </td>
            <td class="Label3">订单类型</td>
            <td class="Field3">
                <asp:DropDownList ID="selPoType" runat="server" ClientIDMode="Static">
                    <asp:ListItem Value="1">采购订单</asp:ListItem>
                    <asp:ListItem Value="2">委外订单</asp:ListItem>
                    <asp:ListItem Value="3">客供料</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td class="Label3">收货方式
            </td>
            <td class="Field3">
                <asp:DropDownList ID="selReceiveType" runat="server" ClientIDMode="Static">
                    <asp:ListItem Value="厂商直送">厂商直送</asp:ListItem>
                    <asp:ListItem Value="工厂自取">工厂自取</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="Label3">状态
            </td>
            <td class="Field3">
                <asp:DropDownList ID="ddlOpenDataStatus" runat="server" ClientIDMode="Static">
                    <asp:ListItem Value="9">未关闭</asp:ListItem>
                    <asp:ListItem Value="10">已关闭</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td class="Label3">交货地址</td>
            <td class="Field3">
                <asp:TextBox ID="txtDeliveryAddress" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
            </td>
            <td class="Label3">
                <%=Resources.lang.Remark%> 
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtRemark" CssClass="TextBox" runat="server" ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr>
    </table>
    <table id="tblExpand" cellspacing="0" cellpadding="5" style="border-width: 0px; width: 100%; border-collapse: collapse; margin-top: 5px;"
        class="EditeContentTable">
        <tr class="ListTableHeader">

            <th scope="col" style="width: 3%;">序号
            </th>
            <th scope="col" style="width: 19%;">物料编码
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
            <th scope="col" onclick="AddPurOrderDtl();" id='btnAdd' style="color: #0066CC; cursor: pointer; width: 100px;">+新增
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
                + "<input type=\"button\" onclick=\"selectItemName(" + moCount + ",this);\" class=\"ButtonBox\" value=\"...\" />"
                + "<input type=\"hidden\" name=\"hdItemId\" class=\"hdItemId\" value='" + entity.ItemID + "'  />"
                //+ "<input type=\"hidden\" name=\"hdItemCode\" class=\"hdItemCode\"  value='" + entity.ItemCode + "'/>"
                + "<input type=\"hidden\" name=\"hdAutoID\" class=\"hdAutoID\" value='" + entity.AutoID + "'  />";

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
            cell.innerHTML = "<input type=\"text\" name=\"SOCode\"  value='" + entity.SOCode + "' class=\"TextBox txtSOCode\"  disabled=\"disabled\" style=\" width:85%;\"  />"
                + "<input type=\"button\" onclick=\"selectSOCode(" + moCount + ",this);\" class=\"ButtonBox\" value=\"...\" />";

            cell = row.insertCell(6);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<input type=\"text\"   name=\"PURQty\"  class=\"PURQty\" value='" + entity.PURQty + "' style=\"width:80%;text-align:right; \"  IsRequired=\"1\" IsNumber=\"1\" onchange='ChangeInsPURQty(" + moCount + ", $(this),this)'/>";

            cell = row.insertCell(7);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<input type=\"text\" name=\"Units\" class=\"Units\" disabled=\"disabled\" value='" + entity.Units + "'    style=\"width:80%;text-align:right;\" />";

            cell = row.insertCell(8);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<input type=\"text\"  name=\"UnitPrice\"  class=\"UnitPrice\" value='" + entity.UnitPrice + "' style=\"width:80%;text-align:right;\"  IsRequired=\"1\" IsNumber=\"1\" onchange='ChangeInsUnitPrice(" + moCount + ", $(this),this)' />";

            cell = row.insertCell(9);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<input type=\"text\"  name=\"TotalPrice\" class=\"TotalPrice\"  value='" + entity.TotalPrice + "' style=\"width:80%;text-align:right; \"  IsRequired=\"1\" IsNumber=\"1\"  disabled=\"disabled\" onchange='ChangeInsTotalPrice(" + moCount + ", $(this),this)'/>";

            cell = row.insertCell(10);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<input type=\"text\" name=\"DeliveryDate\"  value='" + new Date(entity.DeliveryDate).format("yyyy-MM-dd") + "' style='width: 70%' class='DateTimeBox' readonly='readonly'  IsRequired='1' />";

            cell = row.insertCell(11);
            cell.align = "center";
            cell.className = "Field";
            var htmlstring = "<select id=\"seOpenDataStatus\" name=\"seOpenDataStatus\">";
            if (entity.OpenDataStatus == "9") {
                htmlstring += "<option value=\"9\" selected=\"selected\">未关闭</option><option value=\"10\">已关闭</option></select>";
            }
            else {
                htmlstring += "<option value=\"9\">未关闭</option><option value=\"10\" selected=\"selected\">已关闭</option></select>";
            }
            cell.innerHTML = htmlstring;

            cell = row.insertCell(12);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<span style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"deletePurOrderDtl(this, $(this),this)\"><%= Resources.Buttons.COM_Delete %></span>";

            var tdObj = $($("#tblExpand").find("tr")[$("#tblExpand").find("tr").length - 1]).find("td");

            // intiDatepicker($(tdObj[7]).find(".startDate"));

            $(".DateTimeBox").datepicker({

                showOn: "button",
                buttonImageOnly: true,
                showHms: _isHms,
                minDate: 0,
                buttonText: "<%=Resources.Common.ChooseDate %>",
                onSelect: function () {
                    $.grep(listPurOrderDtl, function (o, j) {
                        o.DeliveryDate = $(this).val();
                    });
                    if (_isHms) {
                        var objme = $(this);
                        if (typeof (objme.attr("_isHms")) == "undefined") {
                            if (objme.val().length > 10) {
                                objme.css("width", "140px");
                            }
                        } else { objme.val(objme.val().substring(0, 10)); }
                    }
                }
            });
        }

        function AddPurOrderDtl() {

            var myDate = new Date();

            var dateNow = myDate.getFullYear() + "-" + (myDate.getMonth() + 1) + "-" + myDate.getDate();


            var PurOrderDtlinfo = {};
            //赋值行
            PurOrderDtlinfo.POID = -1;
            PurOrderDtlinfo.POCode = "";
            PurOrderDtlinfo.ItemID = -1;
            PurOrderDtlinfo.ItemCode = "";
            PurOrderDtlinfo.ItemName = "";
            PurOrderDtlinfo.ItemSpec = "";
            //PurOrderDtlinfo.BrandName = "";
            PurOrderDtlinfo.SOCode = "";//增加订单号 modified by zhi.li 20180926
            PurOrderDtlinfo.PURQty = 0;
            PurOrderDtlinfo.Units = "";
            PurOrderDtlinfo.UnitPrice = 0;
            PurOrderDtlinfo.TotalPrice = "";
            PurOrderDtlinfo.DeliveryDate = dateNow;
            PurOrderDtlinfo.AutoID = -1;
            PurOrderDtlinfo.OpenDataStatus = 9;

            $("#trNewInfo").remove();

            var row, cell;
            rowNewIdx = tab.rows.length;
            row = tab.insertRow(rowNewIdx);
            row.className = "ListTableOddRow";

            //PurOrderDtlinfo.tab = rowNewIdx;
            listPurOrderDtl.push(PurOrderDtlinfo);

            cell = row.insertCell(0);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = rowNewIdx;

            cell = row.insertCell(1);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<input type=\"text\" name=\"hdItemCode\" class=\"TextBox hdItemCode\"   disabled=\"disabled\" style=\" width:85%;\"  />"
                + "<input type=\"button\" onclick=\"selectItemName(" + moCount + ",this);\" class=\"ButtonBox\" value=\"...\" />"
                + "<input type=\"hidden\" class=\"hdItemId\" name=\"hdItemId\"  value=-1 />"
                //+ "<input type=\"hidden\" class=\"hdItemCode\" name=\"hdItemCode\" />"
                + "<input type=\"hidden\" class=\"hdAutoID\" name=\"hdAutoID\"  value=-1 />";


            //行号新增根据最大行号后面累加
            cell = row.insertCell(2);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = '';// PurOrderDtlinfo.AutoID;

            cell = row.insertCell(3);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<input type=\"text\" name=\"txtItemName\" class=\"TextBox txtItemName\" disabled=\"disabled\"    style=\"width:80%;text-align:right;\" />";



            cell = row.insertCell(4);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<input type=\"text\"  class=\"ItemSpec\"  name=\"ItemSpec\" disabled=\"disabled\"  style=\"width:80%;text-align:right;\" />";

            //cell = row.insertCell(4);
            //cell.align = "center";
            //cell.className = "Field";
            //cell.innerHTML = " <input type=\"text\" class=\"BrandName\"  name=\"BrandName\" style=\"width:80%;text-align:right;\"  onchange='ChangeInsBrandName(" + moCount + ", $(this),this)' />";

            cell = row.insertCell(5);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<input type=\"text\" name=\"SOCode\"  class=\"TextBox txtSOCode\"  disabled=\"disabled\" style=\" width:85%;\"  />"
                + "<input type=\"button\" onclick=\"selectSOCode(" + moCount + ",this);\" class=\"ButtonBox\" value=\"...\" />";


            cell = row.insertCell(6);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<input type=\"text\" value=\"0\" class=\"PURQty\" name=\"PURQty\" style=\"width:80%;text-align:right; \"  IsRequired=\"1\" IsNumber=\"1\" onchange='ChangeInsPURQty(" + moCount + ", $(this),this)'/>";

            cell = row.insertCell(7);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<input type=\"text\" class=\"Units\"  name=\"Units\" disabled=\"disabled\"   style=\"width:80%;text-align:right;\" />";

            cell = row.insertCell(8);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<input type=\"text\"  class=\"UnitPrice\"  name=\"UnitPrice\" value=\"0\"  style=\"width:80%;text-align:right;\"  IsRequired=\"1\" IsNumber=\"1\" onchange='ChangeInsUnitPrice(" + moCount + ", $(this),this)' />";

            cell = row.insertCell(9);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<input type=\"text\"  class=\"TotalPrice\"  name=\"TotalPrice\" value=\"0\"  style=\"width:80%;text-align:right; \"  IsRequired=\"1\" IsNumber=\"1\"  disabled=\"disabled\" onchange='ChangeInsTotalPrice(" + moCount + ", $(this),this)'/>";

            cell = row.insertCell(10);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<input type=\"text\" name=\"DeliveryDate\" value=" + dateNow + "   style='width: 70%' class='DateTimeBox' readonly='readonly'  IsRequired='1' />";

            cell = row.insertCell(11);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<select id=\"seOpenDataStatus\" name=\"seOpenDataStatus\"><option value=\"9\" selected=\"selected\">未关闭</option><option value=\"10\">已关闭</option></select>";

            cell = row.insertCell(12);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<span style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"deletePurOrderDtl(this, $(this),this)\"><%= Resources.Buttons.COM_Delete %></span>";

            // var tdObj = $($("#tblExpand").find("tr")[$("#tblExpand").find("tr").length - 1]).find("td");

            // intiDatepicker($(tdObj[7]).find(".startDate"));

            $(".DateTimeBox").datepicker({
                showOn: "button",
                buttonImageOnly: true,
                showHms: _isHms,
                buttonText: "<%=Resources.Common.ChooseDate %>",
               onSelect: function () {
                   if (_isHms) {
                       var objme = $(this);
                       if (typeof (objme.attr("_isHms")) == "undefined") {
                           if (objme.val().length > 10) {
                               objme.css("width", "140px");
                           }
                       } else { objme.val(objme.val().substring(0, 10)); }
                   }
               },
               gotoCurrent: true,
               changeMonth: true,
               changeYear: true
           });
       }

       //数量
       function ChangeInsPURQty(rowCount, t, row) {
           var rowclassname = row.parentElement.parentElement;
           var PURQty = $.trim($(rowclassname).find(".PURQty").val());
           //            var UnitPrice = $.trim($(rowclassname).find(".UnitPrice").val());
           if (isNaN(PURQty * 1)) {
               alert('请输入数字格式');
               $(rowclassname).find(".PURQty").val("");
               $(rowclassname).find(".PURQty").focus();
               return false;
           }

           $.grep(listPurOrderDtl, function (o, j) {
               if (o.CountRow === rowCount) {
                   o.PURQty = $(t).val();
               };
           });
       }


       //单价
       function ChangeInsUnitPrice(rowCount, t, row) {
           var rowclassname = row.parentElement.parentElement;
           var PURQty = $(rowclassname).find(".PURQty").val();
           var UnitPrice = $.trim($(rowclassname).find(".UnitPrice").val());
           if (isNaN(UnitPrice * 1)) {
               alert('请输入数字格式');
               $(rowclassname).find(".UnitPrice").val("");
               $(rowclassname).find(".UnitPrice").focus();
               return false;

           }
           if (PURQty == "") {
               alert("请先填写数量！");
               return false;

           }
           $.grep(listPurOrderDtl, function (o, j) {
               if (o.CountRow === rowCount) {
                   o.UnitPrice = $(t).val();

                   o.TotalPrice = (parseFloat((t).val()) * parseFloat(PURQty));
               };
           });

           $(rowclassname).find(".TotalPrice").val(parseFloat((t).val()) * parseFloat(PURQty));

       }

       //删除行操作
       function deletePurOrderDtl(id, t) {
           var id = id.parentElement.parentElement;
           var ItemCode = $.trim($(id).find(".hdItemCode").val());

           //解决删除当前行，序号计算问题
           var childs = $(t).parent().parent().nextAll();//.children("td:eq(0)");
           $.each(childs, function (index, item) {
               $(item).children("td:eq(0)").text(parseInt($(item).children("td:eq(0)").text()) - 1);

           })

           var index = -1;
           $.grep(listPurOrderDtl, function (o, j) {
               if (o.ItemCode == ItemCode) {
                   index = j;
               }
           });

           $(t).parent().parent().remove();
           listPurOrderDtl.splice(index, 1);
       }

       //品牌
       //function ChangeInsBrandName(rowCount, t) {
       //    $.grep(listPurOrderDtl, function (o, j) {
       //        if (o.CountRow === rowCount) {
       //            o.BrandName = $(t).val();
       //        };
       //    });
       //}


       //保存
       function Save() {
           var ss = new Array();
           var hdnPoId = $("#<%=this.hdnPoID.ClientID %>").val();
            var lblPoCode = $("#<%=this.lblPOCode.ClientID %>").text();
            var hdnVenId = $("#<%=this.hdnVenID.ClientID %>").val();
            var txtVendorCode = $("#<%=this.hdnVendorCode.ClientID %>").val();
            var txtOrderDate = $("#<%=this.txtOrderDate.ClientID %>").val();
            var txtDeliveryAddress = $("#<%=this.txtDeliveryAddress.ClientID %>").val();
            var txtTaxRate = $("#<%=this.txtTaxRate.ClientID %>").val();
         <%--   var txtTaxRateTotal = $("#<%=this.txtTaxRateTotal.ClientID %>").val();--%>
            var txtPaymentTerms = $("#<%=this.txtPaymentTerms.ClientID %>").val();
            var txtPaymentMethod = $("#<%=this.txtPaymentMethod.ClientID %>").val();
           <%-- var txtProjectNo = $("#<%=this.txtProjectNo.ClientID %>").val();--%>
            var txtRemark = $("#<%=this.txtRemark.ClientID %>").val();

            var PoType = $("#<%=this.selPoType.ClientID %>").val();
            var ReceiveType = $("#<%=this.selReceiveType.ClientID %>").val();

            var ddlOpenDataStatus = $("#<%=this.ddlOpenDataStatus.ClientID %>").val();

            var isOk = 0;
            $("#tblExpand tr:not(:first)").each(function (index, element) {
                if ($(this).text().trim() == "暂无数据")
                    return true;
                var model = {};
                model.POID = hdnPoId;
                model.POCode = lblPoCode;
                model.ItemID = $(this).children("td:eq(1)").find("[name='hdItemId']").val();
                model.ItemCode = $(this).children("td:eq(1)").find("[name='hdItemCode']").val();
                model.ItemName = $(this).children("td:eq(3)").find("[name='txtItemName']").val();

                model.ItemSpec = $(this).children("td:eq(4)").find("[name='ItemSpec']").val();
                //model.BrandName = $(this).children("td:eq(4)").find("[name='BrandName']").val();
                model.SOCode = $(this).children("td:eq(5)").find("[name='SOCode']").val();
                model.PURQty = $(this).children("td:eq(6)").find("[name='PURQty']").val();
                if (model.PURQty <= 0) {
                    alert("采购数量不能小于等于0");
                    $(this).children("td:eq(6)").find("[name='PURQty']").focus();
                    isOk = 1;
                }
                model.Units = $(this).children("td:eq(7)").find("[name='Units']").val();
                model.UnitPrice = $(this).children("td:eq(8)").find("[name='UnitPrice']").val();

                model.TotalPrice = $(this).children("td:eq(9)").find("[name='TotalPrice']").val();
                model.DeliveryDate = $(this).children("td:eq(10)").find("[name='DeliveryDate']").val();
                var OpenDataStatusName = $(this).children("td:eq(11)").find("[name='seOpenDataStatus']").find("option:selected").text();//状态
                if ($(this).children("td:eq(1)").find("[name='hdAutoID']").val() == "" || $(this).children("td:eq(1)").find("[name='hdAutoID']").val() == "-1") {
                    model.AutoID = (ss.length > 0 ? parseInt(ss[index - 1].AutoID) + 1 : index + 1);
                }
                else {
                    model.AutoID = $(this).children("td:eq(1)").find("[name='hdAutoID']").val();
                }

                if (OpenDataStatusName == "未关闭") {
                    model.OpenDataStatus = 9;
                }
                else {
                    model.OpenDataStatus = 10;
                }
                ss.push(model);

            });
            //已添加项
            if (ss.length == 0) {
                alert("请添加采购单明细项!");
                return false;
            }
            if (isOk == 1) {
                return false;
            }
            var entity = {};
            entity.PurOrderId = PurOrderId; //ID
            entity.VenID = hdnVenId; //供应商ID

            entity.VenCode = txtVendorCode; //供应商编号
            entity.OrderDate = txtOrderDate; //下单日期
            entity.DeliveryAddress = txtDeliveryAddress; //交货地址
            entity.TaxRate = txtTaxRate;     //税率
            entity.TaxRateTotal = 0; //含税合计   update 20180130 del
            entity.PaymentTerms = txtPaymentTerms; //付款条件
            entity.PaymentMethod = txtPaymentMethod; //交付方式
            entity.ProjectNo = ""; //txtProjectNo; //主表项目编号
            entity.Remark = txtRemark; //主表备注
            entity.CreateBy = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>"; //创建更新操作人
            entity.PoType = PoType; //
            entity.ReceiveType = ReceiveType; //
            entity.OpenDataStatus = ddlOpenDataStatus;
            entity.PurOrderDtl = JSON.stringify(ss);

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPurOrder.PurOrderEdit(JSON.stringify(entity));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert('<%=Resources.Messages.SaveInSuccess%>');

            parent.window.Refresh($("#<%=this.lblPOCode.ClientID%>").text());
        }


        //获取物料信息
        var rowObj = null;
        var rowIndex = 0;
        var thisRow = -1;
        function selectItemName(rowCount, obj) {
            rowObj = obj.parentElement.parentElement;
            rowIndex = rowObj.rowIndex;
            thisRow = rowCount;
            dialog({
                title: "<%=Resources.Common.ChooseWindow %>"
            , src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=1&CallBackFunc=getChooseValuesItemName&Multiple=false&rnd=" + Math.random(), width: 650, height: 350
            });
        }

        function getChooseValuesItemName(list) {
            $.grep(listPurOrderDtl, function (o, j) {
                if (o.CountRow === thisRow) {
                    o.ItemId = list[0][0];
                    o.ItemName = list[0][1];
                    o.ItemCode = list[0][2];
                    o.Units = list[0][4];
                    o.ItemSpec = list[0][6];
                };
            });
            $(rowObj).find(".hdItemId").val(list[0][0]);
            $(rowObj).find(".txtItemName").val(list[0][1]);
            $(rowObj).find(".hdItemCode").val(list[0][2]);
            $(rowObj).find(".Units").val(list[0][4]);
            $(rowObj).find(".ItemSpec").val(list[0][6]);

        }

        //选中供应商
        function chooseVendor(falg) {
            dialog({
                title: "<%=Resources.Common.ChooseWindow %>",
               src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=" + falg + "&Multiple=false&rnd=" + Math.random(), width: 650, height: 350
           });
       }
       //供应商返回的值
       function getChooseValue(list) {
           $("#<%=this.hdnVenID.ClientID %>").val(list[0][0]);
            $("#<%=this.hdnVendorCode.ClientID %>").val(list[0][1]);
            $("#<%=this.txtVendorName.ClientID %>").val(list[0][2]);
            $("#<%=this.lblVenUserName.ClientID %>").text(list[0][4]);
            $("#<%=this.lblVenPhone.ClientID %>").text(list[0][5]);
         <%--   $("#<%=this.txtDeliveryAddress.ClientID %>").val(list[0][6]);--%>

        }


        //获取订单号
        var rowObj2 = null;
        var rowIndex2 = 0;
        var thisRow2 = -1;
        function selectSOCode(rowCount, obj) {
            rowObj2 = obj.parentElement.parentElement;
            rowIndex2 = rowObj2.rowIndex;
            thisRow2 = rowCount;
            dialog({
                title: "<%=Resources.Common.ChooseWindow %>"
            , src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=810&CallBackFunc=getChooseValuesselectSOCode&Multiple=false&rnd=" + Math.random(), width: 650, height: 350
            });
        }
        function getChooseValuesselectSOCode(list) {
            $.grep(listPurOrderDtl, function (o, j) {
                if (o.CountRow === thisRow) {
                    o.SOCode = list[0][1];
                };
            });
            $(rowObj2).find(".txtSOCode").val(list[0][1]);
        }
    </script>
</asp:Content>


