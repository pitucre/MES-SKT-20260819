<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="BindValueControl.ascx.cs" Inherits="SKT.LeanMES.Web.SDP.ControlFuntion.BindValueControl" %>
<div>
    <table border="0" width="100%">
        <tr >
            <td class="Label2" style="width:100px;min-width:100px">
                <asp:Label ID="lblSource" runat="server" Text='数据源'></asp:Label><span style="color:Red">*</span>
            </td>
            <td class="Field2">
                <asp:DropDownList ID="ddlDataSource" runat="server" ClientIDMode="Static" Style="min-width: 150px;width:150px;" onchange="BindTableColumns()">
                </asp:DropDownList>
            </td>
            <td class="Label2" style="width:100px;min-width:100px">影响控件<span style="color:Red">*</span></td>
            <td class="Field2">
                <select id="ddlControl" name='ControlId' style="min-width: 150px;width:150px;">
                </select>                  
            </td> 
        </tr>
        <tr>
            <td class="Label2" style="width:100px">
                数据源参数
            </td>
            <td colspan="3" style="word-break:break-all;word-wrap: break-word">
                <asp:Label ID="lblParamters" runat="server" Text="" ></asp:Label>
            </td>
        </tr>  
        <tr>
            <td  class="Label2" style="width:100px;min-width:100px">
                value值<span style="color:Red">*</span>
            </td>
            <td class="Field2">
                <select id="ddlControlValue" name='ControlId' style="min-width: 150px;width:150px;">
                </select>
            </td>

            <td  class="Label2" style="width:100px;min-width:100px">Text值</td>
            <td class="Field2">
                <select id="ddlControlText" name='ControlId' style="min-width: 150px;width:150px;">
                </select>
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
                if(isControlTypeInArray(controlEntitys[k].uictrltype)){
                    controls.options.add(new Option(controlEntitys[k].title + "(" + controlEntitys[k].uictrltype + ")", controlEntitys[k].id));
                }
            }
        }

        function BindTableColumns() {
            var ddlControlText = document.getElementById("ddlControlText");
            ddlControlText.options.length = 0; //删除旧的方法
            var ddlControlValue = document.getElementById("ddlControlValue");
            ddlControlValue.options.length = 0; //删除旧的方法

            $("#<%=lblParamters.ClientID %>").text("");

            ddlControlText.options.add(new Option("请选择", ""));
            ddlControlValue.options.add(new Option("请选择", ""));

            var ddlDataSource = document.getElementById("<%=ddlDataSource.ClientID %>");
            if (ddlDataSource.options[ddlDataSource.selectedIndex].value == "-1") {
                return;
            }

            //Get select Option
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSDP.GetSourceByRDSourceId(ddlDataSource.options[ddlDataSource.selectedIndex].value);
            if (ajax.error != null) {
                alert(ajax.error.Message)
                return false;
            }

            //Get select Option
            var model = ajax.value;
            var sourceColumn = model.TabColumn.split(",");

            for (i = 0; i < sourceColumn.length; i++) {
                ddlControlText.options.add(new Option(sourceColumn[i], sourceColumn[i]));

                ddlControlValue.options.add(new Option(sourceColumn[i], sourceColumn[i]));
            }

            $("#<%=lblParamters.ClientID %>").text(window.parent.getParamBySourceId(ddlDataSource.options[ddlDataSource.selectedIndex].value));
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
        }

        function GetSource(type) {
            var source = document.getElementById("<%=ddlDataSource.ClientID %>");
            if (type == "ID") {
                return source.options[source.selectedIndex].value;
            }
            else {
                return source.options[source.selectedIndex].text;
            }
        }

        function GetStepXml() {
            var returnXml = "";
            var ddlControlText = document.getElementById("ddlControlText");
            var ddlControlValue = document.getElementById("ddlControlValue");

            var DataTextField = ddlControlText.options[ddlControlText.selectedIndex].value;
            if (DataTextField != "") {
                returnXml += "<DataTextField>" + DataTextField + "</DataTextField>";
            }

            var DataValueField = ddlControlValue.options[ddlControlValue.selectedIndex].value;
            if (DataValueField != "") {
                returnXml += "<DataValueField>" + DataValueField + "</DataValueField>";
            }

            returnXml = "<control>" + returnXml + "</control>";
            return returnXml;
        }

        function checkValue() {
            var returnCheck = true;
            var source = document.getElementById("<%= ddlDataSource.ClientID %>");
            if ("-1" == source.options[source.selectedIndex].value) {
                alert("请选择数据源!");
                returnCheck = false;
            }

            var controls = document.getElementById("ddlControl");
            if ("" == controls.options[controls.selectedIndex].value) {
                alert("请选择设置值的控件!");
                returnCheck = false;
            }

            var ddlControlValue = document.getElementById("ddlControlValue");
            if ("" == ddlControlValue.options[ddlControlValue.selectedIndex].value) {
                alert("请选择需要绑定的value值!");
                returnCheck = false;
            }

            var ddlControlText = document.getElementById("ddlControlText");
            if ("" == ddlControlText.options[ddlControlText.selectedIndex].value) {
                alert("请选择需要绑定的Text值!");
                returnCheck = false;
            }

            var controlId = controls.options[controls.selectedIndex].value;
            var controlText = controls.options[controls.selectedIndex].text;
            var controlType = controlText.replace(controlId, "").replace("(", "").replace(")", "");
            if (controlType == "<%= SKT.LeanMES.SDP.Model.ControlType.select.ToString() %>" &&
                controlType == "<%= SKT.LeanMES.SDP.Model.ControlType.radios.ToString() %>" &&
                controlType == "<%= SKT.LeanMES.SDP.Model.ControlType.checkboxs.ToString() %>") {
                var ddlControlText = document.getElementById("ddlControlText");
                if ("" == ddlControlText.options[ddlControlText.selectedIndex].value) {
                    alert("请选择需要绑定的Text值!");
                    returnCheck = false;
                }
            }
            return returnCheck;
        }
    </script>
</div>