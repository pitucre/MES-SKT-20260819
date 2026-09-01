<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="TableControl.ascx.cs" Inherits="SKT.LeanMES.Web.SDP.ControlFuntion.TableControl" %>
<div>
    <table border="0" width="100%">
        <tr >
            <td class="Label2" style="width:100px;min-width:100px">
                <asp:Label ID="lblSource" runat="server" Text='数据源'></asp:Label><span style="color:Red">*</span>
            </td>
            <td class="Field2">
                <asp:DropDownList ID="ddlDataSource" runat="server" ClientIDMode="Static" style="min-width: 150px;width:150px" onchange="SetControlColumn()">
                </asp:DropDownList>
            </td>
            <td class="Label2" style="width:100px;min-width:100px">影响控件<span style="color:Red">*</span></td>
            <td class="Field2">
                <select id="ddlControl" name='ControlId' style="min-width: 150px;width:150px" onchange="SetControlColumn()">
                </select>  
            </td> 
        </tr>
        <tr>
            <td class="Label2" style="width:100px;min-width:100px">
                <asp:Label ID="lblBoundType" runat="server" Text='绑定方式'></asp:Label><span style="color:Red">*</span>
            </td>
            <td class="Field2" style="word-break:break-all;word-wrap: break-word">
                <table style="width:100%;">
                    <tr>
                        <td>
                            <input id="ReBound" name="boundtype" type="radio" value="ReBound" />重新绑定
                        </td>
                        <td>
                            <input id="Superimposed" name="boundtype" type="radio" value="Superimposed" checked="checked"/>叠加
                        </td>
                    </tr>
                </table>
            </td>
            <td class="Label2" style="width:100px;min-width:100px">显示行数<span style="color:Red">*</span></td>
            <td class="Field2">
                <select id="ddlShowRowCount" name='showrowcount' style="min-width: 150px;width:150px">
                    <option value="-1">-1</option>
                    <option value="5" selected="selected">5</option>
                    <option value="10">10</option>
                    <option value="20">20</option>
                    <option value="100">100</option>
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
            <td colspan="4">
                <table class="ListTable" cellspacing="0" cellpadding="4" 
                    style="border-width: 0px;width: 100%; overflow: auto; border-collapse: collapse;" id="tabColumn">
                    <tr style="min-height:30px;" class="ListTableHeader">
                        <th style="width:50%;">控件包含列</th>
                        <th style="width:50%">数据源显示的列名</th>
                    </tr>
                </table>
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

        //控件变化
        function SetControlColumn() {
            var tabColumn = document.getElementById("tabColumn");
            var rowlength = tabColumn.rows.length;
            for (i = rowlength - 1; i > 0; i--) {
                tabColumn.deleteRow(i);
            }

            //
            BindTableColumns();

            $("#<%=lblParamters.ClientID %>").text("");
            var source = document.getElementById("<%=ddlDataSource.ClientID %>");
            if ("-1" != source.options[source.selectedIndex].value) {
                $("#<%=lblParamters.ClientID %>").text(window.parent.getParamBySourceId(source.options[source.selectedIndex].value));
            }
        }

        //
        function BindTableColumns() { 
            var controls = document.getElementById("ddlControl");
            if (controls.options[controls.selectedIndex].value == "") {
                return;
            }

            var ddlDataSource = document.getElementById("<%=ddlDataSource.ClientID %>");
            if (ddlDataSource.options[ddlDataSource.selectedIndex].value == "-1") {
                return;
            }

            //Get Control option
            var controls = document.getElementById("ddlControl");
            var controlId = controls.options[controls.selectedIndex].value;
            if (controlId == "") {
                return;
            }
            var controlHtml = window.parent.GetmodelControl();
            var controlColumns = [];
            for (var k = 0; k < controlEntitys.length; k++) {
                if (controlEntitys[k].id == controlId) {
                    controlColumns = controlEntitys[k].uictrltitle.split('`');
                    break;
                }
            }
            if (controlColumns.length == 0) {
                return false;
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
            var options = "";
            for (i = 0; i < sourceColumn.length; i++) {
                if (sourceColumn[i] != "") {
                    options += "<option value='" + sourceColumn[i] + "'>" + sourceColumn[i] + "</option>";
                }
            }

            var tabColumn = document.getElementById("tabColumn");
            var rowIndex = tabColumn.rows.length;

            for (i = 0; i < controlColumns.length; i++) {
                if (controlColumns[i] != "") {
                    row = tabColumn.insertRow(rowIndex);
                    row.className = "ListTableOddRow";

                    //控件名称
                    cell = row.insertCell(0);
                    cell.align = "center";
                    cell.innerHTML = controlColumns[i];

                    //源的列
                    cell = row.insertCell(1);
                    cell.align = "center";
                    cell.innerHTML = "<select  name=\"ddlSourceColumn\" style=\"width:150px\">" + options + "</select>";

                    rowIndex++;
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
            var tabColumn = document.getElementById("tabColumn");
            for (i = 1; i < tabColumn.rows.length; i++) {
                var datasource = tabColumn.rows[i].children[1].children[0];
                returnXml = returnXml + "<Column ControlColumnName=\"" + tabColumn.rows[i].children[0].innerText + "\" SourceColumnName=\"" + datasource.options[datasource.selectedIndex].value + "\" ></Column>";
            }
            var rdlboundtype = $("input[name='boundtype']");
            var boundtype = "";
            rdlboundtype.each(function () {
                if (this.checked) {
                    boundtype = $(this).val();
                }
            });
            var ddlShowRowCount = document.getElementById("ddlShowRowCount");
            var showrowcount = ddlShowRowCount.options[ddlShowRowCount.selectedIndex].value;
            returnXml = "<BindColumns BoundType=\"" + boundtype + "\" showrowcount=\"" + showrowcount + "\">" + returnXml + "</BindColumns>";
            return returnXml;
        }

        function checkValue() {
            var returnCheck = true;
            var source = document.getElementById("<%=ddlDataSource.ClientID %>");
            if ("-1" == source.options[source.selectedIndex].value) {
                alert("请选择数据源!");
                returnCheck = false;
            }

            var control = document.getElementById("ddlControl");
            if ("" == control.options[control.selectedIndex].value) {
                alert("请选择影响控件!");
                returnCheck = false;
            }
            return returnCheck;
        }
    </script>
</div>