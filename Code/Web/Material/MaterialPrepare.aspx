<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="true"
    CodeBehind="MaterialPrepare.aspx.cs" Inherits="SKT.LeanMES.Web.Material.MaterialPrepare" %>

<asp:Content ID="Content2" ContentPlaceHolderID="viewcontent" runat="server">
    <style>
        .focuMrl {
            /*background: #80fff9 !important;*/
            background: yellow;
        }

        .bg-green {
            background: green;
        }
    </style>


    <table width="100%" class="EditeContentTable">
        <%--        <tr class="Label1" style="height: 30px;">
            <td align="left">
                <span class="information16"></span>请选择要备料的领料申请单
            </td>
            <td align="right">
                <a href="#" onclick="openSplitMaterial();" style="margin-right: 10px;">分料截料</a>
            </td>
        </tr>--%>
        <tr>
            <td class="infoTips" colspan="4">
                <%=Resources.Messages.WithAsteriskIsRequired %>
            </td>
        </tr>
        <tr>
            <td class="Label1">领料单<em>*</em>
            </td>
            <td class="Field1">
                <input type="text" value="" id="txtReuestOrder" class="TextBox" style="width: 250px; height: 25px; font-size: 16px; font-weight: bold; text-transform: uppercase;" /><input type="button" id="Button1" class="ButtonBox" value="..." style="height: 27px; font-weight: bold; text-transform: uppercase;"
                    />
            </td>
        </tr>
        <tr>
            <td class="Label1">工单号
            </td>
            <td class="Field1">
                <label id="woNo">
                </label>
            </td>
        </tr>
    </table>
     <div style="text-align: center; margin-top: 1px;" class="Tips" id="showGrn">
      </div>
    <div class="clear5">
    </div>
    <div style="text-align: center;" class="Tips" id="msg">
    </div>
    <div style="width: 49%; overflow: auto; float: left" id="leftApplication">
        <table class="ListTable" width="100%" id="tblRecHistory">
            <tr class="ListTableHeader">
                <th>序号
                </th>
                <th>物料名称
                </th>
                <th>领料申请数量
                </th>
                <th>已备数量
                </th>
                <%--                <th>
                    是否有条码
                </th>--%>
                <th>先进先出推荐
                </th>
                <th>操作
                </th>
            </tr>
            <tr id="trNewInfo" class="ListTableOddRow">
                <td colspan="7" style="text-align: center;"><span>暂无数据</span>
                </td>
            </tr>
        </table>
    </div>
    <div style="width: 49%; float: right" id="rightRequest">
        <table style="width: 100%;" class="EditeContentTable">
            <tr>
                <td colspan="2">
                    <div class="ListTableTitle" style="border: 0px;">
                        <span>备料信息</span>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="Label1">备料到
                </td>
                <td class="Field1">
                    <select id="selLocation" style="width: 100px;">
                        <option value="1">线边仓</option>
                        <option value="2" selected="selected">产线</option>
                    </select>
                </td>
            </tr>
            <tr id="grntr">
                <td class="Label1">扫描GRN条码
                </td>
                <td class="Field1">
                    <input type="text" id="txtGRN" class="TextBox" style="width: 70%; font-size: 16px; font-weight: bold; text-transform: uppercase;" /><input type="button" id="scanSN" class="ButtonBox" value="..." style="font-weight: bold; text-transform: uppercase;" />
                </td>
            </tr>
            <tr id="whtr" style="display: none">
                <td class="Label1">扫描货位
                </td>
                <td class="Field1">
                    <input type="text" id="txtWHouse" class="TextBox" onchange="WhEnter();" style="width: 70%; font-size: 16px; font-weight: bold; text-transform: uppercase;" />
                </td>
            </tr>
            <tr id="whtrnum" style="display: none">
                <td class="Label1">输入备料数量
                </td>
                <td class="Field1">
                    <input type="text" id="txtWHouseNum" class="TextBox" style="width: 70%; font-size: 16px; font-weight: bold; text-transform: uppercase;" />
                </td>
            </tr>
        </table>
       
        <iframe id="iframeGrnList" name="iframeGrnList" style="width: 100%; overflow: auto; margin: auto 0px; height: 100%"
            frameborder="0" marginwidth="0" marginheight="0"></iframe>
    </div>
    <asp:HiddenField ID="hdFIFO" runat="server" Value="-1" ClientIDMode="Static" />
    <script type="" src="../Content/js/babel.min.js"></script>
  
    <%-- text/babel 用于兼容findIndex函数--%>
    <%--<script type="text/babel">--%>
    <script type="text/jscript">
        var requestOrder = 0; //领料单号
        var itemStr = ""; //存储领料单对应的ItemId
        var grnStr = ""; //存储扫描的Grn
        var FLgrnStr = ""; //存储分料截料GRN
        var NewFLgrnStr = "";//分料截料成功备料完成之后返回的新GRN，用于打印
        var itemAllQty = 0; //领料单总数量
        var requtestQty = 0;   //备料数量
        var flage = 0; //为true可取消先进先出推荐
        var requestId = 0;
        var selItemId = "";
        var GrnArr=[];//每次扫描的GRN存入进来
        var IsSeparateCutting =2;//仓库备料是否自动分料：1：需要 2：不需要 默认不需要
      var ProductMinNumType=1;//产品发料方式   1、默认 2、最小批量
        $(function () {
            
         if (!Array.prototype.findIndex) {
             Object.defineProperty(Array.prototype, 'findIndex', {
            value: function(predicate) {
                if (this == null) {
                    throw new TypeError('数组未定义');
                }
                var o = Object(this);
                var len = o.length >>> 0;
                if (typeof predicate !== 'function') {
                    throw new TypeError('predicate must be a function');
                }

                var thisArg = arguments[1];

           
                var k = 0;

          
                while (k < len) {
                    // a. Let Pk be ! ToString(k).
                    // b. Let kValue be ? Get(O, Pk).
                    // c. Let testResult be ToBoolean(? Call(predicate, T, « kValue, k, O »)).
                    // d. If testResult is true, return k.
                    var kValue = o[k];
                    if (predicate.call(thisArg, kValue, k, o)) {
                        return k;
                    }
                    // e. Increase k by 1.
                    k++;
                }

                // 7. Return -1.
                return -1;
               }
           });
         }

        //切换备料位置
        $("#selLocation").change(function(){
                setPickingList(requestId);
        });

         getmaterialsysconfig();
         $("#Button1").bind("click", function () {
             selectPickingList();
         });

            //增加自定义备料地点选择   BirongLiang  2017-5-11
            initLocSel();
            $("#txtReuestOrder").focus();
            //扫描领料单
            $("#txtReuestOrder").keydown(function () {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    if ($.trim($("#txtReuestOrder").val()) != "") {
                        requestOrder = $.trim($("#txtReuestOrder").val());
                        //setPickingList($("#txtReuestOrder").val());
                        //2017-3-17 通过领料单获取待选列表
                        var getList = SKT.LeanMES.Web.AjaxServices.AjaxMaterialApply.GetApplyInfo(requestOrder);
                        if (getList.error != null) {
                            alert(getList.error.Message)
                            $("#showGrn").html(getList.error.Message);
                            $("#showGrn").css("color", "red");
                            $("#txtReuestOrder").val("");
                            $("#txtReuestOrder").focus();
                            return false;
                        }
                        var dataList = JSON.parse(getList.value);
                        if (dataList.data.length * 1 > 1) {
                            selectPickingList(" and ApplyNo='" + requestOrder + "'");
                        } else {
                            requestId = dataList.data[0].ApplyId;
                            $("#txtReuestOrder").val(requestOrder);
                            $("#woNo").html(dataList.data[0].MOCode);
                            setPickingList(requestId);
                        }
                        
                    }
                    else{
                        alert("请选择备料单!");
                        return;
                    }
                }
            });
            /*扫描物料条码*/
            $("#txtGRN").keydown(function () {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    SendMaterial();
                }
            });
            /*扫描库位*/
            $("#txtWHouse").keydown(function () {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    WhEnter();
                }
            });
            /*输入发料数量*/
            $("#txtWHouseNum").keydown(function () {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    SendMaterialGRN(false);
                }
            });
            $("#scanSN").bind("click", function () {
                SendMaterial();
            });

            //input 事件焦点设定
            $('input').click(function () {
                this.blur();
                this.focus();
            });

            $("#leftApplication").height($(window).height() - 130);
            $("#iframeGrnList").height($(window).height() - 230);
           
        });
        function enterToTab()
        { }

        $("form").submit(function (e) {
            if (e && e.preventDefault) {
                e.preventDefault();
            }
            else {
                window.event.returnValue = false;
            }
            return false;
        })

  
        function getmaterialsysconfig() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialConfig.GetMaterialSysConfig(22);
            if (ajax.error == null) {
                var entity = $.parseJSON(ajax.value).data[0];
                IsSeparateCutting = entity.ChoosePageId;
            }
        }

        //浮点数相加

        function dcmAdd(arg1, arg2) {
            var r1, r2, m;
            try { r1 = arg1.toString().split(".")[1].length; } catch (e) { r1 = 0; }
            try { r2 = arg2.toString().split(".")[1].length; } catch (e) { r2 = 0; }
            m = Math.pow(10, Math.max(r1, r2));
            return (accMul(arg1, m) + accMul(arg2, m)) / m;
        }

        //浮点数相减  
        /*
         * 说明同上面的加法
         * */
        function dcmSub(arg1, arg2) {
            return dcmAdd(arg1, -arg2);
        }

        function accMul(arg1, arg2) {
            var m = 0, s1 = arg1.toString(), s2 = arg2.toString();
            try { m += s1.split(".")[1].length } catch (e) { }
            try { m += s2.split(".")[1].length } catch (e) { }
            return Number(s1.replace(".", "")) * Number(s2.replace(".", "")) / Math.pow(10, m)
        }

        //扫描GRN
        function SendMaterial() {
            if ($.trim($("#txtGRN").val()) == "") {
                $("#showGrn").html("物料条码不能为空!");
                $("#showGrn").css("color", "red");
                $("#txtGRN").focus();
                $("#txtGRN").select();
                return false;
            }
            if (requestOrder == 0) {
                $("#showGrn").html("请先选择对应的领料单!");
                $("#showGrn").css("color", "red");
                $("#txtReuestOrder").focus();
                $("#txtReuestOrder").select();
                return false;
            }
         
            var grn = $.trim($("#txtGRN").val());
            var oldqty,oldpartid;
            //if (grnStr.indexOf(grn) >= 0) {
            if (GrnArr.length > 0) {
                var findIndexs = GrnArr.findIndex(item => item.GRN === grn);

                if (findIndexs > -1) {
                    if (confirm("该条码已经扫描完成,是否清除?")) {
                        GrnArr.forEach(function (item, index) {
                            if (grn == item.GRN) {
                                oldqty = item.BalanceQty;
                                oldpartid = item.partid;
                            }
                        });
                        ClearSingleGrn(grn, oldqty, oldpartid);
                    } else {
                        $("#showGrn").html("该条码已经扫描完成，不能重复扫描!");
                        $("#showGrn").css("color", "red");
                        $("#txtGRN").focus();
                        $("#txtGRN").select();
                    }
                    return false;
                }
            }
            
            //包装判断
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.IsPack(grn);
            if (ajax.value != "" && ajax.value != null) {
                if (!window.confirm("该物料【" + grn + "】已存在包装【" + ajax.value + "】，是否解除包装!")) {
                    return "";
                }
            }


            flage = 0; //默认需要遵循先进先出，没有遵循则提示用户
            //校验GRN
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialApply.CheckGrnMaterialPrepare(itemStr, grn, flage, grnStr, requestId);
            if (ajax.error != null) {
                $("#showGrn").html(ajax.error.Message);
                $("#showGrn").css("color", "red");
                $("#txtGRN").focus();
                $("#txtGRN").select();
                return false;
            }
            else {
                var list = ajax.value[0];
                if (list.Flage == 0 && $("#chkR" + list.PartId).is(":checked")) {
                    var configType = "";
                    if (list.ConfigType == "createdate") {
                        configType = "生产日期";
                    } else if (list.ConfigType == "indate") {
                        configType = "入库日期";
                    }
                    var data = list.MinData;
                    var msg = "";
                    if (configType != "") {
       
                        msg = "该物料有更早[" + configType + "]为[" + data + "]的[" + list.MinGrn+ "]在库["+list.CBarCode+"]物料可用";
                    }

                    if ($("#hdFIFO").val() !== "1") {//没有取消FIFO的权限
                        alert("您没有遵循先进先出原则,\r\n" + msg);
                        $("#txtGRN").focus();
                        $("#txtGRN").select();
                        return false;
                    }

                    if (!confirm("您没有遵循先进先出原则，是否确认操作？\r\n" + msg)) {
                        $("#GRN").focus();
                        $("#GRN").select();
                        return false;
                    }
                }


                var ctrl = $("#td" + list.PartId);
                /*判断扫描数量总和不能大于申请数量*/
                var appCount = $("#qty" + list.PartId).text(); //申请数量
                var requestCount = $("#td" + list.PartId).text(); //已备料数量
                var selLocation = $("#selLocation").val();  //线边仓允许超发  2017-3-8 BirongLiang
                //获取发料方式
                var IssueWay = list.IssueWay;
                ProductMinNumType=list.IssueWay;
                if (IssueWay == "2") { //最小批次发货
                    //如果已备料数量>申请数量，不可以继续扫描发料
                    //if (parseFloat(parseFloat(requestCount) + list.BalanceQty) > parseFloat(appCount)) {
                    if (parseFloat(parseFloat(requestCount)) > parseFloat(appCount)) {
                        $("#showGrn").html("备料数量已经大于领料申请数量!");
                        $("#showGrn").css("color", "red");
                        $("#txtGRN").val("");
                        $("#txtGRN").focus();
                        $("#txtGRN").select();
                        return false;
                    }
                }
                if (parseFloat(parseFloat(requestCount)) >= parseFloat(appCount) && selLocation =='2' && IssueWay =="1") {
                    $("#showGrn").html("备料数量不能大于领料申请数量!");
                    $("#showGrn").css("color", "red");
                    $("#txtGRN").val("");
                    $("#txtGRN").focus();
                    $("#txtGRN").select();
                    return false;
                }
                if (parseFloat(parseFloat(requestCount) + list.BalanceQty) > parseFloat(appCount) ) {
                    var FLQty = dcmSub(list.BalanceQty,dcmSub(parseFloat(appCount),parseFloat(requestCount)));
                    FLgrnStr += grn + ":" + FLQty + ",";
                }
               
                var obj={};
                obj.GRN=grn;
                obj.BalanceQty = list.BalanceQty;
                obj.partid = list.PartId;
                var isCz = false;
                if (GrnArr.length > 0) {
                    for (var i = 0; i < GrnArr.length; i++) {
                        if (GrnArr[i].GRN == grn) {
                            GrnArr[i].BalanceQty = list.BalanceQty;
                            isCz = true;
                        }
                    }
                    if (!isCz) {
                        GrnArr.push(obj);
                    }
                } else {
                    GrnArr.push(obj);
                }
                

                ctrl.text(parseFloat((parseFloat(ctrl.text()) + list.BalanceQty).toFixed(6)));
                $("td").removeClass("focuMrl");
                ctrl.attr('class', 'focuMrl');
                var tdOffset = ctrl.offset();
                $("#leftApplication").scrollTop(tdOffset.top);//将DIV滚动到当前位置  BirongLiang 2017-3-27
                $("#txtGRN").focus();
                requtestQty += list.BalanceQty;
                var applyDtlId = parseInt($(ctrl).attr('ApplyDtlId'));
                grnStr += grn + ":" + applyDtlId + ',';
                $("#showGrn").html("扫描完成!");
                $("#showGrn").css("color", "green");
                $("#txtGRN").val("");
                $("#txtGRN").focus();
                $("#txtGRN").select();

                if (parseFloat(parseFloat(requestCount) + list.BalanceQty) == parseFloat(appCount)) {
                    //数量相等变绿色
                    ctrl.attr('class', 'bg-green');
                }
            }
        }
        //选择领料单
        function selectPickingList(condition) {
            var plusCondition = "";
            if (condition == undefined || condition == '')
                plusCondition = "";
            var searchCondition = " Statue in(0, 4) and ApplyClass<>0";
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=83&PageCondition="
                + escape(searchCondition + plusCondition) + "&Multiple=false&CallBackFunc=getChooseValue&rnd=" + Math.random(), width: 700, height: 380
            });
        }
        function getChooseValue(list) {
            requestOrder = list[0][1]; //领料单号
            requestId = list[0][0];
            $("#txtReuestOrder").val(list[0][1]);
            $("#woNo").text(list[0][2]);
            setPickingList(list[0][0]);  //改为用ApplyID，应对一张applyNO有多个工单的情况  2017-3-16 BirongLiang
            $("#txtGRN").val("");
            
        }
        //根据投料单获取物料信息
        function setPickingList(applyID) {
            if(applyID <= 0){
                return false;
            }
            //初始化明细
            initDetail();
            //获取明细
            if (applyID != "" && applyID != "") {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialApply.GetApplyDtlList($.trim(applyID));
                if (ajax.error != null) {
                    $("#msg").html(ajax.error.Message);
                    $("#msg").css("color", "red");
                    return false;
                }
                else {
                    var list = ajax.value;
                    var r = "";
                    if (list == null || list.length == 0) {
                        r += "<tr class='ListTableEmptyDataRow'><td colspan='7' >此工单暂无数据</td></tr>";
                        $(r).appendTo($("#tblRecHistory"));
                        return false;
                    }
                    for (var i = 0; i < list.length; i++) {
                        requestId = list[0].ApplyId;
                        itemStr += list[i].ItemId + ',';
                        itemAllQty += list[i].ApplyQty; //领料单申请数量
                        if (i % 2 == 0) {
                            r += "<tr class='ListTableOddRow'><td></td>";
                        }
                        else {
                            r += "<tr class='ListTableEvenRow'><td></td>";
                        }
                        r += "<td>" + list[i].ItemCode + "(" + list[i].ItemName + ")" + "</td>";
                        r += "<td id='qty" + list[i].ItemId + "'>" + parseFloat(list[i].ApplyQty) + "</td><td  ApplyDtlId='"+ list[i].ApplyDtlId +"' id='td" + list[i].ItemId + "'>" + parseFloat(list[i].StockQty) + "</td>";
//                        if (list[i].IsGrn == 1) {
//                            //有条码
//                            r += "<td align='center'><input type='checkbox' id ='chktd" + list[i].ItemId + "' disabled='disabled' checked ='true'/><input type='hidden' value='" + list[i].ItemId + "' style='display:none'/></td>";
//                        }
//                        else {
//                            //无条码
//                            r += "<td align='center'><input type='checkbox' id ='chktd" + list[i].ItemId + "' disabled='disabled'/><input type='hidden' value='" + list[i].ItemId + "' style='display:none'/></td>";
                        //                        }
                        if ($("#hdFIFO").val() === "1") {                            
                            r += "<td align='center'><input type='checkBox' class='cbRulePrep' id='chkR" + list[i].ItemId + "' checked='true'><a href='#' onclick ='SearchRule(this)'>先进先出</a><input type='hidden' value='" + list[i].ItemId + "' style='display:none'/></td>";
                        } else
                        {
                            r += "<td align='center'><input type='checkBox' disabled = 'disabled' class='cbRulePrep' id='chkR" + list[i].ItemId + "' checked='true'><a href='#' onclick ='SearchRule(this)'>先进先出</a><input type='hidden' value='" + list[i].ItemId + "' style='display:none'/></td>";
                        }
                        //r += "<td><input type='checkbox'  class='checkboxIssue' onclick='issueselect(this)'/><input type='hidden' value='" + list[i].ItemId + "' style='display:none'/></td>"
                        r += "<td><input type='button' id='budel" + i + "' value='清除' onclick='OrderDelClick(this," + list[i].ItemId + "," + list[i].StockQty + ")' /></td>";
                        r += "</tr>";
                    }

                    if ($("#tblRecHistory tr").length == 1) {
                        $("#tblRecHistory tr:eq(0)").after(r);
                    }
                    else {
                        $("#tblRecHistory tr:eq(1)").before(r);
                    }
                    var j = 0;
                    $("#tblRecHistory tr").each(function () {
                        $(this).children("td:eq(0)").html(j.toString());
                        j++;
                    });
                }
            }
        }
        //清除单个GRN
        function ClearSingleGrn(GRN, qty, partid) {
          
            var ctrl = $("#td" + partid);
            var grnCount = ctrl.text();
            var newNumber = parseFloat(grnCount) - parseFloat(qty);
            requtestQty = parseFloat(requtestQty) - parseFloat(qty);
            ctrl.text(newNumber);
            var grnStrArr = grnStr.split(',');
            grnStrArr = $.grep(grnStrArr, function (item, index) {
                return item != GRN;
            });
            grnStr = grnStrArr.join();

            var deleteIndex = GrnArr.findIndex(item => item.GRN === GRN);
            GrnArr.splice(deleteIndex, 1);


            if (newNumber == 0) {
                ctrl.removeClass("focuMrl");
                ctrl.removeClass("bg-green");
            }
        }
        //清除已经扫描的GRN by liwen 20200618
        function OrderDelClick(obj, ItemId, StockQty) {
          
            var ctrl = $("#td" + ItemId);
            var grnCount = ctrl.text();
            if (grnCount == 0) {
                return false;
            }
            if (grnCount == StockQty) {
                alert("当前数据没有扫描GRN!");
                return false;
            }
            if (confirm("确认清除?")) {
                ctrl.removeClass("focuMrl");
                ctrl.removeClass("bg-green");
                ctrl.text(StockQty);
                grnStr = '';

                removeWithoutCopy(GrnArr, ItemId);

                for (var i = 0; i < GrnArr.length; i++) {
                    grnStr += GrnArr[i].GRN + ',';
                }
                requtestQty = 0;
                alert("清除完成!");
            }
        }

        function removeWithoutCopy(arr, item) {
            var pos =0;
            while(pos < arr.length)
            {
                pos = arr.findIndex(obj => obj.partid === item);
                if(pos == -1) break;
                arr.splice(pos,1);
                if( arr.length !=0)
                {
                    removeWithoutCopy(arr,item);
                }
            }
            return arr;
        }
        var itemId = -1; //获取选中的ItemId
        //先进先出列表显示
        function SearchRule(obj) {
            var $obj = $(obj);
            var isAsc = 0;
            if ($obj.is("input")) {
                //$obj = $obj.next();
                //isAsc = 1;
                return false;
            }
            itemId = $obj.next().val();
            $("#iframeGrnList").attr("src", "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Material/MaterialPrepareView.aspx?ID=" + itemId + "");
        }
        /* 清空指定table中数据 */
        function clearWaitGrnTable() {
            if ($("#tblRecHistory tr").length > 1) {
                $("#tblRecHistory tr:not(:first)").remove();
            }
            $("#iframeGrnList").attr("src", "");
            $("#showGrn").html("");

            itemStr = ""; //存储领料单对应的ItemId
            grnStr = ""; //存储扫描的Grn
            itemAllQty = 0; //领料单总申请数量
            requtestQty = 0;   //本次备料数量
            whList = [];
        }
        //扫描库位
        function WhEnter() {
            if ($.trim($("#txtWHouse").val()) == "") {
                $("#showGrn").html("货位不可为空!");
                $("#showGrn").css("color", "red");
                $("#txtWHouse").focus();
                return false;
            }
            //检验库位条码是否正确
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.GetBarCode($.trim($("#txtWHouse").val()));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return;
            }
            var en = $.parseJSON(ajax.value);
            if (!en.BarCode) {
                $("#showGrn").html("货位不存在!");
                $("#showGrn").css("color", "red");
                $("#txtWarehouse").focus();
                $("#txtWarehouse").val("");
                $("#txtWHouseNum").select();
                return;
            }
            else {
                $("#txtWHouseNum").focus();
                $("#showGrn").html("货位扫描成功!");
                $("#showGrn").css("color", "green");
            }
        }
        var whList = [];
        //输入备料数量
        function SendMaterialGRN() {
            var txtWHouse = $("#txtWHouse").val(); //库位
            var txtWHouseNum = $("#txtWHouseNum").val(); //数量

            if (requestOrder == "") {
                $("#showGrn").html("请先选择对应的领料单!");
                $("#showGrn").css("color", "red");
                $("#txtReuestOrder").focus();
                $("#txtReuestOrder").select();
                return false;
            }
            if (selItemId == "") {
                $("#showGrn").html("无GRN发料，需要选择对应的物料!");
                $("#showGrn").css("color", "red");
                return false;
            }
            if ($.trim($("#txtWHouse").val()) == "") {
                $("#showGrn").html("货位不可为空!");
                $("#showGrn").css("color", "red");
                $("#txtWHouse").focus();
                return false;
            }

            var type = "^[0-9]*[1-9][0-9]*$";
            var re = new RegExp(type);

            if ($.trim(txtWHouseNum) == "") {
                $("#showGrn").html("备料数量不可为空!");
                $("#showGrn").css("color", "red");
                $("#txtWHouseNum").focus();
                return false;
            }

            var ctrl = $("#td" + selItemId);

            /*判断扫描数量总和不能大于申请数量*/
            //线边仓允许超发（超过申请数量）  BirongLiang 2017-3-8
            var appCount = $("#qty" + selItemId).text(); //申请数量
            var requestCount = $("#td" + selItemId).text(); //已备料数量
            var selLocation = $("#selLocation").val();  
            if (parseFloat(parseFloat(requestCount) + parseFloat(txtWHouseNum)) > parseFloat(appCount) && selLocation =='2') {
                $("#txtWHouseNum").focus();
                $("#showGrn").html("备料数量不可以大于该物料申请数!");
                $("#showGrn").css("color", "red");
                return false;
            }
            requtestQty += parseFloat(txtWHouseNum);
            ctrl.text(parseFloat(ctrl.text()) + parseFloat(txtWHouseNum)); //更新已备料数量
            whList.push({ ItemId: selItemId, WHouse: txtWHouse, WHouseNum: txtWHouseNum });
            $("#showGrn").html("扫描完成!");
            $("#showGrn").css("color", "green");
            $("#txtWHouseNum").val("");
            $("#txtWHouseNum").focus();
            $("#txtWHouseNum").select();
        }



        function Save() {
            /*选择的是线别仓还是产线*/
            var selLocation = $("#selLocation").val();
            var locDesc = $("#selLocation").find("option:selected").text();

            if (requestOrder == 0) {
                alert("请选择领料单!");
                return false;
            }
            if (parseFloat(itemAllQty) == "0") {
                alert("申请数量为0,不能备料!");
                return false;
            }
            if (parseFloat(requtestQty) == "0") {
                alert("备料数量为0,不能备料!");
                return false;
            }
            var Isexceed=0;// 1:超发 0：未超发
            if (confirm('是否确定该领料单备料?')) {

            
              
                    var iscf=false;
                    var cfitem="";
                    $("#tblRecHistory tbody tr").each(function (i,e) {
                        if (!$(e).hasClass("ListTableHeader")) {
                            var applyqty = $.trim($(e).find("td:eq(2)").text());
                            var stockqty = $.trim($(e).find("td:eq(3)").text());
                            if (stockqty != "" && applyqty != "") {
                                if (parseFloat(stockqty) > parseFloat(applyqty)){
                                    iscf = true;
                                    Isexceed=1;
                                    cfitem=$.trim($(e).find("td:eq(1)").text());
                                    return false;
                                }  
                            }
                        }
                    });
                    var cfsend=false;
                    //modify by yz.xiong 只有备料到产线时，进行超发控制
                    if (iscf && selLocation == "2") {
                        if (confirm("当前料号【" + cfitem + "】数量已超发，是否确认超发备料?")) {
                            cfsend=true;
                        }
                        if(!cfsend)
                            return false;
                    }
                    else{
                        Isexceed = 0;
                    }
                

                var userName = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>';

                var materialStorageNo = ""; //备料单号
                var ajaxNo = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.GetMaterialStorageNo(-10);
                if (ajaxNo.error != null) {
                    alert(ajaxNo.error.Message);
                    return;
                } else {
                    if (ajaxNo.value == "") {
                        alert("备料单号获取失败");
                        return;
                    }
                    materialStorageNo = ajaxNo.value;
                }

                var entity = {};
                entity.RequestId = requestId;
                entity.userName = userName;
                entity.PrepareMaterialNo = materialStorageNo;
                if (whList.length == 0) {
                    whList.push({ ItemId: "-1", WHouse: "", WHouseNum: 0 });
                }
                entity.tbDtl = JSON.stringify(whList);

                //requestId:领料申请单ID,selLocation:线别仓还是产线,grnStr:GRN集合,entity 无GRN项 备料列表
                //var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialApply.SaveMaterialPrepare(materialStorageNo, requestId, selLocation,locDesc, grnStr, userName, JSON.stringify(entity));
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialApply.SaveMaterialPrepare(materialStorageNo, requestId, selLocation, locDesc, grnStr, userName, JSON.stringify(entity), FLgrnStr,ProductMinNumType,Isexceed);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                else {
                    /*清空数据*/
                    if ($("#tblRecHistory tr").length > 1) {
                        $("#tblRecHistory tr:not(:first)").remove();
                    }

                    $("#iframeGrnList").attr("src", "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Material/MaterialPrepareView.aspx?ID=-1");
                   
                    
                    var str = "<tr id='trNewInfo' class='ListTableOddRow'><td colspan='7' style='text-align:center;'>暂无数据</td></tr>";
                    $(str).appendTo($("#tblRecHistory"));
                    NewFLgrnStr = ajax.value;

                    if (NewFLgrnStr != "") {
                        if (confirm("备料成功！有条码自动分料截料，是否需要打印新条码？")) {
                            dialog({ title: "<%= Resources.Pages.Material_ReprintGRN %>", src: "ReprintGRN.aspx?name=Material_ReprintGRN&GRN=" + NewFLgrnStr + "&rnd=" + Math.random(), width: 450, height: 200 });
                        }
                    }
                    else {
                        alert("备料成功!");
                    }
                    //初始化单据
                    initOrder();
                }
            }
        }
        //分料截料
