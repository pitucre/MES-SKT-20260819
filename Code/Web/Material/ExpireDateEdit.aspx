<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/EditMaster.master" CodeBehind="ExpireDateEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Material.ExpireDateEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" Runat="Server" >
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
            <tr id="mytr">
                <td class="Label1">
                   重检单号：
                </td>
                <td class="Field1">
                    <asp:Label runat="server" ID="lbCJNo">0</asp:Label>
                </td>
             </tr>
            <tr>
                <td class="Label1">
                   检验结果：
                </td>
                <td class="Field1">
                    <select id="ddlstatues">
                        <option selected="selected" value="1">合格</option>
                        <option value="0">不合格</option>
                    </select>
                </td>
             </tr>
            <tr>
                <td class="Label1">
                   备注：
                </td>
                <td class="Field1">
                    <textarea id="txtRemark" rows="2" cols="20" class="TextArea" style="height:50px;width:97%;"></textarea>
                </td>
             </tr>
            <tr>
                <td class="Label1">
                </td>
                <td class="Field1">
                    <input id="saveBtn" type="button" value="保存"  onclick="Save()"/>
                </td>
              </tr>
    </table>
    <script type="text/javascript">
        var username = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
        var myGRNStr = "<%=GRNStr %>";
        var myType = "<%=type %>";

        $(function () {
            if (myType == "update") {
                $("#mytr").hide();
            }
            else {
                $("#mytr").show();
            }
        });
        
        function Save() {
        	if (myType == "insert") {
				if ($('#<%=lbCJNo.ClientID%>').html() == "0") {
        			alert("没有生成重检单号,请设置重检单号生成规则");
        			return;
        		}
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxReinspection.Edit($('#<%=lbCJNo.ClientID%>').html(), myGRNStr, $("#ddlstatues").val(), $("#txtRemark").val(), username);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                alert("生成重检单成功");
                parent.window.refresh();
            }
            else if (myType == "update")
            {
                var myajax = SKT.LeanMES.Web.AjaxServices.AjaxReinspection.UpdateCheckResult(myGRNStr, $("#ddlstatues").val(), $("#txtRemark").val(), username);
                if (myajax.error != null) {
                    alert(myajax.error.Message);
                    return false;
                }
                alert("结果变更成功！");
                parent.window.refresh();
            }
        }
        
    </script>
</asp:Content>
