<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="MenuButtonEdit.aspx.cs" Inherits="SKT.LeanMES.Web.SystemConfiguration.MenuButtonEdit" %>


<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <table id="tblExpand" cellspacing="0" cellpadding="5" style="border-width: 0px; width: 100%; border-collapse: collapse; margin-top: 5px;"
        class="EditeContentTable">
        <tr class="ListTableHeader">
            <th scope="col">名称</th>
            <th scope="col">图标</th>
            <th scope="col">序号</th>
            <th scope="col">模板名称</th>
            <th scope="col">权限存储过程名</th>
            <th scope="col">执行存储过程名</th>
            <th scope="col">权限编号</th>
            <th scope="col" onclick="AddDtl();" id='btnAdd' style="color: #0066CC; cursor: pointer; width: 100px;">+新增</th>
        </tr>
        <tr id="trNewInfo" class="ListTableOddRow">
            <td colspan="10" style="text-align: center;">
                <%=Resources.Messages.HaveNothingData%>
            </td>
        </tr>
    </table>

    <script type="text/javascript">
        function loadtabledata() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxClientConfig.GetMenuBotton('<%=Request.QueryString["page"]%>');
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var obj = $("#tblExpand");
            $("tr[name='trdata']").remove();
            for (var i = 0; i < ajax.value.length; i++) {
                AppendTr(ajax.value[i], obj);
            }

        }
        $(loadtabledata);
        function DeleteDtl(node) {
            var tr = $(node).parent().parent();
            if (tr.find("input[name='Popedom']").val() != "0") {
                if (!window.confirm("保存后会将存储过程删除,确定要删除码？"))
                    return;
            }
            tr.remove();
        }
        var selectnode = null;
        function selectTemplate(node) {
            selectnode = node;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=815&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }

        function getChooseValue(list) {
            if (!selectnode)
                return;
            $(selectnode).val(list[0][2]);
            $(selectnode).siblings("input[name='TempId']").val(list[0][1]);
        }
        function AppendTr(entity, tab) {
            $("#trNewInfo").remove();
            $("<tr class='ListTableOddRow' name='trdata'>"
                + "<td class='Field'><input type=\"text\" name=\"Text\" value=\"" + entity.Text + "\"  style=\"width:60px;\" /></td>"
                + "<td class='Field'><input type=\"text\" name=\"Icon\" value=\"" + entity.Icon + "\" style=\"width:50px;\" /></td>"
                + "<td class='Field'><input type=\"text\" name=\"Sequence\" value=\"" + entity.Sequence + "\" style=\"width:50px;\" /></td>"
                + "<td class='Field'><input type=\"text\" name=\"TempName\" onclick=\"selectTemplate(this)\" readonly=\"readonly\" value=\"" + entity.TempName + "\" style=\"width:100px;\" /><input type=\"hidden\" name=\"TempId\" value=\"" + entity.TempId + "\"/></td>"
                + "<td class='Field'><input type=\"text\" disabled=\"disabled\" name=\"ControlProc\" value=\"" + entity.ControlProc + "\" style=\"width:100px;\" /></td>"
                + "<td class='Field'><input type=\"text\" disabled=\"disabled\" name=\"Handler\" value=\"" + entity.Handler + "\" style=\"width:100px;\" /></td>"
                + "<td class='Field'><input type=\"text\" disabled=\"disabled\" name=\"Popedom\" maxlength='9' value=\"" + entity.Popedom + "\" style=\"width:60px;\" /></td>"
                + "<td class='Field'><span style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"DeleteDtl(this)\"><%= Resources.Buttons.COM_Delete %></span></td></tr>").appendTo(tab);
            }
            function AddDtl() {
                AppendTr({
                    Text: "按钮",
                    Icon: "save",
                    Handler: "",
                    ControlProc: "",
                    Popedom: 0,
                    TempId: "",
                    TempName: "",
                    Sequence: $("#tblExpand tr[name='trdata']").length + 20
                }, $("#tblExpand"));
            }
            /*保存数据*/
            function Save() {
                var array = [];
                $("#tblExpand tr[name='trdata']").each(function () {
                    var trdata = {};
                    $(this).find("input[name]").each(function () {
                        trdata[$(this).attr("name")] = $(this).val();
                    });
                    array.push(trdata);
                });
                var xml = "";
                for (var i = 0; i < array.length; i++) {
                    if (!array[i].Text) {
                        alert("请输入按钮名称");
                        return;
                    }
                    if (array[i].TempId != "" && !/^\d+$/.test(array[i].TempId)) {
                        alert("模板编号输入不正确");
                        return;
                    }
                    if (!array[i].Icon)
                        array[i].Icon = "save";
                    array[i].Popedom = parseInt(array[i].Popedom);
                    array[i].Sequence = parseInt(array[i].Sequence);
                    xml += "<en>";
                    for (var field in array[i]) {
                        xml += "<" + field + ">" + array[i][field] + "</" + field + ">";
                    }
                    xml += "</en>";
                }
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxClientConfig.SaveMenuBotton(xml, '<%=Request.QueryString["module"]%>', '<%=Request.QueryString["page"]%>', '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>');
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                //保存后一定要刷新下，因为很多字段是数据库赋值的
                loadtabledata();
                alert('<%=Resources.Messages.SaveInSuccess%>');
                //parent.window.Refresh();
        }
    </script>
</asp:Content>
