<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true"
    CodeBehind="CapacityVerfyRecordList.aspx.cs" Inherits="SKT.LeanMES.Web.CapacityVerfyRecord.CapacityVerfyRecordList" Title="CapacityVerfyRecord List Page" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" Runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">添加人</td>
            <td class="Field4">
                <asp:TextBox ID="txtCreateBy" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
             <td class="Label3">工序</td>
            <td class="Field4">
                <input type="text"  id="txtStation" runat="server" />
               <%-- <input type="button" id="bnItem" class="ButtonBox" style="float:right;" onclick="openChoosePage(8)" value="..." />    
                <input type="hidden" id="hdnOpId" value="-1" /> --%> 
            </td>
            <td class="Label3">
               时间
            </td>
            <td class="Field4">
                <input type="text" id="txtDateFrom" class="DateTimeBox" runat="server" />
                -
                <input type="text" id="txtDateTo" class="DateTimeBox" runat="server" />
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" Runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1">
        <Columns>
            <asp:BoundField DataField="UserName" HeaderText="用户" />
            <asp:BoundField DataField="NO" HeaderText="编号" />
            <asp:BoundField DataField="QueryDate" HeaderText="日期" />
            <asp:BoundField DataField="Station" HeaderText="工序" />
            <asp:BoundField DataField="EquipmentCode" HeaderText="设备编码" />
            <asp:BoundField DataField="ItemCode" HeaderText="产品编码" />
            <asp:BoundField DataField="ItemName" HeaderText="产品名称" />
            <asp:BoundField DataField="Qty" HeaderText="数量" />
            <asp:BoundField DataField="Price" HeaderText="价格" />
            <asp:BoundField DataField="Salary" HeaderText="工资" />
            <asp:BoundField DataField="AuditingSalary" HeaderText="审核工资" />
            <asp:BoundField DataField="CreateTime" HeaderText="<%$Resources:lang,CreateDateTime%>" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>
            <asp:BoundField DataField="CreateBy" HeaderText="<%$Resources:lang,CreateBy%>" />
            <asp:BoundField DataField="Remark" HeaderText="<%$Resources:lang,Remark%>" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" 
        StartRowIndexParameterName="startRow" MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" 
        TypeName="SKT.LeanMES.CapacityVerfyRecord.BLL.CapacityVerfyRecord" SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value=""/>
    <input type="hidden" id="hdnIdString" name="hdnIdString"  value=""/>

    <script type="text/javascript">
        isMultiple = true;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");
        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/CapacityVerfyRecord/CapacityVerfyRecordEdit.aspx?name=CapacityVerfyRecordAdd&ID=-1";
            dialog({ title: mesLang("添加"), src: openWinUrl, width: 650, height: 400 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/CapacityVerfyRecord/CapacityVerfyRecordEdit.aspx?name=Product_CapacityVerfyRecordEdit&ID=" + idStr;
            dialog({ title: mesLang("修改"), src: openWinUrl, width: 600, height: 400 });
        }

        //审核
        function Audit() {
            var idStr = getRecordIdString();
            if (idStr == "") {
                alert("请选择数据！")
                return false;
            }
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxCapacityVerfyRecord.Audit(idStr, 1);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert("审核成功！")
            document.forms[0].submit();
        }
        //确认产能
        function ConfirmCapacity() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/CapacityVerfyRecord/ConfirmCapacity.aspx?name=Product_ConfirmCapacity";
            dialog({ title: "确认产能", src: openWinUrl, width: 680, height: 500 });
        }

        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }
        function openChoosePage(flags) {
            var condition = "";
            flag = flags;
          
          dialog({ title: "Choose Window", src: "../Framework/ChoosePage.aspx?PageId=" + flags + "&Multiple=true&SearchCondition=" +
			condition + "&rnd=" + Math.random(), width: 600, height: 300
                });

        }

        function getChooseValue(list) {
            if (flag == 8) {
                $("#hdnOpId").val(list[0][0]);
                $("#txtStation").val(list[0][1]);
            }
            flag = -1;
        }  
        function Refresh() {
            document.forms[0].submit();
        }
    </script>
</asp:Content>

