<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true"
    CodeBehind="WriteBackLogList.aspx.cs" Inherits="SKT.LeanMES.Web.SystemConfiguration.WriteBackLogList" Title="Write Back Log List Page" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">MES单号</td>
            <td class="Field3">
                <asp:TextBox ID="MESBillNo" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">回写编码</td>
            <td class="Field3">
                <asp:TextBox ID="WriteBackCode" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">回写名称</td>
            <td class="Field3">
                <asp:TextBox ID="WriteBackName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label3">ERP单号</td>
            <td class="Field3">
                <asp:TextBox ID="ERPNo" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">回写结果</td>
            <td class="Field3">
                <asp:DropDownList ID="ERPResult" runat="server">
                    <asp:ListItem Selected="True" Value="">请选择</asp:ListItem>
                     <asp:ListItem Value="1" Text="<%$ Resources:lang, Succeed %>"></asp:ListItem>
                    <asp:ListItem Value="0" Text="<%$ Resources:lang, Fail %>"></asp:ListItem>
                </asp:DropDownList>
            </td>
            <td class="Label3">操作人</td>
            <td class="Field3">
                <asp:TextBox ID="CreateBy" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label3">回写时间</td>
            <td class="Field3">
                <asp:TextBox ID="CreateDateTimeBegin" runat="server" CssClass="DateTimeBox"></asp:TextBox>-<asp:TextBox ID="CreateDateTimeEnd" runat="server" CssClass="DateTimeBox"></asp:TextBox>
                <img title="点击清除日期" class="clear-time" style="margin: -10px 0px 0px 2px;  cursor: pointer;" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAA8UlEQVQ4T6WS4Q0BURCEPx3ogA7oAB0ogQrQgQ7QgRKoAB1QASXogHzyNnl3eeckJrk/t29mZ3e2w5/o/MgfAgtgBTxzzi8Ckg/AFegBk1ykTUDyKXXeA2tgmr6HTr4JdIF7Rg7nM2ALjHXVJCDZzjvAznUsk4txSSDIF8CHJfhfB9OSwBlwPq2W4A50VRzBgg58VEIkYt1UKkuU7AMF7K6THJHIPMX6qcUIEY+2+onsnLHAxqWGgLGMsiOxmw4U8YhM5JjuoGIrX6LdBjUR/72AW9NS6ynEkWxSG504lg7rMOZzKUY3LLENjlgUaCNW6m+WQjQRQeRbMQAAAABJRU5ErkJggg==" alt="清除">
            </td>
            <td class="Label3"></td>
            <td class="Field3">
            </td>
            <td class="Label3"></td>
            <td class="Field3">
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1">
        <Columns>   
            <asp:BoundField DataField="WriteBackCode" HeaderText="回写编码" SortExpression="WriteBackCode" />
            <asp:BoundField DataField="WriteBackName" HeaderText="回写名称" SortExpression="WriteBackName" />
            <asp:BoundField DataField="MD5" HeaderText="MD5" SortExpression="MD5" />
            <asp:BoundField DataField="ERPResultName" HeaderText="ERP回写结果" SortExpression="ERPResultName" />
            <asp:BoundField DataField="ERPNo" HeaderText="ERP单号" SortExpression="ERPNo" />
            <asp:BoundField DataField="ERPMsg" HeaderText="ERP返回消息" SortExpression="ERPMsg" />
            <asp:BoundField DataField="MESMsg" HeaderText="MES消息" SortExpression="MESMsg" />
            <asp:BoundField DataField="MESBillNo" HeaderText="MES单号" SortExpression="MESBillNo" />
            <asp:BoundField DataField="CreateBy" HeaderText="创建人" SortExpression="CreateBy" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="创建时间" SortExpression="CreateDateTime" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true"
        StartRowIndexParameterName="startRow" MaximumRowsParameterName="maxRows" SortParameterName="sortExpression"
        TypeName="SKT.LeanMES.CommonDataSource.BLL.ERPWriteBackLog" SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />

    <script type="text/javascript">
        isMultiple = false;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");

        $(function () {
            $(".clear-time").click(function () {
                $(this).siblings(".DateTimeBox").val("");
            });
        })

        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SystemConfiguration/WriteBackLogView.aspx?name=System_WriteBackLogView&ID=" + idStr;
            dialog({ title: "查看", src: openWinUrl, width: 1000, height: 800 });
        }

        function Refresh() {
            document.forms[0].submit();
        }
    </script>
</asp:Content>


