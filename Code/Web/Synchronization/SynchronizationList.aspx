<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true"
    CodeBehind="SynchronizationList.aspx.cs" Inherits="SKT.LeanMES.Web.Synchronization.SynchronizationList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">
                业务名称
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtBusinessName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label2">
                <%=Resources.lang.StoredProcedure %>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtProcedure" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" AutoGenerateColumns="false">
        <Columns>
            <asp:BoundField DataField="BusinessName" HeaderText="<%$ Resources:lang, BusinessName %>"
                SortExpression="BusinessName" HeaderStyle-Width="180px" />
            <asp:BoundField DataField="StoredProcedureName" HeaderText="<%$ Resources:lang, StoredProcedureName %>"
                SortExpression="StoredProcedureName" />
            <asp:BoundField DataField="Timeout" HeaderText="<%$ Resources:lang, Timeout %>" SortExpression="Timeout"
                HeaderStyle-Width="60px" />
             <asp:BoundField DataField="CreateBy" HeaderText="创建人"
                SortExpression="CreateBy" />
            <asp:BoundField DataField="CreateTime" HeaderText="创建时间"
                SortExpression="CreateTime" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
            <asp:BoundField DataField="ModifyBy" HeaderText="修改人"
                SortExpression="ModifyBy" />
            <asp:BoundField DataField="ModifyTime" HeaderText="修改时间"
                SortExpression="ModifyTime" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Synchronization.BLL.Synchronization"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <div id="loading" style="display: none; z-index: 111;">
        <div style="background: #cccccc; position: absolute; z-index: 112; top: 0; left: 0px;
            filter: Alpha(opacity=60); -moz-opacity: 0.6; opacity: 0.6;" id="loading-bg">
        </div>
        <div style="position: absolute; top: 35%; left: 35%; z-index: 113; background: #f7f7f7;
            width: 360px; border: 1px solid #333333; height: 65px; line-height: 65px; text-align: center;"
            id="loading-content">
            正在同步数据，请不要关闭页面...
        </div>
    </div>
    <script type="text/javascript">

        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");

        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Synchronization/SynchronizationView.aspx?name=Data_SynchronizationView&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.Data_SynchronizationEdit %>", src: openWinUrl, width: 750, height: 400 });
        }

        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Synchronization/SynchronizationEdit.aspx?name=Data_SynchronizationAdd&ID=-1";
            dialog({ title: "<%=Resources.Pages.Data_SynchronizationAdd %>", src: openWinUrl, width: 750, height: 400 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Synchronization/SynchronizationEdit.aspx?name=Data_SynchronizationEdit&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.Data_SynchronizationEdit %>", src: openWinUrl, width: 750, height: 400 });
        }

        function Refresh() {
            document.forms[0].submit();
        }

        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }

        function Synchronous() {
            var procedureNames = "|";
            var chklist = $("#ContentPlaceHolder1_GridviewContent_GridView1 tbody > tr:has('td:has('input:checked')')");
            $(chklist).each(function (i, elm) {
                var item = $(this);
                var storedProcedureName = item[0].children[2].innerText;
                procedureNames = procedureNames + storedProcedureName + "|";
            });
            if (procedureNames == "|") {
                alert("请选择需要同步的存储过程");
                return false;
            }
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Synchronization/SynchronizationExecute.aspx?name=Execute&ID=" + encodeURIComponent(procedureNames);
            dialog({ title: "<%=Resources.Pages.Data_SynchronizationExecute %>", src: openWinUrl, width: 780, height: 400 });

//            if (confirm("数据同步可能会涉及远程服务器，需要一点时间，在此期间请不要关闭页面。确定现在进行同步数据吗？")) {
//                var chklist = $("#ContentPlaceHolder1_GridviewContent_GridView1 tbody > tr:has('td:has('input:checked')')");
//                $(chklist).each(function (i, elm) {
//                    var item = $(this);


//                    var storedProcedureName = item[0].children[2].innerText;
//                    var timeout = item[0].children[3].innerText;
//                    if (onSynchronization(storedProcedureName, timeout)) {
//                        alert(storedProcedureName + '数据同步成功。 ');
//                    }
//                });
//            }
        }

        function onSynchronization(storedProcedureName, timeout) {
            $("#loading").css("display", "block");
            $("#loading").width($(window).width());
            $("#loading").height($(window).height());
            $("#loading-bg").width($(window).width());
            $("#loading-bg").height($(window).height());
            var parms = [];
            var parm = {};
            parm.ParamName = 'Xj/Ezg5Ydn1vDValcHM1tsVb66OHKhckVXk4ILQ2EvI=';
            parm.ParamSize = 200;
            parm.ParamType = '9gCc5xRAjo9NHpCOpaJi5A==';
            parm.ParamValue = storedProcedureName;
            parms.push(parm);
            var ajax = SKT.AjaxCommon.DBService.ExecuteNonQuery('3squt1RHgnfQqs1q9girlxQdK58Ni1+yg6XJFTJq5fQ=', parms, timeout);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                $("#loading").css("display", "none");
                $("#c").css("display", "block");
                $("#error").html(ajax.error.Message);
                return false;
            }
            $("#loading").css("display", "none");
            return true;
        }
    </script>
</asp:Content>
