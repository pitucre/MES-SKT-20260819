<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="LineChangingTimeEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Plan.LineChangingTimeEdit" %>
<%@ Import Namespace="Resources" %>
<%@ Import Namespace="SKT.LeanMES.Web" %>
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
                线别<em>*</em>
            </td>
            <td class="Field2" >
                 <asp:TextBox ID="txtLineName" runat="server" CssClass="TextBox" Enabled="false" ClientIDMode="Static" ></asp:TextBox><input
                                type="button" id="btnSelectDefaultOpt" class="ButtonBox" value="..." title="选择线别"
                                onclick="selectLine();" />
                            <asp:HiddenField ID="hdnLineId" runat="server" Value="-1" ClientIDMode="Static" />
                </td>
        </tr>
        <tr id="trLine">
            <td class="Label2">
                资源名称<em>*</em>
            </td>
            <td class="Field2" >
               <span id="spanRes" style="display: none;"> 
                            <asp:TextBox ID="txtResName" runat="server" CssClass="TextBox" ClientIDMode="Static" 
                                IsRequired='1'></asp:TextBox><input
                                    type="button" id="btnRes" class="ButtonBox" value="..." title="选择资源"
                                    onclick="selectRes();" />
                            <asp:HiddenField ID="hdnResourceId" runat="server" Value="-1" ClientIDMode="Static" />
                             </span>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                产品A编码<em>*</em>
            </td>
            <td class="Field2" >
                <asp:TextBox ID="txtItemOneCode" runat="server" ReadOnly="true" CssClass="TextBox" IsRequired="1"  ClientIDMode="Static"
                   >
                </asp:TextBox><input type="button" id="Button1" runat="server" class="ButtonBox"
                    value="..." title="Select" onclick="selectOneItem();" />
                <asp:HiddenField ID="hdnItemOneId" runat="server" Value="-1" ClientIDMode="Static" />
            </td>    
            
        </tr>
        <tr>
             <td class="Label2">
                产品B编码<em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtItemTwoCode" runat="server" ReadOnly="true" CssClass="TextBox" IsRequired="1"  ClientIDMode="Static"
                    >
                </asp:TextBox><input type="button" id="Button2" runat="server" class="ButtonBox"
                    value="..." title="Select" onclick="selectTwoItem();" />
                <asp:HiddenField ID="hdnItemTwoId" runat="server" Value="-1" ClientIDMode="Static" />
            </td>       
        </tr>
        <tr>
            <td class="Label2">
               换线时间(小时)<em>*</em>
            </td>
            <td class="Field2" >
                <asp:TextBox ID="txtLineChangingTime" IsRequired="1"  runat="server" ClientIDMode="Static" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.Remark %>
            </td>
            <td class="Field2" >
                <asp:TextBox ID="txtRemark" runat="server" TextMode="MultiLine" CssClass="TextArea"
                    MaxLength="300" Width="90%"></asp:TextBox>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        var lctId = '<%=Request.QueryString["ID"]%>';
        var flag = 0;

        $().ready(function () {
           if (lctId > 0) {
               $("#spanRes").show();
           }

        //只能输入数字，最多保留两位小数
        $("#txtLineChangingTime").keyup(function(){
      
              $(this).val(  $(this).val().replace(/[^\d.]/g,"")); //清除"数字"和"."以外的字符
              $(this).val(  $(this).val().replace(/^\./g,""));
              $(this).val(  $(this).val().replace(/\.{2,}/g,"."));
              $(this).val(  $(this).val().replace(".","$#$").replace(/\./g,"").replace("$#$","."));
              $(this).val(  $(this).val().replace(/^(\-)*(\d+)\.(\d\d).*$/,'$1$2.$3'));

            });
        });


        var contion = "";
       /*选择线别(线别)*/
        function selectLine() {
            flag = 1;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=21&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }
        
         /*选择产品*/
        function selectOneItem() {
            flag = 2;
            if ($("#<%=this.txtItemTwoCode.ClientID %>").val() != "") {
                 contion = " ItemCode !='" + $("#<%=this.txtItemTwoCode.ClientID %>").val()+"'";
            }
           
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=1&Multiple=false&searchCondition="+contion+"&rnd=" + Math.random(), width: 600, height: 300 });
        }

           /*选择产品*/
        function selectTwoItem() {
            flag = 3;
           if ($("#<%=this.txtItemOneCode.ClientID %>").val() != "") {
                 contion = " ItemCode !='" + $("#<%=this.txtItemOneCode.ClientID %>").val()+"'";
            }
         
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=1&Multiple=false&searchCondition="+contion+"&rnd=" + Math.random(), width: 600, height: 300 });
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
                $("#<%=this.hdnResourceId.ClientID%>").val(-1);
                $("#<%=this.txtResName.ClientID%>").val("");
                $("#spanRes").show();
            }else if (flag == 2) {
               
                $("#<%=this.hdnItemOneId.ClientID%>").val(list[0][0]);
                $("#<%=this.txtItemOneCode.ClientID%>").val(list[0][2]);
              
            } else if(flag==3) {
                $("#<%=this.hdnItemTwoId.ClientID%>").val(list[0][0]);
                $("#<%=this.txtItemTwoCode.ClientID%>").val(list[0][2]);
            }else if (flag == 4) {
                $("#<%=this.hdnResourceId.ClientID%>").val(list[0][0]);
                $("#<%=this.txtResName.ClientID%>").val(list[0][1]);

            }
            flag = -1;
        }

        /*保存数据*/
        function Save() {
            var hdnLineId = $("#<%=this.hdnLineId.ClientID%>").val();
            var hdnResourceId = $("#<%=this.hdnResourceId.ClientID%>").val();
            var hdnItemOneId = $.trim($("#<%=this.hdnItemOneId.ClientID%>").val());
            var hdnItemTwoId = $.trim($("#<%=this.hdnItemTwoId.ClientID%>").val());
            var txtLineChangingTime = $("#<%=this.txtLineChangingTime.ClientID%>").val();
          
            var txtRemark = $.trim($("#<%=this.txtRemark.ClientID%>").val());
           

            /*表单验证*/
            /*如需表单验证可以此处处理验证 开始*/


            var entity = {};

            entity.LctId = lctId;
            entity.LineId = hdnLineId;
            entity.ResourceId = hdnResourceId;
            entity.ItemOneId = hdnItemOneId;
            entity.ItemTwoId = hdnItemTwoId;
            entity.LineChangingTime = toDecimal2(txtLineChangingTime);
            entity.Remark = txtRemark;
        
            var ajax = SKT.LeanMES.Web.Plan.LineChangingTimeEdit.Edit(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert('<%=Resources.Messages.SaveInSuccess%>');
            parent.window.Refresh();
            
        }

          function toDecimal2(x) {   
              var f = parseFloat(x);   
              if (isNaN(f)) {   
                return false;   
              }   
              var f = Math.round(x*100)/100;   
              var s = f.toString();   
              var rs = s.indexOf('.');   
              if (rs < 0) {   
                rs = s.length;   
                s += '.';   
              }   
              while (s.length <= rs + 2) {   
                s += '0';   
              }   
              return s;   
        }   
       
    </script>
</asp:Content>
