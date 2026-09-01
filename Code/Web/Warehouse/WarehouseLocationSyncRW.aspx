<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="True"
    CodeBehind="WarehouseLocationSyncRW.aspx.cs" Inherits="SKT.LeanMES.Web.Warehouse.WarehouseLocationSyncRW"
    Title="Edit WarehouseLocation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label2">
                <%= Resources.lang.WarehouseInfo%><em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtWhInfo" runat="server" CssClass="TextBox" MaxLength="20" Enabled="false"
                    IsRequired='1' ClientIDMode="Static"> 
                </asp:TextBox><input type="button" id="btnselectWhInfo" class="ButtonBox" value="..."
                    title="Select" onclick="selectWhInfo();" />
                <asp:HiddenField ID="hdnWhID" runat="server" Value="-1" ClientIDMode="Static" />
                <asp:HiddenField ID="hdnWhCode" runat="server" Value="" ClientIDMode="Static" />
            </td>        
            <td class="Label2">
                料架编码
            </td>
            <td class="Field2">
               <asp:TextBox ID="txtShiftCode" runat="server"  CssClass="TextBox" 
                    MaxLength="50"></asp:TextBox>
            </td>    
        </tr>                                        
    </table>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.EShelf.js" type="text/javascript"></script>
    <script type="text/javascript">
        var eshelf = new EShelf_RW({
            userId: "<%= SKT.LeanMES.Web.AccountController.GetCurrentUser().UserId %>",
            userName: "<%= SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>",
            pluginName: "RW",
            webRoot: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>",
            title: "PDA-物料备料",
        });

        $(function () {
            $("#btnSubmit").click(function () {
                Save();
            });
        });

        function selectWhInfo() {
            flag = 1
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=14&Multiple=false&rnd=" + Math.random(), width: 600, height: 360 });
        }

        function getChooseValue(list) {
            switch (flag) {
                case 1:
                    if (list[0][0] != "-1") {
                        $("#txtWhInfo").val(list[0][1] + "|" + list[0][2]);
                    }
                    else {
                        $("#txtWhInfo").val("");
                    }
                    $("#hdnWhID").val(list[0][0]);
                    $("#hdnWhCode").val(list[0][1]);
                    break;
                case 2:
                    break;
                default:
                    flag = -1;
                    break;
            }

            flag = -1;
        }

        /*保存数据*/
        function Save() {
            var txtWhCode = $("#hdnWhCode").val().trim();                       
            var txtShiftCode = $("#<%=this.txtShiftCode.ClientID %>").val();
            if (!txtWhCode) {
                alert("请选择仓库");
                return false;
            }
            if (!txtShiftCode) {
                alert("请输入料架编码");
                return false;
            }
            console.log(eshelf)
            var data = eshelf.WareHouseLocationSync(txtShiftCode, txtWhCode);
            if (data.success) {
                alert("同步成功");
            }
            else {
                alert("同步失败【" + data.error + "】");
                return false;
            }           
        }
    </script>
</asp:Content>
