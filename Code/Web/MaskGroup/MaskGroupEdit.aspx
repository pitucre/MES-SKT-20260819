<%@ Page Language="C#" MasterPageFile="~/Masters/EditHeadMaster.master" AutoEventWireup="true"
    Inherits="SKT.LeanMES.Web.BasalData.MaskGroupEdit" CodeBehind="MaskGroupEdit.aspx.cs" %>

<%@ MasterType VirtualPath="~/Masters/EditHeadMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">
                <%=Resources.lang.MaskGroup %>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtName" IsRequired='1' runat="server" CssClass="TextBox"></asp:TextBox><em>*</em>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%=Resources.lang.Description %>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtDesc" runat="server" CssClass="TextArea" TextMode="MultiLine"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <div class="ListTableTitle">
        <%=Resources.lang.MaskMemberList %><span id="demo1"></span></div>
    <asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <asp:BoundField DataField="Sequence" HeaderText="<%$ Resources:lang,Sequence %>"
                HeaderStyle-Width="55px" />
            <asp:BoundField DataField="MaskType" HeaderText="<%$ Resources:lang,MaskType %>"
                HeaderStyle-Width="60px" />
            <asp:BoundField DataField="DisplayMask" HeaderText="<%$ Resources:lang,DisplayMask %>"
                />
            <asp:BoundField DataField="MinLength" HeaderText="<%$ Resources:lang,MinLength %>"
                HeaderStyle-Width="60px" Visible="false" />
            <asp:BoundField DataField="MaxLength" HeaderText="<%$ Resources:lang,MaxLength %>"
                HeaderStyle-Width="60px" Visible="false" />
            <asp:BoundField DataField="ValidFrom" HeaderText="<%$ Resources:lang,ValidFrom %>"
                DataFormatString="{0:d}" HtmlEncode="false" HeaderStyle-Width="95px" />
            <asp:BoundField DataField="ValidTo" HeaderText="<%$ Resources:lang,ValidTo %>" DataFormatString="{0:d}"
                HtmlEncode="false" HeaderStyle-Width="95px" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.MaskGroup.BLL.MaskGroupMember"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <input type="hidden" id="hdnTIDString" name="hdnTIDString" value="" />
    <asp:Label ID="lblTID" runat="server" Visible="false"></asp:Label>
    <script language="javascript" type="text/javascript">
        loadfloatButtons("demo1");
        var TID = '<%= Request.QueryString["ID"] %>';
        isMultiple = true;
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");
        var hdnTIDString = $("#hdnTIDString");
        if (TID == -1) {
            TID = '<%= Convert.ToInt32(Request.Form["hdnTIDString"]) %>';
            if (TID == 0) {
                TID = -1;
            }
        }
        hdnTIDString.val(TID);
        var gridview = $("#<%=this.GridView1.ClientID %>");

        //保存数据类型
        function Save() {
            var errStr = "";
            var txtName = $("#<%=this.txtName.ClientID %>").val();

            var txtDesc = $("#<%=this.txtDesc.ClientID %>").val();
            if (errStr != "") {
                alert(errStr);
                return false;
            }
            var entity = {};
            var action = '<%=Request.QueryString["Action"] %>';
            var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
            if (action == "Copy") {
                entity.MaskID = -2;
            }
            else {
                entity.MaskID = TID;
                action = "";
            }
            var oldId = TID;
            entity.MaskGroup = txtName;
            entity.Description = txtDesc;
            entity.Remark = "";
            entity.CreateBy = userName;
            entity.ModifyBy = userName;

            var ajax_inserMaskGroup = SKT.LeanMES.Web.AjaxServices.AjaxMaskGroup.EditMaskGroup(entity, action, oldId);
            if (ajax_inserMaskGroup.error != null) {
                alert(ajax_inserMaskGroup.error.Message);
                return false;
            }

            //            if (!confirm("<%= Resources.Messages.SaveInSuccess %>\n需要关闭窗口吗？")) {
            //                location.href = "MaskGroupEdit.aspx?name=MaskGroupEdit&ID=" + ajax_inserMaskGroup.value;
            //            }
            //            else {
            window.parent.UpdateList(txtName);
            //            }
        }

        //新增数据字段
        function Add() {
            if (hdnTIDString.val() == -1) {
                alert("<%= Resources.Messages.MasterDataSaveFirst %>");
                return;
            }
            else {
                dialog({ title: "<%= Resources.Pages.MaskGroupAdd %>", src: "MaskMemberEdit.aspx?name=MaskMemberAdd&ID=-1&TID=" + hdnTIDString.val(), width: 475, height: 325, resizeable: true });
            }
        }
        //编辑
        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return;
            dialog({ title: "<%= Resources.Pages.MaskGroupEdit %>", src: "MaskMemberEdit.aspx?name=MaskMemberEdit&ID=" + idStr + "&TID=" + hdnTIDString.val(), width: 475, height: 325, resizeable: true });
        }

        //删除
        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }

        function UpdateList(mID) {
            hdnTIDString.val(mID);
            document.forms[0].submit();
        }

        function Copy() {
            var idStr = getOneRecordId();
            if (idStr == "") return;
            dialog({ title: "复制掩码元素", src: "MaskMemberEdit.aspx?name=MaskMemberEdit&ID=" + idStr + "&TID=" + hdnTIDString.val() + "&Action=Copy", width: 475, height: 365, resizeable: true });
        }
    </script>
</asp:Content>
