<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="JigHistoryList.aspx.cs" Inherits="SKT.LeanMES.Web.Jig.JigHistoryList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">
                <%=Resources.lang.SearchCondition%>
            </td>
            <td class="Field3">
                <asp:DropDownList ID="ddlOption" runat="server" > 
                    <asp:ListItem Text='' Value=''></asp:ListItem>
                    <asp:ListItem Text='<%$ Resources:lang, GiveBackHistory %>' Value="1"></asp:ListItem>
                    <asp:ListItem Text='<%$ Resources:lang, BorrowHistory %>' Value="2"></asp:ListItem>
                    <asp:ListItem Text='报废历史' Value="3"></asp:ListItem>
                </asp:DropDownList>
            </td>
            <td class="Label3">
                 <%=Resources.lang.StartTime%>
            </td>
            <td class="Field3">
                <input type="text" id="tbBeginTime" runat="server" class="DateTimeBox"/>
            </td>
            <td class="Label3">
             <%=Resources.lang.EndTime%>
            </td>
            <td class="Field3">
                <input type="text" id="tbEndTime" runat="server" class="DateTimeBox"/>
            </td>
        </tr>
        <tr>
            <td class="Label3">
                <%=Resources.lang.JigCode%>
            </td>
            <td class="Field3">
                 <asp:TextBox ID="txtJigCode" CssClass="TextBox"  runat="server"></asp:TextBox>
            </td>
            <td class="Label3">
                 夹具类型
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtJigType" runat="server" CssClass="TextBox"></asp:TextBox>
                <input type="button" id="btnType" class="ButtonBox" value="..." title="选择类型"
                    onclick="selectTypeName();"  runat="server"/>
            </td>
            <td class="Label3">
             <%=Resources.lang.Requestor%>
            </td>
            <td class="Field3">
               <asp:TextBox ID="txtRequestor" CssClass="TextBox"  runat="server"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" ClientIDMode="Static"
        OnRowDataBound="GridView1_OnRowDataBound">
        <Columns>
            <asp:BoundField DataField="JigCode" HeaderText="<%$ Resources:lang,JigCode %>"  ItemStyle-Width="15%"/>
            <asp:BoundField DataField="JigName" HeaderText="<%$ Resources:lang,JigName %>"  ItemStyle-Width="15%"/>
            <asp:BoundField DataField="JigCategory" HeaderText="夹具类型"  ItemStyle-Width="10%"/>
            <asp:BoundField DataField="LineName" HeaderText="<%$ Resources:lang,LineName %>"  ItemStyle-Width="10%"/>
            <asp:BoundField DataField="OperateType" HeaderText="借用/归还/报废"  ItemStyle-Width="10%"/>
            <asp:BoundField DataField="JigType" HeaderText="说明"  ItemStyle-Width="10%"/>
            <asp:BoundField DataField="CName" HeaderText="<%$ Resources:lang,Requestor %>"  ItemStyle-Width="10%"/>
            <asp:BoundField DataField="CreateDateTime" HeaderText="<%$ Resources:lang,CreateDateTime %>"  ItemStyle-Width="15%"/>
            <%--<asp:BoundField DataField="Remark" HeaderText="<%$ Resources:lang,Remark %>"  ItemStyle-Width="10%"/>--%>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Jig.BLL.JigHistory"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value=""  />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script type="text/javascript">
        isMultiple = false;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");

        function Import() {
            hdnOperate.val("ExportExcel");
            document.forms[0].submit();
            hdnOperate.val("");
        }

        function selectTypeName() {
            temp = 3;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=56&Multiple=false&rnd=" + Math.random(), width: 600, height: 400 });
        }

        function getChooseValue(list) {
            if (temp == 3) {
                $("#<%=this.txtJigType.ClientID %>").val(list[0][1]);

            }
        } 
    </script>
</asp:Content>
