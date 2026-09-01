<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="PackPrintOutput.aspx.cs" Inherits="SKT.LeanMES.Web.PackPrint.PackPrintOutput" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <style type="text/css">
        .appear
        {
            display: "";
        }
        
        .disappear
        {
            display: none;
        }
    </style>
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%" id="tbPanel" style="margin: 0 auto">
        <tr>
            <td class="Label1">
                清单类型
            </td>
            <td class="Field1">
                <select id="listingTypeDrop" onchange="dropChange()">
                    <option value="0">请选择</option>
                    <option value="1">现票品</option>
                    <option value="2">作业内容标记</option>
                    <option value="5">供应商</option>
                    <option value="6">出货清单</option>
                </select>
            </td>
        </tr>
        <tr class="disappear">
            <td class="Label1">
                <%=Resources.lang.ItemsName %>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtItem" runat="server" CssClass="TextBox" IsRequired='1'></asp:TextBox>
                <input type="button" id="btnSelectItem" class="ButtonBox" value="..." title="<%=Resources.lang.ChooseItem %>"
                    onclick="selectItem(1);" />
                <asp:HiddenField ID="hdnItemId" runat="server" Value="-1" />
                <asp:HiddenField ID="hdnItemcode" runat="server" Value="-1" />
            </td>
        </tr>
        <tr class="disappear">
            <td align="right" class="Label1">
                <span style="color: Red">请输入SN号</span>
            </td>
            <td class="Field1">
                <input type="text" id="SN" />
            </td>
        </tr>
        <tr>
            <td class="Label1">
            </td>
            <td class="Field1">
                <input type="button" value="打印" onclick='print()' />
            </td>
        </tr>
    </table>
    <script type="text/javascript">

        isMultiple = true;
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");
        var option = 0;
        var flag = -1;
        var rowObj = null;
        //增加ListingField 
        var tab = document.getElementById("tbPackLevel");

        function dropChange() {
            if ($("#listingTypeDrop").val() == "1" || $("#listingTypeDrop").val() == "6") {
                $("#tbPanel tr:eq(1)").removeClass("appear");
                $("#tbPanel tr:eq(1)").addClass("disappear");

                $("#tbPanel tr:eq(2)").removeClass("disappear");
                $("#tbPanel tr:eq(2)").addClass("appear");
                $("#SN").focus();
            }
            else {
                $("#tbPanel tr:eq(1)").removeClass("disappear");
                $("#tbPanel tr:eq(1)").addClass("appear");

                $("#tbPanel tr:eq(2)").removeClass("appear");
                $("#tbPanel tr:eq(2)").addClass("disappear");
                $("#SN").val("");
            }
        }

        function GetItemId(SN) { //要求用户输入SN，然后得到工种，然后得到相关字段值
            if (SN == "" || SN == null) {
                return;
            }
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxClient.GetUnitInfo(SN);
            if (ajax.error == null) {
                var entity = ajax.value;
                if (entity != null) {
                    return entity.ItemId;
                } else {
                /* 添加提示信息  chenglong.zhu 2016-11-23 */
                return alert("无当前SN号信息");
                }
            } else {
                return null;
            }
        }

        //展示模板
        function print() {
            var itemId, listingTypeId, row, cell, SN, itemCode;
            listingTypeId = $("#listingTypeDrop").val();
            itemId = $("#<%=this.hdnItemId.ClientID%>").val();
            itemCode = $("#<%=this.hdnItemcode.ClientID%>").val();

            if (listingTypeId == "0") {
                alert("请选择清单类型");
                return;
            }
            if (listingTypeId == "1" || listingTypeId == "6") //现票与出货序列清单要求输入SN
            {
                SN = $("#SN").val();
                if (SN == "") {
                    alert("请输入SN");
                    return;
                }
                else {
                    itemId = GetItemId(SN);
                    if (itemId == null || itemId == "") {
                        return;
                    }
                }
            }
            var openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/PackPrint/PackPrint.aspx?itemId=" + itemId + "&listingTypeId=" + listingTypeId + "&SN=" + SN + "&itemCode=" + itemCode;
            window.open(openWinUrl, "打印", 'height=980, width=1080');
        }

        function selectItem(i) {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=" + i.toString() + "&Multiple=false&rnd=" + Math.random(), width: 550, height: 280 });
        }

        function getChooseValue(list) {            
            if (list[0][0] != "-1") {
                $("#<%=this.txtItem.ClientID %>").val(list[0][1] + "(" + list[0][2] + ")");
            }
            else {
                $("#<%=this.txtItem.ClientID %>").val("");
            }
            $("#<%=this.hdnItemcode.ClientID%>").val(list[0][2]);
            $("#<%=this.hdnItemId.ClientID %>").val(list[0][0]);
        }
    </script>
</asp:Content>
