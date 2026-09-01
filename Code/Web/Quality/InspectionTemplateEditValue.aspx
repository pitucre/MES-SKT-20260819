<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/EditMaster.master"
    CodeBehind="InspectionTemplateEditValue.aspx.cs" Inherits="SKT.LeanMES.Web.Quality.InspectionTemplateEditValue" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label4">判断方式
            </td>
            <td class="Field4" id="selectType" colspan="3">
                <asp:DropDownList runat="server" ID="sltType" ClientIDMode="Static" >
                    <asp:ListItem Value="1">常规范围</asp:ListItem>
                    <asp:ListItem Value="2">散列值</asp:ListItem>
                    <asp:ListItem Value="3" Selected="True">范围</asp:ListItem>
                    <%--<asp:ListItem Value="4">比例值</asp:ListItem>--%>
                </asp:DropDownList>
            </td>
        </tr>
        <tr id="one" style="display: none">
            <td class="Label4">输入值<em>*</em>
            </td>
            <td class="Field4" id="txtvalueone" colspan="3">
                <select id="countNumber">
                    <option value="1">==</option>
                    <option value="2">></option>
                    <option value="3">>=</option>
                    <option value="4"><</option>
                    <option value="5"><=</option>
                </select>
                <asp:TextBox ID="TextBox2" MaxLength="100" runat="server" CssClass="TextBox" 
                    onkeyup="this.value=this.value.replace(/[^-?\d.]/g,'')" onafterpaste="this.value=this.value.replace(/[^-?\d.]/g,'')" >
                     </asp:TextBox>
                <strong id="remark"></strong>
            </td>
        </tr>
        <tr id="two" style="display: none">
            <td class="Label4">输入值<em>*</em>
            </td>
            <td class="Field4" id="txtvaluetwo" colspan="3">
                <asp:TextBox ID="TextBox1" MaxLength="100" runat="server" CssClass="TextBox" ></asp:TextBox>
                <strong id="remark"></strong>
            </td>
        </tr>
        <tr name="three">
            <td class="Label4">标准值<em>*</em>
            </td>
            <td class="Field4" id="txtStandard">
                <asp:TextBox ID="TextBox5" MaxLength="100" runat="server" CssClass="TextBox"  Width="80px"
                    onkeyup="this.value=this.value.replace(/[^-?\d.]/g,'')" onafterpaste="this.value=this.value.replace(/[^-?\d.]/g,'')">
                    </asp:TextBox>
            </td>
             <td class="Label4">单位
            </td>
            <td class="Field4">
                <asp:TextBox ID="txtUnit1" runat="server" Width="40px" CssClass="TextBox" Enabled="false"></asp:TextBox><input
                        type="button" id="btnSelectUnit" class="ButtonBox" value="..." title="选择单位"
                        onclick="selectUnit(1);" /><input id="hdnUnit1"  runat="server"  type="hidden" />
            </td>
        </tr>
        <tr name="three">
            <td class="Label4">公差<em>*</em>
            </td>
            <td class="Field4" id="txtvaluethree">
                <asp:TextBox ID="TextBox3" MaxLength="100" runat="server" CssClass="TextBox"  Width="40px" placeholder="上限"
                    onkeyup="this.value=this.value.replace(/[^-?\d.]/g,'')" onafterpaste="this.value=this.value.replace(/[^-?\d.]/g,'')">
                    </asp:TextBox>
                ~
                    <asp:TextBox ID="TextBox4" MaxLength="20" runat="server" CssClass="TextBox" Width="40px" placeholder="下限"
                        onkeyup="this.value=this.value.replace(/[^-?\d.]/g,'')" onafterpaste="this.value=this.value.replace(/[^-?\d.]/g,'')">
                        </asp:TextBox>
                <strong id="remark"></strong>
            </td>
             <td class="Label4">单位
            </td>
            <td class="Field4">
                <asp:TextBox ID="txtUnit2" runat="server" CssClass="TextBox" Enabled="false" Width="40px"></asp:TextBox><input
                        type="button" id="btnSelectUnit" class="ButtonBox" value="..." title="选择单位"
                        onclick="selectUnit(2);" /><input id="hdnUnit2" runat="server" type="hidden" />
            </td>
        </tr>
        <tr id="four" style="display: none">
            <td class="Label4">输入值<em>*</em>
            </td>
            <td class="Field4" id="txtvaluefour" >
                <asp:TextBox ID="TextBox6" MaxLength="100" runat="server" CssClass="TextBox" ></asp:TextBox>
                <strong id="remark"></strong>
            </td>
            <td class="Label4">公差<em>*</em>
            </td>
            <td class="Field4" id="txtvaluethree">
                <asp:TextBox ID="TextBox7" MaxLength="100" runat="server" CssClass="TextBox"  Width="40px" placeholder="上限"
                    onkeyup="this.value=this.value.replace(/[^-?\d.]/g,'')" onafterpaste="this.value=this.value.replace(/[^-?\d.]/g,'')">
                    </asp:TextBox>
                ~
                    <asp:TextBox ID="TextBox8" MaxLength="20" runat="server" CssClass="TextBox" Width="40px" placeholder="下限"
                        onkeyup="this.value=this.value.replace(/[^-?\d.]/g,'')" onafterpaste="this.value=this.value.replace(/[^-?\d.]/g,'')">
                        </asp:TextBox>
                <strong id="remark"></strong>
            </td>
        </tr>
        <tr>
            <td class="Label4">显示
            </td>
            <td class="Field4" colspan="3">
                <strong id="txtone">[</strong><strong id="txttwo"></strong><strong id="txtthree">]</strong>
            </td>
        </tr>
        <tr>
           
        </tr>
