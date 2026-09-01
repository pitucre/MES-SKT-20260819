<%@ Page Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="True"
    CodeBehind="ItemIQCParamView.aspx.cs" Inherits="SKT.LeanMES.Web.Product.ItemIQCParamView" Title="View ItemIPQC" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="Server">
    <table width="100%" class="ContentTable">
        <tr>
            <td class="Label1"><%= Resources.lang.ItemsName %></td>
            <td class="Field1">
                <asp:Label ID="lblItemName" runat="server"></asp:Label>
            </td>
        </tr>
    </table>

    <table id="tableParam" width="100%" class="ListTable" cellpadding="0px" cellspacing="0px" style="text-align:center">
        <thead>
            <tr class="ListTableTitle" style="text-align:center">
                <th style="width:30%">参数名称</th><th style="width:60%">参数检验标准</th>
            </tr>
        </thead>

        <tr class="ListTableEvenRow">

            <td align="center" colspan="2">
                <%=Resources.Messages.HaveNothingData%>
            </td>

        </tr>
    
    </table>

    <script type="text/javascript">
        var Id = <%= Request.QueryString["Id"] == null ? -1 : Convert.ToInt32(Request.QueryString["Id"].ToString())%>

        $(document).ready(function()
        {
            ShowParamList();
        })

        function Edit()
        {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Product/ItemIQCParamEdit.aspx?name=Product_ItemIQCParamEdit&ID=" + Id;
            window.location.href = openWinUrl;
        }


        //显示已配置参数列表
        function ShowParamList() {
            var tableParam = document.getElementById("tableParam");

            var row, cel

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxProduct.GetItemIQCParamList(Id);

            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            if (ajax.value != null ) {
                $("#tableParam tr:eq(1)").remove();
                var entity = ajax.value;
                for (var i = 0; i < entity.length; i++) {
                    row = tableParam.insertRow(tableParam.rows.length);
                    row.className = "ListTableEvenRow";

                    cel = row.insertCell(0);
                    cel.innerHTML = entity[i].ParamName;

                    cel = row.insertCell(1);
                    cel.innerHTML = entity[i].ParamStandard;
                }
            }
        }
    </script>
</asp:Content>