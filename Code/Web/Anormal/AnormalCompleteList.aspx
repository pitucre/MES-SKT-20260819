<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="AnormalCompleteList.aspx.cs" Inherits="SKT.LeanMES.Web.Anormal.AnormalCompleteList" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">异常单号
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtAnormalNo" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">异常类型
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtAnormalTypeName" runat="server" CssClass="TextBox"></asp:TextBox>
                <input type="button" runat="server" class="ButtonBox" value="..." title="选择异常类型" onclick="openChoosePage(1, 831, '选择异常类型');" />
            </td>
            <td class="Label3">异常名称
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtAnormalName" runat="server" CssClass="TextBox"></asp:TextBox>
                <input type="button" runat="server" class="ButtonBox" value="..." title="选择异常名称" onclick="openChooseAnormalPage();" />
            </td>

        </tr>
        <tr>
            <td class="Label3">线别
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtLineName" runat="server" CssClass="TextBox"></asp:TextBox>
                <input type="button" runat="server" class="ButtonBox" value="..." title="选择线别" onclick="openChoosePage(2, 21, '选择线别');" />
            </td>
            <td class="Label3">状态
            </td>
            <td class="Field3">
                <asp:DropDownList ID="ddlStatus" runat="server">
                    <asp:ListItem Value="-1" Text="全部"></asp:ListItem>
                    <asp:ListItem Value="1" Text="已建立"></asp:ListItem>
                    <asp:ListItem Value="3" Text="已处理" Selected="True"></asp:ListItem>
                    <asp:ListItem Value="2" Text="已关闭"></asp:ListItem>
                </asp:DropDownList>
                是否停线
                <asp:DropDownList ID="ckbIsLineStopped" runat="server">
                    <asp:ListItem Value="-1" Text="全部" Selected="True"></asp:ListItem>
                    <asp:ListItem Value="1" Text="已停线"></asp:ListItem>
                    <asp:ListItem Value="0" Text="未停线"></asp:ListItem>
                </asp:DropDownList>
            </td>
            <td class="Label3">异常录入日期
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtStartTime" runat="server" CssClass="DateTimeBox"></asp:TextBox>
                -
                <asp:TextBox ID="txtEndTime" runat="server" CssClass="DateTimeBox"></asp:TextBox>
                <img title="点击清除日期" class="clear-time" style="margin-bottom: -5px; cursor: pointer;" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAA8UlEQVQ4T6WS4Q0BURCEPx3ogA7oAB0ogQrQgQ7QgRKoAB1QASXogHzyNnl3eeckJrk/t29mZ3e2w5/o/MgfAgtgBTxzzi8Ckg/AFegBk1ykTUDyKXXeA2tgmr6HTr4JdIF7Rg7nM2ALjHXVJCDZzjvAznUsk4txSSDIF8CHJfhfB9OSwBlwPq2W4A50VRzBgg58VEIkYt1UKkuU7AMF7K6THJHIPMX6qcUIEY+2+onsnLHAxqWGgLGMsiOxmw4U8YhM5JjuoGIrX6LdBjUR/72AW9NS6ynEkWxSG504lg7rMOZzKUY3LLENjlgUaCNW6m+WQjQRQeRbMQAAAABJRU5ErkJggg==">
            </td>
        </tr>
        <tr>
            <td class="Label3">异常接收人</td>
            <td class="Field3">
                <asp:TextBox runat="server" ID="ReceiveBy" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
            </td>
            <td class="Label3">异常结案日期</td>
            <td class="Field4">
                <asp:TextBox ID="CompleteTimeStart" runat="server" CssClass="DateTimeBox"></asp:TextBox>
                -
                <asp:TextBox ID="CompleteTimeEnd" runat="server" CssClass="DateTimeBox"></asp:TextBox>
                <img title="点击清除日期" class="clear-time" style="margin-bottom: -5px; cursor: pointer;" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAA8UlEQVQ4T6WS4Q0BURCEPx3ogA7oAB0ogQrQgQ7QgRKoAB1QASXogHzyNnl3eeckJrk/t29mZ3e2w5/o/MgfAgtgBTxzzi8Ckg/AFegBk1ykTUDyKXXeA2tgmr6HTr4JdIF7Rg7nM2ALjHXVJCDZzjvAznUsk4txSSDIF8CHJfhfB9OSwBlwPq2W4A50VRzBgg58VEIkYt1UKkuU7AMF7K6THJHIPMX6qcUIEY+2+onsnLHAxqWGgLGMsiOxmw4U8YhM5JjuoGIrX6LdBjUR/72AW9NS6ynEkWxSG504lg7rMOZzKUY3LLENjlgUaCNW6m+WQjQRQeRbMQAAAABJRU5ErkJggg==">
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" DataKeyNames="AnormalObject">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="AbnormalDocumentNo" HeaderText="异常单号" SortExpression="LineName" />
            <asp:BoundField DataField="LineName" HeaderText="线别" SortExpression="LineName" />
            <asp:BoundField DataField="AnormalTypeName" HeaderText="异常类型" SortExpression="AnormalTypeName" />
            <asp:BoundField DataField="AnormalName" HeaderText="异常名称" />
            <asp:BoundField DataField="Station" HeaderText="工位" SortExpression="Station" />
            <asp:BoundField DataField="CreateBy" HeaderText="异常录入人" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="异常录入时间" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
            <asp:BoundField DataField="DeptName" HeaderText="异常部门" />
            <asp:BoundField DataField="StatusName" HeaderText="状态" SortExpression="StatusName" />
            <asp:BoundField DataField="Descriptions" HeaderText="异常描述" />
            <asp:BoundField DataField="IsLineStopName" HeaderText="是否停线" SortExpression="IsLineStopName" />
            <asp:BoundField DataField="ProcessTimeLength" HeaderText="处理时长" DataFormatString="{0:G0}" SortExpression="ProcessTimeLength" />
            <asp:BoundField DataField="CloseTimeLength" HeaderText="结案时长" DataFormatString="{0:G0}" SortExpression="CloseTimeLength" />
            <asp:BoundField DataField="EffectPerson" HeaderText="影响人数" DataFormatString="{0:G0}" />
            <asp:BoundField DataField="ModifyBy" HeaderText="修改人" />
            <asp:BoundField DataField="ModifyDateTime" HeaderText="修改时间" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.ProdAnormal.BLL.Anormal"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
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
        var chooseFlag = -1;
        _isHms = false;

        $(function () {
            $(".clear-time").click(function () {
                $(this).siblings(".DateTimeBox").val("");
            });
        })

        //查看
        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            var openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Anormal/AnormalEdit.aspx?name=Anormal_View&ID=" + idStr;
            window.open(openWinUrl);
        }

        //编辑
        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return;
            var cellText = getOneRecordCellTextByFiled("StatusName");
            if (cellText == "已关闭") {
                alert("该异常已关闭，不能完结!");
                return false;
            }
            if (cellText == "已建立") {
                alert("该异常未进行处理，不能完结!");
                return false;
            }
            var openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Anormal/AnormalEdit.aspx?name=Anormal_Edit&ID=" + idStr + "&Flag=3";
            window.open(openWinUrl);
        }

        //刷新 
        function refresh() {
            document.forms[0].submit();
        }

        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            if (idStr.indexOf(",") == -1) {
                var cellText = getOneRecordCellTextByFiled("Status");
                if (cellText == "已关闭") {
                    alert("该异常已关闭，不能删除!");
                    return false;
                }
            }
            hdnOperate.val("Delete");
            hdnIdString.val(idStr);
            refresh();
        }

        function UpdateList(AnormalTypeName) {
            refresh();
        }

        function Export() {
            hdnOperate.val("exportExcel");
            document.forms[0].submit();
            hdnOperate.val("");
        }

        //选择ChoosePage
        function openChoosePage(flag, pageId, title, multiple, pageCondition) {
            chooseFlag = flag;
            multiple = multiple || false;
            title = title || "";
            pageCondition = pageCondition || "";
            dialog({ title: title, src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot%>/Framework/ChoosePage.aspx?PageId=" + pageId + "&Multiple=" + multiple + "&PageCondition=" + pageCondition + "&CallBackFunc=setChoosePageValue&rnd=" + Math.random(), width: 680, height: 350 });
        }

        //设置ChoosePage返回值
        function setChoosePageValue(list) {
            if (chooseFlag == 1) {          //选择异常类型
                $('#<%=this.txtAnormalTypeName.ClientID%>').val(list[0][1]);
                $('#<%=this.txtAnormalName.ClientID%>').val("");
            }
            if (chooseFlag == 2) {          //选择线别
                $('#<%=this.txtLineName.ClientID%>').val(list[0][1]);
            }
            if (chooseFlag == 3) {          //选择线别
                $('#<%=this.txtAnormalName.ClientID%>').val(list[0][1]);
            }
        }
        //选择异常名称
        function openChooseAnormalPage() {
            var txtAnormalTypeName = $('#<%=this.txtAnormalTypeName.ClientID%>').val();
            var pageCondition = "";
            pageCondition = "AnormalGroupName='" + txtAnormalTypeName + "'";
            openChoosePage(3, 702, '选择异常名称', false, pageCondition);
        }

    </script>
</asp:Content>
