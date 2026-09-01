<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="MaterialStorageGRNInput.aspx.cs" Inherits="SKT.LeanMES.Web.Material.MaterialStorageGRNInput" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">全部入库
            </td>
            <td class="Field1">
                <input type="checkbox" id="checkAll" />
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <span id="spanWarehouse">库位</span> <span>条码</span>
            </td>
            <td class="Field1">
                <input id="txtWarehouse" type="text" class="TextBox" />
            </td>
        </tr>
        <tr>
            <td class="Label1">GRN/包装箱
            </td>
            <td class="Field1">
                <input id="txtGRN" type="text" class="TextBox" />
            </td>
        </tr>
        <tr>
            <td class="Label1">IQC/采购单
            </td>
            <td class="Field1">
                <span id="orderno"></span><span id="split-char"></span><span id="po-code"></span>
            </td>
        </tr>
    </table>
    <div style="width: 100%; color: Red; text-align: center" id="Message">
    </div>
    <div class="clear5">
    </div>
    <div style="width: 100%;"><span>待入库物料列表</span></div>
    <table class="ListTable" cellspacing="0" cellpadding="4" style="border-width: 0px; width: 100%; overflow: auto; border-collapse: collapse;" id="instocktable">
        <thead>
            <tr class="ListTableHeader">
                <th scope="col" align="center">物料列表</th>
                <th scope="col" align="center">物料名称</th>
                <th scope="col" align="center">入库量</th>
            </tr>
        </thead>
        <tbody>
        </tbody>
    </table>

    <div style="width: 100%;"><span>待入库GRN列表</span></div>
    <table class="ListTable" cellspacing="0" cellpadding="4" style="border-width: 0px; width: 100%; overflow: auto; border-collapse: collapse;" id="Table1">
        <thead>
            <tr class="ListTableHeader">
                <th scope="col" align="center">扫描GRN</th>
                <th scope="col" align="center">数量</th>
                <th scope="col" align="center">操作</th>
            </tr>
        </thead>
        <tbody>
        </tbody>
    </table>
    <script type="text/javascript" src="../Content/js/jquery-1.9.1.js"></script>
    <script type="text/javascript">
        var InsId = '<%=Request.QueryString["ID"] %>';
        var tab = document.getElementById("tbPackLevel");
        var isAll = 0; //是否勾选全部入库
        var isputon = 1;//是否勾选入库上架
        var StorageQty = 0; //入库总数量
        var entity = []; //记录数据 IQC单信息
        var List;//IQC单下 GRN信息
        var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
        $(document).ready(function () {
            //$('#checkAll').attr("checked", "checked");
            $("#txtWarehouse").focus();
            isAll = $("#checkAll").is(":checked") ? 1 : 0;


            $("#checkAll").on("change", function () {
                var ischeckall = $(this).prop("checked");
                if (confirm("是否切换入库模式，会清除所有数据")) {
                    $("#txtWarehouse").val("");
                    $("#txtGRN").val("");
                    $("#orderno").text("");
                    $("#split-char").text("");
                    $("#po-code").text("");
                    $("#instocktable tbody").html("");
                    $("#Table1 tbody").html("");
                    List = [];
                    StorageQty = 0;
                    if (ischeckall) {
                        isAll = 1;
                    } else {
                        isAll = 0;
                    }
                } else {
                    if (ischeckall) {
                        $(this).prop("checked", false);
                    } else {
                        $(this).prop("checked", true);
                    }
                }
                $("#txtWarehouse").focus();
            });





            $("#txtWarehouse").keydown(function () {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    if (changeBarCode()) {
                        $("#txtGRN").focus();
                    }
                }
            });

            /*扫描条码*/
            $("#txtGRN").keydown(function () {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    $("#txtGRN").select();
                    changeGRN();
                }
            });
            //getIQCStorageQty(); //获取    IQC检验单号

        });

        $(function () {
            //删除
            $("#Table1 tbody").on("click", ".delete-item", function () {
                var tr = $(this).closest("tr");
                var grns = tr.attr("grns");//GRN或者包装箱中的GRN
                var iqcNo = tr.attr("iqcNo");
                var itemId = tr.attr("itemId");
                var qty = parseFloat(tr.find("td.qty").attr("qty"));
                var grnArr = grns.split(",");
                $(this).closest("tr").remove();
                //移除集合中的条码
                for (var i = 0; i < List.length; i++) {
                    for (var j = 0; j < List[i].length; j++) {
                        //遍历GRN
                        for (var k = 0; k < grnArr.length; k++) {
                            if (grnArr[k] == List[i][j].GRN) {
                                //删除数组中的元素
                                List[i].splice(j, 1);
                                j--;
                            }
                        }
                    }
                }
                //更新entity数量
                for (var i = 0; i < entity.length; i++) {
                    if (entity[i].InspectionNo == iqcNo) {
                        entity[i].StorageQty = entity[i].StorageQty - qty;
                        $("#instocktable tbody td[id=\"" + itemId + "\"]").siblings().find("#qty").text(entity[i].StorageQty);
                    }
                }
            });
        });

        //验证库位
        function changeBarCode() {
            var wh = $.trim($("#txtWarehouse").val());
            if (isputon) {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.GetBarCode(wh);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                var en = $.parseJSON(ajax.value);
                if (!en.BarCode) {
                    showMsg("库位条码不存在!");
                    $("#txtWarehouse").val("");

                    setTimeout(function () {
                        $("#txtWarehouse").focus();
                    }, 100);

                    return false;
                }
                else {
                    $("#Message").html("库位扫描成功").css("color", "green");
                    $("#txtGRN").focus();
                    return true;
                }
            } else {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.GetWarehouseCode(wh);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                var en = $.parseJSON(ajax.value);
                if (!en.CWhCode) {
                    showMsg("仓库条码不存在!");
                    $("#txtWarehouse").val("");

                    setTimeout(function () {
                        $("#txtWarehouse").focus();
                    }, 100);

                    return false;
                }
                else {
                    $("#Message").html("仓库扫描成功");
                    $("#txtGRN").focus();
                    return true;
                }
            }
        }


        //扫描GRN之后的回车
        function changeGRN() {
            var wh = $.trim($("#txtWarehouse").val());
            if ($.trim(wh) == "") {
                showMsg("库位不可为空!");
                $("#txtWarehouse").focus();
                $("#txtWarehouse").select();
                return false;
            }

            var grn = $.trim($("#txtGRN").val());
            if ($.trim(grn) == "") {
                showMsg("物料条码不可为空!");
                $("#txtGRN").focus();
                $("#txtGRN").select();
                return false;
            }

            //包装判断
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.IsPack(grn);
            if (ajax.value != "" && ajax.value != null) {
                if (!window.confirm("该物料【" + grn + "】已存在包装【" + ajax.value + "】，是否解除包装!")) {
                    return "";
                }
            }
            if (isAll) {
                var data = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.SelectByGRN(grn);
                if (data.error != null) {
                    $("#Message").html(data.error.Message).css("color", "red");
                    $("#txtGRN").val("").focus();
                    return false;
                }
                var htmlstr = "";
                $("#instocktable tbody").html("");
                $("#Message").html("");
                entity1 = $.parseJSON(data.value);
                rowCount = entity1[0].rowCount; //获取总条数
                entity1.shift(); //删除总条数信息(第一条)
                if (entity1.length <= 0) {
                    $("#Message").html("GRN对应单据状态不能进行入库操作");
                    return false;
                }
                //校验货位产品唯一
                if (!verifyProductOnly(isputon, grn, "", wh)) return false;

                var IQCId = entity1[0].InspectionId;
                var IQCNo = entity1[0].InspectionNo;
                var poCode = entity1[0].POCode;
                //$("#orderno").val(IQCNo);
                $("#orderno").text(IQCNo);
                $("#split-char").text("/");
                $("#po-code").text(poCode);

                for (var i = 0; i < entity1.length; i++) {
                    htmlstr += "<tr style='background-color:#7FFF00'><td id='" + entity1[i].ItemId + "'>" + entity1[i].ItemCode + "</td><td>" + entity1[i].ItemName + "</td>"
                        + "<td><span  id='qty'>" + entity1[i].InspectionQty + "</span>/<span>" + entity1[i].InspectionQty + "</sapn> </td>"
                        + "</tr>"
                }
                $("#instocktable tbody").append(htmlstr);
                //$("#instocktable").table("refresh");

                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.GetIQCScanGRNInfo(IQCId, "", 1);
                if (ajax.error != null) {
                    showMsg(ajax.error.Message);
                    $("#txtGRN").val("").focus();
                    return false;
                }
                var en = $.parseJSON(ajax.value);
                List = new Array(1);
                for (var i = 0; i < entity1.length; i++) {
                    List[i] = new Array();
                }
                e = {};
                e.InspectionId = IQCId;
                e.InspectionNo = IQCNo;
                e.CBarCode = $.trim($("#txtWarehouse").val());
                e.StorageQty = 0;
                //每次查询,重新清空赋值
                entity = []
                entity.push(e);

                var hl = "";
                for (var i = 0; i < en.data.length; i++) {
                    var en1 = {};
                    en1.GRN = en.data[i].GRN;
                    en1.StorageQty = en.data[i].StorageQty;
                    en1.BarCode = "";
                    List[0].push(en1);
                    hl += "<tr style='background-color:#7FFF00'><td>" + en.data[i].GRN + "</td><td class=\"qty\" qty=\"" + en.data[i].StorageQty + "\">" + en.data[i].StorageQty + "</td><td></td></tr>";
                }
                $("#Table1 tbody").html(hl);
                $("#txtGRN").val("").focus();

            } else {
                $("#Message").html("");

                var iqcNo = $.trim($("#orderno").text());

                //GRN判断
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.IsGRN(iqcNo, grn, $.trim($("#txtWarehouse").val()), isputon);

                if (ajax.error != null) {
                    $("#Message").html(ajax.error.Message).css("color", "red");
                    if (ajax.error.Message.indexOf(($("#spanWarehouse").text() + "[" + $.trim($("#txtWarehouse").val()) + "]")) >= 0) {
                        $("#txtWarehouse").val("").focus();
                    } else {
                        $("#txtGRN").val("").focus();
                    }

                    // $("#txtGRN").val("").focus();
                    return false;
                }
                var data = ajax.value;
                var mark = true;
                var displayqty = 0;//GRN数量 、包装箱数量

                //校验货位产品唯一
                if (!verifyProductOnly(isputon, grn, "", wh)) return false;


                if (iqcNo == "") {

                    $("#orderno").text(data[0].InspectionNo);
                    $("#split-char").text("/");
                    $("#po-code").text(data[0].POrder);
                    //获取检验单
                    if (!Select(grn)) {
                        return false;
                    }
                }
                else {

                    if (data[0].InspectionNo == $.trim($("#orderno").text())) {

                        //判断条码是否已扫描
                        for (var i = 0; i < List.length; i++) {
                            for (var j = 0; j < List[i].length; j++) {
                                //遍历GRN
                                for (var k = 0; k < data.length; k++) {
                                    if (data[k].GRN == List[i][j].GRN) {
                                        showMsg("该条码" + grn + "已扫描", 0);
                                        $("#txtGRN").val("").focus();
                                        return false;
                                    }
                                }
                            }
                        };
                        //追加订单时，判断订单是否重复
                        var code_index = $.inArray(data[0].POrder, $.trim($("#po-code").text()).split(","));
                        if (code_index == -1) {
                            $("#po-code").text($.trim($("#po-code").text()) + "," + data[0].POrder);
                        }

                    }


                }



                if (!List) {
                    showMsg("未能获取到检验单信息！");
                    return false;
                }



                //判断条码是否已扫描
                for (var i = 0; i < List.length; i++) {
                    for (var j = 0; j < List[i].length; j++) {
                        //遍历GRN
                        for (var k = 0; k < data.length; k++) {
                            if (data[k].GRN == List[i][j].GRN) {
                                showMsg("该条码" + grn + "已扫描", 0);
                                $("#txtGRN").val("").focus();
                                return false;
                            }
                        }
                    }
                }





                var grnArr = [];
                for (var j = 0; j < data.length; j++) {
                    // displayqty = displayqty.add(data[j].StorageQty);
                    displayqty = displayqty + (parseFloat(data[j].StorageQty));
                    for (var i = 0; i < entity.length; i++) {
                        //entity[i].StorageQty = 0;//清零库存 只对扫描过的单据增加库存数
                        if (entity[i].InspectionNo == data[j].InspectionNo) {
                            entity[i].CBarCode = $.trim($("#txtWarehouse").val());
                            //entity[i].StorageQty = entity[i].StorageQty.add(parseFloat(data[j].StorageQty));
                            entity[i].StorageQty = entity[i].StorageQty+(parseFloat(data[j].StorageQty));
                            //entity[i].StorageQty = entity[i].StorageQty.add(parseFloat(data[j].StorageQty));
                            var en = {};
                            en.GRN = data[j].GRN;
                            en.StorageQty = data[j].StorageQty;
                            en.BarCode = "";
                            List[i].push(en);
                            mark = false;
                            grnArr.push(data[j].GRN);

                        }
                    }
                }
                if (mark) {
                    $("#Message").html("GRN不属于该单据！").css("color", "red");
                    $("#txtGRN").val("").focus();
                    return false;
                }
                //页面显示，根据物料
                var $tr = $('#' + ajax.value[0].ItemId).parent();
                var a = parseFloat($tr.find("span").html());//入库数量
                var b = parseFloat(displayqty);//GRN数量
                $tr.find("span:eq(0)").html(a + b); //入库数量 
                $("#instocktable tbody tr").removeAttr("style");//移除高亮
                $tr.fadeOut(300).fadeIn(300);//闪动一次
                $("#instocktable").prepend($tr);
                $tr.css("background-color", "#7FFF00");
                //$("#instocktable").table("refresh");

                $(document).scrollTop(200);
                //显示grn
                TableBind(grn, displayqty, data[0].InspectionNo, data[0].ItemId, grnArr);
                $("#txtGRN").val("").focus();
            }
        }

        function TableBind(grn, qty, iqcNo, itemId, grnArr) {
            $("#Table1 tbody tr").removeAttr("style");//移除高亮

            var htmlstr = "<tr style='background-color:#7FFF00' cbarcode=\"" + $.trim($("#txtWarehouse").val()) + "\" grns=\"" + grnArr.join(",") + "\" iqcNo=\"" + iqcNo + "\" itemId=\"" + itemId + "\">";
            htmlstr += "<td id='" + $("#material").val() + "'>" + grn + "</td><td class=\"qty\" qty=\"" + qty + "\">" + qty + "</td><td><a href=\"#\" class=\"delete-item\">删除</a></td>";

            if ($.trim($("#Table1 tbody").html()) == "") {
                $("#Table1 tbody").append(htmlstr);
            } else {
                $("#Table1 tbody tr:eq(0)").before(htmlstr);//累加在第一条
            }
            //$("#Table1").table("refresh");
        }

        function Select(obj) {
            $("#Message").html('');
            $("#instocktable tr:gt(0)").remove();
            var data = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.SelectByGRN(obj); //SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.Select($.trim($("#orderno").text()), obj);

            if (data.error != null) {
                $("#Message").html(data.error.Message).css("color", "red");
                return false;
            }
            entity = $.parseJSON(data.value);
            rowCount = entity[0].rowCount; //获取总条数
            entity.shift(); //删除总条数信息(第一条)

            var htmlstr = "<tr>";
            if (entity.length <= 0) {
                $("#Message").html("单据不包含可入库信息").css("color", "red");
                $("#instocktable tr:gt(0)").remove();
                $("#instocktable tbody").append('<tr class="ListTableOddRow" ><td colspan="10" style="text-align: center;"><font color="red">暂无数据</font></td></tr>');
                //$("#instocktable").table("refresh");
            }
            entity1 = []; //显示用实体
            var flag = -1;
            var item;
            //合并同物料的信息
            $.each(entity, function (i, j) {
                if (item == j.ItemId) {
                    entity1[flag].InspectionQty += j.InspectionQty;
                    entity1[flag].ReQty += j.ReQty;
                    entity1[flag].StorageQty += j.StorageQty;
                }
                else {
                    entity1.push(j);
                    flag++
                }
                item = j.ItemId;
            });
            for (var i = 0; i < entity1.length; i++) {
                htmlstr += "<td id='" + entity1[i].ItemId + "'>" + entity1[i].ItemCode + "</td>"
                    + "<td>" + entity1[i].ItemName + "</td>"
                    //+ "<td>" + entity1[i].InspectionQty + "</td>"//订单数
                    //+ "<td><span  id='qty'>" + entity1[i].StorageQty + "</span>/<span>" + entity1[i].ReQty + "</sapn> </td>"
                    + "<td><span  id='qty'>" + entity1[i].StorageQty + "</span>/<span>" + entity1[i].InspectionQty + "</sapn> </td>"
                    //+ "<td name='stid'></td></tr>"
                    + "</tr>"
            }
            $("#instocktable tbody").append(htmlstr);
            //$("#instocktable").table("refresh");
            ////checkbox 单选
            //$("input[name='favcolor']").on("click", function () {
            //    $("input[name='favcolor']").prop("checked", false);
            //    $(this).prop("checked", "checked").checkboxradio("refresh");
            //});

            //清除入库信息

            $("#txtGRN").val("");
            $("#Table1 tbody").html("");

            List = new Array();
            for (var i = 0; i < entity.length; i++) {
                List[i] = new Array();
            }
            StorageQty = 0;
            return true;

        }




        //var saveData = null;
        function Save() {
            if (!window.confirm("确定保存？")) {
                return "";
            }
            if ($.trim($("#orderno").text()) == "") {
                $("#Message").html("未获取到IQC检验单信息").css("color", "red");
                return false;
            }
            if ($.trim($("#txtWarehouse").val()) == "") {
                $("#Message").html("请扫描库位").css("color", "red");
                return false;
            }
            //if ($("#slider2").val() != 'on') {
            if (!$("#checkputon").prop("checked")) {
                if ($.trim($("#Table1 tbody").html()) == "") {
                    $("#Message").html("请扫描GRN！").css("color", "red");
                    return false;
                }
            }

            for (var l = 0; l < List.length; l++) {
                var CBarCode = entity[l].CBarCode = null ? "" : entity[l].CBarCode;
                for (var s = 0; s < List[l].length; s++) {
                    List[l][s].BarCode = CBarCode;
                }
            }


            for (var j = 0; j < entity.length; j++) {
                var saveentity = {};
                var Sum = 0;//IQC检验单扫描数量（GRN累加得出） 
                for (var q = 0; q < List[j].length; q++) {
                    Sum = Sum + (parseFloat(List[j][q].StorageQty));
                }
                saveentity.InspectionId = entity[j].InspectionId;
                saveentity.StorageQty = Sum;
                saveentity.tbDtl = JSON.stringify(List[j]);
                saveentity.PutOnShelf = isputon;
                saveentity.CreateBy = userName;
                //如果这个IQC单没有GRN不进行入库操作
                if (saveentity.tbDtl == "" || saveentity.tbDtl == null) {
                    continue;
                }

                //校验货位产品唯一
                if (!verifyProductOnly(isputon, List[j][0].GRN, "", entity[j].CBarCode)) return false;

                //var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.SaveIQCGRNStorage(JSON.stringify(saveentity));
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.PDASaveIQCGRNStorage(saveentity);
                if (ajax.error != null) {
                    showMsg(ajax.error.Message);
                } else {
                    var erpNo = ajax.value;
                    if (erpNo) {
                        erpNo = "ERP入库单号：" + erpNo;
                    }
                    alert("保存成功");
                    $("#txtWarehouse").val("").focus();
                    $("#txtGRN").val("");
                    $("#Table1 tbody").html("");
                    $("#instocktable tbody").html("");
                    $("#orderno").text("");
                    $("#split-char").text("");
                    $("#po-code").text("");
                    List = [];
                    entity = [];
                    parent.window.refresh();
                }

            }


        }




        //全部入库选择框改变事件
        function onCheck() {
            if ($("#checkAll").is(':checked')) {
                if ($.trim($("#txtWarehouse").val()) == "") {
                    showMsg("库位不可为空!");
                    $("#txtWarehouse").focus();
                    $('#checkAll').removeAttr("checked", "checked");
                    return false;
                }
                if (changeBarCode()) {
                    isAll = 1;
                    //2017-10-20 胡芳 扫描两个物料GRN之后,再点击全部入库，已扫描的GRN被重复添加  
                    //$("#tbPackLevel  tr:not(:first)").each(function (index) {
                    //            tab.deleteRow(1);
                    //        });  

                    var ListTableHeaderObj = $("#tbPackLevel").find("tr");
                    for (var i = 0; i < ListTableHeaderObj.length; i++) {
                        var className = $(ListTableHeaderObj[i]).attr("class");
                        if ("ListTableHeader" != className) {
                            $(ListTableHeaderObj[i]).empty().remove();
                        }
                    }
                    List = [];
                    getDtl();
                }
                else {
                    $('#checkAll').removeAttr("checked", "checked");
                    return false;
                }
            }
            else {
                isAll = 0;
                $("#tbPackLevel  tr:not(:first)").each(function (index) {
                    tab.deleteRow(1);
                });

                List = [];
                StorageQty = 0;
            }

        }

        //获取    IQC检验单号
        function getIQCStorageQty() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.GetIQCStorageQty(InsId);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return;
            }

            var en = $.parseJSON(ajax.value);
            if (en.data[0] == null) {
                alert("该检验单无GRN可入库");
                parent.window.refresh();
            }
            if (en.data[0] && en.data[0].InspectionNo != "") {
              <%--  $("#<%=this.txtBatchNo.ClientID %>").text(en.data[0].InspectionNo);--%>
                $("#lblPrepInStock").text(en.data[0].QualifiedQty);
            }
        }


        //新增按钮
        function GRNEnter() {
            changeGRN();
        }

        function showMsg(obj) {
            $("#Message").html(obj.toString());
            $("#Message").css("color", "red");
        }

        //清除已扫描的GRN
        function clearGRN() {
            if (!window.confirm("确定清除？")) {
                return "";
            }
            $("#txtWarehouse").val("").focus();
            $("#txtGRN").val("");
            $("#Table1 tbody").html("");
            $("#instocktable tbody").html("");
            $("#orderno").text("");
            $("#split-char").text("");
            $("#po-code").text("");
            List = [];
            entity = [];
            $("#Message").html("清除成功");
        }

        function clearGRN2() {
            $("#tbPackLevel  tr:not(:first)").each(function (index) {
                tab.deleteRow(1);
            });
            GRNStrWithBarCode = "";
            List = [];
            StorageQty = 0;
            $("#Message").html("清除成功");
        }
        //校验货位产品唯一
        function verifyProductOnly(isputon, grn, itemCode, cBarCode) {
            if (isputon == 1) {
                var result = isItemCanPlacedInWarehouseLocation(grn, itemCode, cBarCode);
                if (result == -1) {
                    return false;
                }
                if (result == 0) {
                    showMsg("当前库位不支持存放多种产品，请扫描其他库位！");
                    setTimeout(function () {
                        $("#txtWarehouse").val("").focus();
                    }, 100);
                    return false;
                }
            }
            return true;
        }

        //判断产品是否能放入当前库位
        function isItemCanPlacedInWarehouseLocation(grn, itemCode, cBarCode) {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxWarehouse.IsItemCanPlacedInWarehouseLocation(grn, itemCode, cBarCode);
            if (ajax.error != null) {
                showMsg(ajax.error.Message, 0);
                return -1;
            }
            return ajax.value ? 1 : 0;
        }
    </script>
</asp:Content>
