<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="True"
    CodeBehind="EquipmentCheckOutHistoryEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.EquipmentCheckOutHistoryEdit" Title="Edit EquipmentCheckOutHistory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %>
    </div>
    <div class="ListTableTitle"><span>检验计划</span></div>
    <table width="100%" class="EditeContentTable">
        

        <tr >
            <td class="Label2" id="tdEquiment" runat="server">设备编码</td>
            <td class="Field2" id="tdEquiment1" runat="server">
                <asp:Label runat="server" ID="labeqcode"></asp:Label>
            </td>
          <td class="Label2">检验项目</td>
            <td class="Field2" >
                <asp:Label runat="server" ID="labproject"></asp:Label>
            </td>
        </tr>  
       
    </table>
    <div class="clear5"></div>
        <div class="ListTableTitle"><span>检验记录</span></div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label2"><%= Resources.lang.CertificateFileName %></td>
            <td class="Field2">
                <asp:FileUpload ID="fuLoadingList" runat="server" onchange="uploadFile(this.value)" ClientIDMode="Static" />
                <asp:LinkButton ID="linkUploadFile" runat="server" OnClick="linkUploadFile_Click" ClientIDMode="Static"></asp:LinkButton>
                <asp:Label runat="server" ClientIDMode="Static" ID="lbFileReady" CssClass="redFont" ForeColor="Red">未载入</asp:Label>
            </td>
            <td class="Label2"><%= Resources.lang.CertificateNo %></td>
            <td class="Field2">
                <asp:TextBox ID="txtCertificateNo" runat="server" CssClass="TextBox" MaxLength="50"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">送检人</td>
            <td class="Field2">
                <asp:TextBox ID="txtRepairBy" runat="server" CssClass="TextBox" MaxLength="50" IsRequired="1"
                    Enabled="false" ClientIDMode="Static">
                </asp:TextBox>
                <input type="button" value="..." class="ButtonBox" onclick="selectBy()" />
                <asp:HiddenField ID="HiddBy" runat="server" ClientIDMode="Static" />
            </td>
            <td class="Label2">送检时间</td>
            <td class="Field2">
                <asp:TextBox ID="txtInspectionTime" runat="server" CssClass="DateTimeBox" MaxLength="150"  ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr>
         <tr>
       
         <td class="Label2">送检单位</td>
         <td class="Field2">
             <asp:TextBox ID="txtInspectionUnit" runat="server" CssClass="TextBox" MaxLength="150"  ClientIDMode="Static"></asp:TextBox>
         </td>
     </tr>
        <tr>
            <td class="Label2"><%= Resources.lang.Status %></td>
            <td class="Field2">
                <asp:DropDownList runat="server" ID="txtStatus">
                    <asp:ListItem Value="1">合格</asp:ListItem>
                    <asp:ListItem Value="2">维修再检</asp:ListItem>
                    <asp:ListItem Value="3">报废</asp:ListItem>
                    <asp:ListItem Value="4">停用</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td class="Label2"><%= Resources.lang.Remark %></td>
            <td class="Field2">
                <asp:TextBox ID="txtRemark" runat="server" CssClass="TextBox" MaxLength="200"></asp:TextBox>
            </td>
        </tr>
    </table>

    <script type="text/javascript">
        var Id = '<%=Request.QueryString["ID"]%>';

        function uploadFile(filePath) {
            if (filePath.length > 0) {
                var str = '';
                var postback = $('#<%= linkUploadFile.ClientID %>').attr('href');
                var funcStartIndex = postback.indexOf('\'');
                var funcEndIndex = postback.indexOf('\',');
                if (funcStartIndex != -1 && funcEndIndex != -1) {
                    var str = postback.substring(funcStartIndex + 1, funcEndIndex);

                    __doPostBack(str, '');
                } else {
                    return false;
                }
                //$("#linkUploadFile").click();
            }
        }
        /*送检人*/
        function selectBy() {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=12&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }
        function getChooseValue(list) {
            $("#<%=this.txtRepairBy.ClientID %>").val(list[0][2]);
            $("#<%=this.HiddBy.ClientID %>").val(list[0][1]);
        }

        /*选择供应商*/
        function selectSupplier() {
            chooseFlag = 34;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=34&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }
        function getChooseValue(list) {
            $("#<%=this.txtRepairBy.ClientID %>").val(list[0][2]);
            $("#<%=this.HiddBy.ClientID %>").val(list[0][1]);
        }
        /*保存数据*/
        function Save() {
            var txtStatus = $("#<%=this.txtStatus.ClientID%>").val();
            var txtCertificateNo = $.trim($("#<%=this.txtCertificateNo.ClientID%>").val());
            var txtCertificateFileName = $.trim($("#<%=this.lbFileReady.ClientID%>").html());
            var txtRemark = $.trim($("#<%=this.txtRemark.ClientID%>").val());
            var txtCreateBy = $.trim($("#<%=this.txtRepairBy.ClientID%>").val());
            var inspectionTime = $.trim($("#<%=this.txtInspectionTime.ClientID%>").val());
            var txtInspectionUnit = $.trim($("#<%=this.txtInspectionUnit.ClientID%>").val());
            
            /*表单验证*/
            /*如需表单验证可以此处处理验证 开始*/


            var entity = {};

            entity.EquipmentCheckOutPlanId = Id
            entity.Status = txtStatus;
            entity.CertificateNo = txtCertificateNo;
            entity.CertificateFileName = txtCertificateFileName;
            entity.Remark = txtRemark;
            entity.CreateBy = txtCreateBy;
            entity.InspectionTime = new Date(Date.parse(inspectionTime.replace(/-/g, "/")));
            entity.InspectionUnit = txtInspectionUnit;
            
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipmentCheckOutHistory.EquipmentCheckOutHistoryEdit(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert('<%=Resources.Messages.SaveInSuccess%>')
            if ('<%=Request.QueryString["inMenu"] %>' == "true") {
                openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/User/UserEdit.aspx?name=Account_UserEdit&ID=" + parseInt(ajax.value);
                location.href = openWinUrl;
            }
            else {
                parent.window.Refresh();
            }
        }
    </script>

</asp:Content>
