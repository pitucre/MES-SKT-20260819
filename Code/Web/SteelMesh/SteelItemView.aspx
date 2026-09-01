<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="true"
    CodeBehind="SteelItemView.aspx.cs" Inherits="SKT.LeanMES.Web.SteelMesh.SteelItemView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="server">
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label infoTips" colspan="4">
                <%=Resources.Messages.WithAsteriskIsRequired %>
            </td>
        </tr>
        <tr class="clear5"></tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.ItemName%><em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtItemName" runat="server" CssClass="TextBox" Enabled="false"></asp:TextBox>
                <input type="button" id="btnItemName" class="ButtonBox" value="..." onclick="selectItemName();" />
                <asp:HiddenField ID="hdfItemId" runat="server" Value="-1" />
            </td>
            <td class="Label2">
                <%= Resources.lang.PartItemName%><em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtPartItem" runat="server" CssClass="TextBox" Enabled="false"></asp:TextBox>
                <input type="button" id="Button1" class="ButtonBox" value="..." onclick="selectPartName();" />
                <asp:HiddenField ID="hdfPartId" runat="server" Value="-1" />
            </td>
        </tr>
    </table>
    <div class="clear5">
    </div>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label" style="width: 45%; text-align: center; font-weight: bold;">
                <strong>
                    <label id="lbleft">
                        可选择的钢网
                    </label>
                </strong>
            </td>
            <td class="Label" style="width: 10%; text-align: center;" id="tdMsg">
            </td>
            <td class="Label" style="width: 45%; text-align: center; font-weight: bold;">
                <label id="lbright">
                    已选择的钢网
                </label>
            </td>
        </tr>
        <tr style="height: 300px; padding: 2px;" valign="top">
            <td class="Field" align="center" style="width: 45%; vertical-align: top; overflow:auto; height:360px">
                <div id="loadingmessages1" class="Tips">
                    请选择成品和半成品</div>
                <iframe name="frmUserChooseList" id="frmLeftChooseList" frameborder="0" style="width: 99%;
                    height: 360px;" src=""></iframe>
            </td>
            <td class="Field" style="width: 10%; text-align: center; vertical-align: middle;">
                <input type="button" id="btnLeftChoose" runat="server" value="" class="rightButton"
                    onclick="btnChooseOnClick(0);" />
                <br />
                <br />
                <br />
                <br />
                <input type="button" id="btnRightChoose" runat="server" value="" class="leftButton"
                    onclick="btnChooseOnClick(1);" />
            </td>
            <td class="Field" align="center" style="width: 45%; vertical-align: top; overflow:auto; height:360px">
                <div id="loadingmessages2" class="Tips">
                    请选择成品和半成品</div>
                <iframe name="frmRoleUsersList" id="frmRightUsersList" frameborder="0" style="width: 99%;
                    height: 360px;" src=""></iframe>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        var iframe1 = document.getElementById("frmLeftChooseList");
        var iframe2 = document.getElementById("frmRightUsersList");
        var hid1 = -1;
        var hid2 = -1;
        var temp = 0;
        $(function () {

            if (iframe1.attachEvent) {
                iframe1.attachEvent("onload", function () {
                    $("#loadingmessages1").html("");
                });
            }
            else {
                iframe1.onload = function () {
                    $("#loadingmessages1").html("");
                };
            }

            if (iframe2.attachEvent) {
                iframe2.attachEvent("onload", function () {
                    $("#loadingmessages2").html("");
                });
            }
            else {
                iframe2.onload = function () {
                    $("#loadingmessages2").html("");
                };
            }
        });

        /*选择产品*/
        function selectItemName() {
            temp = 1;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=1&Multiple=false&rnd=" + Math.random(), width: 600, height: 340 });
        }

        /*选择半成品*/
        function selectPartName() {
            temp = 2;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=1&Multiple=false&rnd=" + Math.random(), width: 600, height: 340 });
        }

        function getChooseValue(list) {
            if (temp == 1) {
                hid1 = list[0][0];
                $("#<%=this.txtItemName.ClientID %>").val(list[0][1] + "|" + list[0][2]);
                $("#<%=this.hdfItemId.ClientID %>").val(list[0][0]);

                setTimeout("loadRelationList()", 10);
            }
            else if (temp == 2) {
                hid2 = list[0][0];
                $("#<%=this.txtPartItem.ClientID %>").val(list[0][1] + "|" + list[0][2]);
                $("#<%=this.hdfPartId.ClientID %>").val(list[0][0]);

                setTimeout("loadRelationList()", 10);
            }
        }


        function loadRelationList() {
            if (hid1 <= 0) {
                setMsg("请选择成品！", "red")
                return false;
            }

            if (hid2 <= 0) {
                setMsg("请选择半成品！", "red")
                return false;
            }

            if (hid1 == hid2) {
                setMsg("成品和半成品不能相同！","red")
                return false;
            }

            iframe1.src = "";
            iframe2.src = "";
            setMsg("", "")
            $("#loadingmessages1").html("数据加载中...");
            $("#loadingmessages2").html("数据加载中...");
            iframe1.src = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + '/SteelMesh/SteelChooseList.aspx?itemID=' + hid1 + "&partId=" + hid2 + "&flag=1";
            iframe2.src = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + '/SteelMesh/SteelChooseList.aspx?itemID=' + hid1 + "&partId=" + hid2 + "&flag=2"; ;
        }

        function setMsg(msg, color)
        {
            $("#tdMsg").html(msg).css("color", color);
        }

        /*左右移动,index为0是左向右移，1为右向左移*/
        function btnChooseOnClick(index) {
            /*取到的id字符串*/
            var chooseId = "";
            if ($("#<%=this.hdfItemId.ClientID %>").val() == "-1") {
                setMsg("请选择成品！", "red")
                return false;
            }
            if ($("#<%=this.hdfPartId.ClientID %>").val() == "-1") {
                setMsg("请选择半成品！", "red")
                return false;
            }
            if (index == 0) {
                //chooseId = document.frames[0].window.getSelectedValues(); By BirongLiang @2016-10-27
                chooseId = window.frames[0].window.getSelectedValues();
            }
            else if (index == 1) {
                //chooseId = document.frames[1].window.getSelectedValues();
                chooseId = window.frames[1].window.getSelectedValues();
            }
            if (chooseId == "") {
                alert("<%= Resources.Messages.RequireOperateRecord %>");
                return false;
            }
            //左移到右，添加
            if (index == 0) {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSteelItem.InsertItemSteel(chooseId, parseInt($("#<%=this.hdfItemId.ClientID %>").val()), parseInt($("#<%=this.hdfPartId.ClientID %>").val()));
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
            }
            //右移到左，删除
            else {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSteelItem.DeleteItemSteel(chooseId, parseInt($("#<%=this.hdfItemId.ClientID %>").val()), parseInt($("#<%=this.hdfPartId.ClientID %>").val()));
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
            }

            loadRelationList();

        }
    </script>
</asp:Content>
