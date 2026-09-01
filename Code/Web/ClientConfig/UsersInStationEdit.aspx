<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="UsersInStationEdit.aspx.cs" Inherits="SKT.LeanMES.Web.ClientConfig.UsersInStationEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
<div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired%></div>
    <table width="100%" class="EditeContentTable">
        
        <tr>
            <td class="Label1">
                用户名<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtUserName" runat="server" CssClass="TextBox" Enabled="false" ClientIDMode="Static"
                    IsRequired='1'></asp:TextBox><input type="button" runat="server" id="btnSelectUser"
                        class="ButtonBox" value="..." title="<%=Resources.lang.ChooseType %>" onclick="selectUser();" />
                <asp:HiddenField ID="hdnUserId" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%=Resources.lang.Station %><em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtStation" runat="server" CssClass="TextBox" Enabled="false" ClientIDMode="Static"
                    IsRequired='1'></asp:TextBox><input type="button" runat="server" id="btnSelectStation"
                        class="ButtonBox" value="..." title="选择工序" onclick="selectStation();" />
                <asp:HiddenField ID="hdnStationId" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%=Resources.lang.Line%><em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtLineName" runat="server" CssClass="TextBox" Enabled="false" ClientIDMode="Static"
                    IsRequired='1'></asp:TextBox><input type="button" id="btnSelectDefaultOpt" class="ButtonBox"
                        value="..." title="选择线别" onclick="selectLine();" />
                <asp:HiddenField ID="hdnLineId" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
        </tr>
        <tr>
            <td class="Label2">
                资源<em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtResource" runat="server" CssClass="TextBox" Enabled="false" ClientIDMode="Static"
                    IsRequired='1'></asp:TextBox><input type="button" id="btnSelectResource" class="ButtonBox"
                        value="..." title="Select" onclick="selectResource();" />
                <asp:HiddenField ID="hdnResId" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
        </tr>
        <tr>
            <td class="Label2">
                默认资源
            </td>
            <td class="Field2">
                <input type="checkbox" id="chkIsDefault" runat="server" ClientIDMode="Static" />&nbsp;默认
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        var flag = -1;
        var usersInStationId = '<%=Request.QueryString["ID"] %>';

        /*
        *选择用户
        */
        function selectUser() {
            flag = 1;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=12&Multiple=false&rnd=" + Math.random(), width: 650, height: 300 });
        }

        /*
        *选择工序
        */
        function selectStation() {
            flag = 2;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=8&Multiple=false&rnd=" + Math.random(), width: 650, height: 300 });
        }

        /*
        *选择线别
        */
        function selectLine() {
            flag = 3;
            var searchCondition = "";
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=21&Multiple=false" + searchCondition + "&rnd=" + Math.random(), width: 650, height: 300 });
        }

        /*
        *选择资源
        */
        function selectResource() {
            flag = 4;
            var searchCondition = "";
            var lineId = $("#hdnLineId").val();
            if (lineId > 0) {
                searchCondition = " LineId = " + lineId;
            }
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=6&Multiple=false&SearchCondition=" + searchCondition + "&rnd=" + Math.random(), width: 600, height: 300 });
        }

        /*
        *获取选择窗值
        */
        function getChooseValue(list) {
            if (flag == 1) {
                //获取用户信息
                $("#txtUserName").val(list[0][2]);
                $("#hdnUserId").val(list[0][0]);
            }
            else if (flag == 2) {
                //获取工序信息
                $("#txtStation").val(list[0][1]);
                $("#hdnStationId").val(list[0][0]);
            }
            else if (flag == 3) {
                //获取线别信息
                $("#txtLineName").val(list[0][1]);
                $("#hdnLineId").val(list[0][0]);

                $("#txtResource").val("");
                $("#hdnResId").val(-1);
            }
            else if (flag == 4) {
                //获取资源信息
                $("#txtResource").val(list[0][1]);
                $("#hdnResId").val(list[0][0]);
            }
        }

        /*
        * 保存用户与工序关联信息
        */
        function Save() {
            var userId = $("#hdnUserId").val();
            var stationId = $("#hdnStationId").val();
            var lineId = $("#hdnLineId").val();
            var resId = $("#hdnResId").val();
            var isDeafult = $("#chkIsDefault").is(":checked");            
            var entity = {};
            entity.UsersInStationId = usersInStationId;
            entity.UserId = userId;
            entity.StationId = stationId;
            entity.LineId = lineId;
            entity.ResId = resId;
            entity.IsDefault = (isDeafult == true ? 1 : 0);
            
            /*Save Event*/
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxClientConfig.UsersInStationEdit(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert("<%=Resources.Messages.SaveInSuccess %>");

            window.parent.Refresh($("#txtUserName").val());      
        }
    </script>
</asp:Content>
