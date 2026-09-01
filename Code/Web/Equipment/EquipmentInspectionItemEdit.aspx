<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="EquipmentInspectionItemEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.EquipmentInspectionItemEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <div class="infoTips">
        <em>*</em><span>为必填项</span>
    </div>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">父节点
            </td>
            <td class="Field2">
                <%=parentName%>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%=Resources.lang.InspectionItemName %><em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtInspectionItemName" runat="server" CssClass="TextBox" IsRequired='1'></asp:TextBox>
            </td>
        </tr>
     <%--   <tr>
            <td class="Label2">
                <%=Resources.lang.TestMethod %>
            </td>
            <td class="Field2">
                 <asp:TextBox ID="txtTestMethod" CssClass="TextArea" TextMode="MultiLine" Width="300"
                    Height="80" runat="server" ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr>--%>
        <tr>
            <td class="Label2">录入方式
            </td>
            <td class="Field2">
                <asp:DropDownList runat="server" ID="methodType"  ClientIDMode="Static">
                    <asp:ListItem Value="1">固定结果</asp:ListItem>
                    <asp:ListItem Value="2">指定值</asp:ListItem>
<%--                    <asp:ListItem Value="3">常规范围</asp:ListItem>
                    <asp:ListItem Value="4">散列值</asp:ListItem>
                    <asp:ListItem Value="5">范围</asp:ListItem>--%>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="Label2">单位
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtUnit" runat="server" CssClass="TextBox" Enabled="false"></asp:TextBox><input
                        type="button" id="btnSelectUnit" class="ButtonBox" value="..." title="<%=Resources.lang.ChangeDate %>"
                        onclick="selectUnit();" />
            </td>
        </tr>
         <tr>
            <td class="Label2">检验方法
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtInpsectionmethods" runat="server" CssClass="TextBox" Enabled="false"></asp:TextBox><input
                        type="button" id="btnSelectMethods" class="ButtonBox" value="..." title="<%=Resources.lang.ChangeDate %>"
                        onclick="selectMethods();" />
            </td>
        </tr>
        <tr>
            <td class="Label2">排序
            </td>
            <td class="Field2">
                <asp:TextBox ID="Sorting" runat="server" CssClass="TextBox" Text="0" IsRequired='1' IsNumber='1'></asp:TextBox>
            </td>

        </tr>
        <tr>
            <td class="Label2">
                <%=Resources.lang.Description%>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtDescription" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%=Resources.lang.Status %>
            </td>
            <td class="Field2">
                <asp:HiddenField ID="txtHideInspectionItemId" runat="server" />
                <asp:HiddenField ID="txtHideCreater" runat="server" />
                <asp:HiddenField ID="txtHideCreateTime" runat="server" />
                <asp:DropDownList runat="server" ID="ddlStatus">
                    <asp:ListItem>启用</asp:ListItem>
                    <asp:ListItem>禁用</asp:ListItem>
                </asp:DropDownList>
            </td>

        </tr>
    </table>

    <script language="javascript" type="text/javascript">
        var ReqId = '<%=Request.QueryString["ID"] %>';
        var ParentId = '<%=parentId %>';
        $("select").css("width", "140px");

        var chooseFlag = -1;
        function selectUnit() {
            chooseFlag = 6;
            var searchCondition = " DicProperty ='Unit' ";
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=3&PageCondition=" + searchCondition + "&Multiple=false&rnd=" + Math.random(), width: 600, height: 350 });
        }

        function selectMethods() {
            chooseFlag = 7;
            var searchCondition = " DicProperty='Inspectionmethod' ";
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=822&PageCondition=" + searchCondition + "&Multiple=true&rnd=" + Math.random(), width: 600, height: 350 });
        }

        function getChooseValue(list) {
            if (chooseFlag == 6) {
                ;
                $("#<%=txtUnit.ClientID %>").val(list[0][1]);
            }
            else if (chooseFlag == 7) {
                var Inpsectionmethods = [];
                var myValue = $("#<%=txtInpsectionmethods.ClientID %>").val();
                for (var i = 0; i < list.length; i++) {
                    Inpsectionmethods.push(list[i][1]);
                }
                if (myValue != "") {
                    $("#<%=txtInpsectionmethods.ClientID %>").val(myValue + "," + Inpsectionmethods.join(','));
                }
                else {
                    $("#<%=txtInpsectionmethods.ClientID %>").val(Inpsectionmethods.join(','));
                }
            }
            chooseFlag = -1;
        }

        /*保存数据*/
        function Save() {
            var entity = {};
            //entity.InspectionItemId = $("#<%=this.txtHideInspectionItemId.ClientID %>").val();
            entity.InspectionItemId = ReqId;
            entity.InspectionItemName = $.trim($("#<%=this.txtInspectionItemName.ClientID %>").val());
            <%--   entity.TestMethod = $.trim($("#<%=this.txtTestMethod.ClientID %>").val());--%>
            entity.Creater = $("#<%=this.txtHideCreater.ClientID %>").val();
            /* 无用字段 chenglong.zhu 2016-11-21*/
            //                entity.CreateTime =  new Date($("#<%=this.txtHideCreateTime.ClientID %>").val());
            entity.Description = $.trim($("#<%=this.txtDescription.ClientID %>").val());
            entity.Status = $("#<%=this.ddlStatus.ClientID %>").val() == '启用' ? true : false;
            entity.ParentId = ParentId;
            entity.Sorting = $("#<%=this.Sorting.ClientID %>").val();

            if (entity.InspectionItemId === '') {
                entity.InspectionItemId = ReqId;
            }
            if (ReqId == -1) {
                entity.CreateTime = new Date();
            }
            entity.InspectionMethodId = $("#<%=this.methodType.ClientID %>").val();
            entity.UnitName = $("#<%=txtUnit.ClientID %>").val();
            entity.Inpsectionmethods = $("#<%=txtInpsectionmethods.ClientID %>").val();
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipmentInspectionItem.EquipmentInspectionItemEdit(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert('<%=Resources.Messages.SaveInSuccess %>');
            parent.window.UpdateList();
            return ajax;
        }
    </script>
</asp:Content>