<%--        <tr>
            <td colspan="2" style="text-align:center">
                <input type="button" value="确认" onclick="Save()" style="min-width:80px" />
            </td>
        </tr>--%>
        <%--        <tr>
            <td class="Label2">示例
            </td>
            <td class="Field1">
                <strong id="remark">请按格式输入：</strong>
            </td>
        </tr>--%>
    </table>
    <input type="hidden" id="hdnValue" runat="server" />
    <input type="hidden" id="hdnTransfer" runat="server" value="1"/>
    <script type="text/javascript" src="../Content/js/jquery-3.1.0.min.js"></script>
    <script type="text/javascript">        
        var InputValue = '';
        (function ($) {
            $.getUrlParam = function (name) {
                var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
                var r = window.location.search.substr(1).match(reg);
                if (r != null) return unescape(r[2]); return null;
            }

            InputValue = $("#<%= hdnValue.ClientID %>").val();
            if (InputValue != "") {
                if (InputValue.indexOf("[") != -1) {
                    $("tr[name=three]").css("display", "");
                    $("#one,#two").css("display", "none");

                    var InspectionMethodValue = InputValue.substring(1, InputValue.length - 1);
                    $("#txttwo").text(InspectionMethodValue);

                    var standardValue = InspectionMethodValue.substring(0, InspectionMethodValue.indexOf("[")); //标准值
                    $("#ContentPlaceHolder1_EditContent_TextBox5").val(standardValue);
                    var arr = InspectionMethodValue.substring(InspectionMethodValue.indexOf("[") + 1, InspectionMethodValue.indexOf("]")).replace('[', '').replace(']', '').split('~');


                    $("#ContentPlaceHolder1_EditContent_TextBox3").val(multiple(parseFloat(arr[0]), parseFloat($("#<%= hdnTransfer.ClientID%>").val())));//上限
                    $("#ContentPlaceHolder1_EditContent_TextBox4").val(multiple(parseFloat(arr[1]), parseFloat($("#<%= hdnTransfer.ClientID%>").val())));//下限
                }
                else if (InputValue.indexOf("(") != -1) {
                    $("#two").css("display", "");
                    $("#one,tr[name=three]").css("display", "none");
                    $("#<%=sltType.ClientID %>").val(2);
                    $("#ContentPlaceHolder1_EditContent_TextBox1").val(InputValue.replace("(", "").replace(")", ""));


                    $("#txtone").text("(");
                    $("#txttwo").text(InputValue.replace("(", "").replace(")", ""));
                    $("#txtthree").text(")");
                } else if (InputValue.indexOf("{") != -1) {
                    $("#four").css("display", "");
                    $("#one,tr[name=three],#two").css("display", "none");
                    $("#<%=sltType.ClientID %>").val(4);
                    var InputValueArr = InputValue.replace("{", "").replace("}", "").split('|');
                    $("#ContentPlaceHolder1_EditContent_TextBox6").val(InputValueArr[0]);

                    $("#txtone").text("{");
                    $("#txttwo").text(InputValue.replace("{", "").replace("}", ""));
                    $("#txtthree").text("}");
                    if (InputValueArr[1] != undefined) {
                        var InputValueArrUd = InputValueArr[1].split('~');
                        $("#ContentPlaceHolder1_EditContent_TextBox7").val(InputValueArrUd[0]);//上限
                        $("#ContentPlaceHolder1_EditContent_TextBox8").val(InputValueArrUd[1]);//下限
                    }

                }
                else {
                    $("#one").css("display", "");
                    $("#two,tr[name=three]").css("display", "none");
                    $("#<%=sltType.ClientID %>").val(1);

                    for (i = 0; i < $("#countNumber option").length; i++) {
                        if (InputValue.indexOf($.trim($("#countNumber option")[i].innerText)) != -1) {
                            $("#countNumber option:eq(" + i + ")").attr("selected", "selected");
                            var Qty = InputValue.replace($.trim($("#countNumber option")[i].innerText), "");

                            $("#ContentPlaceHolder1_EditContent_TextBox2").val(Qty);
                            $("#txttwo").text(Qty);
                            $("#txtone").text($.trim($("#countNumber option")[i].innerText));
                            $("#txtthree").text("");
                            break;;
                        }
                    }
                }
            }

        })(jQuery);

        Id = $.getUrlParam('Id');

        $("#selectType").change(function () {
            $("#TextBox2").val("");
            $("#txtone,#txttwo,#txtthree").html("");
            if ($("select").val() == 1) {
                //$("#txtvalue").html("").append("")
                //$("#remark").html("").html("=x、>x、>=x、<x、<=x、±x");
                $("#one").css("display", "");
                $("#txtone").html("==");
                $("#two,tr[name=three],#four").css("display", "none");
            } else if ($("select").val() == 2) {
                $("#txtone").html("(");
                $("#txtthree").html(")");
                //$("#remark").html("").html(" x1,x2,x3,x4");

                $("#two").css("display", "");
                $("#one,tr[name=three],#four").css("display", "none");
            }
            else if ($("select").val() == 3) {
                $("#txtone").html("[");
                $("#txtthree").html("]");
                //$("#remark").html("").html("x,y");

                $("tr[name=three]").css("display", "");
                $("#one,#two,#four").css("display", "none");
            } else if ($("select").val() == 4) {
                $("#txtone").html("{");
                $("#txtthree").html("}");
                //$("#remark").html("").html(" x1,x2,x3,x4");

                $("#four").css("display", "");
                $("#one,tr[name=three],#two").css("display", "none");
            }
        });
        $("#countNumber").change(function () {
            $("#txtone").html($("#countNumber option:selected").html());
        });
        $("#ContentPlaceHolder1_EditContent_TextBox2").on("keyup", function () {
            $("#txttwo").html($("#ContentPlaceHolder1_EditContent_TextBox2").val());
        });
        $("#ContentPlaceHolder1_EditContent_TextBox5").on("keyup", function () {
            $("#txttwo").html(SetShowData());
        });

        $("#ContentPlaceHolder1_EditContent_TextBox1").on("keyup", function () {
            $("#txttwo").html($("#ContentPlaceHolder1_EditContent_TextBox1").val());
        });
        $("#ContentPlaceHolder1_EditContent_TextBox6").on("keyup", function () {
            $("#txttwo").html(SetShowData4());
        });
        $("#ContentPlaceHolder1_EditContent_TextBox7").on("keyup", function () {
            $("#txttwo").html(SetShowData4());
        });
        $("#ContentPlaceHolder1_EditContent_TextBox8").on("keyup", function () {
            $("#txttwo").html(SetShowData4());
        });
        $("#ContentPlaceHolder1_EditContent_TextBox3").on("blur", function () {
            if (parseFloat($("#ContentPlaceHolder1_EditContent_TextBox3").val().toString().replace("~", "")) <= parseFloat($("#ContentPlaceHolder1_EditContent_TextBox4").val())) {
                alert("请输入大于 " + $("#ContentPlaceHolder1_EditContent_TextBox4").val() + " 的值");//改成了偏差值，上下限
                $("#ContentPlaceHolder1_EditContent_TextBox3").val("").focus();
                return false;
            }
            $("#txttwo").html(SetShowData());
        });
        //IE change事件无效 替换成blur
        $("#ContentPlaceHolder1_EditContent_TextBox4").on("blur", function () {
            if (parseFloat($("#ContentPlaceHolder1_EditContent_TextBox3").val().toString().replace("~", "")) <= parseFloat($("#ContentPlaceHolder1_EditContent_TextBox4").val())) {
                alert("请输入小于 " + $("#ContentPlaceHolder1_EditContent_TextBox3").val() + " 的值");//改成了偏差值，上下限  
                $("#ContentPlaceHolder1_EditContent_TextBox4").val("").focus();
                return false;
            }
            //if ($("#txttwo").html().toString().indexOf("~") == -1) {
            //    $("#txttwo").html($("#txttwo").html() + "~" + $("#ContentPlaceHolder1_EditContent_TextBox4").val());
            //} else {
            //    var Strarr = $("#txttwo").html().split("~");
            //    //改成了偏差值，上下限; 显示内容：标准值[上限,下限]
            //    //if (parseFloat(Strarr[0]) >= parseFloat(Strarr[1])) {
            //    //    alert("请输入大于 " + Strarr[0] + " 的值");
            //    //    return false;
            //    //}

            //    //$("#txttwo").html($("#txttwo").html().replace(Strarr[1].toString(), $("#ContentPlaceHolder1_EditContent_TextBox4").val()));
            //    //$("#txttwo").html($("#txttwo").html() + "~" + $("#ContentPlaceHolder1_EditContent_TextBox4").val());
            //}
            //if ($("#ContentPlaceHolder1_EditContent_TextBox4").val() == "") {
            //    $("#txttwo").html($("#txttwo").html().toString().replace("~", ""));
            //}
            $("#txttwo").html(SetShowData());
        });

        function SetShowData4() {
            var woShow = "";
            var StandardData4 = $("#<%=TextBox6.ClientID %>").val();
            var TopData4 = $("#<%=TextBox7.ClientID %>").val();
            var DownData4 = $("#<%=TextBox8.ClientID %>").val();
            if (StandardData4 != "") {

                if (StandardData4 != "" && TopData4 != "" && DownData4 != "") {
                    woShow = StandardData4 + "|" + TopData4 + "~" + DownData4 + "";
                }
                else if (TopData4 == "" && DownData4 == "") {
                    $("#<%=TextBox7.ClientID %>").val(0);
                    $("#<%=TextBox8.ClientID %>").val(0);
                    woShow = StandardData4;
                }
            }
            return woShow;
        }
        function SetShowData() {
            var woShow = "";
            var StandardData = $("#<%=TextBox5.ClientID %>").val();
            var StandardUnit = $("#<%= hdnUnit1.ClientID %>").val();

            var TopData = $("#<%=TextBox3.ClientID %>").val();
            var DownData = $("#<%=TextBox4.ClientID %>").val();
            var OffsetUnit = $("#<%= hdnUnit2.ClientID %>").val();

            var TransforData = 1.00;

            if (StandardData != "") {
                if (StandardUnit == "" || OffsetUnit == "" || StandardUnit == "-1" || OffsetUnit == "-1") {
                    woShow = StandardData + "[" + TopData + "~" + DownData + "]";
                }
                else if (TopData != "" && DownData != "") {
                    if (StandardUnit != OffsetUnit) {
                        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxDictionaryData.GetUnitTransforByUnitIDAndTransforID(StandardUnit, OffsetUnit);
                        if (ajax.error != null) {
                            alert(ajax.error.Message);
                            //$("#<%= hdnUnit1.ClientID %>").val("");
                            $("#<%= hdnUnit2.ClientID %>").val("");
                            //$("#<%=txtUnit1.ClientID %>").val("");
                            $("#<%=txtUnit2.ClientID %>").val("");
                            return StandardData + "[" + TopData + "~" + DownData + "]";
                        }
                        var entity = ajax.value;
                        TransforData = parseFloat(entity.TransforData);
                        if (TransforData < 1) {
                            alert("偏差的单位不能大于标准值的单位");
                            $("#<%= hdnUnit1.ClientID %>").val("");
                            $("#<%= hdnUnit2.ClientID %>").val("");
                            $("#<%=txtUnit1.ClientID %>").val("");
                            $("#<%=txtUnit2.ClientID %>").val("");
                            return StandardData + "[" + TopData + "~" + DownData + "]";
                        }
                    	//TransforData = TransforData.toString().indexOf(".") > 0 ? TransforData.toString() : TransforData.toFixed(1).toString();//用于JS精度
                    }
                    else {
                        TransforData = "1.0";
                    }

                	woShow = StandardData + "[" + UomSum(TopData, TransforData) + "~" + UomSum(DownData, TransforData) + "]";
                }

                //标准值加上限值不能小于0
                //if (parseFloat(StandardData) + (parseFloat(TopData) / TransforData) < 0) {
                //    woShow = "";
                //    alert("标准值加上限值不能小于0");
                //    $("#<%=TextBox3.ClientID %>").val("");
                //}
            }
            return woShow;
        }

    	function UomSum(divider, dividend) {
    		var ajax = SKT.LeanMES.Web.AjaxServices.AjaxDictionaryData.Divider(parseFloat(divider), parseFloat(dividend));
    		if (ajax.error != null) {
    			alert(ajax.error.Message);
    			return;
    		}
    		return ajax.value;
    	}
        //$("#ContentPlaceHolder1_EditContent_TextBox2").change(function () {
        //    $("#txttwo").html($("#ContentPlaceHolder1_EditContent_TextBox2").val());
        //});

        var chooseFlag = -1;
        function selectUnit(flag) {
            chooseFlag = flag;
            var searchCondition = " DicProperty ='Unit' ";
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=3&PageCondition=" + searchCondition + "&Multiple=false&rnd=" + Math.random(), width: 600, height: 350 });
        }

        function getChooseValue(list) {
            if (chooseFlag == 1) {;
                $("#<%=txtUnit1.ClientID %>").val(list[0][1]);
                $("#<%= hdnUnit1.ClientID %>").val(list[0][0]);
            }
            else if(chooseFlag == 2) {;
                $("#<%=txtUnit2.ClientID %>").val(list[0][1]);
                $("#<%= hdnUnit2.ClientID %>").val(list[0][0]);
            }
            $("#txttwo").html(SetShowData());
            chooseFlag = -1;
        }

        var Save = function () {
            var type = $("#sltType").val();
            if (type == 1 && $("#ContentPlaceHolder1_EditContent_TextBox2").val() == "") {
                $("#ContentPlaceHolder1_EditContent_TextBox2").focus();
                alert("请输入标准值！");
                return false;
            }
            else if (type == 2 && $("#ContentPlaceHolder1_EditContent_TextBox1").val() == "") {
                $("#ContentPlaceHolder1_EditContent_TextBox1").focus();
                alert("请输入标准值！");
                return false;
            }
            else if (type == 3) {
                if ($("#ContentPlaceHolder1_EditContent_TextBox5").val().trim() == "") {
                    $("#ContentPlaceHolder1_EditContent_TextBox5").val("").focus();
                    alert("请输入标准值！");
                    return false;
                }
                if ($("#ContentPlaceHolder1_EditContent_TextBox3").val().trim() == "") {
                    $("#ContentPlaceHolder1_EditContent_TextBox3").val("").focus();
                    alert("请输入上限公差值！");
                    return false;
                }
                if ($("#ContentPlaceHolder1_EditContent_TextBox4").val().trim() == "") {
                    $("#ContentPlaceHolder1_EditContent_TextBox4").val("").focus();
                    alert("请输入下限标准值！");
                    return false;
                }
            }
            var Value = $("#txtone").html() + $("#txttwo").html() + $("#txtthree").html();
            var StandardUnit = $("#<%=txtUnit1.ClientID %>").val();
            var OffsetUnit = $("#<%=txtUnit2.ClientID %>").val();
            parent.GetValue(Value, Id, StandardUnit, OffsetUnit);
        }
    </script>
</asp:Content>
