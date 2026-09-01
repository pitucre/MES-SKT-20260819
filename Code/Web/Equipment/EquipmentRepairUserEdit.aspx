<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="EquipmentRepairUserEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.EquipmentRepairUserEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <table width="100%" class="EditeContentTable">
        <tr>
            <td colspan="4" class="Label"><em>*</em><span>为必填项</span>
            </td>
        </tr>
        <tr class="edituser">
            <td class="Label2">用户名<em>*</em>
            </td>
            <td class="Field2">
                <asp:HiddenField ID="hidUserId" runat="server" ClientIDMode="Static" />
                <asp:TextBox ID="txtUserName" runat="server" CssClass="TextBox" Enabled="false" ClientIDMode="Static" IsRequired='1'></asp:TextBox><input type="button" value="..." class="ButtonBox" title="选择用户" onclick="chooseUser()" />
            </td>
            <td class="Label2">中文名
            </td>
            <td class="Field2">
                <asp:Label ID="lblCName" runat="server" Text="" ClientIDMode="Static"></asp:Label>
            </td>
        </tr>
        <tr>
    <%--        <td class="Label2">班次
            </td>
            <td class="Field2">
                <select id='ddlWorkshift' runat="server" clientidmode="Static">
                    <option value="0" selected="selected">无</option>
                    <option value="1">甲班</option>
                    <option value="2">乙班</option>
                </select>
            </td>--%>
            <td class="Label2">邮箱
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtEmail" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">电话
            </td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtPhone" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">部门
            </td>
            <td class="Field2" colspan="3">
                <asp:HiddenField ID="hdnDepartId" runat="server" Value="-1" ClientIDMode="Static" />
                <asp:TextBox ID="txtDepartName" runat="server" CssClass="TextBox" Width="300" ClientIDMode="Static" Enabled="false"></asp:TextBox><input type="button" value="..." class="ButtonBox" title="选择部门" onclick="chooseParentDepart()" />
            </td>
        </tr>
    </table>
    <%--
    <div>异常类型<em>*</em></div>
    <table class="ListTable" width="100%" id="anormal-list">
        <thead>
            <tr class="ListTableHeader">
                <th>异常类型分组名称
                </th>
                <th>异常类型名称
                </th>
                <th>异常类型代码
                </th>
                <th><a type="button" href="#" onclick="selectAnormal()">新增</a></th>
                
            </tr>
        </thead>
        <tbody></tbody>
    </table>
    --%>
    <div style="display:none"><span>工序</span><em>*</em></div>
    <table class="ListTable" width="100%" id="station-list" style="display:none">
        <thead>
            <tr class="ListTableHeader">
                <th>工序
                </th>
                <th>工序类型
                </th>
                <th>工序描述
                </th>
                <th><a type="button" href="#" onclick="selectStation()">新增</a></th>
            </tr>
        </thead>
        <tbody></tbody>
    </table>

    <asp:HiddenField runat="server" ID="hdnEquipmentRepairUserId" Value="-1" />
    <script type="text/javascript">
        var equipmentRepairUserId = parseInt('<%=Request.QueryString["ID"]%>');
        var flag = -1;

        $(document).ready(function () {
            $(".delete-station").live("click", function () {
                $(this).closest("tr").remove();
            });

            if (equipmentRepairUserId > 0) {
                //getAnormalList();
                getStationList();
            }
        });

        //function getAnormalList() {
        //var entity = {};
        //entity.EquipmentRepairUserId = parseInt(equipmentRepairUserId);
        //var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipment.GetEquipmentRepairUserAnormalTypeList(entity);
        //if (ajax.error != null) {
        //    alert(ajax.error.Message);
        //    return false;
        //}
        //var list = ajax.value;
        //var hl = "";
        //for (var i = 0; i < list.length; i++) {
        //    hl += "<tr class=\"ListTableOddRow\" id=\"" + list[i].AnormalTypeId + "\">" +
        //        "<td>" + list[i].AnormalGroupName + "</td>" +
        //        "<td>" + list[i].AnormalTypeName + "</td>" +
        //        "<td>" + list[i].AnormalTypeCode + "</td>" +
        //        "<td><a href=\"#\" class=\"delete-station\">删除</a></td>" +
        //        "</tr>";
        //}
        //$("#anormal-list tbody").append(hl);
        //}

        function getStationList() {
            var entity = {};
            entity.EquipmentRepairUserId = parseInt(equipmentRepairUserId);
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipment.GetEquipmentRepairUserStationList(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var list = ajax.value;
            var hl = "";
            for (var i = 0; i < list.length; i++) {
                hl += "<tr class=\"ListTableOddRow\" id=\"" + list[i].StationId + "\">" +
                    "<td>" + list[i].Station + "</td>" +
                    "<td>" + list[i].StationType + "</td>" +
                    "<td>" + list[i].StationDesc + "</td>" +
                    "<td><a href=\"#\" class=\"delete-station\">" + mesLang("删除") + "</a></td>" +
                    "</tr>";
            }
            $("#station-list tbody").append(hl);
        }

        /*保存数据*/
        function Save() {
            var userId = $("#hidUserId").val();
          <%--  var ddlWorkshift = $.trim($("#<%=this.ddlWorkshift.ClientID %>").val());--%>
            var txtEmail = $.trim($("#<%=this.txtEmail.ClientID %>").val());
            var txtPhone = $.trim($("#<%=this.txtPhone.ClientID %>").val());
            var hdnDepartId = $("#<%=this.hdnDepartId.ClientID %>").val();
            //var anormalTypeIds = [];
            //$("#anormal-list tbody tr").each(function () {
            //    anormalTypeIds.push($(this).attr("id"));
            //});
            //if (anormalTypeIds.length <= 0) {
            //    alert("请先添加异常类型");
            //    return false;
            //}
            var stationIds = [];
            $("#station-list tbody tr").each(function () {
                stationIds.push($(this).attr("id"));
            });
            //if (stationIds.length <= 0) {
            //    alert("请先添加工序");
            //    return false;
            //}
            if (!isNull(txtPhone) && !checkPhone(txtPhone)) {
                $("#<%=this.txtPhone.ClientID %>").addClass("inputerror");
                return false;
            }
            if (!isNull(txtEmail) && !checkEmail(txtEmail)) {
                $("#<%=this.txtEmail.ClientID %>").addClass("inputerror");
                return false;
            }

            var entity = {};
            entity.EquipmentRepairUserId = parseInt(equipmentRepairUserId);
            entity.UserId = parseInt(userId);
            entity.DepartId = parseInt(hdnDepartId);
            entity.Email = txtEmail;
            entity.Phone = txtPhone;
          //  entity.WorkShift = parseInt(ddlWorkshift);
            //entity.AnormalTypeIds = anormalTypeIds.join(",");
            entity.StationIds = stationIds.join(",");

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipment.EquipmentRepairUserEdit(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert('<%=Resources.Messages.SaveInSuccess%>');
            parent.window.Refresh();
        }

        function chooseParentDepart() {
            flag = 0;
            dialog({ title: "选择部门", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot  %>/Organization/OrganizationTree.aspx?rnd=" + Math.random(), width: 350, height: 450 });
        }

        function getChooseValue(departId, departName, departNo) {
            $("#<%=this.hdnDepartId.ClientID %>").val(departId);
            if (departNo != "") {
                $("#<%=this.txtDepartName.ClientID %>").val(departName + "(" + departNo + ")");
            }
            else {
                $("#<%=this.txtDepartName.ClientID %>").val(departName);
            }
            closeDialog();
        }

        <%--//选择异常类型
        function selectStation() {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=60&CallBackFunc=getChooseAnormalValue&Multiple=true&rnd=" + Math.random(), width: 600, height: 300 });
        }
        
        function getChooseAnormalValue(list) {
            var hl = "";
            var len = $("#anormal-list tbody tr").length;
            for (var i = 0; i < list.length; i++) {
                //判断是否存在，存在则不新增
                if ($("#anormal-list tbody tr[id=\"" + list[i][0] + "\"]").length > 0) {
                    continue;
                }
                hl += "<tr class=\"ListTableOddRow\" id=\"" + list[i][0] + "\">" +
                    "<td>" + list[i][4] + "</td>" +
                    "<td>" + list[i][2] + "</td>" +
                    "<td>" + list[i][1] + "</td>" +
                    "<td><a href=\"#\" class=\"delete-station\">删除</a></td>" +
                    "</tr>";
            }
            $("#anormal-list tbody").append(hl);
        }
        --%>

        //选择工序
        function selectStation() {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=8&CallBackFunc=getChooseStationValue&Multiple=true&rnd=" + Math.random(), width: 600, height: 300 });
        }

        function getChooseStationValue(list) {
            var hl = "";
            var len = $("#station-list tbody tr").length;
          
            for (var i = 0; i < list.length; i++) {
             
                //判断是否存在，存在则不新增
                if ($("#station-list tbody tr[id=\"" + list[i][0] + "\"]").length > 0) {
                    continue;
                }
                hl += "<tr class=\"ListTableOddRow\" id=\"" + list[i][0] + "\">" +
                    "<td>" + list[i][1] + "</td>" +
                    "<td>" + list[i][2] + "</td>" +
                    "<td></td>" +
                    "<td><a href=\"#\" class=\"delete-station\">删除</a></td>" +
                    "</tr>";
            }
           
            if (list[0].length > 3) {
               
                return;
            }
            $("#station-list tbody").append(hl);
        }


        //选择用户
        function chooseUser() {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=12&CallBackFunc=getChooseUserValue&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }

        function getChooseUserValue(list) {
            $("#hidUserId").val(list[0][0]);
            $("#txtUserName").val(list[0][3]);
            $("#lblCName").text(list[0][2]);
            //获取部门等信息

         <%--   $("#<%=this.ddlWorkshift.ClientID %>").val("0");--%>
            $("#<%=this.txtEmail.ClientID %>").val("");
            $("#<%=this.txtPhone.ClientID %>").val("");
            $("#<%=this.hdnDepartId.ClientID %>").val("-1");
            $("#<%=this.txtDepartName.ClientID %>").val("");

            var entity =
            {
                Workshift: 0,
                Email: "",
                Phone: "",
                DepartId: -1,
                DepartName: ""
            };
            if (list[0][0] != -1) {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxAccount.GetUserInfo(parseInt(list[0][0]));
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                if (ajax.value != null) {
                    entity = ajax.value;
                }
                //if (entity.Workshift == "") {
                //    entity.Workshift = 0;
                //}
            }

          <%--  $("#<%=this.ddlWorkshift.ClientID %>").val(entity.Workshift);--%>
            $("#<%=this.txtEmail.ClientID %>").val(entity.Email);
            $("#<%=this.txtPhone.ClientID %>").val(entity.Phone);
            $("#<%=this.hdnDepartId.ClientID %>").val(entity.DepartId);
            $("#<%=this.txtDepartName.ClientID %>").val(entity.DepartName);

        }

    </script>
</asp:Content>
