<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="PackagingAttachmentOrderEdit.aspx.cs" Inherits="SKT.LeanMES.Web.DIPPackaging.PackagingAttachmentOrderEdit" %>


<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label2">
                工单号<em>*</em>
            </td>
            <td class="Field2" colspan='3'>
                <asp:TextBox runat="server" ID="txtOrderNO" CssClass="TextBox" Enabled="false" IsRequired="1"></asp:TextBox>
                <input type="button" value="..." class="ButtonBox" onclick="selectOrderNO()" />
                <asp:HiddenField ID="txtOrderId" runat="server" ClientIDMode="Static" />
                <asp:HiddenField ID="txtPAOId" runat="server" ClientIDMode="Static" />
            </td>
        </tr>
        <tr>
            <td class="Label2">
                料号
            </td>
            <td class="Field2">
                 <asp:Label ID="lblItemCode" runat="server" ClientIDMode="Static"></asp:Label>
                <asp:HiddenField ID="txtItemId" runat="server" ClientIDMode="Static" />
            </td>
            <td class="Label2">
                料名称
            </td>
            <td class="Field2">
                <asp:Label ID="lblItemName" runat="server" ClientIDMode="Static"></asp:Label>
            </td>
        </tr>
         <tr  style="display:none;">
            <td class="Label2">
                数量<em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtQuantity" runat="server" CssClass="TextBox" ClientIDMode="Static" IsNumber="1" IsRequired="1" Text="1"></asp:TextBox>
            </td>
            <td class="Label2">
                描述
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtDescription" runat="server" CssClass="TextBox" ClientIDMode="Static"  Width="70%" Text=""></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%=Resources.lang.Remark%> 
            </td>
            <td class="Field2" colspan="3">
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
                工单号<em style="color:red;">*</em>  
            </th>
            <th scope="col" style="width: 15%;">
                料号
            </th>
             <th scope="col" style="width: 18%;">
                料名称
            </th>
            <th scope="col" style="width: 13%;">
                描述
            </th>
            <th scope="col" style="width: 10%;">
                <%=Resources.lang.Qty%> <em style="color:red;">*</em>  
            </th>
            <th scope="col" style="width: 20%;">
                备注
            </th>
            <th scope="col" onclick="AddOrderDtl();" id='btnAdd' style="color: #0066CC; cursor: pointer; width: 100px;">+新增
            </th>
        </tr>
        <tr id="trNewInfo" class="ListTableOddRow">
            <td colspan="8" style="text-align: center;">
                <%=Resources.Messages.HaveNothingData%>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        var PAOId = '<%=Request.QueryString["ID"]%>';
        var countRow = 0, moCount = 0;
        var listOrderDtl = [];
        var tab = document.getElementById("tblExpand");
        var idStringlist = "";
        $(function () {
            var listArr = GetOrderDtlList();
            if (null != listArr) {
                for (var i = 0; i < listArr.length; i++) {
                    countRow = listArr.length;
                    addDetail(listArr[i], i);
                }
            }
        });



         //获取明细列表
        function GetOrderDtlList() {
            if (PAOId == "" || parseInt(PAOId) == -1) {
                return null;
            }
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxDIPPackaging.GetOrderDtlList($("#<%=txtPAOId.ClientID%>").val());

            if (ajax.error != null) {
                alert(ajax.error.Message);
                return null;
            }
            return ajax.value;
        }



        //绑定数据
        function addDetail(entity, i) {
            //重复的不添加
            if (IsHaveId(entity.ProdOrderID)) {
                return false;
            }
            var OrderDtlinfo = {};
            //赋值行
            OrderDtlinfo.ProdOrderID = entity.ProdOrderID;
            OrderDtlinfo.ItemID = entity.ItemID;
            OrderDtlinfo.Description = entity.Description;
            OrderDtlinfo.Quantity = entity.Quantity;
            OrderDtlinfo.Remark = entity.Remark;
            OrderDtlinfo.OrderNO = entity.OrderNO;
            OrderDtlinfo.ItemCode = entity.ItemCode;
            OrderDtlinfo.ItemName = entity.ItemName;
            OrderDtlinfo.PAODId = entity.PAODId;



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
            cell.innerHTML = "<input type=\"text\" name=\"hdOrderNO\"  value='" + entity.OrderNO + "' class=\"TextBox hdOrderNO\"  disabled=\"disabled\" style=\" width:85%;\"  />"
                + "<input type=\"button\" onclick=\"selectItemName(" + moCount + ",this);\" class=\"ButtonBox\" value=\"...\" />"
                + "<input type=\"hidden\" name=\"hdProdOrderID\" class=\"hdProdOrderID\" value='" + entity.ProdOrderID + "'  />"
                + "<input type=\"hidden\" name=\"hdItemId\" class=\"hdItemId\" value='" + entity.ItemID + "'  />"
                + "<input type=\"hidden\" name=\"hdPAODId\" class=\"hdPAODId\" value='" + entity.PAODId + "'  />";


            cell = row.insertCell(2);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<input type=\"text\" name=\"hdItemCode\" class=\"TextBox hdItemCode\" disabled=\"disabled\"  value='" + entity.ItemCode + "'   style=\"width:80%;text-align:right;\" />";


            cell = row.insertCell(3);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<input type=\"text\" name=\"txtItemName\" class=\"TextBox txtItemName\" disabled=\"disabled\"  value='" + entity.ItemName + "'   style=\"width:80%;text-align:right;\" />";


            cell = row.insertCell(4);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<input type=\"text\" name=\"txtDescription\" class=\"txtDescription\"  value='" + entity.Description + "'   style=\"width:80%;text-align:right;\" />";


            cell = row.insertCell(5);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<input type=\"text\"   name=\"Quantity\"  class=\"Quantity\" value='" + entity.Quantity + "' style=\"width:80%;text-align:right; \"  IsRequired=\"1\" IsNumber=\"1\" onchange='ChangeInsQty(" + moCount + ", $(this),this)'/>";

            cell = row.insertCell(6);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<input type=\"text\" name=\"Remark\" class=\"Remark\"  value='" + entity.Remark + "'    style=\"width:80%;text-align:right;\" />";

            cell = row.insertCell(7);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<span style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"deleteOrderDtl(this, $(this),this)\"><%= Resources.Buttons.COM_Delete %></span>";


            idStringlist = idStringlist + entity.ProdOrderID + ",";
        }

        function AddOrderDtl() {
            var OrderDtlinfo = {};
            //赋值行
            OrderDtlinfo.ProdOrderID = -1;
            OrderDtlinfo.ItemID = -1;
            OrderDtlinfo.Description = "";
            OrderDtlinfo.Quantity = 0;
            OrderDtlinfo.Remark = "";
            OrderDtlinfo.OrderNO = "";
            OrderDtlinfo.ItemCode = "";
            OrderDtlinfo.ItemName = "";
            OrderDtlinfo.PAODId = -1;

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
            cell.innerHTML = "<input type=\"text\" name=\"hdOrderNO\" class=\"TextBox hdOrderNO\"   disabled=\"disabled\" style=\" width:85%;\"  />"
                + "<input type=\"button\" onclick=\"selectItemName(" + moCount + ",this);\" class=\"ButtonBox\" value=\"...\" />"
                + "<input type=\"hidden\" class=\"hdProdOrderID\" name=\"hdProdOrderID\"  value=-1 />"
                + "<input type=\"hidden\" class=\"hdItemId\" name=\"hdItemId\"  value=-1 />"
                + "<input type=\"hidden\" class=\"hdPAODId\" name=\"hdPAODId\"  value=-1 />";

            cell = row.insertCell(2);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<input type=\"text\" name=\"hdItemCode\" class=\"TextBox hdItemCode\" disabled=\"disabled\"    style=\"width:80%;text-align:right;\" />";

            cell = row.insertCell(3);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<input type=\"text\" name=\"txtItemName\" class=\"TextBox txtItemName\" disabled=\"disabled\"    style=\"width:80%;text-align:right;\" />";



            cell = row.insertCell(4);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<input type=\"text\"  class=\"txtDescription\"  name=\"txtDescription\"  style=\"width:80%;text-align:right;\" />";


            cell = row.insertCell(5);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<input type=\"text\" value=\"0\" class=\"Quantity\" name=\"Quantity\" style=\"width:80%;text-align:right; \"  IsRequired=\"1\" IsNumber=\"1\" onchange='ChangeInsQty(" + moCount + ", $(this),this)'/>";

            cell = row.insertCell(6);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<input type=\"text\" class=\"Remark\"  name=\"Remark\"   style=\"width:80%;text-align:right;\" />";

            cell = row.insertCell(7);
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
            var hdProdOrderID = $.trim($(id).find(".hdProdOrderID").val());
            var index = -1;

            if (IsHaveId(hdProdOrderID)) {
                var newlistid = "";
                var hidlist = idStringlist.split(',');
                for (var i = 0; i < hidlist.length; i++) {
                    if (hidlist[i] != hdProdOrderID) {
                        newlistid = newlistid + hidlist[i] + ",";
                    }
                }
                idStringlist = newlistid;
            }

            $.grep(listOrderDtl, function (o, j) {
                if (o.ProdOrderID == hdProdOrderID) {
                    index = j;
                }
            });
            $(t).parent().parent().remove();
            listOrderDtl.splice(index, 1);
        }




        /*保存数据*/
        function Save() {
            var ss = new Array();
            var txtRemark=$("#<%=this.txtRemark.ClientID %>").val();
            var isOk = 0;
            $("#tblExpand tr:not(:first)").each(function (index, element) {
                if ($(this).text().trim() == "暂无数据")
                    return true;
                var model = {};
                model.ProdOrderID = $(this).children("td:eq(1)").find("[name='hdProdOrderID']").val();
                model.ItemID = $(this).children("td:eq(1)").find("[name='hdItemId']").val();
                model.Description = $(this).children("td:eq(4)").find("[name='txtDescription']").val();
                model.Quantity = $(this).children("td:eq(5)").find("[name='Quantity']").val();
                if (model.Quantity <= 0) {
                    alert("数量不能小于等于0");
                    $(this).children("td:eq(5)").find("[name='Quantity']").focus();
                    isOk = 1;
                }
                model.Remark = $(this).children("td:eq(6)").find("[name='Remark']").val();
                ss.push(model);


            });
            //已添加项
            if (ss.length == 0) {
                alert("请添加附属工单明细项!");
                return false;
            }
            if (isOk == 1) {
                return false;
            }
            /*表单验证*/
            /*如需表单验证可以此处处理验证 开始*/
            var entity = {};
            entity.PAOId = parseInt(PAOId);
            entity.ProdOrderID=parseInt($("#<%=this.txtOrderId.ClientID %>").val());
            entity.ItemId=parseInt($("#<%=this.txtItemId.ClientID %>").val());
            entity.Description=$("#<%=this.txtDescription.ClientID %>").val();
            entity.Quantity=parseInt($("#<%=this.txtQuantity.ClientID %>").val());
            entity.Remark = txtRemark;
            entity.UserName="<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>"; //创建更新操作人
            entity.PackagingAttachmentOrderDtl = JSON.stringify(ss);
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxDIPPackaging.PackagingAttachmentOrderEdit(JSON.stringify(entity));
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
            , src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=824&CallBackFunc=getChooseValuesItemName&Multiple=false&rnd=" + Math.random(), width: 650, height: 350
           });
       }

        function getChooseValuesItemName(list) {
            if (IsHaveId(list[0][0])) {
                alert("工单【" + list[0][1] + "】在列表中已经存在，不允许重复添加！");
                return false;
            }
            idStringlist = idStringlist + list[0][0] + ",";

           $.grep(listOrderDtl, function (o, j) {
               if (o.CountRow === thisRow) {
                   o.ProdOrderID = list[0][0];
                   o.OrderNO = list[0][1];
                   o.ItemName = list[0][5];
                   o.ItemCode = list[0][2];
                   o.ItemID = list[0][7];
               };
           });
           $(rowObj).find(".hdItemId").val(list[0][7]);
           $(rowObj).find(".txtItemName").val(list[0][5]);
           $(rowObj).find(".hdItemCode").val(list[0][2]);

           $(rowObj).find(".hdOrderNO").val(list[0][1]);
           $(rowObj).find(".hdProdOrderID").val(list[0][0]);
           

        }
        //是否存在
        function IsHaveId(value) {
            var fa = false;
            var hidlist = idStringlist.split(',');
            for (var i = 0; i < hidlist.length; i++) {
                if (hidlist[i] == value) {
                    fa = true;
                }
            }
            return fa;
        }




        var PageId = 0;
        function selectOrderNO() {
            PageId = 824;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=" + PageId + "&Multiple=false&rnd=" + Math.random(), width: 650, height: 320 });
        }
        function getChooseValue(list) {
            if (PageId == 824) {
                $("#<%=this.txtOrderNO.ClientID %>").val(list[0][1]);
                $("#<%=this.txtOrderId.ClientID %>").val(list[0][0]);
                $("#<%=this.lblItemCode.ClientID %>").text(list[0][2]);
                $("#<%=this.lblItemName.ClientID %>").text(list[0][5]);
                $("#<%=this.txtItemId.ClientID %>").val(list[0][7]);
               
            }
        }
    </script>
</asp:Content>
