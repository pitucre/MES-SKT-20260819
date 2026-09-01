<%@ Page Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="true"
    CodeBehind="ConfirmCryMaterial.aspx.cs" Inherits="SKT.LeanMES.Web.Product.ConfirmCryMaterial" %>

<asp:Content ID="Content2" ContentPlaceHolderID="viewcontent" runat="server">
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label4">
                线别
            </td>
            <td class="Field4">
                <asp:TextBox ID="txtResource" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
                <input id="button2" class="ButtonBox" type="button" onclick="selectResourceList()"
                    value="..." title="选择资源" />
                <asp:HiddenField ID="hdnResourceId" runat="server" Value="" ClientIDMode="Static" />
            </td>
            <td class="Label4">
                工位
            </td>
            <td class="Field4">
                <asp:TextBox ID="txtStation" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
                <input id="button1" class="ButtonBox" type="button" onclick="selectStationList()"
                    value="..." title="选择资源" />
                <asp:HiddenField ID="hdnStationId" runat="server" Value="" ClientIDMode="Static" />
            </td>
            <td class="Label4">
                工单
            </td>
            <td class="Field4">
                <input type="text" id="txtMoCode" class="TextBox" />
                <input id="button4" class="ButtonBox" type="button" onclick="selectMoallocateList()"
                    value="..." title="选择生产订单号" />
                <input id="hdnMoId" type="hidden" value="-1000" />
                <input id="hdnProductId" type="hidden" />
            </td>
            <td class="Label4">
                物料编码
            </td>
            <td class="Field4">
                <input type="text" id="txtItemCode" class="TextBox" />
            </td>
        </tr>
        <tr>
            <td class="Label4">
                开始时间
            </td>
            <td class="Field4">
                <input type="text" id="txtDateTimeStart" class="DateTimeBox" />
            </td>
            <td class="Label4">
                结束时间
            </td>
            <td class="Field4">
                <input type="text" id="txtDateTimeEnd" class="DateTimeBox" />
            </td>
            <td class="Label4">
                状态
            </td>
            <td class="Field4">
                <select id="selStates">
                    <option value="-1">所有</option>
                    <option value="0">未确认</option>
                    <option value="1">已确认</option>
                </select>
            </td>
            <td class="Label4">
                刷新时间
            </td>
            <td class="Field4">
                <select id="selTime" style="padding-top:-12px">
                    <option value="1" selected="selected">1分钟</option>
                    <option value="2">2分钟</option>
                    <option value="3">3分钟</option>
                    <option value="4">4分钟</option>
                    <option value="5">5分钟</option>
                    <option value="6">6分钟</option>
                    <option value="7">7分钟</option>
                    <option value="8">8分钟</option>
                    <option value="9">9分钟</option>
                </select>
                <%--<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" style="height:20px;" onclick="SaveRefreshTime();">保存</a>--%>
            </td>
        </tr>
        <tr>
            <td class="Label4" colspan="8" align="center" style="text-align: center">
                <input type="button" id="btnQuery" value="查 询" onclick="Query(-1)" />
                <input type="button" id="Button3" value="未确认" onclick="Query(0)" />
                <input type="button" id="Button5" value="已确认" onclick="Query(1)" />
            </td>
        </tr>
    </table>
    <div class="clear5">
    </div>
    <div class="ListTableTitle">
        <div style="position: absolute; left: 10px; top: 5px; line-height: 18px;">
            叫料看板信息
        </div>
    </div>
    <div id="divItemTypeInfo" style="width: 100%">
    </div>
    <%--<script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.printer.js"></script>--%>
    <link href="../Content/plugin/jquery-easyui-1.4.2/themes/default/easyui.css" rel="stylesheet"
        type="text/css" />
    <link href="../Content/plugin/jquery-easyui-1.4.2/themes/icon.css" rel="stylesheet"
        type="text/css" />
    <%--<script src="../Content/plugin/jquery-easyui-1.4.2/jquery.min.js" type="text/javascript"></script>--%>
    <script src="../Content/plugin/jquery-easyui-1.4.2/jquery.easyui.min.js" type="text/javascript"></script>
    <script src="../Content/plugin/jquery-easyui-1.4.2/layer/layer.js" type="text/javascript"></script>
    <script type="text/javascript">
        var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
        var strShow = "";
        var isEnter = false;
        var iCount = null;
        //初始方法
        $(function () {
            //GetRefreshTime();//获取设置刷新时间
            GetCryMaterialInfo("", "", "", "", "", "", "0", "", "");
            var setTime = ($("#selTime").val() *60* 1000);
            window.setInterval("GetCryMaterialInfo('', '', '', '', '', '', '0', '', '');", setTime); //加载定时器
        });
        //#region 查询按钮事件
        function Query(type) {
            //clearInterval(iCount);
            var ItemTypeCode = ""; //$("#txtItemTypeCode").val();//物料分类编码
            var ItemTypeName = ""; //$("#txtItemTypeName").val();//物料分类名称
            var Station = $("#txtStation").val();   //工位
            var Resource = $("#txtResource").val(); //线别
            var MoCode = $("#txtMoCode").val(); //工单
            var ItemCode = $("#txtItemCode").val(); //产品代码
            var States = type; //$("#selStates").val(); //状态
            var DateTimeStart = $("#txtDateTimeStart").val(); //开始时间
            var DateTimeEnd = $("#txtDateTimeEnd").val(); //结束时间

            $('#divItemTypeInfo').datagrid('load', {
                type: "GetCryMaterialInfo",
                ItemTypeCode: ItemTypeCode,
                ItemTypeName: ItemTypeName,
                StationId: Station,
                ResourceId: Resource,
                MoCode: MoCode,
                ItemCode: ItemCode,
                States:States,
                DateTimeStart: DateTimeStart,
                DateTimeEnd: DateTimeEnd
            });
            //清除选中状态
            $('#divItemTypeInfo').datagrid('clearSelections');
            //var setTime = ($("#selStates").val() * 1000);
            //iCount = setInterval(function () { Query("", "", "", "", "", "", "0", "", ""); }, setTime);
        }
        //#endregion

        //#region 查询物料类型信息
        function GetCryMaterialInfo(ItemTypeCode, ItemTypeName, StationId, ResourceId, MoCode, ItemCode, States, DateTimeStart, DateTimeEnd) {
            //var ajax = SKT.LeanMES.Web.AjaxServices.AjaxProduct.GetCryMaterialInfo(ItemTypeCode, ItemTypeName, StationId, ResourceId).value;

            $('#divItemTypeInfo').datagrid({
                height: $(window).height() - 175,
                url: '../Handler/MenCallMaterial.ashx', //查询数据地址
                queryParams: { type: "GetCryMaterialInfo", ItemTypeCode: ItemTypeCode, ItemTypeName: ItemTypeName, StationId: StationId, ResourceId: ResourceId,
                    MoCode: MoCode, ItemCode: ItemCode, States: States, DateTimeStart: DateTimeStart, DateTimeEnd: DateTimeEnd
                },
                striped: true,
                //fit:true,
                fitColumns: false,
                singleSelect: false, //多选
                rownumbers: true,  //显示行号
                pagination: true, //分页
                nowrap: false,
                width: '100%',
                showFooter: true,
                loadMsg: '加载中，请稍候…',
                pageSize: 10,
                pageList: [10, 20, 50, 100, 150, 200],
                idField: 'RECORDID',
                columns: [[{ field: 'STATES', title: '', width: 15, align: 'left',
                    formatter: function (value, row, index) {   //格式化函数添加一个操作列
                        var str = '';
                        if (row.STATES == '0' || row.STATES == '4') { //0，待送料，1，待接收，2，已接收，3已取消, 4，备料中
                            str = '<a href="#" style ="height:23px;color:red;font-size:20px">▊</a>';
                        } else {
                            str = '<a href="#" style ="height:23px;color:blue;font-size:20px">▊</a>';
                        }
                        return str;
                    }
                },
                    { field: 'ck', checkbox: true },
                    { field: 'LINENAME', title: mesLang('产线'), width: 65, align: 'left' },
                    { field: 'STATION', title: mesLang('工序'), width: 80, align: 'left' },
                    { field: 'OrderNO', title: mesLang('工单'), width: 160, align: 'left' },
                    { field: 'MOCODE', title: mesLang('物料编码'), width: 140, align: 'left' },
                    { field: 'ITEMNAME', title: mesLang('物料名称'), width: 280, align: 'left' },
                    { field: 'QTY', title: mesLang('需求数量'), width: 60, align: 'left' },
                    { field: 'OUTQTY', title: mesLang('配送数量'), width: 70, align: 'left', editor: 'numberbox' },
                    { field: 'SUMQTY', title: mesLang('累计数量'), width: 60, align: 'left' },
                    { field: 'CREATEBY', title: mesLang('叫料人'), width: 60, align: 'left' },
                    { field: 'CREATEDATETIME', title: mesLang('叫料时间'), width: 80, align: 'left' },
                    { field: 'RequireTime', title: mesLang('需求时间'), width: 80, align: 'left' },
                    { field: 'CONFIRMTIME', title: mesLang('送料时间'), width: 80, align: 'left' },
                    { field: 'StateDesc', title: mesLang('状态描述'), width: 80, align: 'left' }
                         ]],
                onLoadError: function (XMLHttpRequest, textStatus, errorThrown) {
//                    alert(XMLHttpRequest.responseText)
//                    alert(XMLHttpRequest.status);
//                    alert(XMLHttpRequest.readyState);
//                    alert(textStatus);
                },
                onLoadSuccess: function (data) {
                    if (data.total == 0) {
                        //当没有记录时提示没有记录信息
                        //$(this).datagrid('appendRow', { LINENAME: '<div style="text-align:center;color:red">没有相关记录！</div>' }).datagrid('mergeCells', { index: 0, field: 'LINENAME', colspan: 13 });
                    }
                    var thisGeid = this;
                    $.each(data.rows, function (index, item) {
                        if (item.STATES == 0 || item.STATES == 4) {
                            $(thisGeid).datagrid('beginEdit', index);
                        }
                    });
                },
                onDblClickRow: function (index, row) {
                    //双击事件
                    //Edit();
                }
            });
            //#region 格式化分页提示
            var p = $('#divItemTypeInfo').datagrid('getPager');
            $(p).pagination({
                beforePageText: '第', //页数文本框前显示的汉字           
                afterPageText: '页    共 {pages} 页',
                displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录'
            });
            //#endregion
            //清除选中状态
            $('#divItemTypeInfo').datagrid('clearSelections');
        }
        //#endregion

        //#region 确认叫料信息
        function ConfirmCryItem() {
            var idStr = "";
            var strSign = true;
            var bSign = true;
            var list = [];
            var rows = $('#divItemTypeInfo').datagrid('getSelections');
            if (!rows[0]) {
                alert("请点选对应记录");
                return false;

            }
            if (rows[0].LINENAME.indexOf("没有相关记录") >= 0) {
                return false;
            }
            for (var i = 0; i < rows.length; i++) {
                var entity = {};
                idStr += rows[i].RECORDID + ","; //主键ID
                var rowIndex= $('#divItemTypeInfo').datagrid('getRowIndex', rows[i]);
                var ed = $('#divItemTypeInfo').datagrid('getEditor', { index: rowIndex, field: 'OUTQTY' });
                if (ed != null) {
                    var value = $(ed.target).numberbox('getValue'); //配送数量
                    if (value.length > 10) {
                        alert('配送数量超出限制');
                        return false;
                    }
                } 
                entity.RecordID = rows[i].RECORDID;
                entity.OutQty = value;
                list.push(entity);

                if (value == "" || value=="0") {
                    bSign = false;
                }

                if (rows[i].STATES == "1") {
                    strSign = false;
                }
            }
            if (idStr == "") {
                alert("请先选择要确认的叫料信息！");
                return false;
            }


            if (strSign == false) {
                alert("已确认叫料的信息无须继续确认！");
                return false;
            }

            if (bSign == false) {
                alert("请输入配送数量！");
                return false;
            }

            //if (confirm('确定要删除吗？')) {

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxProduct.ConfirmCryMaterialInfo(list);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            //layer.msg('<font style="font-weight:bold;color:Green;font-size:20px;">确认成功</font>', { icon: 1 });
            alert("确认成功");
            Query(0);
            //}
        }
        //#endregion

        //#region 选择工位
        function selectStationList() {
            var sqlwhere = "";
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=8&PageCondition=" + sqlwhere + "&Multiple=false&CallBackFunc=setStation&rnd=" + Math.random(), width: 680, height: 350 });
        }
        function setStation(list) {
            var Station = list[0][1];
            if (list[0][0] == "-1") {
                whCodes = "";
            }
            $("#<%=this.txtStation.ClientID %>").val(Station);
            $("#hdnStationId").val(list[0][0]);
        }
        //#endregion

        //#region 选择产线
        function selectResourceList() {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=21&Multiple=false&CallBackFunc=setResource&rnd=" + Math.random(), width: 680, height: 350 });
        }
        function setResource(list) {
            var Resource = list[0][1];
            if (list[0][0] == "-1") {
                whCodes = "";
            }
            $("#<%=this.txtResource.ClientID %>").val(Resource);
            $("#hdnResourceId").val(list[0][0]);
        }
        //#endregion

        //#region 选中生产工单
        function selectMoallocateList() {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>",
                src: "../Framework/ChoosePage.aspx?PageId=44&Multiple=false&rnd=" + Math.random(), width: 680, height: 350
            });
        }
        //工单返回的值
        function getChooseValue(list) {
            $("#txtMoCode").val(list[0][1]);
            $("#hdnMoId").val(list[0][0]);
        }

        //#endregion

        //#region 查询刷新时间
        function GetRefreshTime() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxProduct.GetRefreshime("叫料确认");
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var entity = ajax.value;
            $("#selTime").val(entity.Value);
        }
        //#endregion

        //#region 保存刷新时间
        function SaveRefreshTime() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxProduct.SaveRefreshTime("叫料确认", $("#selTime").val());
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            layer.msg('<font style="font-weight:bold;color:Green;font-size:20px;">保存成功</font>', { icon: 1 });
            location.reload();
        }
        //#endregion
        
    </script>
</asp:Content>
