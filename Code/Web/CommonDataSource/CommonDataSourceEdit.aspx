<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/EditMaster.master"
    CodeBehind="CommonDataSourceEdit.aspx.cs" Inherits="SKT.LeanMES.Web.CommonDataSource.CommonDataSourceEdit" %>

<%@ MasterType VirtualPath="~/Masters/EditMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">

    <div class="wrap_tb" style="min-height: 350px; min-width: 600px">
        <ul class="tb">
            <li class="current" title="数据源基本信息">
                数据源基本信息
            </li>
        </ul>
        <!--基本信息-->
        <div class="tb_c">
            <div class="infoTips">
                <%=Resources.Messages.WithAsteriskIsRequired %> &nbsp 报表和看板模块不支持语句类型数据源。
            </div>
            <table width="100%" class="EditeContentTable">
                <tr>
                    <td class="Label1" align="left">
                        数据源类型：
                    </td>
                    <td class="Field1" align="left">
                        <select class="ddlDbType" id="ddlDbType" runat="server" clientidmode="Static">
                            <option value="SqlText" selected="selected">语句</option>
                            <option value="Table">表格/视图</option>
                            <option value="Procedure">存储过程</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td class="Label1" align="left">
                        使用分类：
                    </td>
                    <td class="Field1" align="left">
                        <select class="ddlUseType" id="ddlUseType" runat="server" clientidmode="Static">
                            <option value="Common">通用</option>
                            <option value="UIModel">UI模板</option>
                            <option value="Report">报表</option>
                            <option value="Board">看板</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td class="Label1" align="left">
                        逻辑分类：
                    </td>
                    <td class="Field1" align="left">
                        <select class="ddlLogicType" id="ddlLogicType" runat="server" clientidmode="Static">
                            <option value="Table">列表</option>
                            <option value="Logic">逻辑</option>
                        </select>
                    </td>
                </tr>

                <tr>
                    <td class="Label1" align="left">
                        数据源名称：<em>*</em>
                    </td>
                    <td class="Field1" align="left">
                        <asp:TextBox ID="txtName" runat="server" CssClass="TextBox" IsRequired="1" MaxLength="20"
                            ClientIDMode="Static" Width="250px">
                        </asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="Label1" align="left">
                        语句正文/存储过程名称：<em>*</em>
                    </td>
                    <td class="Field1" align="left">
                        <asp:TextBox ID="txtSQL" runat="server" Text="" CssClass="TextArea" TextMode="MultiLine"
                            ClientIDMode="Static" Width="250px">
                        </asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="Label1" align="left">
                        备注信息：
                    </td>
                    <td class="Field1" align="left">
                        <asp:TextBox ID="txtRemark" runat="server" Text="" CssClass="TextArea" TextMode="MultiLine"
                            ClientIDMode="Static" Width="250px">
                        </asp:TextBox>
                    </td>
                </tr>
            </table>
            <div class="clear5"></div>

        </div>
        <!--tab2-->
        <div>

        </div>
    </div>

    <script type="text/javascript">
        var dbSrcId = '<%=Request.QueryString["ID"] %>';
        var userName = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>';

        $(document)
            .ready(function() {
            
            });

        function Save() {
            if ($("#ddlDbType").val() === 'SqlText' &&
            ($("#ddlUseType").val() === 'Report' || $("#ddlUseType").val() === 'Board')) {
                alert('抱歉，报表、看板模块不支持语句类型数据源。');
                return false;
            }
            if (!checkRun()) return false;  //检查正文内容
            var srcName = $("#txtName").val();
            var srcUseType = $("#ddlUseType").val();
            var srcDbType = $("#ddlDbType").val();
            var srcText = $("#txtSQL").val();
            var srcRemark = $("#txtRemark").val();
            var srcLogicType = $("#ddlLogicType").val();
            var entity = {};
            entity.DataSourceID = dbSrcId;
            entity.DataSourceName = srcName;
            entity.DataSourceDesc = srcRemark;
            entity.DataSourceType = srcLogicType;
            entity.SQLType = srcDbType;
            entity.SQLInfo = srcText;
            entity.UseType = srcUseType;
            entity.CreateBy = userName;
            entity.ModifyBy = userName;
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxCommDataSource.SaveEdit(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            else {
                alert("<%= Resources.Messages.SaveInSuccess %>");
            }
            parent.window.UpdateList(srcName);
        }

        function checkRun() {
            if ($("#txtSQL").val().trim() === "") {
                alert("请输入语句正文或存储过程名称");
                return false;
            }
            var dbType = $("#ddlDbType").val();
            var sqlText = $("#txtSQL").val();
            var ajaxService = SKT.LeanMES.Web.AjaxServices.AjaxCommDataSource.CheckSqlText(dbType, sqlText);
            if (ajaxService.error != null) {
                alert(ajaxService.error.Message);
                return false;
            }
            //alert(ajaxService.value);
            return ajaxService.value;
        }


    </script>
</asp:Content>
