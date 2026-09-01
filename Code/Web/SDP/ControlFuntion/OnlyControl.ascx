<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="OnlyControl.ascx.cs" Inherits="SKT.LeanMES.Web.SDP.ControlFuntion.OnlyControl" %>
<div>
    <table border="0" width="100%">
        <tr >
            <td class="Label2" style="width:100px;min-width:100px">
                影响控件<span style="color:Red">*</span>
            </td>
            <td class="Field2">
                <select id="ddlControl" name='ControlId' style="min-width: 150px;width:150px">
                </select>
            </td>
            <td class="Label2" style="width:100px;min-width:100px"></td>
            <td class="Field2">                  
            </td> 
        </tr>
    </table>
    <script type="text/javascript">
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
        /*****************************公共方法***********************************/
        function GetControl(type) {
            var control = document.getElementById("ddlControl");
            if (type == "ID") {
                return control.options[control.selectedIndex].value;
            }
            else {
                return control.options[control.selectedIndex].text;
            }
            return "";
        }

        function GetSource(type) {
            return "";
        }

        function GetStepXml() {
            return "";
        }

        function checkValue() {
            var returnCheck = true;
            var control = document.getElementById("ddlControl");
            if ("" == control.options[control.selectedIndex].value) {
                alert("请选择影响控件!");
                returnCheck = false;
            }
            return returnCheck;
        }
    </script>
</div>