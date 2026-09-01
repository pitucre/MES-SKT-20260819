<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/Masters.master" CodeBehind="RouterDesigns.aspx.cs" Inherits="SKT.LeanMES.Web.Router.RouterDesigns" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../Content/guant/platform.css" type="text/css">
    <link rel="stylesheet" href="../Content/guant/libs/jquery/dateField/jquery.dateField.css" type="text/css">
    <link href="../Content/plugin/dialog/skin/default/dialog-1.0.3.css" rel="stylesheet" type="text/css" />
    <script src="../Content/js/jquery.js"></script>
    <script src="../Content/plugin/layui/layui.all.js"></script>
    <link href="../Content/plugin/layui/css/layui.css" rel="stylesheet" />
    <script src="../Content/js/workflow.js?v=20220311"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/dialog/js/jPlugin-dialog-2.0.js?v=160624"
        type="text/javascript"></script>
    <style type="text/css">
        html, body {
            -moz-user-select: none;
            -webkit-user-select: none;
            -ms-user-select: none;
            user-select: none;
        }
         .toolBar {
            height: 27px;
            padding: 0px 0px 0px 0px;
            margin: 0px 0px 2px 0px;
            background: url(../content/images/l_bg_hover.gif) repeat-x;
            position: relative;
            z-index: 1;
            width: 100%;
        }
        .panel_top {
            height: 40px;
            position: absolute;
            top: 25px;
            left: 0;
            right: 0;
            bottom: 0;
        }

        .panel_bottom {
            position: absolute;
            top: 30px;
        }

        .panel_left {
            left: 0;
            bottom: 0;
            width: 150px;
            overflow: hidden;
        }

        .panel_center {
            left: 150px;
            bottom: 0;
            width: 200px;
            overflow-x: hidden;
            border-left: 1px solid #ddd;
            border-right: 1px solid #ddd;
            overflow: hidden;
        }

        .panel_right {
            right: 0;
            bottom: 0;
            left: 350px;
            width:auto;
            overflow: auto;
            background-image: url(../Content/images/gooflow_blank2.gif);
            border-top: 1px solid #ddd;
            border-left: 1px solid #ddd;
        }
        .full_screen {
            width: 100%;
            left: 0px;
        }

        .panel_bottom .p_b_title {
            /*background: #23b7e5;*/
        }

            .panel_bottom .p_b_title input {
                /*background: none;
            border: none;
            color: #fff;*/
                border: 1px solid #ddd;
                height: 35px;
                padding-left: 10px;
            }

                .panel_bottom .p_b_title input:last-of-type {
                    border-left-width: 0;
                }

        .panel_bottom .p_b_content {
            position: absolute;
            top: 35px;
            bottom: 0;
            right: 0;
            left: 0;
            overflow-x: hidden;
            overflow-y: auto;
        }

            .panel_bottom .p_b_content div {
                padding: 0 5px;
                line-height: 35px;
                overflow: hidden;
                text-overflow: ellipsis;
                white-space: nowrap;
                height:35px;
            }

        .panel_center .p_b_content div:hover {
            background: #ddd;
            color: Green;
            font-size:13px;
        }

        .panel_left .p_b_content div:hover {
            cursor: pointer;
            color: Green;
            font-size:13px;
            text-decoration:underline;
        }

        .p_b_content .p_b_c_selected {
            color: Green;
            font-size:13px;
            text-decoration:underline;
        }
        .p_b_content .p_b_c_item {
            border-bottom:1px #D3D3D3 solid;
            border-right:1px #D3D3D3 solid;
        }
        .p_b_content .p_b_c_item_bg {
            background-color:#ECEFF1;
        }

        .panel_center .p_b_content div {
            cursor: move;
        }
        .panel_center .p_b_content div img{
            width:32px;
            height:32px;
            float:left;
            margin-right:5px;
        }
        
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   


        <%--<div class="panel_top">
            <div class="layui-layer-btn layui-layer-btn-">
                <a class="layui-layer-btn0" style="cursor: crosshair;" id="btnLine">连接线</a>
                <a class="layui-layer-btn0" id="btnSave" style="display:none;">保存</a>
            </div>
        </div>--%>
        <div class="panel_bottom panel_left">
            <div class="p_b_title">
                <input type="text" placeholder="<%=Resources.lang.StationType %>" stype="0" />
            </div>
            <div class="p_b_content" id="div_stationType">
                <div stid="" class="p_b_c_item"><span>全部</span></div>
                <%=InitOperationType() %>
            </div>
        </div>

        <div class="panel_bottom panel_center">
            <div class="p_b_title">
                <input type="text" placeholder="<%=Resources.lang.Process %>" style="width:200px" />
            </div>
            <div class="p_b_content" id="div_station">
                <%=InitOperationStaiton() %>
            </div>
        </div>

        <div class="panel_bottom panel_right" id="Workflow"></div>
 
    <script type="text/javascript">
        var r_id = -1;
        var r_name = "";
        var stations = null;
        var wf =null;
        $(function () {
            r_id = '<%=Request.QueryString["R_Id"] %>';
            if (r_id == -1) {
                r_name = "<%=Resources.lang.SelectNullRouter %>";
            }
            else {
                r_name = decodeURI('<%= Request.QueryString["R_Name"] %>');
            }
             //设置tab名称
            window.parent.getCurrentTab().text(r_name + " [<%=Resources.Pages.Router_RouterDesign %>]");
            //window.parent.showLeftMenu();
            stations = <%=InitOperationStaitonJson()%>;
            $(".p_b_title input").keyup(function () {
                var val=$(this).val().toLowerCase();
                var nodes;
                if($(this).attr("stype")=="0"){
                    $("#div_stationType .p_b_c_selected").removeClass("p_b_c_selected");
                    nodes=  $("#div_stationType div[stid]");
                }else {
                    var stid =$("#div_stationType .p_b_c_selected").attr("stid");
                    if (stid)
                        nodes=  $("#div_station div[stid='" + stid + "']");
                    else
                        nodes=   $("#div_station div[stid]");
                }
                if(val){
                    nodes.each(function () {
                        if($(this).text().toLowerCase().indexOf(val)>-1)
                            $(this).show();
                        else
                            $(this).hide();
                    });
                }else {
                    nodes.show();
                }
            });
            //点击工序分类筛选工序
            $("#div_stationType div").click(function () {
                $("#div_stationType .p_b_c_selected").removeClass("p_b_c_selected");
                $(this).addClass("p_b_c_selected");
                $("#div_station div[stid]").hide();
                var stid = $(this).attr("stid");
                if (stid)
                    $("#div_station div[stid='" + stid + "']").show();
                else
                    $("#div_station div[stid]").show();
            });
            $("#div_stationType div:first").click();

            //初始化路由设计器
            initLayout();

            //添加项
            $("#div_station div").mousedown(function (e) {
                var item=null;
                var val = $(this).attr("sid");
                for (var i = 0; i < stations.length; i++) {
                    if (stations[i].StationId == val) {
                        item = {
                            mode:"条码模式",
                            text: stations[i].Station,
                            value: stations[i].StationId
                        };
                        break;
                    }
                }
                wf.dragItem(e,item,function (items) {
                    for (var i = 0; i < items.length; i++) {
                        if (items[i].type == "rect" && items[i].value ==item.value) {
                            layer.open({ content: '工序已存在' });
                            return null;
                        }
                    }
                    return {};
                });
            });
        });

    function ConfigOperation(operationId, operationName) {
        /*判断站位是否保存到路由中*/
        var ajax1 = SKT.LeanMES.Web.AjaxServices.AjaxRouter.OperationIsInRouter(operationId, r_id);
        if (ajax1.error != null) {
            alert(ajax1.error.Message);
            return false;
        }
        var _operationIsInRouter = ajax1.value;
        if (!_operationIsInRouter) {
            alert("请先保存路由！");
            return false;
        }

        var ajax2 = SKT.LeanMES.Web.AjaxServices.AjaxSDP.CheckStationHasModel(operationId);
        if (ajax2.error != null) {
            alert(ajax2.error.Message);
            return false;
        }
        var operationhasmodel = ajax2.value;
        if (operationhasmodel == "False") {
            alert("工序上没有绑定绑定新模板或者绑定的是系统模板,如果需要设置,请使用'系统管理->客户端管理->站位权限配置'功能进行绑定自定义模板！");
            return false;
        }
        if (operationhasmodel == "Defualt") {
            /*打开Activity配置窗口*/
            var openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Router/RouterActivity.aspx?name=Router_RouterActivity&RouterID=" + r_id + "&OperationID=" + operationId + "&RouterName=" + r_name + "&OperationName=" + operationName;
            dialog({ title: "<%=Resources.Pages.Router_RouterActivity %>", src: (openWinUrl), width: 650, height: 470, onClosed: "toggleObject" });
        }
        else {                 
            var openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SDP/RouteFunctionSetting.aspx?RouterID=" + r_id + "&OperationID=" + operationId;
            dialog({ title: "<%=Resources.Pages.Router_RouterActivity %>", src: (openWinUrl), width: 850, height: 550, onClosed: "toggleObject" });
        }
    }

    //新增路由信息回写
    function setBaseValue(rid, rname) {
        r_id = rid;
        r_name = rname;
        window.parent.getCurrentTab().text(r_name + " [<%=Resources.Pages.Router_RouterDesign %>]");
    }

    function Save(){
        if (r_id == -1) {   //新增路由信息
            alert("<%=Resources.Messages.SaveRouterBaseInfoFirst %>");

            var openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Router/RouterEdit.aspx?name=Router_RouterAdd&ID=-1&From=other";
            dialog({ title: "<%=Resources.Pages.Router_RouterAdd %>", src: openWinUrl, width: 650, height: 350, onClosed: "toggleObject" });
            return;
        }
        setTimeout(function () {
            saveCore();
        }, 10);
    }

    function saveCore(){
        var items= wf.getItems();
        var array = [];
        var ids="";
        var data;
        var exists_endline=false;
        var linkString = "", seq1 = ",", seq2 = "^", linkStatus = "";
        for (var i = 0; i < items.length; i++) {
            if (items[i].type == "line") {
                data={
                    R_ID:r_id,
                    Incoming_OpeID:wf.getItem(items[i].from).value,
                    Outgoing_OpeID:wf.getItem(items[i].to).value,
                    StatusId:parseInt(items[i].status)
                };
                array.push(data);

                linkString += wf.getItem(items[i].from).value + seq1 +wf.getItem(items[i].to).value + seq1 + parseInt(items[i].status) + seq1;
                linkString += seq2;
                if (data.Outgoing_OpeID=='-20')
                    exists_endline=true;
            }else if (items[i].type == "rect") {
                if(ids!="")
                    ids+=",";
                ids+=items[i].value;
            }
        }
        if (!exists_endline) {
            layer.open({ content: '没有指向结束流程' });
            return;
        }
        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxRouter.UpdateLayoutNew(r_id, JSON.stringify(items), linkString);
        if (ajax.error == null) {
            TogglePoints(false);
            alert("<%=Resources.Messages.SaveInSuccess %>");
        } else {
            alert(ajax.error.Message);
        }
    }

    //显示或隐藏连线点
    function TogglePoints(isShow){
        wf.togglePoints(isShow);
    }

    //载入路由
    function LoadRouter() {
        dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=22&Multiple=false&rnd=" + Math.random(), width: 600, height: 350});
    }

    function getChooseValue(list) {
        if (parseInt(list[0][0]) == -1) {
            return;
        }

        //init data
        r_id = parseInt(list[0][0]);
        r_name = list[0][1];
        //设置tab名称
        window.parent.getCurrentTab().text(r_name + " [<%=Resources.Pages.Router_RouterDesign %>]");
        //初始化路由设计器
        initLayout();
    }
    //初始化路由设计器
    function initLayout(){
        var routerInfo = r_id == -1 ? null :GetRouterInfo(r_id);
        var datas=[];
        var pointDirectionNum = 4;
        if (routerInfo) {
            //处理新的数据
            if(routerInfo.RouterJson){
                var newData = JSON.parse(routerInfo.RouterJson);
                if(newData && newData.length >0){
                    for (var i = 0; i < newData.length; i++) {
                        if (newData[i].type != "rect" || newData[i].value < 1)
                            continue;
                        newData[i].stroke = "#00f" ;
                    }
                    datas = newData;
                }
            }
            //转换旧的数据
            if(datas.length == 0 && routerInfo.R_JSON){
                //处理单引号问题
                routerInfo.R_JSON = routerInfo.R_JSON.replace(/'/g,"\"");
                var oldData = JSON.parse(routerInfo.R_JSON);
                var newData =[];    //转换后的数据
                var id =1;
                if(oldData && oldData.OperationNode){
                    //处理流程节点
                    for(var i=0;i<oldData.OperationNode.length;i++){
                        var node = oldData.OperationNode[i];
                        newData.push({
                            "id": id,
                            "type": "rect",
                            "x": node.LocX,
                            "y": node.LocY,
                            "text": node.OperationName,
                            "value": node.OperationID
                        });
                        //更新连线的ID
                        for(var j=0;j<oldData.Link.length;j++){
                            var line = oldData.Link[j];
                            if(node.OperationID == line.FromNode){
                                line.FromNodeNew = id;
                            }
                            if(node.OperationID == line.ToNode){
                                line.ToNodeNew = id;
                            }
                        }
                        id++;
                    }
                    //处理连线
                    for(var i=0;i<oldData.Link.length;i++){
                        var line = oldData.Link[i];
                        var fromPort = line.FromPort -10000 +1;
                        var toPort = line.ToPort -10000 +1;
                        newData.push({
                            "id": id, 
                            "type": "line", 
                            "status": line.IsPass == "Pass"? 1:0, 
                            "from": line.FromNodeNew, 
                            "from_point_num":Math.round((fromPort/8) * pointDirectionNum),       //默认左边靠中间的连接点
                            "to_point_num":Math.round((toPort/8) * pointDirectionNum),         //默认右边靠中间的连接点
                            "to": line.ToNodeNew
                        });
                        id++;
                    }
                    datas = newData;
                }
            }
        }
        //默认添加开始和结束流程
        if(datas.length ==0){
            datas=[
                    { id: 1, type: "rect",  text: "结束", x: 300, y: 50, value: "-20" },
                    { id: 2, type: "rect",  text: "开始", x: 50, y: 50, value: "-10" }
            ];
        }
        var status=[
            {id:0,text:"Fail",color:"#f00"},
            {id:1,text:"Pass",color:"#0f0"}
        ];
        //初始化插件
        wf= new WorkFlow({
            items:datas,
            id:"Workflow",
            pointDirectionNum:pointDirectionNum,        
            //删除块前验证
            beforRemoverect:function (item) {
                if (item.value ==-10 || item.value == -20) {
                    layer.open({ content: '开始或结束流程不能删除' });
                    return false;
                }
                return true;
            },
            //创建新的线条
            newLine:function (item) {
                item.status=1;
                return true;
            },
            //获取线条的文字
            lineTextInfo:function (item) {
                for (var i = 0; i < status.length; i++) {
                    if(status[i].id==item.status){
                        return status[i];
                    }
                }
                return status[0];
            },
            //开始连线验证
            fromlinecheck:function (from,items) {
                if (from.value == "-20")
                    return false;
                return true;
            },
            //结束连线验证
            tolinecheck:function (from,to,items) {
                //判断线条是否有重复
                for (var i = 0; i < items.length; i++) {
                    if (items[i].type == "line" && items[i].from ==from.id && items[i].to == to.id)
                        return false;
                }
                //开始节点不能作为终点
                if (to.value == "-10")
                    return false;
                return true;
            },
            //线条中文字的点击事件
            lineTextClick:function (item,x,y,callback) {
                var str = "";
                for (var i = 0; i < status.length; i++) {
                    str += "<option" + (item.status == status[i].id ? " selected='selected'" : "") + " value='" + i + "'>" + status[i].text + "</option>"
                }
                $("<select>" + str + "</select>").css({
                    position: "absolute",
                    width: 60,
                    zIndex: 99999,
                    left:x - 20,
                    top: y - 12
                }).change(function () {
                    item.status = Number($(this).val());
                    for (var i = 0; i < status.length; i++) {
                        if(item.status == status[i].id)
                        {
                            callback(status[i]);
                            break;
                        }
                    }
                    $(this).remove();
                }).appendTo($("#Workflow"));
            },
            //块的双击事件
            dblclickrect:function (item,callback) {
                //开始和结束不允许编辑
                if (!isNaN(item.value) && parseInt(item.value) <= 0)
                    return;

                ConfigOperation(item.value,item.text);
                  
            }
        });
    }
    //获取矩形颜色
    function getrectcolor(mode) {
        return mode == "条码模式" ? "#00f" : "#000";
    }
    //获取路由数据
    function GetRouterInfo(rid) {
        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxRouter.GetLayout(rid);
        if (ajax.error == null) {
            if (ajax.value != "") {
                return ajax.value;
            }

        } else {
            alert(ajax.error.Message);
        }
        return null;
    }
    
    //切换设计画布全屏
    function FullScreen(){
        var $canvesDiv = $("#Workflow");
        var isFullScreen = $canvesDiv.hasClass("full_screen");
        if(isFullScreen){
            $canvesDiv.removeClass("full_screen");
        }
        else{
            window.parent.showLeftMenu(true);
            $canvesDiv.addClass("full_screen");
        }
    }

</script>
</asp:Content>

