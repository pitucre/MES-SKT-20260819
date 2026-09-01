<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="True"
    CodeBehind="WarehouseLocationMaterialEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Warehouse.WarehouseLocationMaterialEdit" Title="Edit WarehouseLocationMaterial" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
     <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
    <table width="100%" class="EditeContentTable">        
        <tr>
            <td class="Label1"><%= Resources.lang.ItemCode%><em>*</em></td>
            <td class="Field1">
                <asp:TextBox ID="txtItemCode" runat="server" CssClass="TextBox" MaxLength="50" ReadOnly="true" IsRequired='1' ClientIDMode="Static" /> 
                <input type="button" id="btnSelectItem" class="ButtonBox" value="..." onclick="selectItem()" />
                <asp:HiddenField ID="hdnItemId" runat="server" Value="-1" />
        </tr>
         <tr>
            <td class="Label1"><%= Resources.lang.WarehouseCode %><em>*</em></td>
            <td class="Field1">
                <asp:TextBox ID="txtCWhCode" runat="server" CssClass="TextBox" MaxLength="50" ReadOnly="true" IsRequired='1' ClientIDMode="Static" /> 
                <input type="button" id="btnSelectWarehouse" class="ButtonBox" value="..." onclick="selectWarehouse()" />
                <asp:HiddenField ID="hdnCWhID" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
        </tr>

        <tr>
            <td class="Label1"><%= Resources.lang.WarehouseGoodsCode %><em>*</em></td>
            <td class="Field1">
                <asp:TextBox ID="txtCBarCode" runat="server" CssClass="TextBox" MaxLength="50" ReadOnly="true" IsRequired='1' ClientIDMode="Static" /> 
                <input type="button" id="btnSelectWarehouseLocation" class="ButtonBox" value="..." onclick="selectWarehouseLocation()" />
                <asp:HiddenField ID="hdnCWlId" runat="server" Value="-1" />
            </td>
        </tr>
        <tr>
            <td class="Label1">
               <%= Resources.lang.Remark%>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtRemark" runat="server" CssClass="TextArea" TextMode="MultiLine" MaxLength="100" Height="55px" Width="80%" />
            </td>
        </tr>
    </table>

    <script type="text/javascript">
        //预定义
        var id = '<%=Request.QueryString["ID"]%>';
        var flag = -1;

        //加载
        $(document).ready(function () {
            /*如果是编辑状态，关闭字段提示*/
            if (parseInt(id) > 0) {
                $(".Tips").hide();
            }
        });

        //保存
        function Save() {
            //获取视图模型
            var entity = getViewModel();
            //校验视图模型
            if (!verifyViewModel(entity)) { return false; }
            //异步保存
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxWarehouseLocationMaterial.Edit(entity);
            if (ajax.error == null) {
                alert('<%=Resources.Messages.SaveInSuccess%>')
                parent.window.UpdateList(entity.ItemCode);
            } else {
                alert(ajax.error.Message);
                return false;
            }
        }
        //获取视图模型
        function getViewModel() {
            var entity = {};

            entity.WarehouseLocationMaterialId = id;
            entity.ItemId = $("#<%=this.hdnItemId.ClientID %>").val();
            entity.ItemCode = $("#<%=this.txtItemCode.ClientID %>").val();
            entity.CWhId = $("#<%=this.hdnCWhID.ClientID %>").val();
            entity.CWhCode = $("#<%=this.txtCWhCode.ClientID %>").val();
            entity.CWlId = $("#<%=this.hdnCWlId.ClientID %>").val();
            entity.CreateBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
            entity.ModifyBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
            entity.Remark = $("#<%=this.txtRemark.ClientID %>").val();

            return entity;
        }
        //校验视图模型
        function verifyViewModel(entity)
        {
            var strError = "";
            if (checkStrLen(entity.Remark, 200, false)) {
                strError += "<%= Resources.Messages.DescriptionError%>";
            }
            if (!isNull(strError)) {
                alert(strError.toString());
                return false;
            }
            return true;
        }
        //选择窗口
        function selectItem() {
            flag = 1;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=1&Multiple=false&rnd=" + Math.random(), width: 650, height: 300 });
        }
        function selectWarehouse() {
            flag = 2;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=14&Multiple=false&rnd=" + Math.random(), width: 650, height: 300 });
        }
        function selectWarehouseLocation() {
            flag = 3;
            var searchCondition = "";
            var strCWhId = $("#<%=this.hdnCWhID.ClientID %>").val();
            if (!strCWhId) {
                alert("<%=Resources.Messages.RequireWarehouse%>");
            }
            else {
                searchCondition = "WarehouseId ='" + strCWhId + "'";
            }
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=33&PageCondition=" + searchCondition + "&Multiple=false&rnd=" + Math.random(), width: 550, height: 300 });
        }
        function getChooseValue(list) {
            switch (flag) {
                case 1:
                    $("#<%=this.hdnItemId.ClientID %>").val(list[0][0]);
                    $("#<%=this.txtItemCode.ClientID %>").val(list[0][2]);
                    break;
                case 2:
                    $("#<%=this.hdnCWhID.ClientID %>").val(list[0][0]);
                    $("#<%=this.txtCWhCode.ClientID %>").val(list[0][1]);
                    //清空货位
                    $("#<%=this.hdnCWlId.ClientID %>").val("");
                    $("#<%=this.txtCBarCode.ClientID %>").val("");
                    break;
                case 3:
                    $("#<%=this.hdnCWlId.ClientID %>").val(list[0][0]);
                    $("#<%=this.txtCBarCode.ClientID %>").val(list[0][2]);
                    break;
                default:
                    flag = -1;
                    break;
            }
            flag = -1;
        }

    </script>

</asp:Content>