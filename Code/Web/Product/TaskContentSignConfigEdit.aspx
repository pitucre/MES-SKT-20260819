<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditHeadMaster.master"
    AutoEventWireup="true" CodeBehind="TaskContentSignConfigEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Product.TaskContentSignConfigEdit" %>

<%@ MasterType VirtualPath="~/Masters/EditHeadMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">
                产品类型
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtName" runat="server" CssClass="TextBox" IsRequired='1' MaxLength="50"></asp:TextBox>
            </td>
            <td class="Label2">
                产品编码
            </td>
            <td class="Field2">
                <asp:TextBox ID="TextBox1" runat="server" CssClass="TextBox" IsRequired='1' MaxLength="50"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                产品名称
            </td>
            <td class="Field2">
                <asp:TextBox ID="TextBox2" runat="server" CssClass="TextBox" IsRequired='1' MaxLength="50"></asp:TextBox>
            </td>
            <td class="Label2">
                版本
            </td>
            <td class="Field2">
                <asp:TextBox ID="TextBox3" runat="server" CssClass="TextBox" IsRequired='1' MaxLength="50"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                批次
            </td>
            <td class="Field2">
                <asp:TextBox ID="TextBox4" runat="server" CssClass="TextBox" IsRequired='1' MaxLength="50"></asp:TextBox>
            </td>
            <td class="Label2">
                产品状态
            </td>
            <td class="Field2">
                <asp:TextBox ID="TextBox5" runat="server" CssClass="TextBox" IsRequired='1' MaxLength="50"></asp:TextBox>
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

    loadfloatButtons("demo1");

    <% if (Request.QueryString["ID"] == null) { %>
        var TID = -1;
    <% } else { %>       
        var TID = <%= Request.QueryString["ID"] %>;
    <% } %>    
    
     isMultiple = false;
     var hdnOperate = $("#hdnOperate");
     var hdnIdString = $("#hdnIdString");
     var hdnTIDString = $("#hdnTIDString"); 
     if (TID==-1)
     {
         TID=<%= Convert.ToInt32(Request.Form["hdnTIDString"]) %>;
         if (TID==0)
         {
            TID=-1;
         }
     }
     hdnTIDString.val(TID); 
     var gridview = $("#<%=this.GridView1.ClientID %>");  
     //保存数据类型
     function Save() {
         var errStr = "";
         var txtName = $("#<%=this.txtName.ClientID %>").val();
         var ddlCat =""; //找不到控件

         if (ddlCat.length <= 0) {
             errStr += "<%= Resources.Messages.WithAsteriskIsRequiredAlert %>";
             alert(errStr);
             return false;
         }
         var txtDesc = "";//找不到控件
         var txtActivity ="";   //找不到控件   
         if (errStr != "") {
             alert(errStr);
             return false;
         }
         var entity = {};
         entity.DataTypeId = TID;
         entity.DataTypeName = txtName;
         entity.ValidationActivity = txtActivity;
         entity.Description = txtDesc;
         entity.Category = ddlCat;
         entity.Remark = "";

         var ajax_inserDataType = SKT.LeanMES.Web.AjaxServices.AjaxDataType.EditDataType(entity);
         if (ajax_inserDataType.error != null) {
             alert(ajax_inserDataType.error.Message);
             return false;
         }
         else {
             //document.getElementById("ddlCat").disabled=false;   
             //document.getElementById("txtName").disabled=false; 
             alert("<%= Resources.Messages.SaveInSuccess %>");
         }
         window.parent.UpdateList(txtName);                        
     }

     //新增数据字段
     function Add(){        
         if (hdnTIDString.val()==-1)
         {
            alert("<%= Resources.Messages.MasterDataSaveFirst %>");
            return;
         }
         else
         {
            dialog({ title: "<%= Resources.Pages.DataFieldAdd %>", src: "DataFieldEdit.aspx?name=DataFieldAdd&ID=-1&TID="+hdnTIDString.val(), width: 500, height: 320, resizeable: true });
         }
     }
     //编辑
     function Edit() {
         var idStr = getOneRecordId();
         if (idStr == "") return;
            dialog({ title: "<%= Resources.Pages.DataFieldEdit %>", src: "DataFieldEdit.aspx?name=DataFieldEdit&ID=" + idStr+"&TID="+hdnTIDString.val(), width: 500, height:320, resizeable: true });
     }

     //删除
     function Delete() {
         var idStr = getDeletingRecordIdString();
         if (idStr == "") return false;
         hdnOperate.val("delete");
         hdnIdString.val(idStr);
         document.forms[0].submit();
     }

     function UpdateList(tID)
     {
         hdnTIDString.val(tID);
         document.forms[0].submit();
     }
     
    </script>
</asp:Content>
