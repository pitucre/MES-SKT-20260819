<%@ Page Language="C#" MasterPageFile="~/Masters/Masters.master" AutoEventWireup="true" CodeBehind="PlanMaterialHomogeneityDetail.aspx.cs" Inherits="SKT.LeanMES.Web.Plan.PlanMaterialHomogeneityDetail" %>

<%@ MasterType VirtualPath="~/Masters/Masters.master" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">BOM物料编码
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtItemName" runat="server" CssClass="TextBox" ClientIDMode="Static">
                </asp:TextBox><input type="button" id="Button1" runat="server" class="ButtonBox"
                    value="..." title="Select" onclick="openChoosePage(1);" />
                <asp:HiddenField ID="hdnItemId" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
        </tr>
        <tr>
            <td class="Field3" style="border-right: 0px; text-align: right;">
                <div style="padding: 4px 0px">
                    <input type="button" id="searchSubmit" value="<%=Resources.lang.Search %>" onclick="doSearch()"
                        class="SearchButton" title="<%=Resources.lang.Search %>" />
                </div>
            </td>
            <td class="Field3" style="border-left: 0px;">
                <div style="padding: 4px 0px">
                    <input type="button" id="btnClear" value="清空" onclick="clearSearch()" class="SearchButton"
                        title="清空查询条件" />
                </div>
            </td>
        </tr>
    </table>
    <table class="ListTable" width="100%" id="kanbanList" border="1">
        <thead>
            <tr class="ListTableHeader">
                <th>工单号
                </th>
                <th>排产号
                </th>
                <th>计划生产数
                </th>
                <th>产品编码</th>
                <th>产品名称
                </th>
                <th>BOM物料编码
                </th>
                <th>BOM物料名称
                </th>
                <th>单位
                </th>
                <th>BOM用量
                </th>
                <th>计划需求总数
                </th>
                <th>可用数量
                </th>
                <th>缺料数
                </th>
                <th>齐套状态
                </th>
            </tr>
        </thead>
        <tbody></tbody>
    </table>
    <script type="text/javascript">

        $(function () {
            //获取数据
            GetList();
            //$(window).unload(function () {
            //window.parent.Refresh();
            //window.parent.document.getElementById("ifmcenterPlan_PlanList").contentWindow.Refresh();
            //});

            //物料编码回车事件
            $("#txtItemName").enterKey(function () {
                GetList();
            });

        });
        

        //查询
        function doSearch() {
            GetList();
        }

        //获取数据
        function GetList() {
            var entity = {};
            entity.FBILLNO = "<%=Request.QueryString["planNo"] %>";
            entity.BomItemCode = $.trim($("#txtItemName").val());
            if (entity.FBILLNO == "") {
                alert("未获取到排产号");
                return;
            }
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPlan.GetMaterialHomogeneity(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return;
            } else {
                var list = ajax.value;
                var hl = "";
                var className = "";
                var red = "";
                for (var i = 0; i < list.length; i++) {
                    className = i % 2 == 0 ? "ListTableOddRow" : "ListTableEvenRow";
                    red = list[i].HomogeneityStatus != "齐套" ? "color:red" : "";
                    hl += "<tr class=\"" + className + "\" style=\"" + red + "\"><td>" + list[i].OrderNo + "</td>"
                            + "<td>" + list[i].FBILLNO + "</td>"
                            + "<td>" + list[i].FQty + "</td>"
                            + "<td>" + list[i].ItemCode + "</td>"
                            + "<td>" + list[i].ItemName + "</td>"
                            + "<td>" + list[i].BomItemCode + "</td>"
                            + "<td>" + list[i].BomItemName + "</td>"
                            + "<td>" + list[i].BomUnits + "</td>"
                            + "<td>" + list[i].PerNum + "</td>"
                            + "<td>" + list[i].NeedQty + "</td>"
                            + "<td>" + list[i].BalanceQty + "</td>"
                            + "<td>" + list[i].LackQty + "</td>"
                            + "<td>" + list[i].HomogeneityStatus + "</td></tr>";
                }
                $(".ListTable tbody").html(hl);
            }
        }

        function openChoosePage(flag) {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=" + flag + "&Multiple=false&rnd=" + Math.random(), width: 680, height: 400 });
        }

        function getChooseValue(list) {
            $("#txtItemName").val(list[0][2]);
            $("#hdnItemId").val(list[0][0]);
        }

        //清空
        function clearSearch() {
            $("#txtItemName").val("");
            $("#hdnItemId").val("");
            GetList();
        }



    </script>
</asp:Content>
