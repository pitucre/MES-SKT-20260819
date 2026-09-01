<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="AQLRuleEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Quality.AQLRuleEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
<div class="infoTips">
                带<em>*</em>为必填项</div>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">
                <%=Resources.lang.RuleName%><em>*</em>
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtRuleName" runat="server" CssClass="TextBox" IsRequired="1"></asp:TextBox>
            </td>
            <td class="Label3">
                <%=Resources.lang.RuleTypeName%>
            </td>
            <td class="Field3">
                <asp:DropDownList ID="ddlRuleType" runat="server">
                </asp:DropDownList>
            </td>
            <td class="Label3">
                描述
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtRemark" runat="server"></asp:TextBox>
            </td>
        </tr>
    </table>
    <table id="tblExpand" cellspacing="0" cellpadding="4" style="border-width: 0px; width: 100%;
        border-collapse: collapse; margin-top: 5px;" class="EditeContentTable">
        <tr class="ListTableHeader">
            <%--<th scope="col" style="width:10%;">
            最大值
        </th>--%>
            <th scope="col" style="width: 10%;">
                抽检索引字母
            </th>
            <th scope="col" style="width: 35%;">
                抽检样本数<em>*</em>
            </th>
            <%--<th scope="col"  style="width:7%;">
             百分比
        </th>--%>
            <th scope="col" style="width: 20%;">
                AC<em>*</em>
            </th>
            <th scope="col" style="width: 35%;">
                RE<em>*</em>
            </th>
            <%--<th scope="col" onclick="addDetail(null);"  style="color:#0066CC;cursor:pointer; width:5%;">
            + 添加行
        </th>--%>
        </tr>
        <tr id="trNewInfo" class="ListTableOddRow">
            <td colspan="6" style="text-align: center;">
                <%=Resources.Messages.HaveNothingData%>
            </td>
        </tr>
    </table>
    <script language="javascript" type="text/javascript">
        var AQLRuleId = '<%=Request.QueryString["ID"] %>';
        var name = '<%=Request.QueryString["name"] %>';
        var tab = document.getElementById("tblExpand");
        var rowObj = null;
        var rowIndex = 0;

        $(document).ready(
            function () {
                if (AQLRuleId > 0) {
                    inti();
                }
                else {
                    LoadInit();
                }

                if (name == "AQLRuleCopy") {
                    AQLRuleId = -1;
                    $("#<%=this.txtRuleName.ClientID %>").val("");
                }
            }
            );

        /*保存数据*/
        function Save() {

            var entity = {};
            entity.AQLRuleId = AQLRuleId;
            entity.RuleName = $("#<%=this.txtRuleName.ClientID %>").val();
            entity.RuleDescription = $("#<%=this.txtRemark.ClientID %>").val();
            entity.AQLRuleTypeId = $("#<%=this.ddlRuleType.ClientID %>").val();
            entity.Remark = $("#<%=this.txtRemark.ClientID %>").val();
            entity.CreaterBy = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
            entity.ModifyBy = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";

            var length = $(".hdALQRuleMemberId").length;

            var params = [], param = {};
            for (var i = 0; i < length; i++) {
                param = {}
                param.ALQRuleMemberId = $($(".hdALQRuleMemberId")[i]).val()
                param.LotLetter = $($(".LotLetter")[i]).val()
                param.SamplingValue = $($(".SamplingValue")[i]).val()
                param.ACValue = $($(".ACValue")[i]).val();
                param.REValue = $($(".REValue")[i]).val();
                param.CreateBy = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
                //                    if (parseInt(param.SamplingValue) < parseInt(param.REValue) || parseInt(param.SamplingValue) < parseInt(param.ACValue)) {
                //                        alert("第" + (i + 1) + "行，AC值和ER值不能大于样本数量！");
                //                        return;
                //                    }

                //                    if (parseInt(param.ACValue) >= parseInt(param.REValue)) {
                //                        alert("第" + (i + 1) + "行，AC值须小于ER值！");
                //                        return;
                //                    }
                params.push(param);
            }

            
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxQuality.AQLRuleEdit(entity, params);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert('<%=Resources.Messages.SaveInSuccess %>');
            parent.window.UpdateList("");
        }

        function addDetail(entity, LotLetter) {
            if (entity == null) {
                entity = {};
                entity.ALQRuleMemberId = -1;
                entity.MinValue = "";
                entity.MaxValue = "";
                entity.SamplingValue = "";
                entity.ACValue = "";
                entity.REValue = "";
                entity.IsPercent = 0;
                entity.LotLetter = "";
            }

            if (entity.LotLetter != "") {
                LotLetter = entity.LotLetter;
            }


            $("#trNewInfo").remove();
            var row, cell;
            rowNewIdx = tab.rows.length;
            row = tab.insertRow(rowNewIdx);
            row.className = "ListTableOddRow";

            cell = row.insertCell(0);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = " <input type=\"hidden\" class=\"hdALQRuleMemberId\" value=\"" + entity.ALQRuleMemberId + "\" />"
                                 + " <input type=\"hidden\" class=\"LotLetter\" value=\"" + LotLetter + "\" />"
                                 + LotLetter;

            cell = row.insertCell(1);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<input type=\"text\"  IsNumber='1' IsRequired='1' style=\" width:90%;\" class=\"SamplingValue\" MaxLength='10' value=\"" + entity.SamplingValue + "\"  />"

            cell = row.insertCell(2);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<input type=\"text\"  IsNumber='1' IsRequired='1' MinValue='0' onkeyup='getIntVal(this)' MaxLength='10' style=\" width:90%;\" class=\"ACValue\" value=\"" + entity.ACValue + "\"  />"

            cell = row.insertCell(3);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<input type=\"text\"  IsNumber='1' IsRequired='1' onkeyup='getIntVal(this)' MaxLength='10' MinValue='1' style=\" width:90%;\" class=\"REValue\" value=\"" + entity.REValue + "\"  />"


        }
        

        function deleteItem(obj) {
            if (typeof (obj) == "number") {
                tab.deleteRow(rowIndex);
            }
            else {
                tab.deleteRow(obj.parentElement.parentElement.rowIndex);
            }
        }

        function inti() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxQuality.GetAQLRuleMemberList(AQLRuleId);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var list = ajax.value;
            for (var i = 0; i < list.length; i++) {
                addDetail(list[i]);
            }
            if (list.length <= 0) {
                LoadInit();
            }
        }
 
        function LoadInit() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxDictionary.GetAQLLotAuditList();
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var list = ajax.value;
            for (var i = 0; i < list.length; i++) {
                addDetail(null, list[i].Value);
            }
        }
    </script>
</asp:Content>
