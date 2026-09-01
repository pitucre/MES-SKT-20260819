<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="SchedulPlanConfigEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Plan.SchedulPlanConfigEdit" %>
<%@ Import Namespace="Resources" %>
<%@ Import Namespace="SKT.LeanMES.Web" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
     <table class="EditeContentTable" width="100%">
        <tr>
            <td class="infoTips" align="left" colspan="4">
                <%=Resources.Messages.WithAsteriskIsRequired %>
            </td>
        </tr>
        <tr class="clear5">
        </tr>
        <tr>
            <td class="Label1">
                <%=Resources.lang.Name%><em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtName" runat="server" IsRequired='1'></asp:TextBox>
            </td>
        </tr>
         <tr>
          <td class="Label1">
                <%=Resources.lang.Status %>
            </td>
            <td class="Field1" >

                <asp:DropDownList runat="server" ID="ddlStatus">
                    <asp:ListItem>启用</asp:ListItem>
                    <asp:ListItem>禁用</asp:ListItem>
                </asp:DropDownList>
            </td>
             </tr>
        <tr>
            <td class="Label1">
                <%=Resources.lang.Remark%>
            </td>
            <td class="Field1">
                 <asp:TextBox ID="txtRemark" CssClass="TextArea" TextMode="MultiLine" runat="server"
                    ClientIDMode="Static" Width="90%" Height="55"></asp:TextBox>
            </td>
        </tr>
           <tr>
           
        </tr>
    </table>

    <table id="tblExpand" class="ListTable" style="border-width:0px;width:100%;border-collapse:collapse; margin-top:5px;" cellspacing="0" cellpadding="2">
        <tr class="ListTableHeader">
             <%-- <th scope="col">序号</th>--%>
              <th scope="col" style="width: 80%;text-align: center">计划时间(如八点半：0830)</th>
              <th scope="col" onclick="Add();" style="color: #0066CC; cursor: pointer; width: 20%;text-align: center">+
              新增
            </th>
        </tr>
    </table>
    
    <asp:HiddenField runat="server" ID="hidPid" Value="-1"/>
<%-- <script src="../Content/js/jquery-3.1.0.min.js"></script>--%>
    
    <script type="text/javascript">

        var index = 1;
        $(function() {
            var pid = $("#<%=this.hidPid.ClientID%>").val();
            if (pid > 0) {
                var listArr = GetDetail(pid);
                if (null != listArr) {
                    index = 1;
                    for (var i = 0; i < listArr.length; i++) {
                        addDetail(listArr[i], index);
                        index++;
                    }
                }
            }
        });
        function Add() {
            
            addDetail(null, index);
            index++;
        }

        function GetDetail(pid) {
            var result = SKT.LeanMES.Web.Plan.SchedulPlanConfigEdit.GetDetailAll(pid);
            if (result.error != null) {
                alert(result.error.Message);
                return false;
            }
            return result.value;

        }
        var tab = document.getElementById("tblExpand");
        var selectRowClass = "selectRow";
        var rowNewIdx;
        function addDetail(entity, i) {
           
            var row, cell;
            rowNewIdx = GetIndex();
            row = tab.insertRow(rowNewIdx);
            row.className = "ListTableOddRow";

            $("#trNewInfo").remove();


            //cell = row.insertCell(0);
            //cell.align = "center";
            //cell.className = "Field pointer";
            //cell.innerHTML = i;

            cell = row.insertCell(0);
            cell.align = "center";
            cell.className = "Field pointer";
            if (entity == null) {
                cell.innerHTML = '<input type="text" class="planTime" value="" MaxLength="50" onblur="ValTimeZx(this,1)" onkeyup="this.value=this.value.replace(/\D/g,\'\')" onafterpaste="this.value=this.value.replace(/\D/g,\'\')"  style="width:120px;height:25px;text-align: center"/>';
            } else {
                cell.innerHTML = '<input type="text" class="planTime" value="' + entity.PlanTime + '" MaxLength="50"  style="width:120px;height:25px;text-align: center" onblur="ValTimeZx(this,1)" onkeyup="this.value=this.value.replace(/\D/g,\'\')" onafterpaste="this.value=this.value.replace(/\D/g,\'\')"/>';
            }
           
            cell = row.insertCell(1);

            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<span style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"deleteItem(this)\"><%= Resources.Buttons.COM_Delete %></span>";
          
        }

        function GetIndex() {
            var list = $(tab).find("tr");
            for (var i = 0; i < list.length; i++) {
                if ($(list[i]).attr("class").indexOf(selectRowClass) > -1) {
                    return i;
                }
            }
            return tab.rows.length;
        }

        function deleteItem(obj) {
            if (typeof (obj) == "number") {
                tab.deleteRow(rowIndex);
            }
            else {
                tab.deleteRow(obj.parentElement.parentElement.rowIndex);
            }

        }

        /*保存数据*/
        function Save() {
            var entity = {};
            entity.Pid = $("#<%=this.hidPid.ClientID %>").val();
            entity.Name=$("#<%=this.txtName.ClientID %>").val();
            entity.IsEnable = $("#<%=this.ddlStatus.ClientID %>").val() === '启用' ? 0 : 1;
            entity.Remark = $("#<%=this.txtRemark.ClientID %>").val();
            entity.CreateBy = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";

            var planTimes = "";
            for (var i = 0; i < $("#tblExpand tr:gt(0)").length; i++) {
                var data = $("#tblExpand tr:gt(0)")[i];
                if (planTimes != "") {
                    planTimes += ",";
                }
                planTimes += $(data).find("td:eq(0) input").val();
               
            }
            if (planTimes == "") {
                alert("请添加计划时间");
                return;
            }
            entity.PlanTimeDetials = planTimes;
            var ajax = SKT.LeanMES.Web.Plan.SchedulPlanConfigEdit.Save(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert('<%=Resources.Messages.SaveInSuccess %>');
            parent.window.Refresh();
            return ajax;
        }

        function ValTimeZx(obj, type) {
      
            var timeValue = $(obj).val();
            if (timeValue.length <= 0) {
                return;
            }
            $(obj).val(intToTime($(obj).val()));
            timeValue = $(obj).val();
            var reg = /^(\d{1,2}):(\d{1,2})$/;
            var r = timeValue.match(reg);
            if (r == null) {
                alert("输入格式不正确，请按HH:mm的格式输入！");
                $(obj).val("");
                $(obj).focus();
                return;
            }
            var strs = new Array();
            strs = timeValue.split(":");
            if (parseInt(strs[0]) > 23 || parseInt(strs[1]) > 59) {
                alert("时间值不正确，小时不得大小23，分钟不得大于59！");
                $(obj).val("");
                $(obj).focus();
                return;
            }
        }

    </script>

</asp:Content>

   