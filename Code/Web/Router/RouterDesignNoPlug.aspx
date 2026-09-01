<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="RouterDesignNoPlug.aspx.cs" Inherits="SKT.LeanMES.Web.Router.RouterDesignNoPlug" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <script src="../Content/js/go.js"></script>
    <script src="../Content/js/skt.utility.router.js"></script>
    <div id="divMsg" class="ListTableTitle" style="color: Gray; font-size: 12px; font-weight: bold;
        text-align: left; border-bottom: 0;">
        <%=Resources.lang.CurrentObject %><span id="spanMsg" style="color: Green"></span>&nbsp;&nbsp;
    </div>
    <div id="routerObject" style="width: 100%;">
        <table id="tblContent" class="EditeContentTable" cellpadding="0" cellspacing="2"
            style="width: 100%; height: 100%;">
            <tr>
                <td style="width: 150px; vertical-align: top; border-left: none; overflow:hidden;" valign="top">
                    <div class="divHeader" style="border-top: none; border-left: none;">
                        工序类型</div>
                    <div style="overflow: auto;" id="operationTypeList">
                        <table class="ListTable" cellspacing="0" cellpadding="5" style="border-width: 0px;
                            width: 100%; border-collapse: collapse;" id="tblOperationType">
                            <%=InitOperationType() %>
                        </table>
                    </div>
                </td>
                <td style="" valign="top">
                    <div style="border-left: 1px solid #d3d3d3;">
                        <div style="background-color: whitesmoke;margin-right:2px; border: solid 1px black; float:left; overflow:hidden;padding:5px 0px;">
                            <div style="overflow:hidden; padding:5px">
                                <input type="text" id="searchvalue" style=" width:100px; float:left; overflow:hidden; " />
                                <a class="search" onclick="searchstation()" style=" width:30px; display:block; overflow:hidden; background-color:red; padding:5px">搜索</a>
                            </div>
                            <div id="myPaletteDiv" ></div>
                        </div>
                        <div id="myDiagramDiv" style="flex-grow: 1;  border: solid 1px black;float:left;overflow:hidden;"></div>
                    </div>
                </td>
            </tr>
        </table>
    </div>
  
    <script type="text/javascript">
        var r_id = -1;
        var r_name = "";
         $(document).ready(function () {
            r_id = '<%=Request.QueryString["R_Id"] %>';

            if (r_id == -1) {
                r_name = "<%=Resources.lang.SelectNullRouter %>";
            }
            else {
                r_name = decodeURI('<%= Request.QueryString["R_Name"] %>');
            }
             //window.parent.showLeftMenu();

         });

        $(function () {

            //set designer display size.
            setRouterDesignerSize();

            //bind resize event
            $("#tblContent").resize(function () {
                setRouterDesignerSize();
            });
            $(window).resize(function () {
                setRouterDesignerSize();
            });

            //set operationType onmousehover style
            var color, size;
            $("#tblOperationType td").hover(function () {
                color = $(this).css("color");
                size = $(this).css("font-size");
                $(this).css({ "cursor": "pointer", "color": "Green", "font-size": "13px", "text-decoration": "underline" });
            }, function () {
                $(this).css({ "color": color, "font-size": size, "text-decoration": "" });
            });
            keepSessionAlive();

            initRouter();
        });

        //init designer size style
        function setRouterDesignerSize() {
            $("#myDiagramDiv").css({ "width": "100%", "height": $(window).height() - 70 });
            var width = parseInt($("#myDiagramDiv").css("width").replace("px", "")) - 187;
            console.log(width);
            $("#myDiagramDiv").css({ "width": width, "height": $(window).height() - 70 });
            $("#myPaletteDiv").css({ "width": "180px", "height": $(window).height() - 110 });
            $("#routerObject").css({ "margin-top": "0px" });
            $("#operationTypeList").height($(window).height() - 90);
        }

        //get operation by operationTypeId when clicked operationType link
        function initOperation(opeTypeId) {
            if (opeTypeId != 0) {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxStation.GetOperationByTypeId(opeTypeId);
                if (ajax.error == null) {
                    var rows = ajax.value.Rows;
                    var jsonString = "", seq = "^";
                    var obj = []
                    for (var i = 0; i < rows.length; i++) {
                        rows[i].StationId + "," + rows[i].Station + "," + rows[i].StationDesc
                        obj.push({
                            category: "Default", //必须值
                            key: rows[i].StationId,//必须值
                            text: rows[i].Station,//必须值
                            StationId: rows[i].StationId,//必须值
                            Station: rows[i].Station,//必须值
                        });
                        //routerDesigner.LoadOperations(jsonString);

                        nodesobj = obj
                        addPaletteNodeList(obj);
                    }
                }
                else { alert(ajax.error.Message); }
            } else {
                routerDesigner.loadOperations("-10,Start,Start^-20,End,End");
            }
        }


        function keepSessionAlive() {
            setInterval(function () {
                $.post("../Framework/Expired.aspx?x=" + Math.random() * 1000);
            }, 180000);
        }

        function searchstation()
        {
            if (typeof (nodesobj) != 'undefined' && nodesobj != null)
            {
                var value = $("#searchvalue").val();
                if (value == "")
                {
                    addPaletteNodeList(nodesobj);
                    return;
                }
                var obj = [];
                for(var i=0;i<nodesobj.length;i++)
                {
                    if (nodesobj[i].Station.toUpperCase().indexOf(value.toUpperCase()) > -1)
                    {
                        obj.push(nodesobj[i])
                    }
                }
                addPaletteNodeList(obj);
            }
        }

        function addPaletteNodeList(nodes) {
            clearPaletteNode();
            for (var i = 0; i < nodes.length; i++) {
                addPaletteNode(nodes[i]);
            }
        }

        function addPaletteNode(node) {
            palette.model.addNodeData(node);
        }

        function clearPaletteNode() {
            var data = palette.model.nodeDataArray;
            while (data.length > 0) {
                palette.model.removeNodeData(data[0]);
            }
        }


        function initRouter() {
            if (window.goSamples) {
                goSamples();
            }
            $$ = go.GraphObject.make;
            diagram = $$(go.Diagram, "myDiagramDiv",  // 创建空的背景图
                {
                    initialContentAlignment: go.Spot.Center,
                    allowCopy: true,
                    allowDrop: true,  //接受来调色板的元素
                    scrollsPageOnFocus: false,     //未知其属性
                    "undoManager.isEnabled": true,  // 启用撤销和恢复
                    allowRelink: false //不允许重绘
                });
            diagram.linkTemplate =
                    $$(go.Link,
                      {
                          routing: go.Link.AvoidsNodes,  //避开其他节点
                          curve: go.Link.JumpOver,    //连线的样式
                          corner: 5,   //角
                          mouseEnter: function (e, link) {
                              link.findObject("HIGHLIGHT").stroke = "rgba(30,144,255,0.2)";
                          },
                          mouseLeave: function (e, link) {
                              link.findObject("HIGHLIGHT").stroke = "transparent";
                          },
                          selectionAdorned: false
                      },
                      $$(go.Shape,  // the highlight shape, normally transparent  突出显示形状，通常是透明的。
                        { isPanelMain: true, strokeWidth: 8, stroke: "transparent", name: "HIGHLIGHT" }),
                      $$(go.Shape,  // the link path shape 链接路径形状
                        { isPanelMain: true, stroke: "gray", strokeWidth: 2 },
                        new go.Binding("stroke", "isSelected", function (sel) {
                            return sel ? "dodgerblue" : "gray";
                        }).ofObject()),
                      $$(go.Shape,  // the arrowhead 箭头
                        { toArrow: "standard", strokeWidth: 0, fill: "gray" }),
                     $$(go.Panel, "Auto",  // the link label, normally not visible 链接标签，通常不可见
                        { visible: true, name: "LABEL", segmentIndex: 2, segmentFraction: 0.5 },
                        new go.Binding("visible", "visible").makeTwoWay(),
                        $$(go.Shape, "RoundedRectangle",  // the label shape
                            { fill: "#F8F8F8", strokeWidth: 0 }),
                        $$(go.TextBlock, "Pass",// the label
                            {
                                textAlign: "center",
                                font: "10pt helvetica, arial, sans-serif",
                                stroke: "#333333",
                                editable: true,
                                editable: true,
                                choices: ['Pass', 'Fail', 'Remove', 'Unpack', 'Any']
                            },
                            new go.Binding("text").makeTwoWay())
                    )
          );




            AddNodeTemplateMapDefault("Default", "#44BB44", 60, 60, true, true, true);
            AddNodeTemplateMapDefault("Start", "#22B8DD", 60, 60, true, false, false, 'Circle');
            AddNodeTemplateMapDefault("End", "#cc3366", 60, 60, false, true, false, 'Circle');
            //设置常规节点样式
            //category:类型，color:颜色，width：宽,height：高,
            //fromLinkable:线输出，toLinkable：线输入， duplicates: 重复链接
            //shape：形状
            function AddNodeTemplateMapDefault(category, color, width, height, fromLinkable, toLinkable, duplicates, shape) {
                if (typeof (fromLinkable) == "undefined") { fromLinkable = true; }
                if (typeof (toLinkable) == "undefined") { toLinkable = true; }
                if (typeof (duplicates) == "undefined") { duplicates = true; }
                if (typeof (shape) == "undefined") { shape = 'RoundedRectangle'; }

                // 为常规节点定义节点模板
                diagram.nodeTemplateMap.add(category,  // the default category   文本节点
                    $$(go.Node, "Table", nodeStyle(),
                        // the main object is a Panel that surrounds a TextBlock with a rectangular Shape
                        $$(go.Panel, "Auto",
                            $$(go.Shape, shape,
                                {
                                    width: width,
                                    height: height,
                                    fill: color,
                                    portId: "A",
                                    strokeWidth: 0,
                                    fromLinkable: fromLinkable, toLinkable: toLinkable,
                                    fromLinkableSelfNode: duplicates, toLinkableSelfNode: duplicates,
                                    fromLinkableDuplicates: duplicates, toLinkableDuplicates: duplicates,
                                    toMaxLinks: 2,
                                    mouseEnter: function (e, port) {  // the PORT argument will be this Shape
                                        if (!e.diagram.isReadOnly) {
                                            port.fill = "rgba(255,0,255,0.5)";
                                        }
                                    },
                                    mouseLeave: function (e, port) {
                                        port.fill = color;
                                    }// allow user-drawn links to here
                                }),
                            $$(go.Shape, shape,// the "Out" port
                                {
                                    width: width - 10,
                                    height: height - 10,
                                    fill: 'transparent',
                                    strokeWidth: 0
                                }),
                            $$(go.TextBlock,
                                {
                                    font: "bold 10pt Helvetica, Arial, sans-serif",
                                    width: width - 10,
                                    textAlign: "center",
                                    stroke: "whitesmoke",
                                    wrap: go.TextBlock.WrapFit,
                                    editable: false
                                }, new go.Binding("text").makeTwoWay())
                        )
                    )
                );
            }
            function nodeStyle() {
                return [
                    //节点。位置来自节点数据的“loc”属性，
                    //由点转换。解析静态方法。
                    //如果节点。位置改变，更新节点数据的“loc”属性，
                    //转换回来使用点。stringify静态方法。
                    new go.Binding("location", "loc", go.Point.parse).makeTwoWay(go.Point.stringify),
                    {
                        //节点位置位于每个节点的中心
                        locationSpot: go.Spot.Center
                    }
                ];
            }

            diagram.addModelChangedListener(function (evt) {
                // ignore unimportant Transaction events
                if (!evt.isTransactionFinished) return;
                var txn = evt.object;  // a Transaction
                txn.changes.each(function (e) {
                    // ignore any kind of change other than adding/removing a node
                    console.log(evt.propertyName + " added node with key: " + e.newValue.key);
                    if (e.modelChange !== "nodeDataArray") return;
                    // record node insertions and removals
                    if (e.change === go.ChangedEvent.Insert) {
                        if(parseFloat(e.newValue.key)<0)
                        {
                            diagram.model.removeNodeData(e.newValue);
                            alert("不允许拖拽重复工位！");
                        }
                    } else if (e.change === go.ChangedEvent.Remove) {
                        console.log(evt.propertyName + " removed node with key: " + e.oldValue.key);
                    }
                });
            });

            // Create an HTMLInfo and dynamically create some HTML to show/hide
            var customEditor = new go.HTMLInfo();
            var customSelectBox = document.createElement("select");
            customEditor.show = function (textBlock, diagram, tool) {
                if (!(textBlock instanceof go.TextBlock)) return;

                // Populate the select box:
                customSelectBox.innerHTML = "";

                // this sample assumes textBlock.choices is not null
                var list = textBlock.choices;
                for (var i = 0; i < list.length; i++) {
                    var op = document.createElement("option");
                    op.text = list[i];
                    op.value = list[i];
                    customSelectBox.add(op, null);
                }

                // 填充列表后，设置值:
                customSelectBox.value = textBlock.text;

                // Do a few different things when a user presses a key
                customSelectBox.addEventListener("keydown", function (e) {
                    var keynum = e.which;
                    if (keynum == 13) { // Accept on Enter
                        tool.acceptText(go.TextEditingTool.Enter);
                        return;
                    } else if (keynum == 9) { // Accept on Tab
                        tool.acceptText(go.TextEditingTool.Tab);
                        e.preventDefault();
                        return false;
                    } else if (keynum === 27) { // Cancel on Esc
                        tool.doCancel();
                        if (tool.diagram) tool.diagram.focus();
                    }
                }, false);

                var loc = textBlock.getDocumentPoint(go.Spot.TopLeft);
                var pos = diagram.transformDocToView(loc);
                customSelectBox.style.left = pos.x + "px";
                customSelectBox.style.top = pos.y + "px";
                customSelectBox.style.position = 'absolute';
                customSelectBox.style.zIndex = 100; // place it in front of the Diagram

                diagram.div.appendChild(customSelectBox);
            }

            customEditor.hide = function (diagram, tool) {
                diagram.div.removeChild(customSelectBox);
            }

            // This is necessary for HTMLInfo instances that are used as text editors
            customEditor.valueFunction = function () { return customSelectBox.value; }

            // Set the HTMLInfo:
            diagram.toolManager.textEditingTool.defaultTextEditor = customEditor;

            // initialize the Palette that is on the left side of the page
            palette = $$(go.Palette, "myPaletteDiv",  // must name or refer to the DIV HTML element
                    {
                        scrollsPageOnFocus: false,   //未知其属性
                        nodeTemplateMap: diagram.nodeTemplateMap,  // share the templates used by myDiagram
                        model: new go.GraphLinksModel([
                        ])
                    });



            diagram.model.nodeDataArray = [
                    { "key": -1, "category": "Start", "loc": "50 50", "text": "开始", "color": "lightblue" },
                    { "key": -2, "category": "End", "loc": "150 380", "text": "结束!", "color": "lightblue" }
            ];

        }
    </script>
</asp:Content>
