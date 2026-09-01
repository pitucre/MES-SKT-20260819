<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="OrderPickListAdd.aspx.cs" Inherits="SKT.LeanMES.Web.SMT.OrderPickListAdd" %>
<%@ Import Namespace="Resources" %>
<%@ Import Namespace="SKT.LeanMES.Web" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">

    <table id="FTable" class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">
                工单<em>*</em>
            </td>
            <td class="Field3">
                 <input type="text" id="txtOrderNo" class="ui-textbox" IsRequired="1" style="width:80%" /><input id="button4" class="ButtonBox" type="button" onclick="openChoosePage(44)"  value="..." title="选择生产订单号" />                    
            </td>
            <td class="Label3">
                产品编码
            </td>
            <td class="Field3" colspan="3">
                <span id="lblItemName"></span>
            </td>
        </tr>  
        <tr>
          <td class="Label3">
                上料清单名<em>*</em>
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtPickListName" ClientIDMode="Static" runat="server" CssClass="TextBox"  isrequired="1" ></asp:TextBox>
            </td>           
            
           <td class="Label3">
                <%= Resources.lang.Revision %>
                <em>*</em>
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtRev" runat="server" CssClass="TextBox"  ClientIDMode="Static"  isrequired="1" Width="80" ></asp:TextBox>
            </td>
            <td class="Label3">
                备注
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtRemark" runat="server" CssClass="TextBox"  ClientIDMode="Static" ></asp:TextBox>
            </td>
        </tr>       
    </table>
    <table id="tblExpand" cellspacing="0" cellpadding="4" style="border-width: 0px; width: 100%;
        border-collapse: collapse; margin-top: 5px;" class="EditeContentTable">
        <tr class="ListTableHeader">
            <th scope="col" style="width: 4%;">
                <input name="chkAll" id="chkAll" onclick="checkAll();" type="checkbox" style='width:15px;height:15px' />
            </th>
             <th scope="col" style="width: 4%;">
                序号
            </th>
            <th scope="col" >
                物料编码
            </th>
            <th scope="col" style="">
                物料名称
            </th>
            <th scope="col" style="width: 8%;">
                数量
            </th>
            <th scope="col" style="width: 8%;">
                扣料组编码
            </th> 
            <th scope="col" style="width: 10%;">
                扣料组描述
            </th>
            <th scope="col" style="width: 15%;">
                备注
            </th>             
        </tr>
        <tr id="trNoData" class="ListTableOddRow"><td colspan="8" style="text-align: center;">暂无数据</td></tr>
    </table>
    <script type="text/javascript">

        var trNoDataHtml;       //暂无数据的HTML
        
        $(document).ready(function () {
            trNoDataHtml = $("#trNoData").html();
            //扫描框回车事件
            $("#txtOrderNo").keydown(
                function (e) {
                    var curKey = 0, e = e || window.event;
                    curKey = e.keyCode || e.which || e.charCode;

                    if (curKey == 13) {
                        stopDefault(e);
                        GetOrderBom($.trim(this.value));

                    }
                    if (curKey == 46) {
                        $("#txtOrder").val("");
                    }
                }
            );

            $("#chkAll").click(function () {
                if ($(this).prop("checked")) {
                    $("input[name=chkList]").prop("checked", true);
                    $("input[name=chkList]").parent().parent().find("td").css("background-color", "yellow");
                }
                else {
                    $("input[name=chkList]").prop("checked", false);
                    $("input[name=chkList]").parent().parent().find("td").css("background-color", "#fff");
                }
            });
        }); 
       
        function GetOrderBom(orderno) {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPickList.GetOrderBomInfo(orderno);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            $("#tblExpand .ListTableOddRow").remove();
            if (ajax.value && ajax.value.length > 0) {
                for (var i = 0; i < ajax.value.length; i++) {
                    addDetail(ajax.value[i], i);
                }
            }
            else {
                $("#tblExpand tbody").append(trNoDataHtml);
            }
        }

        //新增
        var tab = document.getElementById("tblExpand");
        
        function addDetail(entity,k) {
            
           
            var row, cell;
            rowNewIdx = tab.rows.length;
            row = tab.insertRow(rowNewIdx);
            row.className = "ListTableOddRow";
            
            cell = row.insertCell(0);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<input type='checkbox' style='width:15px;height:15px' name='chkList' onclick='check(this)' >";

            //行号
            cell = row.insertCell(1);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = (k+1);

            //产品编码
            cell = row.insertCell(2);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<input type='hidden' name='hdItemId' value='" + entity.ItemID + "' /><span >" + entity.ItemCode + "</span>";

            //产品名称
            cell = row.insertCell(3);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML =  entity.ItemName ;

            //数量
            cell = row.insertCell(4);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<input type='text' MaxLength='9' IsNumber='1' IsRequired='1' style='width:80%;' value='" + entity.Qty + "' name='txtQty'  />";

            var groupCode = "<select name='sltGroupCode' IsRequired='1' >";
            var groupDesc = "";
            var isCheck = "";
            for (var j = 1; j <= 10; j++) {
                isCheck = "";
                if (entity.GroupCode == j) {
                    isCheck = "selected='selected'";
                    groupDesc = "扣料组" + j;
                                        
                }
                groupCode += "<option value=" + j + " " + isCheck + ">" + j + "</option>";
            }

            //扣料组编码
            cell = row.insertCell(5);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = groupCode;

            //扣料组描述
            cell = row.insertCell(6);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<input type='text' style='width:90%;'   value='" + groupDesc + "' name='txtGroupDesc'  />";

            //备注
            cell = row.insertCell(7);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<input type='text' style='width:90%;' MaxLength='20' value='' class='txtRemark'  name='txtRemark' />";

            
        }
 
        function getChooseValue1(list) { 
            switch (globalFlag) {             
            case 44:   //选择工单             
                $("#txtOrderNo").val(list[0][1]);
                $("#lblItemName").text(list[0][2] + "【" + list[0][5] + "】");
                GetOrderBom(list[0][1]);
                break;          
            default:  
                break;
            }
        }

        function check(obj) {
            if ($(obj).prop("checked")) {               
                $(obj).parent().parent().find("td").css("background-color", "yellow")
            }
            else {
                $(obj).parent().parent().find("td").css("background-color", "#fff")
            }
            
        }

        function openChoosePage(flags) {
            var condition = "";
            globalFlag = flags;             
            dialog({
                title: "<%= Common.ChooseWindow %>",
                src: "<%= WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=" + flags +
                    "&Multiple=false&PageCondition=" +
                    escape(condition) +"&callBackFunc=getChooseValue1"+
                    "&rnd=" +
                    Math.random(),
                width: 700,
                height: 300
            });
        }

        function Save() {
            var orderNo = $.trim($("#txtOrderNo").val());
            var txtPickListName = $.trim($("#txtPickListName").val());
            var txtRev = $.trim($("#txtRev").val());
            var txtRemark = $.trim($("#txtRemark").val());
            
            var detailEntity = getDetail();

            if (detailEntity.itemIdArr == "") {
                alert("请选择上料清单所需物料信息！");
                return;
            }
           
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPickList.CollectOrderPickList(orderNo, txtPickListName, txtRev, txtRemark, JSON.stringify(detailEntity));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            
            alert('<%=Resources.Messages.SaveInSuccess%>');
            parent.window.Refresh();
        }

        function getDetail() {
            var itemIdArr = "";
            var itemQtyArr = "";
            var groupCodeArr = "";
            var groupDescArr = "";
            var remarkArr = "";
            
            $("#tblExpand tr:not(.ListTableHeader)").each(function () {
                if($(this).find("input[name=chkList]").prop("checked")){
                    itemIdArr += $(this).find("input[name=hdItemId]").val() + "^";
                    itemQtyArr += $(this).find("input[name=txtQty]").val() + "^";
                    groupCodeArr += $(this).find("select[name=sltGroupCode]").val() + "^";
                    groupDescArr += ($(this).find("input[name=txtGroupDesc]").val()) + "^";
                    remarkArr += $.trim($(this).find("input[name=txtRemark]").val())+ "^"; 
                }
                               
            });

            var entity = {};

            entity.itemIdArr = itemIdArr.substr(0, itemIdArr.length - 1);
            entity.itemQtyArr = itemQtyArr.substr(0, itemQtyArr.length - 1);
            entity.groupCodeArr = groupCodeArr.substr(0, groupCodeArr.length - 1);
            entity.groupDescArr = groupDescArr.substr(0, groupDescArr.length - 1);
            entity.remarkArr = remarkArr.substr(0, remarkArr.length - 1); 

            return entity;
        }

    </script>
</asp:Content>

