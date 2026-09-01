<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SetDataSource.aspx.cs" Inherits="SKT.LeanMES.Web.SDP.SetDataSource" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head id="Head1" runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=8" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/jquery.min.js" type="text/javascript"></script>
    <link href="../Content/Main.css" rel="stylesheet" type="text/css" />

    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.entertotab.min.js"
        type="text/javascript"></script>
    <link href="../Content/plugin/tabs/tabs.css" rel="stylesheet" type="text/css" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/tabs/jPlugin-tabs.js" type="text/javascript" id="masterJsTab"></script>
    <style type="text/css">
     .dlg-nc>.nebutton>.close{width:46px; height:19px; cursor:pointer; position:absolute; top:-1px; right:0px; background-position:-14px 0;}
     </style>
    <title>
        <%=Resources.Common.SetDataSource %></title>
</head>
<body>
    <form id="form1" runat="server">
    <div id="divListPageHeader">
        <table border="0" width="100%">
            <tr>
                <td align="right" width="40px">
                    <asp:Label ID="lblSource" runat="server" Text='数据源'></asp:Label>
                </td>
                <td>
                    <asp:DropDownList ID="ddlDataSource" runat="server" ClientIDMode="Static" onChange="SetSourceData()">
                    </asp:DropDownList>
                </td>
                <td>
                    <input id="btnCallback" type="button" class="button" value="保存" style="width:50px;margin-right:20px" onclick="callbackReturn()" /><input id="btnCancel" type="button" style="width:50px" class="button" value="取消" onclick="closeWindow()" />
                </td>
            </tr>
        </table>
    </div>
    <div class="ContentContainer">
        <div class="infoTips">
            数据源信息
        </div>
        <table class="EditeContentTable" width="100%">
            <tr>
                <td class="Label2">
                    <label id="datasourceName">数据源名称</label>
                </td>
                <td class="Field2">
                    <label id="datasourceNameText"></label>
                </td>
                <td class="Label2">
                    <label id="Label1">数据源类别</label>
                </td>
                <td class="Field2">
                    <label id="datasourceTypeText"></label>
                </td>
            </tr>
            <tr>
                <td class="Label2">
                    <label id="Label2">数据源描述</label>
                </td>
                <td class="Field2" colspan="3">
                    <label id="datasourceDescText"></label>
                </td>
            </tr>
            <tr>
                <td class="Label2">
                    <label id="Label3">输出列</label>
                </td>
                <td class="Field2" colspan="3">
                    <label id="tabColumn"></label>
                    <input id="hdSql" type="hidden" />
                </td>
            </tr>
        </table>
        <div class="infoTips">
            数据源参数
        </div>
        <table class="ListTable" width="100%" id="tbParamters">
            
        </table>
        <div style="display:none" id="modelHtml"></div>
        <asp:HiddenField ID="hdnContent" runat="server" />
        <asp:HiddenField ID="hdnSourceType" runat="server" />
    </div>
    </form>
    <script type="text/javascript">
        var controlEntitys = [];
        $(document).ready(function () {
            controlEntitys = window.parent.GetmodelControl();

            SetSourceData();
        });

        function SetSourceData() {
            var obj = document.getElementById("ddlDataSource");
            var dropdowm = obj.options[obj.selectedIndex].value;
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSDP.GetSourceBySourceId(dropdowm);

            if (ajax.error != null) {
                alert(ajax.error.Message)
                return false;
            }
            var model = ajax.value;

            $("#datasourceNameText").text(model.DataSourceName);
            $("#datasourceTypeText").text(model.DataSourceType);
            $("#datasourceDescText").text(model.DataSourceDesc);
            $("#tabColumn").text(model.TabColumn);
            $("#hdSql").val(model.SQLInfo);

            var paramters = model.Paramters.split(",");
            var options = "<option value=''>请选择</option>";
            for (var k = 0; k < controlEntitys.length; k++) {
                if (controlEntitys[k].uictrltype == '<%= SKT.LeanMES.SDP.Model.ControlType.text.ToString() %>'
                    || controlEntitys[k].uictrltype == '<%= SKT.LeanMES.SDP.Model.ControlType.textarea.ToString() %>'
                    || controlEntitys[k].uictrltype == '<%= SKT.LeanMES.SDP.Model.ControlType.select.ToString() %>') {
                    options += "<option value='" + controlEntitys[k].id + "'>" + controlEntitys[k].title + "(" + controlEntitys[k].uictrltype + ")" + "</option>";
                }
            }

            var commonOptions = "<option value=''>请选择</option>";
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSDP.GetDefualtParamters();
            if (ajax.error != null) {
                alert(ajax.error.Message)
                return false;
            }
            var defualtparamters = ajax.value;
            var tempParamter = $(defualtparamters).find("defualt");
            for (i = 0; i < tempParamter.length; i++) {                    
                commonOptions += "<option value='" + $(tempParamter[i]).attr("Value") + "'>" + $(tempParamter[i]).attr("Text") + "</option>";
            }

            var html = "<tr  class=\"ListTableHeader\"><th>参数</th><th>控件</th><th>内置通用值</th><th>默认值</th></tr>";
            for (var i = 0; i < paramters.length; i++) {
                if ($.trim(paramters[i]) != "") {
                    html += "<tr class='ListTableOddRow'>";
                    html += "<td style='width:30%'>" + paramters[i] + "</td>";
                    html += "<td><select name='ControlId'>";
                    html += options;
                    html += "</select></td>";
                    html += "<td><select name='CommonValue' style='width:100px'>";
                    html += commonOptions;
                    html += "</select></td>";
                    html += "<td><input name='paramValue' type='text' style='width:100px;' /></td></tr>";
                }
            }
            $("#tbParamters").html(html);
        }

        function callbackReturn() {
            var source = new Object();
            var obj = document.getElementById("ddlDataSource");
            source.datasourceId = obj.options[obj.selectedIndex].value;
            source.tabColumn = $("#tabColumn").text();
            source.sourceName = $("#datasourceNameText").text();
            source.sqlinfo = $("#hdSql").val();
            
            var isParamterHaveValue = true;
            var paramters = [];
            $("#tbParamters tr").each(function () {
                if ($.trim($(this).children(0)[0].innerText) != "参数") {
                    var paramter = new Object();
                    paramter.ParamterName = $.trim($(this).find("td")[0].innerText);
                    paramter.ControlId = $(this).find("td select[name='ControlId']")[0].options[$(this).find("td select[name='ControlId']")[0].selectedIndex].value;
                    paramter.ParamterValue = $(this).find("td select[name='CommonValue']")[0].options[$(this).find("td select[name='CommonValue']")[0].selectedIndex].value;
                    if (paramter.ParamterValue == "") {
                        paramter.ParamterValue = $(this).find("td input").val();
                    }
                    
                    if (paramter.ControlId == "" && paramter.ParamterValue == "") {
                        isParamterHaveValue = false;
                    }
                    paramters.push(paramter);
                }
            });
            if (!isParamterHaveValue) {
                alert("请给每个参数都选择对应的控件或者赋默认值");
                return;
            }

            //callBack
            try {
                if ($("#hdnSourceType").val() == "table") {
                    window.parent.SetSource1(source, paramters);
                }
                else {
                    window.parent.SetSource2(source, paramters);
                }
            }
            catch (err) {
            }

            //close window
            closeWindow();
        }

        function closeWindow() {
            try {
                window.parent.closeDialog();
                window.parent.document.focus();
            }
            catch (ex) {

            }
        }        
    </script>
</body>
</html>
