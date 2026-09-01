<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="FloorLineInfoEdit.aspx.cs" Inherits="SKT.LeanMES.Web.DIPPackaging.FloorLineInfoEdit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <table width="100%" class="EditeContentTable">
        <tr><td colspan="2" class="Label"><%=Resources.Messages.WithAsteriskIsRequired %></td></tr>
        <tr>
            <td class="Label1">楼层<em>*</em></td>
            <td class="Field1">
                 <asp:TextBox runat="server" ID="txtFName" CssClass="TextBox" Enabled="false" IsRequired="1"></asp:TextBox>
                <input type="button" value="..." class="ButtonBox" onclick="selectFName()" />
                <asp:HiddenField ID="txtFid" runat="server" ClientIDMode="Static" />
            </td>

        </tr>
        <tr>
            <td class="Label1">线别<em>*</em></td>
            <td class="Field1">
                 <asp:TextBox runat="server" ID="txtLineName" CssClass="TextBox" Enabled="false" IsRequired="1"></asp:TextBox>
                <input type="button" value="..." class="ButtonBox" onclick="selectLineName()" />
                <asp:HiddenField ID="txtLineId" runat="server" ClientIDMode="Static" />
            </td>

        </tr>
        <tr>
            <td class="Label1"><%= Resources.lang.Remark %></td>
            <td class="Field1">
                <asp:TextBox ID="txtRemark" runat="server" CssClass="TextBox"  MaxLength="200"></asp:TextBox>
            </td>
        </tr>
    </table>

    <script type="text/javascript">
        var floorLineInfoId = '<%=Request.QueryString["ID"]%>';
        var PageId = 0;

        function selectFName() {
            PageId = 829;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=" + PageId + "&Multiple=false&rnd=" + Math.random(), width: 650, height: 320 });
        }
        function selectLineName() {
            PageId = 21;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=" + PageId + "&Multiple=false&rnd=" + Math.random(), width: 650, height: 320 });
        }

        function getChooseValue(list) {
            if (PageId == 829) {

                $("#<%=this.txtFName.ClientID %>").val(list[0][2]);
                $("#<%=this.txtFid.ClientID %>").val(list[0][0]);
            } else if (PageId == 21) {
                $("#<%=this.txtLineName.ClientID %>").val(list[0][1]);
                $("#<%=this.txtLineId.ClientID %>").val(list[0][0]);
            }
        }

        /*保存数据*/
        function Save() {
            var txtFid = $("#<%=this.txtFid.ClientID%>").val();
            var txtLineId = $("#<%=this.txtLineId.ClientID%>").val();
            var txtCreateBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
            var txtModifyBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
            var txtRemark = $.trim($("#<%=this.txtRemark.ClientID%>").val());


        /*表单验证*/
        /*如需表单验证可以此处处理验证 开始*/


            var entity = {};
            entity.FLId = floorLineInfoId;
        entity.Fid = txtFid;
        entity.LineId = txtLineId;
        entity.Status = 1;
        entity.CreateBy = txtCreateBy;
        entity.ModifyBy = txtModifyBy;
        entity.Remark = txtRemark;

        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxDIPPackaging.FloorLineInfoEdit(entity);
        if (ajax.error != null) {
            alert(ajax.error.Message);
            return false;
        }

        alert('<%=Resources.Messages.SaveInSuccess%>')
         parent.window.Refresh();
    }
    </script>

</asp:Content>
