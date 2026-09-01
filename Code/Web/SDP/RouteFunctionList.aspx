<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" 
CodeBehind="RouteFunctionList.aspx.cs" Inherits="SKT.LeanMES.Web.SDP.RouteFunctionList"  Title="Route Activity List"
ValidateRequest="false"%>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">
                路由
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtRouter" runat="server" CssClass="TextBox" Enabled="false" Text=""></asp:TextBox><input
                    type="button" id="btselRouter" runat="server" class="ButtonBox" value="..." title="选择路由" onclick="selectRouter();" />
                <asp:HiddenField ID="hdnRouterId" runat="server" Value="-1" />
                <asp:HiddenField ID="hdnRoute" runat="server" Value="-1" />
            </td>
            <td class="Label2">
                工序
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtStation" runat="server" CssClass="TextBox" Enabled="false" Text=""></asp:TextBox><input
                    type="button" id="Button1" runat="server" class="ButtonBox" value="..." title="选择工序" onclick="selectStation();" />
                    <asp:HiddenField ID="hdnStation" runat="server" Value="-1" />
            </td>
        </tr>        
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">    
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" 
        AutoGenerateColumns="false" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <asp:BoundField DataField="R_Name" HeaderText="路由" HeaderStyle-Width="180px" SortExpression="R_Name"/>
            <asp:BoundField DataField="StationType" HeaderText="工序类别" HeaderStyle-Width="180px" SortExpression="StationType"/>
            <asp:BoundField DataField="Station" HeaderText="工序" HeaderStyle-Width="180px" SortExpression="Station"/>
            <asp:BoundField DataField="StationDesc" HeaderText="工序描述" />
            <asp:TemplateField HeaderText="模板情况">
                <ItemTemplate>
                    <asp:Label ID="lblModelInfo" runat="server" Text=""></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.SDP.BLL.Activity"
        SelectMethod="GetRouteDetail" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <%--<input type="button" onclick="return SetLogic()" value="设置逻辑"/>--%>
    <script type="text/javascript">
        //选择路由
        function selectRouter() {
            chooseFlag = 4;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=22&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }

        function selectStation() {
            chooseFlag = 8;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=8&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }
        
        //返回填充数据
        function getChooseValue(list) {
            if (chooseFlag == 4) { //路由，应该把对应的站点绑定到投入产出下拉框
                $("#<%=this.txtRouter.ClientID %>").val(list[0][1]);
                $("#<%=this.hdnRouterId.ClientID %>").val(list[0][0]);
                $("#<%=this.hdnRoute.ClientID %>").val(list[0][1]);
            }
            else if (chooseFlag == 8) {
                $("#<%=this.txtStation.ClientID %>").val(list[0][1]);
                $("#<%=this.hdnStation.ClientID %>").val(list[0][1]); 
            }
            chooseFlag = -1;
        }

        function SetLogic() {
            if (!checkModelStatus()) {
                return false;
            }

            var idStr = getOneRecordId();
            if (idStr == "") return false;

            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SDP/RouteFunctionSetting.aspx?ID=" + idStr;
            dialog({ title: "逻辑设置", src: openWinUrl, width: 850, height: 550, resizeable: false });
            return false;
        }

        /*得到选中记录的值*/
        function checkModelStatus() {
            var bResult = true;
            var checkboxs = document.getElementsByName("chkSelect");
            var checkboxCount = checkboxs.length;

            for (var i = 0; i < checkboxCount; i++) {
                if (checkboxs[i].checked) {
                    var modelStatus = $.trim($(checkboxs[i]).parent().nextAll().find("span[id*='lblModelInfo']").text());
                    if (modelStatus.indexOf("(自定义)")<=0) {
                        alert("该工序没有绑定新模板,请使用'系统管理->客户端管理->站位权限配置'功能进行绑定！");
                        bResult = false;
                    }
                }
            }

            return bResult;
        }
    </script>
</asp:Content>
