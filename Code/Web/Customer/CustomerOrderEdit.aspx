<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master"
    AutoEventWireup="true" CodeBehind="CustomerOrderEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Customer.CustomerOrderEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
    <table width="100%" class="EditeContentTable">
        <tr id="TrFrom" style="display: none">
            <td class="Label2">
                 <%=Resources.lang.OrderNumber %>
            </td>
            <td class="Field2" colspan='3'>
                <asp:Label ID="lblOrderCode" runat="server" ClientIDMode="Static"></asp:Label>
                <asp:HiddenField runat="server" ID="hdnCustomerOrderID" Value="-1" />
            </td>
        </tr>
        <tr>
            <td class="Label2">
                客户编码<em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtCustomer" runat="server" CssClass="TextBox" Text="" ClientIDMode="Static" isrequired="1" Width="70%"></asp:TextBox>
                <input type="button" id="btnSelectCustomer" class="ButtonBox" value="..." title="选择客户" onclick="selectCustomer();" />
                <asp:HiddenField ID="hdnCustomerId" runat="server" ClientIDMode="Static" Value="-1" />
            </td>
            <td class="Label3">
                客户名称
            </td>
            <td class="Field3">
                <asp:Label ID="lblCustomerName" runat="server" ClientIDMode="Static"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                 <%=Resources.lang.OrderNo %><em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtCustomerOrder" runat="server" CssClass="TextBox" ClientIDMode="Static" isrequired="1" Width="70%"></asp:TextBox>
            </td>
            <td class="Label2"><%=Resources.lang.PurDate%> <em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtOrderDate" runat="server" IsRequired="1" CssClass="DateTimeBox" ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr>
        <tr>
           <td class="Label2">状态
            </td>
            <td class="Field2">
                <asp:DropDownList ID="ddlOpenDataStatus" runat="server" ClientIDMode="Static">
                     <asp:ListItem Value="9" Text="<%$ Resources:lang, NotClosed %>"></asp:ListItem>
                    <asp:ListItem Value="10" Text="<%$ Resources:lang, BeenClosed %>"></asp:ListItem>
                </asp:DropDownList>  
            </td>
            <td class="Label2">
                <%=Resources.lang.Remark%> 
            </td>
            <td class="Field2">
                 <asp:TextBox ID="txtRemark" CssClass="TextBox" runat="server"  ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr>
    </table>
   <table id="tblExpand" cellspacing="0" cellpadding="5" style="border-width: 0px; width: 100%; border-collapse: collapse; margin-top: 5px;"
        class="EditeContentTable">
        <tr class="ListTableHeader">
            
             <th scope="col" style="width: 5%;">
               序号
            </th>
            <th scope="col" style="width: 22%;">
                产品编码
            </th>
             <th scope="col" style="width: 18%;">
                产品名称
            </th>
            <th scope="col" style="width: 22%;">
                产品规格
            </th>
            <th scope="col" style="width: 10%;">
                <%=Resources.lang.Qty%>   
            </th>
            <th scope="col" style="width: 22%;">
                备注
            </th>
            <th scope="col" onclick="AddOrderDtl();" id='btnAdd' style="color: #0066CC; cursor: pointer; width: 100px;">+新增
            </th>
        </tr>
        <tr id="trNewInfo" class="ListTableOddRow">
            <td colspan="7" style="text-align: center;">
                <%=Resources.Messages.HaveNothingData%>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        var CustomerOrderID = '<%=Request.QueryString["ID"]%>';
        var countRow = 0, moCount = 0;
        var listOrderDtl = [];
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
            var listArr = GetOrderDtlList();
            if (null != listArr) {
                for (var i = 0; i < listArr.length; i++) {
                    countRow = listArr.length;
                    addDetail(listArr[i], i);
                }
            }
        });



         //获取采购单明细列表
        function GetOrderDtlList() {
            if (CustomerOrderID == "" || parseInt(CustomerOrderID) == -1) {
                return null;
            }
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxCustomer.GetOrderDtlList($("#<%=lblOrderCode.ClientID%>").text());

            if (ajax.error != null) {
                alert(ajax.error.Message);
                return null;
            }
            return ajax.value;
        }



        //绑定数据
        function addDetail(entity, i) {
            var OrderDtlinfo = {};
            //赋值行
            OrderDtlinfo.CusDtlId = entity.CusDtlId;
            OrderDtlinfo.CustomerOrderID = entity.CustomerOrderID;
            OrderDtlinfo.CustomerOrder = entity.CustomerOrder;
            OrderDtlinfo.ItemID = entity.ItemID;
            OrderDtlinfo.ItemCode = entity.ItemCode;
            OrderDtlinfo.ItemName = entity.ItemName;
            OrderDtlinfo.ItemSpec = entity.ItemSpec;
            OrderDtlinfo.Qty = entity.Qty;
            OrderDtlinfo.CusDtlRem = entity.CusDtlRem;
            OrderDtlinfo.AutoID = entity.AutoID;



            $("#trNewInfo").remove();
            var countRow = $("#tblExpand").find(".ListTableOddRow").length + 1;
            OrderDtlinfo.CountRow = moCount;
            listOrderDtl.push(OrderDtlinfo);

          
            var row, cell;
            rowNewIdx = tab.rows.length;
            row = tab.insertRow(rowNewIdx);
            row.className = "ListTableOddRow";

            OrderDtlinfo.tab = rowNewIdx;
            listOrderDtl.push(OrderDtlinfo);

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
                + "<input type=\"hidden\" name=\"hdAutoID\" class=\"hdAutoID\" value='" + entity.AutoID + "'  />";

            cell = row.insertCell(2);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<input type=\"text\" name=\"txtItemName\" class=\"TextBox txtItemName\" disabled=\"disabled\"  value='" + entity.ItemName + "'   style=\"width:80%;text-align:right;\" />";


            cell = row.insertCell(3);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<input type=\"text\" name=\"ItemSpec\" class=\"ItemSpec\" disabled=\"disabled\"  value='" + entity.ItemSpec + "'   style=\"width:80%;text-align:right;\" />";


            cell = row.insertCell(4);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<input type=\"text\"   name=\"Qty\"  class=\"Qty\" value='" + entity.Qty + "' style=\"width:80%;text-align:right; \"  IsRequired=\"1\" IsNumber=\"1\" onchange='ChangeInsQty(" + moCount + ", $(this),this)'/>";

            cell = row.insertCell(5);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<input type=\"text\" name=\"CusDtlRem\" class=\"CusDtlRem\"  value='" + entity.CusDtlRem + "'    style=\"width:80%;text-align:right;\" />";

            cell = row.insertCell(6);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<span style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"deleteOrderDtl(this, $(this),this)\"><%= Resources.Buttons.COM_Delete %></span>";

            
        }

        function AddOrderDtl() {
            var OrderDtlinfo = {};
            //赋值行
            OrderDtlinfo.CusDtlId = -1;
            OrderDtlinfo.CustomerOrderID = $("#hdnCustomerOrderID").val();;
            OrderDtlinfo.CustomerOrder = $("#<%=lblOrderCode.ClientID%>").text();
            OrderDtlinfo.ItemID = -1;
            OrderDtlinfo.ItemCode = "";
            OrderDtlinfo.ItemName = "";
            OrderDtlinfo.ItemSpec = "";
            OrderDtlinfo.Qty = 0;
            OrderDtlinfo.CusDtlRem = "";
            OrderDtlinfo.AutoID = -1;

            $("#trNewInfo").remove();

            var row, cell;
            rowNewIdx = tab.rows.length;
            row = tab.insertRow(rowNewIdx);
            row.className = "ListTableOddRow";
           
            listOrderDtl.push(OrderDtlinfo);

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
                + "<input type=\"hidden\" class=\"hdAutoID\" name=\"hdAutoID\"  value=-1 />";

            cell = row.insertCell(2);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<input type=\"text\" name=\"txtItemName\" class=\"TextBox txtItemName\" disabled=\"disabled\"    style=\"width:80%;text-align:right;\" />";



            cell = row.insertCell(3);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<input type=\"text\"  class=\"ItemSpec\"  name=\"ItemSpec\" disabled=\"disabled\"  style=\"width:80%;text-align:right;\" />";


            cell = row.insertCell(4);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<input type=\"text\" value=\"0\" class=\"Qty\" name=\"Qty\" style=\"width:80%;text-align:right; \"  IsRequired=\"1\" IsNumber=\"1\" onchange='ChangeInsQty(" + moCount + ", $(this),this)'/>";

            cell = row.insertCell(5);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<input type=\"text\" class=\"CusDtlRem\"  name=\"CusDtlRem\"   style=\"width:80%;text-align:right;\" />";

            cell = row.insertCell(6);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<span style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"deleteOrderDtl(this, $(this),this)\"><%= Resources.Buttons.COM_Delete %></span>";

        }





        //数量
        function ChangeInsQty(rowCount, t, row) {
            var rowclassname = row.parentElement.parentElement;
            var Qty = $.trim($(rowclassname).find(".Qty").val());
            if (isNaN(Qty * 1)) {
                alert('请输入数字格式');
                $(rowclassname).find(".Qty").val("");
                $(rowclassname).find(".Qty").focus();
                return false;
            }

            $.grep(listOrderDtl, function (o, j) {
                if (o.CountRow === rowCount) {
                    o.Qty = $(t).val();
                };
            });
        }

        //删除行操作
        function deleteOrderDtl(id, t) {
            var id = id.parentElement.parentElement;
            var ItemCode = $.trim($(id).find(".ItemCode").val());
            var index = -1;
            $.grep(listOrderDtl, function (o, j) {
                if (o.ItemCode == ItemCode) {
                    index = j;
                }
            });
            $(t).parent().parent().remove();
            listOrderDtl.splice(index, 1);
        }




        /*保存数据*/
        function Save() {
            var ss = new Array();
            var CustomerCode = $("#<%=this.txtCustomer.ClientID %>").val();//客户编码
            var CustomerName = $("#<%=this.lblCustomerName.ClientID %>").text();//客户名称
            var CustomerID = $("#<%=this.hdnCustomerId.ClientID %>").val();//客户ID
            var CustomerOrder = $("#<%=this.txtCustomerOrder.ClientID %>").val();//订单号
            var CustomerOrderID = $("#<%=this.hdnCustomerOrderID.ClientID %>").val();//订单行号
            var txtOrderDate= $("#<%=this.txtOrderDate.ClientID %>").val();
            var ddlOpenDataStatus = $("#<%=this.ddlOpenDataStatus.ClientID %>").val();
            var txtRemark=$("#<%=this.txtRemark.ClientID %>").val();

            var isOk = 0;
            $("#tblExpand tr:not(:first)").each(function (index, element) {
                if ($(this).text().trim() == "暂无数据")
                    return true;
                var model = {};
                model.CustomerOrderID = CustomerOrderID;
                model.CustomerOrder = CustomerOrder;
                model.ItemID = $(this).children("td:eq(1)").find("[name='hdItemId']").val();
                model.ItemCode = $(this).children("td:eq(1)").find("[name='hdItemCode']").val();
                model.ItemName = $(this).children("td:eq(2)").find("[name='txtItemName']").val();
                model.ItemSpec = $(this).children("td:eq(3)").find("[name='ItemSpec']").val();
                model.Qty = $(this).children("td:eq(4)").find("[name='Qty']").val();
                if (model.Qty <= 0) {
                    alert("采购数量不能小于等于0");
                    $(this).children("td:eq(4)").find("[name='Qty']").focus();
                    isOk = 1;
                }
                model.CusDtlRem = $(this).children("td:eq(5)").find("[name='CusDtlRem']").val();
                model.AutoID = $(this).children("td:eq(1)").find("[name='hdAutoID']").val() == "" || $(this).children("td:eq(1)").find("[name='hdAutoID']").val() == "-1" ? (index + 1) : $(this).children("td:eq(1)").find("[name='hdAutoID']").val();
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

            /*表单验证*/
            /*如需表单验证可以此处处理验证 开始*/
            var entity = {};
            entity.CustomerOrderID = CustomerOrderID;
            entity.CustomerID = CustomerID;
            entity.CustomerCode = CustomerCode;
            entity.CustomerName = CustomerName;
            entity.CustomerOrder = CustomerOrder;
            entity.CustomerOrder_LOT = CustomerOrder;
            entity.ItemCode = "";
            entity.Qty = 0;
            entity.CreateBy = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>"; //创建更新操作人
            entity.OrderDateTime = txtOrderDate;
            entity.OpenDataStatus = ddlOpenDataStatus;
            entity.SourceType = "客户订单";
            entity.OrderRem = txtRemark;
            entity.CustomerOrderDtl = JSON.stringify(ss);
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxCustomer.CustomerOrderEditNew(JSON.stringify(entity));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert('保存成功！')
            parent.window.Refresh();
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
           $.grep(listOrderDtl, function (o, j) {
               if (o.CountRow === thisRow) {
                   o.ItemId = list[0][0];
                   o.ItemName = list[0][1];
                   o.ItemCode = list[0][2];
                   o.ItemSpec = list[0][6];
               };
           });
           $(rowObj).find(".hdItemId").val(list[0][0]);
           $(rowObj).find(".txtItemName").val(list[0][1]);
           $(rowObj).find(".hdItemCode").val(list[0][2]);
           $(rowObj).find(".ItemSpec").val(list[0][6]);

       }








        function selectCustomer() {
            dialog({
               title: "<%=Resources.Common.ChooseWindow %>",
                src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=10&CallBackFunc=setCustomer&Multiple=false&rnd=" + Math.random(), width: 680, height: 350
            });
        }

        function setCustomer(list) {
            $("#<%=this.txtCustomer.ClientID %>").val(list[0][2]);//客户编码
            $("#<%=this.hdnCustomerId.ClientID %>").val(list[0][0]);//客户ID
            $("#<%=this.lblCustomerName.ClientID %>").text(list[0][3]);//客户名称
            
        }
        
        
    </script>
</asp:Content>