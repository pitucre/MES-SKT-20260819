<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="true" CodeBehind="KanbanList.aspx.cs" Inherits="SKT.LeanMES.Web.Kanban.Builtin.KanbanList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="server" ViewStateMode="Disabled">
    <style type="text/css">
        #outer {
            width: 100%;
            margin: 0px auto;
            display: table;
            text-align: center;
            position: relative;
            background-color: #080912;
        }

        #contentHeadTable tr {
            background-color: #080912;
            height: 80px;
        }

        #MaiContent {
            overflow: auto;
        }

        #LabTitle {
            display: table-cell;
            position: absolute;
            vertical-align: middle;
            position: absolute;
            right: 40%;
            top: 20px;
            text-align: center;
            vertical-align: middle;
            font-size: 30px;
            color: #A4A7A8;
            font-weight: bold;
        }

        #labTime {
            display: block;
            vertical-align: middle;
            position: absolute;
            top: 40%;
            right: 20px;
            font-size: 15px;
            color: #D8DADA;
            height: 65px;
        }

        #station_phase {
            display: block;
            vertical-align: middle;
            position: absolute;
            top: 15%;
            right: 20px;
            font-size: 15px;
            color: #D8DADA;
            height: 65px;
        }

        .Field1 {
            width: 20%;
            height: 20px;
            text-align: left;
            background-color: #fff;
            padding: 3px 0px 3px 3px;
            border-top: 1px solid #d3d3d3;
            border-left: 1px solid #d3d3d3;
            border-right: 1px solid #d3d3d3;
            border-bottom: 1px solid #d3d3d3;
        }
    </style>
    <!--看板欢迎词全局设置-->
    <table class="EditeContentTable" style="width: 100%;">
        <tr>
            <td colspan="2">
                <div class="divHeader" style="border: 0px;">看板欢迎词全局设置</div>
            </td>
        </tr>
        <tr class="ListTableHeader">
            <td class="Label2">看板全局欢迎词</td>
            <td class="Field2">
                <div>
                    <asp:TextBox ID="txtGlobalWelcText" runat="server" TextMode="MultiLine" CssClass="TextArea" Rows="5" Width="300px" Height="60px" ClientIDMode="Static"></asp:TextBox>
                </div>

            </td>
        </tr>
    </table>
    <div class="clear5"></div>
    <!--看板计算公式-->
    <table class="EditeContentTable" style="width: 100%; display: none;">
        <tr>
            <td colspan="2">
                <div class="divHeader" style="border: 0px;">看板计算公式说明</div>
            </td>
        </tr>
        <tr class="ListTableHeader">
            <td class="Label2">生产进度=</td>
            <td class="Field2">
                <asp:TextBox ID="txtKBCalc1" runat="server" TextMode="MultiLine" CssClass="TextArea calc" Rows="5" Width="300px" Height="60px" ClientIDMode="Static" Text="（该车间工单当天实际产出数累计/当天计划数累计）*100%"></asp:TextBox>
            </td>
        </tr>
        <tr class="ListTableHeader">
            <td class="Label2">综合IE效率=</td>
            <td class="Field2">
                <asp:TextBox ID="txtKBCalc2" runat="server" TextMode="MultiLine" CssClass="TextArea calc" Rows="5" Width="300px" Height="60px" ClientIDMode="Static" Text="总装单机型IE效率取平均值
