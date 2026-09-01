    <%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditHeadMaster.master"
    AutoEventWireup="true" CodeBehind="ItemBomEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Product.ItemBomEdit" %>

<%@ MasterType VirtualPath="~/Masters/EditHeadMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="Tips" id="NotAllowModify" runat="server">
    </div>
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">
                <%= Resources.lang.ItemCode %><em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtItemCode" runat="server" CssClass="TextBox" IsRequired='1' ReadOnly="true"
                    ClientIDMode="Static"></asp:TextBox><input type="button" id="btnSelectItem" class="ButtonBox" value="..." title="Select"
                    onclick="openChoosePage(1);" />
                <asp:HiddenField ID="hdnItemId" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
            <td class="Label2">
                <%=Resources.lang.ItemsName %>
            </td>
            <td class="Field2">
                <asp:Label ID="lblItemName" runat="server" Text="" ClientIDMode="Static"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%=Resources.lang.Revision%><em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtVersion" runat="server" CssClass="NumericBox50" Text="1.0" IsRequired='1'
                    MaxLength='20' IsNumber='1' ClientIDMode="Static"></asp:TextBox>
                <asp:CheckBox ID="ckbIsCurrentRev" runat="server" Text="<%$Resources:lang,AsCurrentRevision %>"
                    Checked="true" ClientIDMode="Static" />
            </td>
            <td class="Label2">
                <%--  <%=Resources.lang.CurrentRevision %> --%>
                <%=Resources.lang.Status %>
            </td>
            <td class="Field2">
                <asp:DropDownList ID="ddlStatus" runat="server" ClientIDMode="Static">
                   <asp:ListItem Value="1" Text="<%$ Resources:lang,InUse %>"></asp:ListItem>
                    <asp:ListItem Value="0" Text="<%$ Resources:lang,OutOfService %>"></asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%=Resources.lang.Description %>
            </td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtBomDesc" runat="server" CssClass="TextArea" TextMode="MultiLine"
                    MaxLength='200' ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <div class="ListTableTitle">
        <%=Resources.lang.MaterialList%>&nbsp;<span id="bomCompList"></span></div>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" DataSourceID="ObjectDataSource1">
        <Columns>
            <%-- To Do --%>
            <%--<asp:BoundField DataField="ItemLevel" HeaderText="阶次" />--%>
            <asp:BoundField DataField="ItemCode" HeaderText="物料编码" />
            <asp:BoundField DataField="ItemName" HeaderText="物料描述" />
            <asp:BoundField DataField="Units" HeaderText="单位" />
          <%--  <asp:BoundField DataField="Qty" HeaderText="单位用量" />--%>
            <asp:TemplateField HeaderText="单位用量" SortExpression="Qty"  HeaderStyle-Width="80px">
                <ItemTemplate>
                    <%#Eval("Qty","{0:G0}").ToString() %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="UsePosition" HeaderText="使用位置" />
            <asp:TemplateField HeaderText="是否虚拟件">
                <ItemTemplate>
                    <%#Eval("IsFictitious").ToString().ToLower() == "true" ? "是" : "否"%>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Product.BLL.ItemBomChild"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <asp:HiddenField ID="hdnBomId" runat="server" Value="-1" />
    <asp:HiddenField ID="hdnHasCopy" runat="server" Value="-1" />
    <script type="text/javascript">
        loadfloatButtons("bomCompList");
        isMultiple = true;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");
        var isMESadd = "<%=IsMESadd %>";
        var isCopy = "<%=IsCopy %>";
        var bomName = "";
        var bomid = '<%=Request.QueryString["ID"] %>';
        //Add By Alma.Liu 201880930 
        function Import() {
            hdnOperate.val("ExportExcel");
            document.forms[0].submit();
            hdnOperate.val("");
        }

        $().ready(function () {
            if (isCopy != "") {
                document.oncontextmenu = function () {
                    event.cancelBubble = true;
                    event.returnValue = false;
                    return false;
                };
            }
            //if (bomid != "-1" && isCopy == "") {
            //    $("#btnSelectItem").attr("disabled", "disabled");
            //}
            if (isMESadd == "MES" && isCopy == "")
            {
                $("#btnSelectItem").attr("disabled", "disabled");
            }
        });
        function AddComponent() {
            //if (isMESadd == "ERP") {
            //    alert("ERP下载的产品BOM，不能编辑！")
            //    return false;
            //}
            var bomId = $("#<%=this.hdnBomId.ClientID %>").val();
            if (bomId == -1) {
                if (!saveData()) {
                    return false;
                }
            }
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Product/ItemBomComponentEdit.aspx?name=Product_BomMatAdd&ID=-1&BOMID=" + $("#<%=this.hdnBomId.ClientID %>").val();
            dialog({ title: "<%=Resources.Pages.Product_BomMatAdd %>", src: openWinUrl, width: 650, height: 350 });
        }

        function EditComponent() {
            //if (isMESadd == "ERP") {
            //    alert("ERP下载的产品BOM，不能编辑！")
            //    return false;
            //}
            var idStr = getOneRecordId();
            if (idStr == "") return false;

            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Product/ItemBomComponentEdit.aspx?name=Product_BomMatEdit&ID=" + idStr + "&BOMID=" + $("#<%=this.hdnBomId.ClientID %>").val();
            dialog({ title: "<%=Resources.Pages.Product_BomMatEdit %>", src: openWinUrl, width: 650, height: 350 });
        }

        function RemoveComponent() {
            //if (isMESadd == "ERP") {
            //    alert("ERP下载的产品BOM，不能编辑！")
            //    return false;
            //}
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }

        function Save() {
            //if (isMESadd == "ERP") {
            //    alert("ERP下载的产品BOM，不能编辑！")
            //    return false;
            //}
            if (isCopy == "Copy") {
                //复制
                hdnOperate.val("Copy");
            } else {
                //正常编辑保存
                if (!saveData()) {
                    return false;
                }
            }
            alert("<%=Resources.Messages.SaveInSuccess %>");
            document.forms[0].submit();
            parent.window.UpdateList(bomName);
        }
        /**
        *保存BOM主表信息，返回BOMId        
        **/
        function saveData() {
            var bomId = $("#<%=this.hdnBomId.ClientID %>").val();
            bomName = $("#txtItemCode").val() + "-" + $("#txtVersion").val();
            var txtItemName = $("#lblItemName").html();
            var txtItemCode = $("#txtItemCode").val();
            var itemId = $("#hdnItemId").val();
            var txtVersion = $("#<%=this.txtVersion.ClientID %>").val();
            var ddlStatus = $("#<%=this.ddlStatus.ClientID %>").val();
            var ckbIsCurrentRev = ($("#<%=this.ckbIsCurrentRev.ClientID%>").is(":checked"));
            var txtBomDesc = $("#<%=this.txtBomDesc.ClientID %>").val();

            if (isCopy != "") {
                if (txtVersion.indexOf("复制") > -1) {
                    if (confirm("当前版本号为复制版本,是否需要修改版本信息！\n 点击[确认]进行版本信息修改,点击[取消]保存产品BOM信息。")) {
                        $("#<%=this.txtVersion.ClientID %>").focus();
                        return false;
                    }
                }
            }
            if (txtItemCode == "" || txtVersion == "") {
                alert("带*号不可为空！");
                return false;
            }
            var entity = {};
            entity.OrganizationCode = "";
            entity.ItemBomId = bomId;
            entity.BomName = bomName;
            entity.ItemId = itemId;
            entity.ItemName = txtItemName;
            entity.ItemCode = txtItemCode;
            entity.Version = txtVersion;
            entity.State = ddlStatus;
            entity.Source = 3; //1、ERP下载 2、MES导入 3、MES创建
            entity.IsCurrentVer = ckbIsCurrentRev;
            entity.Description = txtBomDesc;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxProduct.ItemBomEdit(entity);

            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            $("#<%=this.hdnBomId.ClientID %>").val(ajax.value);
            return true;
        }

        function update(bomId) {
            $("#<%=this.hdnBomId.ClientID %>").val(bomId);
            document.forms[0].submit();
        }

        function openChoosePage(flags) {
            var condition = "";
            flag = flags;
            dialog({
                title: "<%= Resources.Common.ChooseWindow %>",
                src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=" +
                flags +
                "&Multiple=false&SearchCondition=" +
                condition +
                "&rnd=" +
                Math.random(),
                width: 650,
                height: 350
            });
        }

        function getChooseValue(list) {
            if (flag == 1) {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxProduct.IsItemBomExists(list[0][0]);
                if (ajax.value == 1) {
                    alert("物料Bom列表已存在该产品信息");
                    return;
                }
                $("#hdnItemId").val(list[0][0]);
                $("#txtItemCode").val(list[0][2]);
                $("#lblItemName").html(list[0][1]);
               
            }
        }

     
    </script>
</asp:Content>
