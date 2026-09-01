<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="JigOut.aspx.cs" Inherits="SKT.LeanMES.Web.Jig.JigOut" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
<table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">
                <%= Resources.lang.JigName%>
            </td>
            <td class="Field1">
                <asp:Label ID="lblJigName" runat="server"></asp:Label> 
            </td>
        </tr>
        <tr>
            <td class="Label1">
                借用类型
            </td>
            <td class="Field1" id="tdtxtAddQty">
                <select id="ddlOutType" onchange="change()">
                   <option value="5" selected="selected">
                        <%=Resources.lang.repaireOut%></option>
                    <option value="6">
                        <%=Resources.lang.CleanOut%></option>
                    <option value="7">
                        <%=Resources.lang.BrrOut%></option>
                    <!--<option value="8">
                        <%=Resources.lang.ScrappeOut%></option>-->
                    <!--<option value="9">
                        <%=Resources.lang.SalesReturn%></option>-->
                        <option value="11">
                        <%=Resources.lang.GetByLine%></option>
                </select>
                <input id="btnSave" type="button" value="<%=Resources.lang.ConfirmBorrow %>" onclick="SavePlus()"
                    style="height: 22px; width: 80px; border-style: outset; cursor: pointer; font-weight: bold;" />
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%=Resources.lang.Requestor%><em>*</em>
            </td>
            <td class="Field1" id="tdAdmin">
                <asp:TextBox ID="txtRequestor" runat="server" CssClass="TextBox" isRequired="1" MaxLength="50"
                    ClientIDMode="Static"></asp:TextBox>
                <input type="button" id="btnRequestor" class="ButtonBox" value="..." onclick="selectRequestor()" />
                <asp:HiddenField ID="hdnRequestor" runat="server" Value="-1" />
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%=Resources.lang.Line%>
            </td>
            <td class="Field1" id="td1">
                <asp:TextBox ID="txtLine" runat="server" CssClass="TextBox" Enabled="false"></asp:TextBox>
                <input type="button" id="btnLine" class="ButtonBox" value="..." title="选择产线" onclick="selectLineName();" />
                <asp:HiddenField ID="hdnLineId" runat="server" Value="-1" />
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%=Resources.lang.JigNickName%>
            </td>
            <td class="Field1" id="tdNickName">
                <asp:Label ID="lblJigNickName" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%=Resources.lang.Category%>
            </td>
            <td class="Field1" id="tdCategory">
                 <asp:Label ID="lblJigType" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%=Resources.lang.ItemName%>
            </td>
            <td class="Field1" id="tdItemName">
                <asp:Label ID="lblItemId" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%=Resources.lang.VendorName%>
            </td>
            <td class="Field1" id="tdVendorName">
               <asp:Label ID="lblVendorId" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%=Resources.lang.PartLocation%>
            </td>
            <td class="Field1" id="tdPartLocation">
                <asp:Label ID="lblPosition" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%=Resources.lang.StandarLive%>
            </td>
            <td class="Field1" id="tdStandarLive">
                <asp:Label ID="lbStandarLive" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%=Resources.lang.UserCount%>
            </td>
            <td class="Field1" id="tdOutPeople">
                 <asp:Label ID="lblUseCount" runat="server"></asp:Label>
            </td>
        </tr>
                <tr>
            <td class="Label1">
                当前位置
            </td>
            <td class="Field1">
                <asp:Label ID="lblCurPosition" runat="server"></asp:Label>
            </td>
        </tr>

        <tr>
         <td class="Label2"><%= Resources.lang.Remark%></td>
            <td class="Field2">
                <asp:Label ID="lblRemark" runat="server"></asp:Label>
            </td>
        </tr>

    </table>
    <script type="text/javascript">
    var Id = <%= Request.QueryString["ID"] == null ? -1 : Convert.ToInt32(Request.QueryString["ID"].ToString())%>;
     var chooseFlag = -1;

        $(function () {
            change();
        });
        function change() {
            var ddlValue = $("#ddlOutType").val();
            if (ddlValue != "11") {
                $("#btnLine").attr("disabled", "disabled");
            }
            else {
                $("#btnLine").removeAttr("disabled", "disabled");
            }
            $("#<%=this.txtLine.ClientID %>").val("");
            $("#<%=this.hdnLineId.ClientID %>").val("-1");
        }
        /*选择产线*/
        function selectLineName() {
            chooseFlag = 21;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=21&Multiple=false&rnd=" + Math.random(), width: 400, height: 300 });
        }

        function selectRequestor(){
            chooseFlag = 12;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=12&Multiple=false&rnd=" + Math.random(), width: 420, height: 250 });
        }

        function getChooseValue(list) {
            if(chooseFlag == 21)
            {
                $("#<%=this.txtLine.ClientID %>").val(list[0][1]);
                $("#<%=this.hdnLineId.ClientID %>").val(list[0][0]);
            }
            else if(chooseFlag = 12)
            {

                $("#<%=this.txtRequestor.ClientID %>").val(list[0][1] + "|(" + list[0][2] + ")");
                $("#<%=this.hdnRequestor.ClientID %>").val(list[0][0]);
             }
        }



        function Save() {
            var lblJigName = $("#<%=this.lblJigName.ClientID %>").html();
            var lineId = $("#<%=this.hdnLineId.ClientID %>").val();
            var steelType =  $("#ddlOutType").val();//出入库类型为下拉列表的值
            var useCount = $("#<%=this.lblUseCount.ClientID %>").html();//已使用次数
            var liftCount = $("#<%=this.lbStandarLive.ClientID %>").html();//使用寿命
            
            if(steelType=="11"&&lineId=="-1"){
                alert("请选择产线!");
                return false;
            }
            if(parseInt(useCount)>=parseInt(liftCount)){
                alert("使用次数大于或等于标准寿命,禁止出库!");
                return false;
            }
             var entity = {};
             entity.JigHistoryId = -1;
             entity.JigId = Id;
             entity.LineId = parseInt(lineId);
             entity.OperateType = 2;
             entity.JigType = parseInt(steelType);
             entity.Operator = $("#<%=this.hdnRequestor.ClientID %>").val();
             entity.Remark="";

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxJigHistory.JigRecordEdit(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert('<%=Resources.Messages.SaveInSuccess%>');
                $("#<%=this.txtLine.ClientID %>").val("");
                $("#<%=this.hdnLineId.ClientID %>").val("-1");
                parent.window.UpdateList(lblJigName);
        }
    </script>
</asp:Content>

