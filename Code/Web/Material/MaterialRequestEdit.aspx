<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" 
CodeBehind="MaterialRequestEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Material.MaterialRequestEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">

    <table id="FTable" class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2"> <%= Resources.lang.MaterialRequestOrderNumber %><em>*</em> </td>
            <td class="Field2">
                <asp:TextBox ID="txtFormNO" runat="server"  IsRequired='1' Text="" Enabled="false"></asp:TextBox>
                </td>
            <td class="Label2"><%= Resources.lang.ProcessFormNO %></td>
             <td class="Field2"> 
                <asp:TextBox ID="txtWONumber" runat="server" CssClass="TextBox"  Enabled="false"></asp:TextBox>
                 <input id="button1" class="ButtonBox" type="button" onclick="selectWOValue()" value="..." title="选择流程单" /> 
                <asp:HiddenField ID="hfWOId" runat="server" Value="-1" />
            </td>
            
        </tr>
        <tr>
            
            
            <td class="Label2"> <%= Resources.lang.DepartmentName%><em>*</em>  </td>
            <td class="Field2"> 
                <asp:TextBox ID="txtDepartment" runat="server" CssClass="TextBox" IsRequired='1' Enabled="false"></asp:TextBox>
                 <input id="button2" class="ButtonBox" type="button" onclick="selectDepartmentValue()" value="..." IsRequired='1' title="选择部门" /> 
                <asp:HiddenField ID="hfDepartId" runat="server" Value="0" />
            </td>
            <td class="Label2"> <%= Resources.lang.Requestor%><em>*</em>  </td>
            <td class="Field2"> 
                <asp:TextBox ID="txtRequestUser" runat="server" CssClass="TextBox" Enabled="false" IsRequired='1'>
                    </asp:TextBox><input type="button" id="btnSelectCustomer" class="ButtonBox" value="..."  title="选择用户" onclick="selectUserValue();"/>
                   <asp:HiddenField ID="hfRequestUserId" runat="server" Value="0" />
                 </td> 
        </tr>
        <tr>
            <td class="Label2">Resources.lang.Priority<em>*</em>  </td>
            <td class="Field2"> 
                <asp:DropDownList ID="ddlPrioritys" runat="server">
                </asp:DropDownList>
            </td> 
             <td class="Label2"> <%= Resources.lang.UserDate%><em>*</em> </td>
             <td class="Field2"> 
                 <asp:TextBox ID="txtUserDate" runat="server" CssClass="DateTimeBox"  IsRequired='1'></asp:TextBox>
             </td> 
        </tr>
    </table>
    <table id="tblExpand"  cellspacing="0" cellpadding="4" style="border-width:0px;width:100%;border-collapse:collapse; margin-top:5px;" class="EditeContentTable">
        <tr class="ListTableHeader">
            <th scope="col" style="width:25%;">
                <%= Resources.lang.MaterialName%> 
            </th>
             <th scope="col" style="width:25%;">
                 物料描述
            </th>
            <th scope="col"  style="width:10%;">
                <%= Resources.lang.VersionNumber%> 
            </th>
            <th scope="col"  style="width:10%;">
               <%= Resources.lang.PickingQty%>    
            </th>
            <th scope="col"  style="width:10%;">
               <%= Resources.lang.PartUnit%>    
            </th>
            <th scope="col"  style="width:20%;">
                <%= Resources.lang.Remark%>     
            </th>
            <th scope="col" onclick="addDetail(null);" style="color:#0066CC;cursor:pointer; width:10%;">
                +<%= Resources.Buttons.COM_Add%>
            </th>
        </tr>
         <tr id="trNewInfo" class="ListTableOddRow"><td colspan="7" style="text-align:center;">暂无数据</td></tr>
    </table>
    
    <script type="text/javascript">
        _isHms = true; /*日期控件开启时分秒*/

        var materialRequestId = '<%=Request.QueryString["ID"]%>';
     
        $(function () {
            /*如何是新增，给领料人赋给默认值*/
            if (materialRequestId == '-1') {
                $("#<%=this.txtRequestUser.ClientID %>").val("<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>");
                $("#<%=this.hfRequestUserId.ClientID %>").val("<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserId %>");
            }

           initFTable();

            /*加载领料记录*/
            initItem(materialRequestId);

        });

        function Save() {
            var hdItemId = $(".hdItemId");
            var bb = false;
            if (typeof (hdItemId) == "undefined") {
                bb = false;
            }
            else {
                for (var i = 0; i < hdItemId.length; i++) {
                    if ("-1" != $(hdItemId[i]).val() + "") {
                        bb = true;
                    }
                }
            }
            if (!bb) {

                alert("<%=Resources.Messages.PleaseAddMaterial %>");
                return;
            }

            var txtFormNO = $.trim($("#<%=this.txtFormNO.ClientID%>").val());
            var txtDepartId = $("#<%=this.hfDepartId.ClientID%>").val();
            var txtRequestUserId = $("#<%=this.hfRequestUserId.ClientID%>").val();
            var txtUserDate = $("#<%=this.txtUserDate.ClientID%>").val();
            var Prioritys = $("#<%=this.ddlPrioritys.ClientID%>").val();
            var WOId = $("#<%=this.hfWOId.ClientID%>").val();

            var entity = {};
            entity.MaterialRequestId = materialRequestId
            entity.FormNO = txtFormNO;
            entity.DepartId = txtDepartId;
            entity.RequestUserId = txtRequestUserId;
            entity.UserDateStr = txtUserDate;
            entity.Prioritys = Prioritys;
            entity.WOId = WOId;
            entity.CreateBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>'
            entity.ModifyBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>'

            if (SubmitValidation()) {
                //获取已领料状态
                ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.Editable(entity.MaterialRequestId);
                if (ajax.error != null) {
                    return false;
                }
                //ajax.value为1表示没领料或不存此领料单据
                if (parseInt(ajax.value) == 1) {
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.MaterialRequestEdit(entity);
                    if (ajax.error != null) {
                        return false;
                    }
                    else {

                        ajax = MaterialRequestMemberEdit(ajax.value);
                    }
                    if (ajax.error != null) {
                        alert(ajax.error.Message);
                        return false;
                    }
                    alert('<%=Resources.Messages.SaveInSuccess%>');
                    parent.window.Refresh();
                }           
            }
        }


        function MaterialRequestMemberEdit(id) {
            var hdMaterialRequestMemberId = $(".hdMaterialRequestMemberId");
            var hdItemId = $(".hdItemId");
            var RequestQty = $(".RequestQty");
            var Remark = $(".Remark");


            var ent = {};
            ent.MaterialRequestId = id;
            ent.MaterialRequestMemberIdS = GetArrValue(hdMaterialRequestMemberId);
            ent.ItemIdS = GetArrValue(hdItemId);
            ent.RequestQtyS = GetArrValue(RequestQty);
            ent.RemarkS = GetArrValue(Remark); 
            return ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.MaterialRequestMemberEdit(ent);


        }

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

        var tab = document.getElementById("tblExpand");
        function addDetail(entity) {
            if (entity == null) {
                entity = {};
                entity.ItemId = -1;
                entity.IteRev = "";
                entity.ItemName = "";
                entity.ItemDesc = "";
                entity.MaterialRequestMemberId = -1;
                entity.RequestQty = 0;
                entity.Remark = "";
                entity.Unit = "";
            }
            //add  by weixia  on  2015/5/7
            $("#trNewInfo").remove();
            var row, cell;
            rowNewIdx = tab.rows.length;
            row = tab.insertRow(rowNewIdx);
            row.className = "ListTableOddRow";

            cell = row.insertCell(0);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = " <input type=\"hidden\" class=\"hdMaterialRequestMemberId\" value=\"" + entity.MaterialRequestMemberId + "\" />"
            + "<input type=\"hidden\" class=\"hdItemId\" value=\"" + entity.ItemId + "\" />"
            + "<input type=\"text\" name=\"txtItems\" class=\"TextBox\" value=\"" + entity.ItemName + "\" disabled=\"disabled\" style=\" width:85%;\" >"
            + "<input type=\"button\" id=\"btnSelectItems\" onclick=\"selectItems(this);\" class=\"ButtonBox\" value=\"...\" />";

            cell = row.insertCell(1);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<input type=\"text\" name=\"txtVersion\" class=\"TextBox\" style=\" width:90%;\" disabled=\"disabled\" value=\"" + entity.ItemDesc + "\"  />"
            
            cell = row.insertCell(2);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<input type=\"text\" name=\"txtVersion\" class=\"TextBox\" style=\" width:90%;\" disabled=\"disabled\" value=\"" + entity.IteRev + "\"  />"
          
          
            cell = row.insertCell(3);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<input type=\"text\" id=\"txtRequestQty\" IsNumber='1' IsRequired='1' MinValue='1' style=\" width:90%;\" class=\"RequestQty\" value=\"" + entity.RequestQty + "\"  />"

            cell = row.insertCell(4);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<input type=\"text\" name=\"txtUnit\" class=\"TextBox\" style=\" width:90%;\" disabled=\"disabled\" value=\"" + entity.Unit + "\"  />"

            cell = row.insertCell(5);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<input type=\"text\" id=\"txtRemark\" class=\"Remark\" style=\" width:90%;\" value=\"" + entity.Remark + "\"  />"

            cell = row.insertCell(6);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<span style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"deleteItem(this)\"><%= Resources.Buttons.COM_Delete %></span>";
        }

        function initItem(id) {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.MaterialRequestMember_GetListByID(id);
            if (ajax.error == null) {
                var entityAry = ajax.value;
                for (var i = 0; i < entityAry.length; i++) {
                    addDetail(entityAry[i]);
                }
            } else {
                alert(ajax.error.Message);
            }
        }

        function deleteItem(obj) {
            tab.deleteRow(obj.parentElement.parentElement.rowIndex);
        }

        function selectDepartmentValue() {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=13&CallBackFunc=getChooseValueDepartment&Multiple=false&rnd=" + Math.random(), width: 500, height: 300 });
        }

        function selectUserValue() {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=12&CallBackFunc=getChooseValueUser&Multiple=false&rnd=" + Math.random(), width: 500, height: 300 });
        }

        function getChooseValueDepartment(list) {
            $("#<%=this.txtDepartment.ClientID %>").val(list[0][2]);
            $("#<%=this.hfDepartId.ClientID %>").val(list[0][0]);
        }

        function getChooseValueUser(list) {
            $("#<%=this.txtRequestUser.ClientID %>").val(list[0][2]);
            $("#<%=this.hfRequestUserId.ClientID %>").val(list[0][0]);
        }

        var flag = -1;
        var rowIndex = -1;
        var rowObj = null;
        function selectItems(obj) {
            flag = 5;
            rowObj = obj.parentElement.parentElement;
            rowIndex = rowObj.rowIndex;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=1&CallBackFunc=getChooseValueMaterial&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }

        function getChooseValueMaterial(list) {
            var mid = list[0][0];
            var b = true;
            var o = $(".hdItemId");
            for (var i = 0; i < o.length; i++) {
                if (mid == $(o[i]).val()) {
                    b = false;
                    alert("<%= Resources.Messages.MaterialExist %>");
                }
            }
            if (b == true) {
                if (flag == 5) {
                    rowObj.cells[0].children[1].value = list[0][0];
                    rowObj.cells[0].children[2].value = list[0][1];
                    rowObj.cells[1].children[0].value = list[0][3];
                    rowObj.cells[2].children[0].value = list[0][2];
                    rowObj.cells[4].children[0].value = list[0][5];
                }
            }
            flag = -1;
        }

        function selectWOValue() {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=28&CallBackFunc=getChooseValueWO&Multiple=false&rnd=" + Math.random(), width: 500, height: 300 });
        }

        function getChooseValueWO(list) {
            $("#<%=this.hfWOId.ClientID %>").val(list[0][0]);
            $("#<%=this.txtWONumber.ClientID %>").val(list[0][1]);
        }

        function initFTable() {
            if (parseInt(materialRequestId) == -1) {
               
                var trObj = $("#FTable").find("tr");
                var tdObj1 = $(trObj[0]).find("td");
                $(tdObj1[0]).css("display", "none");
                $(tdObj1[1]).css("display", "none");

                var tdObj2 = $(trObj[1]).find("td");
                var str = "<td class=\"Label2\">" + $(tdObj2[0]).html() + "</td><td class=\"Field2\">" + $(tdObj2[1]).html() + "</td>";
                $(trObj[0]).append(str);
                $(tdObj2[0]).empty().remove();
                $(tdObj2[1]).empty().remove();

                var tdObj3 = $(trObj[2]).find("td");
                str = "<td class=\"Label2\">" + $(tdObj3[0]).html() + "</td><td class=\"Field2\">" + $(tdObj3[1]).html() + "</td>";
                $(trObj[1]).append(str);
                $(tdObj3[0]).empty().remove();
                $(tdObj3[1]).empty().remove();           
            }       
        }
    </script>

</asp:Content>
