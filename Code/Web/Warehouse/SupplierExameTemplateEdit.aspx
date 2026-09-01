<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/EditMaster.master" 
    CodeBehind="SupplierExameTemplateEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Warehouse.SupplierExameTemplateEdit" %>


<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <style>
        .wrap_tb > div {
            clear: both;
            display: none;
            height: auto;
            padding-top: 5px;
        }
    </style>
     <%--选项卡 开始--%>
    <div class="wrap_tb" id="infoTabs">
        <ul class="tb">
            <li class="current" onclick="selHoldObjec(this,1)">考核模版</li>
            <li onclick="selHoldObjec(this,2)">关联供应商</li>
        </ul>
        <%--选项卡内容 工单Hold--%>
        <div id="infoTabContent-1" class="tb_c">
            <table class="EditeContentTable" width="100%">
                <tr>
                    <td class="Label2">
                        <em>*</em>模版编码：
                    </td>
                    <td class="Field2">
                        <input type="text" id="txtSupplierExameTempletCode" class="TextBox" ClientIDMode="Static" runat="server" disabled="disabled"/>                     
                    </td>
                    <td class="Label2">
                        <em>*</em>模版名称：
                    </td>
                    <td class="Field2">
                        <input type="text" id="txtSupplierExameTempletName" class="TextBox" ClientIDMode="Static" runat="server"/>                     
                    </td>
                </tr>
                <tr>
                    <td class="Label2">
                        <em>*</em>状态：
                    </td>
                    <td class="Field2">
                         <asp:DropDownList runat="server" ID="ddlIsEnable" Width="160" ClientIDMode="Static" >
                            <asp:ListItem Value="">请选择</asp:ListItem>
                            <asp:ListItem Value="启用" Selected="True">启用</asp:ListItem>
                            <asp:ListItem Value="禁用">禁用</asp:ListItem>
                        </asp:DropDownList>                   
                    </td>
                    <td class="Label2">
                        <em>*</em>类型：
                    </td>
                    <td class="Field2">
                         <asp:DropDownList runat="server" ID="ddlSupplierExameTempletType" Width="160" ClientIDMode="Static">
                            <asp:ListItem Value="">请选择</asp:ListItem>
                             <asp:ListItem Value="月度">月度</asp:ListItem>
                            <asp:ListItem Value="季度">季度</asp:ListItem>
                            <asp:ListItem Value="年度">年度</asp:ListItem>
                        </asp:DropDownList>                   
                    </td>
                </tr>
                <tr>          
                    <td class="Label2">
                       全部供应商可用：
                    </td>
                    <td class="Field2">
                        <asp:CheckBox ID="cbIsALLSupplier" ClientIDMode="Static" runat="server"  />
                    </td>          
                    <td class="Label2">
                       备注：
                    </td>
                    <td class="Field2">
                        <asp:TextBox ID="txtDescription" runat="server" CssClass="TextArea" TextMode="MultiLine"
                            Width="85%" ClientIDMode="Static"></asp:TextBox>
                    </td>
                </tr>
            </table>
            <table id="tblExpand" cellspacing="0" cellpadding="4" style="border-width: 0px; width: 100%; border-collapse: collapse; margin-top: 5px;"
                class="EditeContentTable">
                <tr class="ListTableHeader">
                     <th scope="col" style="width: 15%;">
                       考核内容<em>*</em>
                    </th>
                    <th scope="col" style="width: 15%;">
                       考核方式<em>*</em>
                    </th>
                    <th scope="col" style="width: 5%;">计算方法
                    </th>
                    <th scope="col" style="width: 5%;">考核权重%<em>*</em>
                    </th>
                    <th scope="col" style="width: 5%;">
                        排序
                    </th>
                    <th scope="col" id="thAddDetail" onclick="addDetail(null,'','-1','','');" style="color: #0066CC; cursor: pointer; width: 8%;">+
                        <%=Resources.lang.AddExameContent %>
                    </th>
                </tr>
                <tr id="trNewInfo" class="ListTableOddRow">
                    <td colspan="7" style="text-align: center;">
                        <%=Resources.Messages.HaveNothingData%>
                    </td>
                </tr>
            </table>
        </div>
        <%--选项卡内容 产品Hold--%>
        <div id="infoTabContent-2">
            <table class="EditeContentTable" width="100%">
                <tr>
                    <td class="Label1">
                        <em>*</em>供应商编号：
                    </td>
                    <td class="Field1">
                        <input type="text" id="txtVenCode" class="TextBox" />
                        <input id="cbVendor" type="button" class="ButtonBox" value="..." onclick="chooseVendorCode()" />
                    </td>                    
                </tr>
            </table>
            <table id="tblVendor" class="EditeContentTable" width="100%">
                <tr class="ListTableHeader">                     
                    <th scope="col" style="width: 15%;">
                       供应商编号
                    </th>
                    <th scope="col" style="width: 80%;">
                        供应商名称
                    </th>
                    <th scope="col" style="width: 10%;">操作</th>                                   
                </tr>
                <tr id="trNewVendor" class="ListTableOddRow">
                    <td colspan="3" style="text-align: center;">
                        <%=Resources.Messages.HaveNothingData%>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <asp:HiddenField ID="hdnIsBeUsed" runat="server" Value="0"/>
    <script type="text/javascript">
        var supplierExameTempletId = '<%=Request.QueryString["ID"]%>';
        var chooseFlag = 0;
        var objectFlag = 1; //默认工单
        var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>"
        var tab = document.getElementById("tblExpand");
        var tabVendor = document.getElementById("tblVendor");
        var IsBeUsed = $("#<%= hdnIsBeUsed.ClientID %>").val();
        var rowObj = null;
        var rowIndex = 0;
        var IsInti = false;

        $(document).ready(function () {
            //根据Id获取明细和供应商
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSupplierExame.GetTemplateDtlById(parseInt(supplierExameTempletId));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var list = ajax.value;
            for (i = 0; i < list.length; i++) {
                $("#trNewInfo").remove();
                AddNewDetail(list[i]);
            }

            var ajax1 = SKT.LeanMES.Web.AjaxServices.AjaxSupplierExame.GetTemplateVendorById(parseInt(supplierExameTempletId));
            if (ajax1.error != null) {
                alert(ajax1.error.Message);
                return false;
            }
            var list1 = ajax1.value;
            for (k = 0; k < list1.length; k++) {
                $("#trNewVendor").remove();
                $("#cbIsALLSupplier").attr("checked", false);
                AddNewVendor(list1[k]);
            }

            if (IsBeUsed == "1") {
                //$("#thAddDetail").attr("disabled", "disabled");
                $("#cbVendor").attr("disabled", "disabled");
            }
        })

        function selHoldObjec(obj, tag) {
            objectFlag = tag;
            selectTab(obj, tag);
        }
        //添加考核内容
        function addDetail(entity) {
           /* if (IsBeUsed == "1") {
                return false;
            }*/

            var SupplierExameTempletCode = $.trim($("#txtSupplierExameTempletCode").val());
            var SupplierExameTempletName = $.trim($("#txtSupplierExameTempletName").val());
            var IsEnable = $.trim($("#<%=this.ddlIsEnable.ClientID %>").val());
            if (!SupplierExameTempletCode) {
                alert("请填写模版编码!");
                return false;
            }
            if (!SupplierExameTempletName) {
                alert("请填写模版名称!");
                return false;
            }
            if (!IsEnable) {
                alert("请选择模版状态!");
                return false;
            }

            selectItems();
        }
        function selectItems() {
            var pageCondition = " IsEnable = 1 ";

            dialog({
                title: "<%=Resources.Common.ChooseWindow %>"
                , src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=823&CallBackFunc=getChooseValueExameContent&PageCondition=" + escape(pageCondition) + "&Multiple=false&rnd="
                    + Math.random(), width: 600, height: 300
            });
        }
        function getChooseValueExameContent(list) {  
            $("#trNewInfo").remove();
            var entity = {};
            
            if (list.length > 0 && list[0][1] != "") {
                //是否有选择重复
                var existsID = false;
                var ExameContentIds = $(tab).find("tr td input[name='ExameContentId']");
                for (var i = 0; i < ExameContentIds.length; i++) {
                    if ($(ExameContentIds[i]).val() == list[0][0]) {
                        existsID = true;
                        break;
                    }
                }
                if (existsID) {
                    alert("选择的考核内容(" + list[0][1] + ")重复,考核模板存在考核内容");
                    return;
                }

                entity.SupplierExameContentId = list[0][0];
                entity.SupplierExameName = list[0][1];
                entity.SupplierExameType = list[0][2];
                entity.SupplierExameCompute = list[0][3];
                entity.AssessmentWeight = "";
            }
            else {
                return false;
            }
            AddNewDetail(entity);
            return true;
        }

        function AddNewDetail(entity) {
          
            var row, cell;
            var rowNewIdx = tab.rows.length;
            row = tab.insertRow(rowNewIdx);
            row.className = "ListTableOddRow";

            var isUsedDisabled = IsBeUsed == "1" ? "COLOR: #808080;" : "COLOR: #0000ff;";

            cell = row.insertCell(0);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<input type=\"text\" name=\"txtSupplierExameName\"  IsRequired='1' class=\"TextBox\" value=\"" + entity.SupplierExameName + "\" disabled=\"disabled\" style=\" width:80%;\" >"
            + "<input type=\"hidden\" name=\"ExameContentId\"   value=\"" + entity.SupplierExameContentId + "\"/>";

            cell = row.insertCell(1);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<input type=\"text\" IsRequired='1'  style=\" width:90%;\" readonly='readonly' disabled='true'  class=\"TextBox\" value=\"" + entity.SupplierExameType + "\" />";

            cell = row.insertCell(2);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<input type=\"text\"   style=\" width:90%;\"  disabled='true'  class=\"TextBox\" value=\"" + entity.SupplierExameCompute + "\" />";

            cell = row.insertCell(3);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<input type=\"text\" IsRequired='1' " + isUsedDisabled + "  style=\" width:90%;\"  class=\"TextBox\" value=\"" + entity.AssessmentWeight
                + "\" onkeyup=\"limitNumRange(this)\" onafterpaste=\"limitNumRange(this)\"/>";

            cell = row.insertCell(4);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<a href='#' onclick='up(this)'><img src='../Content/images/arrowUp.gif' /></a><a href='#' onclick='down(this)'><img src='../Content/images/arrowDown.gif'/>";


            cell = row.insertCell(5);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<span style=\"CURSOR: pointer;" + isUsedDisabled + "\"  onclick=\"deleteItem(this,1)\"><%= Resources.Buttons.COM_Delete %></span>";
        }

        function up(obj) {
            var objParentTR = $(obj).parent().parent();
        
          
            var prevTR = objParentTR.prev();
            //ListTableHeader
            if (prevTR.attr("class") == "ListTableHeader") {
                return;
            }
            if (prevTR.length > 0) {
                prevTR.insertAfter(objParentTR);
            }
        }
        function down(obj) {
            var objParentTR = $(obj).parent().parent();
            var nextTR = objParentTR.next();
            if (nextTR.length > 0) {
                nextTR.insertBefore(objParentTR);
            }
        }

        function chooseVendorCode(obj) {
            dialog({
                title: "<%=Resources.Common.ChooseWindow %>"
                , src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=34&CallBackFunc=getChooseValue&Multiple=true&rnd="
                    + Math.random(), width: 600, height: 300
            });
        }
        function getChooseValue(list) {
            $("#trNewVendor").remove();            
            var entity = {};            
            if (list.length > 0 && list[0][1] != "") {
                //供应商是否有在同类型的模板下
                $("#cbIsALLSupplier").attr("checked", false);
                for (k = 0; k < list.length; k++) {
                    //是否有选择重复
                    var existsID = false;
                    var vendorIds = $(tabVendor).find("tr td input[name='VendorId']");
                    for (var i = 0; i < vendorIds.length; i++) {
                        if ($(vendorIds[i]).val() == list[k][0]) {
                            existsID = true;
                            break;
                        }
                    }
                    if (existsID) {
                        alert("选择的供应商(编码:" + list[k][1] + ")重复,考核模板已存在供应商");
                        return;
                    }
                    entity = {};
                    entity.SupplierID = list[k][0];
                    entity.VendorCode = list[k][1];
                    entity.VendorName = list[k][2];
                    AddNewVendor(entity);
                }
            }
            else {
                return false;
            }            
        }

        function AddNewVendor(entity) {
            var isUsedDisabled = IsBeUsed == "1" ? "COLOR: #808080;" : "COLOR: #0000ff;";

            var row, cell;
            var rowNewIdx = tabVendor.rows.length;
            row = tabVendor.insertRow(rowNewIdx);
            row.className = "ListTableOddRow";

            cell = row.insertCell(0);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = entity.VendorCode + "<input type=\"hidden\" name=\"VendorId\"   value=\"" + entity.SupplierID + "\"/>";

            cell = row.insertCell(1);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = entity.VendorName;

            cell = row.insertCell(2);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<span style=\"CURSOR: pointer;" + isUsedDisabled + "\"  onclick=\"deleteItem(this,2)\"><%= Resources.Buttons.COM_Delete %></span>";
        }

        function deleteItem(obj, flag) {
           /* if (IsBeUsed == "1") {
                return false;
            }
            */
            var trObj = $(obj).parent().parent(); //获取TR对象     
            trObj.remove();
            if (flag == 2) {
                if (tabVendor.rows.length == 1) {
                    $("#cbIsALLSupplier").attr("checked", true);
                }
            }
        }

        //保存数据
        function Save() {
            var SupplierExameTempletCode = $.trim($("#txtSupplierExameTempletCode").val());
            var SupplierExameTempletName = $.trim($("#txtSupplierExameTempletName").val());
            var IsEnable = $.trim($("#<%=this.ddlIsEnable.ClientID %>").val());
            var Description = $.trim($("#txtDescription").val());
            var SupplierExameTempletType = $("#ddlSupplierExameTempletType").val();
            var IsAllSupplier = $("#cbIsALLSupplier")[0].checked ? 1 : 0;
            if (!SupplierExameTempletCode) {
                alert("模版编码不能为空!");
                return false;
            }
            if (!SupplierExameTempletName) {
                alert("请填写模版名称!");
                return false;
            }
            if (!IsEnable) {
                alert("请填写模版状态!");
                return false;
            }
            if (SupplierExameTempletType == "") {
                alert("请选择模版类型!");
                return false;
            }
            var AllWeight = 0.00;
            var ExameTempletDtl = [];
            $("#tblExpand tr:gt(0)").each(function (index) {
                var SupplierExameContentId =$($(this).find("td").eq(0).find("input[name='ExameContentId']")[0]).val(); //考核内容ID
                var SupplierExameName = $($(this).find("td").eq(0).find("input[name='txtSupplierExameName']")[0]).val(); //考核内容
                var SupplierExameType = $($(this).find("td").eq(1).find("input")[0]).val(); //考核方式
                var SupplierExameCompute = $($(this).find("td").eq(2).find("input")[0]).val().trim(); //计算方法
                var AssessmentWeight = $($(this).find("td").eq(3).find("input")[0]).val(); //考核权重
                AllWeight = AllWeight + parseFloat(AssessmentWeight);                

                ExameTempletDtl.push({
                    "SupplierExameTempletID": parseInt(supplierExameTempletId),
                    "SupplierExameContentId": parseInt(SupplierExameContentId),
                    "SupplierExameName": SupplierExameName,
                    "SupplierExameType": SupplierExameType,
                    "SupplierExameCompute": SupplierExameCompute,
                    "AssessmentWeight": parseFloat(AssessmentWeight)
                });
            });
            

            if (AllWeight != 100) {
                alert("权重设置错误,权重总合计要是100");
                return false;
            }

            var vendors = [];
            $("#tblVendor tr:gt(0)").each(function () {
                var vendorId = $($(this).find("td input[name='VendorId']")[0]).val();
                if (vendorId != undefined) {
                    vendors.push({
                        "SupplierExameTempletID": parseInt(supplierExameTempletId),
                        "SupplierID": parseInt(vendorId)
                    });
                }
               
            });

            if (IsAllSupplier == 0 && vendors.length<=0) {
                alert("请设置可用供应商信息");
                return false;
            }
            var entity = {};
            entity.SupplierExameTempletID = parseInt(supplierExameTempletId);
            entity.SupplierExameTempletCode = SupplierExameTempletCode;
            entity.SupplierExameTempletName = SupplierExameTempletName;
            entity.SupplierExameTempletType = SupplierExameTempletType;
            entity.IsAllSupplier = IsAllSupplier;
            entity.IsEnable = IsEnable;
            entity.Description = Description;
            entity.CreateBy = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().EmployeeCName %>";

           // return;
            //entity.SupplierExameTempletDtl = JSON.stringify(ExameTempletDtl);
            //entity.ExameTempletVendor = JSON.stringify(vendors);
            //var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPrint.ExecuteSpc("uspSaveExameTemplet", JSON.stringify(entity));
        
           
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSupplierExame.SaveExameTemplet(entity, ExameTempletDtl, vendors);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            
            parent.window.UpdateList(entity.SupplierExameTempletName);
            
        }

        //限制文本框的数字输入范围
        function limitNumRange(input, min, max) {
            //参数处理
            min = min || 0;
            max = max || 100;
            if (!input || !input.value) return;
            //移除非数字
            input.value = input.value.replace(/[^\d]/g, '')
            //限制范围
            if (!input.value) return;
            var num = parseInt(input.value);
            if (num < min) {
                num = min;
            }
            if (num > max) {
                num = max;
            }
            input.value = num;
        }
    </script>
</asp:Content>


