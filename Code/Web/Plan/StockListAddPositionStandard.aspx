<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="StockListAddPositionStandard.aspx.cs" Inherits="SKT.LeanMES.Web.Plan.StockListAddPositionStandard" %>

<%@ Import Namespace="Resources" %>
<%@ Import Namespace="SKT.LeanMES.Web" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
     <div class="infoTips">
        <%= Resources.Messages.WithAsteriskIsRequired %>
    </div>
      <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label1">排产工单
            </td>
            <td class="Field1">
                <asp:Label ID="lblPlanOrder" runat="server" Text="" ClientIDMode="Static" ></asp:Label>
            </td>
            </tr>
          <tr>
            <td class="Label1">主料<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtMainItemCode" runat="server" ReadOnly="true" CssClass="TextBox" IsRequired="1"  ClientIDMode="Static"
                     >
                </asp:TextBox><input type="button" id="Button1" runat="server" class="ButtonBox"
                    value="..." title="Select" onclick="openChoosePage(206);" />
                <asp:HiddenField ID="hdnItemId" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
        </tr>
          <tr>
              <td class="Label1">设备<em>*</em></td>
              <td  class="Field1">
                  <asp:DropDownList ID="ddlEquipment" runat="server" IsRequired="1" ClientIDMode="Static" ></asp:DropDownList>
              </td>
          </tr>
          <tr>
            <td class="Label1">区<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtArea" runat="server"  CssClass="TextBox" IsRequired="1"  ClientIDMode="Static"  ></asp:TextBox>                 
            </td>
        </tr>
        <tr>
            <td class="Label1">站位<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtPosition" runat="server"  CssClass="TextBox" IsRequired="1"  ClientIDMode="Static"  ></asp:TextBox>                 
            </td>
        </tr>
        <tr>
            <td class="Label1">用量<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtNum" runat="server" CssClass="TextBox" IsRequired="1"  ClientIDMode="Static" MaxLength="5"  ></asp:TextBox>                
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%= Resources.lang.FeederTypeName%><em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtFeederType" runat="server" CssClass="TextBox" Enabled="false"
                    ReadOnly="true" IsRequired='1' ></asp:TextBox><input type="button" id="btnType" class="ButtonBox"
                        value="..." title="" onclick="selectType();"  ClientIDMode="Static"/>
                <asp:HiddenField ID="txtFeederTypeID" runat="server" Value="-1" />
            </td>
        </tr>
    </table>
    <asp:HiddenField runat="server" ID="hidPid" Value="-1"/>
    <script type="text/javascript">
        var planOrderNo = '<%=Request.QueryString["PlanOrderNo"]%>';
        var standerID='<%=Request.QueryString["standardID"]%>'
        $().ready(function () {
            $("#lblPlanOrder").text(planOrderNo);          

            $("#txtNum").keyup(function () {
                getDecimalVal(this);
            });
        });

        function openChoosePage(flags) {
            var condition = " FBILLNO= '" + planOrderNo + "'";
            flag = flags;
            dialog({
                title: "<%= Common.ChooseWindow %>",
                src: "<%= WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=" +
                flags +
                "&Multiple=false&SearchCondition=" +
                condition +
                "&rnd=" +
                Math.random(),
                width: 680,
                height: 300
            });
        }

          function selectType() {
            flag = 2;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=41&Multiple=false&rnd=" + Math.random(), width: 680, height: 300 });
        }

        function getChooseValue(list) {
            if (flag == 206) {
                $("#txtMainItemCode").val(list[0][1]);
                $("#hdnItemId").val(list[0][0]);                
            }
            if (flag == 2) {
                $("#<%=this.txtFeederType.ClientID %>").val(list[0][1]);
                $("#<%=this.txtFeederTypeID.ClientID %>").val(list[0][0]);
            }
        }
  
        function Save() {
            var mainItemCode = $.trim($("#txtMainItemCode").val());
            var position = $.trim($("#txtPosition").val());
            var equipqmentId = parseInt($("#ddlEquipment").val());
            var num = parseFloat($("#txtNum").val());
            var area = $.trim($("#txtArea").val());
            var feederType = $("#<%= this.txtFeederType.ClientID %>").val();

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxStockList.AddStockListPosition(planOrderNo, mainItemCode, position, num, equipqmentId, feederType, area, standerID);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert('<%=Resources.Messages.SaveInSuccess%>')
            parent.window.Refresh();
        }

    </script>
</asp:Content>
