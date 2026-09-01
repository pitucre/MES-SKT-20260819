<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="LineEdgeEdit.aspx.cs" Inherits="SKT.LeanMES.Web.MaterialDelivery.LineEdgeEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <table width="100%" class="EditeContentTable">
        <tr>
            <td colspan="3" class="Label">
                <%=Resources.Messages.WithAsteriskIsRequired %>
            </td>
        </tr>
        <tr> 
            <td class="Label1">
                <%= Resources.lang.EdgeName %>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtEdgeName" runat="server" IsRequired='1' CssClass="TextBox" MaxLength="50"></asp:TextBox><em>*</em>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%= Resources.lang.Remark%>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtRemark" runat="server" CssClass="TextArea" TextMode="MultiLine"
                    MaxLength="200"></asp:TextBox>
            </td>
        </tr>
    </table>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label" style="width: 45%; text-align: center; font-weight: bold;">
                <asp:Label ID="Label5" runat="server" Text="选择线别"></asp:Label>
            </td>
            <td class="Label" style="width: 10%; text-align: center;">
            </td>
            <td class="Label" style="width: 45%; text-align: center; font-weight: bold;">
                <asp:Label ID="Label6" runat="server" Text="已选线别"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Field" align="center" style="width: 45%; vertical-align: top;">
                <asp:ListBox ID="lbLeft" runat="server" Width="230" Height="200"></asp:ListBox>
            </td>
            <td class="Field" style="width: 10%; text-align: center; vertical-align: middle;">
                <input type="button" id="btnLeftChoose" runat="server" value=" >> " class="SearchButton"/>
                <br />
                <br />
                <br />
                <br />
                <input type="button" id="btnRightChoose" runat="server" value=" << " class="SearchButton"/>
            </td>
            <td class="Field" align="center" style="width: 45%; vertical-align: top;">
                <asp:ListBox ID="lbRight" runat="server" Width="230" Height="200"></asp:ListBox>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
       var leftListBox = $("#<%=this.lbLeft.ClientID%>");
       var rightListBox= $("#<%=this.lbRight.ClientID%>");
         var Id = <%= Request.QueryString["ID"] == null ? -1 : Convert.ToInt32(Request.QueryString["ID"].ToString())%>
        /*保存数据*/
        function Save() {
            var txtEdgeName = $.trim($("#<%=this.txtEdgeName.ClientID%>").val());
            var txtCreateBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
            var txtModifyBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
            var txtRemark = $.trim($("#<%=this.txtRemark.ClientID%>").val());
            var lineIdStr = "";
           if(rightListBox[0].options.length>0){
                for(var i=0;i<rightListBox[0].options.length;i++){
                    lineIdStr += rightListBox[0].options[i].value+",";
                }
                lineIdStr=lineIdStr.substring(0,lineIdStr.length-1);
           }
            /*表单验证*/
            /*如需表单验证可以此处处理验证 开始*/
            
            
            var entity = {};

            entity.EdgeId = Id
            entity.EdgeName = txtEdgeName;
            entity.LineIdStr = lineIdStr;
            entity.Remark = txtRemark;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEdgeLine.EdgeLineEdit(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert('<%=Resources.Messages.SaveInSuccess%>')
            if ('<%=Request.QueryString["inMenu"] %>' == "true") {
                openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/MaterialDelivery/LineEdgeEdit.aspx?name=LineEdgeEdit&ID=" + parseInt(ajax.value);
                location.href = openWinUrl;
            }
            else {
                parent.window.Refresh();
            }
        }

       
        $(document).ready(function(){

            $("#<%=this.btnLeftChoose.ClientID%>").click(function(){         
            if(leftListBox[0].options.length>0){
                for(var i=0;i<leftListBox[0].options.length;i++){
                    if(leftListBox[0].options[i].selected==true){
                        rightListBox.append("<option value='"+leftListBox[0].options[i].value+"'>"+leftListBox[0].options[i].innerText+"</option>"); 
                        leftListBox[0].options.remove(i);
                    }
                }
            } 
         });

         $("#<%=this.btnRightChoose.ClientID%>").click(function(){
             if(rightListBox[0].options.length>0){
                for(var i=0;i<rightListBox[0].options.length;i++){
                    if(rightListBox[0].options[i].selected==true){
                        leftListBox.append("<option value='"+rightListBox[0].options[i].value+"'>"+rightListBox[0].options[i].innerText+"</option>"); 
                        rightListBox[0].options.remove(i);
                    }
                }
            }
         });
       });
    </script>
</asp:Content>
