<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="True"
    CodeBehind="WarehouseCheckOrderEdit.aspx.cs"
    Inherits="SKT.LeanMES.Web.MaterialCheck.WarehouseCheckOrderEdit" Title="" %>

<%@ MasterType VirtualPath="~/Masters/EditMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <link href="../Content/plugin/DataTables-1.10.12/css/jquery.dataTables.min.css" rel="stylesheet"
        type="text/css" />
    <script src="../Content/plugin/DataTables-1.10.12/js/jquery.js" type="text/javascript"></script>
    <script src="../Content/plugin/DataTables-1.10.12/js/jquery.dataTables.js" type="text/javascript"></script>
    <style>
        .jqTable th {
            background-color: #ececec;
            padding: 3px;
            height: 22px;
            border: 1px solid #d3d3d3;
            border-collapse: collapse;
            font-family: Verdana, 微软雅黑,黑体,宋体;
            color: #183152;
        }

        .jqTable tr td {
            border: 1px solid rgb(211, 211, 211);
        }

        thead td {
            border-bottom: 1px solid #ececec;
            border-collapse: collapse;
        }

        table.dataTable.no-footer {
            border-bottom: 1px solid #ececec;
            border-collapse: collapse;
        }

        table.dataTable thead th, table.dataTable thead td {
            border-bottom: 1px solid #ececec;
            border-collapse: collapse;
            padding: 0px;
        }
    </style>

    <div class="wrap_tb" style="min-height: 350px; min-width: 600px">
        <ul class="tb">
            <li class="current" title="<%= Resources.lang.BaseInfo%>">
                <%= Resources.lang.BaseInfo%>
            </li>
            <li title="物料选择" id="tabChooseMaterial">物料选择</li>
        </ul>
        <!--基本信息-->
        <div class="tb_c">
            <div class="infoTips">
                <%=Resources.Messages.WithAsteriskIsRequired %>
            </div>
            <table class="EditeContentTable" width="100%">
                <tr>
                    <td class="Label1">盘点单<em>*</em>
                    </td>
                    <td class="Field1">
                        <asp:TextBox ID="txtCheckOrder" runat="server" CssClass="TextBox" ClientIDMode="Static"
                            IsRequired='1' Width="270px"></asp:TextBox>
                        <input type="button" id="btnGetOrderSN" width="200px" style="display: none" value="新建系统内置规则单号" />
                        <asp:Label ID="lbOrderStatus" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="Label1">盘点单名称<em>*</em>
                    </td>
                    <td class="Field1">
                        <input type="text" id="txtCheckOrderName" class="TextArea" isrequired='1' runat="server" clientidmode="Static" />
                    </td>
                </tr>
                <%--                    <tr>
                        <td class="Label1">
                            当前状态
                        </td>
                        <td class="Field1">
                            <input type="text" id="txtCheckOrderStatus" class="TextBox" runat="server" disabled="True"/>
                        </td>
                    </tr>--%>
                <!-- <tr>
                        <td class="Label1">
                            仓库<em>*</em>
                        </td>
                        <td class="Field1">
                            <asp:TextBox ID="txtWhCode" runat="server" CssClass="TextBox" ClientIDMode="Static" AutoPostBack="True"
                                ReadOnly="true"></asp:TextBox><input id="button1" class="ButtonBox" type="button" onclick="selectWhCodeList()"
                                value="..." title="选择仓库" />
                            <asp:HiddenField ID="hdnWhCode" runat="server" Value="-1" ClientIDMode="Static" />
                            <asp:HiddenField ID="hdnWhID" runat="server" Value="-1" ClientIDMode="Static" />
                        </td>
                    </tr> -->
                <!-- <tr>
                        <td class="Label1">
                            物料编码
                        </td>
                        <td class="Field1">
                            <asp:TextBox ID="TextBox1" runat="server" CssClass="TextBox" ClientIDMode="Static" AutoPostBack="True"
                                ReadOnly="true"></asp:TextBox><input id="button1" class="ButtonBox" type="button" onclick="selectWhItem()"
                                value="..." title="选择物料" />
                            <asp:HiddenField ID="HiddenField1" runat="server" Value="-1" ClientIDMode="Static" />
                        </td>
                    </tr>
                    <tr>
                        <td class="Label1">
                            已选择物料
                        </td>
                        <td class="Field1" id="tdItemCode" style="font-weight:bolder">
                        </td>
                    </tr>-->
                <tr>
                    <td class="Label1">盘点类型<em>*</em>
                    </td>
                    <td class="Field1" id="tdSelCheckType"></td>
                </tr>
                <tr>
                    <td class="Label1">计划时间<em>*</em>
                    </td>
                    <td class="Field1">
                        <input type="text" id="txtBeginDate" isrequired='1' class="DateTimeBox" runat="server" clientidmode="Static"
                            readonly="readonly" />
                    </td>
                </tr>
                <!-- <tr>
                        <td class="Label1">
                            选择所有GRN
                        </td>
                        <td class="Field1">
                            <input type="checkbox" id="chkAllMa" class="checkbox" runat="server" clientidmode="Static"/>
                        </td>
                    </tr>-->
                <tr>
                    <td class="Label1">备注
                    </td>
                    <td class="Field1">
                        <textarea style="width: 370px" class="TextArea" id="txtRemark"></textarea>
                    </td>
                </tr>
            </table>

        </div>
        <!--物料编辑-->
        <div>
            <table class="EditeContentTable" width="100%">
                <tr style="height: 300px; padding: 2px;" valign="top">
                    <td class="Field" align="center" style="width: 90%; vertical-align: top;">
                        <div id="loadingmessages1" class="Tips">
                            数据加载中...
                        </div>
                        <iframe name="frmToChooseList" id="frmToChooseList" frameborder="0" style="width: 99%; height: 600px;"
                            src=""></iframe>
                    </td>
                </tr>
            </table>


        </div>
    </div>
    <asp:HiddenField ID="hfCheckTypeList" runat="server" Value="-1" ClientIDMode="Static" />
    <asp:HiddenField ID="hfSelType" runat="server" Value="-1" ClientIDMode="Static" />

    <asp:HiddenField ID="hfMaterialList" runat="server" Value="-1" ClientIDMode="Static" />
    <asp:HiddenField ID="hfMaterialChossing" runat="server" Value="-1" ClientIDMode="Static" />
    <asp:HiddenField ID="hfRenderFlag" runat="server" Value="-1" ClientIDMode="Static" />
    <asp:HiddenField ID="hdnRemark" runat="server" Value="" ClientIDMode="Static" />
    <script type="text/javascript">
        var warehouseCheckOrderId = '<%=Request.QueryString["ID"]%>';
        var arrItemId = [];  //选择的ItemCode
        var userName = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>';
        $(document)
            .ready(function () {
                initSelControls($("#hfSelType").val()); //绑定盘点单类型控件
                if (warehouseCheckOrderId * 1 > 0 && $("#hdnWhID").val() * 1 > 0) {//编辑模式
                   // var mChooseList = getMaterialList(1);
                    //$('#tbToChoose').DataTable().destroy();
                    //$('#tbToChoose').empty();
                    //initJqTable('tbChoose', mChooseList);
                    //$('#tbToCheck').DataTable().destroy();
                    //$('#tbToCheck').empty();
                    //initJqTable('tbCheck', mCheckList);
                    //清空页面
                    // parent.window.Refresh();
                }
                if (warehouseCheckOrderId === '-1') $("#btnGetOrderSN").show();
                //赋值给Remark

                $("#txtRemark").val($("#hdnRemark").val());
            });

        function initSelControls(checkType) {
            var checkTypeList = $("#hfCheckTypeList").val();
            var objTypeList = JSON.parse(checkTypeList);
            if (objTypeList.length == 0) {
                alert('盘点单种类信息获取失败');
                return false;
            }
            //----盘点单类型
            var ddlHtml = "<select class='ddlCheckType' id='ddlCheckType'> ";
            ddlHtml += "<option value='-1'>请选择</option> ";
            for (var i = 0; i < objTypeList.length; i++) {
                var ItemIndex = objTypeList[i].ItemIndex;
                var ItemName = objTypeList[i].ItemName;
                if (checkType === ItemName) {
                    ddlHtml += "<option selected='selected' value='" + ItemIndex + "'>" + ItemName + "</option> ";
                } else {
                    ddlHtml += "<option value='" + ItemIndex + "'>" + ItemName + "</option> ";
                }

            }
            ddlHtml += "</select>";
            $("#tdSelCheckType").html(ddlHtml);

        }

        //选择仓库
        function selectWhCodeList() {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=14&Multiple=false&CallBackFunc=setWhCode&rnd=" + Math.random(), width: 500, height: 300 });
        }

        //选择物料
        function selectWhItem() {
            if ($("#hdnWhID").val() === '-1') {
                alert('请先选择仓库')
                return false;
            }
            var condition = " WarehouseId=" + $("#hdnWhID").val();
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=202&Multiple=true&CallBackFunc=setWhItemCode&PageCondition=" + escape(condition) + "&rnd=" + Math.random(), width: 800, height: 500 });
        }

        function setWhCode(list) {
            var whCodes = list[0][1] + "|" + list[0][2];
            if (list[0][0] == "-1") {
                whCodes = "";
            }
            $("#tdItemCode").html("");//清空物料选择相关信息
            arrItemId = [];
            $("#<%=this.txtWhCode.ClientID %>").val(whCodes);
            $("#hdnWhID").val(list[0][0]);
            $("#hdnWhCode").val(list[0][1]);
            //$('#chkAllMa').removeAttr('checked');
            var mList = getMaterialList(1); //绑定可选物料信息
            //清空，绑定表格
            $('#tbToChoose').DataTable().destroy();
            $('#tbToChoose').empty();

            initJqTable('tbChoose', mList);

            $('#tbToCheck').DataTable().destroy();
            $('#tbToCheck').empty();
            if ($("#hdnWhID").val() * 1 > 0) {
                var mCheckList = getMaterialList(2); //获取已选择盘点内容    
                initJqTable('tbCheck', mCheckList);
            } else {
                initJqTable('tbCheck', []);
            }
        }

        function setWhItemCode(list) {
            if (list.length > 0) {
                for (var i = 0; i < list.length; i++) {
                    if (list[i][0] === '-1') {
                        $("#tdItemCode").html('');
                        arrItemId = [];
                    } else {
                        if (checkSelected("'" + list[i][1] + "'")) return false;
                        arrItemId.push("'" + list[i][1] + "'");
                        $("#tdItemCode").append(list[i][1] + ";");
                    }

                }
            }
            $("#hfRenderFlag").val('-1');
            //$('#chkAllMa').removeAttr('checked');
            //var mList = getMaterialList(1, arrItemId.join(',')); //绑定可选物料信息            
            //$('#tbToChoose').DataTable().destroy();
            //$('#tbToChoose').empty();
            //initJqTable('tbChoose', mList);//清空，绑定表格
        }

        function checkSelected(itemCode) {
            var exist = false;
            if (arrItemId.indexOf(itemCode) > -1) {
                alert("请勿重复选择");
                exist = true;
            } else {
                arrItemId.push(itemCode);
            };
            return exist;
        }

        //flag=1,获取待选物料，flag=2,获取已选择的物料
        function getMaterialList(flag, condition) {
            //var flag  =1;
            var orderId = warehouseCheckOrderId;
            var whId = $("#hdnWhID").val() * 1;
            if (whId < 0) return false;
            var searchSetting = condition || '';
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxWarehouse.GetMaterialForCheck(flag, orderId, whId, searchSetting);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            //console.log(ajax.value)
            //$("#hfMaterialList").val(ajax.value);
            return (ajax.value);

        }

        function initJqTable(tb, strDataSet) {
            //var objDataSet = JSON.parse(strDataSet);TODO：数据量太大，应使用分页
            var objDataSet = strDataSet;
            //if (objDataSet.length === 0) return;
            var dataSet = [];
            for (var i = 0; i < objDataSet.length; i++) {
                var row = [];
                row.push(objDataSet[i].WhBarcode); //货架
                row.push(objDataSet[i].ItemCode); //
                row.push(objDataSet[i].Item); //Item名字
                //row.push(objDataSet[i].StorageQty); //数量
                row.push(objDataSet[i].SN); //SN
                dataSet.push(row);
            }
            if (tb === 'tbChoose') {
                $('#tbToChoose').DataTable({
                    data: dataSet,
                    paging: true,
                    //dom: '<"toolbar">frtip',
                    searching: true,
                    scrollCollapse: true,
                    //scrollY: "380px", //超过380px高度用滚动条。不兼容@2016/12/2
                    language: getJQTableLanguage(),   //多语言设定（默认英语）
                    columns: [
                        { title: "货位编码" },
                        { title: "物料编码" },
                        { title: "物料描述" },
                        //{ title: "库存" },
                        { title: "SN" }
                    ]
                });
            }
            if (tb === 'tbCheck') {
                $('#tbToCheck').DataTable({
                    data: dataSet,
                    paging: true,
                    searching: true,
                    scrollCollapse: true,
                    language: getJQTableLanguage(),
                    columns: [
                        { title: "货位编码" },
                        { title: "物料编码" },
                        { title: "物料描述" },
                        //{ title: "库存" },
                        { title: "SN" } //will save columns(4)
                    ]
                });
            }
        }
        //选中行变色
        $('#tbToChoose,#tbToCheck').on('click', 'tr', function () {
            $(this).toggleClass('selected');
        });

        function assignToListBox() {
            var table1 = $('#tbToChoose').DataTable();
            var table2 = $('#tbToCheck').DataTable();
            var choosingData = table1.rows('.selected').data();
            var dataLen = choosingData.length;
            for (var i = 0; i < dataLen; i++) {
                table2.row.add(choosingData[i]).draw(false);//插入到右边
            }
            table1.rows('.selected').remove().draw(false); //删除左边的选择内容
            //console.log("rowCount = " + table1.rows('.selected').data().length)
            //console.log(JSON.stringify(table1.rows('.selected').data()))
        }

        function deleteFromListBox() {
            var table1 = $('#tbToChoose').DataTable();
            var table2 = $('#tbToCheck').DataTable();
            var choosingData = table2.rows('.selected').data();
            var dataLen = choosingData.length;
            for (var i = 0; i < dataLen; i++) {
                table1.row.add(choosingData[i]).draw(false);
            }
            table2.rows('.selected').remove().draw(false);
        }

        /*保存数据*/
        function Save() {
            var checkOrder = $("#txtCheckOrder").val();
            //searchWhCodeId
            var warehouseId = window.frames[0].window.$("#hdnWhIDOne").val();
            var getQty = -1;
            getQty = window.frames[0].window.$("#txtGetQty").val();
            if (getQty == "") { getQty == 0 }
            var checkType = $("#ddlCheckType").val();
            var checkTime = $("#txtBeginDate").val();
            var remark = $("#txtRemark").val();
            var tbToCheck = $('#tbToCheck').DataTable();
            var checkMaterialSN = tbToCheck.columns(3).data().join(",");
            var checkOrderName = $("#txtCheckOrderName").val();

            var inTime = new Date(checkTime);
            inTime = inTime.getFullYear() + '-' + (inTime.getMonth() + 1) + '-' + inTime.getDate()
            var nowTime = new Date();
            nowTime = nowTime.getFullYear() + '-' + (nowTime.getMonth() + 1) + '-' + nowTime.getDate()
            if (checkType === '-1') {
                alert('请选择盘点类型');
                return false;
            }

            if (Date.parse(inTime) < Date.parse(nowTime)) {
                alert('计划时间不能小于当前日期');
                return false;
            }   //  时间输入验证

            if (window.frames[0].window.$('#chkMatchWholeWord').is(":checked")) {
                if (getQty == "") {
                    alert("请填写物料款数!");
                    return false;
                }
                if (warehouseId == -1) {
                    alert("请选择对应的仓库!");
                    return false;
                }
            }

            //获取已经选择的GRN
            window.frames[0].window.$("#tbBuyOrderDetail tbody tr").each(function () {
                var a = $(this).children();//获取每一行
                RowId = a[0].innerText;//取得第2列的值 行号
                grn = a[4].innerText;
                CheckGRNDetail.push({ "GRN": grn, "NowQty": RowId });
                //window.frames[1].window.$("tr[id=" + grn + "]").remove();
            });

            if (CheckGRNDetail.length == 0) {
                alert("请查询选择对应的盘点物料!");
                return false;
            }

            var entity = {}; // Model WarehouseCheckOrderInfo
            entity.ProdWarehouseCheckId = warehouseCheckOrderId;
            entity.CheckOrder = checkOrder;
            entity.WarehouseId = warehouseId;
            entity.CheckTypeId = checkType;
            entity.BeginDate = checkTime;
            entity.Remark = remark;
            // entity.SN = checkMaterialSN;
            entity.CheckOrderName = checkOrderName;
            entity.CreateBy = userName + "||" + getQty;
            entity.TbDtl = JSON.stringify(CheckGRNDetail);
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxWarehouse.WarehouseCheckOrderEdit(JSON.stringify(entity));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert('<%=Resources.Messages.SaveInSuccess%>')
            if ('<%=Request.QueryString["inMenu"] %>' == "true") {
                openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/User/UserEdit.aspx?name=Account_UserEdit&ID=" + parseInt(ajax.value);
                location.href = openWinUrl;
            }
            else {
                parent.window.Refresh();
                document.forms[0].submit();
            }
            window.parent.openTab(this, "仓库盘点列表", "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/MaterialCheck/WarehouseCheckOrderList.aspx?name=WarehouseCheckOrderList", Date.parse(new Date()), "<%=SKT.LeanMES.Web.WebHelper.ImageRoot %>icon/eqpttype.png");
            parent.window.Refresh();
            window.location.reload();
        }

        ////checkbox
        //$('#chkAllMa').on('click', function () {
        //    if ($("#hdnWhID").val() * 1 < 0) {
        //        alert('请选择仓库');
        //        $(this).removeAttr('checked');
        //        return false;
        //    } else {
        //        $("#hfRenderFlag").val(genTempTable());//生成临时表
        //        if ($('#chkAllMa').is(':checked')) {
        //            //选择全部物料
        //            var selAll = SKT.LeanMES.Web.AjaxServices.AjaxWarehouse.ChoosingCheckGrn('-1', userName, warehouseCheckOrderId);
        //            if (selAll.error != null) {
        //                alert(selAll.error.Message);
        //                return;
        //            }
        //        }
        //    }

        //});

        var getJQTableLanguage = function () {
            return {
                //"lengthMenu": "Display _MENU_ records per page",
                "zeroRecords": "没有符合的结果",
                "info": "显示第 _PAGE_ 页,共 _PAGES_ 页",
                "infoEmpty": "",
                "search": "综合搜索:",
                "infoFiltered": "(从 _MAX_ 条记录中查询)",
                "paginate": {
                    "first": "首页",
                    "last": "尾页",
                    "next": "后一页",
                    "previous": "前一页"
                }
            };

        }

        //获取系统规则的盘点单号
        $("#btnGetOrderSN").on('click',
            function () {
                $("#txtCheckOrder").val(getOrderSn());
            });
        var getOrderSn = function () {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxWarehouse.GenerateOrderSN();
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return '';
            }
            return (ajax.value);
        }

        //点击物料选择，渲染iframe内容
        var IsFirstClick = 0;
        $("#tabChooseMaterial").on('click',
            function () {
                //if ($("#hfRenderFlag").val() === '-1') {
                //    $("#hfRenderFlag").val(genTempTable());//生成临时表
                //}
                if (IsFirstClick == 0) {
                    IsFirstClick = 1;
                    var iframe1 = document.getElementById("frmToChooseList");
                    iframe1.src = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + '/MaterialCheck/CheckListToChoose.aspx?OrderID=<%= Request.QueryString["ID"] %>';
                    if (iframe1.attachEvent) {
                        iframe1.attachEvent("onload", function () {
                            $("#loadingmessages1").html("");
                        });
                    }
                    else {
                        iframe1.onload = function () {
                            $("#loadingmessages1").html("");
                        };
                    }
                   /* var iframe2 = document.getElementById("frmCheckingList");

                  /*  if (iframe2.attachEvent) {
                        iframe2.attachEvent("onload", function () {
                            $("#loadingmessages2").html("");
                        });
                    }
                    else {
                        iframe2.onload = function () {
                            $("#loadingmessages2").html("");
                        };
                    }*/
                }

            });

            var CheckGRNDetail = []; //存储数据
            var grn = "";
            var strGRNs;
            var barCode = "";
            var itemCode = "";
            var itemDesc = "";
            var RowId = 0;
            var arr = "";
            function btnChooseOnClick(index) {

                if (index == 0) {
                    /* document.frames[0]写法只有IE opera 支持 chenglong.zhu 2016-11-21 */
                    strGRNs = window.frames[0].window.getSelectedValues();
                    //获取选中的GRN,移除选中的GRN，选中的GRN填充到右边
                    var checkStr = "";
                    window.frames[0].window.$("input[name='chkSelect']:checked").each(function () { // 遍历选中的checkbox
                        RowId = $(this).parent().next().text();//取得第2列的值 行号
                        barCode = $(this).parent().next().next().text();//获取3列 仓库barCode
                        itemCode = $(this).parent().next().next().next().text();//4列 产品编码
                        itemDesc = $(this).parent().next().next().next().next().text();//4列 产品编码
                        grn = $(this).parent().next().next().next().next().next().text();
                        CheckGRNDetail.push({ "GRN": grn, "BarCode": barCode, "ItemCode": itemCode, "ItemDesc": itemDesc, "RowId": RowId });
                        window.frames[0].window.$("tr[id='" + grn + "']").remove();
                    });
                    showRight(index);
                }
                else {
                    /* document.frames[0]写法只有IE opera 支持 chenglong.zhu 2016-11-21 */
                    //userIdString = document.frames[1].window.getSelectedValues();
                    strGRNs = window.frames[1].window.getSelectedValues();
                    window.frames[1].window.$("input[name='chkSelect']:checked").each(function () { // 遍历选中的checkbox
                        RowId = $(this).parent().next().text();//取得第2列的值 行号
                        barCode = $(this).parent().next().next().text();//获取3列 仓库barCode
                        itemCode = $(this).parent().next().next().next().text();//4列 产品编码
                        itemDesc = $(this).parent().next().next().next().next().text();//4列 产品编码
                        grn = $(this).parent().next().next().next().next().next().text();
                        CheckGRNDetail.push({ "GRN": grn, "BarCode": barCode, "ItemCode": itemCode, "ItemDesc": itemDesc, "RowId": RowId });
                        window.frames[1].window.$("tr[id='" + grn + "']").remove();
                    });
                    //获取数据
                    showRight(index)
                }

                if (strGRNs == "") {
                    alert("<%= Resources.Messages.RequireOperateRecord %>");
                    return false;
                }

                //显示在右边
                /*增加选中的GRN*/
                if (index == 0) {
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxWarehouse.ChoosingCheckGrn(strGRNs, userName, warehouseCheckOrderId);
                    if (ajax.error != null) {
                        alert(ajax.error.Message);
                        return;
                    }

                }
                /* else {
                     var ajax = SKT.LeanMES.Web.AjaxServices.AjaxWarehouse.DeleteChoosingGrn(strGRNs, userName, -1);
                     if (ajax.error != null) {
                         alert(ajax.error.Message);
                         return;
                     }
                 }
    
               //  window.frames[0].window.document.forms[0].submit();
                 window.frames[1].window.document.forms[0].submit();*/
            }

            function genTempTable() {
                //if ($("#hfRenderFlag").val() !== '-1' ) return false;
                var mList = arrItemId.join(','); //绑定可选物料信息            

                //生成GRN选择情况状态临时表
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxWarehouse.getWarehouseCheckSnap(warehouseCheckOrderId, userName, mList);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return '';
                }
                //$("#hfRenderFlag").val('1');
                return '1'
            }

            function showRight(index) {
                var htmlstr = "";
                if (CheckGRNDetail != null && CheckGRNDetail.length > 0) {
                    for (var i = 0; i < CheckGRNDetail.length; i++) {
                        if (i % 2 == 0) {
                            htmlstr += "<tr class='ListTableEvenRow'  id=" + CheckGRNDetail[i].GRN + ">";
                        }
                        else {

                            htmlstr += "<tr class='ListTableOddRow' id=" + CheckGRNDetail[i].GRN + ">";
                        }
                        htmlstr += "<td><input type='checkbox' id='checkBox'" + CheckGRNDetail[i].GRN + "'' name ='chkSelect'  "
                               + " value =" + CheckGRNDetail[i].GRN + " /></td>"
                               + "<td>" + CheckGRNDetail[i].RowId + "</td>"
                               + "<td>" + CheckGRNDetail[i].BarCode + "</td>"
                               + "<td>" + CheckGRNDetail[i].ItemCode + "</td>"
                               + "<td>" + CheckGRNDetail[i].ItemDesc + "</td>"
                               + "<td>" + CheckGRNDetail[i].GRN + "</td>"
                        + "</tr>";
                    }
                }
                if (index == 0) {
                    window.frames[1].window.$("#tbBuyOrderDetail").append(htmlstr);
                    CheckGRNDetail = [];
                }
                else {
                    window.frames[0].window.$("#tbBuyOrderDetail").append(htmlstr);
                    CheckGRNDetail = [];
                }
            }

            //全部加入
            function btnChooseAll() {
                //填充左边的数据 遍历所有的表数据 填充
                window.frames[0].window.$("#tbBuyOrderDetail tbody tr").each(function () {
                    var a = $(this).children();//获取每一行
                    RowId = a[1].innerText;//取得第2列的值 行号
                    barCode = a[2].innerText;//获取3列 仓库barCode
                    itemCode = a[3].innerText;//4列 产品编码
                    itemDesc = a[4].innerText;//4列 产品编码
                    grn = a[5].innerText;
                    CheckGRNDetail.push({ "GRN": grn, "BarCode": barCode, "ItemCode": itemCode, "ItemDesc": itemDesc, "RowId": RowId });
                    window.frames[0].window.$("tr[id='" + grn + "']").remove();
                });
                showRight(0);
            }

            //全部移除
            function btnRemoveAll() {
                //填充左边的数据 遍历所有的表数据 填充
                window.frames[1].window.$("#tbBuyOrderDetail tbody tr").each(function () {
                    var a = $(this).children();//获取每一行
                    RowId = a[1].innerText;//取得第2列的值 行号
                    barCode = a[2].innerText;//获取3列 仓库barCode
                    itemCode = a[3].innerText;//4列 产品编码
                    itemDesc = a[4].innerText;//4列 产品编码
                    grn = a[5].innerText;
                    CheckGRNDetail.push({ "GRN": grn, "BarCode": barCode, "ItemCode": itemCode, "ItemDesc": itemDesc, "RowId": RowId });
                    window.frames[1].window.$("tr[id='" + grn + "']").remove();
                });
                showRight(1);
            }
    </script>



</asp:Content>
