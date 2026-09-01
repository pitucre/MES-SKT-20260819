<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="WorkTimeSetEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Plan.WorkTimeSetEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
<style type="text/css">
    .Label2 {
        width: 25%
    }
</style>
    <div class="infoTips">
        <%= Resources.Messages.WithAsteriskIsRequired %>
    </div>
    <table width="100%" class="EditeContentTable">
         <tr>
             <td class="Label2">
                项目名称<em>*</em>
            </td>
            <td class="Field2" colspan="3">
                 <asp:TextBox ID="txtName" runat="server" CssClass="TextBox"  ClientIDMode="Static" ></asp:TextBox>
                              
                </td>
        </tr>
        <tr>
             <td class="Label2">
                线别<em>*</em>
            </td>
            <td class="Field2" colspan="3">
                 <asp:TextBox ID="txtLineName" runat="server" CssClass="TextBox" Enabled="false" ClientIDMode="Static" ></asp:TextBox><input
                                type="button" id="btnSelectDefaultOpt" class="ButtonBox" value="..." title="选择线别"
                                onclick="selectLine();" />
                            <asp:HiddenField ID="hdnLineId" runat="server" Value="-1" ClientIDMode="Static" />
                </td>
        </tr>
       <%-- <tr id="trLine">
            <td class="Label2">
                资源<em>*</em>
            </td>
            <td class="Field2" colspan="3">
               <span id="spanRes" style="display: none;"> 
                            <asp:TextBox ID="txtResName" runat="server" CssClass="TextBox" ClientIDMode="Static" 
                                IsRequired='1'></asp:TextBox><input
                                    type="button" id="btnRes" class="ButtonBox" value="..." title="选择资源"
                                    onclick="selectRes();" />
                            <asp:HiddenField ID="hdnResourceId" runat="server" Value="-1" ClientIDMode="Static" />
                             </span>
            </td>
        </tr>--%>
        <tr>
            <td class="Label2">
                设置时间<em>*</em>
            </td>
            <td class="Field2" colspan="3" >
                <asp:TextBox ID="txtSetDate" runat="server" ReadOnly="true" CssClass="DateTimeBox" IsRequired="1"  ClientIDMode="Static"
                   >
                </asp:TextBox>
            </td>    
           
        </tr>
     
        <tr>
            <td class="Label2">
               时长(分钟)<em>*</em>
            </td>
            <td class="Field2" >
                <asp:TextBox ID="txtTimes" IsRequired="1"  runat="server" IsNumber='1' ClientIDMode="Static" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
        <%--<tr>
            <td class="Label2">
                <%= Resources.lang.Remark %>
            </td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtRemark" runat="server" TextMode="MultiLine" CssClass="TextArea"
                    MaxLength="300" Width="90%"></asp:TextBox>
            </td>
        </tr>--%>
    </table>
    <script type="text/javascript">
        var lctId = '<%=Request.QueryString["ID"]%>';
        var flag = 0;

        $().ready(function () {
           if (lctId > 0) {
               $("#spanRes").show();
           }
        });

       /*选择线别(线别)*/
        function selectLine() {
            flag = 1;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=21&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }



         /*选择资源*/
        function selectRes() {
            flag = 4;
            var searchCondition = " LineId="+$("#<%=this.hdnLineId.ClientID%>").val();
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=6&Multiple=false&searchCondition="+searchCondition+"&rnd=" + Math.random(), width: 600, height: 300 });
        }

        /*设置从选择窗口选取的值*/
        function getChooseValue(list) {
            if (flag == 1) {
                $("#<%=this.hdnLineId.ClientID%>").val(list[0][0]);
                $("#<%=this.txtLineName.ClientID%>").val(list[0][1]);
               <%-- $("#<%=this.hdnResourceId.ClientID%>").val(-1);
                $("#<%=this.txtResName.ClientID%>").val("");--%>
                $("#spanRes").show();
            }else if (flag == 4) {
              <%--  $("#<%=this.hdnResourceId.ClientID%>").val(list[0][0]);
                $("#<%=this.txtResName.ClientID%>").val(list[0][1]);--%>

            }
            flag = -1;
        }

        /*保存数据*/
        function Save() {
            var hdnLineId = $("#<%=this.hdnLineId.ClientID%>").val();
       <%--     var hdnResourceId = $("#<%=this.hdnResourceId.ClientID%>").val();--%>
            var hdnResourceId = -1;
            var txtName = $.trim($("#<%=this.txtName.ClientID%>").val());
            var txtSetDate = $.trim($("#<%=this.txtSetDate.ClientID%>").val());
            var txtTimes = $("#<%=this.txtTimes.ClientID%>").val();
          
          <%--  var txtRemark = $.trim($("#<%=this.txtRemark.ClientID%>").val());--%>
           

            /*表单验证*/
            /*如需表单验证可以此处处理验证 开始*/


            var entity = {};

            entity.WtId = lctId;
            entity.LineId = hdnLineId;
            entity.ResourceId = hdnResourceId;
            entity.SetDate = txtSetDate;
            entity.Name = txtName;
            entity.Times = txtTimes;
            //entity.Remark = txtRemark;
        
            var ajax = SKT.LeanMES.Web.Plan.WorkTimeSetEdit.Edit(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert('<%=Resources.Messages.SaveInSuccess%>');
            parent.window.Refresh();
            
        }
       
    </script>
</asp:Content>
