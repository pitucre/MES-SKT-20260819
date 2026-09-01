<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    Inherits="SKT.MES.Web.BasalData.DataFieldEdit" CodeBehind="DataFieldEdit.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label1">
                <%= Resources.lang.Sequence%><em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtSeq" IsRequired='1' IsNumber='1' runat="server" CssClass="TextBox" onkeyup="this.value=this.value.replace(/\D/g,'')"
                    onafterpaste="this.value=this.value.replace(/\D/g,'')"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%= Resources.lang.DataField%><em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtField" runat="server" CssClass="TextBox" IsRequired='1' ReadOnly="true" ></asp:TextBox><input
                    type="button" id="Button1" class="ButtonBox" value="..." title="" onclick="selectDataField();" />
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%= Resources.lang.DataTag%><em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtTag" runat="server" CssClass="TextBox" IsRequired='1' ></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%= Resources.lang.MaskGroup%>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtMask" runat="server" CssClass="TextBox" Enabled="false"></asp:TextBox><input
                    type="button" id="btnMask" class="ButtonBox" value="..." title="" onclick="selectMask();" />
                <asp:HiddenField ID="txtMaskID" runat="server" Value="-1" />
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%= Resources.lang.DataType%>
            </td>
            <td class="Field1">
                <asp:DropDownList ID="ddlType" runat="server">
                    <asp:ListItem Value="" Text=""></asp:ListItem>
                    <asp:ListItem Text="Text" Value="Text"></asp:ListItem>
                    <asp:ListItem Text="Date" Value="Date"></asp:ListItem>
                    <asp:ListItem Text="Number" Value="Number"></asp:ListItem>
                    <asp:ListItem Text="CheckBox" Value="CheckBox"></asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%= Resources.lang.Required%>
            </td>
            <td class="Field1">
                <asp:CheckBox ID="chkRequired" runat="server" />
            </td>
        </tr>
    </table>
    <script type="text/javascript">
    var FID='<%= Request.QueryString["ID"] %>';//从表ID
    var TID = '<%= Request.QueryString["TID"] %>'; //主表ID 

    var chooseItem = 0;//开窗选择内置数据
    var SearchCondition="DicProperty='SYS' and Name='DataField'";

    function Save()
    {
        var errStr = "";
        var txtSeq = $("#<%=this.txtSeq.ClientID %>").val();
        var txtField = $("#<%=this.txtField.ClientID %>").val();
        var txtTag = $("#<%=this.txtTag.ClientID %>").val();

        if (txtField.length <=0 || txtSeq.length<=0 || txtTag.length<=0)
        {
           errStr+= "<%= Resources.Messages.WithAsteriskIsRequiredAlert %>";
        }
        
        var txtMask =$("#<%=this.txtMaskID.ClientID%>").val();
        var ddlType = $("#<%=this.ddlType.ClientID %>").val(); 
        var isRequired=$("#<%=this.chkRequired.ClientID %>").prop("checked");              
        if (errStr != "") 
        {
            alert(errStr);            
            return false;
        }
        var entity = {};
        var action = '<%=Request.QueryString["Action"] %>';
        if (action == "Copy") {
            entity.DataFieldId = -1;
        }
        else {
            entity.DataFieldId = FID;
        }
        entity.DataTypeId = TID;
        entity.Sequence = txtSeq;
        entity.DataField  = txtField;
        entity.DataTag = txtTag;              
        entity.DataType = ddlType;  
        entity.MaskGroup = txtMask;
        entity.Required = isRequired;
        entity.Remark="";     

        var ajax_inserField = SKT.LeanMES.Web.AjaxServices.AjaxDataType.EditDataField(entity);
        if (ajax_inserField.error !=null) 
        {
            alert(ajax_inserField.error.Message);
            return false;
        }
        else
        {
            alert("<%= Resources.Messages.SaveInSuccess %>");
        }       
        parent.window.UpdateList(TID);       
    }

    function selectMask()
    {
       chooseItem=1
       dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=24&Multiple=false&rnd=" + Math.random(), width: 390, height: 250 });
    }

    //得到系统内置的DataField
    function selectDataField()
    {
       chooseItem=2
       dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=3&Multiple=false&PageCondition="+SearchCondition+"&rnd=" + Math.random(), width: 390, height: 250 });
    }

    //获得开窗得到的Mask Group
    function getChooseValue(list)
    {
       if (chooseItem == 1){
          $("#<%=this.txtMask.ClientID %>").val(list[0][1]);
          $("#<%=this.txtMaskID.ClientID %>").val(list[0][0]); 
       }  
       if (chooseItem == 2){
          $("#<%=this.txtField.ClientID %>").val(list[0][1]);  
          $("#<%=this.txtField.ClientID %>").attr("readonly","readonly");        
       }     
    }    
    </script>
</asp:Content>