各机型IE效率＝(（各机型瓶颈时间（单位为秒）*该机型当前产出数）/（各机型最后一片板产出时间－各机型第一片板投入时间-异常时间）)*3600*100%"></asp:TextBox>
            </td>
        </tr>
        <tr class="ListTableHeader">
            <td class="Label2">车间直通率=</td>
            <td class="Field2">
                <asp:TextBox ID="txtKBCalc3" runat="server" TextMode="MultiLine" CssClass="TextArea calc" Rows="5" Width="300px" Height="60px" ClientIDMode="Static" Text="(车间当天对应工单白卡数累计/车间当天产出数累计)*100%"></asp:TextBox>
            </td>
        </tr>
    </table>
    <table class="EditeContentTable" cellspacing="0" cellpadding="4" style="border-width: 0px; width: 100%; border-collapse: collapse; margin-top: 5px;">
        <tr>
            <td colspan="2">
                <div class="divHeader">看板设置</div>
            </td>
        </tr>
        <tr class="ListTableHeader">
            <td class="Label2">看板名称
            </td>
            <td class="Field2">
                <select id="selKBName">
                </select>
            </td>

        </tr>
        <tr id="trWorkshop" class="ListTableHeader" style="display: none;">
            <td class="Label2">车间看板
            </td>
            <td class="Field2">
                <asp:HiddenField ID="hdnWorkshopId" Value="-1" runat="server" ClientIDMode="Static" />
                <asp:TextBox ID="txtWorkshop" runat="server" CssClass="TextBox" ReadOnly="true" ClientIDMode="Static"></asp:TextBox><input type="button" class="ButtonBox" value="..." onclick="OnChoosePage(4)" />
            </td>

        </tr>
        <tr id="trLine" style="display: none;" class="ListTableHeader">
            <td class="Label2">产线
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtLine" runat="server" CssClass="TextBox" Enabled="false" ClientIDMode="Static"></asp:TextBox><input
                    type="button" id="btnSelectLine" class="ButtonBox" value="..." title="<%=Resources.lang.LineName %>"
                    onclick="OnChoosePage(1);" />
                <asp:HiddenField ID="hdnLine" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
        </tr>
        <tr class="ListTableHeader">
            <td class="Label2">看板欢迎词
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtWelcomeMsg" runat="server" CssClass="TextBox" Rows="5" Width="300px" Height="30px" ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2"></td>
            <td class="Field2">
                <div style="padding: 5px;">
                    <%-- <asp:Button ID="btnSetWelcText" runat="server" Text="保存" CssClass="SearchButton" />--%>
                    <input type="submit" name="btnSetWelcText" value="保存" id="btnSetWelcText" class="SearchButton">
                </div>
            </td>
        </tr>
    </table>
    <asp:HiddenField ID="hdnMsg" Value="" runat="server" />
    <input type="hidden" id="PopedomCode" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.store.js" type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.client.productioncollection.js" type="text/javascript"></script>
    <script type="text/javascript">
        var userId = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserId %>";
        LoadOptions();//加载看板
        function LoadOptions() {
            //Popedoms集合 用于判断是否生成对应权限码；
            var Popedoms = SKT.LeanMES.Web.AjaxServices.AjaxKanban.GetPopedoms().value;
            var optionsStr = "";

            if (IsHasPermission(userId, 70200206) && $.inArray(70200206, Popedoms) > -1) {
                optionsStr += '<option value="19" selected="selected">仓库收料看板</option>';
            }
            //if (IsHasPermission(userId, 70200207) && $.inArray(70200207, Popedoms) > -1) {
            //    optionsStr += '<option value="5">IQC待检验看板</option>';
            //}
            //if (IsHasPermission(userId, 70200208) && $.inArray(70200208, Popedoms) > -1) {
            //    optionsStr += '<option value="16">IQC合格率及不良分布看板</option>';
            //}
            if (IsHasPermission(userId, 70200209) && $.inArray(70200209, Popedoms) > -1) {
                optionsStr += '<option value="6">仓库备料看板</option>';
            }
            //if (IsHasPermission(userId, 70200213) && $.inArray(70200213, Popedoms) > -1) {
            //    optionsStr += '<option value="3">SMT接料看板</option>';
            //}
            //if (IsHasPermission(userId, 70200210) && $.inArray(70200210, Popedoms) > -1) {
            //    optionsStr += '<option value="12">辅料管理看板</option>';
            //}
            //if (IsHasPermission(userId, 70200211) && $.inArray(70200211, Popedoms) > -1) {
            //    optionsStr += '<option value="14">MSD管理看板</option>';
            //}
            //if (IsHasPermission(userId, 70200212) && $.inArray(70200212, Popedoms) > -1) {
            //    optionsStr += '<option value="1">线体看板</option>';
            //}
         
            //if (IsHasPermission(userId, 70200219) && $.inArray(70200219, Popedoms) > -1) {
            //    optionsStr += '<option value="2">车间看板</option>';
            //}
          
            //if (IsHasPermission(userId, 70200221) && $.inArray(70200221, Popedoms) > -1) {
            //    optionsStr += '<option value="13">生产看板</option>';
            //}
           
            if (IsHasPermission(userId, 70200224) && $.inArray(70200224, Popedoms) > -1) {
                optionsStr += '<option value="4">车间品质监控看板</option>';
            }
            if (IsHasPermission(userId, 70200225) && $.inArray(70200225, Popedoms) > -1) {
                optionsStr += '<option value="11">成品出货看板</option>';
            }
           /* optionsStr += '<option value="21">设备看板</option>';*/
            optionsStr += '<option value="21">设备看板</option>'
            optionsStr += '<option value="30">注塑车间设备看板</option>';
            if (IsHasPermission(userId, 70200234) && $.inArray(70200234, Popedoms) > -1) {
                optionsStr += '<option value="31">注塑机台单看板</option>';
            }
            if (IsHasPermission(userId, 70200235) && $.inArray(70200235, Popedoms) > -1) {
                optionsStr += '<option value="32">注塑车间生产状况综合看板</option>';
            }
            optionsStr += '<option value="33">首件看板</option>';
            //optionsStr += '<option value="40">注塑综合看板</option>';
            if (IsHasPermission(userId, 70200236) && $.inArray(70200236, Popedoms) > -1) {
                optionsStr += '<option value="41">设备概况看板</option>';
            }
            if (IsHasPermission(userId, 70200237) && $.inArray(70200237, Popedoms) > -1) {
                optionsStr += '<option value="42">车间生产运行监控</option>';
            }

            $("#selKBName").html(optionsStr);
            $("#selKBName").change();
        }
        $("#selKBName").change(function () {
            if (this.value == "1") {
                $("#trWorkshop").hide();
                $("#trLine").show();
                $("#txtLine").val("");
                $("#hdnLine").val(-1);
                $("#txtWelcomeMsg").val("");
                //$("#PopedomCode").val("70200212");
            }
            else if (this.value == "2") {
                $("#trWorkshop").show();
                $("#trLine").hide();
                $("#txtWorkshop").val("");
                $("#hdnWorkshopId").val(-1);
                $("#txtWelcomeMsg").val("");
                //$("#PopedomCode").val("70200219");
            } else if (this.value == "3") {
                $("#trWorkshop").hide();
                $("#trLine").show();
                $("#txtLine").val("");
                $("#hdnLine").val(-1);
                $("#trWelcomeMsg").hide();
                $("#txtWelcomeMsg").val("");
                // $("#PopedomCode").val("70200213");
            } else if (this.value == "4") {

                $("#trWorkshop").show();
                $("#trLine").hide();
                $("#txtWelcomeMsg").val("");
                $("#trWelcomeMsg").hide();
                setWelcomeMsg(-1, -1);
                // $("#PopedomCode").val("70200224");
            } else if (this.value == "5") {
                $("#trWorkshop").hide();
                $("#trLine").hide();
                $("#txtWelcomeMsg").val("");
                $("#trWelcomeMsg").hide();
                setWelcomeMsg(-1, -1);
                // $("#PopedomCode").val("70200207");
            } else if (this.value == "6") {
                $("#trWorkshop").hide();
                $("#trLine").hide();
                $("#txtWelcomeMsg").val("");
                $("#trWelcomeMsg").hide();
                setWelcomeMsg(-1, -1);
                //$("#PopedomCode").val("70200209");
            } else if (this.value == "7") {
                $("#trWorkshop").hide();
                $("#trLine").hide();
                $("#txtWelcomeMsg").val("");
                $("#trWelcomeMsg").hide();
                // $("#PopedomCode").val("70200218");
            } else if (this.value == "8") {
                $("#trWorkshop").hide();
                $("#trLine").hide();
                $("#txtWelcomeMsg").val("");
                // $("#PopedomCode").val("70200214");
            } else if (this.value == "9" || this.value == "10") {
                $("#trWorkshop").hide();
                $("#trLine").show();
                $("#txtWelcomeMsg").val("");
                $("#trWelcomeMsg").hide();
                $("#trSave").hide();
                if (this.value == "9") {
                    // $("#PopedomCode").val("70200215");
                } else if (this.value == "10") {
                    // $("#PopedomCode").val("70200216");
                }
            } else if (this.value == "12") {
                $("#trWorkshop").hide();
                $("#trLine").hide();
                $("#txtWelcomeMsg").val("");
                $("#trWelcomeMsg").hide();
                setWelcomeMsg(-1, -1);
                // $("#PopedomCode").val("70200210");
            }
            else if (this.value == "13") {
                $("#trWorkshop").hide();
                $("#trLine").hide();
                $("#txtWelcomeMsg").val("");
                $("#trWelcomeMsg").hide();
                setWelcomeMsg(-1, -1);
                // $("#PopedomCode").val("70200221");
            }
            else if (this.value == "14") {
                $("#trWorkshop").hide();
                $("#trLine").hide();

                $("#txtWelcomeMsg").val("");
                $("#trWelcomeMsg").hide();
                setWelcomeMsg(-1, -1);
                // $("#PopedomCode").val("70200211");
            }
            else if (this.value == "15") {
                $("#trWorkshop").hide();
                $("#trLine").show();

                $("#txtLine").val("");
                $("#hdnLine").val(-1);
                $("#txtWelcomeMsg").val("热烈欢迎各位领导莅临参观指导");
                // $("#PopedomCode").val("70200217");
            }
            else if (this.value == "16") {
                $("#trWorkshop").hide();
                $("#trLine").hide();
                $("#trFloor").hide();
                $("#txtWelcomeMsg").val("");
                $("#trWelcomeMsg").hide();
                setWelcomeMsg(-1, -1);
                // $("#PopedomCode").val("70200208");
            }
            else if (this.value == "17") {
                $("#trWorkshop").show();
                $("#trLine").hide();
                $("#txtWelcomeMsg").val("");
                //$("#PopedomCode").val("70200220");
            }
            else if (this.value == "18") {
                $("#trWorkshop").hide();
                $("#trLine").show();
                $("#txtWelcomeMsg").val("");
                // $("#PopedomCode").val("70200222");
            }
            else if (this.value == "19") {
                $("#trWorkshop").hide();
                $("#trLine").hide();
                $("#txtWelcomeMsg").val("");
                $("#trWelcomeMsg").hide();
                setWelcomeMsg(-1, -1);
                //$("#PopedomCode").val("70200206");
            }
            else if (this.value == "20") {
                $("#trWorkshop").show();
                $("#trLine").hide();
                $("#txtWorkshop").val("");
                $("#hdnWorkshopId").val(-1);
                $("#txtWelcomeMsg").val("");
                //$("#PopedomCode").val("70200223");
            }
            else if (this.value == "21") {

                $("#trWorkshop").hide();
                $("#trLine").hide();
                $("#txtWorkshop").val("");
                $("#hdnWorkshopId").val(-1);
                $("#txtWelcomeMsg").val("");
                //$("#PopedomCode").val("70200223");
            }
            else if (this.value == "22") {

                $("#trWorkshop").hide();
                $("#trLine").hide();
                $("#txtWorkshop").val("");
                $("#hdnWorkshopId").val(-1);
                $("#txtWelcomeMsg").val("");
                //$("#PopedomCode").val("70200223");
            }
            else if (this.value == "23") {

                $("#trWorkshop").hide();
                $("#trLine").hide();
                $("#txtWorkshop").val("");
                $("#hdnWorkshopId").val(-1);
                $("#txtWelcomeMsg").val("");
                //$("#PopedomCode").val("70200223");
            }
            else if (this.value == "24") {
                $("#trWorkshop").hide();
                $("#trLine").hide();
                $("#txtWelcomeMsg").val("");
                $("#trWelcomeMsg").hide();
                setWelcomeMsg(-1, -1);
                // $("#PopedomCode").val("70200228");
            }
            else if (this.value == "25") {
                $("#trWorkshop").hide();
                $("#trLine").hide();
                $("#txtWelcomeMsg").val("");
                $("#trWelcomeMsg").hide();
                setWelcomeMsg(-1, -1);
                // $("#PopedomCode").val("70200229");
            }
            else if (this.value == "26") {
                $("#trWorkshop").hide();
                $("#trLine").hide();
                $("#txtWelcomeMsg").val("");
                $("#trWelcomeMsg").hide();
                setWelcomeMsg(-1, -1);
                // $("#PopedomCode").val("70200230");
            }
            else if (this.value == "11") {
                $("#trWorkshop").hide();
                $("#trLine").hide();
                $("#txtWelcomeMsg").val("");
                $("#trWelcomeMsg").hide();
                setWelcomeMsg(-1, -1);
                // $("#PopedomCode").val("70200207");
            }
            else if (this.value == "27") {
                $("#trWorkshop").hide();
                $("#trLine").show();
                $("#txtLine").val("");
                $("#hdnLine").val(-1);
                $("#txtWelcomeMsg").val("热烈欢迎各位领导莅临参观指导");
                // $("#PopedomCode").val("70200207");
            }
            else if (this.value == "28") {
                $("#trWorkshop").show();
                $("#trLine").hide();
                $("#txtWelcomeMsg").val("");
                $("#trWelcomeMsg").hide();
                setWelcomeMsg(-1, -1);
            }
            else if (this.value == "29") {
                $("#trWorkshop").show();
                $("#trLine").hide();
                $("#txtWelcomeMsg").val("");
                $("#trWelcomeMsg").hide();
                setWelcomeMsg(-1, -1);
            }
            else if (this.value == "31") {
                $("#trWorkshop").hide();
                $("#trLine").show();
                $("#txtLine").val("");
                $("#hdnLine").val(-1);
                $("#txtWelcomeMsg").val("");
            }
            else if (this.value == "32") {
                $("#trWorkshop").hide();
                $("#trLine").hide();
                $("#txtWorkshop").val("");
                $("#hdnWorkshopId").val(-1);
                $("#txtWelcomeMsg").val("");
            }
            else if (this.value == "33") {
                $("#trWorkshop").hide();
                $("#trLine").hide();
                $("#txtWelcomeMsg").val("");
                $("#trWelcomeMsg").hide();
                setWelcomeMsg(-1, -1);
            }
            else if (this.value == "34") {
                $("#trWorkshop").hide();
                $("#trLine").hide();
                $("#txtWorkshop").val("");
                $("#hdnWorkshopId").val(-1);
                $("#txtWelcomeMsg").val("");
            } else if (this.value == "41") {
                $("#trWorkshop").show();
                $("#trLine").hide();
                $("#txtWorkshop").val("注塑车间");
                $("#hdnWorkshopId").val(1);
                $("#txtWelcomeMsg").val("");
            } else if (this.value == "42") {
                $("#trWorkshop").hide();
                $("#trLine").hide();
                $("#txtWelcomeMsg").val("");
            } 
        });

        $(function () {
            $("#txtGlobalWelcText").change(function () {
                //    setWelcText($(this).val());
            });
            $("#btnSetWelcText").click(function () {
                setWelcText($("#txtGlobalWelcText").val());
                return false;
            });

            $(".calc").change(function () {
                $.ajax({
                    url: 'KanBanList.aspx?Action=setcalc&name=' + $(this).attr("id") + '&w=' + escape($.trim($(this).val())) + '&rnd=' + Math.random(),
                    type: 'get',
                    success: function (data) {
                        alert(data);
                    },
                    datatype: 'text'
                })
            });
            var workshopId = $("#<%=this.hdnWorkshopId.ClientID%>").val();
            var lineId = $("#<%=this.hdnLine.ClientID %>").val();
            setWelcomeMsg(workshopId, lineId);
        });

        function setWelcText(w) {
            var kanbanTypeId = $("#selKBName").find("option:selected").val();
            var lineWorkdId = -1;
            var workshopId = -1;
            var lineId = -1;
            var welcomeMsg = $("#txtWelcomeMsg").val();
            workshopId = $("#<%=this.hdnWorkshopId.ClientID%>").val(); //车间id
            lineId = $("#<%=this.hdnLine.ClientID %>").val(); //线别id
            if (kanbanTypeId == 1) {
                lineWorkdId = lineId;
            } else if (kanbanTypeId == 2) {
                lineWorkdId = workshopId;
            }
            else if (kanbanTypeId == 3) {
                lineWorkdId = lineId;
            }

            $.ajax({
                url: 'KanBanList.aspx?Action=setwlc&w=' + escape($.trim(w)) + '&typeId=' + kanbanTypeId + '&lineworkId=' + lineWorkdId + '&welcomeMsg=' + escape(welcomeMsg) + '&rnd=' + Math.random(),
                type: 'get',
                success: function (data) {
                    alert(data);
                },
                datatype: 'text'
            })
        }

        function OnChoosePage(supID) {
            if (supID == 1) {
                dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=21&Multiple=false&CallBackFunc=setLineInfo&rnd=" + Math.random(), width: 600, height: 300 });
            } else if (supID == 2) {
                dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=71&Multiple=false&CallBackFunc=setSchedulingOrder&rnd=" + Math.random(), width: 600, height: 300 });
            } else if (supID == 3) {
                dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=8&Multiple=false&CallBackFunc=setStation&rnd=" + Math.random(), width: 600, height: 300 });
            } else if (supID == 4) {
                dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=122&Multiple=false&CallBackFunc=setWorkshop&rnd=" + Math.random(), width: 600, height: 300 });
            }
}

