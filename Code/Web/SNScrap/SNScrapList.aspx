<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="SNScrapList.aspx.cs" Inherits="SKT.LeanMES.Web.SNScrap.SNScrapList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">报废条码
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtSN" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
            </td>
            <td class="Label2">报废类型
            </td>
            <td class="Field2">
                <asp:DropDownList ID="ddlScrapType" runat="server">
                    <asp:ListItem Value="-1" Text="所有"> </asp:ListItem>
                    <asp:ListItem Value="0" Text="维修报废"> </asp:ListItem>
                    <asp:ListItem Value="1" Text="自动报废"> </asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="Label2">工单号
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtOrderNo" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
            </td>
            <td class="Label2">产品编码
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtItemCode" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">报废开始时间
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtBegTime" runat="server" class="DateTimeBox" Width="150" isRequired="1"
                    ClientIDMode="Static"></asp:TextBox>
                &nbsp;&nbsp;&nbsp;<img id="timeClear"  style="cursor: pointer;" onclick="clearTime(this)" title="点击清除日期" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAA8UlEQVQ4T6WS4Q0BURCEPx3ogA7oAB0ogQrQgQ7QgRKoAB1QASXogHzyNnl3eeckJrk/t29mZ3e2w5/o/MgfAgtgBTxzzi8Ckg/AFegBk1ykTUDyKXXeA2tgmr6HTr4JdIF7Rg7nM2ALjHXVJCDZzjvAznUsk4txSSDIF8CHJfhfB9OSwBlwPq2W4A50VRzBgg58VEIkYt1UKkuU7AMF7K6THJHIPMX6qcUIEY+2+onsnLHAxqWGgLGMsiOxmw4U8YhM5JjuoGIrX6LdBjUR/72AW9NS6ynEkWxSG504lg7rMOZzKUY3LLENjlgUaCNW6m+WQjQRQeRbMQAAAABJRU5ErkJggg==" />


            </td>
            <td class="Label2">结束时间
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtEndTime" runat="server" class="DateTimeBox" Width="150" isRequired="1"
                    ClientIDMode="Static"></asp:TextBox>
                &nbsp;&nbsp;&nbsp;<img id="repairTimeClear"  style="cursor: pointer;" onclick="clearTime(this)" title="点击清除日期" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAA8UlEQVQ4T6WS4Q0BURCEPx3ogA7oAB0ogQrQgQ7QgRKoAB1QASXogHzyNnl3eeckJrk/t29mZ3e2w5/o/MgfAgtgBTxzzi8Ckg/AFegBk1ykTUDyKXXeA2tgmr6HTr4JdIF7Rg7nM2ALjHXVJCDZzjvAznUsk4txSSDIF8CHJfhfB9OSwBlwPq2W4A50VRzBgg58VEIkYt1UKkuU7AMF7K6THJHIPMX6qcUIEY+2+onsnLHAxqWGgLGMsiOxmw4U8YhM5JjuoGIrX6LdBjUR/72AW9NS6ynEkWxSG504lg7rMOZzKUY3LLENjlgUaCNW6m+WQjQRQeRbMQAAAABJRU5ErkJggg==" />


            </td>

        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="SN" HeaderText="报废条码" />
            <asp:BoundField DataField="OrderNO" HeaderText="工单号" />
            <asp:BoundField DataField="ItemCode" HeaderText="产品编码" />
            <asp:BoundField DataField="ItemName" HeaderText="产品名称" />
            <asp:BoundField DataField="ItemSpec" HeaderText="产品规格" />
            <asp:BoundField DataField="NcUserName" HeaderText="不良录入人" />
            <asp:BoundField DataField="NcDateTime" HeaderText="不良录入时间" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>
            <asp:BoundField DataField="ScrapReson" HeaderText="报废原因" />
            <asp:BoundField DataField="ScrapUserName" HeaderText="报废确认人" />
            <asp:BoundField DataField="ScrapTime" HeaderText="报废确认时间" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>
            <asp:BoundField DataField="ScrapType" HeaderText="报废类型" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.ProdUnit.BLL.SNScrap"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <script type="text/javascript">
        _isHms = false;

        //报废恢复
        function Receive() {
            if (!confirm('确认该产品SN进行报废恢复?')) {
                return false;
            }
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSNScrap.SaveSNScrap(idStr);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            } else {
                alert("报废恢复成功！");
                UpdateList();
            }
        }

        function UpdateList() {
            document.forms[0].submit();
        }



        /*清除日期*/
        function clearTime(obj) {
            if (obj.id == "timeClear") {
                $("#txtBegTime").val("");

            }
            else if (obj.id == "repairTimeClear") {
                $("#txtEndTime").val("");
            }
        }
    </script>
</asp:Content>
