<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="True"
    CodeBehind="EquipmentCheckOutHistoryList.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.EquipmentCheckOutHistoryList" Title="EquipmentCheckOutHistory List Page" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" Runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
           <%--  <td class="Label2">效验对象</td>
            <td class="Field2">
                 <asp:DropDownList runat="server" ID="ddlObject">
                    <asp:ListItem Value="-1">请选择</asp:ListItem>
                    <asp:ListItem Value="1">设备</asp:ListItem>
                    <asp:ListItem Value="2">设备类型</asp:ListItem>
                 
                </asp:DropDownList>
            </td>--%>

            <td class="Label2">设备编码</td>
            <td class="Field2">
                <asp:TextBox ID="txtEqCode" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
          <%--<tr>
              <td class="Label2"><%=Resources.lang.EquipmentTypeName%></td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtEquimentType" runat="server"  minChars="1"></asp:TextBox>   <input type="button" value="..." class="ButtonBox" onclick="selectEqType()" />
            </td>
        </tr>--%>
        
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" Runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1">
        <Columns>
            <%-- To Do --%>
          <%--  <asp:BoundField DataField="ObjectTypeName" HeaderText="效验对象" />
            <asp:BoundField DataField="EquimentTypeName" HeaderText="设备类型名称" />--%>
            <asp:BoundField DataField="EqCode" HeaderText="设备编码" />
            <asp:BoundField DataField="CheckTypeName" HeaderText="校验类型" />
            <asp:BoundField DataField="CheckProjectName" HeaderText="校验项目" />
            <asp:BoundField DataField="CycleTypeName" HeaderText="周期类型" />
             <asp:TemplateField HeaderText="上次校验时间" >
                <ItemTemplate >
                    <%#string.Format("{0:yyyy-MM-dd hh:mm:ss}",Eval("LastTime")).Trim()=="9999-12-31 12:00:00"?"":string.Format("{0:yyyy-MM-dd HH:mm:ss}",Eval("LastTime"))%>
                </ItemTemplate>
            </asp:TemplateField>
         
            <asp:BoundField DataField="NextTime" HeaderText="下次校验时间"  DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>
            <asp:BoundField DataField="StatusNmae" HeaderText="<%$ Resources:lang, Status %>" />

            <asp:BoundField DataField="CertificateNo" HeaderText="<%$ Resources:lang, CertificateNo %>" />
           <%-- <asp:BoundField DataField="CertificateFileName" HeaderText="<%$ Resources:lang, CertificateFileName %>" />--%>
             <asp:TemplateField HeaderText="证书文件名称">  
                        <ItemTemplate>
                          <%-- <%# Eval("CertificateFileName") %>  --%>
                          <a href='javascript:void(0);' onclick="LoadZhenShu('<%#Eval("CertificateFileName")%>')"><%# Eval("CertificateFileName") %> </a>  
                        </ItemTemplate>  
                    </asp:TemplateField>  
            <asp:BoundField DataField="Remark" HeaderText="<%$ Resources:lang, Remark %>" />
            <asp:BoundField DataField="CreateBy" HeaderText="送检人" />
              <asp:BoundField DataField="InspectionUnit" HeaderText="送检单位" />
         <%--   <asp:BoundField DataField="InspectionTime" HeaderText="送检时间"  DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>--%>
             <asp:TemplateField HeaderText="送检时间" >
                <ItemTemplate >
                    <%#string.Format("{0:yyyy-MM-dd hh:mm:ss}",Eval("InspectionTime")).Trim()=="9999-12-31 12:00:00"?"":string.Format("{0:yyyy-MM-dd HH:mm:ss}",Eval("InspectionTime"))%>
                </ItemTemplate>
            </asp:TemplateField>
         
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" 
        StartRowIndexParameterName="startRow" MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" 
        TypeName="SKT.LeanMES.Equipment.BLL.EquipmentCheckOutHistory" SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value=""/>
    <input type="hidden" id="hdnIdString" name="hdnIdString"  value=""/>

    <script type="text/javascript">
        isMultiple = false;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");
        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/EquipmentCheckOutHistoryEdit.aspx?name=EquipmentCheckOutHistoryAdd&ID=-1";
            dialog({ title: "1111", src: openWinUrl, width: 650, height: 400});
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/EquipmentCheckOutHistoryEdit.aspx?name=EquipmentCheckOutHistoryEdit&ID=" + idStr;
            dialog({ title: "1222222", src: openWinUrl, width: 600, height: 400 });
        }
        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }

        function Refresh() {
            document.forms[0].submit();
        }
        function LoadZhenShu(data) {
            <%--var path = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/UploadFiles/EQFile/CheckOutFile/" + data;--%>
            if (data == "未载入") {
                alert("未上传文件!");
                return false;
            }
            var path = '<%=SKT.LeanMES.Web.WebHelper.EQCheckOutFileRoot %>'+"/"+data;
            window.open(path);
        }

         function selectEqType() {
            var openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/EquimentTypeDialog.aspx?name=Equipment_EquimentTypeDialog&controlId=controlId";
            dialog({ title: "设备类型", src: openWinUrl, width: 255, height: 350 });
            }
         SetValue = function (list) {
             closeDialog();
           <%-- $("#<%=txtEquimentType.ClientID%>").val(list[0].name);--%>
        }
    </script>
</asp:Content>

