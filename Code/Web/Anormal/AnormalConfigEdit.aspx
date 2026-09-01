<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/EditMaster.master" CodeBehind="AnormalConfigEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Anormal.AnormalConfigEdit" %>


<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label1">
                异常类型<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtAnormalTypeName" IsRequired='1' ReadOnly="true"   runat="server" CssClass="TextBox"></asp:TextBox>
                <input type="button" runat="server" class="ButtonBox" value="..." title="异常类型" onclick="selectAnormalType();" />
                <input type="hidden" id="hdAnormalTypeId" runat="server" value="-1"/>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                异常接收途径<em>*</em>
            </td>
            <td class="Field1">
                <asp:DropDownList ID="ddlSendWay" runat="server" onchange="ChangeSendWay()">
                    <asp:ListItem Value="1" Text="邮件发送" Selected="True"></asp:ListItem>
                    <asp:ListItem Value="2" Text="微信发送"></asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                异常接收人<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtReceiverName" IsRequired='1' Enabled="false" runat="server" CssClass="TextBox" Width="90%"></asp:TextBox>
                <input type="button" runat="server" class="ButtonBox" value="..." title="异常接收人" onclick="selectActionPerson();" />
                <input type="hidden" id="hdReceiver" runat="server" />
            </td>
        </tr>
        
    </table>
    <script type="text/javascript">
        var ID = '<%= Request.QueryString["ID"] %>';
        function Save() {
            var hdAnormalTypeId = $.trim($("#<%=this.hdAnormalTypeId.ClientID %>").val());
            var txtAnormalTypeName = $.trim($("#<%=this.txtAnormalTypeName.ClientID %>").val());
            var txtReceiverName = $("#<%=this.txtReceiverName.ClientID %>").val();
            var hdReceiver = $("#<%=this.hdReceiver.ClientID %>").val();
            var ddlSendWay = $("#<%=this.ddlSendWay.ClientID %>").val();
            if (ddlSendWay == -1) {
                alert("必须选择发送途径!");
                return false;
            }

            var entity = {};
            entity.AnormalConfigID = ID;
            entity.AnormalTypeId = hdAnormalTypeId;
            entity.Receiver = hdReceiver;
            entity.ReceiverName = txtReceiverName;
            entity.SendWay = ddlSendWay;
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxAnormalConfig.EditAnormalConfig(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert("<%= Resources.Messages.SaveInSuccess %>");
            parent.window.UpdateList(txtAnormalTypeName);
        }
         //选择异常接收人
        function selectActionPerson() {
            var pageCondition = '';
            dialog({ title: "选择异常接收人", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot%>/Framework/ChoosePage.aspx?PageId=12&Multiple=true&CallBackFunc=setActionPerson&PageCondition=" + pageCondition + "&rnd=" + Math.random(), width: 680, height: 350 });
        }
        function setActionPerson(list) {
            var receiver = $("#<%=this.hdReceiver.ClientID %>").val();
            var receiverName = $("#<%=this.txtReceiverName.ClientID %>").val();

            var ddlSendWay = $("#<%=this.ddlSendWay.ClientID %>").val();
            var listReceiver = receiver.split(";");
            //清空选择项
            if (list.length > 0 && list[0][0] == "-1") {
                receiver = "";
                receiverName = "";
            }
            else {//添加不重复项（验证邮箱和微信）
                for (var i = 0; i < list.length; i++) {
                    if (listReceiver.indexOf(list[i][2]) == -1) {
                        if (ddlSendWay == 1) {
                            if (!list[i][5] || $.trim(list[i][5]) == "") {
                                alert("请先在【用户列表】维护好当前用户的邮箱地址！");
                                return;
                            }
                        } else if (ddlSendWay == 2) {
                            if (!list[i][6] || $.trim(list[i][6]) == "") {
                                alert("请先在【用户列表】维护好当前用户的微信号！");
                                return;
                            }
                        }
                        receiver += ";" + list[i][2];
                        receiverName += ";" + list[i][3];
                    }
                }
                if (receiver.indexOf(";") == 0) {
                    receiver = receiver.substring(1)
                    receiverName = receiverName.substring(1);
                }
            }
            $('#<%=this.hdReceiver.ClientID%>').val(receiver);
            $('#<%=this.txtReceiverName.ClientID%>').val(receiverName);
            
        }
        //选择异常类型
        function selectAnormalType() {
            var pageCondition = '';
            dialog({ title: "选择异常类型", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot%>/Framework/ChoosePage.aspx?PageId=831&Multiple=false&CallBackFunc=setAnormalType&PageCondition=" + pageCondition + "&rnd=" + Math.random(), width: 680, height: 350 });
        }
        function setAnormalType(list) {
            $('#<%=this.txtAnormalTypeName.ClientID%>').val(list[0][1]);
            $('#<%=this.hdAnormalTypeId.ClientID%>').val(list[0][0]);
        }

        function ChangeSendWay() {
            $("#<%=this.txtReceiverName.ClientID %>").val("");
            $("#<%=this.hdReceiver.ClientID %>").val("");
        }
    </script>
</asp:Content>

