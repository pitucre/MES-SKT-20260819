<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="InspectionTemplateItemEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Quality.InspectionTemplateItemEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <div class="infoTips">
        <em>*</em><span>为必填项</span>
    </div>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">模板名称<em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtInspectionTemplateName" runat="server" CssClass="TextBox" IsRequired='1' Enabled="false"></asp:TextBox><input id="button1" class="ButtonBox" type="button" onclick="SelectInspectionTemplate()" value="..." title="选择模板" />
                <asp:HiddenField ID="hfInspectionTemplateId" runat="server" Value="-1" />
            </td>
        </tr>
        <tr style="display:none;">
            <td class="Label2">供应商
            </td>
            <td class="Field2">
                <input type="text" id="txtVendorCode" runat="server" class="TextBox" disabled="disabled" value="" /><input
                    type="button" id="btnSelectSupplier" class="ButtonBox" value="..." onclick="selectSupplier()" />
                <input type="hidden" value="" runat="server" id="hdnVendorCode" />
            </td>
        </tr>
        <tr>
            <td class="Label2">类型
            </td>
            <td class="Field2">
                <input id="rdoItem" name="Fruit" type="radio" runat="server" class="itp-type" value="1" checked="true" />
                <span>按产品</span>                
                <input id="rdoType" name="Fruit" type="radio" runat="server" class="itp-type" value="2" />
                <span>按产品类别</span>
            </td>
        </tr>
        <tr id="itemCode">
            <td class="Label2">
                <%=Resources.lang.ItemCode %><em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtItemCode" runat="server" CssClass="TextBox" Enabled="false" Text="ALL"></asp:TextBox><input id="button2" class="ButtonBox" type="button" onclick="SelectItem()" value="..." title="选择产品" />
                <asp:HiddenField ID="hfItemId" runat="server" Value="-1" />
            </td>
        </tr>
        <tr class="itemCode">
            <td class="Label2">大类
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtCategoryOne" runat="server" CssClass="TextBox" ReadOnly="true"
                    ClientIDMode="Static"></asp:TextBox><input type="button" id="btnSelectCategory" class="ButtonBox"
                        value="..." title="<%=Resources.lang.ChooseItem %>" onclick="selectCategory(1);" />
                <asp:HiddenField ID="HiddentxtCategoryOne" runat="server" Value="-1" />
            </td>
        </tr>
        <tr class="itemCode">
            <td class="Label2">中类
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtCategoryTwo" runat="server" CssClass="TextBox" ReadOnly="true"
                    ClientIDMode="Static"></asp:TextBox><input type="button" id="Button1" class="ButtonBox"
                        value="..." title="<%=Resources.lang.ChooseItem %>" onclick="selectCategory(2);" />
                <asp:HiddenField ID="HiddentxtCategoryTwo" runat="server" Value="-1" />
            </td>
        </tr>
        <tr class="itemCode">
            <td class="Label2">小类
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtCategoryThree" runat="server" CssClass="TextBox" ReadOnly="true"
                    ClientIDMode="Static"></asp:TextBox><input type="button" id="Button3" class="ButtonBox"
                        value="..." title="<%=Resources.lang.ChooseItem %>" onclick="selectCategory(3);" />
                <asp:HiddenField ID="HiddentxtCategoryThree" runat="server" Value="-1" />
            </td>
        </tr>
        <tr>
            <td class="Label2">检验水平<em>*</em>
            </td>
            <td class="Field2">
                <asp:DropDownList ID="ddlLotAudit" runat="server" />
            </td>
        </tr>
        <tr>
            <td class="Label2">AQL规则
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtAQLName" runat="server" CssClass="TextBox" Enabled="false" Text=""></asp:TextBox><input id="button3" class="ButtonBox" type="button" onclick="SelectAQL()" value="..." title="选择AQL" />
                <asp:HiddenField ID="hfAQLId" runat="server" Value="-1" />
            </td>
        </tr>
        <tr style="display: none;">
            <td class="Label2">
                <%=Resources.lang.AqlName %>
            </td>
            <td class="Field2">
                <asp:DropDownList ID="ddlAQLSampleName" runat="server">
                </asp:DropDownList>
            </td>
        </tr>
    </table>
    <script type="text/javascript" src="../Content/js/jquery-3.1.0.min.js"></script>
    <script type="text/javascript">
        var Flag = 1;
        var txtCategoryOne = "";
        var txtCategoryTwo = "";
        var txtCategoryThree = "";
        $(function () {
            //$("tr[class='itemCode']").css("display", "none");
            var val = $("input[type='radio'].itp-type:checked").val();
            changeType(val);
        });

        $("input[type='radio'].itp-type").on("change", function () {
            var val = $(this).val();
            changeType(val);
        });

        function changeType(val) {
            if (val == 1) {
                $("#itemCode").css("display", "");
                $("tr[class='itemCode']").css("display", "none");
                if (($("#<%=this.hfItemId.ClientID%>").val() == "-1" || $("#<%=this.hfItemId.ClientID%>").val() == "") && $("#<%=this.txtItemCode.ClientID%>").val() == "") {
                    $("#<%=this.hfItemId.ClientID%>").val("-1");
                    $("#<%=this.txtItemCode.ClientID%>").val("ALL");
                }
                Flag = 1;
            } else {
                Flag = 2;

                $("#itemCode").css("display", "none");
                $("tr[class='itemCode']").css("display", "");
            }
        }

        var id = '<%=Request.QueryString["ID"] %>';


        function Save() {

            var en = {};
            if (Flag == 1) {
                if ($("#<%=this.hfItemId.ClientID%>").val() == "" || $("#<%=this.txtItemCode.ClientID%>").val() == "") {
                    alert("请选择产品");
                    return false;
                }
                txtCategoryOne = "";
                txtCategoryTwo = "";
                txtCategoryThree = "";
            } else {
                txtCategoryOne = $("#<%=this.HiddentxtCategoryOne.ClientID%>").val();
                txtCategoryTwo = $("#<%=this.HiddentxtCategoryTwo.ClientID%>").val();
                txtCategoryThree = $("#<%=this.HiddentxtCategoryThree.ClientID%>").val();
                if (txtCategoryOne == "-1") {
                    txtCategoryOne = "";
                }
                if (txtCategoryTwo == "-1") {
                    txtCategoryTwo = "";
                }
                if (txtCategoryThree == "-1") {
                    txtCategoryThree = "";
                }
                if (txtCategoryOne == "" && txtCategoryTwo == "" && txtCategoryThree == "") {
                    alert("请选择产品类别");
                    return false;
                }
            }
            en.InspectionTemplateItemId = id;
            en.InspectionTemplateId = $("#<%=this.hfInspectionTemplateId.ClientID%>").val();
            //en.ItemId = $("#<%=this.hfItemId.ClientID%>").val();
            Flag == 1 ? en.ItemId = $("#<%=this.hfItemId.ClientID%>").val() : en.ItemId = "";
            en.AQLRuleId = $("#<%=this.hfAQLId.ClientID%>").val();
            en.CreateBy = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
            en.ModifyBy = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
            en.Remark = "";
            en.LotAudit = $("#<%=this.ddlLotAudit.ClientID%>").val();
            en.VendorCode = $("#<%=this.hdnVendorCode.ClientID%>").val();
            en.AQLSampleId = $("#<%=this.ddlAQLSampleName.ClientID%>").val();
            /*
            en.CategoryOne = "";
            en.CategoryTwo = "";
            en.CategoryThree = "";            
            if (Flag == 2 && txtCategoryThree != "") {
                en.CategoryThree = txtCategoryThree;
            } else if (Flag == 2 && txtCategoryTwo != "" && txtCategoryThree == "") {
                en.CategoryTwo = txtCategoryTwo;
            } else if (Flag == 2 && txtCategoryOne != "" && txtCategoryTwo == "") {
                en.CategoryOne = txtCategoryOne;
            }
            */
            en.CategoryThree = txtCategoryThree;
            en.CategoryTwo = txtCategoryTwo;
            en.CategoryOne = txtCategoryOne;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxQuality.InspectionTemplateItemEdit(JSON.stringify(en));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert('<%=Resources.Messages.SaveInSuccess %>');
            parent.window.UpdateList("");
        }

        var chooseFlagCategory = 0;
        function selectCategory(flag) {
            chooseFlagCategory = flag;
            var pageCondition = "";
            var parentId = -1;

            if (flag == 1) {
                pageCondition = "ParentId = -1";
            }
            else if (flag == 2) {
                parentName = $("#txtCategoryOne").val();
                if (parentName == "") {
                    alert("请先选择产品大类！");
                    return false;
                }
                pageCondition = "ParentName='" + parentName + "'";

            }
            else if (flag == 3) {
                parentName = $("#txtCategoryTwo").val();
                if (parentName == "") {
                    alert("请先选择产品中类！");
                    return false;
                }
                pageCondition = "ParentName='" + parentName + "'";
            }
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=110&CallBackFunc=getCategoryValue&PageCondition=" + escape(pageCondition) + "&Multiple=false&rnd=" + Math.random(), width: 550, height: 280 });
        }

        function SelectInspectionTemplate() {
            dialog({
                title: "<%=Resources.Common.ChooseWindow %>",
                src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=75&CallBackFunc=getChooseValueInspectionTemplate&Multiple=false&rnd=" + Math.random(), width: 680, height: 400
            });
        }

        function getChooseValueInspectionTemplate(list) {
            $("#<%=this.hfInspectionTemplateId.ClientID%>").val(list[0][0]);
            $("#<%=this.txtInspectionTemplateName.ClientID%>").val(list[0][1]);
        }

        function SelectItem() {
            dialog({
                title: "<%=Resources.Common.ChooseWindow %>",
                src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=1&CallBackFunc=getChooseValueItemCode&Multiple=false&rnd=" + Math.random(), width: 680, height: 400
            });
        }
        function getCategoryValue(list) {
            if (chooseFlagCategory == 1) {
                txtCategoryOne = list[0][1];
                $("#<%=this.HiddentxtCategoryOne.ClientID%>").val(list[0][1]);
                $("#txtCategoryOne").val(list[0][2]);
                $("#txtCategoryTwo").val("");
                $("#txtCategoryThree").val("");
            }
            else if (chooseFlagCategory == 2) {
                txtCategoryTwo = list[0][1];
                $("#<%=this.HiddentxtCategoryTwo.ClientID%>").val(list[0][1]);
                $("#txtCategoryTwo").val(list[0][2]);
                $("#txtCategoryThree").val("");
            }
            else if (chooseFlagCategory == 3) {
                txtCategoryThree = list[0][1];
                $("#<%=this.HiddentxtCategoryThree.ClientID%>").val(list[0][1]);
                $("#txtCategoryThree").val(list[0][2]);
            }
}

