<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PrintControl.ascx.cs" Inherits="SKT.LeanMES.Web.SDP.ControlFuntion.PrintControl" %>
<script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/jquery.min.js" type="text/javascript"></script>
<div>
    <table border="0" width="100%">
        <tr>
            <td  class="Label2" style="width:100px;min-width:100px">
                <%= Resources.lang.RuleType %><em>*</em>
            </td>
            <td class="Field2">
                <asp:DropDownList ID="ddlType" runat="server" >
                </asp:DropDownList>
            </td>  
            <td class="Label2" style="width:100px;min-width:100px">
                取值控件<span style="color:Red">*</span>
            </td>
            <td class="Field2">
                <select id="ddlControl" name='ControlId' style="min-width: 150px;width:150px;">
                </select> 
            </td>
        </tr>
    </table>

    <script type="text/javascript">
        /*****************************公共方法***********************************/
        var controlEntitys = [];
        $(document).ready(function () {
            controlEntitys = window.parent.GetmodelControl(); 
            BindControl();
        });

        function BindControl() {
            var controls = document.getElementById("ddlControl");

            controls.options.add(new Option("请选择", ""));

            for (var k = 0; k < controlEntitys.length; k++) {
                if (isControlTypeInArray(controlEntitys[k].uictrltype)) {
                    controls.options.add(new Option(controlEntitys[k].title + "(" + controlEntitys[k].uictrltype + ")", controlEntitys[k].id));
                }
            }
        }

        function GetControl(type) {
            var control = document.getElementById("ddlControl");
            if (type == "ID") {
                return control.options[control.selectedIndex].value;
            }
            else {
                return control.options[control.selectedIndex].text;
            }
        }

        function GetSource(type) {
            return "";
        }

        function GetStepXml() {
            var returnXml = "";
            var ddlType = document.getElementById('<%=ddlType.ClientID %>');
//            var ddlDoc = document.getElementById('<=ddlDoc.ClientID >');

            var ruleType = ddlType.options[ddlType.selectedIndex].value;
            if (ruleType != "") {
                returnXml += "<ruleType>" + ruleType + "</ruleType>";
            }

//            var ddlDoc = ddlDoc.options[ddlDoc.selectedIndex].value;
//            if (ddlDoc != "") {
//                returnXml += "<doc>" + ddlDoc + "</doc>";
//            }

            var ddlControl = document.getElementById("ddlControl");
            var control = ddlControl.options[ddlControl.selectedIndex].value;
            if (control != "") {
                returnXml += "<control>" + control + "</control>";
            }

            returnXml = "<stepxml>" + returnXml + "</stepxml>";
            return returnXml;
        }

        function checkValue() {
            var returnCheck = true;
            var ddlType = document.getElementById('<%=ddlType.ClientID %>');
            if ("" == ddlType.options[ddlType.selectedIndex].value) {
                alert("请选择规则类型!");
                returnCheck = false;
            }

//            var ddlDoc = document.getElementById('<=ddlDoc.ClientID >');
//            if ("" == ddlDoc.options[ddlDoc.selectedIndex].value) {
//                alert("请选择文档!");
//                returnCheck = false;
//            }

            var ddlControl = document.getElementById("ddlControl");
            if (ddlControl.selectedIndex != -1 && "" == ddlControl.options[ddlControl.selectedIndex].value) {
                alert("请选择取值控件!");
                returnCheck = false;
            }
            return returnCheck;
        }
    </script>
</div>