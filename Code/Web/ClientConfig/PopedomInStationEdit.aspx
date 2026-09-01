<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="PopedomInStationEdit.aspx.cs" Inherits="SKT.LeanMES.Web.ClientConfig.PopedomInStationEdit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
<div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired%></div>
    <table width="100%" class="EditeContentTable">        
        <tr>
            <td class="Label1">
                <%=Resources.lang.StationType %><em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtStationType" runat="server" CssClass="TextBox" Enabled="false" IsRequired="1" ></asp:TextBox><input
                    type="button" runat="server" id="btnSelectStationType" class="ButtonBox" value="..."
                    title="<%=Resources.lang.ChooseType %>" onclick="selectStationType();" />
                <asp:HiddenField ID="hdnStationTypeId" runat="server" Value="-1" />
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%=Resources.lang.Station %>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtStation" runat="server" CssClass="TextBox" Enabled="false"></asp:TextBox><input
                    type="button" runat="server" id="btnSelectStation" class="ButtonBox" value="..."
                    title="<%=Resources.lang.Choose%>" onclick="selectStation();" />
                <asp:HiddenField ID="hdnStationId" runat="server" Value="-1" />
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%=Resources.lang.TemplateName %><em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtNewTemp" runat="server" CssClass="TextBox" Enabled="false"
                    IsRequired='1' ClientIDMode="Static"></asp:TextBox><input type="button" id="btnSelectTemp"
                        class="ButtonBox" value="..." title="Select" onclick="selectNewTemplate();" />
                <asp:HiddenField ID="hdnNewTemplate" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
        </tr>
       
    </table>
    <asp:HiddenField ID="hdnPopedomInStationId" runat="server" Value="-1" />
    <script type="text/javascript">

        var chooseFlag = 0;

        /**
         *选择工序类型
         */
        function selectStationType() {
            chooseFlag = 1;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=4&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }

        /**
         *选择Station
         */
        function selectStation() {
            chooseFlag = 2;
            var stationTypeId = $.trim($("#<%=hdnStationTypeId.ClientID %>").val());
            //var searchCondition = " (1=1) ";
            var searchCondition = "";

            //未选中工序类型时显示所有工序
            if (stationTypeId == "-1" || stationTypeId == "") {
               // searchCondition = " (1=1) ";
            }
            else {
                searchCondition = " StationTypeId = " + stationTypeId;
            }
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=8&PageCondition=" + searchCondition + "&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }

        /**
         *返回值
         */
        function getChooseValue(list) {
            if (chooseFlag == 1) {
                $("#<%=this.txtStationType.ClientID %>").val(list[0][1]);
                $("#<%=this.hdnStationTypeId.ClientID %>").val(list[0][0]);
                //设置对应的工序为空

                $("#<%=this.txtStation.ClientID %>").val('');
                $("#<%=this.hdnStationId.ClientID %>").val('-1');
            }
            else if (chooseFlag == 2) {
                $("#<%=this.txtStation.ClientID %>").val(list[0][1]);
                $("#<%=this.hdnStationId.ClientID %>").val(list[0][0]);
                //如果工序类型未选择，则带出工序类型
                var stationTypeId = $.trim($("#<%=hdnStationTypeId.ClientID %>").val());
                if (stationTypeId == "-1" || stationTypeId == "") {
                    var stationType = list[0][2];
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxStation.GetStationType(stationType);
                    if (ajax.error != null) {
                        alert(ajax.error.Message);
                    }
                    else {
                        var result = ajax.value;
                        if (result) {
                            $("#<%=this.txtStationType.ClientID %>").val(stationType);
                            $("#<%=this.hdnStationTypeId.ClientID %>").val(result.StationTypeId);
                        }
                    }
                }
            }
            chooseFlag = 0;
        }

        var popedomInStationId = $("#<%=this.hdnPopedomInStationId.ClientID %>").val(); ;
        /*保存数据*/
        function Save() {
            var txtStationTypeId = $("#<%=this.hdnStationTypeId.ClientID %>").val();
            var txtStationId = $("#<%=this.hdnStationId.ClientID%>").val();
            var txtTemplateId = $("#<%=this.hdnNewTemplate.ClientID%>").val();
            var txtCreateBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
            var txtModifyBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
            
            /*表单验证*/
            /*如需表单验证可以此处处理验证 开始*/
            if (txtStationTypeId == undefined || txtStationTypeId === "-1") {
                alert('<%=Resources.lang.StationType %>' + '<%=Resources.Messages.NotNull%>');
                return false;
            }


            var entity = {};
            entity.PopedomInStationId = popedomInStationId;
            entity.StationTypeId = txtStationTypeId;
            entity.StationId = txtStationId;
            entity.Popedom = txtTemplateId;
            entity.CreateBy = txtCreateBy;
            entity.ModifyBy = txtModifyBy;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxClientConfig.PopedomInStationEdit(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert('<%=Resources.Messages.SaveInSuccess%>')
            if ('<%=Request.QueryString["inMenu"] %>' == "true") {
                openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/User/UserEdit.aspx?name=Account_UserEdit&ID=" + parseInt(ajax.value);
                location.href = openWinUrl;
            }
            else {
                parent.window.Refresh();
            }
        }

        function selectNewTemplate() {
            flag = 12;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=121&CallBackFunc=setTemplate&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }

        function setTemplate(list) {
            $("#hdnNewTemplate").val(list[0][1]);
            $("#txtNewTemp").val(list[0][2]);
        }
    </script>

</asp:Content>
