<%@ Page Language="C#" MasterPageFile="~/Masters/EditHeadMaster.master" AutoEventWireup="true"
    Inherits="SKT.LeanMES.Web.BasalData.DataTypeEdit" CodeBehind="DataTypeEdit.aspx.cs" %>

<%@ MasterType VirtualPath="~/Masters/EditHeadMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="infoTips">
        <%= Resources.Messages.WithAsteriskIsRequired %></div>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">
                <%=Resources.lang.DTName%><em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtName" runat="server" IsRequired='1' CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label2">
                <%=Resources.lang.DTCategory%><em>*</em>
            </td>
            <td class="Field2">
                <asp:DropDownList ID="ddlCat" runat="server" IsRequired='1'>
                    <asp:ListItem Value="">=请选择=</asp:ListItem>
                    <asp:ListItem Value="Assembly">Assembly</asp:ListItem>
                    <asp:ListItem Value="NC">NC</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%=Resources.lang.ValidationActivity %>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtActivity" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label2">
                <%=Resources.lang.Description %>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtDesc" runat="server" CssClass="TextArea" TextMode="MultiLine"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <div class="ListTableTitle">
        <%=Resources.lang.DataFieldList%><span id="demo1"></span></div>
    <asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server" DataSourceID="ObjectDataSource1">
        <Columns>
            <asp:BoundField DataField="Sequence" HeaderText="<%$ Resources:lang,Sequence %>" />
            <asp:BoundField DataField="DataField" HeaderText="<%$ Resources:lang,DataField %>" />
            <asp:BoundField DataField="DataTag" HeaderText="<%$ Resources:lang,DataTag %>" />
            <asp:BoundField DataField="MaskGroupData" HeaderText="<%$ Resources:lang,MaskGroup %>" />
            <asp:BoundField DataField="DataType" HeaderText="<%$ Resources:lang,DataFormat %>" />
            <asp:BoundField DataField="Required" HeaderText="<%$ Resources:lang,Required %>" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.DataType.BLL.DataField"
        SelectMethod="GetAllByTID" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <input type="hidden" id="hdnTIDString" name="hdnTIDString" value="" />
    <asp:Label ID="lblTID" runat="server" Visible="false"></asp:Label>
    <script language="javascript" type="text/javascript">
        var isEdit = false;

        loadfloatButtons("demo1");
        var TID = '<%= Request.QueryString["ID"] %>';
        isMultiple = false;
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
            var ddlCat = $("#<%=this.ddlCat.ClientID %>").val();


            var txtDesc = $("#<%=this.txtDesc.ClientID %>").val();
            var txtActivity = $("#<%=this.txtActivity.ClientID %>").val();
            var userName = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>';
            var entity = {};
            var action = '<%=Request.QueryString["Action"] %>';
            if (action == "Copy") {
                entity.DataTypeId = -1;
            }
            else {
                entity.DataTypeId = TID;
                action = "";
            }

            entity.DataTypeName = txtName;
            entity.ValidationActivity = txtActivity;
            entity.Description = txtDesc;
            entity.Category = ddlCat;
            entity.Remark = "";
            entity.CreateBy = userName;
            entity.ModifyBy = userName;

            //如果是新增模式
            if (TID > 0 || TID < -1) {
                isEdit = true;
            } else {
                isEdit = false;
            }

            var ajax_inserDataType = SKT.LeanMES.Web.AjaxServices.AjaxDataType.EditDataType(entity,action,TID);
            if (ajax_inserDataType.error != null) {
                alert(ajax_inserDataType.error.Message);
                return false;
            }
            else {
                TID = ajax_inserDataType.value;
                hdnTIDString.val(TID);
                alert("<%= Resources.Messages.SaveInSuccess %>");
            }

            //如果是新增模式，不关闭
            if (isEdit) {
                window.parent.UpdateList(txtName);
            }
        }

        //新增数据字段
        function Add() {
            if (hdnTIDString.val() == -1) {
                alert("<%= Resources.Messages.MasterDataSaveFirst %>");
                return;
            }
            else {
                dialog({ title: "<%= Resources.Pages.DataFieldAdd %>", src: "DataFieldEdit.aspx?name=DataFieldAdd&ID=-1&TID=" + hdnTIDString.val(), width: 500, height: 320, resizeable: true });
            }
        }
        //编辑
        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return;
            dialog({ title: "<%= Resources.Pages.DataFieldEdit %>", src: "DataFieldEdit.aspx?name=DataFieldEdit&ID=" + idStr + "&TID=" + hdnTIDString.val(), width: 500, height: 320, resizeable: true });
        }

        //删除
        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }

        function UpdateList(txtName) {
            $("#<%=this.txtName.ClientID %>").val(txtName);
            document.forms[0].submit();
        }

        function Copy() {
            var idStr = getOneRecordId();
            if (idStr == "") return;
            dialog({ title: "<%= Resources.Pages.DataFieldEdit %>", src: "DataFieldEdit.aspx?name=DataFieldEdit&ID=" + idStr + "&TID=" + hdnTIDString.val() + "&Action=Copy&rnd=" + Math.random(), width: 500, height: 320, resizeable: true });
        }
    </script>
</asp:Content>
