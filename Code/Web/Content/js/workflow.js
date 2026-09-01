var WorkFlow = function (options) {
    var design = {
        panel: null,                //面板
        svg: null,                  //面板中的画布
        dragItem: null,             //将要添加的拖动块
        dragNode: null,             //画布中拖动的块
        dragLine: null,             //画布中拖动的线条
        points: [],                 //流程的连接点集合
        minHeight: 500,             //画布的最小高度   
        minWidth: 800,             //画布的最小宽度

        /*--------------------节点图形--------------------*/
        virtualNodeType: "virtual", //虚拟节点类型
        nodeWidth: 70,              //节点的宽度
        nodeHeight: 70,             //节点的高度
        nodeRx: 3,                  //节点的rx
        nodeRy: 3,                  //节点的ry
        selectedNodeStroke: "#00f",     //选中的节点边框颜色
        selectedNodeStrokeWidth: 1.5,   //选中的节点边框大小

        /*--------------------节点文字--------------------*/
        textHeight: 25,             //文字的高度
        textFill:"00f",             //文字颜色

        /*--------------------节点图片--------------------*/
        nodeImageUrl: "../Content/images/wf_node.png",            //普通节点图片
        StartNodeImageUrl: "../Content/images/wf_start.png",      //开始节点图片
        EndImageUrl: "../Content/images/wf_end.png",              //结束节点图片

        /*--------------------连接线--------------------*/
        showPoint: false,           //显示所有连接点
        pointSize: 6,               //连接点的尺寸
        pointDirectionNum: 4,       //每个方向的连接点数(上下左右)
        lineStrokeWidth: 2,         //线宽
        lineExtendedWidth: 30,      //最小延长线宽度
        autowireRange: 80,          //自动连线的范围
        pointFill: "#4F80FF",       //连接点颜色
        selectedLineStrokeDasharray: "5 2",    //连点选中时虚线设置
        lineDragPointSize:5,            //拖拽点菱形大小

        //创建节点
        createNode: function (name, entity) {
            var node = document.createElementNS("http://www.w3.org/2000/svg", name);
            for (var attr in entity) {
                node.setAttribute(attr, entity[attr]);
            }
            return node;
        },
        //初始化
        init: function () {
            design.panel = document.getElementById(options.id);
            design.pointSize = options.pointSize || design.pointSize;
            design.pointDirectionNum = options.pointDirectionNum || design.pointDirectionNum;
            design.showPoint = typeof (options.showPoint) == "undefined" ? design.showPoint : options.showPoint;
            design.lineStrokeWidth = options.lineStrokeWidth || design.lineStrokeWidth;
            design.lineExtendedWidth = options.lineExtendedWidth || design.lineExtendedWidth;
            design.autoFillWidth = design.nodeWidth + design.lineExtendedWidth + 20;    //自动填充宽度
            design.autoFillHeight = design.nodeHeight + design.textHeight + design.lineExtendedWidth + 20;   //自动填充高度
            //计算画布最小尺寸
            var maxWidth = 0;
            var maxHeight = 0;
            $.each(options.items, function (i, o) {
                if (o.x > maxWidth) {
                    maxWidth = o.x;
                }
                if (o.y > maxHeight) {
                    maxHeight = o.y;
                }
            });
            maxWidth = maxWidth + design.autoFillWidth;
            maxHeight = maxHeight + design.autoFillHeight;
            design.minWidth = maxWidth > design.minWidth ? maxWidth : design.minWidth;
            design.minHeight = maxHeight > design.minHeight ? maxHeight : design.minHeight;
            //清空画布
            $(design.panel).find("svg").remove();
            //初始化画布
            this.svg = this.createNode("svg", { "width": "100%", "height": "100%", style: "overflow:hidden;min-width:" + design.minWidth + "px;min-height:" + design.minHeight + "px;" });
            design.panel.appendChild(this.svg);
            design.panel.addEventListener("mousemove", function (e) {
                //拖动块的事件
                if (design.dragNode) {
                    design.dragNode.item.x = design.dragNode.oldX + e.clientX - design.dragNode.e.clientX;
                    design.dragNode.item.y = design.dragNode.oldY + e.clientY - design.dragNode.e.clientY;
                    //拖到边界
                    var svgWidth = $(design.svg).width();
                    var svgHeight = $(design.svg).height();
                    if (design.dragNode.item.x + design.nodeWidth > svgWidth) {
                        $(design.svg).css("min-width", svgWidth + design.autoFillWidth + "px");
                    }
                    if (design.dragNode.item.y + design.nodeHeight > svgHeight) {
                        $(design.svg).css("min-height", svgHeight +design.autoFillHeight + "px");
                    }
                    //块
                    design.dragNode.e.target.setAttribute("x", design.dragNode.item.x);
                    design.dragNode.e.target.setAttribute("y", design.dragNode.item.y);
                    var t = document.getElementById("recttext" + design.dragNode.item.id);
                    if (t) {
                        t.setAttribute("x", design.dragNode.item.x + design.nodeWidth / 2);
                        t.setAttribute("y", design.dragNode.item.y + design.nodeHeight + design.textHeight / 2);
                        t.childNodes[0].setAttribute("x", design.dragNode.item.x + design.nodeWidth / 2);
                        t.childNodes[0].setAttribute("y", design.dragNode.item.y + design.nodeHeight + design.textHeight / 2);
                    }
                    //块背景图
                    var image = document.getElementById("rectimage" + design.dragNode.item.id);
                    if (image) {
                        image.setAttribute("x", design.dragNode.item.x);
                        image.setAttribute("y", design.dragNode.item.y);
                    }
                    //连接点
                    var item = design.dragNode.item;
                    var arrPoint = design.getPointsPosition(item);
                    var arrPointsObj = [];
                    for (var i = 0; i < design.points.length; i++) {
                        if(design.points[i].id== design.dragNode.item.id){
                            arrPointsObj.push(design.points[i]);
                        }
                    }  
                    for (var i = 0; i < arrPoint.length; i++) {
                        var p = document.getElementById("rect_point_" + (i + 1) + "_" + design.dragNode.item.id);
                        p.setAttribute("x", arrPoint[i][0]);
                        p.setAttribute("y", arrPoint[i][1]);
                        //连接点对象更新
                        for (var j = 0; j < arrPointsObj.length; j++) {
                            if (arrPointsObj[j].point_num == i + 1) {
                                var points = design.getPointPostionForLine(item, i + 1);
                                arrPointsObj[j].x = arrPoint[i][0];
                                arrPointsObj[j].y = arrPoint[i][1];
                                arrPointsObj[j].r_x = points[0];
                                arrPointsObj[j].r_y = points[1];
                            }
                        }
                    }
                    //线
                    for (var i = 0; i < options.items.length; i++) {
                        if (options.items[i].type == "line" && (options.items[i].from == design.dragNode.item.id || options.items[i].to == design.dragNode.item.id))
                            design.setline(options.items[i]);
                    }
                }
                //拖动线条的事件
                if (design.dragLine && design.dragLine.item && !design.dragLine.complete) {
                    if (design.dragLine.item.id) {
                        var x= e.clientX - design.panel.offsetLeft + design.panel.scrollLeft;
                        var y = e.clientY - design.panel.offsetTop + design.panel.scrollTop;
                        //自动连线
                        var nearesPoints = design.getNearestPoints(x, y, design.autowireRange);
                        if (nearesPoints) {
                            design.endDragLine(nearesPoints.id, nearesPoints.point_num);
                        }
                        else {
                            //要连接的节点是否结束节点
                            if (design.dragLine.isLineToEnd) {
                                //重置节点为虚拟节点
                                design.dragLine.to.type = design.virtualNodeType;
                                //通过起始点偏移鼠标，避免线遮挡鼠标
                                var points = design.getPointPostionForLine(design.dragLine.from, design.dragLine.item.from_point_num);
                                if (x > points[0])
                                    design.dragLine.to.x = x - 5;
                                else
                                    design.dragLine.to.x = x + 5;
                                if (y > points[1])
                                    design.dragLine.to.y = y - 5;
                                else
                                    design.dragLine.to.y = y + 5;
                                //设置走向
                                var point_num = design.getRelativePointNum(design.dragLine.from, design.dragLine.item.from_point_num, design.dragLine.to);
                                design.dragLine.item.to_point_num = point_num;
                            }
                            else {
                                //重置节点为虚拟节点
                                design.dragLine.from.type = design.virtualNodeType;
                                //通过起始点偏移鼠标，避免线遮挡鼠标
                                var points = design.getPointPostionForLine(design.dragLine.to, design.dragLine.item.to_point_num);
                                if (x > points[0])
                                    design.dragLine.from.x = x - 5;
                                else
                                    design.dragLine.from.x = x + 5;
                                if (y > points[1])
                                    design.dragLine.from.y = y - 5;
                                else
                                    design.dragLine.from.y = y + 5;
                                //设置走向
                                var point_num = design.getRelativePointNum(design.dragLine.to, design.dragLine.item.to_point_num, design.dragLine.from);
                                design.dragLine.item.from_point_num = point_num;
                            }
                            //绘制线
                            design.setline(design.dragLine.item, design.dragLine.from, design.dragLine.to);
                        }
                    } else {
                        //设置新ID
                        design.dragLine.item.id = design.newId();
                        //设置箭头走向
                        var to_point_num = design.getRelativePointNum(design.dragLine.from, design.dragLine.item.from_point_num, design.dragLine.to);
                        design.dragLine.item.to_point_num = to_point_num;
                        //绘制线
                        if (options.newLine && options.newLine(design.dragLine.item))
                            design.newline(design.dragLine.item, design.dragLine.from, design.dragLine.to);
                    }
                }
            });
            design.panel.addEventListener("mouseup", function (e) {
                design.completeDragLine();
            });
            design.svg.addEventListener("click", function (e) {
                if (e.target == this) {
                    design.unSelectNode();
                }
            });
            //要添加的拖动块 移动事件
            $("body").mousemove(function (e) {
                if (!design.dragItem)
                    return;
                design.dragItem.node.css({
                    left: e.clientX - design.nodeWidth / 2,
                    top: e.clientY - design.nodeHeight / 2
                });
            }).keydown(function (e) {
                if (e.keyCode == 46)
                    design.removeNode();
            });;

            //添加文字背景
            var filter = this.createNode("filter", { "id": "textbackground", "x": 0, "y": 0, "width": 1, "height": 1 });
            filter.appendChild(this.createNode("feFlood", { "flood-color": "#fff" }));
            filter.appendChild(this.createNode("feComposite", { "in": "SourceGraphic", "operator": "over" }));
            this.svg.appendChild(filter);

            //先添加所有块
            for (var i = 0; i < options.items.length; i++) {
                if (options.items[i].type == "rect")
                    design.newrect(options.items[i]);
            }
            //在添加线条
            for (var i = 0; i < options.items.length; i++) {
                if (options.items[i].type == "line")
                    design.newline(options.items[i]);
            }

        },
        //获取最大的Id
        maxId: function (t) {
            var maxId = -99999;
            for (var i = 0; i < options.items.length; i++) {
                if (t && t != options.items[i].type)
                    continue;
                if (options.items[i].id > maxId)
                    maxId = options.items[i].id;
            }
            return maxId;
        },
        //新Id
        newId: function () {
            var newId = design.maxId();
            if (newId < 1)
                newId = 1;
            else
                newId += 1;
            return newId;
        },
        //移除拖动中的线条，还在添加的中的线条
        removedragline: function () {
            if (design.dragLine) {
                if (design.dragLine.item && !design.dragLine.complete)
                    design.removeline(design.dragLine.item.id);
                design.dragLine = null;
            }
        },
        //删除线条
        removeline: function (id, moverelation) {
            var element = document.getElementById("marker" + id);
            if (moverelation) {
                var array = [];
                var en;
                for (var i = 0; i < options.items.length; i++) {
                    if (options.items[i].id != id)
                        array.push(options.items[i]);
                    else
                        en = options.items[i];
                }
                if (!en)
                    return;
                options.items = array;
            }
            element.parentNode.removeChild(document.getElementById("polyline" + id));
            element.parentNode.removeChild(document.getElementById("linetext" + id));
            element.parentNode.removeChild(document.getElementById("linepolygon_" + id + "_0"));
            element.parentNode.removeChild(document.getElementById("linepolygon_" + id + "_1"));
            element.parentNode.removeChild(element);
        },
        //删除块
        removerect: function (id) {
            var element = document.getElementById("rect" + id);
            var array = [];
            var en;
            for (var i = 0; i < options.items.length; i++) {
                if (options.items[i].id != id)
                    array.push(options.items[i]);
                else
                    en = options.items[i];
            }
            if (!en)
                return;
            if (options.beforRemoverect && !options.beforRemoverect(en))
                return;
            options.items = array;
            //获取关联的线条，删除
            var lines = [];
            for (var i = 0; i < options.items.length; i++) {
                if (options.items[i].type == "line" && (options.items[i].from == en.id || options.items[i].to == en.id))
                    lines.push(options.items[i].id);
            }
            for (var i = 0; i < lines.length; i++) {
                design.removeline(lines[i], true);
            }
            //删除连接点
            var pointsWrapper = $("#rect_point_wrapper" + id);
            pointsWrapper.remove();
            for (var i = design.points.length - 1; i >= 0; i--) {
                if (design.points[i].id == id) {
                    design.points.slice(i, 1);
                }
            }

            //删除文本
            element.parentNode.removeChild(document.getElementById("recttext" + id));
            //删除背景图
            element.parentNode.removeChild(document.getElementById("rectimage" + id));
            //删除节点
            element.parentNode.removeChild(element);
            
        },
        //根据id 或者 type+id查找项目
        getitem: function (id, type) {
            var item = null;
            for (var i = 0; i < options.items.length; i++) {
                if (type) {
                    if (options.items[i].type != type)
                        continue;
                    if (type + options.items[i].id != id)
                        continue;
                } else {
                    if (options.items[i].id != id)
                        continue;
                }
                item = options.items[i];
                break;
            }
            return item;
        },
        //获取线条的走向
        getlinepoints: function (item, f, t) {
            var _from, _to;
            var points, line_text_points;
            var arr = [];
            if (typeof (f) == "object")
                _from = f;
            if (typeof (t) == "object")
                _to = t;
            for (var i = 0; i < options.items.length; i++) {
                if (options.items[i].id == f) {
                    _from = options.items[i];
                }
                if (options.items[i].id == t) {
                    _to = options.items[i];
                }
            }
            arr = design.getlinepoints_curve(item, _from, _to);

            //    if (_from.id == _to.id)
            //        points = design.getlinepoints_self(_from);

            //    if (_to.y + design.nodeHeight < _from.y)
            //        points = design.getlinepoints_to_top(_from, _to);
            //    else if (_from.y + design.nodeHeight < _to.y)
            //        points =  design.getlinepoints_to_bottom(_from, _to);
            //    else
            //        points = design.getlinepoints_to_level(_from, _to);

            //    line_text_points = design.getmidpoint(points);
            //    arr.push(points);
            //    arr.push(line_text_points);
            return arr;
           
        },
        //指向自己
        getlinepoints_self: function (_from) {
            var array = [];
            if (_from.x - (design.nodeWidth / 2) <= 0) {
                //右
                array.push(_from.x + design.nodeWidth);
                array.push(_from.y + (design.nodeHeight / 2));
                array.push(_from.x + design.nodeWidth + (design.nodeWidth / 2));
                array.push(array[1]);
                array.push(array[2]);
            } else {
                //左
                array.push(_from.x);
                array.push(_from.y + (design.nodeHeight / 2));
                array.push(_from.x - (design.nodeWidth / 2));
                array.push(array[1]);
                array.push(array[2]);
            }

            if (_from.y - (design.nodeHeight / 2) <= 0) {
                //下
                array.push(_from.y + design.nodeHeight + (design.nodeHeight / 2));
                array.push(_from.x + (design.nodeWidth / 2));
                array.push(array[5]);
                array.push(array[6]);
                array.push(_from.y + design.nodeHeight);
            } else {
                //上
                array.push(_from.y - (design.nodeHeight / 2));
                array.push(_from.x + (design.nodeWidth / 2));
                array.push(array[5]);
                array.push(array[6]);
                array.push(_from.y);
            }
            return array;
        },
        //指向y轴的上面
        getlinepoints_to_top: function (_from, _to) {
            var array = [];
            array.push(_from.x + (design.nodeWidth / 2));
            array.push(_from.y);
            if (_to.x + design.nodeWidth < _from.x) {
                //上左
                array.push(_to.x + design.nodeWidth);
                array.push(_to.y + (design.nodeHeight / 2));
            }
            else if (_from.x + design.nodeWidth < _to.x) {
                //上右
                array.push(_to.x);
                array.push(_to.y + (design.nodeHeight / 2));
            }
            else {
                //上中
                array.push(_to.x + (design.nodeWidth / 2));
                array.push(_to.y + design.nodeHeight);
            }
            return array;
        },
        //指向y轴的下面
        getlinepoints_to_bottom: function (_from, _to) {
            var array = [];
            array.push(_from.x + (design.nodeWidth / 2));
            array.push(_from.y + design.nodeHeight);
            if (_to.x + design.nodeWidth < _from.x) {
                //下左
                array.push(_to.x + design.nodeWidth);
                array.push(_to.y + (design.nodeHeight / 2));
            }
            else if (_from.x + design.nodeWidth < _to.x) {
                //下右
                array.push(_to.x);
                array.push(_to.y + (design.nodeHeight / 2));
            }
            else {
                //下中
                if (design.fromtoline_count(_from.id, _to.id) < 2) {
                    array.push(_to.x + (design.nodeWidth / 2));
                    array.push(_to.y);
                } else {
                    array[0] = _from.x + design.nodeWidth;
                    array.push(_to.x + design.nodeWidth);
                    array.push(_to.y);
                }
            }
            return array;
        },
        //两个块直接有多少线条
        fromtoline_count: function (f, t) {
            var count = 0;
            for (var i = 0; i < options.items.length; i++) {
                if (!options.items[i].type == "line")
                    continue;
                if ((options.items[i].from == f && options.items[i].to == t) || (options.items[i].from == t && options.items[i].to == f))
                    count++;
            }
            return count;
        },
        //y轴有重叠，同一水平线有重叠
        getlinepoints_to_level: function (_from, _to) {
            var array = [];
            if (_to.x + design.nodeWidth < _from.x) {
                //在左边
                return design.getlinepoints_to_level_left(_from, _to);
            }
            else if (_from.x + design.nodeWidth < _to.x) {
                //在右边
                return design.getlinepoints_to_level_right(_from, _to);
            }
            else {
                //中中 说明包含 x轴也重叠了
                if (_to.x < _from.x) {
                    array.push(_from.x + design.nodeWidth);
                    array.push(_from.y + (design.nodeHeight / 2));
                    array.push(_from.x + design.nodeWidth + (design.nodeWidth / 2));
                    array.push(array[1]);
                    array.push(array[2]);
                    if (_to.y < _from.y) {
                        //to在左上
                        array.push(_to.y - (design.nodeHeight / 2));
                        if (array[5] < 0) {
                            array[5] = _to.y;
                            array.push(_to.x + design.nodeWidth);
                            array.push(array[5]);
                        } else {
                            array.push(_to.x + (design.nodeWidth / 2));
                            array.push(array[5]);
                            array.push(array[6]);
                            array.push(_to.y);
                        }
                    } else {
                        //to在左下
                        array.push(_to.y + design.nodeHeight + (design.nodeHeight / 2));
                        array.push(_to.x + (design.nodeWidth / 2));
                        array.push(array[5]);
                        array.push(array[6]);
                        array.push(_to.y + design.nodeHeight);
                    }
                } else if (_to.x + design.nodeWidth > _from.x + design.nodeWidth) {
                    if (_to.y <= _from.y) {
                        //to在右上
                        array.push(_from.x + (design.nodeWidth / 2));
                        array.push(_from.y + design.nodeHeight);
                        array.push(array[0]);
                        array.push(_from.y + design.nodeHeight + (design.nodeHeight / 2));
                        array.push(_to.x + design.nodeWidth + (design.nodeWidth / 2));
                        array.push(array[3]);
                        array.push(array[4]);
                        array.push(_to.y + (design.nodeHeight / 2));
                        array.push(_to.x + design.nodeWidth);
                        array.push(array[7]);
                    } else {
                        //to在右下
                        if (_from.y - (design.nodeHeight / 2) <= 0) {
                            array.push(_from.x + design.nodeWidth);
                            array.push(_from.y);
                            array.push(_to.x + design.nodeWidth + (design.nodeWidth / 2));
                            array.push(array[1]);
                            array.push(array[2]);
                            array.push(_to.y + (design.nodeHeight / 2));
                            array.push(_to.x + design.nodeWidth);
                            array.push(array[5]);
                        } else {
                            array.push(_from.x + (design.nodeWidth / 2));
                            array.push(_from.y);
                            array.push(array[0]);
                            array.push(_from.y - (design.nodeHeight / 2));
                            array.push(_to.x + design.nodeWidth + (design.nodeWidth / 2));
                            array.push(array[3]);
                            array.push(array[4]);
                            array.push(_to.y + (design.nodeHeight / 2));
                            array.push(_to.x + design.nodeWidth);
                            array.push(array[7]);
                        }
                    }
                } else {
                    //to和from重叠
                    array.push(_from.x + design.nodeWidth);
                    array.push(_from.y + (design.nodeHeight / 2));
                    array.push(_from.x + design.nodeWidth + (design.nodeWidth / 2));
                    array.push(array[1]);
                    array.push(array[2]);
                    array.push(_to.y + design.nodeHeight + (design.nodeHeight / 2));
                    array.push(_to.x + (design.nodeWidth / 2));
                    array.push(array[5]);
                    array.push(array[6]);
                    array.push(_to.y + design.nodeHeight);
                }
            }
            return array;
        },
        //在同一水平线的 左边
        getlinepoints_to_level_left: function (_from, _to) {
            var array = [];
            array.push(_from.x);
            array.push(_from.y + (design.nodeHeight / 2));
            array.push(_to.x + design.nodeWidth);
            array.push(_to.y + (design.nodeHeight / 2));
            return array;
        },
        //在同一水平线的 右边
        getlinepoints_to_level_right: function (_from, _to) {
            var array = [];
            if (design.fromtoline_count(_from.id, _to.id) < 2) {
                array.push(_from.x + design.nodeWidth);
                array.push(_from.y + (design.nodeHeight / 2));
                array.push(_to.x);
                array.push(_to.y + (design.nodeHeight / 2));
            } else {
                array.push(_from.x + design.nodeWidth);
                array.push(_from.y);
                array.push(_to.x);
                array.push(_to.y);
            }
            return array;
        },
        //绘制曲线
        getlinepoints_curve: function (item, from, to) {
            var line_points = [];                   //线的坐标组
            var text_points = {};                   //文本的坐标
            var line_dragpoint_points = [];         //线拖拽点的坐标
            var arr = [];   //结果集
            var from_direct = Math.floor((item.from_point_num - 1) / design.pointDirectionNum);
            var to_direct =  Math.floor((item.to_point_num - 1) / design.pointDirectionNum);
            var from_points = design.getPointPostionForLine(from, item.from_point_num);
            var to_points = design.getPointPostionForLine(to, item.to_point_num);
            var from_step = design.lineExtendedWidth;
            var to_step = design.lineExtendedWidth;
            //初始化向量
            var vector = [to_points[0] - from_points[0], to_points[1] - from_points[1]];        //两点的直接向量  
            var horizontal_vector = [to_points[0] - from_points[0], 0];     //直接向量的水平向量
            var vertical_vector = [0, to_points[1] - from_points[1]];       //直接向量的垂直向量
            var from_vector = [0,0];        //开始向量
            var from_vector_unit = [0,0];   //开始向量单位尺度
            var to_vector = [0,0];          //结束向量
            var to_vector_unit = [0,0];     //结束向量单位尺度
            switch (from_direct) {
                case 0:
                    from_vector[0] = 0;
                    from_vector[1] = -from_step;
                    from_vector_unit[0] = 0;
                    from_vector_unit[1] = 1;
                    break;
                case 1:
                    from_vector[0] = from_step;
                    from_vector[1] = 0;
                    from_vector_unit[0] = 1;
                    from_vector_unit[1] = 0;
                    break;
                case 2:
                    from_vector[0] = 0;
                    from_vector[1] = from_step;
                    from_vector_unit[0] = 0;
                    from_vector_unit[1] = 1;
                    break;
                case 3:
                    from_vector[0] = -from_step;
                    from_vector[1] = 0;
                    from_vector_unit[0] = 1;
                    from_vector_unit[1] = 0;
                    break;
            }
            switch (to_direct) {
                case 0:
                    to_vector[0] = 0;
                    to_vector[1] = to_step;
                    to_vector_unit[0] = 0;
                    to_vector_unit[1] = 1;
                    break;
                case 1:
                    to_vector[0] = -to_step;
                    to_vector[1] = 0;
                    to_vector_unit[0] = 1;
                    to_vector_unit[1] = 0;
                    break;
                case 2:
                    to_vector[0] = 0;
                    to_vector[1] = -to_step;
                    to_vector_unit[0] = 0;
                    to_vector_unit[1] = 1;
                    break;
                case 3:
                    to_vector[0] = to_step;
                    to_vector[1] = 0;
                    to_vector_unit[0] = 1;
                    to_vector_unit[1] = 0;
                    break;
            }
            //01.计算延长线坐标
            var from_extended_points = [from_points[0] + from_vector[0], from_points[1] + from_vector[1]];
            var to_extended_points = [to_points[0] - to_vector[0], to_points[1] - to_vector[1]];
            //02.计算正交线起始方向
            var from_orthogonal_vector = [];
            //开始向量的平行向量和垂直向量,平行公式（x0 * y1-x1 * y0 == 0）
            var from_parallel_vector = [];
            var from_vertical_vector = [];
            if (from_vector[0] * horizontal_vector[1] - horizontal_vector[0] * from_vector[1] == 0) {
                from_parallel_vector = horizontal_vector;
                from_vertical_vector = vertical_vector;
            }
            else {
                from_parallel_vector  = vertical_vector;
                from_vertical_vector = horizontal_vector;
            }
            //开始向量已平行向量是否同向,同向公式 (x0 * x1 + y0 * y1 >0)
            var isSameDirection = from_vector[0] * from_parallel_vector[0] + from_vector[1] * from_parallel_vector[1] > 0;
            if (isSameDirection) {
                from_orthogonal_vector = from_parallel_vector;
            }
            else {
                from_orthogonal_vector = from_vertical_vector;
            }
            //03.计算正交线的最终方向
            var to_orthogonal_vector = [];
            //终点向量的平行向量和垂直向量,平行公式（x0 * y1-x1 * y0 == 0）
            var to_parallel_vector = [];
            var to_vertical_vector = [];
            if (to_vector[0] * horizontal_vector[1] - horizontal_vector[0] * to_vector[1] == 0) {
                to_parallel_vector = horizontal_vector;
                to_vertical_vector = vertical_vector;
            }
            else {
                to_parallel_vector = vertical_vector;
                to_vertical_vector = horizontal_vector;
            }
            //终点向量已平行向量是否同向,同向公式 (x0 * x1 + y0 * y1 >0)
            var isToSameDiection = to_vector[0] * to_parallel_vector[0] + to_vector[1] * to_parallel_vector[1] > 0;
            if (isToSameDiection) {
                to_orthogonal_vector = to_parallel_vector;
            }
            else {
                to_orthogonal_vector = to_vertical_vector;
            }
            //04.正交线方向规则（正交线起始方向等于正交线最终方向,两个拐弯点，否则一个拐弯点）
            var first_turn_points =[0,0];
            var second_turn_points = [0, 0];
            //正交线起始向量
            var orthogonal_vector = [to_extended_points[0] - from_extended_points[0], to_extended_points[1] - from_extended_points[1]];
            var orthogonal_vector_unit = [0, 0];
            var orthogonal_vector_unit_vertical = [0, 0];       //正交线垂直向量单位
            //同向
            if (isSameDirection) {
                orthogonal_vector_unit = from_vector_unit;
            }
            else {
                orthogonal_vector_unit[0] = Math.abs(from_vector_unit[0] - 1);
                orthogonal_vector_unit[1] = Math.abs(from_vector_unit[1] - 1);
            }
            //正交线起始方向 == 正交线最终方向
            if (from_orthogonal_vector == to_orthogonal_vector) {
                turns_num = 2;
                orthogonal_vector_unit_vertical[0] = Math.abs(orthogonal_vector_unit[0] - 1);
                orthogonal_vector_unit_vertical[1] = Math.abs(orthogonal_vector_unit[1] - 1);
                //第一个拐弯点
                first_turn_points[0] = from_extended_points[0] + orthogonal_vector[0] / 2 * orthogonal_vector_unit[0];
                first_turn_points[1] = from_extended_points[1] + orthogonal_vector[1] / 2 * orthogonal_vector_unit[1];
                //第二个拐弯点
                second_turn_points[0] = first_turn_points[0] + orthogonal_vector[0] * orthogonal_vector_unit_vertical[0];
                second_turn_points[1] = first_turn_points[1] + orthogonal_vector[1] * orthogonal_vector_unit_vertical[1];
                //文本的位置
                text_points.x = (first_turn_points[0] + second_turn_points[0]) / 2;
                text_points.y = (first_turn_points[1] + second_turn_points[1]) / 2;
                //处理延长线过长的问题
                //正交线起点比第一个拐点远，正交线起点==第一个拐弯点
                var vecter = [0, 0];
                vecter[0] = (to_extended_points[0] + from_extended_points[0]) / 2 - from_points[0];
                vecter[1] = (to_extended_points[1] + from_extended_points[1]) / 2 - from_points[1];
                if (Math.abs(vecter[0] * from_vector_unit[0] + vecter[1] * from_vector_unit[1]) <= from_step && isSameDirection) {
                    from_extended_points = first_turn_points;
                }
                //正交线终点比第二个拐点远，正交线终点==第二个拐弯点
                var vecter = [0, 0];
                vecter[0] = to_points[0]- (to_extended_points[0] + from_extended_points[0]) / 2;
                vecter[1] = to_points[1]- (to_extended_points[1] + from_extended_points[1]) / 2 ;
                if (Math.abs(vecter[0] * to_vector_unit[0] + vecter[1] * to_vector_unit[1]) <= from_step && isToSameDiection) {
                    to_extended_points = second_turn_points;
                }
            }
            else {
                turns_num = 1;
                //第一个拐弯点
                first_turn_points[0] = from_extended_points[0] + orthogonal_vector[0] * orthogonal_vector_unit[0];
                first_turn_points[1] = from_extended_points[1] + orthogonal_vector[1] * orthogonal_vector_unit[1];
                //文本的位置
                text_points.x = (from_extended_points[0] + first_turn_points[0]) / 2;
                text_points.y = (from_extended_points[1] + first_turn_points[1]) / 2;
                //处理延长线过长的问题
                //正交线起点比第一个拐点远，正交线起点==第一个拐弯点
                var vecter = [0, 0];
                vecter[0] = (to_extended_points[0] + from_extended_points[0]) / 2 - from_points[0];
                vecter[1] = (to_extended_points[1] + from_extended_points[1]) / 2 - from_points[1];
                if (Math.abs(vecter[0] * from_vector_unit[0] + vecter[1] * from_vector_unit[1]) <= from_step && isSameDirection) {
                    from_extended_points = first_turn_points;
                }
                //正交线终点比第二个拐点远，正交线终点==第二个拐弯点
                var vecter = [0, 0];
                vecter[0] = to_points[0] - (to_extended_points[0] + from_extended_points[0]) / 2;
                vecter[1] = to_points[1] - (to_extended_points[1] + from_extended_points[1]) / 2;
                if (Math.abs(vecter[0] * to_vector_unit[0] + vecter[1] * to_vector_unit[1]) <= from_step && isToSameDiection) {
                    to_extended_points = first_turn_points;
                }
            }
            
            //05.最终的坐标集合
            //起始点
            line_points.push(from_points[0]);   
            line_points.push(from_points[1]);
            //正交线起点
            line_points.push(from_extended_points[0]);   
            line_points.push(from_extended_points[1]);
            //正交线起拐弯点
            line_points.push(first_turn_points[0]);
            line_points.push(first_turn_points[1]);
            if (turns_num == 2) {
                line_points.push(second_turn_points[0]);
                line_points.push(second_turn_points[1]);
            }
            //正交线的终点
            line_points.push(to_extended_points[0]);
            line_points.push(to_extended_points[1]);
            //终点
            line_points.push(to_points[0]);
            line_points.push(to_points[1]);
            //处理线拖拽点
            var fromDragPoint = [(from_points[0] + from_extended_points[0]) / 2, (from_points[1] + from_extended_points[1]) / 2];
            var toDragPoint = [(to_points[0] + to_extended_points[0]) / 2, (to_points[1] + to_extended_points[1]) / 2];
            line_dragpoint_points.push([
                fromDragPoint[0] - design.lineDragPointSize,        //左
                fromDragPoint[1],     
                fromDragPoint[0],                                   //上
                fromDragPoint[1] - design.lineDragPointSize,
                fromDragPoint[0] + design.lineDragPointSize,        //右
                fromDragPoint[1], 
                fromDragPoint[0],        //下
                fromDragPoint[1] + design.lineDragPointSize, 
            ]);
            line_dragpoint_points.push([
                toDragPoint[0] - design.lineDragPointSize,          //左
                toDragPoint[1],
                toDragPoint[0],                                     //上
                toDragPoint[1] - design.lineDragPointSize,
                toDragPoint[0] + design.lineDragPointSize,      //右
                toDragPoint[1],
                toDragPoint[0],          //下
                toDragPoint[1] + design.lineDragPointSize,
            ]);
            arr.push(line_points);
            arr.push(text_points);
            arr.push(line_dragpoint_points);
            return arr;

        },
        //创建线条
        newline: function (item, f, t) {
            if (!f)
                f = item.from;
            if (!t)
                t = item.to;
            //箭头
            var m = this.createNode("marker", { "id": "marker" + item.id, "markerWidth": 6, "markerHeight": 6, "refX": 7, "refY": 4, "orient": "auto", "viewBox": "0 0 8 8" });
            m.appendChild(this.createNode("path", { "id": "markerpath" + item.id, "d": "M 0 0 L 8 4 L 0 8 Z", "fill": options.lineTextInfo(item).color }));

            //线条
            var points = design.getlinepoints(item, f, t);
            var mid = points[1];
            var l = design.getLine(item, points[0]);

            design.svg.appendChild(m);
            design.svg.appendChild(l);

            //线条的文字
            if (options.lineText);
            {
                var lt = this.createNode("text", { "id": "linetext" + item.id, "x": mid.x, "y": mid.y, "fill": options.lineTextInfo(item).color, "filter": "url(#textbackground)", "font-size": "12", "text-anchor": "middle" });
                lt.textContent = options.lineTextInfo(item).text;

                if (options.lineTextClick) {
                    lt.addEventListener("click", function (e) {
                        var en = design.getitem(Number(e.target.getAttribute("id").replace("linetext", "")));
                        options.lineTextClick(en, e.target.getAttribute("x"), e.target.getAttribute("y"), function (status) {
                            e.target.textContent = status.text;
                            e.target.setAttribute("fill", status.color);
                            document.getElementById("polyline" + en.id).setAttribute("stroke", status.color);
                            document.getElementById("markerpath" + en.id).setAttribute("fill", status.color);
                            $(design.panel).find("select").remove();
                        });
                    });
                }
                design.svg.appendChild(lt);
            }
            //线的菱形拖拽点(兼容处理旧的数据)
            if (points[2]) {
                var fromDragPoint = points[2][0];
                var toDragPoint = points[2][1];
                var lp_from = this.createNode("polygon", {
                    "id": "linepolygon_" + item.id + "_0",
                    "class": "linepolygon" + item.id,
                    "points": fromDragPoint,
                    "fill": "#fff",
                    "stroke": design.pointFill,
                    "stroke-width": design.lineStrokeWidth,
                    "style": "display:none;cursor:pointer;",
                });
                lp_from.addEventListener("mousedown", function (e) {
                    var to = design.getitem("rect" + item.to, "rect");
                    var from = $.extend({}, to, { id: design.newId() + 10, type: design.virtualNodeType });
                    var line = design.getitem("line" + item.id, "line");
                    design.beginDragLine(from, to, line, 1);
                });
                var lp_to = this.createNode("polygon", {
                    "id": "linepolygon_" + item.id + "_1",
                    "class": "linepolygon" + item.id,
                    "points": toDragPoint,
                    "fill": "#fff",
                    "stroke": design.pointFill,
                    "stroke-width": design.lineStrokeWidth,
                    "style": "display:none;cursor:pointer;",
                });
                lp_to.addEventListener("mousedown", function (e) {
                    var from = design.getitem("rect" + item.from, "rect");
                    var to = $.extend({}, from, { id: design.newId() + 10, type: design.virtualNodeType });
                    var line = design.getitem("line" + item.id, "line");
                    design.beginDragLine(from, to, line, 1);
                });
                design.svg.appendChild(lp_from);
                design.svg.appendChild(lp_to);
            }
        },
        getLine: function (item, points) {
            var l = this.createNode("polyline", { "id": "polyline" + item.id, "points": points, "fill": "none", "stroke": options.lineTextInfo(item).color, "stroke-width":design.lineStrokeWidth , "marker-end": "url(#marker" + item.id + ")", "style": "cursor:pointer;" });
            l.addEventListener("click", function (e) {
                design.selectNode(e.target);
            });
            return l;
        },
        //拖动后改变线条属性
        setline: function (item, f, t) {
            design.removeline(item.id);
            design.newline(item, f, t);
        },
        selectNodeObj: null,
        selectNode: function (el) {
            if (design.selectNodeObj) {
                if (design.selectNodeObj.nodeName == "rect") {
                    design.selectNodeObj.removeAttribute("stroke");
                    design.selectNodeObj.removeAttribute("stroke-width");
                }
                else if (design.selectNodeObj.nodeName == "polyline") {
                    design.selectNodeObj.removeAttribute("stroke-dasharray");
                    $(".linepolygon" + design.selectNodeObj.id.replace("polyline", "")).hide();
                }
            }
            if (el.nodeName == "rect") {
                el.setAttribute("stroke-width", design.selectedNodeStrokeWidth);
                el.setAttribute("stroke", design.selectedNodeStroke);
            }
            else if (el.nodeName == "polyline") {
                el.setAttribute("stroke-dasharray", design.selectedLineStrokeDasharray);
                $(".linepolygon" + el.id.replace("polyline", "")).show();
            }
            design.selectNodeObj = el;
        },
        unSelectNode: function () {
            $(design.panel).find("select").remove();
            if (design.selectNodeObj) {
                if (design.selectNodeObj.nodeName == "rect") {
                    design.selectNodeObj.removeAttribute("stroke");
                    design.selectNodeObj.removeAttribute("stroke-width");
                }
                else if (design.selectNodeObj.nodeName == "polyline") {
                    design.selectNodeObj.removeAttribute("stroke-dasharray");
                    $(".linepolygon" + design.selectNodeObj.id.replace("polyline", "")).hide();
                }
            }
            design.selectNodeObj = null;
        },
        removeNode: function () {
            if (design.dragLine) {
                design.removedragline();
                return;
            }
            if (!design.selectNodeObj)
                return;
            var e = design.selectNodeObj;
            if (e.nodeName == "rect") {
                design.removerect(e.getAttribute("id").replace("rect", ""));
                if (design.dragLine)
                    design.removedragline();
            } else if (e.nodeName == "polyline") {
                $("#" + options.id + " select").remove();
                design.removeline(e.getAttribute("id").replace("polyline", ""), true);
            }
        },
        dblclickrect: function (node) {
            if (design.dragLine) {
                design.removedragline();
                return;
            }
            var item = design.getitem(node.id, node.nodeName);
            if (options.dblclickrect) {
                options.dblclickrect(item, function () {
                    document.getElementById("rect" + item.id).setAttribute("stroke", item.stroke);
                    document.getElementById("recttext" + item.id).setAttribute("fill", item.stroke);
                });
            }
        },
        beginDragNode: function (e) {
            var item = design.getitem(e.target.id, e.target.nodeName);
            if (!item)
                return;
            design.dragNode = {
                e: e,
                item: item,
                oldX: item.x,
                oldY: item.y
            };
        },
        endDragNode: function () {
            design.dragNode = null;
        },
        //创建块
        newrect: function (item) {
            //块的图形
            var r = this.createNode("rect", { "id": "rect" + item.id, "fill-opacity": 0, "x": item.x, "y": item.y, "rx": design.nodeRx, "ry": design.nodeRy, "width": design.nodeWidth, "height": design.nodeHeight, "style": "cursor:pointer;" });
            r.addEventListener("mousedown", function (e) {
                design.selectNode(e.target);
                design.beginDragNode(e);
            });
            r.addEventListener("mouseup", function (e) {
                design.endDragNode();
            });
            r.addEventListener("dblclick", function (e) {
                design.dblclickrect(e.target);
            });
            //块的文字
            var t = this.createNode("text", { "id": "recttext" + item.id, "width": design.nodeWidth, "height": design.nodeHeight, "x": item.x + design.nodeWidth / 2, "y": item.y + design.nodeHeight + design.textHeight / 2, "fill": design.textFill, "font-size": "12", "text-anchor": "middle", "value": item.value, "style": "cursor:pointer;" });
            var tspan = this.createNode("tspan", { "x": item.x + design.nodeWidth / 2, "y": item.y + design.nodeHeight + design.textHeight / 2 });
            tspan.textContent = item.text
            t.appendChild(tspan);
            //块的背景图
            var imageUrl = design.nodeImageUrl;
            if (item.value == "-10") {
                imageUrl = design.StartNodeImageUrl;
            }
            else if (item.value == "-20") {
                imageUrl = design.EndImageUrl;
            }
            var image = this.createNode("image", {
                "id": "rectimage" + item.id,
                "href": imageUrl,
                "width": design.nodeWidth,
                "height": design.nodeHeight,
                "x": item.x,
                "y": item.y,
                "style": "pointer-events:none;"
            });
            //块的连接点
            var d = 8;
            var g = this.createNode("g", { "id": "rect_point_wrapper" + item.id, "class": "rect_point_wrapper", "display": (design.showPoint ? "inline" : "none") });
            var arrPoint = design.getPointsPosition(item);
            for (var i = 0; i < arrPoint.length; i++) {
                var p = this.createNode("rect", {
                    "id": "rect_point_" + (i + 1) + "_" + item.id,
                    "fill": design.pointFill,
                    "width": design.pointSize,
                    "height": design.pointSize,
                    "x": arrPoint[i][0],
                    "y": arrPoint[i][1],
                    "style": "cursor:crosshair;"
                });
                p.addEventListener("mousedown", function (e) {
                    var arr = e.target.id.split("_");
                    var id = parseInt(arr[3]);
                    var point_num = parseInt(arr[2]);
                    var from = design.getitem("rect" + id, "rect");
                    var to = { type: design.virtualNodeType };
                    var item = { type: "line", from: id, from_point_num: point_num };
                    design.beginDragLine(from, to, item, 0);
                });
                g.appendChild(p);
                //添加到对象集合
                var r_points = design.getPointPostionForLine(item,i+1);
                design.points.push({
                    id: item.id,
                    point_num: i + 1,
                    x: arrPoint[i][0],          //连接点坐标
                    y: arrPoint[i][1],
                    r_x: r_points[0],           //连接点所在图形节点坐标
                    r_y: r_points[1],
                });
            }
            design.svg.appendChild(r);
            design.svg.appendChild(t);
            design.svg.appendChild(image);
            design.svg.appendChild(g);
        },
        //获取两点的中点
        getmidpoint: function (points)
        {
            if (points.length == 4) {
                return {
                    x: (Number(points[0]) + Number(points[2])) / 2,
                    y: (Number(points[1]) + Number(points[3])) / 2 + 6
                };
            }
            return {
                x: (Number(points[2]) + Number(points[4])) / 2,
                y: (Number(points[3]) + Number(points[5])) / 2 + 6
            };
        },

        //获取连接点位置的数组
        getPointsPosition :function (item) {
            var x = item.x;
            var y = item.y;
            var w = design.nodeWidth;
            var h = design.nodeHeight;
            var arr = [];
            var n = design.pointDirectionNum;
            var size = design.pointSize;
            //上
            for (var i = 0; i < n; i++) {
                arr[i] = [0, 0];
                if (i == 0) {
                    arr[i][0] = x - size;
                    arr[i][1] = y - size;
                }
                else {
                    arr[i][0] = x + (w / n) * i - size / 2;
                    arr[i][1] = y - size;
                }
            }
            //右
            for (var i = 0; i < n; i++) {
                arr[i+n] = [0, 0];
                if (i == 0) {
                    arr[i + n][0] = x + w;
                    arr[i+n][1] = y - size;
                }
                else {
                    arr[i + n][0] = x + w;
                    arr[i + n][1] = y + (h / n) * i - size / 2;
                }
            }
            //下
            var m = n;
            for (var i = 0; i < n; i++) {
                arr[i + 2 * n] = [0, 0];
                if (i == 0) {
                    arr[i + 2 * n][0] = x + w;
                    arr[i + 2 * n][1] = y + h;
                }
                else {
                    arr[i + 2 * n][0] = x + (w / n) * m - size / 2;
                    arr[i + 2 * n][1] = y + h;
                }
                m--;
            }
            //左
            var m = n;
            for (var i = 0; i < n; i++) {
                arr[i + 3 * n] = [0, 0];
                if (i == 0) {
                    arr[i + 3 * n][0] = x - size;
                    arr[i + 3 * n][1] = y + h;
                }
                else {
                    arr[i + 3 * n][0] = x - size;
                    arr[i + 3 * n][1] = y + (h / n) * m - size / 2;
                }
                m--;
            }
            return arr;
        },
        //获取连接点用于线的坐标组
        getPointPostionForLine: function (item, num) {
            var direct = Math.floor((num - 1) / design.pointDirectionNum);
            var arr = [0, 0];
            var x = item.x;
            var y = item.y;
            var w = (item.type && item.type == design.virtualNodeType) ? 0 : design.nodeWidth;
            var h = (item.type && item.type == design.virtualNodeType) ? 0 : design.nodeHeight;
            var n = design.pointDirectionNum;
            var index = (num - 1) % design.pointDirectionNum;

            if (direct == 0) {      //上
                if (index == 0) {
                    arr[0] = x;
                    arr[1] = y;
                }
                else {
                    arr[0] = x + (w / n) * index;
                    arr[1] = y;
                }
            }
            else if (direct == 1) { //右
                if (index == 0) {
                    arr[0] = x + w;
                    arr[1] = y;
                }
                else {
                    arr[0] = x + w;
                    arr[1] = y + (h / n) * index;
                }
            }
            else if (direct == 2) { //下
                if (index == 0) {
                    arr[0] = x + w;
                    arr[1] = y + h;
                }
                else {
                    arr[0] = x + w - (w / n) * index;
                    arr[1] = y + h;
                }
            }
            else if (direct == 3) { //左
                if (index == 0) {
                    arr[0] = x;
                    arr[1] = y + h;
                }
                else {
                    arr[0] = x;
                    arr[1] = y + h - (h / n) * index;
                }
            }
            return arr;
        },
        //获取连线时鼠标模拟的相对连接点位置(用于绘制鼠标处线的走向)
        getRelativePointNum: function (original, original_point_num, relative) {
            if (typeof (original) != "object" || typeof (relative) != "object" || !original_point_num) {
                return -1;
            }
            var originalPoint = design.getPointPostionForLine(original, original_point_num);
            var relativePoint = [relative.x, relative.y];
            var vector = [relativePoint[0] - originalPoint[0], relativePoint[1] - originalPoint[1]];
            var relative_point_num = -1;
            //区分左右
            if (vector[0] > 0) {
                relative_point_num = design.pointDirectionNum * 3 + Math.floor(design.pointDirectionNum / 2) + 1;
            }
            else {
                relative_point_num = design.pointDirectionNum * 1 + Math.floor(design.pointDirectionNum / 2) + 1;
            }
            return relative_point_num;
        },
        //获取范围内最近的连接点
        getNearestPoints: function (x, y, range) {
            var points = null;
            if (typeof (x) == "undefined" || typeof (y) == "undefined" || typeof (range) == "undefined")
                return points;
            for (var i = 0; i < design.points.length; i++) {
                var r_x = design.points[i].r_x;
                var r_y = design.points[i].r_y;
                var distance = Math.sqrt(Math.pow(r_x - x, 2) + Math.pow(r_y - y, 2));
                //在范围内
                if (distance < range) {
                    if (points) {
                        var oldDistance = Math.sqrt(Math.pow(points.r_x - x, 2) + Math.pow(points.r_y - y, 2));
                        if (distance < oldDistance) {
                            points = design.points[i];
                        }
                    }
                    else {
                        points = design.points[i];
                    }
                }
                
            }
            return points;
        },
        //连线开始(mode 0:连线模式 1:拖拽模式)
        beginDragLine: function (from, to, item,mode) {
            if (!design.dragLine) {
                if (!from || !to)
                    return;
                //连线开始
                if (mode == 0) {
                    if (options.fromlinecheck) {
                        if (!options.fromlinecheck(from, options.items))
                            return;
                    }
                }
                design.dragLine = {
                    complete: false,
                    mode: mode,
                    isLineToEnd: from.type != design.virtualNodeType,       //是否连接到结束节点
                    from: from,
                    to: to,
                    item: $.extend({}, item),
                    oldItem: item,
                };
                //移除数据实体
                if (design.dragLine.mode == 1) {
                    $.each(options.items, function (i, o) {
                        if (o.id == item.id) {
                            options.items.splice(i, 1);
                            return false;
                        }
                    });
                }
            }
        },
        //连线完成确认
        completeDragLine: function () {
            if (design.dragLine && design.dragLine.item) {
                //连线的开始和结束节点就绪添加节点(没有虚拟节点表示就绪)
                if (design.dragLine.from.type != design.virtualNodeType && design.dragLine.to.type != design.virtualNodeType && !design.dragLine.complete) {
                    //如果是连线到结束节点，开始验证
                    if (design.dragLine.isLineToEnd) {
                        if (options.tolinecheck) {
                            if (!options.tolinecheck(design.dragLine.from, design.dragLine.to, options.items)) {
                                design.removedragline();
                                return;
                            }
                        }
                    }
                    else {
                        if (options.fromlinecheck) {
                            if (!options.fromlinecheck(design.dragLine.from, options.items))
                                return;
                        }
                    }
                    design.dragLine.complete = true;
                    options.items.push(design.dragLine.item);
                    design.setline(design.dragLine.item);
                    //拖放模式设置线选中
                    if (design.dragLine.mode == 1) {
                        design.selectNode($("#polyline" + design.dragLine.item.id)[0]);
                    }
                    design.removedragline();
                    if (options.afteraddline)
                        options.afteraddline();
                    
                }
                else {
                    //拖拽线时复位
                    if (design.dragLine.mode == 1) {
                        design.setline(design.dragLine.oldItem);
                        options.items.push(design.dragLine.oldItem);
                        design.selectNode($("#polyline" + design.dragLine.oldItem.id)[0]);
                        design.dragLine = null;
                    }
                    else {
                        //取消连线
                        design.removedragline();
                    }
                }
            }
        },
        //连线结束
        endDragLine: function (id, point_num) {
            if (design.dragLine && design.dragLine.item) {
                //同一个连接点
                if (design.dragLine.isLineToEnd) {
                    if (design.dragLine.from.id == id && design.dragLine.item.from_point_num == point_num) {
                        return;
                    }
                }
                else {
                    if (design.dragLine.to.id == id && design.dragLine.item.to_point_num == point_num) {
                        return;
                    }
                }
                //选中节点
                if (!design.dragLine.complete) {
                    var item = design.getitem("rect" + id, "rect");
                    if (!item)
                        return;
                    if (design.dragLine.isLineToEnd) {
                        design.dragLine.to = $.extend({}, item);
                        design.dragLine.item.to = id;
                        design.dragLine.item.to_point_num = point_num;
                    }
                    else {
                        design.dragLine.from = $.extend({}, item);
                        design.dragLine.item.from = id;
                        design.dragLine.item.from_point_num = point_num;
                    }
                    design.setline(design.dragLine.item);
                }
            }
        },
    };
    design.init();

    //添加拖动项
    this.dragItem = function (e, item, callback) {
        if (design.dragLine) {
            design.removedragline();
            return;
        }
        design.dragItem = item;
        if (design.dragItem == null)
            return;
        design.dragItem.node = $("<div class='drag-item-wapper'><div class='drag-item-node'></div><span class='drag-item-text'>" + design.dragItem.text + "</span></div>");
        design.dragItem.node.css({
            width: design.nodeWidth,
            height: design.nodeHeight + design.textHeight,
            position: "absolute",
            zIndex: 99999,
            left: e.clientX - design.nodeWidth / 2,
            top: e.clientY - design.nodeHeight / 2,
            textAlign: "center",
            cursor: "move",
            overflow: "hidden"
        }).mouseup(function (e) {
            if (!design.dragItem)
                return;
            design.dragItem.node.remove();
            var p_left = design.panel.offsetLeft - design.panel.scrollLeft;
            var p_top = design.panel.offsetTop - design.panel.scrollTop;
            if (e.clientX - (design.nodeWidth / 2) > p_left && e.clientY - (design.nodeHeight / 2) > p_top) {
                var rect = callback(options.items);
                if (!rect)
                    return;
                rect = $.extend({}, {
                    id: design.newId(),
                    type: "rect",
                    x: e.clientX - p_left - (design.nodeWidth / 2),
                    y: e.clientY - p_top - (design.nodeHeight / 2),
                    text: design.dragItem.text,
                    value: design.dragItem.value
                }, rect);
                options.items.push(rect);
                design.newrect(rect);
                design.dragItem = null;
            }
        }).appendTo($("body"));
        design.dragItem.node.find(".drag-item-node").css({
            "width": design.nodeWidth,
            "height": design.nodeHeight,
            "border-width": design.selectedNodeStrokeWidth,
            "border-style": "solid",
            "border-color": design.selectedNodeStroke,
            "background-image": "url(" + design.nodeImageUrl + ")",
            "background-repeat": "no-repeat",
            "background-size": "100% 100%",
            "borderRadius": 3,
            "position": "relative",
            "left": 0,
            "top": 0,
        });
        design.dragItem.node.find("drag-item-text").css({
            "width": "auto",
            "height": design.textHeight,
            "position": "relative",
            "left":0 ,
            "top": design.nodeHeight,
        });
    }

    //获取所有项
    this.getItems = function () {
        return options.items;
    }

    //根据条件获取编辑项
    this.getItem = function (id, type) {
        return design.getitem(id, type);
    }

    //显示或隐藏所有连接点
    this.togglePoints = function (isShow) {
        if (isShow != undefined) {
            design.showPoint = !isShow;
        }
        if (design.showPoint) {
            $(".rect_point_wrapper").hide();
            design.showPoint = false;
        }
        else {
            $(".rect_point_wrapper").show();
            design.showPoint = true;
        }
    }
}