//        function openSplitMaterial() {
//            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Material/MaterialSplit.aspx?name=Material_MaterialSplit";
//            dialog({ title: "分料截料", src: openWinUrl, width: 750, height: 400 });
//        }
        //物料选择框事件
        function issueselect(obj) {
            var $obj = $(obj);
            if ($obj.attr("checked") != "checked") {
                //取消选择
                selItemId = "";
                show1();
                return;
            }
            $(".checkboxIssue").each(function () {
                if (this != obj) {
                    $(this).attr("checked", false);
                }
            });
            var itemId = $obj.next().val();
            if ($("#chktd" + itemId).is(':checked')) {
                //有条码
                show1();
            }
            else {
                //无条码
                selItemId = $obj.next().val(); //选择的物料ID
                show2();
            }
            $("#showGrn").html("");
        }
        //GRN条码
        function show1() {
            $("#grntr").show();
            $("#whtr").hide();
            $("#whtrnum").hide();
        }
        //仓库条码
        function show2() {
            $("#whtrnum").show();
            $("#whtr").show();
            $("#txtWHouseNum").val("");
            $("#grntr").hide();
            $("#iframeGrnList").attr("src", ""); //隐藏先进先出列表
        }

        function initLocSel() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialApply.GetPrepareLoc();
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var dataList = JSON.parse(ajax.value).data;
            var strHtml = '';
            for (var i = 0; i < dataList.length; i++) {
                strHtml += '<option value="' + dataList[i].RID + '">' + dataList[i].PrepareDesc + '</option>';
            }
            $("#selLocation").append(strHtml);

        }

        //初始化单据
        function initOrder(){
            requestId =0;
            requestOrder = 0;
            $("#txtReuestOrder").val("");
            $("#woNo").html("");
            initDetail();
        }
        //初始化明细
        function initDetail() {
            FLgrnStr = "";
            NewFLgrnStr = "";
            $("#msg").html("");
            $("#showGrn").html("");
            GrnArr = [];
            clearWaitGrnTable();
        }
    </script>
</asp:Content>
