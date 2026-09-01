<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    Inherits="SKT.LeanMES.Web.Production.ShopOrderEdit" CodeBehind="ShopOrderEdit.aspx.cs"
    ValidateRequest="false" %>

<%@ Import Namespace="Resources" %>
<%@ Import Namespace="SKT.LeanMES.Web" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="wrap_tb" style="min-width: 780px;">
        <ul class="tb">
            <li class="current">基本信息</li>
            <li>工单BOM</li>
            <%--2016-12-19BirongLiang   预留产品工艺参数，暂不用--%>
            <li style="display: none">产品工艺参数</li>
            <li>工序工艺参数</li>
            <li>扩展信息</li>
        </ul>
        <div class="tb_c" style="min-height: 350px; overflow: auto;">
            <div class="infoTips">
                <%= Messages.WithAsteriskIsRequired %>
            </div>
            <table class="EditeContentTable" width="100%">
                <tr>
                    <td class="Label2">
                        <%= lang.ItemsName %><em>*</em>
                    </td>
                    <td class="Field2" colspan="3">
                        <asp:TextBox ID="txtItemName" runat="server" CssClass="TextBox" Enabled="false" ClientIDMode="Static"
                            Width="64%">
                        </asp:TextBox>
                        <%--<input type="button" id="btnSelectItem" runat="server" class="ButtonBox" value="..."
                            title="Select" onclick="openChoosePage(1);" />--%>
                        <input type="button" id="btnSelectItem" runat="server" class="ButtonBox" value="..."
                            title="Select" onclick="openChoosePage(832);" />

                        <asp:HiddenField ID="hdnItemId" runat="server" Value="-1" ClientIDMode="Static" />
                    </td>
                </tr>
                <tr>
                    <td class="Label2">
                        <%= lang.ShopOrder %><em>*</em>
                    </td>
                    <td class="Field2">
                        <asp:TextBox ID="txtOrderNO" runat="server" MaxLength='50' CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
                    </td>
                    <td class="Label2">
                        <%= lang.Qty_to_Build %><em>*</em>
                    </td>
                    <td class="Field2">
                        <asp:TextBox ID="txtQty_to_Build" runat="server" Width="50%" CssClass="NumericBox50" ClientIDMode="Static"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="Label2">
                        <%= lang.OrderType %>
                    </td>
                    <td class="Field2">
                        <asp:DropDownList runat="server" ID="ddlOrderType" ClientIDMode="Static">
                            <asp:ListItem Value="1" Selected="True" Text="正常"></asp:ListItem>
                            <asp:ListItem Value="2" Text="RMA"></asp:ListItem>
                            <asp:ListItem Value="3" Text="返工"></asp:ListItem>
                            <asp:ListItem Value="4" Text="委托加工"></asp:ListItem>
                            <asp:ListItem Value="5" Text="受托加工"></asp:ListItem>
                            <asp:ListItem Value="6" Text="重复生产"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td class="Label2">
                        <%= lang.Status %>
                    </td>
                    <td class="Field2">
                          <span class="spOrderStatus">未选择状态</span>
                       <%-- <asp:DropDownList runat="server" ID="ddlShopOrderStatus" ClientIDMode="Static">
                        </asp:DropDownList>--%>
                    </td>
                </tr>
                <tr>
                    <td class="Label2">
                        <%= lang.Bom %>
                    </td>
                    <td class="Field2">
                        <asp:TextBox ID="txtBOM" runat="server" CssClass="TextBox" Enabled="false" ClientIDMode="Static"></asp:TextBox><input
                            type="button" id="btnSelectBom" class="ButtonBox" runat="server" value="..." title="Select"
                            onclick="openChoosePage(108);" />
                        <asp:HiddenField ID="hdnBomId" runat="server" Value="-1" ClientIDMode="Static" />
                    </td>
                    <td class="Label2">
                        <%= lang.RouterName %>
                    </td>
                    <td class="Field2">
                        <asp:TextBox ID="txtRouter" runat="server" CssClass="TextBox" Enabled="false" ClientIDMode="Static"></asp:TextBox><input
                            type="button" id="btnSelectRouter" class="ButtonBox" value="..." runat="server" title="Select"
                            onclick="openChoosePage(22);" />
                        <asp:HiddenField ID="hdnRId" runat="server" Value="-1" ClientIDMode="Static" />
                    </td>
                </tr>
                <tr>
                    <td class="Label2">
                        <%= lang.Priority %><em>*</em>
                    </td>
                    <td class="Field2">
                        <asp:TextBox ID="txtPriority" runat="server" CssClass="NumericBox50" Text="0" ClientIDMode="Static"></asp:TextBox><span class="Tips">范围0~9999(默认为0)</span>
                    </td>
                    <td class="Label2">
                        <%= lang.CustomerName %>
                    </td>
                    <td class="Field2">
                        <asp:TextBox ID="txtCustomer" runat="server" CssClass="TextBox" Enabled="false" ClientIDMode="Static"></asp:TextBox><input
                            type="button" id="btnSelectCustomer" class="ButtonBox" runat="server" value="..." title="Select"
                            onclick="openChoosePage(10);" />
                        <asp:HiddenField ID="hdnCustomerId" runat="server" Value="-1" ClientIDMode="Static" />
                    </td>
                </tr>
                <tr>
                    <td class="Label2">
                        <%= lang.CustomerOrder %>
                    </td>
                    <td class="Field2">
                        <asp:TextBox ID="txtCustomerOrder" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox><input
                            type="button" id="Button1" class="ButtonBox" runat="server" value="..." title="Select"
                            onclick="openChoosePage(810);" />
                    </td>
                    <td class="Label2">
                        <%= lang.CustomerOrderQty %>
                    </td>
                    <td class="Field2">
                        <asp:TextBox ID="txtCustomerOrderQty" runat="server" Width="50%" CssClass="NumericBox50" ClientIDMode="Static"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="Label2">
                        工单计划开始日期
                    </td>
                    <td class="Field2">
                        <asp:TextBox CssClass="DateTimeBox" ID="txtPlanned_Start_Time" runat="server"  Width="140" options="{showHms:'false'}"
                            ClientIDMode="Static">
                        </asp:TextBox>
                    </td>
                    <td class="Label2">
                        工单计划完成日期
                    </td>
                    <td class="Field2">
                        <asp:TextBox CssClass="DateTimeBox" ID="txtPlanned_Completed_Date" runat="server" options="{showHms:'false'}"
                            Width="140" ClientIDMode="Static">
                        </asp:TextBox>
                    </td>
                </tr>
                 <tr>
                        <td  class="Label2">
                            <%= Resources.lang.MaskGroup%>
                        </td>
                        <td   class="Field2">
                            <asp:TextBox ID="txtMask" runat="server" CssClass="TextBox" Enabled="false"></asp:TextBox><input
                                type="button" id="btnMask" class="ButtonBox" value="..." title="" onclick="selectMask();" />
                            <asp:HiddenField ID="txtMaskID" runat="server" Value="-1" />
                        </td>
                         <td  class="Label2">工单BOM版本</td>
                         <td   class="Field2"><asp:TextBox ID="txtBomVersion" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox></td>
                    </tr>
            </table>
        </div>
        <div style="min-height: 460px; overflow: auto;">
            <div>
                <table class="EditeContentTable" style="border-collapse: inherit;" width="100%">
                    <tr>
                        <td class="Label2">
                            <%= lang.Bom %>：
                        </td>
                        <td class="Field2">
                            <input type="text" style="border: 0px; width: 90%" readonly="readonly" id="txtBOM2"
                                value="" />
                        </td>
                        <td class="Label2">
                            产品BOM更新模式
                        </td>
                        <td class="Field2">
                            <asp:DropDownList runat="server" ID="ddlPrivacyBOM" ClientIDMode="Static">
                                <%--<asp:ListItem Value="0" Text="不保存副本"></asp:ListItem>--%>
                                <asp:ListItem Value="0" Text="默认"></asp:ListItem>
                                <asp:ListItem Value="1" Text="创建副本"></asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                </table>
                <table class="ListTable" cellspacing="0" cellpadding="4" style="border-width: 0px;
                    min-width: 760px; width: 100%; overflow: auto; border-collapse: collapse;" id="tbBomComponent">
                    <tr class="ListTableHeader">
                        <%--                        <th scope="col" align="center">
                            序号
                        </th>--%>
                        <th scope="col" align="center" >
                            物料编码
                        </th>
                        <th scope="col" align="center">
                            物料描述
                        </th>
                        <th scope="col" align="center">
                            数据类型
                        </th>
