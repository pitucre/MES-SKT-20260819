<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="DIPPackagingPlanEdit.aspx.cs" Inherits="SKT.LeanMES.Web.DIPPackaging.DIPPackagingPlanEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <table width="100%" class="EditeContentTable">
        <tr><td colspan="4" class="Label"><%=Resources.Messages.WithAsteriskIsRequired %></td></tr>
        <tr>
            <td class="Label2">楼层<em>*</em></td>
            <td class="Field2">
                 <asp:TextBox runat="server" ID="txtFName" CssClass="TextBox" Enabled="false" IsRequired="1"></asp:TextBox>
                <input type="button" value="..." class="ButtonBox" onclick="selectFName()" />
                <asp:HiddenField ID="txtFid" runat="server" ClientIDMode="Static" />
            </td>
             <td class="Label2">楼层线体<em>*</em></td>
            <td class="Field2">
                 <asp:TextBox runat="server" ID="txtLineName" CssClass="TextBox" Enabled="false" IsRequired="1"></asp:TextBox>
                <input type="button" value="..." class="ButtonBox" onclick="selectLineName()" />
                <asp:HiddenField ID="txtLineId" runat="server" ClientIDMode="Static" />
            </td>
        </tr>
        <tr>
            <td class="Label2">工单<em>*</em></td>
            <td class="Field2">
                 <asp:TextBox runat="server" ID="txtOrderNO" CssClass="TextBox" Enabled="false" IsRequired="1"></asp:TextBox>
                <input type="button" value="..." class="ButtonBox" onclick="selectOrderNO()" />
                <asp:HiddenField ID="txtOrderId" runat="server" ClientIDMode="Static" />
            </td>
            <td class="Label2">工单号</td>
            <td class="Field2">
                <asp:Label ID="txtOrderOrder" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">料号</td>
            <td class="Field2" colspan="3"> 
                <asp:Label ID="txtItemCode" runat="server"></asp:Label>
                <asp:HiddenField ID="txtItemId" runat="server" ClientIDMode="Static" />
            </td>

        </tr>
        <tr>
            <td class="Label2">料名称</td>
            <td class="Field2" colspan="3">
                 <asp:Label ID="txtItemName" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">产品描述</td>
            <td class="Field2" colspan="3">
                <asp:Label ID="txtItemDes" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">计划生产数量<em>*</em></td>
            <td class="Field2">
                <asp:TextBox ID="txtPlanQty" runat="server" CssClass="TextBox"  MaxLength="1000" IsRequired="1"></asp:TextBox>
            </td>
            <td class="Label2">计划时间<em>*</em></td>
            <td class="Field2">
                <asp:TextBox ID="txtPlanDatiTime" IsRequired="1" CssClass="DateTimeBox"  runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2"><%= Resources.lang.Remark %></td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtRemark" runat="server" CssClass="TextBox"  MaxLength="200"></asp:TextBox>
            </td>
        </tr>
    </table>

    <script type="text/javascript">
        var DPPId = '<%=Request.QueryString["ID"]%>';


         var PageId = 0;

        function selectFName() {
            PageId = 829;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=" + PageId + "&Multiple=false&rnd=" + Math.random(), width: 650, height: 320 });
        }
        function selectLineName() {
            PageId = 830;
            if ($("#<%=this.txtFName.ClientID %>").val() == "") {
                alert("请先选择楼层！");
                return;
            }
            var SearchCondition = " FName ='" + $("#<%=this.txtFName.ClientID %>").val() + "'";
            dialog({
                title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=" + PageId + "&Multiple=false&PageCondition="
                     + escape(SearchCondition) + "&rnd=" + Math.random(), width: 650, height: 320
            });
        }
        function selectOrderNO() {
            PageId = 44;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=" + PageId + "&Multiple=false&rnd=" + Math.random(), width: 650, height: 320 });
        }

        function getChooseValue(list) {
            if (PageId == 829) {
               
                $("#<%=this.txtFName.ClientID %>").val(list[0][2]);
                $("#<%=this.txtFid.ClientID %>").val(list[0][0]);
            } else if (PageId == 830) {
                $("#<%=this.txtLineName.ClientID %>").val(list[0][1]);
                $("#<%=this.txtLineId.ClientID %>").val(list[0][0]);
            }
            else if (PageId == 44) {
                $("#<%=this.txtOrderNO.ClientID %>").val(list[0][1]);
                $("#<%=this.txtOrderId.ClientID %>").val(list[0][0]);
                $("#<%=this.txtItemCode.ClientID %>").text(list[0][2]);
                $("#<%=this.txtItemName.ClientID %>").text(list[0][5]);
                $("#<%=this.txtOrderOrder.ClientID %>").text(list[0][1]);

                //查询出来
                GetItemModel(list[0][2]);
            }
        }
        //查物料信息
        function GetItemModel(itemcode) {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxDIPPackaging.GetItemModel(itemcode);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            else {
                var data = ajax.value;
                $("#<%=this.txtItemId.ClientID %>").val(data.ItemID);
                $("#<%=this.txtItemDes.ClientID %>").text(data.ItemSpec);
            }
        }


        /*保存数据*/
        function Save() {
            var txtFid = $("#<%=this.txtFid.ClientID%>").val();
            var txtLineId = $("#<%=this.txtLineId.ClientID%>").val();
            var txtOrderId = $("#<%=this.txtOrderId.ClientID%>").val();
            var txtOrderNO = $.trim($("#<%=this.txtOrderNO.ClientID%>").val());
            var txtItemId = $("#<%=this.txtItemId.ClientID%>").val();
            var txtItemCode = $.trim($("#<%=this.txtItemCode.ClientID%>").text());
            var txtItemDes = $.trim($("#<%=this.txtItemDes.ClientID%>").text());
            var txtPlanQty = $("#<%=this.txtPlanQty.ClientID%>").val();
            var txtPlanDatiTime = $("#<%=this.txtPlanDatiTime.ClientID%>").val();
            var txtStatus = 1;
            var txtCreateBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
            var txtModifyBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
            var txtRemark = $.trim($("#<%=this.txtRemark.ClientID%>").val());

        /*表单验证*/
        /*如需表单验证可以此处处理验证 开始*/


        var entity = {};

        entity.DPPId = parseInt(DPPId);
        entity.Fid = parseInt(txtFid);
        entity.LineId = parseInt(txtLineId);
        entity.OrderId = parseInt(txtOrderId);
        entity.OrderNO = txtOrderNO;
        entity.ItemId = parseInt(txtItemId);
        entity.ItemCode = txtItemCode;
        entity.ItemDes = txtItemDes;
        entity.PlanQty = parseInt(txtPlanQty);
        //entity.PlanDatiTime = txtPlanDatiTime;
        entity.Status = parseInt(txtStatus);
        entity.CreateBy = txtCreateBy;
        entity.ModifyBy = txtModifyBy;
        entity.Remark = txtRemark;

        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxDIPPackaging.DIPPackagingPlanEdit(entity, txtPlanDatiTime);
        if (ajax.error != null) {
            alert(ajax.error.Message);
            return false;
        }

        alert('<%=Resources.Messages.SaveInSuccess%>')
        parent.window.Refresh();
    }
    </script>

</asp:Content>