var showMsg = "";
function setWorkshop(list) {
    $("#<%=this.hdnWorkshopId.ClientID%>").val(list[0][0]);
    $("#<%=this.txtWorkshop.ClientID%>").val(list[0][1]);
    setWelcomeMsg(list[0][0], -1);
    return true;
}

function setLineInfo(list) {
    $("#<%=this.hdnLine.ClientID %>").val(list[0][0]);
    $("#<%=this.txtLine.ClientID %>").val(list[0][1]);
    setWelcomeMsg(-1, list[0][0]);
    return true;
}

/**
**设置欢迎词文本
**/
function setWelcomeMsg(workshopId, lineId) {
    var kanbanTypeId = $("#selKBName").find("option:selected").val();
    showMsg = SKT.LeanMES.Web.AjaxServices.AjaxKanban.GetWelcome(workshopId, lineId, kanbanTypeId).value;
    $("#txtWelcomeMsg").val(showMsg);
}

function View() {
    var reportName = "";
    var welcomeMsg = "";
    //var PopedomCode = $("#PopedomCode").val();
    //if (PopedomCode == "") {
    //    PopedomCode = "70200206";//默认 仓库收料看板
    //}
    ////判断权限//by liwen 20210721
    //if (!IsHasPermission(userId, PopedomCode)) {
    //    alert("没有操作权限！");
    //    return false;
    //}

    welcomeMsg = $.trim($("#txtWelcomeMsg").val());
    if (welcomeMsg == "")
        welcomeMsg = $.trim($("#txtGlobalWelcText").val());

    switch ($("#selKBName").val()) {
        case "1":
            var lineId = $("#<%=this.hdnLine.ClientID %>").val();
            var lineName = $("#<%=this.txtLine.ClientID %>").val();
            if (lineId < 1) {
                alert("请选择产线!");
                return false;
            }

            reportName = "SMTLineProductionKanban.aspx?lineId=" + lineId + "&lineName=" + escape(lineName) + "&welcomeMsg=" + escape(welcomeMsg);
            break;
        case "2":
            var workshopId = $("#<%=this.hdnWorkshopId.ClientID%>").val();
            var workshopName = $("#<%=this.txtWorkshop.ClientID%>").val();
            if (workshopId < 1) {
                alert("请选择车间!");
                return false;
            }
            reportName = "SMTWorkshopProductionKanban.aspx?workshopId=" + workshopId + "&workshopName=" + escape(workshopName) + "&welcomeMsg=" + escape(welcomeMsg);
            break;
        case "3":
            var lineId = $("#<%=this.hdnLine.ClientID %>").val();
            var lineName = $("#<%=this.txtLine.ClientID %>").val();
            //if (lineId < 1) {
            //    alert("请选择产线!");
            //    return false;
            //}

            reportName = "ReceivingMaterialKanBan.aspx?lineId=" + lineId + "&lineName=" + escape(lineName) + "&welcomeMsg=" + escape(welcomeMsg);
            break;
        case "4":
            var workshopId = $("#<%=this.hdnWorkshopId.ClientID%>").val();
            var workshopName = $("#<%=this.txtWorkshop.ClientID%>").val();
            if (workshopId < 1) {
                workshopId = -1;

            }
            reportName = "ProducationQuality.aspx?workshopId=" + workshopId + "&workshopName=" + escape(workshopName) + "&welcomeMsg=" + escape(welcomeMsg);
            break;
        case "5":
            reportName = "IqcWaitCheckOutKanban.aspx?welcomeMsg=" + escape(welcomeMsg);
            break;
        case "6":
            reportName = "MaterialPrepareKanban.aspx?welcomeMsg=" + escape(welcomeMsg);
            break;
        case "7":
            reportName = "PersonnelEfficiencykanban.aspx?welcomeMsg=" + escape(welcomeMsg);
            break;
        case "8":
            reportName = "SmtLineStatusKanBan.aspx?welcomeMsg=" + escape(welcomeMsg);
            break;
        case "9":
            var lineId = $("#<%=this.hdnLine.ClientID %>").val();
            var lineName = $("#<%=this.txtLine.ClientID %>").val();
            if (lineId < 1) {
                alert("请选择产线!");
                return false;
            }
            reportName = "SMTRefluxFurnaceKanban.aspx?lineId=" + lineId + "&lineName=" + escape(lineName) + "&welcomeMsg=" + escape(welcomeMsg);
            break;
        case "10":
            var lineId = $("#<%=this.hdnLine.ClientID %>").val();
            var lineName = $("#<%=this.txtLine.ClientID %>").val();
            if (lineId < 1) {
                alert("请选择产线!");
                return false;
            }
            reportName = "PTHWaveSolderingKanBak.aspx?lineId=" + lineId + "&lineName=" + escape(lineName) + "&welcomeMsg=" + escape(welcomeMsg);
            break;
        case "11":
            reportName = "CPOutStockKanban.aspx?welcomeMsg=" + escape(welcomeMsg);
            break;
        case "12":
            reportName = "AccessoryKanBan.aspx?welcomeMsg=" + escape(welcomeMsg);
            break;
        case "13":
            reportName = "SMTWorkshopProductionKanbanTest.aspx?welcomeMsg=" + escape(welcomeMsg);
            break;
        case "14":
            reportName = "MSDKanBan.aspx?welcomeMsg=" + escape(welcomeMsg);
            break;
        case "15":
            var lineId = $("#<%=this.hdnLine.ClientID %>").val();
            var lineName = $("#<%=this.txtLine.ClientID %>").val();
            if (lineId < 1) {
                lineId = -1;
                lineName = "全部";
            }
            if (welcomeMsg == "" || welcomeMsg == null) {
                welcomeMsg = "热烈欢迎各位领导莅临参观指导";
            }
            reportName = "DayLinePlanReachedKanBan.aspx?lineId=" + lineId + "&lineName=" + escape(lineName) + "&welcomeMsg=" + escape(welcomeMsg);
            break;
        case "16":
            reportName = "IQCPassRateAndBadDistributionKanban.aspx?welcomeMsg=" + escape(welcomeMsg);
            break;
        case "17":
            var workshopId = $("#<%=this.hdnWorkshopId.ClientID%>").val();
            var workshopName = $("#<%=this.txtWorkshop.ClientID%>").val();
            if (workshopId < 1) {
                alert("请选择车间!");
                return false;
            }
            store.set('welcome-workshop-' + workshopId, welcomeMsg);

            reportName = "WorkshopEquipmentKanban.aspx?workshopId=" + workshopId + "&workshopName=" + escape(workshopName) + "&welcomeMsg=" + escape(welcomeMsg);
            break;
        case "18":
            var lineId = $("#<%=this.hdnLine.ClientID %>").val();
            var lineName = $("#<%=this.txtLine.ClientID %>").val();
            if (lineId < 1) {
                alert("请选择产线!");
                return false;
            }
            store.set('welcome-line-' + lineId, welcomeMsg);

            reportName = "LineEquipmentProductionStatus.aspx?lineId=" + lineId + "&lineName=" + escape(lineName) + "&welcomeMsg=" + escape(welcomeMsg);
            break;
        case "19":
            reportName = "SupplierDeliveryKanban.aspx?welcomeMsg=" + escape(welcomeMsg);
            break;
        case "20":
            var workshopId = $("#<%=this.hdnWorkshopId.ClientID%>").val();
            if (workshopId < 1) {
                alert("请选择车间!");
                return false;
            }
            reportName = "AgeingRackKanban.aspx?workshopId=" + workshopId + "&welcomeMsg=" + escape(welcomeMsg);
            break;

        case "21":
            reportName = "EquipmentKanban.aspx?welcomeMsg=" + escape(welcomeMsg);

            break;
        case "22":
            reportName = "JITMaterialPreparation.aspx?welcomeMsg=" + escape(welcomeMsg);

            break;
        case "23":
            reportName = "JITMaterialDistribution.aspx?welcomeMsg=" + escape(welcomeMsg);

            break;
        case "24":
            reportName = "SupplierDeliveryKanban_New.aspx?welcomeMsg=" + escape(welcomeMsg);
            break;
        case "25":
            reportName = "EquipmentMounterKanban.aspx?welcomeMsg=" + escape(welcomeMsg);
            break;
        case "26":
            reportName = "ThrowMaterialRateKanban.aspx?welcomeMsg=" + escape(welcomeMsg);
            break;
        case "27":
               var lineId = $("#<%=this.hdnLine.ClientID %>").val();
            var lineName = $("#<%=this.txtLine.ClientID %>").val();
            if (lineId < 1) {
                alert("请选择产线!");
                return false;
            }
            store.set('welcome-line-' + lineId, welcomeMsg);

            reportName = "PBABlankingKanBan.aspx?lineId=" + lineId + "&lineName=" + escape(lineName) + "&welcomeMsg=" + escape(welcomeMsg);
            break;
        case "28":
            var workshopId = $("#<%=this.hdnWorkshopId.ClientID%>").val();
            var workshopName = $("#<%=this.txtWorkshop.ClientID%>").val();
            if (workshopId < 1) {
                workshopId = -1;

            }
            reportName = "NineInOneKanban.aspx?workshopId=" + workshopId + "&workshopName=" + escape(workshopName) + "&welcomeMsg=" + escape(welcomeMsg);
            break;
        case "29":
            reportName = "EnergyMonitoringKanBan.aspx?welcomeMsg=" + escape(welcomeMsg);
            break;
        case "30":
            reportName = "InjectionMoldWorkshopProductionKanbanNewTest.aspx?welcomeMsg=" + escape(welcomeMsg);
            break;
        case "31":
            var lineId = $("#<%=this.hdnLine.ClientID %>").val();
            var lineName = $("#<%=this.txtLine.ClientID %>").val();
            if (lineId < 1) {
                alert("请选择产线!");
                return false;
            }
            store.set('welcome-line-' + lineId, welcomeMsg);

            reportName = "EqumentLineProductionKanban.aspx?lineId=" + lineId + "&lineName=" + escape(lineName) + "&welcomeMsg=" + escape(welcomeMsg);
            break;
        case "32":
            var workshopId = 1;
            var workshopName = $("#<%=this.txtWorkshop.ClientID%>").val();
            if (workshopId < 1) {
                alert("请选择车间!");
                return false;
            }
            store.set('welcome-workshop-' + workshopId, welcomeMsg);

            reportName = "ALLEqumentLineProductionKanban.aspx?workshopId=" + workshopId + "&workshopName=" + escape(workshopName) + "&welcomeMsg=" + escape(welcomeMsg);
            break;
        case "33":
            reportName = "FirstInspectionKanban.aspx?welcomeMsg=" + escape(welcomeMsg);
            break;
        case "34":
            reportName = "WorkshopQualityKanban.aspx?welcomeMsg=" + escape(welcomeMsg);
            break;
        case "40":
            reportName = "MDProductionKanbanNew.aspx?welcomeMsg=" + escape(welcomeMsg);
            break;
        case "41":
            var workshopId = $("#<%=this.hdnWorkshopId.ClientID%>").val();
            var workshopName = $("#<%=this.txtWorkshop.ClientID%>").val();
            if (workshopId < 1) {
                alert("请选择车间!");
                return false;
            }
            reportName = "EquipmentGeneralKanBan.aspx?workshopId=" + workshopId + "&workshopName=" + escape(workshopName) + "&welcomeMsg=" + escape(welcomeMsg);
            break;
        case "42":
            reportName = "ProductionOperationKanBan.aspx?welcomeMsg=" + escape(welcomeMsg);
            break;
    }

    window.open("<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Kanban/Builtin/" + reportName);
}

//设置tbody高度
function SetDataTBodyHeigth() {
    var outerHeigth = $("#outer").css("height").replace("px", "");
    //Tbody可用来显示数据的高度
    var tbody = window.screen.height - parseInt(outerHeigth);

    $("#MaiContent").css("height", tbody)
}

    </script>
</asp:Content>