<%--                        <th scope="col" align="center">
                            需求量
                        </th>--%>
                        <th scope="col" align="center">
                            用量
                        </th>
                        <th scope="col" align="center">
                            工序
                        </th>
                        <th scope="col" align="center">
                            客指用料
                        </th>
                        <th scope="col" align="center">
                            供应商简称
                        </th>
                        <th scope="col" align="center">
                            替代料
                        </th>
                        <th scope="col" align="center">
                            使用比例
                        </th>
                        <th scope="col" onclick="addComponent(null, true, this);" style="color: #0066CC;
                            cursor: pointer; width: 80px; vertical-align: middle;" align="center">
                            <img src="../Content/images/icon/Add.png" class="imgText" />
                            <%= Buttons.COM_Add %>
                        </th>
                    </tr>
                </table>
            </div>
        </div>
        <div style="min-height: 335px; overflow: auto;">
            <div>
                <table class="EditeContentTable" style="border-collapse: inherit;" width="100%">
                    <tr>
                        <td class="Label1">
                            产品工艺参数更新模式
                        </td>
                        <td class="Field1">
                            <asp:DropDownList runat="server" ID="ddlItemPParam" ClientIDMode="Static">
                                <asp:ListItem Value="0" Text="默认"></asp:ListItem>
                                <asp:ListItem Value="1" Text="创建副本"></asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                </table>
                <table class="ListTable" cellspacing="0" cellpadding="4" style="border-width: 0px;
                    min-width: 760px; width: 100%; overflow: auto; border-collapse: collapse;" id="tbParaItem">
                    <tr class="ListTableHeader">
                        <th scope="col" align="center">
                            序号
                        </th>
                        <%--                        <th scope="col" align="center">工序
                        </th>--%>
                        <th scope="col" align="center">
                            参数名字
                        </th>
                        <th scope="col" align="center">
                            参数数值
                        </th>
                        <th scope="col" align="center">
                            特殊说明
                        </th>
                        <%--                        <th scope="col" style="color: #0066CC; cursor: pointer; width: 80px; vertical-align: middle;"
                            align="center">
                            <img src="../Content/images/icon/Add.png" class="imgText" />
                            <%= Resources.Buttons.COM_Add%>
                        </th>--%>
                    </tr>
                </table>
            </div>
        </div>
        <div style="min-height: 335px; overflow: auto;">
            <div>
                <table class="EditeContentTable" style="border-collapse: inherit;" width="100%">
                    <tr>
                        <td class="Label2">
                            <%= lang.Station %>：
                        </td>
                        <td class="Field2">
                            <span class="spStation">未绑定路由</span>
                        </td>
                        <td class="Label2">
                            工序工艺参数更新模式
                        </td>
                        <td class="Field2">
                            <asp:DropDownList runat="server" ID="ddlOpePParam" ClientIDMode="Static">
                                <asp:ListItem Value="0" Text="默认"></asp:ListItem>
                                <asp:ListItem Value="1" Text="创建副本"></asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                </table>
                <table class="ListTable" cellspacing="0" cellpadding="4" style="border-width: 0px;
                    min-width: 760px; width: 100%; overflow: auto; border-collapse: collapse;" id="tbParams">
                    <tr class="ListTableHeader">
                        <th scope="col" align="center">
                            序号
                        </th>
                        <th scope="col" align="center" class="clParaStation">
                            工序
                        </th>
                        <th scope="col" align="center">
                            参数名字
                        </th>
                        <th scope="col" align="center">
                            参数数值
                        </th>
                        <th scope="col" align="center">
                            特殊说明
                        </th>
                    </tr>
                </table>
            </div>
            <asp:HiddenField runat="server" ID="hfJSONStation" ClientIDMode="Static" />
            <asp:HiddenField runat="server" ID="hfJSONOrderStatus" ClientIDMode="Static" />
              <asp:HiddenField runat="server" ID="hdStatus" ClientIDMode="Static" />
              <asp:HiddenField runat="server" ID="hdQtyReleased" ClientIDMode="Static" />
              <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />

        </div>
        <div style="min-height: 335px; overflow: auto;">
                <table id="tblExtensionInfos" class="EditeContentTable" width="100%">
                <tr id="trNewInfo">
                    <td colspan="4" style="text-align: center;">
                        <%=Resources.lang.NoExtendedInfos %>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <script type="text/javascript">
    var flag = -1;
    var soId = <%= Request.QueryString["ID"] %>;
    var tab = document.getElementById("tbBomComponent");
    var LoginUser = '<%= AccountController.GetCurrentUser().UserName %>';
    var tabParams = document.getElementById("tbParams");
    var tabItemParams = document.getElementById("tbParaItem");
    var hdnOperate = $("#hdnOperate");
    var chooseType = '';
    var rowObj = {};
    var rowSeq = 0;
    _isHms = true;
    var hfJSONStation;
    var hfJSONOrderStatus;
    var itemID;
    var nowBomPara, nowOpePara ,nowItemPara,nowBomID,qtyReleased,status;
     //Add By Alma.Liu 20181008 
    function Import() {
        hdnOperate.val("ExportExcel");
        document.forms[0].submit();
        hdnOperate.val("");
    }

    $(document)
        .ready(function() {
            checkDateTimeBox();
            $( ".DateTimeBox" ).datepicker( "option", "showHms",false );
            $("#txtBOM2").val($("#txtBOM").val()!==''?$("#txtBOM").val():'未绑定BOM');
            if (tab.rows.length < 2) {
                $("#tbBomComponent")
                    .append("<tr class='ListTableEmptyDataRow'><td colspan='12'>点击“新增”按钮来设置BOM内容。</td></tr>");
            }
            if (tabParams.rows.length < 2)
            {
                $("#tbParams").append("<tr class='ListTableEmptyDataRow'><td colspan='6'>" + mesLang("选择工序获取工艺参数")+"</td></tr>");
            }
            if (tabItemParams.rows.length < 2) {
                $("#tbParaItem").append("<tr class='ListTableEmptyDataRow'><td colspan='5'>此产品没有工艺参数。</td></tr>");
            }


            itemID = $("#hdnItemId").val();
            hfJSONStation = $("#hfJSONStation").val();
            hfJSONOrderStatus = $("#hfJSONOrderStatus").val();
            nowBomPara = $("#ddlPrivacyBOM").val();
            nowOpePara=$("#ddlOpePParam").val();
            nowItemPara = $("#ddlItemPParam").val();
            nowBomID = $("#hdnBomId").val();
            qtyReleased = $("#hdQtyReleased").val();
            status=$("#hdStatus").val();

            //读取已有信息
            if (parseInt(soId) > -1) {
                initOrderBOM(soId.toString(), $("#hdnBomId").val(), $("#ddlPrivacyBOM").val());
                //initOrderParam(soId.toString());   //BOM工艺参数
                initOrderParam(-1, itemID); //产品工艺参数
                setSelStation(hfJSONStation, '-1'); //顶部工序选择按钮
                setShopOrderStatus(hfJSONOrderStatus, status);
                //设置动态表格控件状态----
                if ($("#ddlPrivacyBOM").val() * 1 === 0) {
                    $(".chkEditableBOM").attr("disabled", "disabled");
                }
                if ($("#ddlItemPParam").val() * 1 === 0) {
                    $(".chkEditableP.item").attr("disabled", "disabled");
                }
                if ($("#ddlOpePParam").val() * 1 === 0) {
                    $(".chkEditableP.station").attr("disabled", "disabled");
                }
                 if (qtyReleased> 0) {
                    $("#ddlShopOrderStatus").attr("disabled", "disabled");
                }
                //--------
            } else {
                 setShopOrderStatus(hfJSONOrderStatus, -1);

            }


            //绑定基本信息BOM选定事件
            $("#txtBOM")
                .live("change",
                    function() {
                        $("#txtBOM2").val($("#txtBOM").val());
                        $("#tbBomComponent .ListTableOddRow").remove();
                        initOrderBOM(-1,$("#hdnBomId").val(),0);
                    });
            //绑定station事件
            $(".ddlStation")
                .live("change",
                    function() {
                        //$(this).parent().prev('input').val($(this).val());
                        $("#tbParams .ListTableOddRow").remove();
                        initOrderParam($(this).val(), -1);
                    });
            //绑定BOM模式事件
            $("#ddlPrivacyBOM")
                .live("change",
                    function() {
                        //$(this).parent().prev('input').val($(this).val());
                        if (nowBomPara * 1 !== 0 && $(this).val() * 1 === 0) { //创建副本->默认
                            if (confirm("此选项将删除已存在的副本信息")) {
                                $("#tbBomComponent .ListTableOddRow").remove();//清空工单BOM信息
                                initOrderBOM(-1, $("#hdnBomId").val(),0); //使用-1即新建方法初始化OrderBOM
                            }

                        }else if (nowBomPara * 1 === 0 && $(this).val() * 1 !== 0) { //默认->创建副本
                            //从默认转变为副本，先读取副本历史记录，没有则使用默认
                            $("#tbBomComponent .ListTableOddRow").remove();//清空工单BOM信息
                            initOrderBOM(soId, $("#hdnBomId").val(),1);
                        }else if (nowBomPara * 1 === 0 && $(this).val() * 1 === 0) {  //默认
                            $("#tbBomComponent .ListTableOddRow").remove(); 
                            initOrderBOM(-1, $("#hdnBomId").val(),0); 
                        }else if (nowBomPara * 1 !== 0 && $(this).val() * 1 !== 0) {  //创建
                            $("#tbBomComponent .ListTableOddRow").remove(); 
                            initOrderBOM(soId, $("#hdnBomId").val(),1);  
                        }
                        if ($(this).val() * 1 === 0) {
                            $(".chkEditableBOM").attr("disabled", "disabled");
                        } else {
                            $(".chkEditableBOM").removeAttr("disabled");
                        }
                    });
            //绑定ITEM PARAM 模式事件
            $("#ddlItemPParam")
                .live("change",
                    function() {
                        //$(this).parent().prev('input').val($(this).val());
                        if (nowItemPara * 1 > 0 && $(this).val() * 1 === 0) {
                            alert("此选项将删除已存在的副本信息");
                        }
                        if ($(this).val() * 1 === 0) {
                            $(".chkEditableP.item").attr("disabled", "disabled");
                        } else {
                            $(".chkEditableP.item").removeAttr("disabled");
                        }
                    });
            //绑定STATION PARAM 模式事件
            $("#ddlOpePParam")
                .live("change",
                    function() {
                        //$(this).parent().prev('input').val($(this).val());
                        if (nowOpePara * 1 > 0 && $(this).val() * 1 === 0) {
                            if (confirm("此选项将删除已存在的副本信息")) {

                            }

                        }
                        if ($(this).val() * 1 === 0) {
                            $(".chkEditableP.station").attr("disabled", "disabled");
                        } else {
                            $(".chkEditableP.station").removeAttr("disabled");
                        }
                    });
        });

    //绑定初始读取信息
    function initOrderBOM(strID,BOMID,choosingFlag) {
        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxShopOrder.GetOrderBOM(strID,BOMID,choosingFlag);
        if (ajax.error == null && ajax.value != null) {
            var entityAry = ajax.value;
            this.rowSeq = entityAry.length;
            for (var i = 0; i < entityAry.length; i++) {
                addComponent(entityAry[i], false);
                if (entityAry[i].IsReplacement == 'True') {
                    this.rowSeq = rowSeq - 1;
                }
            }
        } else if (ajax.error != null) {
            alert(ajax.error.Message);
        }
    }

    //绑定初始工艺信息
    function initOrderParam(stationId, itemId) {
        var oType = '';
        if (stationId*1 === -1) {
            oType = 'item';
        } else {
            oType = 'station';
        }
        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxShopOrder.GetOrderParam(soId, stationId, itemId);
        if (ajax.error == null && ajax.value != null) {
            var entityAry = ajax.value;
            for (var i = 0; i < entityAry.length; i++) {
                addParams(entityAry[i], false, oType);
            }
        } else if (ajax.error != null) {
            alert(ajax.error.Message);
        }
    }

    function setSelStation(strJson, selectedItem) {
        var objJson;
        if (typeof strJson === 'undefined' || strJson === "") {
            return;
        } else {
            objJson = $.parseJSON(strJson);
        }
        if (typeof objJson === 'undefined') {
            return;
        }
        var ddlHtml = "<select class='ddlStation' id='ddlStation'> ";
        ddlHtml += "<option value='-1'>请选择工序</option> ";
        for (i = 0; i < objJson.length; i++) {
            var ItemIndex = objJson[i].ItemIndex;
            var ItemValue = objJson[i].ItemValue;
            //var ItemName = objJson[i].ItemName;
            if (selectedItem == ItemIndex) {
                ddlHtml += "<option selected=true value='" + ItemIndex + "'>" + ItemValue + "</option> ";
            } else {
                ddlHtml += "<option value='" + ItemIndex + "'>" + ItemValue + "</option> ";
            }
        }
        ddlHtml += "</select>";
        //$("#" + showID).append(ddlHtml);
        $(".spStation").html(ddlHtml);
    }

    function setShopOrderStatus(strJson, selectedItem) {
        var objJson;
        if (typeof strJson === 'undefined' || strJson === "") {
            return;
        } else {
            objJson = $.parseJSON(strJson);
        }
        if (typeof objJson === 'undefined') {
            return;
        }
        var ddlHtml = "<select class='ddlShopOrderStatus' id='ddlShopOrderStatus'> ";
    
        for (i = 0; i < objJson.length; i++) {
            var ItemIndex = objJson[i].ItemIndex;
            //var ItemValue = objJson[i].ItemValue;
            var ItemName =mesLang(objJson[i].ItemName);
            if (selectedItem == ItemIndex) {
                ddlHtml += "<option selected=true value='" + ItemIndex + "'>" + ItemName + "</option> ";
            } else {
                ddlHtml += "<option value='" + ItemIndex + "'>" + ItemName + "</option> ";
            }
        }
        ddlHtml += "</select>";  
        $(".spOrderStatus").html(ddlHtml);

    }
    function openChoosePage(flags) {
        var condition = "";
        switch (flags) {
        case 1:
            break;
        case 832:
            break;
        case 108:        //基础BOM
            condition = "State=1";
            if (nowBomPara*1 === 2) {
                //alert("已锁定了工单BOM副本，如确定更换，请先更改工单BOM更新模式");
                if (confirm("已锁定了工单BOM副本，是否确定更换BOM？") === false) 
                return false;
            }
            if ($("#hdnItemId").val() === '-1') {
                alert("请先选择产品");
                return false;
            }
            if (nowBomID !== '' && nowBomID * 1 > 0) {
                if (confirm("此操作将放弃对工单BOM的编辑记录") === false) {
                    return false;}}
            if ($("#hdnItemId").val()!=='-1') {
                  condition += " and ItemId="+$("#hdnItemId").val();
            };
                break;
            case 810: 
                if ($("#txtCustomer").val() != "" && $("#hdnItemId").val() != "") {
                    condition = "CustomerCode = (select CustomerCode from dbo.Basal_Customer WHERE CustomerName ='" + $("#txtCustomer").val()
                        + "') AND CustomerOrderID IN(SELECT CustomerOrderID FROM dbo.Prod_CustomerOrderDtl WHERE ItemID = '" + $("#hdnItemId").val() + "')";
                } else if ($("#txtCustomer").val() != "") {
                    condition = "CustomerCode = (select CustomerCode from dbo.Basal_Customer WHERE CustomerName ='" + $("#txtCustomer").val()
                        + "')  ";
                } else if ($("#hdnItemId").val() != "") {

                    condition = " CustomerOrderID IN(SELECT CustomerOrderID FROM dbo.Prod_CustomerOrderDtl WHERE ItemID = '" + $("#hdnItemId").val() + "')";
                }
               
            break;
        case 22:            //基础路由信息
            if (nowOpePara * 1 === 2) {
                if (confirm("已存在锁定的工单工序参数副本，是否确定更换路由？") === false) 
                return false;
            }
            condition = "R_Status=1";
            break;
        default:
           // condition = "1=1";
            break;
        }
        flag = flags;
        dialog({
            title: "<%= Common.ChooseWindow %>",
            src: "<%= WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=" +
                flags +
                "&Multiple=false&SearchCondition=" +
                condition +
                "&rnd=" +
                Math.random(),
            width: 680,
            height: 300
        });
    }


    function getChooseValue(list) {
        var ajax;
        
        //----工单编辑tab内容-begin----------
        if (flag == 10) {
            $("#txtCustomer").val(list[0][1]);
            $("#hdnCustomerId").val(list[0][0]);
        } else if (flag == 1) {
            $("#txtItemName").val(list[0][1] + formatChooseValue(list[0][2]));
            $("#hdnItemId").val(list[0][0]);

            //自动绑定当前版本产品BOM
 
            ajax = SKT.LeanMES.Web.AjaxServices.AjaxShopOrder.GetCurItemBom(list[0][0]);
            if (ajax.error == null && ajax.value != '[]') {
                var objList = JSON.parse(ajax.value);
                $("#txtBOM").val(objList[0].BomName);
                $("#hdnBomId").val(objList[0].ItemBomId);
                $("#txtBOM2").val(objList[0].BomName);
                $("#tbBomComponent .ListTableOddRow").remove();
                initOrderBOM(-1, $("#hdnBomId").val(),0);
            } else {
                //清空BOM信息
                $("#txtBOM").val('');
                $("#hdnBomId").val('-1');
                $("#txtBOM2").val('未绑定');
                $("#tbBomComponent .ListTableOddRow").remove();//清空工单BOM信息
            }
            
            GetItemRouter(list[0][0]);
             
        }else if (flag == 832) {
            $("#txtItemName").val(list[0][1] + formatChooseValue(list[0][2]));
            $("#hdnItemId").val(list[0][0]);

            $("#<%=this.txtMask.ClientID %>").val(list[0][9]);//读取掩码
            $("#<%=this.txtMaskID.ClientID %>").val(list[0][8]);//读取掩码
            //自动绑定当前版本产品BOM
 
            ajax = SKT.LeanMES.Web.AjaxServices.AjaxShopOrder.GetCurItemBom(list[0][0]);
            if (ajax.error == null && ajax.value != '[]') {
                var objList = JSON.parse(ajax.value);
                $("#txtBOM").val(objList[0].BomName);
                $("#hdnBomId").val(objList[0].ItemBomId);
                $("#txtBOM2").val(objList[0].BomName);
                $("#tbBomComponent .ListTableOddRow").remove();
                initOrderBOM(-1, $("#hdnBomId").val(),0);
            } else {
                //清空BOM信息
                $("#txtBOM").val('');
                $("#hdnBomId").val('-1');
                $("#txtBOM2").val('未绑定');
                $("#tbBomComponent .ListTableOddRow").remove();//清空工单BOM信息
            }
            
            GetItemRouter(list[0][0]);

        }
        else if (flag == 22) {
            $("#txtRouter").val(list[0][1]);
            $("#hdnRId").val(list[0][0]);
            ajax = SKT.LeanMES.Web.AjaxServices.AjaxShopOrder.getRouterDetail("RouterID",$("#hdnRId").val());
            if (ajax.error == null && ajax.value != null) {
                setSelStation(ajax.value, -1);
                $("#tbParams .ListTableOddRow").remove();
            }else if (ajax.error != null) {
                alert(ajax.error.Message);
            }
        } else if (flag == 108) {
        //BOM Name + Item Name
            $("#txtBOM").val(list[0][1] + formatChooseValue(list[0][2]));
            $("#hdnBomId").val(list[0][0]);
            $("#txtBOM2").val(list[0][1] + formatChooseValue(list[0][2]));
            $("#tbBomComponent .ListTableOddRow").remove();
            initOrderBOM(-1, $("#hdnBomId").val(),0);
        }
        else if (flag == 810) {
            $("#txtCustomerOrder").val(list[0][1]);
        }
        flag = -1;
        //----工单编辑tab内容-end----------
        //----BOM编辑tab内容-begin----------
        switch (this.chooseType) {
        case 'Item':
            rowObj.cells[0].children[0].value = list[0][2]; //ItemCode
            rowObj.cells[1].children[0].value = list[0][0]; //ItemID
            rowObj.cells[1].children[1].value = list[0][1]; //ItemName
            break;
        case 'UnitType':
            rowObj.cells[2].children[0].value = list[0][0];
            rowObj.cells[2].children[1].value = list[0][2];
            break;
        case 'Ope':
            rowObj.cells[4].children[0].value = list[0][0];
            rowObj.cells[4].children[1].value = list[0][1];
            break;
        case 'Cust':
            rowObj.cells[6].children[0].value = list[0][0];
            rowObj.cells[6].children[1].value = list[0][1];
            rowObj.cells[5].children[0].value = 'Y'; //客指用料显示
            break;
        default:
            break;
        }
        //----BOM编辑tab内容--end---------
    }

    function Save() {
        if (checkInputIsOK()) {
            var entity = {};
            entity.ProdOrderID = soId;
            entity.OrderNO = $("#txtOrderNO").val();
            entity.OrderType = $("#ddlOrderType").val();
            entity.Status = $("#ddlShopOrderStatus").val();
            entity.Priority = $("#txtPriority").val();
            entity.ItemId = $("#hdnItemId").val();
            entity.BOMId = $("#hdnBomId").val();
            entity.RouterId = $("#hdnRId").val();
            entity.CustomerID = $("#hdnCustomerId").val();
            entity.CustomerOrder = $("#txtCustomerOrder").val();
            entity.CustomerOrderQty = formatNumberStr($("#txtCustomerOrderQty").val());
            entity.Qty_to_Build = $("#txtQty_to_Build").val();
            entity.CreateBy = '<%= AccountController.GetCurrentUser().UserName %>';
            entity.ModifyBy = '<%= AccountController.GetCurrentUser().UserName %>';
            entity.PrivacyBOM = $("#ddlPrivacyBOM").val();
            entity.PrivacyOpeParam = $("#ddlOpePParam").val();
            entity.PrivacyItemParam = $("#ddlItemPParam").val();
            entity.MaskId = $("#<%=this.txtMaskID.ClientID%>").val();
            entity.BomVersion = $("#<%=this.txtBomVersion.ClientID%>").val();

            var pst = formatDate($("#txtPlanned_Start_Time").val());
            var pcd = formatDate($("#txtPlanned_Completed_Date").val());
            var ssd = pst;
            var sct = pcd;
            //工单BOM
            var obOrderNo = $("#txtOrderNO").val();
            //var obSeq = document.getElementsByName("txtSeq"); //顺序            
            var obItemID = document.getElementsByName("txtItemID"); //物料CODE
            var obUnitTypeID = document.getElementsByName("txtUnitTypeID"); //数据类型/单位
            var obTotalNum = document.getElementsByName("txtTotalNums"); //总用量
            var obPerNum = document.getElementsByName("txtPerNums"); //每次用量
            var obOpeID = document.getElementsByName("txtOperationID"); //位置
            var obCustID = document.getElementsByName("txtCustID"); //客户/供应商ID
            var obIsRe = document.getElementsByName("txtIsRe"); //替换料
             
            var obSeqStr = "";
            var obItemIDStr = "";
            var obUnitTypeIDStr = "";
            var obTotalNumStr = "";
            var obPerNumStr = "";
            var obOpeIDStr = "";
            var obCustIDStr = "";
            var obIsReStr = "";

            //工艺参数信息
            var opSeq = document.getElementsByName("txtPSeq"); //顺序            
            var opStationID = document.getElementsByName("txtPStationID"); //工序
            var opParamName = document.getElementsByName("txtParamName"); //参数名
            var opParamValue = document.getElementsByName("txtParamValue"); //参数值
            var opParamRemark = document.getElementsByName("txtParamRemark"); //Remark
            var opItemID = document.getElementsByName("txtPItemID"); //  ItemID
            var opSeqStr = '';
            var opStationStr = '';
            var opParaNameStr = '';
            var opParamValueStr = '';
            var opParamRemarkStr = '';
            var opItemIDStr = '';
            
            //验证
            if (entity.PrivacyBOM * 1 > 0 && obItemID.length === 0) {
                alert("当前工单BOM更新模式不允许提交空内容");
                return false;
            }

            //Bom的物料编号为空,不能保存
            for (var i = 0; i < obItemID.length; i++) {
                if($.trim(obItemID[i].value) =="-1" || $.trim(obItemID[i].value) == "0"){
                    alert("请选择Bom物料");
                    return false;
                }
            }

            //更新基本信息
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxShopOrder.EditShopOrder(entity, pst, pcd, ssd, sct);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            else{
                //modify by yz.xiong 返回新增后的主键ID
                soId = ajax.value;
            }
            
            //更新工单BOM
            for (var i = 0; i < obItemID.length; i++) {
                //只有当替代料有内容的时候，才能保存
                if($.trim(obItemID[i].value)!="-1"){
                    //                obSeqStr += obSeq[i].value + ",";
                    obItemIDStr += obItemID[i].value + ",";
                    //                obItemCodeStr += obItemCode[i].value + ",";
                    //                obItemNameStr += obItemName[i].value + ",";
                    obUnitTypeIDStr += obUnitTypeID[i].value + ",";
                    //obTotalNumStr += obTotalNum[i].value + ",";
                    obPerNumStr += obPerNum[i].value + ",";
                    obOpeIDStr += obOpeID[i].value + ",";
                    obCustIDStr += obCustID[i].value + ",";
                    obIsReStr += obIsRe[i].value + ",";
                }
            }
            //            obSeqStr = obSeqStr.slice(0, -1);
            obItemIDStr = obItemIDStr.slice(0, -1);
            obUnitTypeIDStr = obUnitTypeIDStr.slice(0, -1);
            //obTotalNumStr = obTotalNumStr.slice(0, -1);
            obPerNumStr = obPerNumStr.slice(0, -1);
            obOpeIDStr = obOpeIDStr.slice(0, -1);
            obCustIDStr = obCustIDStr.slice(0, -1);
            obIsReStr = obIsReStr.slice(0, -1);

            ajax = SKT.LeanMES.Web.AjaxServices.AjaxShopOrder.EditOrderBOM(obOrderNo,
//                    obSeqStr,
                    obItemIDStr,
                    obUnitTypeIDStr,
                    obTotalNumStr,
                    obPerNumStr,
                    obOpeIDStr,
                    obCustIDStr,
                    obIsReStr,
                    LoginUser,
                    entity.PrivacyBOM);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            //更新工单工艺参数
            for (var i = 0; i < opParamName.length; i++) {
                opSeqStr += opSeq[i].value + ",";
                opStationStr += (opStationID[i] ? opStationID[i].value : '-1') + ",";
                opParaNameStr += opParamName[i].value + ",";
                opParamValueStr += opParamValue[i].value + ",";
                opParamRemarkStr += opParamRemark[i].value + ",";
                opItemIDStr += opItemID[i].value + ",";
            }
            opSeqStr = opSeqStr.slice(0, -1);
            opStationStr = opStationStr.slice(0, -1);
            opParaNameStr = opParaNameStr.slice(0, -1);
            opParamValueStr = opParamValueStr.slice(0, -1);
            opParamRemarkStr = opParamRemarkStr.slice(0, -1);
            opItemIDStr = opItemIDStr.slice(0, -1);
            ajax = SKT.LeanMES.Web.AjaxServices.AjaxShopOrder
                .EditOrderParams(obOrderNo,
                    opSeqStr,
                    opStationStr,
                    opParaNameStr,
                    opParamValueStr,
                    opParamRemarkStr,
                    LoginUser,
                    opItemIDStr,
                    entity.PrivacyItemParam,
                    entity.PrivacyOpeParam);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            //保存扩展信息
            var extIds = new Array();
            $("input[class='ExtId']").each(function () {
                extIds.push($(this).val());
            });
            var extFieldsIds = new Array();
            $("input[class='ExtFieldsId']").each(function () {
                extFieldsIds.push($(this).val());
            });
            var extFieldValues = new Array();
            $("input.ExtFieldValue").each(function () {
                if ($(this).attr("type") == "radio") {
                    if ($(this).is(":checked")) {
                        extFieldValues.push($(this).val().toString());
                    } else {
                        extFieldValues.push("null");
                    }
                } else {
                    if ($(this).val() != null && $(this).val() != "") {
                        extFieldValues.push($(this).val().toString());
                    } else {
                        extFieldValues.push("null");
                    }
                }
            });
            var extIdStrs = extIds.join(',') + ',';
            var extFieldsIdStrs = extFieldsIds.join(',') + ',';
            var extFieldValueStrs = extFieldValues.join(',') + ',';
            var extAjax = SKT.LeanMES.Web.AjaxServices.AjaxBaseExt.BaseExtInfoListEdit(extIdStrs, extFieldsIdStrs, extFieldValueStrs, soId, "PROD_ORDER");
            if (extAjax.error != null) {
                alert(extAjax.error.Message);
                return false;
            }


            alert("<%= Messages.SaveInSuccess %>");
            try{
                parent.window.UpdateList(entity.OrderNO);
            }
            catch(err){
                window.parent.closeTab(window.parent.getCurrentTab()[0]);
            }
        }
    }

    function checkDateTimeBox() {
        $(".DateTimeBox")
            .bind("change",
                function() {
                    var date = $(this);
                    if (date.val().length == 10) {
                        date.val(date.val().substr(0, 10) + " 00:00");
                    }
                    if (date.val().length != 16 && date.val().length != 0) {
                        alert("<%= Messages.InvalidateDate %>");
                        $(this).val("");
                        return;
                    }
                });
    }

    function checkInputIsOK() {
        if ($("#hdnItemId").val() == "-1" ||
            isNull($("#txtOrderNO").val()) ||
            isNull($("#txtQty_to_Build").val()) ||
            isNull($("#txtPriority").val())) {
            alert("<%= Messages.WithAsteriskIsRequiredAlert %>");
            return false;
        }
        if (!isNumber($("#txtQty_to_Build").val()) || !isNumber($("#txtPriority").val())) {
            alert("<%= Messages.MustbeNumber %>" + "和正整数");
            return false;
        }
        if( parseInt($("#txtPriority").val())>9999 || parseInt($("#txtPriority").val())<0){
            alert("优先级范围不在(0~9999)");
            return false;
        }

        if ($("#txtQty_to_Build").val() == "0") {
            alert("工单数量不能为0");
            return false;
        }
        if (!isNull($("#txtCustomerOrderQty").val())) {
            if (!isNumber($("#txtCustomerOrderQty").val())) {
                alert("<%= Messages.MustbeNumber %>");
                return false;
            }
        }
        if (!compareStartEndTime(formatDate($("#txtPlanned_Start_Time").val()),
            formatDate($("#txtPlanned_Completed_Date").val()))) {
            return false;
        }
        /*2016-12-20 BirongLiang 增加时间验证*/
        if ($("#txtPlanned_Start_Time").val() !== '' && $("#txtPlanned_Completed_Date").val() !== '') {
            var startT = (new Date).getDate($("#txtPlanned_Start_Time").val()) ;
            var completT = (new Date).getDate($("#txtPlanned_Completed_Date").val());
            if (startT > completT) {
                alert("开工时间不能大于完成时间");
                return false;
            }
        }

        return true;
    }

    function formatDate(dateStr) {
        return (dateStr == "" ? "9999-12-31 00:00" : dateStr);
    }

    function formatChooseValue(vals) {
        return (vals == "" ? "" : " (" + vals + ")");
    }

    function formatNumberStr(vals) {
        return (vals == "" ? "0" : vals);
    }

    function compareStartEndTime(start, end) {
        var result = true;
        if (start != "" && end != "") {
            start = start.replace(/-/g, "").replace(/ /g, ".").replace(/:/g, "");
            end = end.replace(/-/g, "").replace(/ /g, ".").replace(/:/g, "");
            if (parseFloat(end) < parseFloat(start)) {
                result = false;
                alert("<%= Messages.StartDateTimeGreaterThanEndDateTime %>");
            }
        }
        return result;
    }

    //增加工单BOM
    function addComponent(entity, callFromButton, obj) {
        if (callFromButton === true && $("#txtBOM2").val() === "") {
            alert("请先在基本信息绑定BOM");
            return false;
        }
        if (callFromButton === true && $("#ddlPrivacyBOM").val() === "0") {
            alert("若要编辑工单BOM，请先选择更新模式");
            return false;
        }
        if (obj) {
            this.rowSeq += 1;
        }
        $("#tbBomComponent .ListTableEmptyDataRow").remove();
        if (entity == null) {
            entity = {};
//            entity.AssSequence = rowSeq > 0 ? rowSeq : 1;
            entity.ItemID = -1;
            entity.ItemCode = "";
            entity.ItemName = "";
            entity.DataTypeID = -1;
            entity.DataTypeName = "";
            entity.PerNum = 0;
            entity.AssOperationID = -1;
            entity.Operation = '';
            entity.IsCustomize = "";
            entity.CustomID = -1;
            entity.CustName = '';
            entity.CustCode = '';
            entity.IsReplacement = 0;
            entity.RplPercent = 0;
            //   需求量=用量x工单数 
            entity.CompCount = 0;
            //entity.CompCount = entity.PerNum * $("#txtQty_to_Build").val();
        }

        var row, cell;
        if (typeof callFromButton === 'number') {                   //增加替代料的情况
            //rowNewIdx =Math.abs(tab.rows.length - this.rowSeq) + callFromButton ;
            rowNewIdx = callFromButton + 1;
        } else {
            rowNewIdx = tab.rows.length;
        }
        row = tab.insertRow(rowNewIdx);
        row.className = "ListTableOddRow";
        //序号
//        cell = row.insertCell(0);
//        cell.align = "center";
//        cell.innerHTML = "<input type=\"text\" class='chkEditableBOM' name=\"txtSeq\" style=\"width:20px;\" value=\"" +
//            entity.AssSequence +
//            "\"/>";
        //产品编码
        cell = row.insertCell(0);
        cell.align = "center";
        cell.innerHTML = "<input type=\"text\" name=\"txtItemCode\"  style=\"width:140px;\"   value=\"" +
            entity.ItemCode +
            "\" disabled=\"disabled\">" +
            "<input type=\"button\" id=\"btnSelectItems\" onclick=\"selChoosePage('Item',this);\" class='ButtonBox chkEditableBOM'  value=\"...\"  />";
        //产品名称
        cell = row.insertCell(1);
        cell.align = "center";
        cell.innerHTML = "<input type=\"hidden\" name=\"txtItemID\" value=\"" +
            entity.ItemID +
            "\" />" +"<input type='text' readonly='readonly' style='border:0px' value='"+ entity.ItemName +"'>";

        //数据类型
        cell = row.insertCell(2);
        cell.align = "center";
        cell.innerHTML = "<input type=\"hidden\" name=\"txtUnitTypeID\" value=\"" +
            entity.DataTypeID +
            "\" /><input type=\"text\" name=\"txtUnitType\" style=\"width:30px;\"   value=\"" +
            entity.DataTypeName +
            "\" disabled=\"disabled\">" +
            "<input type=\"button\" id=\"btnUnitType\" onclick=\"selChoosePage('UnitType',this);\" class='chkEditableBOM ButtonBox'  value=\"...\"  />";

//        //需求量 
//        cell = row.insertCell(3);
//        cell.align = "center";
//        cell.innerHTML = "<input type=\"text\" name=\"txtTotalNums\" style=display:none;\"width:20px;\" value=\"" +
//            (entity.CompCount) +
//            "\" class='chkEditableBOM NumericBox50 txtTotalNums' onkeyup=\"this.value=this.value.replace(/\\D/g,'')\" onafterpaste=\"this.value=this.value.replace(/\\D/g,'')\"/>";
        //每次用量
        cell = row.insertCell(3);
        cell.align = "center";
        cell.innerHTML = "<input type=\"text\" name=\"txtPerNums\" style=\"width:30px;\" value=\"" +
            parseFloat(Number(entity.PerNum).toFixed(6)) +
            "\" class='chkEditableBOM NumericBox50' onkeyup=\"this.value=this.value.replace(/[^0-9\.]\D*$/,'')\" onafterpaste=\"this.value=this.value.replace(/[^0-9\.]\D*$/,'')\"/>";
        //工序(位置)
        cell = row.insertCell(4);
        cell.align = "center";
        //cell.width = "100px";
        cell.innerHTML = "<input type=\"hidden\" name=\"txtOperationID\" value=\"" +
            entity.AssOperationID +
            "\" disabled=\"disabled\">" +"<input type='text' name='txtOpeName' value='"+ entity.Operation +"' style='width:50px' disabled='disabled'>"+
            "<input type=\"button\" id=\"btnSelectItems\" onclick=\"selChoosePage('Ope',this);\" class='chkEditableBOM ButtonBox'  value=\"...\"  />";
        //客指用料
        cell = row.insertCell(5);
        cell.align = "center";
        var txtIsCustomize = entity.CustomID * 1 > -1 ? 'Y' : 'N';
        cell
            .innerHTML =
            "<input type=\"text\" name=\"txtIsCustomize\" style=\"width:20px;\"disabled=\"disabled\" value='" +
            txtIsCustomize +
            "'>";

        //供应商简称
        cell = row.insertCell(6);
        cell.align = "center";
        cell.innerHTML = "<input type=\"hidden\" name=\"txtCustID\" value=\"" +
            entity.CustomID +
            "\" /><input type=\"text\" name=\"txtCust\"  style=\"width:30px;\"   value=\"" +
            entity.CustName +
            "\" disabled=\"disabled\">" +
            "<input type=\"button\" id=\"btnSelectItems\" onclick=\"selChoosePage('Cust',this);\" class='chkEditableBOM ButtonBox'  value=\"...\"  />";

        //替代料
        cell = row.insertCell(7);
        cell.align = "center";
        var isReplacement = entity.IsReplacement ? entity.IsReplacement : 0;
        if (typeof callFromButton === 'number' || entity.IsReplacement == 'True') {
            cell.innerHTML = "<input type=\"hidden\" name=\"txtIsRe\" value=\"" + isReplacement + "\" />替代料";
        } else {
            cell.innerHTML = "<input type=\"hidden\" name=\"txtIsRe\" value=\"" + isReplacement + "\" />";
            //+ "<input type=\"button\" id=\"btnAddReplac\" onclick=\"addReplace(this);\"  value=\"新增替代料\"  />";           
            cell
                .innerHTML +=
                "<span id='btnAddReplac' class='chkEditableBOM' style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"addReplace(this)\">" + mesLang("新增替代料") + "</span>";
        }

        //使用比例
        cell = row.insertCell(8);
        cell.align = "center";
        entity.RplPercent = typeof entity.RplPercent == 'undefined' ? '' : entity.RplPercent;
        cell.innerHTML = "<input type=\"text\" name=\"txtRplPercent\" style=\"width:25px;\" value=\"" +
            entity.RplPercent +
            "\" class=\"NumericBox50\" onkeyup=\"this.value=this.value.replace(/\\D/g,'')\" onafterpaste=\"this.value=this.value.replace(/\\D/g,'')\"/>";

        //操作按钮
        cell = row.insertCell(9);
        cell.align = "center";
        cell.innerHTML =
            "<span style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"deleteItem(this)\"><%= Buttons.COM_Delete %></span>";

    }

    //删除BOM组件信息
    function deleteItem(obj) {
        //alert(obj.parentElement.parentElement.previousSibling.cells[0].children[0].value)
        var _OrderNo = $("#txtOrderNO").val();
        var _AssSeq = obj.parentElement.parentElement.cells[0].children[0].value;
        var _ItemID = obj.parentElement.parentElement.cells[2].children[0].value;
        //BirongLiang@2016-11-02
//        if (soId == -1) {
            tab.deleteRow(obj.parentElement.parentElement.rowIndex);
//        } else {
//            if (!window.confirm("<%= Messages.ConfirmDelete %>")) {
//                return false;
//            }
//            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxShopOrder.DeleteOrderBOM(_OrderNo, _AssSeq, _ItemID);
//            if (ajax) {
//                tab.deleteRow(obj.parentElement.parentElement.rowIndex);
//            }
//            this.rowSeq = rowSeq - 1;
//        }
    }

    function selChoosePage(type, obj) {
        if (typeof type === 'undefined' || type === "") {
            return false;
        }
        if (type === 'Item') {
            this.chooseType = 'Item';
            rowObj = obj.parentElement.parentElement;
            dialog({
                title: "<%= Common.ChooseWindow %>",
                src: "<%= WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=1&Multiple=false&rnd=" +
                    Math.random(),
                width: 650,
                height: 350
            });
        }
        if (type === 'UnitType') {
            this.chooseType = 'UnitType';
            rowObj = obj.parentElement.parentElement;
            dialog({
                title: "<%= Common.ChooseWindow %>",
                src: "<%= WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=2&Multiple=false&rnd=" +
                    Math.random(),
                width: 650,
                height: 350
            });
        }
        if (type === 'Ope') {
            this.chooseType = 'Ope';
            rowObj = obj.parentElement.parentElement;
            dialog({
                title: "<%= Common.ChooseWindow %>",
                src: "<%= WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=8&Multiple=false&rnd=" +
                    Math.random(),
                width: 650,
                height: 350
            });
        }
        if (type === 'Cust') {
            this.chooseType = 'Cust';
            rowObj = obj.parentElement.parentElement;
            dialog({
                title: "<%= Common.ChooseWindow %>",
                src:
                    "<%= WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=10&Multiple=false&rnd=" +
                        Math.random(),
                width: 650,
                height: 350
            });
        } else {
            return false;
        }
    }

    //增加替代料
    function addReplace(obj) {
        var thisRow = obj.parentElement.parentElement.rowIndex;
        
        var dataTypeId = $(obj.parentElement.parentElement).find("input[name='txtUnitTypeID']").val();
        var dataTypeName = $(obj.parentElement.parentElement).find("input[name='txtUnitType']").val();
        var comCount = $(obj.parentElement.parentElement).find("input[name='txtTotalNums']").val();
        var perNum = $(obj.parentElement.parentElement).find("input[name='txtPerNums']").val();
        var assOperationID = $(obj.parentElement.parentElement).find("input[name='txtOperationID']").val();
        var operation = $(obj.parentElement.parentElement).find("input[name='txtOpeName']").val();
        var rePercent = $(obj.parentElement.parentElement).find("input[name='txtRplPercent']").val();

        entity = {};
        //alert(obj.parentElement.parentElement.rowIndex);
//        entity.AssSequence = obj.parentElement.parentElement.cells[0].children[0].value;
        entity.ItemID = -1;
        entity.ItemCode = "";
        entity.ItemName = "";
        entity.DataTypeID = dataTypeId;
        entity.DataTypeName = dataTypeName;
        entity.CompCount = comCount;
        entity.PerNum = perNum;
        entity.AssOperationID = assOperationID;
        entity.Operation = operation;
        entity.IsCustomize = "";
        entity.CustomID = -1;
        entity.CustName = '';
        entity.CustCode = '';
        entity.IsReplacement = 1;
        entity.RplPercent = rePercent;
        addComponent(entity, thisRow);
    }

    //新增工单工艺参数
    function addParams(entity, doClick, type) {
        if (type == 'station') { //StationParam
            $("#tbParams .ListTableEmptyDataRow").remove();
            if (entity == null && doClick !== false) {
                entity = {};
                entity.ItemId = -1;
                entity.StationId = $("#ddlStation").val();
                entity.ParamName = '';
                entity.ParamValue = '';
                entity.ParamSeq = 0;
                entity.Remark = '';
                //entity.CreateBy ='';
            }
            var row, cell;
            rowNewIdx = tabParams.rows.length;
            row = tabParams.insertRow(rowNewIdx);
        } else { //itemParam
            $("#tbParaItem .ListTableEmptyDataRow").remove();
            if (entity == null && doClick !== false) {
                entity = {};
                entity.ItemId = itemID;
                entity.StationId = -1;
                entity.ParamName = '';
                entity.ParamValue = '';
                entity.ParamSeq = 0;
                entity.Remark = '';
            }
            var row, cell;
            rowNewIdx = tabItemParams.rows.length;
            row = tabItemParams.insertRow(rowNewIdx);
        }
        row.className = "ListTableOddRow";
        var cellNum = 0;
        //序号
        cell = row.insertCell(cellNum++);
        cell.align = "center";
        cell.innerHTML = "<input type=\"text\" class='chkEditableP " +
            type +
            "' name=\"txtPSeq\" style=\"width:30px;\" value=\"" +
            entity.ParamSeq +
            "\" >";
        if (type == 'station') {
            //工序
            cell = row.insertCell(cellNum++);
            cell.align = "center";
            //cell.width = "100px";
            cell.innerHTML = "<input type=\"hidden\" name=\"txtPStationID\" style=\"width:80px;\" value=\"" +
                entity.StationId +
                "\" >";
            cell.innerHTML += $("#ddlStation").find("option:selected").text();
        }
        //参数
        cell = row.insertCell(cellNum++);
        cell.align = "center";
        cell
            .innerHTML =
            "<input type=\"hidden\" readonly='readonly' disabled='disabled' name=\"txtParamName\" style=\"width:150px;\" value=\"" + entity.ParamName + "\"  />";
        cell.innerHTML += entity.ParamName;
        //参数值
        cell = row.insertCell(cellNum++);
        cell.align = "center";
        cell.innerHTML = "<input type=\"text\" name=\"txtParamValue\" class='chkEditableP " +
            type +
            "' style=\"width:150px;\" value=\"" +
            entity.ParamValue +
            "\"  />";
        //remark
        cell = row.insertCell(cellNum++);
        cell.align = "center";
        var _txtRemark = entity.Remark || "";
        cell.innerHTML = "<input type=\"text\" name=\"txtParamRemark\" class='chkEditableP " +
            type +
            "' style=\"width:200px;\" value=\"" +
            _txtRemark +
            "\"  />";
        cell.innerHTML += "<input type=\"hidden\" name=\"txtPItemID\" style='display:none' value=\"" +
            entity.ItemId +
            "\"  />";
        //(不允许删除工艺参数@2016/07/28)
//        //操作按钮
//        cell = row.insertCell(cellNum++);
//        cell.align = "center";
//        cell.innerHTML = "<span style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"deleteParam(this)\"><%= Buttons.COM_Delete %></span>";


        //setSelStation(hfJSONStation,entity.StationId);
    }

    //删除工序信息
    function deleteParam(obj) {
        //alert(obj.parentElement.parentElement.previousSibling.cells[0].children[0].value)
        var _OrderNo = $("#txtOrderNO").val();
        //var _Seq = obj.parentElement.parentElement.cells[0].children[0].value;
        var _StationID = obj.parentElement.parentElement.cells[1].children[0].value;
        var _ParamName = obj.parentElement.parentElement.cells[2].children[0].value;
        if (soId === -1) {
            tabParams.deleteRow(obj.parentElement.parentElement.rowIndex);
        } else {
            if (!window.confirm("<%= Messages.ConfirmDelete %>")) {
                return false;
            }
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxShopOrder.DeleteParam(_OrderNo, _StationID, _ParamName);
            if (ajax) {
                tabParams.deleteRow(obj.parentElement.parentElement.rowIndex);
            }
        }
    }

    //
    $("#txtQty_to_Build").change(function() {
        var orderQty = $("#txtQty_to_Build").val() * 1;
        $(".txtTotalNums")
            .each(function() {
                $(this).val(orderQty * $(this).parent().next().find("input").val());
            });
    });

    /*获取产品设置好的路由信息*/
    function GetItemRouter(itemId){
         var ajax = SKT.LeanMES.Web.AjaxServices.AjaxProduct.GetItemByItem(itemId);
         if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            else{
                 $("#txtRouter").val(ajax.value.RouterName);
                $("#hdnRId").val(ajax.value.RouterID);
            }
    }

    /**
    *选择掩码组信息
    **/
    function selectMask() {
        dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=24&CallBackFunc=getMaskInfo&Multiple=false&rnd=" + Math.random(), width: 650, height: 350 });
    }

    /**
    *设置掩码组信息
    **/
    function getMaskInfo(list) {
        $("#<%=this.txtMask.ClientID %>").val(list[0][1]);
        $("#<%=this.txtMaskID.ClientID %>").val(list[0][0]); 
    }
    </script>

       <script type="text/javascript">
        
