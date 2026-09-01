<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    Inherits="SKT.MES.Web.BasalData.ShiftMemberEdit" CodeBehind="ShiftMemberEdit.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <table width="100%" class="EditeContentTable">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
        <tr>
            <td class="Label1">
                <%= Resources.lang.ProductionShift%><em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtProductionShift" runat="server" IsRequired='1'></asp:TextBox>
            </td>
        </tr>
       
        <tr>
            <td class="Label1">
                <%= Resources.lang.Sequence%><em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtSequence" runat="server" IsRequired='1'  ClientIDMode="Static" ></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%= Resources.lang.StartTime%><em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtStartTime" runat="server" Width="100px" IsRequired='1' onblur="ValTime(this)" onkeyup="this.value=this.value.replace(/[^:0-9]/g,'')" onafterpaste="this.value=this.value.replace(/[^:0-9]/g,'')"></asp:TextBox>(如:08:30)
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%= Resources.lang.EndTime%><em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtEndTime" runat="server" Width="100px" CssClass="endDate" IsRequired='1' onblur="ValTime(this)" onkeyup="this.value=this.value.replace(/[^:0-9]/g,'')" onafterpaste="this.value=this.value.replace(/[^:0-9]/g,'')" ></asp:TextBox>
                <asp:CheckBox ID="chkIsInterDay" runat="server" ClientIDMode="Static" /> 是否跨天
            </td>
        </tr>
         <tr>
            <td class="Label1">
                <%= Resources.lang.Description%>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtDescription" runat="server"></asp:TextBox>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
    <% if (Request.QueryString["ID"] == null) { %> //从表ID
        var memberId = -1;
    <% } else { %>
        var memberId = <%= Request.QueryString["ID"] %>;
    <% } %>
    <% if (Request.QueryString["PID"] == null) { %>  //主表ID
        var shiftId = -1;
    <% } else { %>
        var shiftId = <%= Request.QueryString["PID"] %>; 
    <% } %>

        $().ready(function () {
            $("#txtSequence").keyup(function () {
                getIntVal(this);
            });
        });

    function Save()
    {
        var errStr = "";
        var txtProductionShift = $("#<%=this.txtProductionShift.ClientID %>").val();
        var txtStartTime = $("#<%=this.txtStartTime.ClientID %>").val();        
        var txtEndTime = $("#<%=this.txtEndTime.ClientID %>").val();  
        var txtSequence = $("#<%=this.txtSequence.ClientID %>").val(); 
        var chkIsInterDay = $("#<%=this.chkIsInterDay.ClientID %>").prop("checked"); 
         
        //add by weixia on  2015/3/2 生产班次名称不能为空
        if(txtProductionShift.length <=0)
        {
          errStr +="<%= Resources.Messages.ProShiftNotEmpty %>";
        }   
        if (!checkTime(txtStartTime) || !checkTime(txtEndTime)){
           errStr+="<%= Resources.Messages.TimeFormatError %>";
        }  
        var txtDescription = $("#<%=this.txtDescription.ClientID %>").val();        
        if (errStr != "") 
        {
            alert(errStr);            
            return false;
        }
        var entity = {};
        entity.MemberId=memberId;
        entity.ShiftId=shiftId;
        entity.ProductionShift=txtProductionShift;
        entity.Description=txtDescription;
        entity.StartTime=txtStartTime;             
        entity.EndTime=txtEndTime;
        entity.Sequence = txtSequence;
        entity.IsInterday = chkIsInterDay;

        var ajax_inserField = SKT.LeanMES.Web.AjaxServices.AjaxShiftMember.EditShiftMember(entity);
        if (ajax_inserField.error !=null) 
        {
            alert(ajax_inserField.error.Message);
            return false;
        }
        else
        {
            alert("<%= Resources.Messages.SaveInSuccess %>");
        }
        parent.window.UpdateList(shiftId);       
    }

     function ValTime(obj) {
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
            if ($(obj).attr("class") == "endDate") {  
                             
               // checkProTime(obj);
            }
        }

        //验证时间段大小
        function checkProTime(obj) {       
            var startTime =  $("#<%=this.txtStartTime.ClientID %>").val().replace(":", "");
            var endTime = $("#<%=this.txtEndTime.ClientID %>").val().replace(":", "");           
            
            if (parseInt(startTime) > parseInt(endTime)) {
                alert("开始时间不能大于结束时间！");
                $(obj).focus();
                return false;
            }
        }
    </script>
</asp:Content>
