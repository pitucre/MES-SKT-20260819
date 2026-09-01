<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="StockListChangeOrder.aspx.cs" Inherits="SKT.LeanMES.Web.Plan.StockListChangeOrder" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
     <div class="infoTips">
            <%=Resources.Messages.WithAsteriskIsRequired %></div>
     <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label1">
                 <%=Resources.lang.Line%><em>*</em>
            </td>
            <td class="Field1">
               <asp:TextBox ID="txtLineName" runat="server" CssClass="TextBox" Enabled="false" ClientIDMode="Static"  IsRequired='1' ></asp:TextBox><input
                                type="button" id="btnSelectDefaultOpt" class="ButtonBox" value="..." title="选择线别"
                                onclick="selectLine();" />
                            <asp:HiddenField ID="hdnLineId" runat="server" Value="-1" ClientIDMode="Static" />
            </td>             
        </tr>
         </table>
    <script type="text/javascript">
          var linePlanNo = '<%=Request.QueryString["PlanOrderNo"]%>'; 
         /*选择线别*/
        function selectLine() {           
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=21&Multiple=false&rnd=" + Math.random(), width: 680, height: 300 });
        }

        /*设置从选择窗口选取的值*/
        function getChooseValue(list) {            
                $("#hdnLineId").val(list[0][0]);
                $("#txtLineName").val(list[0][1]);            
        }


        function Save() {
            var lineId = $("#hdnLineId").val();
            if (lineId == -1) {
                alert("请选择线别！");
                return false;
            }

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxStockList.StockListChangeLine(linePlanNo, lineId);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert('<%=Resources.Messages.SaveInSuccess%>')
            parent.window.Refresh();
        }
    </script>
</asp:Content>
