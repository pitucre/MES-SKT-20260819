<%@ Page Language="C#" AutoEventWireup="True" MasterPageFile="~/Masters/EditMaster.master" 
   CodeBehind="AuthorizationEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Certification.AuthorizationEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label2">
                <asp:Label ID="Label1" runat="server" Text="用户名"></asp:Label>
            </td>
            <td class="Field2">
                
                <asp:Label ID="lblLogID" runat="server" Text=""></asp:Label>           
            </td>
            <td class="Label2">
                <asp:Label ID="Label2" runat="server" Text="工号"></asp:Label>
            </td>
            <td class="Field2">
                <asp:Label ID="lblEmployeeNOText" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <asp:Label ID="Label3" runat="server" Text="<%$ Resources:lang, ChineseName %>"></asp:Label>
            </td>
            <td class="Field2">
                <asp:Label ID="lblCNameText" runat="server"></asp:Label>
            </td>
            <td class="Label2">
                <asp:Label ID="Label4" runat="server" Text="<%$ Resources:lang, EnglishName %>"></asp:Label>
            </td>
            <td class="Field2">
                <asp:Label ID="lblUserNameText" runat="server"></asp:Label>
            </td>
        </tr> 
        <tr>
            <td class="Label2">
                <asp:Label ID="Label8" runat="server" Text="岗位授权日期"></asp:Label>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtStart" runat="server" CssClass="DateTimeBox" Width ="100" ></asp:TextBox><em>*</em>
            </td>
            <td class="Label2">
                <asp:Label ID="Label7" runat="server" Text="过期日期"></asp:Label>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtExpiration" runat="server" CssClass="DateTimeBox" Width ="100"></asp:TextBox><em>*</em>
            </td>            
        </tr>       
        </table>
        <div class="clear5"></div>
         
                <table class="EditeContentTable" width="100%">
                 
                    <tr>
                        <td class="Label" style="width: 45%; text-align: center; font-weight:bold;">
                            <asp:Label ID="Label5" runat="server" Text="用户岗位认证列表"></asp:Label>
                        </td>
                        <td class="Label" style="width: 10%; text-align: center;">
                        </td>
                        <td class="Label" style="width: 45%; text-align: center; font-weight:bold;">
                            <asp:Label ID="Label6" runat="server" Text="已授权的岗位认证 "></asp:Label>
                        </td>
                    </tr>                                       
                    <tr>
                        <td class="Field" style="width: 45%; vertical-align: top;">                         
                            <iframe name="frmRoleChooseList" frameborder="0" style="width: 99%; height: 300px;"
                                src="CertChooseList.aspx?ID=<%= Request.QueryString["ID"] %>"></iframe>
                        </td>
                        <td class="Field" style="width: 10%;text-align: center; vertical-align: middle;">
                            <input type="button" id="btnLeftChoose" runat="server" class="rightButton"
                                onclick="btnChooseOnClick(0);" />
                            <br />
                            <br />
                            <br />
                            <br /> 
                            <input type="button" id="btnRightChoose" runat="server" class="leftButton"
                                onclick="btnChooseOnClick(1);" />
                        </td>
                        <td class="Field" style="width: 45%; vertical-align: top; "> 
                            <iframe name="frmUserRoleList" frameborder="0" style="width: 99%; height: 300px; padding:0px;"
                                src="CertificationMemberList.aspx?ID=<%= Request.QueryString["ID"] %>"></iframe>
                        </td>
                    </tr>
                </table>
            
     
    <script type="text/javascript">          
        var userId = '<%= Request.QueryString["ID"] %>';
        function btnChooseOnClick(index) {
            var UserID = <%= Request.QueryString["ID"] %>;
            //过期日期
            var txtExpiration = $("#<%=this.txtExpiration.ClientID %>").val();
            //授权日期
            var txtStart = $("#<%=this.txtStart.ClientID %>").val();        
            var uCertIDString;
            var userName = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>';

            if (index == 0) {//添加
                if (txtExpiration.length == 0 || txtStart.length==0) {
                    alert("<%= Resources.Messages.WithAsteriskIsRequiredAlert %>");
                    return;
                }
                else {
                    if (isDate(txtExpiration) && isDate(txtStart)) {
                         /* document.frames[0]写法只有IE opera 支持 chenglong.zhu 2016-11-21 */
                        //uCertIDString = document.frames[0].window.getSelectedValues(); 
                        uCertIDString = window.frames[0].window.getSelectedValues();
                        //只有授权时需要把时间写过去，取消授权没有把时间写过去，所以在此处加上即可
                        var Expiration=new Date(Date.parse(txtExpiration.replace(/-/g,   "/")));
                        var Start=new Date(Date.parse(txtStart.replace(/-/g,   "/")));
                        if(Expiration<Start)
                        {
                            alert("过期日期不能小于授权日期!");
                            return;                    
                        }
                    }
                    else {
                        alert("无效日期格式!");
                        return;
                    }
                }                
            }
            else {
                //uCertIDString = document.frames[1].window.getSelectedValues();
                uCertIDString = window.frames[1].window.getSelectedValues();
            }

            if (uCertIDString == "") {
                alert("<%= Resources.Messages.RequireOperateRecord %>");
                return;
            }

            /*Add By Alen 2016-06-16 增加时间提醒给用户，以防用户选错认证授权的有效时间  Begin*/
            if(index==0){
            var _str = "请确认此岗位认证的时间\n授权日期为：{0}\n到期日期为：{1}\n如果同意点【确定】，否则点【取消】，然后重新选择日期.";
                if(!confirm(_str.format(txtStart,txtExpiration))){
                    return false;
                }
            }
            /*End*/

            /*授权岗位认证到用户*/
            if (index == 0) {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxCertification.AssignCertsToUser(UserID, uCertIDString,txtStart,txtExpiration);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return;
                }                
            }
            else {/*从用户岗位认证中删除*/
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxCertification.RemoveCertsFromUser(uCertIDString);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return;
                }
            }
            $("#<%=this.txtExpiration.ClientID %>").val("");
//            document.frames[0].window.document.forms[0].submit();
//            document.frames[1].window.document.forms[0].submit();
            document.forms[0].submit();
        }
    </script>
</asp:Content>

