<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MaterialBucketItemRelationEdit.aspx.cs"
    Inherits="SKT.LeanMES.Web.Product.MaterialBucketItemRelationEdit" MasterPageFile="~/Masters/EditMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">

    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label1">料号编码<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtMaterialBucketCode" runat="server" CssClass="TextBox" MaxLength="50" IsRequired='1' ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">备注
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtRemark" runat="server" CssClass="TextBox" MaxLength="50" ClientIDMode="Static" Width="90%"></asp:TextBox>
            </td>
        </tr>

    </table>

    <table id="tblExpand" cellspacing="0" cellpadding="4" style="border-width: 0px; width: 100%; border-collapse: collapse; margin-top: 5px;"
        class="EditeContentTable">
        <tr class="ListTableHeader">
            <th scope="col" style="width: 15%;">产品编码
            </th>
            <th scope="col" style="width: 15%;">产品名称
            </th>
            <th scope="col" id="thAddDetail" onclick="addDetail(null);" style="color: #0066CC; cursor: pointer; width: 8%;">+
               新增关联产品
            </th>
        </tr>
        <tr id="trNewInfo" class="ListTableOddRow">
            <td colspan="2" style="text-align: center;">
                <%=Resources.Messages.HaveNothingData%>
            </td>
        </tr>
    </table>
    <script type="text/javascript">


        var BucketId = <%=Request.QueryString["ID"]%>;
        var tab = document.getElementById("tblExpand");
        var rowObj = null;
        var rowIndex = 0;

        $(function () {
            initFTable();
        })

        function initFTable() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxProduct.GetMaterialBucketRelationItemList(BucketId);
            IsInti = true;
            var qty = 0;
            if (ajax.error == null) {
                var entityAry = ajax.value;
                if (entityAry.length > 0) {
                    for (var i = 0; i < entityAry.length; i++) {
                        addDetail(entityAry[i]);
                    }
                }
            }
        }


        function addDetail(entity) {
            if (entity == null) {
                entity = {};
                entity.ItemId = -1;
                entity.ItemCode = "";
                entity.ItemName = "";
            }

            $("#trNewInfo").remove();
            var row, cell;
            rowNewIdx = tab.rows.length;
            row = tab.insertRow(rowNewIdx);
            row.className = "ListTableOddRow";

            cell = row.insertCell(0);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = " <input type=\"hidden\" class=\"hdItemId\" value=\"" + entity.ItemId + "\" />"
                + "<input type=\"text\" name=\"txtLineName\"  IsRequired='1' class=\"TextBox\" value=\"" + entity.ItemCode + "\" disabled=\"disabled\" style=\" width:150px;\" >"
                + "<input type=\"button\" id=\"btnSelectItems\" onclick=\"selectItems(this);\" class=\"ButtonBox\" value=\"...\"  />";


            cell = row.insertCell(1);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = entity.ItemName;

            cell = row.insertCell(2);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<span style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"deleteItem(this)\"><%= Resources.Buttons.COM_Delete %></span>";


        }

        function Save() {

            var ItemIdArr = GetArrValue($(".hdItemId"));
            var entity = {};
            entity.BucketId = BucketId;
            entity.MaterialBucketCode = $("#<%=this.txtMaterialBucketCode.ClientID %>").val();
            entity.Remark = $("#<%=this.txtRemark.ClientID %>").val()
            entity.ItemAttr = ItemIdArr;
            entity.CreateBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxProduct.EditMaterialBucket(entity);

            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert('<%=Resources.Messages.SaveInSuccess%>');
            parent.window.Refresh();

        }
        function selectItems(obj) {
            rowObj = obj.parentElement.parentElement;
            rowIndex = rowObj.rowIndex;
            dialog({
                title: "<%=Resources.Common.ChooseWindow %>"
                , src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=1&CallBackFunc=getChooseValueLine&Multiple=false&rnd="
                    + Math.random(), width: 600, height: 300
            });
        }

        function deleteItem(obj) {
            var trObj = $(obj).parent().parent(); //获取TR对象     
            trObj.remove();
        }

        function getChooseValueLine(list) {
         
            var isOk = 0;
            $(".hdItemId").each(function (i) {
              
                if (list[0][0] == $(this).val()) {
                    isOk = 1;
                }

            })

            if (isOk == 0) {
                var ItemIdObj = $(".hdItemId");
                var ItemId = list[0][0];
                rowObj.cells[0].children[0].value = ItemId;
                rowObj.cells[0].children[1].value = list[0][2];
                rowObj.cells[1].innerHTML = list[0][1];
            }
            

            return true;
        }

        //获取对象数组里的val值，返回'1,2,3,4,5'
        function GetArrValue(o) {
            var str = "";
            for (var i = 0; i < o.length; i++) {
                if (i == 0) {
                    str = $(o[i]).val();
                }
                else {
                    str += "," + $(o[i]).val();
                }
            }
            return str;
        }

    </script>
</asp:Content>

