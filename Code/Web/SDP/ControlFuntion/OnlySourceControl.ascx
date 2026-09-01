<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="OnlySourceControl.ascx.cs" Inherits="SKT.LeanMES.Web.SDP.ControlFuntion.OnlySourceControl" %>
<div>
    <table border="0" width="100%">
        <tr >
            <td class="Label2" style="width:100px;min-width:100px">
                <asp:Label ID="lblSource" runat="server" Text='数据源'></asp:Label><span style="color:Red">*</span>
            </td>
            <td class="Field2">
                <asp:DropDownList ID="ddlDataSource" runat="server" ClientIDMode="Static" style="min-width: 150px;width:150px" onchange="BindTableColumns()">
                </asp:DropDownList>
            </td>
            <td class="Label2" style="width:100px;min-width:100px">结果保存控件</td>
            <td class="Field2">  
                <input id="cbControlId" type="checkbox" value="是否保存结果" />          
            </td> 
        </tr>
        <tr>
            <td class="Label2" style="width:100px">
                数据源参数
            </td>
            <td  class="Field2" colspan="3" style="word-break:break-all;word-wrap: break-word">
                <asp:Label ID="lblParamters" runat="server" Text="" ></asp:Label>
            </td>
        </tr>
    </table>
    <script type="text/ecmascript">        
        $(document).ready(function () {
            
        });
        
        function BindTableColumns() {
            $("#<%=lblParamters.ClientID %>").text("");
            var source = document.getElementById("<%=ddlDataSource.ClientID %>");
            if ("-1" != source.options[source.selectedIndex].value) {
                $("#<%=lblParamters.ClientID %>").text(window.parent.getParamBySourceId(source.options[source.selectedIndex].value));
            }
        }

        /*****************************************************/
        function GetControl(type) {
            var control = document.getElementById("cbControlId");
            if (type == "ID") {
                if (control.checked) {
                    return "IsPass";
                }
            }
            else {
                return "IsPass";
            }
            return "";
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
            return "";
        }

        function checkValue() {
            var returnCheck = true;
            var source = document.getElementById("<%=ddlDataSource.ClientID %>");
            if ("-1" == source.options[source.selectedIndex].value) {
                alert("请选择数据源!");
                returnCheck = false;
            }
            return returnCheck;
        }
    </script>
</div>