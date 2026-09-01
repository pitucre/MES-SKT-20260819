<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/ViewMaster.master"
    CodeBehind="IQCFormAttend.aspx.cs" Inherits="SKT.LeanMES.Web.Quality.IQCFormAttend" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="Server">
    <style type="text/css">
        input.btn-disabled { cursor:not-allowed; background-color:#337ab7; border-color:#2e6da4; opacity:0.65;}
        .Label1Use {
            width: 10%;
            height: 26px;
            text-align: right;
            padding: 5px 5px 5px 0px;
            border-top: 1px solid #d3d3d3;
            border-left: 1px solid #d3d3d3;
            border-right: 1px solid #d3d3d3;
            border-bottom: 1px solid #d3d3d3;
            background-color: #f7f7f7;
        }
        .Field1Use {
            word-break: break-all;
            width: 16%;
            height: 26px;
            text-align: left;
            background-color: #fff;
            padding: 5px 0px 5px 5px;
            border-top: 1px solid #d3d3d3;
            border-left: 1px solid #d3d3d3;
            border-right: 1px solid #d3d3d3;
            border-bottom: 1px solid #d3d3d3;
        }
    </style>
    <table width="100%" class="EditeContentTable" style="margin-bottom: -1px;">
        <tr>
            <td class="infoTips" colspan="4">
                <%=Resources.Messages.WithAsteriskIsRequired %>
            </td>
        </tr>
        <tr class="clear5">
        </tr>
        <tr>
            <td class="Label2">MRB单号
            </td>
            <td class="Field2">
                <asp:Literal ID="ltrMRBNo" runat="server" ClientIDMode="Static"></asp:Literal>
            </td>
            <td class="Label2">IQC检验单号
            </td>
            <td class="Field2">
                <input type="hidden" value="-1" id="hdnIQCId" runat="server" clientidmode="Static" />
                <asp:Literal ID="lblIQCNo" runat="server" ClientIDMode="Static"></asp:Literal>
            </td>
        </tr>
        <tr>
            <td class="Label2">优先级
            </td>
            <td class="Field2">
                <asp:Label ID="lblUrgentLevel" runat="server" ></asp:Label>
            </td>
            <td class="Label2">检验数量
            </td>
            <td class="Field2" colspan="3">
                <asp:Label ID="lblCheckQty" runat="server" ClientIDMode="Static"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">物料编码
            </td>
            <td class="Field2">
                <asp:Label ID="lblItemCode" runat="server"></asp:Label>
            </td>
            <td class="Label2">物料名称
            </td>
            <td class="Field2">
                <asp:Label ID="lblItemName" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">处理结果<em>*</em>
            </td>
            <td class="Field2" colspan="3">
                <asp:DropDownList runat="server" ID="ddlIQCStatus" ClientIDMode="Static">
                </asp:DropDownList>
            </td>
        </tr>
        <tr  id="textdesc">
            <%--<td class="Label2">不良描述
            </td>--%>
            <td class="Label2">异常原因<em>*</em>
            </td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="desc" runat="server" CssClass="TextBox" Width="600px"></asp:TextBox>
            </td>
        </tr>
        <tr class="close-remark" style="display:none;">
            <td class="Label2">备注
            </td>
            <td class="Field2" colspan="3">
                    <input id="txtDealRemark" class="TextBox" style="min-width:600px"/>
            </td>
        </tr>
    </table>
    <div id="showCheckButton">
        <table class="EditeContentTable" style="width: 100%;">
            <tr>
                <td class="Field2" colspan="4" style="text-align: center;">
                    <input id="Button2" type="button" class="btn-save" value="保存检验结果" onclick="if (SubmitValidation()) { SaveForm(); }" />
                    <input type="button" class="close-case btn-disabled" disabled="disabled" value="结案" onclick="CloseCase();" style=" margin-left:15px; width:60px;" />
                </td>
            </tr>
        </table>
    </div>
    <div id="showChooseSome" style="display: none">
        <table id="tabTmplContent1" class="EditeContentTable" style="width: 100%;">
            <%--<tr>
                <td class="infoTips" colspan="4">
                    <span style="font-size: 13px;">请扫描合格的物料条码。 如需恢复初始状态，可再次扫描物料条码！</span>
                </td>
            </tr>--%>
            <tr id="idGrn">
                <td class="Label2">扫描方式
                </td>
                <td class="Field2">
                    <asp:DropDownList ID="ddlScanningMode" runat="server" ClientIDMode="Static" onchange="JavaScript:ChangeScanningMode(this)">                        
                        <asp:ListItem Value='1'>不良品扫描</asp:ListItem>
                        <asp:ListItem Value='0'>良品扫描</asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td class="Label2">物料/包装箱条码扫描
                </td>
                <td class="Field2">
                    <input type="text" class="TextBox" id="txtGrn" onchange="changeGrn(this)" />&nbsp;&nbsp;<br/><div style="display:none;" id="goodProduct"><span>合格数：<span id="lblOkGRN">0</span> / <span id="lblTotalGRN">0</span></span></div>
                    <div  id="badProduct"><span>不合格数：<span id="lblNOGRN">0</span> / <span id="lblTotalGRN1">0</span></span></div>
                </td>
            </tr>
            <tr style="display: none">
                <td class="Label1">是否挑选完毕
                </td>
                <td class="Field1">
                    <input type="checkbox" id="checkAll" checked="checked" disabled="disabled" />
                </td>
            </tr>
            <tr>
                <td class="Field1" colspan="4" style="text-align: center;">
                    <input id="Button3" type="button" class="btn-save" value="保存挑选结果" onclick="Save();" />
                    <input type="button" class="close-case btn-disabled" disabled="disabled" value="结案" onclick="CloseCase();" style=" margin-left:15px; width:60px;" />
                </td>
            </tr>
        </table>
        <br />
        <table id="tbGrnInfo" class="EditeContentTable" style="width: 100%;">
        </table>
    </div>
    <div id="divShowNoGRN" style="display: none">
        <table id="Table1" class="EditeContentTable" style="width: 100%;">
            <tr id="Tr1">
                <td class="Label1">合格数量
                </td>
                <td class="Field1">
                    <input type="text" class="TextBox" id="txtGoodQty" onkeyup="if(isNaN(value))execCommand('undo')"
                        onafterpaste="if(isNaN(value))execCommand('undo')" />
                </td>
            </tr>
            <tr>
                <td class="Field1" colspan="2" style="text-align: center;">
                    <input id="btnNOGRN" type="button" class="btn-save" value="保存挑选结果" onclick="SaveNoGRN();" tabindex="10" />
                    <input type="button" class="close-case btn-disabled" disabled="disabled" value="结案" onclick="CloseCase();" style=" margin-left:15px; width:60px;" />
                </td>
            </tr>
        </table>
    </div>
    <div class="clear5">
    </div>
    <div style="text-align: center; margin-top: 5px;" class="Tips" id="msg">
    </div>
    <div class="clear5">
    </div>
    <div id="tblInfo">
    </div>
    <asp:HiddenField ID="hidIsHaveGRN" runat="server" Value="-1" ClientIDMode="Static" />
    <asp:HiddenField ID="hidMRBStatus" runat="server" Value="-1" ClientIDMode="Static" />
    <script type="text/javascript">
        var chooseIQCId = -1; //选中的IQC检验单
        var List = [];
        var preGrnArr = [];
        var isHaveGRN = 1; //有
        var mrbStatus = -1;//MRB状态
        var sIndex = 1;//扫描方式 0 良品扫描  1 不良品扫描
        var IsChooseOver = 0;

        $(function(){
            chooseIQCId = $("#hdnIQCId").val();
            isHaveGRN = $("#hidIsHaveGRN").val();
            mrbStatus = $("#hidMRBStatus").val();
            if(mrbStatus == "1"){
                $(".close-remark").show();
                $("#ddlIQCStatus").prop("disabled",true);
                $(".close-case").removeClass("btn-disabled").prop("disabled",false);
            }
            if(mrbStatus != "0"){
                $(".btn-save").addClass("btn-disabled").prop("disabled",true);
            }
            
        });
        //by liwen 20200806
        function ChangeScanningMode(dp) {
            sIndex = parseInt(dp.value);
            if (sIndex == 0) {
                $("#goodProduct").show();
                $("#badProduct").hide();
                //BuildTable(List);
                showGrn("");
                sumNGQty = 0;
                sumOKQty = 0;
                GrnNew = "";
                $("#lblNOGRN").html(0);
                
            } else if (sIndex == 1) {
                $("#goodProduct").hide();
                $("#badProduct").show();
                //BuildTable(List);
                showGrn("");
                sumNGQty = 0;
                sumOKQty = 0;
                GrnNew = "";
                $("#lblOkGRN").html(0);
            }
        }

        $("#txtGrn").keydown(function (event) {
            var e = event || window.event
            if (e && e.keyCode == 13) {
                if ($.trim($("#txtGrn").val()) != "") {
                    changeGrn(this);
                }
                return false;
            }
        });

        var chooseIqcResult = -1;
        $("#ddlIQCStatus").bind("change", function () {
            chooseIqcResult = $(this).val();
            if (chooseIQCId == -1) {
                alert("未找到检验单信息！");
                $(this).val(-1);
                return;
            }
            //if (chooseIqcResult == 2) {
            //    $("#textdesc").show();

            //} else {
            //    $("#textdesc").hide();
            //}
            if (chooseIqcResult == 4) { //挑选
                //如果挑选的话，有条码的话进行条码挑选如果没有进行数量挑选
                if (isHaveGRN == 1) {
                    $("#showChooseSome").show();
                    $("#divShowNoGRN").hide();
                }
                else {
                    $("#divShowNoGRN").show();
                    $("#showChooseSome").hide();
                }
                $("#showCheckButton").hide();
                showGrn("");
                //getGrnBackInfo();
            }
            else {
                $("#showChooseSome").hide();
                $("#showCheckButton").hide();
                $("#divShowNoGRN").hide();
                $("#showCheckButton").show();
            }
        });

        //保存检验数据
        function SaveForm() {
            if (confirm('已确认该处理结果?')) {
                var iqcCheckId = $("#ddlIQCStatus").val();
                if(iqcCheckId == "-1"){
                    alert("请选择处理结果");
                    return;
                }
                var Desc =$("#<%=this.desc.ClientID %>").val();
                if (Desc == "") {
                    alert("请输入异常原因");
                    return;
                }
                var dealRemark = $("#txtDealRemark").val();
                //挑选
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxInspection.SaveMaterialHand(chooseIQCId, iqcCheckId, Desc, dealRemark);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return;
                }
                else {
                    alert("数据保存成功！");
                    $(".close-remark").show();
                    $(".btn-save").addClass("btn-disabled").prop("disabled",true);
                    $(".close-case").removeClass("btn-disabled").prop("disabled",false);
                    //parent.window.Refresh();
                }
            }
        }

        //根据IQC检验单带出物料信息
        function getGrnBackInfo() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.GetIQCFormGrn(chooseIQCId);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return;
            }

            //判断是否条码
            var en = $.parseJSON(ajax.value);
            if (en.data[0].IsGRN === 0) {
                $("#idGrn").css("display", "none");
                isGrn = 0;
            }
            $('#tbGrnInfo').empty();
            //加载GRN信息
            List = en.data1;

            $.grep(List, function (o, j) {
                if (o.ChooseQty == "") {
                    o.ChooseQty = 0;
                }
                if (o.ScrapQty == "") {
                    o.ScrapQty = 0;
                }
                AddDtl(o);
            });
        }

        //根据GRN取得信息
        function changeGrn(t) {
            var GRN = $.trim($(t).val());
            //by liwen 20200806 
            var ddlScanningMode = $("#ddlScanningMode").val();
            if (ddlScanningMode == 0) {//良品扫描
                ChangeNg(GRN);
            } else if (ddlScanningMode == 1) {//不良品扫描
                ChangeBadNg(GRN);
            } else {
                alert("请选择扫描方式!");
                return false;
            }
            $(t).val("");
        }

        function showGrn(GRN) {
           
            //判断存在以否
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.GetMaterialIQCHandleGrn(GRN, chooseIQCId);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return;
            }
            preGrnArr = $.parseJSON(ajax.value);
            List = $.parseJSON(ajax.value);
            BuildTable(List);
            $("#txtGrn").focus();
            $("#showChooseSome").show();
        }

        //挑选不良数
        var sumNGQty = 0;
        var sumOKQty = 0;
        var GrnNew = "";
        function ChangeBadNg(Grn) {
            
            var isOKGrn = false;
            var okQty = 0;
            var ngQty = 0;
            var ishavpack = false;
            var pkserialnumber = "";
            var totalQty = parseInt($("#lblCheckQty").text());
            var checkQty = 0;
            List.forEach(function (i, v) {
                checkQty += i.NgQty;
            });

            for (var i = 0; i < List.length; i++) {
                if (List[i].PKSerialNumber != "") { 
                    if (List[i].PKSerialNumber == Grn) {
                        if (checkQty + List[i].TotalQty >= totalQty) {
                            alert("当前所有GRN全部为不合格，请选择‘批量退货’处理方式!（不合格数只能<总数量" + totalQty + "）");
                            break;
                        }
                        okQty = 0;
                        ngQty = ngQty + List[i].TotalQty;
                        List[i].OKQty = 0;
                        List[i].NgQty = List[i].TotalQty;
                        isOKGrn = true;
                        if (GrnNew.indexOf(List[i].GRN) == -1) {//判断重复扫描
                            sumNGQty = sumNGQty + List[i].TotalQty;
                            GrnNew += List[i].GRN + ",";
                        }
                    }
                    if (List[i].GRN == Grn) {
                        if (checkQty + List[i].TotalQty >= totalQty) {
                            alert("当前所有GRN全部为不合格，请选择‘批量退货’处理方式!（不合格数只能<总数量" + totalQty + "）");
                            break;
                        }
                        ishavpack = true;
                        pkserialnumber = List[i].PKSerialNumber;
                        okQty = 0;
                        ngQty = List[i].TotalQty;
                        List[i].OKQty = 0;
                        List[i].NgQty = List[i].TotalQty;
                        isOKGrn = true;
                        if (GrnNew.indexOf(Grn) == -1) {//判断重复扫描
                            sumNGQty = sumNGQty + List[i].TotalQty;
                            GrnNew += Grn + ",";
                        }
                    }
                } else {
                    if (List[i].GRN == Grn) {
                        if (checkQty + List[i].TotalQty >= totalQty) {
                            alert("当前所有GRN全部为不合格，请选择‘批量退货’处理方式!（不合格数只能<总数量" + totalQty + "）");
                            break;
                        }
                        okQty = 0;
                        ngQty = List[i].TotalQty;
                        List[i].OKQty = 0;
                        List[i].NgQty = List[i].TotalQty;
                        isOKGrn = true;
                        if (GrnNew.indexOf(Grn) == -1) {//判断重复扫描
                            sumNGQty = sumNGQty + List[i].TotalQty;
                            GrnNew += Grn + ",";
                        }
                    }
                }
            }
            //$.grep(List, function (o, j) {
            //    if (o.GRN == Grn) {
            //        okQty = 0;
            //        ngQty = o.TotalQty;
            //        o.OKQty = 0;
            //        o.NgQty = o.TotalQty;
            //        isOKGrn = true;
            //        if (GrnNew.indexOf(Grn)==-1) {//判断重复扫描
            //            sumNGQty = sumNGQty + o.TotalQty;
            //            GrnNew += Grn + ",";
            //        }
            //    }
            //});
            if (!isOKGrn) return;
            if (ishavpack) {
                if (confirm("扫描的物料条码已经放进包装箱，是否解除该物料条码包装？")) {
                    //解除物料条码与包装箱
                    var ajax1 = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.UnPack(pkserialnumber);
                    if (ajax1.error != null) {
                        alert(ajax1.error.Message);
                        return false;
                    }
                    var ajax2 = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.RemoveGRN(pkserialnumber, Grn);
                    if (ajax2.error != null) {
                        alert(ajax2.error.Message);
                        return false;
                    }
                    var ajax3 = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.ClosePack(pkserialnumber);
                    if (ajax3.error != null) {
                        alert(ajax3.error.Message);
                        return false;
                    }
                    refreshgrnlist(Grn, pkserialnumber);
                } else { 
                    alert("扫描的物料条码已经放进包装箱，请扫描包装箱或者先解除！");
                    return;
                }
            }
            if (!ishavpack && !isOKGrn) {
                alert("扫描的物料条码不属于该检验单！");
                return;
            }
            else {
                $("#lblNOGRN").text(sumNGQty.toFixed(6));
                //查找表单GRN
                $("#tbGrnInfo tr:gt(0) td").each(function () {
                    if ($(this).text() == Grn) {
                        $(this).parent().children().css("background-color", "green").css("color", "#000");
                        $(this).parent().find("td:eq(4)").text(0);
                        $(this).parent().find("td:eq(5)").text($(this).parent().find("td:eq(3)").text());
                        $(this).parent().prependTo($('#tbGrnInfo tbody'));
                        $(this).parent().find("td:eq(6) input").val("").attr("disabled", false);
                    }
                });
            }
        }

        //挑选良品数
        function ChangeNg(Grn) {          
            var isOKGrn = false;
            var okQty = 0;
            var ngQty = 0;
            var ishavpack = false;
            var pkserialnumber = "";
            var totalQty = parseInt($("#lblCheckQty").text());
            var checkQty = 0;
            List.forEach(function (i, v) {
                checkQty += i.OKQty;
            });
            for (var i = 0; i < List.length; i++) {
                if (List[i].PKSerialNumber != "") {
                    if (List[i].PKSerialNumber == Grn) {
                        if (checkQty + List[i].TotalQty >= totalQty) {
                            alert("当前所有GRN全部为合格，请选择‘特采’处理方式!（不合格数只能<总数量"+totalQty+"）");
                            break;
                        }

                        ngQty = 0;
                        okQty = okQty + List[i].TotalQty;
                        List[i].OKQty = List[i].TotalQty;
                        List[i].NgQty = 0;
                        isOKGrn = true;
                        if (GrnNew.indexOf(List[i].GRN) == -1) {//判断重复扫描
                            sumOKQty = sumOKQty + List[i].TotalQty;
                            GrnNew += List[i].GRN + ",";
                        }
                    }
                    if (List[i].GRN == Grn) {
                        if (checkQty + List[i].TotalQty >= totalQty) {
                            alert("当前所有GRN全部为合格，请选择‘特采’处理方式!（不合格数只能<总数量" + totalQty + "）");
                            break;
                        }

                        ishavpack = true;
                        pkserialnumber = List[i].PKSerialNumber;                        
                        ngQty = 0;
                        okQty = okQty + List[i].TotalQty;
                        List[i].OKQty = List[i].TotalQty;
                        List[i].NgQty = 0;
                        isOKGrn = true;
                        if (GrnNew.indexOf(List[i].GRN) == -1) {//判断重复扫描
                            sumOKQty = sumOKQty + List[i].TotalQty;
                            GrnNew += List[i].GRN + ",";
                        }
                    }
                } else {
                    if (List[i].GRN == Grn) {
                        if (checkQty + List[i].TotalQty >= totalQty) {
                            alert("当前所有GRN全部为合格，请选择‘特采’处理方式!（不合格数只能<总数量"+totalQty+"）");
                            break;
                        }
                        ngQty = 0;
                        okQty = List[i].TotalQty;
                        List[i].OKQty = List[i].TotalQty;
                        List[i].NgQty = 0;
                        isOKGrn = true;
                        if (GrnNew.indexOf(Grn) == -1) {//判断重复扫描
                            sumOKQty = sumOKQty + List[i].TotalQty;
                            GrnNew += Grn + ",";
                        }
                    }
                }
            }

            if (!isOKGrn) return;

            //$.grep(List, function (o, j) {
            //    if (o.GRN == Grn) {
            //        ngQty = 0;
            //        okQty = o.TotalQty;
            //        o.OKQty = o.TotalQty;
            //        o.NgQty =0;
            //        isOKGrn = true;
            //        if (GrnNew.indexOf(Grn) == -1) {//判断重复扫描
            //            sumOKQty = sumOKQty + o.TotalQty;
            //            GrnNew += Grn + ",";
            //        }
            //    }
            //});
          
            if (ishavpack) {
                if (confirm("扫描的物料条码已经放进包装箱，是否解除该物料条码包装？")) {
                    //解除物料条码与包装箱
                    var ajax1 = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.UnPack(pkserialnumber);
                    if (ajax1.error != null) {
                        alert(ajax1.error.Message);
                        return false;
                    }
                    var ajax2 = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.RemoveGRN(pkserialnumber, Grn);
                    if (ajax2.error != null) {
                        alert(ajax2.error.Message);
                        return false;
                    }
                    var ajax3 = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.ClosePack(pkserialnumber);
                    if (ajax3.error != null) {
                        alert(ajax3.error.Message);
                        return false;
                    }
                    refreshgrnlist(Grn, pkserialnumber);
                } else {
                    alert("扫描的物料条码已经放进包装箱，请扫描包装箱或者先解包！");
                    return;
                }
            }
            if (!ishavpack && !isOKGrn) {
                alert("扫描的物料条码不属于该检验单！");
                return;
            }
            else {
                $("#lblOkGRN").text(sumOKQty.toFixed(6));
                //查找表单GRN
                $("#tbGrnInfo tr:gt(0) td").each(function () {
                    if ($(this).text() == Grn) {
                        $(this).parent().children().css("background-color", "green").css("color", "#fff");
                        $(this).parent().find("td:eq(4)").text($(this).parent().find("td:eq(3)").text());
                        $(this).parent().find("td:eq(5)").text(0);
                        $(this).parent().prependTo($('#tbGrnInfo tbody'))

                        $(this).parent().find("td:eq(6) input").val("").attr("disabled", "disabled");
                    }
                });
            }
        }

        function refreshgrnlist(Grn,packnu) {
            for (var i = 0; i < List.length; i++) {
                if (List[i].GRN == Grn) {
                    if (sIndex == 0) {
                        List[i].OKQty = List[i].TotalQty;
                        List[i].NgQty = 0;
                    }
                    if (sIndex == 1) {
                        List[i].OKQty = 0;
                        List[i].NgQty = List[i].TotalQty;
                    }

                    if (List[i].PKSerialNumber == packnu) {
                        List[i].PKSerialNumber = "";
                    }
                }
            }
            if(List.length>0)
                BuildTable(List);

        }

        //备注
        function ChangeRemark(Grn, t) {
            $.grep(List, function (o, j) {
                if (o.GRN == Grn) {
                    o.Remark = $.trim($(t).val());
                };
            });
        }

        //创建IQC物料GRN表格
        function BuildTable(dt) {
            $('#tbGrnInfo').html("");
            var th =
                "<thead><tr>" +
                    "<td class='Label1' style='text-align: center; width: 15%'>物料条码</td>" +
                    "<td class='Label1' style='text-align: center; width: 15%'>包装箱</td>" +
                    "<td class='Label1' style='text-align: center; width: 15%'>料号</td>" +
                    "<td class='Label1' style='text-align: center; width: 12%'>物料总数量</td>" +
                    "<td class='Label1' style='text-align: center; width: 12%'>合格数</td>" +
                    "<td class='Label1' style='text-align: center; width: 13%'>不合格数</td>" +
                    "<td class='Label1' style='text-align: center; width: 18%; display:none'>不良描述</td>" +
                    "<td class='Label1' style='text-align: center; width: 8%'>操作</td>" +
                    "</tr></thead>";


            var tr = "<tbody>";
            var entity;
            var sumTotalQty = 0;

            for (var i = 0; i < dt.length; i++) {
                entity = dt[i];
                sumTotalQty = sumTotalQty + entity.TotalQty;
                tr += "<tr>" +
                        "<td class='Field1' style=' width:15%'>" + entity.GRN + "</td>" +
                        "<td class='Field1' style=' width:15%'>" + entity.PKSerialNumber + "</td>" +
                        "<td class='Field1' style=' width:15%'>" + entity.ItemCode + "</td>" +
                        "<td class='Field1' style=' width:12%'>" + entity.TotalQty + "</td>" +
                        "<td class='Field1' style=' width:12%'><label>" + entity.OKQty + "</label></td>" +
                        "<td class='Field1' style=' width:13%'> " + entity.NgQty + "</td>" +
                        "<td class='Field1' style=' width:18%;display:none'><input type='text' value= '" + entity.Remark + "' style='width:90%' onchange=\"ChangeRemark('" + entity.GRN + "', $(this))\"/></td>" +
                        "<td class='Field1' style=' width:13%'><a href='javascript:void(0);' onclick=delGrn(this,'" + entity.GRN+ "')>删除</a></td>" +
                        "</tr>";
            }
            tr += "</tbody>";
            $("#lblTotalGRN").text(sumTotalQty.toFixed(6));
            $("#lblTotalGRN1").text(sumTotalQty.toFixed(6));
            $('#tbGrnInfo').append(th + tr);
        }
        function delGrn(obj, Grn) {
            if (IsChooseOver == 1) {
                alert("已挑选完毕不允许删除！");
                return false;
            }
            if (GrnNew.indexOf(Grn) == -1) {
                alert("您还未扫描过此GRN！");
                return false;
            }
            $(obj).parent().parent().children().css("background-color", "#fff").css("color", "rgb(0, 0, 0)");
            $(obj).parent().parent().find("td:eq(6) input").val("").removeAttr("disabled");
            for (var i = 0; i < preGrnArr.length; i++) {
                if (preGrnArr[i].GRN == Grn) {
                    $(obj).parent().parent().find("td:eq(4)").text(preGrnArr[i].OKQty);
                    $(obj).parent().parent().find("td:eq(5)").text(preGrnArr[i].NgQty);
                    if (sIndex == 0) {
                        var okSum = parseInt($("#lblOkGRN").text());
                        var newOkSum = okSum - preGrnArr[i].TotalQty;
                        sumOKQty = sumOKQty - preGrnArr[i].TotalQty;
                        $("#lblOkGRN").text(newOkSum.toFixed(6))
                    } else if (sIndex == 1) {
                        var badSum = parseInt($("#lblNOGRN").text());
                        var newBadSum = badSum - preGrnArr[i].TotalQty;
                        sumNGQty = sumNGQty - preGrnArr[i].TotalQty;
                        $("#lblNOGRN").text(newBadSum)
                    }
                }
            }

            for (var i = 0; i < List.length; i++) {
                if (List[i].PKSerialNumber != "") {
                    if (List[i].PKSerialNumber == Grn) {
                        List[i].OKQty = preGrnArr[i].OKQty;
                        List[i].NgQty = preGrnArr[i].NgQty;                        
                    }
                    if (List[i].GRN == Grn) {
                        List[i].OKQty = preGrnArr[i].OKQty;
                        List[i].NgQty = preGrnArr[i].NgQty;
                    }
                } else {
                    if (List[i].GRN == Grn) {
                        List[i].OKQty = preGrnArr[i].OKQty;
                        List[i].NgQty = preGrnArr[i].NgQty;
                    }
                }
            }

            GrnNew = GrnNew.replace(Grn,"");
        }

        //没有物料条码的，数量管控
        function SaveNoGRN() {
            var goodQty = $("#txtGoodQty").val() * 1;
            var allQty = $("#lblCheckQty").text() * 1;
            if (goodQty > allQty) {
                alert("合格数量不能大于检验单数量!");
                return false;
            }

            var Desc = $("#desc").val();
            if (Desc == "" || Desc == undefined) {
                alert("请输入异常原因");
                return;
            }


            var notgoodQty = (allQty - goodQty);
            if (confirm('确定本次挑选合格数量为' + goodQty + ',不合格数量为' + notgoodQty + '')) {
                var entity = {};
                entity.InspectionId = chooseIQCId;
                entity.GoodQty = goodQty;  //合格数量
                entity.CreateBy = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUserInfo().UserName%>";
                entity.Auditing = Desc;
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.SaveIQCChooseQtyInfo(JSON.stringify(entity));
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return;
                }
                alert("保存成功");
                //parent.window.Refresh();
                $(".close-remark").show();
                $(".btn-save").addClass("btn-disabled").prop("disabled",true);
                $(".close-case").removeClass("btn-disabled").prop("disabled",false);
            }
        }
        //挑选检验
        function Save() {
           
            var isFinish = 0;
            if ($('#checkAll').attr('checked')) {
                isFinish = 1;
            }
            if (List.length == 0) {
                alert("请输入数据后再保存!");
                return;
            }
            var isPass=true;
            if (sIndex == 0) {
                if (!confirm("当前扫描良品：" + GrnNew+"其它未扫的系统自动判定为不良品。")) {
                    isPass=false;
                }
            } else if (sIndex == 1) {
                if (!confirm("当前扫描不良品：" + GrnNew + "其它未扫的系统自动判定为良品。")) {
                    isPass = false;
                }
            }
            if (!isPass) {
                return false;
            }
            
            for (var i = 0; i < List.length; i++) {
                if (sIndex == 0) {
                    if (GrnNew.indexOf(List[i].GRN) > -1) {
                        List[i].isOk = 1;//良品
                        //List[i].OKQty = List[i].TotalQty;
                        //List[i].NgQty = 0;
                    } else {//未扫
                        List[i].isOk = 0;//不良品
                        List[i].OKQty = 0;
                        List[i].NgQty = List[i].TotalQty;
                        //变更界面List
                        $("#tbGrnInfo tr:gt(0) td").each(function () {
                            if ($(this).text() == List[i].GRN) {
                                $(this).parent().find("td:eq(4)").text(0);
                                $(this).parent().find("td:eq(5)").text(List[i].TotalQty);
                                $(this).parent().prependTo($('#tbGrnInfo tbody'));
                                $(this).parent().find("td:eq(6) input").val("").attr("disabled", false);
                            }
                        });
                    }
                } else if (sIndex == 1) {
                    if (GrnNew.indexOf(List[i].GRN) > -1) {
                        List[i].isOk = 0;//不良品
                        //List[i].OKQty =0;
                        //List[i].NgQty = List[i].TotalQty;
                    } else {//未扫
                        List[i].isOk = 1;//良品
                        List[i].OKQty = List[i].TotalQty;
                        List[i].NgQty = 0;

                        $("#tbGrnInfo tr:gt(0) td").each(function () {
                            if ($(this).text() == List[i].GRN) {
                                $(this).parent().find("td:eq(4)").text(List[i].TotalQty);
                                $(this).parent().find("td:eq(5)").text(0);
                                $(this).parent().prependTo($('#tbGrnInfo tbody'))

                                $(this).parent().find("td:eq(6) input").val("").attr("disabled", "disabled");
                            }
                        });
                    }
                }
            }            

            var Desc = $("#<%=this.desc.ClientID %>").val();
            if (Desc == "" || Desc==undefined) {
                alert("请输入异常原因");
                return;
            }

            //BuildTable(List);
            $('#ddlScanningMode').prop("disabled", "disabled");

            var entity = {};
            entity.InspectionId = chooseIQCId;
            entity.isFinish = isFinish; //是否挑选完毕
            entity.CreateBy = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
            entity.tbDtl = JSON.stringify(List);
            entity.DealRemark = $("#txtDealRemark").val();
            entity.Auditing = Desc;
            
            //判断存在以否
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.SaveIQCFormAttendGRN(JSON.stringify(entity));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return;
            }
            IsChooseOver = 1;
            alert("保存成功");
            //parent.window.Refresh();
            $(".close-remark").show();
            $(".btn-save").addClass("btn-disabled").prop("disabled",true);
            $(".close-case").removeClass("btn-disabled").prop("disabled",false);
        }

        //结案
        function CloseCase(){
            var entity = {};
            entity.InspectionId = chooseIQCId;
            entity.DealRemark = $.trim($("#txtDealRemark").val());
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.RMBCloseCase(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return;
            }
            alert("结案成功");
            parent.window.Refresh();
        }
    </script>
</asp:Content>
