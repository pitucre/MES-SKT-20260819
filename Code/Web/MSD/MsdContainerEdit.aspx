<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="MsdContainerEdit.aspx.cs" Inherits="SKT.LeanMES.Web.MSD.MsdContainerEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label1">
                容器类型<em>*</em>
            </td>
            <td class="Field1">
                <asp:DropDownList ID="ddlContainerType" ClientIDMode="Static" runat="server" IsRequired="1">
                    <asp:ListItem Text="--请选择--" Value="" />
                    <asp:ListItem Text="恒温箱" Value="1" />
                    <asp:ListItem Text="烘烤箱" Value="2" />
                </asp:DropDownList>
            </td>
        </tr>
         <tr>
            <td class="Label1">
                容器名称<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtContainerName" runat="server" ClientIDMode="Static" IsRequired="1"
                    CssClass="TextBox" MaxLength="30"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                容器编码<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtContainerCode" runat="server" ClientIDMode="Static" IsRequired="1"
                    CssClass="TextBox" MaxLength="30"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                最大装载数量<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtMaxQty" runat="server" ClientIDMode="Static" IsRequired="1" MaxLength="7"
                    CssClass="TextBox" MinValue='1'></asp:TextBox>
            </td>
        </tr>
        <tr class="isBakeContainer">
            <td class="Label1">
                上限温度(℃ )<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtMaxTemp" runat="server" ClientIDMode="Static" IsRequired="1"
                    CssClass="TextBox" MaxLength="7"></asp:TextBox> ℃
            </td>
        </tr>
        <tr class="isBakeContainer">
            <td class="Label1">
                下限温度(℃ )<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtMinTemp" runat="server" ClientIDMode="Static" IsRequired="1"
                    CssClass="TextBox" MaxLength="7"></asp:TextBox> ℃
            </td>
        </tr>
        <tr>
            <td class="Label1">
                描述
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtRemark" runat="server" TextMode="MultiLine" CssClass="TextArea"
                    ClientIDMode="Static" MaxLength="100"></asp:TextBox>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        var msdContainerId = '<%=Request.QueryString["ID"]%>';

        $().ready(function () {
            $(".isBakeContainer").hide();
            $("#txtMaxTemp,#txtMinTemp").val(0);

            $("#txtMaxQty").bind("keyup", function () {
                getIntVal(this);
            });

            $("#txtMaxTemp,#txtMinTemp").bind("keyup", function () {
                getDecimalVal(this);
            });

            $("#ddlContainerType").change(function () {
                if (this.value == "1") { //恒温箱
                    $(".isBakeContainer").hide();
                    $("#txtMaxTemp,#txtMinTemp").val(0);
                }
                else {
                    $(".isBakeContainer").hide();
                    $("#txtMaxTemp,#txtMinTemp").val(0);


                }
            });

            if ($("#<%=this.ddlContainerType.ClientID%>").val() == "1") {
                $(".isBakeContainer").hide();
                

            }
        });


        /*保存数据*/
        function Save() {
            var txtContainerType = $("#<%=this.ddlContainerType.ClientID%>").val();
            var txtContainerCode = $.trim($("#<%=this.txtContainerCode.ClientID%>").val());
            var txtMaxTemp = $("#<%=this.txtMaxTemp.ClientID%>").val();
            var txtMinTemp = $("#<%=this.txtMinTemp.ClientID%>").val();
            var txtMaxQty = $("#<%=this.txtMaxQty.ClientID%>").val();           
            var txtRemark = $.trim($("#<%=this.txtRemark.ClientID%>").val());
            var txtContainerName = $.trim($("#<%=this.txtContainerName.ClientID%>").val());

            if (parseFloat(txtMaxTemp) < parseFloat(txtMinTemp)) {
                alert("上限温度不可小于下限温度！");
                return;
            }
            /*表单验证*/
            /*如需表单验证可以此处处理验证 开始*/

            var entity = {};

            entity.MsdContainerId = msdContainerId
            entity.ContainerType = txtContainerType;
            entity.ContainerCode = txtContainerCode;
            entity.MaxTemp = parseFloat(txtMaxTemp);
            entity.MinTemp = parseFloat(txtMinTemp);
            entity.MaxQty = parseInt(txtMaxQty);           
            entity.Remark = txtRemark;
            entity.ContainerName = txtContainerName;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMSD.MsdContainerEdit(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert('<%=Resources.Messages.SaveInSuccess%>');
            parent.window.UpdateList();
             
        }
    </script>
</asp:Content>
