<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" Inherits="SKT.LeanMES.Web.SMT.MachineEdit" Title="MachineEdit" Codebehind="MachineEdit.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
<div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
    <table width="100%" class="EditeContentTable">
       <tr>
            <td class="Label1">
                <%= Resources.lang.MachineModelName%>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtModelName" runat="server" CssClass="TextBox" Enabled="false" IsRequired="1" ></asp:TextBox><input
                    type="button" id="btnModel" class="ButtonBox" value="..." title="" onclick="selectModel();" />
                <asp:HiddenField ID="txtModelID" runat="server" Value="-1" /><em>*</em> 
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%= Resources.lang.Line%>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtLineName" runat="server" CssClass="TextBox" Enabled="false"  IsRequired="1" ></asp:TextBox><input
                    type="button" id="BtnLine" class="ButtonBox" value="..." title="" onclick="selectLine();" />
                <asp:HiddenField ID="txtLineID" runat="server" Value="-1" /><em>*</em> 
            </td>
        </tr>
    </table>

    <script type="text/javascript">
    <% if (Request.QueryString["ID"] == null) { %>
        var machineId = -1;
    <% } else { %>
        var machineId = <%= Request.QueryString["ID"] %>;
    <% } %>

     function Save()
    {
        var errStr="";
        var txtModelID =$("#<%= this.txtModelID.ClientID %>").val();
        var txtModelName =$("#<%= this.txtModelName.ClientID %>").val();
        var txtLineName =$("#<%= this.txtLineName.ClientID %>").val();
        var txtLineID =$("#<%= this.txtLineID.ClientID %>").val();


        if(txtModelName.length<=0)
        {
            errStr+= "<%= Resources.Messages.ModelNameEmpty %>";
        }

        if(txtLineName.length<=0)
        {
            errStr+= "<%= Resources.Messages.LineNameEmpty %>";
        }
        if (errStr != "") 
        {
            alert(errStr);
            return false;
        }
                var entity = {};

        entity.ID = machineId;
        entity.MachineSN =txtLineName+txtModelName;
        entity.Description ="";
        entity.MachineModelID =txtModelID;
        entity.ModelName=txtModelName;
        entity.LineID = txtLineID;
        entity.LineName=txtLineName;
        entity.Status = 1;
        entity.Remark = "";

        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxServiceMachine.AddMachine(entity);
        if (ajax.error !=null) 
        {
            alert(ajax.error.Message);
            return false;
        }
         alert('<%=Resources.Messages.SaveInSuccess %>');
       parent.window.UpdateList(entity.MachineSN);
    }

    var flag=0;
    function selectModel()
    {
        flag=1;
       dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=40&Multiple=false&rnd=" + Math.random(), width: 500, height: 300 });
    }

    function getChooseValue(list)
    {
        if(flag==1)
        {
            $("#<%=this.txtModelName.ClientID %>").val(list[0][1]);
            $("#<%=this.txtModelID.ClientID %>").val(list[0][0]);
        }
         if(flag==2)
        {
            $("#<%=this.txtLineName.ClientID %>").val(list[0][1]);
            $("#<%=this.txtLineID.ClientID %>").val(list[0][0]);
        }
    }

    function selectLine()
    {
        flag=2;
        dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=21&Multiple=false&rnd=" + Math.random(), width: 500, height: 300 });
    }
    </script>
</asp:Content>