function getChooseValueItemCode(list) {
    $("#<%=this.hfItemId.ClientID%>").val(list[0][0]);
            if (list[0][0] > 0) {
                $("#<%=this.txtItemCode.ClientID%>").val(list[0][2]);
            }
            else {
                $("#<%=this.txtItemCode.ClientID%>").val("ALL");
            }
        }


        function SelectAQL() {
            dialog({
                title: "<%=Resources.Common.ChooseWindow %>",
                src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=76&CallBackFunc=getChooseValueAQLlist&Multiple=false&rnd=" + Math.random(), width: 680, height: 400
            });
        }

        function getChooseValueAQLlist(list) {
            $("#<%=this.hfAQLId.ClientID%>").val(list[0][0]);
            if (list[0][0] != "-1") {
                $("#<%=this.txtAQLName.ClientID%>").val(list[0][1] + '[' + list[0][2] + ']');
            }
            else {
                $("#<%=this.txtAQLName.ClientID%>").val("");
            }
        }

        function selectSupplier() {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=34&CallBackFunc=getSupplier&Multiple=false&rnd=" + Math.random(), width: 680, height: 300 });
        }

        function getSupplier(list) {
            if (list[0][0] == "-1") {
                $("#<%=this.hdnVendorCode.ClientID%>,#<%=this.txtVendorCode.ClientID%>").val("");
                return false;
            }

            $("#<%=this.txtVendorCode.ClientID%>").val("[" + list[0][1] + "]" + list[0][2]);
            vendorCode = list[0][1];
            $("#<%=this.hdnVendorCode.ClientID%>").val(vendorCode);
        }
    </script>
</asp:Content>
