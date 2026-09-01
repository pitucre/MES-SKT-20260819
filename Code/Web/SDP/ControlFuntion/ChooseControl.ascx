<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ChooseControl.ascx.cs" Inherits="SKT.LeanMES.Web.SDP.ControlFuntion.ChooseControl" %>
<div>
    <table border="0" width="100%;min-width:100px">
        <tr >
            <td class="Label2" style="width:100px">
                <asp:Label ID="lblSource" runat="server" Text='选择页面'></asp:Label><span style="color:Red">*</span>
            </td>
            <td class="Field2">
                <asp:DropDownList ID="ddlPage" runat="server" ClientIDMode="Static" style="min-width: 150px;width:150px" onchange="BindTabCom()">
                </asp:DropDownList>
            </td>
            <td class="Label2" style="width:100px;min-width:100px"></td>
            <td class="Field2">                 
            </td> 
        </tr>
        <tr>
            <td class="Label2" style="width:100px;min-width:100px">显示内容(Text)</td>
            <td class="Field2">
                <select id="ddlControlValue" name='ControlId' style="min-width: 150px;width:150px;">
                </select>
            </td>
            <td class="Label2" style="width:100px;min-width:100px">隐藏内容(Id)</td>
            <td class="Field2">
                <select id="ddlControlText" name='ControlId' style="min-width: 150px;width:150px;">
                </select>
            </td>                   
        </tr>
    </table>
    <script type="text/javascript">        
        function BindTabCom() {
            var ddlControlText = document.getElementById("ddlControlText");
            ddlControlText.options.length = 0; //删除旧的方法
            var ddlControlValue = document.getElementById("ddlControlValue");
            ddlControlValue.options.length = 0; //删除旧的方法

            ddlControlText.options.add(new Option("请选择", ""));
            ddlControlValue.options.add(new Option("请选择", ""));

            var ddlPage = document.getElementById("<%=ddlPage.ClientID %>");
            if (ddlPage.options[ddlPage.selectedIndex].value == "") {
                return;
            }
            
            var fielesValue = $(ddlPage.options[ddlPage.selectedIndex]).attr("returnFielesValue").split(",");
            var fielesName = $(ddlPage.options[ddlPage.selectedIndex]).attr("returnFielesName").split(",");
            for (i = 0; i < fielesValue.length; i++) {
                ddlControlText.options.add(new Option(fielesName[i], fielesValue[i]));
                ddlControlValue.options.add(new Option(fielesName[i], fielesValue[i]));
            }
        }


        /*****************************公共方法***********************************/
        function GetControl(type) {
            return "";
        }

        function GetSource(type) {
            return "";
        }

        function GetStepXml() {
            var returnXml = "";
            var ddlPage = document.getElementById("<%=ddlPage.ClientID %>");
            returnXml += "<page id='" + ddlPage.options[ddlPage.selectedIndex].value + "' Multiple='False'></page>";
            var ddlControlText = document.getElementById("ddlControlText");
            returnXml += "<Text>" + ddlControlText.options[ddlControlText.selectedIndex].value + "</Text>";
            var ddlControlValue = document.getElementById("ddlControlValue");
            returnXml += "<Value>" + ddlControlValue.options[ddlControlValue.selectedIndex].value + "</Value>";  
                                
            returnXml = "<ChoosePage>" + returnXml + "</ChoosePage>";
            return returnXml;
        }

        function checkValue() {
            var returnCheck = true;
            var ddlPage = document.getElementById("<%=ddlPage.ClientID %>");
            if(ddlPage.options[ddlPage.selectedIndex].value == ""){
                alert("请选择弹出页");                
                returnCheck= false;
            }

            var ddlControlText = document.getElementById("ddlControlText");
            if(ddlControlText.options[ddlControlText.selectedIndex].value == ""){
                alert("请选择显示的内容");
                returnCheck= false;
            }

            var ddlControlValue = document.getElementById("ddlControlValue");
            if(ddlControlValue.options[ddlControlValue.selectedIndex].value == ""){
                alert("请选择保存的内容");
                returnCheck= false;
            }

            return returnCheck;
        }
    </script>
<//div>

