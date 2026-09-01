<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="ResourceCalendarCopy.aspx.cs" Inherits="SKT.LeanMES.Web.Plan.ResourceCalendarCopy" %>
<%@ Import Namespace="Resources" %>
<%@ Import Namespace="SKT.LeanMES.Web" %>
  
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">

<style type="text/css">
    .Label2 {
        width: 25%
    }
</style>
    <div class="infoTips">
        提示：只复制当前时间至结束时间之间的日历班次 ，<%= Resources.Messages.WithAsteriskIsRequired %>
    </div>
    <table width="100%" class="EditeContentTable">
        <tr>
             <td class="Label2">
               源资源<em>*</em>
            </td>
            <td class="Field2" colspan="3">
               <asp:Label runat="server" ID="lblResName"></asp:Label>
                <asp:HiddenField runat="server" ID="hdnResourceCopyId"/>
                </td>
        </tr>
        <tr id="trLine">
            <td class="Label2">
                目标资源<em>*</em>
            </td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtResName" runat="server" ReadOnly="true" IsRequired="1" CssClass="TextBox" ClientIDMode="Static"
                    Width="50%">
                </asp:TextBox><input type="button" id="btnSelectItem" runat="server" class="ButtonBox"
                    value="..." title="Select" onclick="openChoosePage(6);" />
                <asp:HiddenField ID="hdnResourceId" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
        </tr>
         <tr>
            <td class="Label2">
                开始时间<em>*</em>
            </td>
            <td class="Field2" colspan="3" >
                <asp:TextBox ID="txtStartTime" runat="server" ReadOnly="true" class="DateTimeBox" IsRequired="1"  ClientIDMode="Static"
                    Width="50%">
                </asp:TextBox>
              
            </td>           
        </tr>
        <tr>
            <td class="Label2">
                结束时间<em>*</em>
            </td>
            <td class="Field2" colspan="3" >
                <asp:TextBox ID="txtEndTime" runat="server" ReadOnly="true" class="DateTimeBox" IsRequired="1"  ClientIDMode="Static"
                    Width="50%">
                </asp:TextBox>
              
            </td>           
        </tr>
     
    </table>
       
    <script type="text/javascript">
        var standardLaborTimeId = '<%=Request.QueryString["ID"]%>';
        var flag = 0;

        $().ready(function () {
        });

        /*保存数据*/
        function Save() {

            var hdnResourceCopyId = $("#<%=this.hdnResourceCopyId.ClientID %>").val();
            var hdnResourceId = $("#<%=this.hdnResourceId.ClientID %>").val(); 
            var txtEndTime=$("#<%=this.txtEndTime.ClientID %>").val();
            var txtStartTime = $("#<%=this.txtStartTime.ClientID %>").val();
            //var curTime = new Date();
           
            if (new Date(Date.parse(txtStartTime)) > new Date(Date.parse(txtEndTime))) {
                alert("结束时间不能小于开始时间");
                return false;
            }

            var ajax = SKT.LeanMES.Web.Plan.ResourceCalendarCopy.CopyResourceCalendar(hdnResourceCopyId, hdnResourceId, txtStartTime, txtEndTime);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert('<%=Resources.Messages.SaveInSuccess%>');

        }
       
        function openChoosePage(flags) {
          
            var condition = " ResourceId!=" + $("#<%=this.hdnResourceCopyId.ClientID %>").val();
            flag = flags;
            dialog({
                title: "<%= Common.ChooseWindow %>",
                src: "<%= WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=" +
                flags +
                "&Multiple=false&SearchCondition=" +
                condition +
                "&rnd=" +
                Math.random(),
                width: 400,
                height: 300
            });
        }

        function getChooseValue(list) {
         if (flag == 6) {
                $("#<%=this.txtResName.ClientID %>").val(list[0][1]);
                 $("#<%=this.hdnResourceId.ClientID %>").val(list[0][0]);
            }
        }

    
    </script>
</asp:Content>
