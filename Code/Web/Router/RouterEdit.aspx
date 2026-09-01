<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/EditMaster.master"
    CodeBehind="RouterEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Router.RouterEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    
    <div class="wrap_tb">
        <ul class="tb">
            <li class="current">
                <%= Resources.lang.BaseInfo%></li>
         <%--   <li id="bindItem">已绑定产品</li>
            <li id = "bindOrder">已绑定工单</li>--%>
        </ul>
        <div class="tb_c">
        <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
            <table class="EditeContentTable" width="100%">
                <tr>
                    <td class="Label1">
                        <%=Resources.lang.RouterName%><em>*</em>
                    </td>
                    <td class="Field1">
                        <asp:TextBox ID="txtRouterName" runat="server" CssClass="TextBox" IsRequired='1' ClientIDMode="Static"
                            Width="200px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="Label1">
                        <%=Resources.lang.Status %>
                    </td>
                    <td class="Field1">
                        <asp:DropDownList ID="ddlRouterStatus" runat="server" ClientIDMode="Static">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td class="Label1">
                        <%=Resources.lang.Description%>
                    </td>
                    <td class="Field1">
                        <asp:TextBox ID="txtDescription" runat="server" CssClass="TextArea" TextMode="MultiLine" ClientIDMode="Static"></asp:TextBox>
                    </td>
                </tr>
            </table>
        </div>
        <div>
            <table class="ListTable" cellspacing="0" cellpadding="5" style="border-width: 0px;
                width: 100%; border-collapse: collapse;" id="tblExpand">
                <tr class="ListTableHeader">
                    <th scope="col" style="width: 30%;">
                        <%=Resources.lang.ItemsName%>
                    </th>
                    <th scope="col" style="width: 30%;">
                        <%=Resources.lang.ItemCode%>
                    </th>
                    <th scope="col" style="width: 30%;">
                        <%=Resources.lang.Revision%>
                    </th>
                    <%--                    <th scope="col" onclick="addDetail(null);" style="color:#0066CC;cursor:pointer; width:20%;">
                        +<%= Resources.Buttons.COM_Add%>
                    </th>--%>
                </tr>
            </table>
        </div>
        <div>
            <table class="ListTable" cellspacing="0" cellpadding="5" style="border-width: 0px;
                width: 100%; border-collapse: collapse;" id="tbOrderBindList">
                <tr class="ListTableHeader">
                    <th scope="col" style="width: 30%;">
                        工单号
                    </th>
                </tr>
            </table>
        </div>
    </div>
    <script type="text/javascript">
        var fromPage = '<%=Request.QueryString["From"] %>';
        fromPage = (fromPage=="") ? "" : "designer";
        var itemName = "";
        var rid = '<%=Request.QueryString["ID"] %>';
        var userName = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>';
        $(function () {           
//            if (parseInt(rid) > -1) {
//                initItemBind(rid);
//                initOrderBind(rid);
//            }         

//            if (fromPage != "") {
//                if (rid != -1) {
//                    $("#bindItem").click();
//                }
//            }
        });

        var rowIndex = -1;
        var rowObj = null;

        function selectItems(obj) {
            rowObj = obj.parentElement.parentElement;
            rowIndex = rowObj.rowIndex;
            var searchCondition = "RouterID=-1"; //just get no router item
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=1&SearchCondition=" + searchCondition + "&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }

        function getChooseValue(list) {
            if (!checkIsRepeat(list[0][0]) && checkedItemIsBindOtherRouter(list[0][0])) {
                rowObj.cells[0].children[2].value = list[0][0];
                rowObj.cells[0].children[0].value = list[0][1];
                rowObj.cells[1].children[0].value = list[0][2];
                rowObj.cells[1].children[1].innerText = list[0][2];
                rowObj.cells[2].children[0].value = list[0][3];
                rowObj.cells[2].children[1].innerText = list[0][3];
            }
        }

        function addDetail(entity) {
            if (entity == null || entity.length == 0) {
                $("#tblExpand").append("<tr class='ListTableOddRow'><td colspan='3' align='center' >暂无数据</td></tr>");
                return false;
            }

            var row, cell;

            var tab = document.getElementById("tblExpand");
            rowNewIdx = tab.rows.length;
            row = tab.insertRow(rowNewIdx);
            row.className = "ListTableOddRow";

            /*item name*/
            cell = row.insertCell(0);
            cell.align = "center";
            cell.innerHTML = "<span>" + entity.ItemName + "</span><span></span>"
            //cell.innerHTML = "<input type=\"text\" name=\"txtItems\" class=\"TextBox\" value=\""+entity.ItemName+"\" disabled=\"disabled\">"
            //+ "<input type=\"button\" id=\"btnSelectItems\" onclick=\"selectItems(this);\" class=\"ButtonBox\" value=\"...\" />"
            + "<input type=\"hidden\" name=\"hdnItemId\" value=\"" + entity.ItemId + "\" />";

            /*item code*/
            cell = row.insertCell(1);
            cell.align = "center";
            cell.innerHTML = "<input type=\"hidden\" name=\"hdnItemCode\" value=\"" + entity.ItemCode + "\"  /><span>" + entity.ItemCode + "</span>";

            /*item rev*/
            cell = row.insertCell(2);
            cell.align = "center";
            cell.innerHTML = "<input type=\"hidden\" name=\"hdnVersion\" value=\"" + entity.ItemRev + "\"  /><span>" + entity.ItemRev + "</span>";

            /*button*/
            //            cell = row.insertCell(3);
            //            cell.align = "center";
            //            cell.innerHTML = "<span style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"deleteItem(this)\"><%= Resources.Buttons.COM_Delete %></span>";
        }

        function initItemBind(rids) {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxRouter.GetItemBind(rids);
            if (ajax.error == null) {
                var entityAry = ajax.value;
                if (entityAry.length == 0) {
                    $("#tblExpand").append("<tr class='ListTableOddRow'><td colspan='3' align='center' >暂无数据</td></tr>");
                    return false;
                }

                for (var i = 0; i < entityAry.length; i++) {
                    addDetail(entityAry[i]);
                }
            } else {
                alert(ajax.error.Message);
            }
        }

        function initOrderBind(rids) {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxRouter.GetOrderBind(rids);
            if (ajax.error == null) {
                var entityAry = ajax.value;
                if (entityAry.length == 0) {
                    $("#tbOrderBindList").append("<tr class='ListTableOddRow'><td align='center'>暂无数据</td></tr>");
                    return false;
                }

                var html = "";
                for (var i = 0; i < entityAry.length; i++) {
                    html += "<tr  class='ListTableOddRow'><td>" + entityAry[i] + "</td></tr>";
                }
                $("#tbOrderBindList").append(html);

            } else {
                alert(ajax.error.Message);
            }


        }

        function deleteItem(obj) {
            tab.deleteRow(obj.parentElement.parentElement.rowIndex);
        }

        function checkIsRepeat(id) {
            var result = false;
            var idObj = document.getElementsByName("hdnItemId");
            for (var i = 0; i < idObj.length; i++) {
                if (idObj[i].value == id) {
                    result = true;
                    break;
                }
            }
            //if(result){alert("<%=Resources.Messages.RecordExists %>");}
            return result;
        }

        function Save() {
            if (isNull($("#txtRouterName").val())) {
                alert("<%=Resources.Messages.WithAsteriskIsRequiredAlert %>");
                return;
            }
            var action = "<%=this.IsCopy %>" == "1" ? 2 : -1;//动作
            /*BaseInfo*/
            var entity = {};
            entity.R_ID = rid;
            entity.R_Name = $("#txtRouterName").val();
            entity.R_Description = $("#txtDescription").val();
            entity.R_Status = $("#ddlRouterStatus").val();
            entity.CreateBy = userName;
            entity.ModifyBy = userName;
            entity.Remark = "";
            entity.Action = action;

            /*Bind Item*/
            var objItem = document.getElementsByName("hdnItemId");
            var itemIdString = "", seq = ",";

            for (var i = 0; i < objItem.length; i++) {
                if (parseInt(objItem[i].value) != -1) {
                    itemIdString += objItem[i].value + seq;
                }
            }

            /*Save Event*/
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxRouter.EditRouter(entity, itemIdString);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            if (fromPage == "") {
                alert("<%=Resources.Messages.SaveInSuccess %>");
                window.parent.UpdateList($("#txtRouterName").val());
            } else {
                if (rid != -1) {
                    alert("<%=Resources.Messages.SaveInSuccess %>");
                    window.parent.closeDialog();
                }
                else {
                    window.parent.setBaseValue(parseInt(ajax.value), entity.R_Name);
                    window.parent.saveCore();
                    window.parent.closeDialog();
                }
            }
        }



        /********************************************************/
        //zhibin.chen  2016-02-29  判断所绑定的产品中，是否存在
        /********************************************************/
        function checkedItemIsBindOtherRouter(itemid) {
            var result = false;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxRouter.CheckedItemIsBindOtherRouter(itemid, rid)
            if (ajax.error == null) {
                if (ajax.value == 0 || (ajax.value == 1 && window.confirm("该产品已绑定其它路由，是否要将此产品绑定到该路由？"))) {
                    result = true;
                }
                else {
                    result = false;
                }
            }
            else {
                alert("产品是否绑定路由检查出错！" + ajax.error.Message);
            }

            return result;
        }
    </script>
</asp:Content>
