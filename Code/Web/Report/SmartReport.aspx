<%@ Page Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="true"     
    EnableEventValidation="false"
    CodeBehind="SmartReport.aspx.cs"   Inherits="SKT.LeanMES.Web.Report.SmartReport"  ViewStateMode="Disabled" %>


<asp:Content ID="searchConditions" runat="server" ContentPlaceHolderID="viewcontent">

    <link href="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/zTree/css/zTreeStyle/zTreeStyle.css" rel="stylesheet" type="text/css" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/zTree/js/jquery.ztree.core.js" type="text/javascript"></script>
    
    <link href="../Content/plugin/treetable/stylesheets/jquery.treetable.css" rel="stylesheet" />
    <link href="../Content/plugin/treetable/stylesheets/jquery.treetable.theme.default.css" rel="stylesheet" />
    <script src="../Content/plugin/treetable/javascripts/jquery.treetable.js"></script>

    <link  href="../Content/plugin/jQueryTabeZsy/css/style.css" rel="stylesheet" />
    <script src="../Content/plugin/jQueryTabeZsy/js/table.js"></script>
    <script src="../Content/js/initPage.js"></script>
    <style>
        body,html { margin:0 auto; }
        #content { width:100%; overflow:auto;font-size:12px; }
        table{width:100%;border:1px solid #999;}
        table th,table td{word-break: keep-all;white-space:nowrap;}

   
        .group-box { clear:both; overflow:auto; padding:0 10px; padding-bottom:10px; margin:5px 0px 10px 0px; }

        .DataTypeTitle { font-weight:bold; }
        .BaseInfo-Group { margin-top:5px; padding:10px;border:1px solid #ddd;border-radius: 5px;box-shadow: 1px 1px 1px #ddd; overflow:hidden;  }
        .listItem { overflow:hidden; float:left; }
        .listItem .title { float:left;   /*overflow:hidden; text-align:right; width:100px;font-weight:bold;*/ }
        .listItem .value { float:left; padding-left:5px; overflow:hidden;}
        
        .pc .DataTypeTitle { display:none; }
        .pc .group-box { display:none; }
        .pc div.current { display:block;  }
        #SearchDiv { text-align:center; padding:5px; }
        #ParameterTable { margin-bottom:5px; }

        #spanPrompt { color:blue; cursor:pointer; }
        #tdDes { border:1px solid #d1d1d1; padding:5px; color:#980000; margin-bottom:5px; }
        #noData { font-size:14px; text-align:center; display:block; padding-top:30px; }
        #titleUL { display:none; }
        #titleUL li { margin-bottom:5px; border: 1px solid #CDCDCD;}
        .tb > li.current { line-height: 25px;}
        .Page-Box { margin-top:10px; }
    </style>

    <table  id="ParameterTable" class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2" style="width: 10%; border-left: 0px">
                请输入
            </td>
            <td class="Field2" style="width: 10%; border-left: 0px" >
              <input  id="Value" type="text" />  
                <input id="btnSearch" type="button" value="<%=Resources.lang.Search %>" class="SearchButton"
                    title="<%=Resources.lang.Search %>" onclick="Search()" />
            </td>
            
        </tr>
    </table>
    <div id="tdDes">
        
    </div>
        <div style="width:100%;">
            <div id="content" class="pc">
                <ul id='titleUL' class='tb' style="display:block">
                    <li>物料条码信息</li>
                    <li>采购信息</li>
                    <li>送货信息</li>
                    <li>IQC信息</li>
                    <li>IQC检验项目</li>
                    <li>AQL检验规则</li>
                    <li>入库信息</li>
                    <li>备料信息</li>
                    <li>供应商信息</li>
                    <li>SMT上料记录</li>
                    <li>SMT产品用料</li>
                    <li>工单信息</li>
                    <li>路由信息</li>
                    <li>老化信息</li>
                    <li>包装详细</li>
                    <li>检验单</li>
                    <li>生产历史</li>
                    <li>角色信息</li>
                    <li>产线信息</li>
                    <li>物料批次信息</li>
                    <li>物料批次条码</li>
                    <li>物料批次使用</li>
                    <li>出货信息</li>
                </ul>
            </div>
        </div>
     
  
    <script type="text/javascript" >

        var maxLenObj = null;
        var contentUI = "";
        /*绑定搜索按钮事件*/
        $(function () {
            contentUI = $("#content").html();
            $("#spanPrompt").bind("click",function () {
                var display = $("#tdDes").css("display");
                if (display == "none")
                {
                    $(this).html("隐藏提示");
                    $("#tdDes").css("display", "block");
                }
                else {
                    $(this).html("显示提示");
                    $("#tdDes").css("display", "none");
                }
            })

            var entity = {};
            var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("SmartReport_DataTypeList", JSON.stringify(entity));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return;
            }
            maxLenObj = $.parseJSON(ajax.value).data;
            var tdDesc = "提示：可以输入";
            for (var i = 0; i < maxLenObj.length; i++) {
                var DataTypeName = maxLenObj[i].DataTypeName;
                tdDesc += DataTypeName;
                if(i+1<maxLenObj.length)
                {
                    tdDesc += "、";
                }
                else
                {
                    tdDesc += "。";
                }
            }
            $("#tdDes").html(mesLang(tdDesc));

            //Wesley:2023-11-2
            //BUG:1319 智能查询功能优化
            //添加扫描框回车事件，但界面会刷新，没有效果，原因暂时不知道，尝试发布看看有没有效果
            $("#Value").keydown(
                function (e) {
                    var curKey = 0, e = e || window.event;
                    curKey = e.keyCode || e.which || e.charCode;
                    if (curKey == 13) {
                        $('#btnSearch').click();
                    }
                }
            );
        });

        function Search()
        {
            $("#content").html("<div  id='noData'>尚未查询出数据......</div><ul id='titleUL' class='tb'></ul>");
            var searchValue = $("#Value").val();
            for (var i = 0; i < maxLenObj.length; i++) {
                var DataTypeId = maxLenObj[i].DataType;
                ExistsData(DataTypeId, searchValue, -1);
            }
            if (searchValue == "") {
                $("#content").html(contentUI)
            }
        }

     
        function ExistsData(dataType, searchValue, UserId) {
            var entity = {};
            entity.DataType = dataType;
            entity.ScheduleValue = searchValue;
            entity.UserId = UserId;
            
            var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("SmartReport_ExistsData", JSON.stringify(entity));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return;
            }
            if (ajax.value != null) {
                var en = $.parseJSON(ajax.value);
                if (en.data.length > 0) {
                    var dataType = en.data[0].dataType;
                    var desc = en.data[0].desc;
                    $("#content").append("<div id='dataType-" + dataType + "'><div></div></div>");
                    LoadDataByDataType(dataType, searchValue)
                    
                }
            }
        }

        /*通过数据类型加载数据*/
        function LoadDataByDataType(dataType, searchValue) {
            var entity = {};
            entity.DataType = dataType;
            var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("SmartReport_TypeStoredProcedure", JSON.stringify(entity));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return;
            }
            if (ajax.value != null) {
                var en = $.parseJSON(ajax.value);
                for (var i = 0; i < en.data.length; i++) {
                    var divID = "dataType-" + dataType + "-" + i;

                    var storedProcedure = en.data[i].StoredProcedure;
                    var dataType = en.data[i].DataType;
                    var ShowType = en.data[i].ShowType;
                    var dataTitle = en.data[i].DataTitle;
                    var current = "";
                   
                    var currentObj = $("#titleUL").find(".current");
                    if (currentObj.length == 0)
                    {
                        current = "current";
                       
                    }
                    $("#titleUL").append("<li id='li-" + divID + "' class='" + current + "' sp='" + storedProcedure + "' onclick='liclick(this)' >" + dataTitle + "</li>");
                    $("#dataType-" + dataType).append("<div id='" + divID + "' class='group-box " + divID + "  " + current + "'><div class='DataTypeTitle'>" + dataTitle + "</div></div>");

                    GetDataContent(storedProcedure, divID, dataType, ShowType);
                }
            }
        }

        function liclick(obj) {
           
            var id = $(obj).attr("id");
            var divId = id.replace("li-", "");
            $(".group-box").removeClass("current");
            $("#" + divId).addClass("current");

            $("#titleUL").find("li").removeClass("current");
            $("#li-" + divId).addClass("current");

        }
        
        var page = 1;
        var size = 10;
        /*
        storedProcedure
        divID
        dataType
        */
        function GetDataContent(storedProcedure, divID, dataType, ShowType) {
            var postParameters = GetParameters();
            $.post("<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Handler/ReportHandler.ashx",
                     { SP: storedProcedure, Parameters: postParameters },
                     function (resultData) {
                         var json = eval('(' + resultData + ')');
                      
                         if (json.length == 0) {
                             $("#" + divID).empty().remove();
                             $("#li-" + divID).empty().remove();
                             return;
                         }
                         else {
                             $("#noData").css("display", "none");
                             $("#titleUL").css("display", "block");
                             
                         }

                         if (ShowType == "BaseInfo")
                         {
                             LoadDataToBaseInfo(divID, json);
                         }
                         else if (ShowType == "Table")
                         {
                            
                             LoadDataToTable(divID, json);
                         }
                         else if(ShowType=="Tree")
                         {
                             LoadDataToTree(divID, json);
                         }
                         else if (ShowType == "TreeTable") {
                             LoadDataToTreeTable(divID, json);
                         }

                         /*页面语言初始化*/
                         initPageLang();
                     })
        }

        /*加载数据到Tree*/
        function LoadDataToTreeTable(divID, data) {
            var headHtml = "<thead><tr>";
            if (data.length > 0) {
                for (var pName in data[0]) {
                    if (pName != "Id" && pName != "parentId" ) {
                        headHtml += "<th>" + pName + "</th>";
                    }
                }
            }
            headHtml += "</tr></thead>"
            var html = ' <table id="TreeTable-' + divID + '">' + headHtml + '</table>';
            //$("#" + divID).append("<div id='" + divID + "-Group' class='BaseInfo-Group'>" + html + "</div>");
            $("#" + divID).append(html);

            /*将树结构的数据排序，父子数据衔接在一起*/
            var orderData = GetGroupDataByParentId(data, 0);

            $.each(orderData, function (idx, obj) {
                var parentIdHtml = "";
                if (parseInt(obj.parentId) != 0)
                {
                    parentIdHtml = "data-tt-parent-id='" + obj.parentId + "'";
                }
                var trHtml = "<tr  data-tt-id='" + obj.Id + "' " + parentIdHtml + ">";
                for (var pName in obj) {
                    if (pName != "Id" && pName != "parentId" ) {
                        trHtml += "<td>" + obj[pName] + "</td>";
                    }
                }
                trHtml += "</tr>"
                $("#TreeTable-" + divID ).append(trHtml);
            });

            var option = {
                theme: 'vsStyle',
                expandable: true,
                beforeExpand: function ($treetable, id) {
                    //判断id是否已经有了孩子节点，如果有了就不再加载，这样就可以起到缓存的作用
                    if ($('.' + id, $treeTable).length) { return; }
                    //这里的html可以是ajax请求
                    var html = '<tr id="8" pId="6"><td>5.1</td><td>可以是ajax请求来的内容</td></tr>'
                             + '<tr id="9" pId="6"><td>5.2</td><td>动态的内容</td></tr>';

                    $treetable.addChilds(html);
                },
                onSelect: function ($treetable, id) {
                    window.console && console.log('onSelect:' + id);

                }
            };
            $("#TreeTable-" + divID).treetable(option);
        }

        /*将树结构的数据排序，父子数据衔接在一起*/
        function GetGroupDataByParentId(data,parentId)
        {
            var orderData = [];
            if(data.length>0)
            {
                for (var i = 0; i < data.length; i++)
                {
                    if(data[i].parentId==parentId)
                    {
                        orderData.push(data[i]);
                        var childData = GetGroupDataByParentId(data, data[i].Id);
                        if(childData.length>0)
                        {
                            for(var j=0;j<childData.length;j++)
                            {
                                orderData.push(childData[j]);
                            }
                        }
                    }
                }
            }
            return orderData;
        }

        /*加载数据到Tree*/
        function LoadDataToTree(divID, data) {
            /*创建Treetable表头*/
            var html = '<ul id="Tree-' + divID + '" class="ztree"></ul>';
            $("#" + divID).append("<div id='" + divID + "-Group' class='BaseInfo-Group'>" + html + "</div>");
            var zNodes =[];
            $.each(data, function (idx, obj) {
                var tdHtml = "";
                for (var pName in obj) {
                    if (pName != "Id" && pName != "parentId" && obj[pName]!="") {
                        tdHtml += pName+"："+obj[pName] + "；";
                    }
                }
                zNodes.push({ id: obj.Id, pId: obj.parentId, name: tdHtml, open: true })
            });
            var setting = {
                data: {
                    simpleData: {
                        enable: true
                    }
                }
            };
            $.fn.zTree.init($("#Tree-" + divID), setting, zNodes);

        }

        /*加载数据到BaseInfo*/
        function LoadDataToBaseInfo(divID, data) {
           
            $("#" + divID).append("<div id='" + divID + "-Group' class='BaseInfo-Group'></div>");
     
            var j = 0;
            for (var i = 0; i < data.length; i++) {
                var html = "";
                var j = 0;
                for (var paraName in data[j]) {
                    if (paraName != "Count") {
                        html += "<div class='listItem'><span class='title'>" + paraName + "：</span><span class='value'>" + data[i][paraName] + "</span></div>";
                        j++;
                    }
                }
                $("#" + divID + "-Group").append(html);
            }
            $("#" + divID).removeClass("group-box");
            /*页面语言初始化*/
            initPageLang();
            var MaxSize = 0;
            var listItemObj = $("#" + divID).find(".listItem");
            for (var i = 0; i < listItemObj.length; i++) {
                var size = $(listItemObj[i]).width();
                if(size>MaxSize)
                {
                    MaxSize = size;
                }
            }
            for (var i = 0; i < listItemObj.length; i++) {
                var size = $(listItemObj[i]).css("width", (MaxSize + 10) + "px");
            }
            $("#" + divID).addClass("group-box")
        }

        /*加载数据到table*/
        function LoadDataToTable(divID, data) {
           
            /*输出的表格Id*/
            var TableId= divID + "-Table";
            $("#" + divID).addClass("table-list")
            $("#" + divID).append("<table id='" + TableId + "'><thead></thead><tbody></tbody></table>");
            var table = $("#" + divID).find("table")[0];/*此处可用TableId获取对象*/
            //创建表头
            $(table).find("thead").append(CreateTableHead(data));

            if (data != null && data.length > 0) {
                var rowData = data[0];
                for (var i = 0; i < data.length; i++) {
                    var html = "";
                    if (table.rows.length % 2 == 0) {
                        html = "<tr class='ListTableOddRow'>";
                    }
                    else {
                        html = "<tr class='ListTableEvenRow'>";
                    }

                    var j = 0;
                    for (var paraName in data[j]) {
                        if (paraName != "Count") {
                  
                            html += "<td style=' width:auto;white-space:normal; '>" + data[i][paraName] + "</td>";
                            j++;
                        }
                        else if (i == 0 && paraName == "Count")
                        {
                       
                            CreateTablePage(divID, TableId, parseInt(data[i][paraName]), 1, size);
                        }
                    }
                    $(table).find('tbody').append(html);
                }
            }
            $("." + divID).setTable();
        }

        function CreateTablePage(divID, refControl, totalCount, curPage, pageSize)
        {

            /*如果存在分页侧返回*/
            if ($("#" + divID + "-Page-Box").length > 0)
            {
                return;
            }

            $("#" + divID).append('<div id="' + divID + '-Page-Box" class="Page-Box" style="width: 100%;text-align: center;"><div id="' + divID + '-page"></div></div>');
            /**
			 * 纯粹的JS分页插件，代码缺点：JS操作DOM冗余太多，太繁琐
			 */
            pageUtil.initPage(divID+"-page", {
                totalCount: totalCount,//总页数，一般从回调函数中获取。如果没有数据则默认为1页
                curPage: 1,//初始化时的默认选中页，默认第一页。如果所填范围溢出或者非数字或者数字字符串，则默认第一页
                showCount: 5,//分页栏显示的数量
                pageSizeList: [5, 10, 15, 20, 25, 30],//自定义分页数，默认[5,10,15,20,50]
                defaultPageSize: size,//默认选中的分页数,默认选中第一个。如果未匹配到数组或者默认数组中，则也为第一个
                isJump: true,//是否包含跳转功能，默认false
                isPageNum: true,//是否显示分页下拉选择，默认false
                isPN: true,//是否显示上一页和下一面，默认true
                isFL: true,//是否显示首页和末页，默认true
                jump: function (curPage, pageSize) {//跳转功能回调，传递回来2个参数，当前页和每页大小。如果没有设置分页下拉，则第二个参数永远为0。这里的this被指定为一个空对象，如果回调中需用到this请自行使用bind方法
                    console.log(curPage, pageSize);
                },
            });
        }

        /*动态创建表头*/
        function CreateTableHead(data) {
            if (data.length > 0) {
                var rowData = data[0];
                var headHtml = '<tr class="ListTableHeader" >'; //class="ListTableHeader"  
                var i = 0;
                for (var paraName in rowData) {
                    /*获取状态字段在第几列*/
                    if (paraName != "Count") {

                        headHtml += '<th>';
                        headHtml += paraName
                        headHtml += '</th>'
                        i += 1;
                    }
                    else {
                        pageCount = rowData[paraName]
                    }
                }
                headHtml += '</tr>';
                return headHtml;

            }
        }

        /*组建JSON*/
        function GetParameters() {

            var postParameters = "[";
            var parObject = $("#ParameterTable").find("input[type='text']");
            for (var i = 0; i < parObject.length; i++) {
                var className = $(parObject[i]).attr("class");
                if (className == null || className.indexOf("chooseText") == -1) {
                    postParameters += "{ 'ParamName':'" + $(parObject[i]).attr("id") + "','ParamValue':'" + $(parObject[i]).val() + "' }"
                    if ((i + 1) < parObject.length && postParameters.charAt(postParameters.length - 1) != ',') {
                        postParameters += ","
                    }
                }
            }

            parObject = $("#ParameterTable").find("input[type='hidden']");
            for (var i = 0; i < parObject.length; i++) {
                if (i == 0 && postParameters.length > 1 && postParameters.charAt(postParameters.length - 1) != ',') {
                    postParameters += ","
                }
                postParameters += "{ 'ParamName':'" + $(parObject[i]).attr("id") + "','ParamValue':'" + $(parObject[i]).val() + "' }"
                if ((i + 1) < parObject.length) {
                    postParameters += ","
                }
            }

            if (postParameters.length > 10 && postParameters.charAt(postParameters.length - 1) != ',') {
                postParameters += ","
            }
            postParameters += "{ 'ParamName':'Page','ParamValue':'" + page + "' },"
            postParameters += "{ 'ParamName':'Size','ParamValue':'" + size + "' }"
            postParameters += "]";

            return postParameters;
        }
    </script>

</asp:Content>
