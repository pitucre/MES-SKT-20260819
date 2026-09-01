<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="true"
    CodeBehind="PreviewSchedulView.aspx.cs" Inherits="SKT.LeanMES.Web.Plan.PreviewSchedulView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="server">
    <div class="infoTips">
        <%= Resources.Messages.PlanListByTime %>
    </div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label3">
                 <%=Resources.lang.OrderNum%>
            </td>
            <td class="Field3">
                <asp:Label ID="lbOrderNumber" runat="server" Text=""></asp:Label>
            </td>
          <td class="Label3">
                 <%=Resources.lang.Layout %>
            </td>
            <td class="Field3">
                <asp:Label ID="lblPlaneQty" runat="server" Text="" ForeColor="#FF3300"></asp:Label>
            </td>
            <td class="Label3">
                产品编码
            </td>
            <td class="Field3">
                <asp:Label ID="lblItemCode" runat="server" Text="" ClientIDMode="Static"></asp:Label>
                <asp:HiddenField ID="hdnItemId" Value="-1" ClientIDMode="Static" runat="server" />
            </td>
        </tr>
        <tr>
            <td class="Label3">
                <%=Resources.lang.MaterialName %>
            </td>
            <td class="Field3">
                <asp:Label ID="lbFName" runat="server" Text="" ClientIDMode="Static"></asp:Label>
            </td>
              <td class="Label3">
                <%=Resources.lang.PlanQty%>
            </td>
            <td class="Field3">
                <asp:Label ID="lbFQty" runat="server" Text=""></asp:Label>
            </td>
            
            <td class="Label3">
                已排产数量
            </td>
            <td class="Field3">
                <asp:Label ID="lbFQtyPlan" runat="server" Text="" ForeColor="#FF3300"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label3">
                路由名称
            </td>
            <td class="Field3">
                <asp:Label ID="lblRouterName" runat="server" ClientIDMode="Static" Text=""></asp:Label>
            </td>
            <td class="Label3">
                <%=Resources.lang.PlanCommitDate%>
            </td>
            <td class="Field3">
                <asp:Label ID="lbFPlanCommitDate" runat="server" Text=""></asp:Label>
            </td>
            <td class="Label3">
                <%=Resources.lang.PlanFinishDate%>
            </td>
            <td class="Field3">
                <asp:Label ID="lbFPlanFinishDate" runat="server" Text=""></asp:Label>
            </td>
        </tr>
        <tr style="display: none">
            <td class="Label3">
                <%=Resources.lang.Biller %>
            </td>
            <td class="Field3">
                <asp:Label ID="lbFBiller" runat="server" Text=""></asp:Label>
            </td>
            <td class="Label3">
                <%=Resources.lang.Conveyer %>
            </td>
            <td class="Field3">
                <asp:Label ID="lbFConveyer" runat="server" Text=""></asp:Label>
            </td>
        </tr>
        <tr style="display: none">
            <td class="Label2">
                <%=Resources.lang.CommitDate%>
            </td>
            <td class="Field2">
                <asp:Label ID="lbFCommitDate" runat="server" Text="Label"></asp:Label>
            </td>
            <td class="Label2">
                <%=Resources.lang.ProcessingCompany%>
            </td>
            <td class="Field2">
                <asp:Label ID="lbFWorkShop" runat="server" Text="Label"></asp:Label>
            </td>
        </tr>
    </table>
    <table id="tblExpand" cellspacing="0" cellpadding="4" style="border-width: 0px; width: 100%;
        border-collapse: collapse; margin-top: 5px;" class="EditeContentTable">
        <tr class="ListTableHeader" style="text-align: center">
            <th scope="col" style="width: 15%;">
                <%=Resources.lang.ResName%>
            </th>
            <th scope="col" style="width: 5%;">
                面别 
            </th>
             <th scope="col" style="width: 15%;">
                <%=Resources.lang.StartTime %>
            </th>
            <th scope="col" style="width: 10%;">
                <%=Resources.lang.PlanQty %>
            </th>
            <th scope="col" style="width: 10%;">
               是否插单
            </th> 
        </tr>
        <tr id="trNewInfo" class="ListTableOddRow">
            <td colspan="5" style="text-align: center;">
                <%=Resources.Messages.HaveNothingData%>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        var planType = 1;
        var FInterID = '<%=Request.QueryString["ID"]%>';
        var tb = '<%=Request.QueryString["Tb"]%>';
        var FBILLNO = $('#' + '<%=this.lbOrderNumber.ClientID %>').html();

     

        var tab = document.getElementById("tblExpand");
        var rowObj = null;
        var rowIndex = 0;

        $(function () {
            $("#<%=this.lblPlaneQty.ClientID%>").text(tb);
          
            initFTable();
        });

        function initFTable() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPlan.GetLinePreviewSchedulByOrderId(FInterID, tb);
            if (ajax.error == null) {
                var entityAry = ajax.value;
                var planNumber = 0;
                for (var i = 0; i < entityAry.length; i++) {
                    addDetail(entityAry[i]);
                    planNumber += entityAry[i].PlanNumber;
                }
                $("#<%=this.lbFQtyPlan.ClientID%>").text(planNumber);
            } else {
                alert(ajax.error.Message);
            }
           
           
        }

       
        function addDetail(entity) {

            $("#trNewInfo").remove();
            var row, cell;
            rowNewIdx = tab.rows.length;
            row = tab.insertRow(rowNewIdx);
            row.className = "ListTableOddRow";

            cell = row.insertCell(0);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = entity.ResName;


            cell = row.insertCell(1);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML =entity.TableName ;

            cell = row.insertCell(2);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = entity.DayTime;

            cell = row.insertCell(3);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = entity.PlanNumber;

            cell = row.insertCell(4);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = entity.IsHand==0?"否":"是";
        }
        

      
    </script>
</asp:Content>