/*加载扩展字段信息*/
function loadExtsionInfos() {
    var itemId = '<%= Request.QueryString["ID"] %>';
    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxBaseExt.GetExtsionInfoListByItemId(itemId, "PROD_ORDER");
            if (ajax.error != null) {
                return false;
            }
            var list = ajax.value;
            if (list != null && list != undefined && list.length > 0) {
                /*显示扩展字段信息*/
                var r = "";
                var listLength = list.length;
                for (var i = 0; i < listLength; i++) {
                    if (i % 2 == 0) {
                        r += "<tr>";
                    }

                    //必填的判断，modified by zhi.li 20180824
                    var extensionFieldIsAllowNull=0;
                    if (list[i].ExtFieldIsAllowNull==false)
                    {
                        extensionFieldIsAllowNull=1;
                        r += "<td class='Label2'><label id='lblExtFieldDescription" + i + "' name='ExtFieldDescription'>" + list[i].ExtFieldDescription + "</label><em>*</em>";
                    }
                    else
                    {
                        r += "<td class='Label2'><label id='lblExtFieldDescription" + i + "' name='ExtFieldDescription'>" + list[i].ExtFieldDescription + "</label>";
                    }


                    r += "<input type='hidden' id='txtExtId" + i + "' class='ExtId' value='" + (list[i].ExtId == null ? -1 : list[i].ExtId) + "' /><input type='hidden' id='txtExtFieldsId" + i + "' class='ExtFieldsId' value='" + list[i].ExtFieldsId + "' /><input type='hidden' id='txtSequence" + i + "' class='Sequence' value='" + list[i].Sequence + "' />";
                    r += "</td><td class='Field2'>";
                    //字段类型为布尔
                    if (list[i].ExtFieldType == "bit" || list[i].ExtFieldType == "bool") {
                        if (list[i].ExtFieldValue == "true" || list[i].ExtFieldValue == "True") {
                            r += "<%=Resources.lang.Yes %><input type='radio' id='radExtFieldValue" + i + "' tag='radExtFields' name='radExtFields" + list[i].ExtFieldName + "' class='ExtFieldValue' checked='checked' value='true' />&nbsp;&nbsp;&nbsp;&nbsp;<%=Resources.lang.No %><input type='radio' id='radExtFieldValue" + i + "" + i + "' tag='radExtFields' name='radExtFields" + list[i].ExtFieldName + "' value='false";
                        } else if (list[i].ExtFieldValue == "false" || list[i].ExtFieldValue == "False") {
                            r += "<%=Resources.lang.Yes %><input type='radio' id='radExtFieldValue" + i + "' tag='radExtFields' name='radExtFields" + list[i].ExtFieldName + "' value='true' />&nbsp;&nbsp;&nbsp;&nbsp;<%=Resources.lang.No %><input type='radio' id='radExtFieldValue" + i + "" + i + "' tag='radExtFields' name='radExtFields" + list[i].ExtFieldName + "' class='ExtFieldValue' value='false' checked='checked";
                        } else {
                            r += "<%=Resources.lang.Yes %><input type='radio' id='radExtFieldValue" + i + "' tag='radExtFields' name='radExtFields" + list[i].ExtFieldName + "' class='ExtFieldValue' value='true' />&nbsp;&nbsp;&nbsp;&nbsp;<%=Resources.lang.No %><input type='radio' id='radExtFieldValue" + i + "" + i + "' tag='radExtFields' name='radExtFields" + list[i].ExtFieldName + "' value='false";
                        }
                } else if (list[i].ExtFieldType == "datetime") { //字段类型为时间
                    r += "<input type='text' id='txtExtFieldValue" + i + "' name='dateExtFields' class='ExtFieldValue' IsRequired='"+extensionFieldIsAllowNull+"' readonly value='";
                    if (list[i].ExtFieldValue != null && list[i].ExtFieldValue != undefined && list[i].ExtFieldValue != "") {
                        r += list[i].ExtFieldValue;
                    }
                } else if (list[i].ExtFieldType == "int") {
                    r += "<input type='text' id='txtExtFieldValue" + i + "' name='intExtFields' class='ExtFieldValue'  IsRequired='"+extensionFieldIsAllowNull+"' value='";
                    if (list[i].ExtFieldValue != null && list[i].ExtFieldValue != undefined && list[i].ExtFieldValue != "") {
                        r += list[i].ExtFieldValue;
                    }
                } else { //字段类型为字符
                    r += "<input type='text' id='txtExtFieldValue" + i + "' name='txtExtFields' class='ExtFieldValue' IsRequired='"+extensionFieldIsAllowNull+"'  value='";
                    if (list[i].ExtFieldValue != null && list[i].ExtFieldValue != undefined && list[i].ExtFieldValue != "") {
                        r += list[i].ExtFieldValue;
                    }
                }

                r += "' /></td>";
                if (i % 2 == 0 && i == listLength - 1) {
                    r += "<td class='Label2'></td><td class='Field2'></td></tr>";
                } else if (i % 2 != 0) {
                    r += "</tr>";
                } else {
                    r += "";
                }
            }
            $("#trNewInfo").remove();
            $("#tblExtensionInfos").append(r);
        } else {
            $("#tblExtensionInfos tr").remove();
            $("#tblExtensionInfos").append("<tr><td colspan='4' style='text-align:center;'><font color='red'><%=Resources.lang.NoExtendedInfos %>！</font></td>");
        }
}

        
    $(function () {
        loadExtsionInfos();
        $("input[name='dateExtFields']").datepicker({
            showHms: false
        });
        $("input[name='intExtFields']").change(function () {
            if (!this.value.match(/^(?:[\+\-]?\d+(?:\.\d+)?|\.\d*?)?$/)) {
                this.value = "";
                alert("只能输入数字");
                this.focus();
            }
        });
        changeRadioClass();
    });

    function changeRadioClass() {
        $('input[tag="radExtFields"]').click(function () {
            $(this).attr('class', 'ExtFieldValue');
            $(this).siblings().removeClass();
        });
    }

    </script>
</asp:Content>
