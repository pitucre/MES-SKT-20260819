<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="ContainerWeightEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Container.ContainerWeightEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <div class="wrap_tb" style="min-width: 650px;">
        <div class="tb_c" style="min-height: 300px; overflow: auto;">
            <div class="infoTips">
                <%=Resources.Messages.WithAsteriskIsRequired %>
            </div>
            <table class="EditeContentTable" width="100%">
                <tr>
                    <td class="Label1">设置类型：<em>*</em>
                    </td>
                    <td class="Field1">
                          <asp:RadioButton ID="radioItem" runat="server"  ClientIDMode="Static" GroupName="radioType" Checked="true" /> <span>产品</span> 
                <asp:RadioButton ID="radioProdOrder" runat="server"  ClientIDMode="Static" GroupName="radioType"  /> <span>工单</span>  
                    </td>
                </tr>                
                <tr id="trItem" runat="server" clientidmode="Static">
                    <td class="Label1">产品编码：<em>*</em>
                    </td>
                    <td class="Field1">
                        <asp:TextBox ID="txtMainItemCode" runat="server" CssClass="TextBox" Enabled="false"
                            IsRequired='1' ClientIDMode="Static"></asp:TextBox><input type="button" id="btnSelectItem"
                                class="ButtonBox" value="..." title="<%=Resources.lang.ChooseItem %>" onclick="ChoosePage(1);" />
                        <asp:HiddenField ID="hdnMainItemId" runat="server" Value="-1"  ClientIDMode="Static" />
                    </td>
                </tr>
                <tr id="trProdOrder" style="display:none;"  runat="server" clientidmode="Static">
                    <td class="Label1">工单号：<em>*</em>
                    </td>
                    <td class="Field1">
                        <asp:TextBox ID="txtProdOrder" runat="server" CssClass="TextBox" Enabled="false"
                              ClientIDMode="Static"></asp:TextBox><input type="button" id="btnSelectOrder"
                                class="ButtonBox" value="..." title="<%=Resources.lang.ChooseOrder %>" onclick="ChoosePage(44);" />
                        <asp:HiddenField ID="hdnProdOrderId" runat="server" Value="-1" ClientIDMode="Static" />
                    </td>
                </tr>
                <tr>
                    <td class="Label1">包装类型：<em>*</em>
                    </td>
                    <td class="Field1">
                        <asp:DropDownList ID="ddlType" runat="server" IsRequired='1'>
                            <asp:ListItem Value="" Text="--请选择--"> </asp:ListItem>
                            <asp:ListItem Value="Item" Text="Item"> </asp:ListItem>
                            <asp:ListItem Value="Box" Text="Box"> </asp:ListItem>
                            <asp:ListItem Value="Container" Text="Container"> </asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td class="Label1">重量最小值：<em>*</em>
                    </td>
                    <td class="Field1">
                        <asp:TextBox ID="txtMinQty" ClientIDMode="Static" runat="server" CssClass="TextBox" MaxLength="50" IsRequired='1'></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="Label1">重量最大值：<em>*</em>
                    </td>
                    <td class="Field1">
                        <asp:TextBox ID="txtMaxQty"  ClientIDMode="Static" runat="server" CssClass="TextBox" MaxLength="50" IsRequired='1' ></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="Label1">单位：<em>*</em>
                    </td>
                    <td class="Field1">
                        <select id="sltUnits" runat="server" clientidmode="Static" IsRequired="1">
                            <option value="">--请选择--</option>
                            <option value="g">克</option>
                            <option value="kg">千克</option>
                            <option value="lb">磅</option>
                        </select>                       
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <script type="text/javascript">
        var containerWeightId = '<%= Request.QueryString["ID"] %>';

        $().ready(function () {
            $("#txtMinQty,#txtMaxQty").keyup(function () {
                getDecimalVal(this);
            });

            $("#radioItem").click(function () {                
                $("#trItem").show();
                $("#trProdOrder").hide();
                $("#txtProdOrder").val("");
                $("#txtMainItemCode").attr("IsRequired", "1");
                $("#txtProdOrder").attr("IsRequired", "0");
                $("#hdnProdOrderId").val("-1");
            });

            $("#radioProdOrder").click(function () {
                $("#trProdOrder").show();
                $("#trItem").hide();
                $("#txtMainItemCode").attr("IsRequired", "0");
                $("#txtProdOrder").attr("IsRequired", "1");
            });
            
            if ($("#radioProdOrder").prop("checked")) {
                $("#radioProdOrder").click();
            }
        });
    
        function Save() {
            
            var txtMainItemCode = $("#<%=this.txtMainItemCode.ClientID%>").val();
            var txtMinQty = parseFloat($("#<%= this.txtMinQty.ClientID %>").val());
            var txtMaxQty = parseFloat($("#<%=this.txtMaxQty.ClientID %>").val());
            var txtUnits = $("#sltUnits").val();
            var ddlType = $("#<%=this.ddlType.ClientID %>").val();
            var txtType = 1;
            var txtProdOrderId = $("#hdnProdOrderId").val();
           if (txtMinQty > txtMaxQty) {
               alert("最小重量不能大于最大重量");
               return;
           }

           if ($("#radioProdOrder").prop("checked")) {
               txtType = 2;
              // txtMainItemCode = "";
           }
           else {
               txtProdOrderId = -1;
           }
           var entity = {};
           entity.ItemCode = txtMainItemCode;
           entity.ContainerWeightId = containerWeightId;
           entity.MinWeight = parseFloat(txtMinQty);
           entity.MaxWeight = parseFloat(txtMaxQty);
           entity.UnitId = txtUnits;
           entity.PackingType = ddlType;
           entity.TypeId = txtType;
           entity.ProdOrderId = txtProdOrderId;

           var ajax = SKT.LeanMES.Web.AjaxServices.AjaxContainerWeight.EditContainerWeight(entity);
           if (ajax.error != null) {
               alert(ajax.error.Message);
               return false;
           }
           alert('<%=Resources.Messages.SaveInSuccess%>')
            parent.window.Refresh();
        }

        /*选择产品*/
        function ChoosePage(flag) {
            chooseFlag = flag;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=" + flag + "&Multiple=false&rnd=" + Math.random(), width: 650, height: 320 });
        }
        /*选择单位*/
        function selectDictory() {
            chooseFlag = 2;
            var searchCondition = " DicProperty ='Unit' ";
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=3&PageCondition=" + searchCondition + "&Multiple=false&rnd=" + Math.random(), width: 650, height: 300 });
        }
        function getChooseValue(list) {
            if (chooseFlag == 1) {
                $("#<%=this.txtMainItemCode.ClientID %>").val(list[0][2]);
                $("#<%=this.hdnMainItemId.ClientID %>").val(list[0][0]);
                $("#txtProdOrder").val("");
                $("#hdnProdOrderId").val("-1");
            }
            else if (chooseFlag == 44) {
                $("#<%=this.txtProdOrder.ClientID %>").val(list[0][1]);
                $("#<%=this.hdnProdOrderId.ClientID %>").val(list[0][0]);
                $("#<%=this.txtMainItemCode.ClientID %>").val(list[0][2]);
            }
     }
    </script>
</asp:Content>
