<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="true"
    CodeBehind="BatchSNNcDataSave.aspx.cs" Inherits="SKT.LeanMES.Web.Client.BatchSNNcDataSave"
    ValidateRequest="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="server">
    <div>
        <table width="100%" class="EditeContentTable">
            <tr>
                <td class="Label2">
                    批次条码<em>*</em>
                </td>
                <td class="Field2">
                    <asp:TextBox ID="txtBatchSN" runat="server" CssClass="TextBox"  IsRequired='1' MaxLength="50"></asp:TextBox>
                </td>
                <td class="Label2">
                    机台/线别 <em>*</em>
                </td>
                <td class="Field2">
                    <asp:TextBox ID="txtLineName" runat="server" CssClass="TextBox" MaxLength="50"  IsRequired='1' Enabled="false"></asp:TextBox>
                    <input type="button" id="btnSelectItem" runat="server" class="ButtonBox" value="..." title="Select" onclick="openChoosePage(1);" />
                    <asp:HiddenField ID="hdnLineID" runat="server" Value="-1" ClientIDMode="Static" />
                </td>
            </tr>
            <tr>
                <td class="Label2">
                    工序 <em>*</em>
                </td>
                <td class="Field2">
                    <asp:TextBox ID="txtStationName" runat="server" CssClass="TextBox" MaxLength="50" IsRequired='1' Enabled="false"></asp:TextBox>
                    <input type="button" id="Button1" runat="server" class="ButtonBox" value="..." title="Select" onclick="openChoosePage(2);" />
                    <asp:HiddenField ID="hdnStationID" runat="server" Value="-1" ClientIDMode="Static" />
                </td>
                <td class="Label2">
                    不良现象 <em>*</em>
                </td>
                <td class="Field2">
                    <asp:TextBox ID="txtNcdataName" runat="server" CssClass="TextBox" MaxLength="50" IsRequired='1' Enabled="false"></asp:TextBox>
                    <input type="button" id="Button2" runat="server" class="ButtonBox" value="..." title="Select" onclick="openChoosePage(3);" />
                    <asp:HiddenField ID="hdnNcdataCode" runat="server" Value="-1" ClientIDMode="Static" />
                </td>
            </tr>
            <tr>
                <td class="Label2">
                    不良数量 <em>*</em>
                </td>
                <td class="Field2">
                    <asp:TextBox ID="txtNcQty" runat="server" CssClass="TextBox" MaxLength="50" IsRequired='1'></asp:TextBox>
                </td>
                <td class="Label2">
                    不良原因 <em>&nbsp;</em>
                </td>
                <td class="Field2">
                    <asp:TextBox ID="txtNcTypeName" runat="server" CssClass="TextBox" MaxLength="50" Enabled="false"></asp:TextBox>
                    <input type="button" id="Button3" runat="server" class="ButtonBox" value="..." title="Select" onclick="openChoosePage(4);" />
                    <asp:HiddenField ID="hdnNcTypeCode" runat="server" Value="-1" ClientIDMode="Static" />
                </td>
            </tr>
            <tr>
                <td class="Label2">
                    <%= Resources.lang.Remark %>
                    <em>&nbsp;</em>
                </td>
                <td class="Field2" colspan="4">
                    <asp:TextBox ID="txtRemark" runat="server" CssClass="TextArea" TextMode="MultiLine"
                        MaxLength="50" Width="99%" ClientIDMode="Static" Height="50"></asp:TextBox>
                </td>
            </tr>
        </table>
    </div>
    <div class="clear5">
    </div>
    <div style="text-align: center">
        <!--工作释放操作状态的信息提示区域-->
        <div id="lblMessage" class="Tips">
        </div>
        <input type="button" id="btnRelease" style="width: 82px; cursor: pointer;" value=" 保 存 " onclick="Save();" />
    </div>
    <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/layui.all.js"></script>
    <link href="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/css/layui.css" rel="stylesheet" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/ws.js" type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.printer.js?v=1" type="text/javascript"></script>
    <script type="text/javascript">

        var userName = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>';
        var ResourceId = '<%=Request.QueryString["resourceid"]%>'; 

        $(function () {
            var SN = '<%=Request.QueryString["SN"]%>';
            var stationId = '<%=Request.QueryString["stationid"]%>';
            var resourceId = '<%=Request.QueryString["resoureid"]%>';
            var prodline = '<%=Request.QueryString["prodline"]%>';

            var info = { StationID: stationId, ResourceID: resourceId, LineName: prodline };
            var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspGetCommonProCollectionBatchOPLineData", JSON.stringify(info));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var list = JSON.parse(ajax.value);
            var listOrder = list.data;
            $("#<%=this.txtLineName.ClientID %>").val(listOrder[0].LineName);
            $("#<%=this.hdnLineID.ClientID %>").val(listOrder[0].LineId);
            $("#<%=this.txtStationName.ClientID %>").val(listOrder[0].Station);
            $("#<%=this.hdnStationID.ClientID %>").val(listOrder[0].StationId);
        });

        function Save() {
            var LineID = $("#<%=this.hdnLineID.ClientID %>").val();
            var StationID = $("#<%=this.hdnStationID.ClientID %>").val();
            var NcdataCode = $("#<%=this.hdnNcdataCode.ClientID %>").val();
            var NcTypeCode = $("#<%=this.hdnNcTypeCode.ClientID %>").val();
            var BatchSN = $("#<%=this.txtBatchSN.ClientID %>").val();
            var NcQty = $("#<%=this.txtNcQty.ClientID %>").val();
            var Remark = $("#<%=this.txtRemark.ClientID %>").val();
            if (BatchSN == "-1" || BatchSN == "") {
                alert('请扫描批次SN！');
                return;
            }
            if (LineID == "-1" || LineID == "") {
                alert('请选择线别！');
                return;
            }
            if (StationID == "-1" || StationID == "") {
                alert('请选择工序！');
                return;
            }
            if (NcdataCode == "-1" || NcdataCode == "") {
                alert('请选择不良现象！');
                return;
            }
            //if (NcTypeCode == "-1" || NcTypeCode == "") {
            //    alert('请选择不良原因！');
            //    return;
            //}
            if (NcQty == "-1" || NcQty == "") {
                alert('请填写不良数量！');
                return;
            }
            var info = { BatchSN: BatchSN, LineID: LineID, StationID: StationID, ResourceId: ResourceId, NcdataCode: NcdataCode, NcTypeCode: NcTypeCode, NcQty: NcQty, Remark: Remark,UserName: userName };
            var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspCommonProCollectionBatchSaveNGData", JSON.stringify(info));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert("不良信息录入成功！");
            Clear();
        }

        function Clear() {
            $("#<%=this.hdnLineID.ClientID %>").val("");
            $("#<%=this.txtLineName.ClientID %>").val("");
            $("#<%=this.hdnStationID.ClientID %>").val("");
            $("#<%=this.txtStationName.ClientID %>").val("");
            $("#<%=this.hdnNcdataCode.ClientID %>").val("");
            $("#<%=this.txtNcdataName.ClientID %>").val("");
            $("#<%=this.hdnNcTypeCode.ClientID %>").val("");
            $("#<%=this.txtNcTypeName.ClientID %>").val("");
            $("#<%=this.txtBatchSN.ClientID %>").val("");
            $("#<%=this.txtNcQty.ClientID %>").val("");
            $("#<%=this.txtRemark.ClientID %>").val("");
        }

        var flag = -1;
        /*2.工单列表*/
        function openChoosePage(flage) {
            //线别
            if (flage == 1) {
                flag = flage;
                dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=21&Multiple=false&rnd=" + Math.random(), width: 650, height: 420 });
            }
            //工序
            if (flage == 2) {
                flag = flage;
                dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=8&Multiple=false&rnd=" + Math.random(), width: 650, height: 420 });
            }
            //不良代码
            if (flage == 3) {
                flag = flage;
                var StationID = $("#<%=this.hdnStationID.ClientID %>").val();
                var searchCondition = " StationID = " + StationID + " and Category='Failure'";//不良现象
                dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=836&PageCondition= " + searchCondition + "&Multiple=false&rnd=" + Math.random(), width: 650, height: 420 });
            }
            //不良代码
            if (flage == 4) {
                flag = flage;
                var StationID = $("#<%=this.hdnStationID.ClientID %>").val();
                //var searchCondition = " Status ='Enabled' AND Category = 'Failure' AND StationId = " + stationId + " ";
                var searchCondition = " StationID = " + StationID + " and Category = 'Defect'";//不良原因
                dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=836&PageCondition= " + searchCondition + "&Multiple=false&rnd=" + Math.random(), width: 650, height: 420 });
            }
        }

        //绑定选择类型值
        function getChooseValue(list) {
            //线别
            if (flag == 1) {
                $("#<%=this.txtLineName.ClientID %>").val(list[0][1]);
                $("#<%=this.hdnLineID.ClientID %>").val(list[0][0]);
            }
            //工序
            if (flag == 2) {
                $("#<%=this.txtStationName.ClientID %>").val(list[0][1]);
                $("#<%=this.hdnStationID.ClientID %>").val(list[0][0]);
            }
            //不良代码
            if (flag == 3) {
                $("#<%=this.txtNcdataName.ClientID %>").val(list[0][1]);
                $("#<%=this.hdnNcdataCode.ClientID %>").val(list[0][1]);
            }
            //不良代码类型
            if (flag == 4) {
                $("#<%=this.txtNcTypeName.ClientID %>").val(list[0][1]);
                $("#<%=this.hdnNcTypeCode.ClientID %>").val(list[0][0]);
            }
        }

    </script>
</asp:Content>
