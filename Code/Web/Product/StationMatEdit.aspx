<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="StationMatEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Product.StationMatEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <table width="100%" class="EditeContentTable">
        <tr>
            <td style="height: 35px;">
                <%--&nbsp; &nbsp;&nbsp;物料大类
                <asp:DropDownList ID="ddlCategoryOne" runat="server" ClientIDMode="Static" Width="100px">
                    <asp:ListItem Value="-1">所有</asp:ListItem>
                </asp:DropDownList>
                &nbsp;物料中类
                <asp:DropDownList ID="ddlCategoryTwo" runat="server" ClientIDMode="Static" Width="100px">
                    <asp:ListItem Value="-1">所有</asp:ListItem>
                </asp:DropDownList>
                &nbsp;物料小类
                <asp:DropDownList ID="ddlCategoryThree" runat="server" ClientIDMode="Static" Width="100px">
                    <asp:ListItem Value="-1" Text="所有"> </asp:ListItem>
                </asp:DropDownList>--%>
                &nbsp; &nbsp;&nbsp;<%=Resources.lang.MaterialTopclass%>
                <asp:TextBox ID="txtCategoryOne" runat="server" CssClass="TextBox" Width="100px"
                    ClientIDMode="Static"></asp:TextBox><input type="button" id="btnSelectCategory" class="ButtonBox"
                        value="..." title="<%=Resources.lang.ChooseItem %>" onclick="selectCategory(1);" />
                &nbsp;<%=Resources.lang.MaterialMiddleClass%>
                <asp:TextBox ID="txtCategoryTwo" runat="server" CssClass="TextBox" Width="100px"
                    ClientIDMode="Static"></asp:TextBox><input type="button" id="Button1" class="ButtonBox"
                        value="..." title="<%=Resources.lang.ChooseItem %>" onclick="selectCategory(2);" />
                &nbsp;<%=Resources.lang.SubclassMaterial%>
                <asp:TextBox ID="txtCategoryThree" runat="server" CssClass="TextBox" Width="100px"
                    ClientIDMode="Static"></asp:TextBox><input type="button" id="Button2" class="ButtonBox"
                        value="..." title="<%=Resources.lang.ChooseItem %>" onclick="selectCategory(3);" />
                &nbsp;<input type="button" value=" 分类查询 " onclick="searchCategory()" />
            </td>
        </tr>
    </table>
    <div class="clear5">
    </div>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label" style="width: 48%; text-align: center; font-weight: bold; height: 20px;">
                待维护物料信息
            </td>
            <td class="Label" style="width: 6%; text-align: center; height: 20px;">
            </td>
            <td class="Label" style="width: 48%; text-align: center; font-weight: bold; height: 20px;">
                已维护物料信息
            </td>
        </tr>
        <tr style="height: 300px; padding: 2px;" valign="top">
            <td class="Field" align="center" style="width: 48%; vertical-align: top;">
                <div id="loadingmessages1" class="Tips">
                    数据加载中...</div>
                <iframe name="frmMatChooseList" id="frmMatChooseList" frameborder="0" style="width: 99%;
                    height: 400px;" src=""></iframe>
            </td>
            <td class="Field" style="width: 6%; text-align: center; vertical-align: middle;">
                <input type="button" id="btnLeftChoose" runat="server" value="" class="rightButton"
                    onclick="btnChooseOnClick(0);" />
                <br />
                <br />
                <br />
                <br />
                <input type="button" id="btnRightChoose" runat="server" value="" class="leftButton"
                    onclick="btnChooseOnClick(1);" />
            </td>
            <td class="Field" align="center" style="width: 48%; vertical-align: top;">
                <div id="loadingmessages2" class="Tips">
                    数据加载中...</div>
                <iframe name="frmStationInMatList" id="frmStationInMatList" frameborder="0" style="width: 99%;
                    height: 400px;" src=""></iframe>
            </td>
        </tr>
    </table>
    <input type="hidden" value="-1" id="hdnCategoryOne" />
    <input type="hidden" value="-1" id="hdnCategoryTwo" />
    <script type="text/javascript">
        var categoryOne = "";
        var categoryTwo = "";
        var categoryThree = "";

        $(function () {

            // BindItemCategory("ddlCategoryOne", -1);

            var iframe1 = document.getElementById("frmMatChooseList");
            iframe1.src = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + '/Product/StationMatPreList.aspx?ID=<%= Request.QueryString["ID"] %>&cone=' + categoryOne + '&ctwo=' + categoryTwo + '&cthree=' + categoryThree;
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

            var iframe2 = document.getElementById("frmStationInMatList");
            iframe2.src = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + '/Product/StationMatInList.aspx?ID=<%= Request.QueryString["ID"] %>&cone=' + categoryOne + '&ctwo=' + categoryTwo + '&cthree=' + categoryThree;

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

            $("#ddlCategoryOne").bind("change", function () {
                var id = this.value;
                categoryOne = $(this).find("option:selected").text();
                if (id == "-1") {
                    categoryOne = "";
                    $("#ddlCategoryTwo option:gt(0),#ddlCategoryThree option:gt(0)").remove();
                }
                else {
                    BindItemCategory("ddlCategoryTwo", id);
                }
            });

            $("#ddlCategoryTwo").bind("change", function () {
                var id = this.value;
                categoryTwo = $(this).find("option:selected").text();
                if (id == "-1") {
                    categoryTwo = "";
                    $("#ddlCategoryThree option:gt(0)").remove();
                }
                else {
                    BindItemCategory("ddlCategoryThree", id);
                }
            });

            $("#ddlCategoryThree").bind("change", function () {
                var id = this.value;
                categoryThree = $(this).find("option:selected").text();
                if (id == "-1") {
                    categoryThree = "";
                }
            });
        });

        var chooseFlag = 0;
        function selectCategory(flag) {
            chooseFlag = flag;
            var pageCondition = "";
            var parentId = -1;

            if (flag == 1) {
                pageCondition = "ParentId = -1";
            }
            else if (flag == 2) {
                parentId = $("#hdnCategoryOne").val();
                pageCondition = "ParentId !=-1 AND ItemCategoryId IN (SELECT ParentId FROM vwGetCategoryTree)";
                if (parentId != "-1") {
                    pageCondition += " And ParentId=" + parentId;
                }
            }
            else if (flag == 3) {
                parentId = $("#hdnCategoryTwo").val();
                pageCondition = "ParentId !=-1 AND ItemCategoryId NOT IN (SELECT ParentId FROM vwGetCategoryTree)";
                if (parentId != "-1") {
                    pageCondition += " And ParentId=" + parentId;
                }
            }
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=110&PageCondition=" + escape(pageCondition) + "&Multiple=false&rnd=" + Math.random(), width: 550, height: 280 });
        }

        function getChooseValue(list) {
            if (chooseFlag == 1) {
                $("#hdnCategoryOne").val(list[0][0]);
                $("#txtCategoryOne").val(list[0][2]);
                categoryOne = list[0][2];
            }
            else if (chooseFlag == 2) {
                $("#hdnCategoryTwo").val(list[0][0]);
                $("#txtCategoryTwo").val(list[0][2]);
                categoryTwo = list[0][2];
            }
            else if (chooseFlag == 3) {
                $("#hdnCategoryThree").val(list[0][0]);
                $("#txtCategoryThree").val(list[0][2]);
                categoryThree = list[0][2];
            }
        }

        function searchCategory() {
            var iframe1 = document.getElementById("frmMatChooseList");
            iframe1.src = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + '/Product/StationMatPreList.aspx?ID=<%= Request.QueryString["ID"] %>&cone=' + categoryOne + '&ctwo=' + categoryTwo + '&cthree=' + categoryThree;
            var iframe2 = document.getElementById("frmStationInMatList");
            iframe2.src = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + '/Product/StationMatInList.aspx?ID=<%= Request.QueryString["ID"] %>&cone=' + categoryOne + '&ctwo=' + categoryTwo + '&cthree=' + categoryThree;

        }

        function loadingcompleted() {
            $("#loadingmessages1").html("");
        }

        function btnChooseOnClick(index) {
            var IdString;
            var stationId;

            var userName = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>';

            if (index == 0) {
                //document.frames 替换为 window.frames , document.frames只有IE、Opera浏览器支持 chenglong.zhu 2016-11-21 15：58
                //IdString = document.frames[0].window.getSelectedValues();
                //stationId = document.frames[1].window.stationId;
                IdString = window.frames[0].window.getSelectedValues();
                stationId = window.frames[1].window.stationId;
                if (stationId == "-1") {
                    alert("请先选择右侧的工序名称！");
                    return false;
                }
            }
            else {
                //IdString = document.frames[1].window.getSelectedValues();
                IdString = window.frames[1].window.getSelectedValues();
            }

            if (IdString == "") {
                alert("<%= Resources.Messages.RequireOperateRecord %>");
                return false;
            }

            /*维护物料与工序关系，工序ID*/
            if (index == 0) {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxProduct.AddMatStation(stationId, IdString);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return;
                }

            }
            else {/*删除物料与工序关系*/
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxProduct.RemoveMatStation(IdString);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return;
                }
            }
            //document.frames[0].window.document.forms[0].submit();
            //document.frames[1].window.document.forms[0].submit();
            window.frames[0].window.document.forms[0].submit();
            window.frames[1].window.document.forms[0].submit();
        }


        function BindItemCategory(sltId, parentId) {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxProduct.GetItemCategory(parentId);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            var list = ajax.value;
            if (list.length > 0) {
                BindSelect(sltId, list);
            }
        }

        function BindSelect(id, list) {
            $("#" + id).empty();
            $("#" + id).append('<option value="-1">所有</option>');
            for (var i = 0; i < list.length; i++) {

                entity = list[i];
                $("#" + id).append('<option value="'
                           + entity.ItemCategoryId + '">'
                           + entity.CategoryName + '</option>');

            }
        }
    </script>
</asp:Content>
