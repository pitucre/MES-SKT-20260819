<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="ItemBomSubsItemEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Product.ItemBomSubsItemEdit" %>

<%@ Import Namespace="Resources" %>
<%@ Import Namespace="SKT.LeanMES.Web" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">

    <%--<div style="width:100%;text-align:center; margin:5px 0px 5px 0px;">物料编码&nbsp;&nbsp; <asp:TextBox ID="TextBox1" runat="server" CssClass="TextBox" IsRequired='1' ReadOnly="true"
                    ClientIDMode="Static"></asp:TextBox><input type="button" id="btnSelectItem" class="ButtonBox" value="..." title="Select"
                    onclick="openChoosePage(1);" />
                <asp:HiddenField ID="HiddenField1" runat="server" Value="-1" ClientIDMode="Static" /> 
        &nbsp;&nbsp;<input title="查询" class="SearchButton" id="searchSubmit" onclick="return btSearch()" type="submit" value="查询">
    </div>--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">BOM名称
            </td>
            <td class="Field2">
                <asp:Label ID="lblBomName" runat="server"></asp:Label>
            </td>
            <td class="Label2">
                <%=Resources.lang.Revision%>
            </td>
            <td class="Field2">
                <asp:Label ID="lblVersion" runat="server"></asp:Label>
                (<asp:Label ID="lblIsCurrentRev" runat="server"></asp:Label>)   
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.ItemCode %>
            </td>
            <td class="Field2">
                <asp:Label ID="lblItemCode" runat="server"></asp:Label>
            </td>
            <td class="Label2">
                <%=Resources.lang.ItemsName %>
            </td>
            <td class="Field2">
                <asp:Label ID="lblItemName" runat="server" Text=""></asp:Label>
            </td>
        </tr>

    </table>
    <table class="ListTable" id="tbCompentList" style="border-width: 0px; width: 100%; border-collapse: collapse; margin-top: 5px;"
        cellspacing="0" cellpadding="2">
        <tbody>
            <tr class="ListTableHeader">
                <th style="width: 45px;" scope="col">序号
                </th>
                <th scope="col">物料编码
                </th>
                <th style="width: 80px;" scope="col">单位用量
                </th>
                <th style="width: 50px;" scope="col">单位
                </th>
                <th style="width: 120px;" scope="col">替代料
                </th>
                <th style="width: 80px;" scope="col">操作
                </th>
            </tr>
        </tbody>
    </table>

    <script type="text/javascript">
        var rowObj = {};
        var rowSeq = 0;
        var list = [{ "ItemBomChildId": 35874, "ItemCode": "JIT-M-P-01", "IsRep": "0", "Units": "PCS", "Qty": "10" },
                    { "ItemBomChildId": 35874, "ItemCode": "JIT-M-P-01", "IsRep": "1", "Units": "PCS", "Qty": "10" }
        ];

        loadTable(list);

        function loadTable(list) {
            var row, cell;
            var entity = {};
            var flage = "";
            var entityAry = list;
            var setTable = document.getElementById("tbCompentList");

            if (entityAry == null || entityAry.length == 0) {
                row = setTable.insertRow(1);
                row.className = 'ListTableOddRow';
                cell = row.insertCell(0);
                cell.align = "center";
                cell.colSpan = "6";
                cell.innerHTML = "没有记录！";

                return false;
            }

            if (entityAry.length > 0) {

                /***动态创建表***/
                for (var i = 0; i < entityAry.length; i++) {
                    entity = entityAry[i];
                    row = setTable.insertRow(setTable.rows.length);
                    if (i % 2 == 0) {
                        row.className = 'ListTableOddRow';
                    }
                    else {
                        row.className = 'ListTableEvenRow';
                    }
                    //                    row.onclick = function(){ try{clk(this);}catch (ex){} };
                    row.onmouseover = function () { try { mi(this); } catch (ex) { } };
                    row.onmouseout = function () { try { mo(this); } catch (ex) { } };
                    //                    row.ondblclick = function(){ try{dblClk(this);}catch (ex){} };

                    cell = row.insertCell(0);
                    cell.align = "center";
                    cell.innerHTML = i + 1;

                    cell = row.insertCell(1);
                    cell.align = "center";
                    cell.innerHTML = (entity.IsRep == 0) ? "<input type='hidden' name = 'ItemBomChild' value='" + entity.ItemBomChildId + "'/>" + entity.ItemCode : "<input type=\"text\" name=\"txtItemCode\"  style=\"width:140px;\"   value=\"" +
            entity.ItemCode +
            "\" disabled=\"disabled\">" +
            "<input type=\"button\" id=\"btnSelectItems\" onclick=\"selChoosePage('Item',this);\" class='ButtonBox chkEditableBOM'  value=\"...\"  />";;

                    cell = row.insertCell(2);
                    cell.align = "center";
                    cell.innerHTML = entity.Qty;

                    cell = row.insertCell(3);
                    cell.align = "center";
                    cell.innerHTML = entity.Units;
                    cell = row.insertCell(4);
                    cell.align = "center";
                    cell.innerHTML = (entity.IsRep == 0) ? "<a href='#' onclick='' >新增替代料</a>" : "替代料";

                    cell = row.insertCell(5);
                    cell.align = "center";
                    cell.innerHTML = "<a href='#' onclick='' >删除</a>";
                }
            }
        }

        function selChoosePage(type, obj) {
            if (typeof type === 'undefined' || type === "") {
                return false;
            }
            if (type === 'Item') {
                this.chooseType = 'Item';
                rowObj = obj.parentElement.parentElement;
                dialog({
                    title: "<%= Common.ChooseWindow %>",
                src: "<%= WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=1&Multiple=false&rnd=" +
                    Math.random(),
                width: 550,
                height: 280
            });
        }
        else {
            return false;
        }
    }

    function getChooseValue(list) {
        rowObj.cells[1].children[0].value = list[0][2]; //ItemCode
        rowObj.cells[1].children[0].value = list[0][0]; //ItemID
    }
    </script>
</asp:Content>
