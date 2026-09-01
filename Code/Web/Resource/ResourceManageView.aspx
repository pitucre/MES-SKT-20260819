<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/EditMaster.master" CodeBehind="ResourceManageView.aspx.cs" Inherits="SKT.LeanMES.Web.Resource.ResourceManageView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">

    <div style="min-width: 600px; min-height: 300px;">

        <div class="wrap_tb">

            <div class="tb_c">
                <table class="EditeContentTable" id="tblExpand" width="100%">

                    <tr>
                        <td class="Label2">产品编码
                        </td>
                        <td class="Field2">
                            <asp:Label runat="server" ID="lblItemCode"></asp:Label>

                        </td>
                        <td class="Label2">产品名称
                        </td>
                        <td class="Field2">
                            <asp:Label runat="server" ID="lblItemName"></asp:Label>
                        </td>
                    </tr>
                    <tr>

                        <td class="Label2">产品规格 
                        </td>
                        <td class="Field2">
                            <asp:Label runat="server" ID="lblItemSpec"></asp:Label>
                        </td>
                        <td class="Label2">工序 
                        </td>
                        <td class="Field2">
                            <asp:Label runat="server" ID="lblStation"></asp:Label>
                        </td>
                    </tr>
                    <tr>

                        <td class="Label2">线别 </td>
                        <td class="Field2">
                            <asp:Label runat="server" ID="lblCenter"></asp:Label>
                        </td>
                        <td class="Label2">资源 
                        </td>
                        <td class="Field2">
                            <asp:Label runat="server" ID="lblResource"></asp:Label>
                        </td>
                    </tr>
                    <%-- <tr>
                        <td class="Label2"><%= Resources.lang.EquipmentCode %> </td>
                        <td class="Field2">
                            <asp:TextBox ID="txtEqCode" runat="server" CssClass="TextBox"
                                ReadOnly="true"></asp:TextBox><input type="button" id="btnEquipmentCode" class="ButtonBox"
                                    value="..." onclick="selectEquiment()" title="选择设备" />
                              <asp:HiddenField ID="hdnEquimentId" runat="server" Value="-1" ClientIDMode="Static" />
                        </td>
                        <td class="Label2"><%= Resources.lang.EquipmentName %> </td>
                        <td class="Field2">
                            <asp:Label runat="server" ID="lblEqName"></asp:Label>

                        </td>
                    </tr>--%>
                    <%--<tr>
                        <td class="Label2">线别 </td>
                        <td class="Field2" colspan="3">
                            <asp:TextBox ID="txtLineName" runat="server" CssClass="TextBox" Enabled="false" ClientIDMode="Static" ></asp:TextBox><input
                                type="button" id="btnSelectDefaultOpt" class="ButtonBox" value="..." title="选择线别"
                                onclick="selectLine();" />
                            <asp:HiddenField ID="hdnLineId" runat="server" Value="-1" ClientIDMode="Static" />
                        </td>

                    </tr>--%>
                    <tr>
                        <td class="Label2">前置时间 </td>
                        <td class="Field2">
                            <asp:Label runat="server" ID="lblFrontTime"></asp:Label>
                            <asp:DropDownList runat="server" ID="drpFrontTime" ClientIDMode="Static">
                               <asp:ListItem Value="Minute" Text="<%$ Resources:lang,Min %>"></asp:ListItem>
                                <asp:ListItem Value="Second" Text="<%$ Resources:lang,Second %>"></asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td class="Label2">后置时间 
                        </td>
                        <td class="Field2">
                            <asp:Label runat="server" ID="lblPostTime"></asp:Label>
                            <asp:DropDownList runat="server" ID="drpPostTime" ClientIDMode="Static">
                                <asp:ListItem Value="Minute" Text="<%$ Resources:lang,Min %>"></asp:ListItem>
                                <asp:ListItem Value="Second" Text="<%$ Resources:lang,Second %>"></asp:ListItem>
                            </asp:DropDownList>
                        </td>

                    </tr>
                    <tr>
                        <td class="Label2">产能 
                        </td>
                        <td class="Field2">
                            <asp:Label runat="server" ID="lblCapacity"></asp:Label>
                            <asp:DropDownList runat="server" ID="drpCapacity" ClientIDMode="Static">
                                <asp:ListItem Value="Minute">Minute</asp:ListItem>
                                <asp:ListItem Value="Hour">Hour</asp:ListItem>
                                <asp:ListItem Value="Day">Day</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td class="Label2">工作效率因子 
                        </td>
                        <td class="Field2">
                            <asp:Label runat="server" ID="lblEfficiencyFactor"></asp:Label>
                        </td>

                    </tr>

                    <tr>

                        <td class="Label2">优先级 
                        </td>
                        <td class="Field2" colspan="3">
                            <asp:Label runat="server" ID="lblPriority"></asp:Label>
                        </td>


                    </tr>
                    <tr>
                        <td class="Label2">
                            <%=Resources.lang.Description%>
                        </td>
                        <td class="Field2" colspan="3">
                            <asp:Label runat="server" ID="lblRemark"></asp:Label>
                        </td>

                    </tr>
                </table>
            </div>
        </div>
    </div>
    <link href="../Content/plugin/tabs/tabs.css" rel="stylesheet" type="text/css" />
    <script src="../Content/plugin/tabs/jPlugin-tabs.js" type="text/javascript"></script>
    <script type="text/javascript">
        function Edit() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Resource/ResourceManageEdit.aspx?name=Resource_ResourceManageEdit&ID=" + '<%= Request.QueryString["ID"] %>' + "&inMenu=true";
            location.href = openWinUrl;
        }

    </script>
</asp:Content>
