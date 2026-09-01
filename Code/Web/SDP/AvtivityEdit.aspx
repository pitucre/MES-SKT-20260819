<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AvtivityEdit.aspx.cs" Inherits="SKT.LeanMES.Web.SDP.AvtivityEdit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=8" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/jquery.min.js" type="text/javascript"></script>
    <link href="../Content/Main.css" rel="stylesheet" type="text/css" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.entertotab.min.js"
        type="text/javascript"></script>
    <link href="../Content/plugin/tabs/tabs.css" rel="stylesheet" type="text/css" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/tabs/jPlugin-tabs.js"
        type="text/javascript" id="masterJsTab"></script>
    <style type="text/css">
        .dlg-nc > .nebutton > .close
        {
            width: 46px;
            height: 19px;
            cursor: pointer;
            position: absolute;
            top: -1px;
            right: 0px;
            background-position: -14px 0;
        }
    </style>
    <title>
        <%=Resources.Common.SetDataSource %></title>
</head>
<%@ Register src="ControlFuntion/CommonControl.ascx" tagname="CommonC" tagprefix="uc1" %>
<body>
    <form id="form1" runat="server">
    <div>
        <table class="EditeContentTable" width="100%">            
            <tr>
                <td class="Label2" style="width:100px;min-width:100px">
                    控件名称
                </td>
                <td class="Field2">
                    <asp:Label ID="lblControlName" runat="server" Text=""></asp:Label>
                </td>
                <td class="Label2" style="width:100px;min-width:100px">
                    控件事件<span style="color:Red">*</span>
                </td>
                <td class="Field2">
                    <asp:Label ID="lblActivity" runat="server" Text=""></asp:Label>
                </td>
            </tr>
            <tr>                
                <td class="Label2" style="width:100px;min-width:100px">
                    步骤方法<span style="color:Red">*</span>
                </td>
                <td class="Field2">
                    <asp:DropDownList ID="ddlFunction" runat="server" AutoPostBack="true" Style="min-width: 150px"
                        onselectedindexchanged="ddlFunction_SelectedIndexChanged">
                    </asp:DropDownList>
                </td>
                <td class="Label2" style="width:100px;min-width:100px">
                    步骤名称
                </td>
                <td class="Field2">
                    <input id="txtStepName" type="text" class="TextBox" />
                </td>
            </tr>            
            <tr>
                <td colspan="4" id="tbUserControl" runat="server" style="width:100%">
                
                </td>
            </tr>  
            <tr>
                <td align="center" colspan="4" style="padding:2px 0px 2px 0px">
                    <input id="btnCallback" type="button" class="button" value="保存" style="width:50px;margin-right:10px" onclick="callbackReturn()" /><input id="btnCancel" type="button" style="width:50px" class="button" value="取消" onclick="closeWindow()" />
                </td>
            </tr>          
        </table>
        <asp:HiddenField ID="hdnControlTypes" runat="server" />
    </div>
    </form>
    <script type="text/javascript">
        function closeWindow() {
            try {
                window.parent.closeDialog();
                window.parent.document.focus();
            }
            catch (ex) {

            }
        }

        function isControlTypeInArray(siglecontrolType) {
            if ($("#hdnControlTypes").val() != "") {
                var controltype = $("#hdnControlTypes").val().split(",");
                if ($.inArray(siglecontrolType, controltype) == -1) {
                    return false;
                }
                else {
                    return true;
                }
            }
            else {
                return true;
            }
        }

        function callbackReturn() {
            if ($.trim(document.getElementById("txtStepName").value) == "") {
                alert("步骤名称不能为空");
                return;
            }
            if (!checkValue()) {
                return;
            }

            var stepInfo = new Object();
            stepInfo.DataSourceControlId = GetControl("ID");
            stepInfo.DataSourceControl = GetControl("NAME");

            stepInfo.DataSourceId = GetSource("ID");
            stepInfo.DataSource = GetSource("NAME");

            stepInfo.StepName = document.getElementById("txtStepName").value;
            stepInfo.StepType = document.getElementById("ddlFunction").options[document.getElementById("ddlFunction").selectedIndex].value;
            stepInfo.StepXml = GetStepXml();
            
            window.parent.SetStepInfo(stepInfo);
        }
    </script>
</body>
</html>
