<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CommonControl.ascx.cs" Inherits="SKT.LeanMES.Web.SDP.ControlFuntion.CommonControl" %>
<script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/jquery.min.js" type="text/javascript"></script>
<div>
    <table border="0" width="100%">
        <tr >
            <td class="Label2" style="width:100px;min-width:100px">
                <asp:Label ID="lblSource" runat="server" Text='数据源'></asp:Label><span style="color:Red">*</span>
            </td>
            <td class="Field2">
                <asp:DropDownList ID="ddlDataSource" runat="server" ClientIDMode="Static" style="min-width: 150px;width:150px">
                </asp:DropDownList>
            </td>
            <td class="Label2" style="width:100px;min-width:100px"></td>
            <td class="Field2">                  
            </td> 
        </tr>
    </table>

    <script type="text/javascript">
        /*****************************公共方法***********************************/
        function GetControl(type) {
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