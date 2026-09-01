<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="MouldBomComponentEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.MouldBomComponentEdit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">
                构件名称<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtMouldTypeName" runat="server" CssClass="TextBox" Enabled="false" IsRequired='1' ClientIDMode="Static"></asp:TextBox><input
                    type="button" id="btnSelectItem" class="ButtonBox" value="..." title="选择"
                    onclick="selectItem(710);" />
             
                <asp:HiddenField ID="hdnMouldTypeId" runat="server" Value="-1" />
            </td>
        </tr>
 
       <%-- <tr>
            <td class="Label1">
               构件编码<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtComponentCode" runat="server" CssClass="TextBox" IsRequired='1'  ClientIDMode="Static" ></asp:TextBox>
              
            </td>
        </tr>--%>
         <tr>
            <td class="Label1">
               可替换构件
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtReplaceComponent" runat="server" CssClass="TextBox" Enabled="false"  ClientIDMode="Static"></asp:TextBox><input
                    type="button" id="btnSelectItem1" class="ButtonBox" value="..." title="选择"
                    onclick="select2();" />
             
              
            </td>
        </tr>
        <tr>
            <td class="Label1">
                构件描述
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtDescribe" runat="server" CssClass="TextBox" MaxLength='200' ClientIDMode="Static"  Width="90%"></asp:TextBox>
            </td>
        </tr>
       
         
    </table>
    <script type="text/javascript">        
        var bomChildId = '<%=Request.QueryString["ID"] %>';
        var bomId = '<%=Request.QueryString["BOMID"] %>';               
        var bomName = '<%=Request.QueryString["BomName"] %>';
        var chooseFlag = 0;

        function selectItem(i) {
            chooseFlag = i;
            var condition = " ComponentName  like'" + bomName + "%'";
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=" + i.toString() + "&SearchCondition=" + condition + "&Multiple=false&rnd=" + Math.random(), width: 550, height: 280 });
        }

        function select2() {
            /*var txtcomponentName = $("#<%=this.txtMouldTypeName.ClientID %>").val();
            if (txtcomponentName == "") {
                alert("请选择构件名称");
                return;
            }
            var condition = " ComponentName!='" + txtcomponentName + "' and ComponentName  like'" + bomName + "%'";*/

            var condition = "";
            chooseFlag = 10;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=710&SearchCondition=" + condition + "&Multiple=true&rnd=" + Math.random(), width: 400, height: 280 });
        }
        

        function getChooseValue(list) {            
            if (chooseFlag == 1) {
                $("#<%=this.txtMouldTypeName.ClientID %>").val(list[0][1]);
                $("#<%=this.hdnMouldTypeId.ClientID %>").val(list[0][0]);

            }else  if (chooseFlag == 710) {
               $("#<%=this.hdnMouldTypeId.ClientID%>").val(list[0][0]);
               $("#<%=this.txtMouldTypeName.ClientID%>").val(list[0][1]);

            } else if (chooseFlag == 10) {
                var replaceCom = "";
                for (var i = 0; i < list.length; i++) {
                    replaceCom += list[i][1];
                    if (replaceCom != "") {
                        replaceCom += "|";
                    }
                }
                replaceCom = replaceCom.substring(0, replaceCom.length - 1);
               //$("#<%=this.hdnMouldTypeId.ClientID%>").val(list[0][0]);
                $("#<%=this.txtReplaceComponent.ClientID%>").val(replaceCom);

            }                    
        }

        function Save() {

            var hdnMouldTypeId = $("#<%=this.hdnMouldTypeId.ClientID %>").val();
            var txtDescribe = $("#<%=this.txtDescribe.ClientID %>").val();
            var entity = {};
            entity.MouldBomChildId = bomChildId;
            entity.MouldBomId = bomId;
            entity.MouldTypeId = hdnMouldTypeId;
            entity.ComponentCode = "";
            entity.Describe = txtDescribe;
            entity.ReplaceComponentName = $("#<%=this.txtReplaceComponent.ClientID%>").val();

            var ajax = SKT.LeanMES.Web.Equipment.MouldBomComponentEdit.EditBomChild(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert("<%=Resources.Messages.SaveInSuccess %>");
            parent.window.update();
        }     
    </script>
</asp:Content>