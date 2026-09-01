<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" CodeBehind="TechnologyParam.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.TechnologyParam" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <style type="text/css">
        .wrapper {
            padding-top: 10px;
            padding-left: 10px;
            padding-right: 10px;
        }

        .noBody {
            border: 0px solid #d3d3d3 !important;
        }

            .noBody tr td {
                border: 0px solid #d3d3d3 !important;
                padding-bottom: 5px;
            }

        .wrapper h1 {
            text-align: center;
            font-size: 30px;
            font-weight: bold;
            padding-bottom: 10px;
        }

        table tr th, table tr td, table tr td {
            text-align: center;
        }

        table a {
            font-size: 16px !important;
        }

        table label {
            font-size: 16px !important;
        }

        table input[type=text] {
            width: 90%;
        }

        .BtnBox {
            padding: 10px;
        }

        #iqcDetail, #iqcContent, #iqcSize, #iqcPerformance, #iqcTest {
            font-size: 20px;
            border: 0.5px solid #000;
            border-collapse: collapse;
        }

            #iqcDetail tr td, #iqcContent tr td, #iqcSize tr td, #iqcPerformance tr td, #iqcTest tr td {
                border: 0.5px solid #000;
            }

        /*.uploadify-button {
            width: 35px !important;
        }

        #fileUpload-button {
            width: 35px !important;
        }

        #fileUpload object {
            width: auto !important;
            display: inline !important;
        }

        #iqcTestUpload-button {
            width: 500px;
        }
        */

        #iqcTestUpload object {
            width: auto !important;
            display: inline !important;
        }
    </style>



    <div class="wrap_tb" id="wrap_tb">
        <ul class="tb">
            <li class="current" id="Div1">注塑工艺参数</li>
            <li>注塑工艺参数录入</li>
        </ul>
        <div class="tb_c tb_content">
            <div id="divDtl">
                <table class="EditeContentTable" width="100%">
                    <tr>
                        <td class="Label4">射胶时间</td>
                        <td class="Field4">
                            <asp:Label ID="SampleValueVPTime" runat="server"></asp:Label>
                        </td>
                        <td class="Label4">保压压力一段</td>
                        <td class="Field4">
                            <asp:Label ID="Holding_Pressure_1" runat="server"></asp:Label>
                        </td>
                        <td class="Label4">保压压力二段</td>
                        <td class="Field4">
                            <asp:Label ID="Holding_Pressure_2" runat="server"></asp:Label>
                        </td>
                        <td class="Label4">保压时间一段</td>
                        <td class="Field4">
                            <asp:Label ID="Holding_Time_1" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="Label4">保压时间二段</td>
                        <td class="Field4">
                            <asp:Label ID="Holding_Time_2" runat="server"></asp:Label>
                        </td>
                        <td class="Label4">冷却时间</td>
                        <td class="Field4">
                            <asp:Label ID="sCoolingTime" runat="server"></asp:Label>
                        </td>
                        <td class="Label4">背压</td>
                        <td class="Field4">
                            <asp:Label ID="Back_pressure_1" runat="server"></asp:Label>
                        </td>
                        <td class="Label4">熔胶位置</td>
                        <td class="Field4">
                            <asp:Label ID="Charge_Position_1" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="Label4">周期时间</td>
                        <%--获取数据--%>
                        <td class="Field4">
                            <asp:Label ID="Cycle_Time" runat="server"></asp:Label>
                        </td>
                         <td class="Label4">射咀温度</td>
                        <td class="Field4">
                            <asp:Label ID="Label31" runat="server"></asp:Label>
                        </td>

                        <td class="Label4" style="display:none">前模模温</td>
                        <td class="Field4" style="display:none">
                            <asp:Label ID="Label9" runat="server"></asp:Label>
                        </td>
                        <td class="Label4" style="display:none">后模模温</td>
                        <td class="Field4" style="display:none">
                            <asp:Label ID="Label10" runat="server"></asp:Label>
                        </td>
                        <td class="Label4" style="display:none">前模模温实测</td>
                        <td class="Field4" style="display:none">
                            <asp:Label ID="Label11" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr style="display:none">
                        <td class="Label4">后模模温实测</td>
                        <td class="Field4">
                            <asp:Label ID="Label12" runat="server"></asp:Label>
                        </td>
                        <td class="Label4">热嘴</td>
                        <td class="Field4">
                            <asp:Label ID="Label13" runat="server"></asp:Label>
                        </td>
                        <td class="Label4">热流道板一段</td>
                        <td class="Field4">
                            <asp:Label ID="Label14" runat="server"></asp:Label>
                        </td>
                        <td class="Label4">热流道板二段</td>
                        <td class="Field4">
                            <asp:Label ID="Label15" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr style="display:none">
                        <td class="Label4">热嘴1</td>
                        <td class="Field4">
                            <asp:Label ID="Label16" runat="server"></asp:Label>
                        </td>
                        <td class="Label4">热嘴2</td>
                        <td class="Field4">
                            <asp:Label ID="Label17" runat="server"></asp:Label>
                        </td>
                        <td class="Label4">热嘴3</td>
                        <td class="Field4">
                            <asp:Label ID="Label18" runat="server"></asp:Label>
                        </td>
                        <td class="Label4">热嘴4</td>
                        <td class="Field4">
                            <asp:Label ID="Label19" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr style="display:none">
                        <td class="Label4">热嘴5</td>
                        <td class="Field4">
                            <asp:Label ID="Label20" runat="server"></asp:Label>
                        </td>
                        <td class="Label4">热嘴6</td>
                        <td class="Field4">
                            <asp:Label ID="Label21" runat="server"></asp:Label>
                        </td>
                        <td class="Label4">热嘴7</td>
                        <td class="Field4">
                            <asp:Label ID="Label22" runat="server"></asp:Label>
                        </td>
                        <td class="Label4">热嘴8</td>
                        <td class="Field4">
                            <asp:Label ID="Label23" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr style="display:none"> 
                        <td class="Label4">热嘴9</td>
                        <td class="Field4">
                            <asp:Label ID="Label24" runat="server"></asp:Label>
                        </td>
                        <td class="Label4">热嘴10</td>
                        <td class="Field4">
                            <asp:Label ID="Label25" runat="server"></asp:Label>
                        </td>
                        <td class="Label4">热嘴11</td>
                        <td class="Field4">
                            <asp:Label ID="Label26" runat="server"></asp:Label>
                        </td>
                        <td class="Label4">热嘴12</td>
                        <td class="Field4">
                            <asp:Label ID="Label27" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr style="display:none">
                        <td class="Label4">烘料时间</td>
                        <td class="Field4">
                            <asp:Label ID="Label28" runat="server"></asp:Label>
                        </td>
                        <td class="Label4">烤料温度</td>
                        <td class="Field4">
                            <asp:Label ID="Label29" runat="server"></asp:Label>
                        </td>
                        <td class="Label4">原材料水分含量</td>
                        <td class="Field4">
                            <asp:Label ID="Label30" runat="server"></asp:Label>
                        </td>
                        <td class="Label4">射咀温度</td>
                        <td class="Field4">
                            <asp:Label ID="Label311" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="Label4">第一段温度</td>
                        <td class="Field4">
                            <asp:Label ID="Label32" runat="server"></asp:Label>
                        </td>
                        <td class="Label4">第二段温度</td>
                        <td class="Field4">
                            <asp:Label ID="Label33" runat="server"></asp:Label>
                        </td>
                        <td class="Label4">第三段温度</td>
                        <td class="Field4">
                            <asp:Label ID="Label34" runat="server"></asp:Label>
                        </td>
                        <td class="Label4">第四段温度</td>
                        <td class="Field4">
                            <asp:Label ID="Label35" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="Label4" style="display:none">射胶温度实测</td>
                        <td class="Field4" style="display:none">
                            <asp:Label ID="Label36" runat="server"></asp:Label>
                        </td>
                        <td class="Label4">射胶压力</td>
                        <td class="Field4">
                            <asp:Label ID="Label37" runat="server"></asp:Label>
                        </td>
                        <td class="Label4">射胶压力二段</td>
                        <td class="Field4">
                            <asp:Label ID="Label38" runat="server"></asp:Label>
                        </td>
                        <td class="Label4">射胶压力三段</td>
                        <td class="Field4">
                            <asp:Label ID="Label39" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="Label4">射胶压力四段</td>
                        <td class="Field4">
                            <asp:Label ID="Label40" runat="server"></asp:Label>
                        </td>
                        <td class="Label4">射胶速度一段</td>
                        <td class="Field4">
                            <asp:Label ID="Label41" runat="server"></asp:Label>
                        </td>
                        <td class="Label4">射胶速度二段</td>
                        <td class="Field4">
                            <asp:Label ID="Label42" runat="server"></asp:Label>
                        </td>
                        <td class="Label4">射胶速度三段</td>
                        <td class="Field4">
                            <asp:Label ID="Label43" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="Label4">射胶速度四段</td>
                        <td class="Field4">
                            <asp:Label ID="Label44" runat="server"></asp:Label>
                        </td>
                        <td class="Label4">射胶位置一段</td>
                        <td class="Field4">
                            <asp:Label ID="Label45" runat="server"></asp:Label>
                        </td>
                        <td class="Label4">射胶位置二段</td>
                        <td class="Field4">
                            <asp:Label ID="Label46" runat="server"></asp:Label>
                        </td>
                        <td class="Label4">射胶位置三段</td>
                        <td class="Field4">
                            <asp:Label ID="Label47" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="Label4">射胶位置四段</td>
                        <td class="Field4">
                            <asp:Label ID="Label48" runat="server"></asp:Label>
                        </td>
                        <td class="Label4">保压切换位置</td>
                        <td class="Field4">
                            <asp:Label ID="Label49" runat="server"></asp:Label>
                        </td>
                        <td class="Label4" style="display:none">锁模力</td>
                        <td class="Field4" style="display:none">
                            <asp:Label ID="Label50" runat="server"></asp:Label>
                        </td>
                        <td class="Label4">熔胶压力</td>
                        <td class="Field4">
                            <asp:Label ID="Label51" runat="server"></asp:Label>
                        </td>
                        <td class="Label4">熔胶速度</td>
                        <td class="Field4">
                            <asp:Label ID="Label52" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr style="display:none">
                        <td class="Label4">熔胶速度</td>
                        <td class="Field4">
                            <asp:Label ID="Label521" runat="server"></asp:Label>
                        </td>
                    </tr>
                </table>
            </div>
            <br />
        </div>
        <div>
            <table class="EditeContentTable" width="100%" id="dataTable" runat="server">
                <tr style="display:none">
                    <td class="Label4">前模模温</td>
                    <td class="Field4">
                        <input type="text" id="Text0" runat="server" />
                    </td>
                    <td class="Label4">后模模温</td>
                    <td class="Field4">
                        <input type="text" runat="server" id="Text2" />
                    </td>
                    <td class="Label4">前模模温实测</td>
                    <td class="Field4">
                        <input type="text" runat="server" id="Text3" />
                    </td>
                    <td class="Label4">后模模温实测</td>
                    <td class="Field4">
                        <input type="text" runat="server" id="Text4" />
                    </td>
                </tr>
                <tr style="display:none">
                    <td class="Label4">热嘴</td>
                    <td class="Field4">
                        <input type="text" runat="server" id="Text5" />
                    </td>
                    <td class="Label4">热流道板一段</td>
                    <td class="Field4">
                        <input type="text" runat="server" id="Text6" />
                    </td>
                    <td class="Label4">热流道板二段</td>
                    <td class="Field4">
                        <input type="text" runat="server" id="Text7" />
                    </td>
                    <td class="Label4">热嘴1</td>
                    <td class="Field4">
                        <input type="text" runat="server" id="Text8" />
                    </td>
                </tr>
                <tr style="display:none">
                    <td class="Label4">热嘴2</td>
                    <td class="Field4">
                        <input type="text" runat="server" id="Text9" />
                    </td>
                    <td class="Label4">热嘴3</td>
                    <td class="Field4">
                        <input type="text" runat="server" id="Text10" />
                    </td>
                    <td class="Label4">热嘴4</td>
                    <td class="Field4">
                        <input type="text" runat="server" id="Text11" />
                    </td>
                    <td class="Label4">热嘴5</td>
                    <td class="Field4">
                        <input type="text" runat="server" id="Text12" />
                    </td>
                </tr>
                <tr style="display:none">
                    <td class="Label4">热嘴6</td>
                    <td class="Field4">
                        <input type="text" runat="server" id="Text13" />
                    </td>
                    <td class="Label4">热嘴7</td>
                    <td class="Field4">
                        <input type="text" runat="server" id="Text14" />
                    </td>
                    <td class="Label4">热嘴8</td>
                    <td class="Field4">
                        <input type="text" runat="server" id="Text15" />
                    </td>
                    <td class="Label4">热嘴9</td>
                    <td class="Field4">
                        <input type="text" runat="server" id="Text16" />
                    </td>
                </tr>
                <tr style="display:none">
                    <td class="Label4">热嘴10</td>
                    <td class="Field4">
                        <input type="text" runat="server" id="Text17" />
                    </td>
                    <td class="Label4">热嘴11</td>
                    <td class="Field4">
                        <input type="text" runat="server" id="Text18" />
                    </td>
                    <td class="Label4">热嘴12</td>
                    <td class="Field4">
                        <input type="text" runat="server" id="Text19" />
                    </td>
                    <td class="Label4">烘料时间</td>
                    <td class="Field4">
                        <input type="text" runat="server" id="Text20" />
                    </td>
                </tr>
                <tr>
                    <td class="Label4" style="display:none">烤料温度</td>
                    <td class="Field4" style="display:none">
                        <input type="text" runat="server" id="Text21" />
                    </td>
                    <td class="Label4" style="display:none">原材料水分含量</td>
                    <td class="Field4" style="display:none">
                        <input type="text" runat="server" id="Text22" />
                    </td>
                    <td class="Label4">射咀温度</td>
                    <td class="Field4">
                        <input type="text" runat="server" id="TempReal1" />
                    </td>
                    <td class="Label4">第一段温度</td>
                    <td class="Field4">
                        <input type="text" runat="server" id="TempReal2" />
                    </td>
                    <td class="Label4"></td>
                    <td class="Field4">
                    </td>
                    <td class="Label4"></td>
                    <td class="Field4">
                    </td>
                    
                </tr>
                <tr>
                    <td class="Label4">第二段温度</td>
                    <td class="Field4">
                        <input type="text" runat="server" id="TempReal3" />
                    </td>
                    <td class="Label4">第三段温度</td>
                    <td class="Field4">
                        <input type="text" runat="server" id="TempReal4" />
                    </td>
                    <td class="Label4">第四段温度</td>
                    <td class="Field4">
                        <input type="text" runat="server" id="TempReal5" />
                    </td>
                    <td class="Label4" style="display:none">射胶温度实测</td>
                    <td class="Field4" style="display:none">
                        <input type="text" runat="server" id="Text25" />
                    </td>
                     <td class="Label4"></td>
                 <td class="Field4">
                 </td>
                    
                </tr>
                <tr>
                    <td class="Label4">射胶压力</td>
                    <td class="Field4">
                        <input type="text" runat="server" id="Inject_P1" />
                    </td>
                    <td class="Label4">射胶压力二段</td>
                    <td class="Field4">
                        <input type="text" runat="server" id="Inject_P2" />
                    </td>
                    <td class="Label4">射胶压力三段</td>
                    <td class="Field4">
                        <input type="text" runat="server" id="Inject_P3" />
                    </td>
                    <td class="Label4">射胶压力四段</td>
                    <td class="Field4">
                        <input type="text" runat="server" id="Inject_P4" />
                    </td>
                </tr>
                <tr>
                    <td class="Label4">射胶速度一段</td>
                    <td class="Field4">
                        <input type="text" runat="server" id="Inject_V1" />
                    </td>
                    <td class="Label4">射胶速度二段</td>
                    <td class="Field4">
                        <input type="text" runat="server" id="Inject_V2" />
                    </td>
                    <td class="Label4">射胶速度三段</td>
                    <td class="Field4">
                        <input type="text" runat="server" id="Inject_V3" />
                    </td>
                    <td class="Label4">射胶速度四段</td>
                    <td class="Field4">
                        <input type="text" runat="server" id="Inject_V4" />
                    </td>
                </tr>
                <tr>
                    <td class="Label4">射胶位置一段</td>
                    <td class="Field4">
                        <input type="text" runat="server" id="Inject_S1" />
                    </td>
                    <td class="Label4">射胶位置二段</td>
                    <td class="Field4">
                        <input type="text" runat="server" id="Inject_S2" />
                    </td>
                    <td class="Label4">射胶位置三段</td>
                    <td class="Field4">
                        <input type="text" runat="server" id="Inject_S3" />
                    </td>
                    <td class="Label4">射胶位置四段</td>
                    <td class="Field4">
                        <input type="text" runat="server" id="Inject_S4" />
                    </td>
                </tr>
                <tr>
                    <td class="Label4">保压切换位置</td>
                    <td class="Field4">
                        <input type="text" runat="server" id="SampleValueVPPosition" />
                    </td>
                    <td class="Label4" style="display:none">锁模力</td>
                    <td class="Field4" style="display:none">
                        <input type="text" runat="server" id="Text39" />
                    </td>
                    <td class="Label4">熔胶压力</td>
                    <td class="Field4">
                        <input type="text" runat="server" id="Charge_Force_1" />
                    </td>
                    <td class="Label4">熔胶速度</td>
                    <td class="Field4">
                        <input type="text" runat="server" id="Charge_Verlocity_1" />
                    </td>
                     <td class="Label4"></td>
                     <td class="Field4">
                     </td>
                </tr>
            </table>
            <div style="text-align: center;margin-top:20px">
                <input type='button' class='result-entry' value='保存' onclick='Save()' />
                <input type='button' class='result-entry' value='注塑数据获取' onclick='Get()' />
            </div>
        </div>
    </div>
    <input id="inputPOCode" type="hidden" />
    <input id="inputDeliverNo" type="hidden" />
    <input id="inputVenCode" type="hidden" />
    <script type="text/javascript" src="../Content/js/jquery-3.1.0.min.js"></script>
    <script type="text/javascript" src="../Content/plugin/uploadify/jquery.uploadify.min.js"></script>
    <script type="text/javascript">
        var LinePlanCode = "<%=Request.QueryString["LinePlanCode"]%>"
        
        $(function () {
            if (!LinePlanCode) {
                return false
            }
            // 获取注塑机数据
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipment.GetOpcPointData(LinePlanCode);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return;
            }
            var data = ajax.value.Rows;
            for (var i = 0; i < data.length; i++) {
                $('#ContentPlaceHolder1_EditContent_' + data[i].PointName).text(data[i].Data)
            }
        });


        // 获取方法
        function Get() {
            if (!LinePlanCode) {
                return false
            }
            // 获取注塑机数据
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipment.GetOpcPointData(LinePlanCode);

            if (ajax.error != null) {
                alert(ajax.error.Message);
                return;
            }
            var data = ajax.value.Rows;            
            for (var i = 0; i < data.length; i++) {
                $('#ContentPlaceHolder1_EditContent_' + data[i].PointName).val(data[i].Data)
            }

            alert("获取成功");
        }

        // 保存方法
        function Save() {
            // 获取数据
            var data = [];
            $("#ContentPlaceHolder1_EditContent_dataTable tr").each(function (i, j) {
                $(j).find("td").each(function (n, m) {
                    if ((n + 1) % 2 == 0) {
                        var entity = {};
                        var td = $(m).find("input");
                        entity.LinePlanID = null;
                        if (td.length > 0) {
                            entity.TechnologyParamName = td.attr("id").replace('ContentPlaceHolder1_EditContent_', '')
                            entity.Data = td.val()
                            entity.CreateTime = null
                            entity.LinePlanCode = LinePlanCode
                            data.push(entity)
                        }
                        
                    }
                });
            });
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipment.SaveTechnologyParam(JSON.stringify(data));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return;
            }

            // 保存数据后刷新页面
            window.location.reload();
        }

    </script>
</asp:Content>
