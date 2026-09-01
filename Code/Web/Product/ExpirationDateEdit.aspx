<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="True"
    CodeBehind="ExpirationDateEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Product.ExpirationDateEdit"
    Title="Edit MaintenanceDemo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <table width="100%" class="EditeContentTable">
        <tr>
            <td colspan="4" class="Label infoTips">
                <%=Resources.Messages.WithAsteriskIsRequired %>
            </td>
        </tr>
        <tr class="clear5"></tr>
        <tr>
            <td class="Label1">保质期方案名称<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtExpirationDateName" runat="server" CssClass="TextBox" MaxLength="50" isRequired="1"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%= Resources.lang.Remark %>
            </td>
            <td class="Field1" colspan="2">
                <asp:TextBox ID="txtRemark" runat="server" CssClass="TextArea" TextMode="MultiLine"
                    MaxLength="50" Width="60%" Height="50"></asp:TextBox>
            </td>
        </tr>
    </table>
    <div class="clear5">
    </div>
    <table class="ListTable" cellspacing="0" cellpadding="4" style="border-width: 0px; width: 100%; overflow: auto; border-collapse: collapse;"
        id="tbPackLevel">
        <tr class="ListTableHeader">
            <th scope="col" align="center" width="10%">复检次数
            </th>
            <th scope="col" align="center" width="25%">复检保质期(天)
            </th>
            <th scope="col" align="center" width="45%">备注
            </th>
            <th scope="col" onclick="addPackLevelDetail(null);" style="color: #0066CC; cursor: pointer; width: 100px;"
                align="center" width="20%">+<%= Resources.Buttons.COM_Add%>
            </th>
        </tr>
    </table>
    <script type="text/javascript">
        var tab = document.getElementById("tbPackLevel");
        var Id = <%= Request.QueryString["ID"] == null ? -1 : Convert.ToInt32(Request.QueryString["ID"].ToString())%>;
        var userName = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>';
        var items=[];
        /*页面加载时*/
        $(document).ready(function(){
            if(Id > 0){
                GetExpirationDateDtlList(Id);
            }
        });
        function GetExpirationDateDtlList(demoId){
            var ajax = SKT.LeanMES.Web.AjaxServices.ExpirationDate.GetExpirationDateDtlList(demoId);
            if(ajax.error == null){
                
                var entityAry = ajax.value;
                for(var i=0; i < entityAry.length; i++){
                    addPackLevelDetail(entityAry[i]);
                    items.push(entityAry[i]);
                }
            }
            else{
                alert(ajax.error.Message);
            }
        }
        /*添加行*/
        function addPackLevelDetail(entity) {
        
            if(entity == null){
                entity = {};
                entity.ExpirationDateDtlId = -1;
                entity.Pid =Id;
                entity.Number = "";
                entity.DayNumber = "";
                entity.Remark = "";
            }

            var row, cell,optionvalue,disabled;
            rowNewIdx = tab.rows.length;

            entity.Number=rowNewIdx;
            row = tab.insertRow(rowNewIdx);
            row.className = "ListTableOddRow";

            optionvalue=entity.PackingLevel;
            cell = row.insertCell(0);
            cell.align = "center";
            cell.innerHTML = "<input id=\"hdfSubId\" name=\"hidden\" type=\"hidden\" width=\"20\"  value=\""+entity.ExpirationDateDtlId+"\"/>"
                +"<input type=\"text\" name=\"txtJobCode\" style=\"width:50px;\" maxlength=\"50\"  ReadOnly=\"true\" value=\""+(typeof(entity.Number)=='undenfind'?rowNewIdx:entity.Number)+"\" />";

            cell = row.insertCell(1);
            cell.align = "center";
            cell.innerHTML = "<input type=\"text\" name=\"txtJobName\" style=\"width:100px;\" maxlength=\"50\"value=\""+entity.DayNumber+"\" />";

            cell = row.insertCell(2);
            cell.align = "center";
            cell.innerHTML="<input type=\"text\" name=\"txtJobRemark\" style=\"width:150px;\" maxlength=\"50\"  value=\""+entity.Remark+"\" />";

            cell = row.insertCell(3);
            cell.align = "center";
            cell.innerHTML = "<span style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"deleteItem(this)\"><%= Resources.Buttons.COM_Delete %></span>&nbsp;&nbsp;&nbsp;&nbsp;<span style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"saveItem(this)\"><%= Resources.Buttons.COM_Save %></span>";   
        }
        function deleteItem(obj){
            if (!window.confirm("<%=Resources.Messages.ConfirmDelete %>")) {
                return false;
            }
            var subId = $(obj).parent().parent().find($("input[name='hidden']")).val();
            var ajax = SKT.LeanMES.Web.AjaxServices.ExpirationDate.DelDtl(subId);
            if(ajax){
                tab.deleteRow(obj.parentElement.parentElement.rowIndex);
                //序号重排
                for (var i = 0; i < $("#tbPackLevel tr:gt(0)").length; i++) {
                    $($("#tbPackLevel tr:gt(0) input[name='txtJobCode']")[i]).val(i+1);
                }

             
                items.pop();
            }
            else{
                alert("删除保质期方案失败!");
                return false;
            }
        }
     
        function saveItem(obj){
        var name = $("#<%=this.txtExpirationDateName.ClientID%>").val();
        if(name==""){
            alert("请输入保质期方案名称!");
            return false;
        }
        var entity = {};
        if($("#hdfSubId").val()=="-1"){
            entity.DemoSubId = -1;
        }
        else{
            entity.DemoSubId = parseInt($(obj).parent().parent().find($("input[name='hidden']")).val());
        }
        if(Id=="-1"){
            alert("请先保存保质期方案主表信息!");
            return false;
        }
        var re = /^[0-9]+.?[0-9]*$/; //判断字符串是否为数字 //判断正整数 /^[1-9]+[0-9]*]*$/ 
        var nubmer = $(obj).parent().parent().find("input[name='txtJobName']").val();

        if (!re.test(nubmer)) {
            alert("请输入数字");
            $(obj).parent().parent().find("input[name='txtJobName']").focus();
            return false;
        }
        entity.Pid = Id;
        entity.Number = $(obj).parent().parent().find("input[name='txtJobCode']").val();
        entity.DayNumber = $(obj).parent().parent().find("input[name='txtJobName']").val();                    
        entity.Remark = $(obj).parent().parent().find("input[name='txtJobRemark']").val();
        entity.CreateBy = userName;
        var ajax = SKT.LeanMES.Web.AjaxServices.ExpirationDate.EditDtl(entity);
        if (ajax.error != null) {
            alert(ajax.error.Message);
            return false;
        }
        items.push(entity);
        alert('<%=Resources.Messages.SaveInSuccess%>')
        }
        /*保存数据*/
        function Save() {
           
            var txtExpirationDateName = $.trim($("#<%=this.txtExpirationDateName.ClientID%>").val());
            var txtRemark = $.trim($("#<%=this.txtRemark.ClientID%>").val());
            if(Id>0)
            {
                if(items.length==0||$("#tbPackLevel .ListTableOddRow").length!=items.length)
                {
                    alert("未维护明细方案不能保存！");
                    return false;
                }
            }
         

            /*表单验证*/
            /*如需表单验证可以此处处理验证 开始*/

            var entity = {};

            entity.ExpirationDateId = Id
            entity.ExpirationDateName = txtExpirationDateName;
            entity.CheckCount =0;// $("#tbPackLevel tr:gt(0) input[name='txtJobCode']:last").val();
            entity.CreateBy = userName;
            entity.Remark = txtRemark;

            var ajax = SKT.LeanMES.Web.AjaxServices.ExpirationDate.Edit(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert('<%=Resources.Messages.SaveInSuccess%>')
             if('<%=Request.QueryString["inMenu"] %>' == "true") {
                openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Maintenance/MaintenanceDemoEdit.aspx?name=MaintenanceDemoEdit&ID=" + parseInt(ajax.value);
                location.href = openWinUrl;
            }
            else {
                parent.window.Refresh();
            }
        }
    </script>
</asp:Content>
