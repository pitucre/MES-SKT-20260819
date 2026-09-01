<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="ESOPLineEdit.aspx.cs" Inherits="SKT.LeanMES.Web.ESOP.ESOPLineEdit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
<div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired%></div>
    <table width="100%" class="EditeContentTable">
 
        <tr>
            <td class="Label1">
                <%=Resources.lang.OrderNo %><em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtOrderNo" runat="server" CssClass="TextBox" ReadOnly="true" ClientIDMode="Static"
                    IsRequired='1'></asp:TextBox><input type="button" runat="server" id="btnSelectOrder"
                        class="ButtonBox" value="..." title="选择工单" onclick="selectOrder();" />
                <asp:HiddenField ID="hdnProdOrderId" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%=Resources.lang.Line%><em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtLineName" runat="server" CssClass="TextBox" ReadOnly="true" ClientIDMode="Static"
                    IsRequired='1'></asp:TextBox><input type="button" id="btnSelectDefaultOpt" class="ButtonBox"
                        value="..." title="选择线别" onclick="selectLine();" />
                <asp:HiddenField ID="hdnLineId" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
        </tr>
        
        <tr>
            <td class="Label2">
                默认ESOP
            </td>
            <td class="Field2">
                <input type="checkbox" id="chkIsDefault" runat="server" ClientIDMode="Static" />&nbsp;<span>默认</span>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        var flag = -1;
        var esopLineId = '<%=Request.QueryString["ID"] %>';

     
        /*
        *选择工序
        */
        function selectOrder() {
            flag = 1;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=44&Multiple=false&rnd=" + Math.random(), width: 680, height: 300 });
        }

        /*
        *选择线别
        */
        function selectLine() {
            flag = 2;
            var searchCondition = "";
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=21&Multiple=false" + searchCondition + "&rnd=" + Math.random(), width: 680, height: 300 });
        }

        /*
        *获取选择窗值
        */
        function getChooseValue(list) {
            if (flag == 1) {
                //获取用户信息
                $("#txtOrderNo").val(list[0][1]);
                $("#hdnProdOrderId").val(list[0][0]);
            }
            else if (flag == 2) {
                //获取线别信息
                $("#txtLineName").val(list[0][1]);
                $("#hdnLineId").val(list[0][0]);
            }
           
        }

        /*
        * 保存用户与工序关联信息
        */
        function Save() {
            var prodOrderId = $("#hdnProdOrderId").val();
            var lineId = $("#hdnLineId").val();           
            var isDeafult = $("#chkIsDefault").is(":checked");

            var entity = {};
            entity.ESOPLineId = esopLineId;
            entity.ProdOrderId = prodOrderId;
            entity.LineId = lineId;
            entity.IsDefault = isDeafult;

            /*Save Event*/
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEsop.EsopLineEdit(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert("<%=Resources.Messages.SaveInSuccess %>");

            window.parent.Refresh($("#txtUserName").val());
        }
    </script>
</asp:Content>
