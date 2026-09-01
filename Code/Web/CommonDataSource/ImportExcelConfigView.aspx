<%@ Page Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="true" CodeBehind="ImportExcelConfigView.aspx.cs" Inherits="SKT.LeanMES.Web.CommonDataSource.ImportExcelConfigView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="Server">
    <div class="wrap_tb" style="min-height: 350px; min-width: 600px">
        <ul class="tb">
            <li class="current" title="导入数据配置信息">导入数据配置信息
            </li>
        </ul>
        <!--基本信息-->
        <div class="tb_c">
            <div class="infoTips">
                <%=Resources.Messages.WithAsteriskIsRequired %> &nbsp
            </div>
            <table width="100%" class="EditeContentTable">
                <tr>
                    <td class="Label1" align="left">导入表名称：
                    </td>
                    <td class="Field1" align="left">
                        <label ID="lblIdcName" runat="server" style="width:300px"></label>
                    </td>
                </tr>
                <tr>
                    <td class="Label1" align="left">导入数据模板：
                    </td>
                    <td class="Field1" align="left">
                        <label id="lblFileNames" runat="server" style="width:300px"></label>
                    </td>
                </tr>
                <tr>
                    <td class="Label1" align="left">导入数据存储过程名称：
                    </td>
                    <td class="Field1" align="left">                            
                       <label id="lblProcName" runat="server" style="width:300px"></label>
                    </td>
                </tr>
                <tr>
                    <td class="Label1" align="left">备注信息：
                    </td>
                    <td class="Field1" align="left">
                        <label id="lblRemark" runat="server" style="width:300px"></label>
                    </td>
                </tr>
            </table>
            <div class="clear5"></div>
            <input type="hidden" id="hdnOperate" name="hdnOperate" value="Eidt" />
            <input type="hidden" id="hdnId" name="hdnId" value="-1" />
        </div>
        <!--tab2-->
        <div>
        </div>
    </div>
    <script type="text/javascript">
        function Edit() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/CommonDataSource/ImportExcelConfigEdit.aspx?name=ImportExcelConfigEdit&ID=" + '<%= Request.QueryString["ID"] %>';
            location.href = openWinUrl;
        }
    </script>
</asp:Content>
