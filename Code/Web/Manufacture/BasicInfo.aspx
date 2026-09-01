<%@ Page Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="true"
    EnableEventValidation="false" Inherits="SKT.LeanMES.Web.Manufacture.BasicInfo"
    Title="BasicInfoPage" CodeBehind="BasicInfo.aspx.cs" ViewStateMode="Disabled" %>

<asp:Content ID="searchConditions" runat="server" ContentPlaceHolderID="viewcontent">
    <!----------------------------------------------------------------------------------
                                        信息中心
创建时间：2014-11-13
更新时间:
创建人：zhibin.Chen
修改人：
------------------------------------------------------------------------------------>
    <style type="text/css">
        .ListTable {
            margin-left: 0px;
            width: 100%;
        }

            .ListTable tr td {
                background-color: #F8F8F8;
            }

        .InfoTable {
            height: 179px;
            overflow: auto;
        }

        .bold {
            font-weight: bold;
        }

        .InfoTable Table {
            margin-left: 9px;
            line-height: 16px;
        }

        .borderleft {
            border-left: 1px solid #d3d3d3;
        }

        .borderright {
            border-right: 1px solid #d3d3d3;
        }

        .listbox {
            width: 99%;
            border: 0px;
            height: 145px;
        }

        .lblprompt {
            font-weight: normal;
            margin-left: 6px;
        }

        .textLine {
            text-decoration: line-through;
            vertical-align: middle;
        }

        .divTop {
            width: 100%;
            height: 170px;
            position: relative;
        }

        .divLeft {
            width: 50%;
            height: 200px;
            position: absolute;
            left: 0px;
            top: 0px;
        }

        .divRight {
            width: 50%;
            height: 200px;
            position: absolute;
            right: 0px;
            top: 0px;
        }

        .divBottom {
            width: 100%;
            height: auto;
        }

        .divBottomLeft {
            width: 50%;
            height: 179px;
            float: left;
        }

        .divBottomRight {
            width: 50%;
            height: 179px;
            float: left;
        }

        #divPOproductlist ul {
            float: left;
            list-style-type: none;
            line-height: 22px;
            padding-left: 2%;
            width: 98%;
        }

        #divPOproductlist li {
            width: 23%;
            margin-right: 2%;
            float: left;
        }

        #divPOproductPaging {
            position: absolute;
            right: 6px;
            top: 0px;
            line-height: 20px;
            width: 50%;
            height: 22px;
            font-weight: normal;
        }

            #divPOproductPaging ul {
                float: right;
                list-style-type: none;
                line-height: 22px;
            }

            #divPOproductPaging li {
                padding: 3px 5px;
                float: left;
                cursor: pointer;
            }

        .divwait {
            position: absolute;
            left: 47.2%;
            top: 190px;
            width: 66px;
            height: 66px;
            z-index: 9999;
        }

        /*Search button ==开始*/
        .SearchButton {
            border: none;
            background: url(<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/images/btn_search.png) no-repeat;
            cursor: pointer;
            width: 43px;
            height: 23px;
            padding: 2px;
            font-size: 11px;
        }

            .SearchButton:hover {
                border: none;
                background: url(<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/images/btn_search_hover.png) no-repeat;
                cursor: pointer;
                width: 43px;
                height: 23px;
                padding: 2px;
                font-size: 11px;
            }
        /*Search button ==结束*/
    </style>
    <div class="divHeader">
        <div style="position: absolute; left: 10px;">
            <img src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/Images/icon/information.png"
                alt="" style="vertical-align: middle;" />&nbsp;<asp:Label runat="server" ID="pageTitle"></asp:Label>
        </div>
    </div>
    <%--筛选条件 开始--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2" style="width: 5%; border-right: 0px">
                <input type="radio" id="rdoSerialNumber" name="rdoSearchGroup" runat="server" clientidmode="Static" />
            </td>
            <td class="Label2" style="width: 10%; border-left: 0px">
                <%= Resources.lang.SerialNumber + "/" + Resources.lang.CustomerSN%>
            </td>
            <td class="Field2">
                <input type="text" id="txtSerialNumber" class="TextBox" runat="server" style="width: 98%"
                    clientidmode="Static" maxlength='400' />
            </td>
            <td class="Label2" style="width: 5%; border-right: 0px">
                <input type="radio" id="rdoProductOrder" name="rdoSearchGroup" runat="server" clientidmode="Static" />
            </td>
            <td class="Label2" style="width: 10%; border-left: 0px">
                <%= Resources.lang.ShopOrder%>
            </td>
            <td class="Field2" colspan="3">
                <input type="text" id="txtProductOrder" class="TextBox" runat="server" style="width: 98%"
                    clientidmode="Static" maxlength='50' />
            </td>
        </tr>
        <tr>
            <td class="Label2" style="width: 5%; border-right: 0px">
                <input type="radio" id="rdoBoxNumber" name="rdoSearchGroup" runat="server" clientidmode="Static" />
            </td>
            <td class="Label2" style="width: 10%; border-left: 0px">
                <%= Resources.lang.BoxNumber%>
            </td>
            <td class="Field2">
                <input type="text" id="txtBoxNumber" class="TextBox" runat="server" style="width: 98%"
                    clientidmode="Static" maxlength='50' />
            </td>
            <td class="Label2" style="width: 5%; border-right: 0px">
                <input type="radio" id="rdoModelNo" name="rdoSearchGroup" runat="server" clientidmode="Static"
                    maxlength='50' />
            </td>
            <td class="Label2" style="width: 10%; border-left: 0px">
                <%= Resources.lang.ModelNo%>
            </td>
            <td class="Field2" style="width: 15%">
                <input type="text" id="txtModelNo" class="TextBox" runat="server" style="width: 95%"
                    clientidmode="Static" maxlength='50' />
            </td>
            <td class="Label2" style="width: 5%; border-left: 0px">
                <%= Resources.lang.AC_Version%>
            </td>
            <td class="Field2" style="width: 15%">
                <input type="text" id="txtVersions" class="TextBox" runat="server" style="width: 95%"
                    clientidmode="Static" maxlength='20' />
            </td>
        </tr>
        <tr>
            <td colspan="8" style="text-align: center; height: 28px;">
                <input type="submit" id="searchSubmit" value="<%=Resources.lang.Search %>" class="SearchButton"
                    title="<%=Resources.lang.Search %>" onclick="return btSearch()" />
            </td>
        </tr>
    </table>
    <%--筛选条件 结束--%>
    <div class="clear5">
    </div>
    <%--选项卡 开始--%>
    <div class="wrap_tb" id="wrap_tb_container" style="min-width: 710px; overflow: auto;">
        <ul class="tb">
            <li class="current">
                <%--选项卡-产品信息--%>
                <%=Resources.lang.ItemBaseInfo%>
            </li>
            <li>
                <%--选项卡-物料信息--%>
                <%=Resources.lang.ItemMaterielInfo%>
            </li>
            <li>
                <%--选项卡-组装信息--%>
                组装信息 </li>
            <li>
                <%--选项卡-包装信息--%>
                <%=Resources.lang.ItemPackingInfo%>
            </li>
            
            <li>
                <%--选项卡-型号信息--%>
                <%=Resources.lang.ModelInfo%>
            </li>
            <li>
                <%--选项卡-流程信息--%>
                <%=Resources.lang.FlowPathInfo%>
            </li>
            <li>
                <%--选项卡-拼板信息--%>
                <%=Resources.lang.ProductOrderInfo%>
            </li>
            <li>
                <%--选项卡-不良维修信息--%>
                <%=Resources.lang.NCCodeRepairInfo%>
            </li>
            <li>
                <%--选项卡-出货信息--%>
                <%=Resources.lang.OutStockInfo%>
            </li>
            <%--<li>
                测试数据
            </li>--%>
        </ul>
        <%--选项卡内容 开始--%>
        <div class="tb_c" style="min-height: 385px; overflow-y: scoll;">
            <%--选项卡内容-产品信息--%>
            <%--产品信息上半部 --%>
            <div class="divTop">
                <div>
                    <div class="divHeader">
                        <%=Resources.lang.SummaryInfo%><label class="jslblProduct lblprompt"></label>
                    </div>
                    <div id="divProductSummaryInfo" runat="server" clientidmode="Static" class="InfoTable"
                        style="overflow-x: hidden; height: 150px;">
                    </div>
                </div>
            </div>
            <div class="clear5">
            </div>
            <%--产品信息下半部 --%>
            <div class="divBottom">
                <div class="divHeader">
                    <%=Resources.lang.ProductionHistory%><label class="jslblProduct lblprompt"></label>
                </div>
                <div id="divProductHistoryRPT">
                    <table class="ListTable ListTableHeader">
                        <tr>
                            <th style="width: 8%">
                                <%=Resources.lang.OrderNum%>
                            </th>
                            <th style="width: 10%">
                                产品编码
                            </th>
                            <th style="width: 10%">
                               产线
                            </th>
                            <th style="width: 10%">
                               工序
                            </th>
                            <th style="width: 5%">
                                <%=Resources.lang.AC_Operate%>
                            </th>
                            <%--<th style="width: 13%">
                                <%=Resources.lang.EnterTime %>
                            </th>--%>
                            <th style="width: 13%">
                                过站时间
                            </th>
                            <th style="width: 7%">
                                <%=Resources.lang.Staff %>
                            </th>
                            <th style="width: 8%">
                                <%=Resources.lang.AC_Resource%>
                            </th>
                            <th style="width: 10%">
                                客户条码1
                            </th>
                            <th style="width: 10%">
                                客户条码2
                            </th>
                            <th style="width: 10%">
                                数量
                            </th>
                            <th style="width: 10%">
                                <%=Resources.lang.BoxSN%>
                            </th>
                            <th style="width: 10%">
                                <%=Resources.lang.CartonNunber%>
                            </th>
                            <th style="width: 10%">
                                <%=Resources.lang.PalletNumber%>
                            </th>
                            <th style="width: 10%">
                                <%=Resources.lang.QcLotNumber%>
                            </th>

                        </tr>
                        <asp:Repeater ID="rptProduct" runat="server">
                            <ItemTemplate>
                                <tr>
                                    <td>
                                        <%#Eval("ProdOrderNo")%>
                                    </td>
                                    <td>
                                        <%#Eval("ItemCode")%>
                                    </td>
                                     <td>
                                        <%#Eval("LineName")%>
                                    </td>
                                    <td>
                                        <%#Eval("Operation")%>
                                    </td>
                                    <td>
                                        <%#Eval("IsPass")%>
                                    </td>
                                    
                                    <td>
                                        <%#Eval("ExitTimeStr")%>
                                    </td>
                                    <td>
                                        <%#Eval("LoginID")%>
                                    </td>
                                    <td>
                                        <%#Eval("ResName")%>
                                    </td>
                                    <td>
                                        <%# Eval("CustomerSN").ToString().Length > 30 ? Eval("CustomerSN").ToString().Substring(0, 30) + "..." : Eval("CustomerSN").ToString()%>                                           
                                    </td>
                                    <td>
                                        <%# Eval("CustomerSN2").ToString().Length > 30 ? Eval("CustomerSN2").ToString().Substring(0, 30) + "..." : Eval("CustomerSN2").ToString()%>                                           
                                    </td>
                                    <td>
                                        <%#Eval("Qty")%>
                                    </td>
                                    <td>
                                        <%#Eval("BoxSN").ToString().Length > 30 ? Eval("BoxSN").ToString().Substring(0, 30) + "..." : Eval("BoxSN").ToString()%>                              
                                    </td>
                                    <td>
                                        <%#Eval("CartonNo").ToString().Length > 30 ? Eval("CartonNo").ToString().Substring(0, 30) + "..." : Eval("CartonNo").ToString()%>
                                    </td>
                                    <td>
                                        <%#Eval("PalletNo").ToString().Length > 30 ? Eval("PalletNo").ToString().Substring(0, 30) + "..." : Eval("PalletNo").ToString()%>
                                    </td>
                                    <td>
                                        <%#Eval("QcLotNo").ToString().Length > 30 ? Eval("QcLotNo").ToString().Substring(0, 30) + "..." : Eval("QcLotNo").ToString()%>
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </table>
                </div>
            </div>
            <div class="clear5">
            </div>
        </div>
        <div style="min-height: 385px; overflow: auto;">
            <%--选项卡内容-物料信息--%>
            <div id="infoTabContent-2">
                <%--物料信息上半部 --%>
                <div class="divTop">
                    <div class="divLeft">
                        <div class="divHeader">
                            <%=Resources.lang.UsedItemList%><label class="jslblProduct lblprompt"></label>
                            <div style="position: absolute; right: 5px; width: 36%; top: 2px; text-align: right; font-weight: normal;">
                                <input type="checkbox" id="chkComponent" onclick="GetAllItem(this.checked)" />
                                <label id="lblComponent">
                                    <%=Resources.lang.DisplayRemovedItem%></label>
                            </div>
                        </div>
                        <div class="borderright InfoTable" style="height: 140px; overflow: scroll;">
                            <asp:TreeView ID="treeBoardCount" runat="server" ClientIDMode="Static" ShowLines="true" Style="cursor: pointer;"></asp:TreeView>
                            <!-- <asp:ListBox ID="listboxUseItem" runat="server" ClientIDMode="Static" CssClass="listbox"></asp:ListBox> -->
                        </div>
                    </div>
                    <div class="divRight">
                        <div class="divHeader">
                            <span>维修更换物料</span><label class="jslblUseItem lblprompt"></label>
                        </div>
                        <div id="divItemDetailInfo" runat="server" clientidmode="Static" class="InfoTable borderleft" style="height: 147px;">
                            <table class="ListTable ListTableHeader" style="margin-left: 0px;">
                                <thead>
                                    <tr>
                                        <th>更换日期</th>
                                        <th>物料条码</th>
                                        <th>物料编码</th>
                                        <th>数量</th>
                                        <th>DateCode</th>
                                        <th>LotNo</th>
                                        <th>更换后物料条码</th>
                                        <th>更换后物料编码</th>
                                        <th>更换后DateCode</th>
                                        <th>更换后LotNo</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:Literal ID="ltrRepairReplaseMaterial" runat="server"></asp:Literal>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="clear5">
                </div>
                <%--物料信息下半部 --%>
                <div class="divBottom">
                    <div class="divHeader">
                        <%=Resources.lang.ItemUsageRecord%><label class="jslblProduct lblprompt"></label>
                    </div>
                    <div id="divItemHistoryRPT">
                        <table class="ListTable ListTableHeader">
                            <tr >
                                <th style="width:15%;">物料序列号
                                </th>
                                <th style="width: 15%">物料编码
                                </th>
                                <th style="width: 15%">
                                    <%=Resources.lang.ItemName%>
                                </th>
                                <th style="width: 10%">
                                    <%=Resources.lang.LotCode%>
                                </th>
                                <th style="width: 10%">
                                    <%=Resources.lang.DateCode%>
                                </th>
                                <th style="width: 5%">用量
                                </th>
                                <th style="width: 15%">供应商
                                </th>
                                <th style="width: 5%">
                                    <%=Resources.lang.Operater%>
                                </th>
                                <th style="width: 10%">
                                    <%=Resources.lang.OperationStation%>
                                </th>
                                <th style="width: 15%">
                                    <%=Resources.lang.OperationTime%>
                                </th>
                                <th style="width: 5%">
                                    <%=Resources.lang.AC_Operate%>
                                </th>
                            </tr>
                            <asp:Repeater ID="rptItemTracking" runat="server">
                                <ItemTemplate>
                                    <tr>
                                        <td style="white-space:normal;word-wrap:break-word;word-break:break-all;">
                                            <%#Eval("SerialNumber")%>
                                        </td>
                                        <td>
                                            <%#Eval("ItemCode")%>
                                        </td>
                                        <td>
                                            <%#Eval("ItemName")%>
                                        </td>
                                        <td>
                                            <%#Eval("LotCode")%>
                                        </td>
                                        <td>
                                            <%#Eval("DateCode")%>
                                        </td>
                                        <td>
                                            <%#Eval("Qty")%>
                                        </td>
                                        <td>
                                            <%#Eval("VendorName") %>
                                        </td>
                                        <td>
                                            <%#Eval("CreateBy")%>
                                        </td>
                                        <td>
                                            <%#Eval("InsertOperation")%>
                                        </td>
                                        <td>
                                            <%#Eval("CreateDateTime")%>
                                        </td>
                                        <td>
                                            <%#Eval("Remark")%>
                                        </td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                        </table>
                    </div>
                </div>
                <div class="clear5">
                </div>
            </div>
        </div>
        <div style="min-height: 385px; overflow: auto;">
            <%--选项卡内容-组装信息--%>
            <div id="infoTabContent-3">
                <div style="position: relative; width: 100%;">
                    <div style="position: absolute; width: 50%; left: 0px; top: 0px;">
                        <div class="divHeader">
                           <span>组装信息</span> <label class="jslblProduct lblprompt"></label>
                        </div>
                        <div id="div2" runat="server" clientidmode="Static" style="border-right: 1px solid #d3d3d3">
                            <asp:TreeView runat="server" ID="treeAssemble" ShowLines="true" ClientIDMode="Static" Style="cursor: pointer;">
                            </asp:TreeView>
                        </div>
                    </div>
                    <div style="position: absolute; width: 50%; right: 0px; top: 0px;">
                        <div class="divHeader">
                            组件采集信息
                        </div>
                        <div id="divAssyDetailInfo" style="line-height: 22px;">
                        </div>
                    </div>
                </div>
                <div class="clear5">
                </div>
            </div>
        </div>
        <div style="min-height: 385px; overflow: auto;">
            <%--选项卡内容-包装信息--%>
            <div id="infoTabContent-4">
                <%--包装信息上半部 --%>
                <div class="divTop">
                    <div class="divLeft">
                        <div class="divHeader">
                            <%=Resources.lang.PackingList%><label class="jslblPack lblprompt"></label>
                        </div>
                        <div class="InfoTable borderright" style="cursor: default; overflow: auto; height: 150px;">
                            <asp:TreeView runat="server" ID="tvBoxPack" ShowLines="true" ClientIDMode="Static">
                            </asp:TreeView>
                        </div>
                    </div>
                    <div class="divRight">
                        <div class="divHeader">
                            <%=Resources.lang.DetailInfo%><label class="jslblPack lblprompt"></label>
                        </div>
                        <div id="divPackingDetailInfo" runat="server" clientidmode="Static" class="InfoTable borderleft">
                        </div>
                    </div>
                </div>
                <div class="clear5">
                </div>
                <%--包装信息下半部 --%>
                <div class="divBottom">
                    <div class="divHeader">
                        <%=Resources.lang.PackingHistory%><label class="jslblPack lblprompt"></label>
                    </div>
                    <table class="ListTable ListTableHeader">
                        <tr>
                            <th>
                                <%=Resources.lang.ProductSN%>
                            </th>
                            <th style="width: 80px">
                                <%=Resources.lang.Operater%>
                            </th>
                            <th style="width: 130px">
                                <%=Resources.lang.OperationTime%>
                            </th>
                            <th style="width: 300px">
                                <%=Resources.lang.AC_Operate%>
                            </th>
                        </tr>
                        <asp:Repeater ID="rptPacking" runat="server">
                            <ItemTemplate>
                                <tr>
                                    <td>
                                        <span title="<%#Eval("SerialNumber")%>"><%#Eval("SerialNumber").ToString().Length > 80 ? Eval("SerialNumber").ToString().Substring(0,80)+"..." : Eval("SerialNumber").ToString()%></span>
                                    </td>
                                    <td>
                                        <%#Eval("OperaterPerson")%>
                                    </td>
                                    <td>
                                        <%#Eval("OperaterTime")%>
                                    </td>
                                    <td>
                                        <%#Eval("OperaterDesc")%>
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </table>
                </div>
                <div class="clear5">
                </div>
            </div>
        </div>
     
        <div style="min-height: 385px; overflow-y: scroll;">
            <%--选项卡内容-型号信息--%>
            <div id="infoTabContent-6">
                <%--型号信息上半部 --%>
                <div class="divTop">
                    <div class="divLeft">
                        <div class="divHeader">
                            <%=Resources.lang.SummaryInfo%><label class="jslblModelNo lblprompt"></label>
                        </div>
                        <div id="divModelSummaryInfo" runat="server" clientidmode="Static" class="InfoTable borderright"
                            style="height: 150px;">
                        </div>
                    </div>
                    <div class="divRight">
                        <div class="divHeader">
                            <%=Resources.lang.DetailInfo%><label class="jslblModelNo lblprompt"></label>
                        </div>
                        <div id="divModelDetailInfo" runat="server" clientidmode="Static" class="InfoTable borderleft"
                            style="height: 150px;">
                        </div>
                    </div>
                </div>
                <div class="clear5">
                </div>
                <%--型号信息下半部 --%>
                <div class="divBottom">
                    <div class="divBottomLeft">
                        <div class="divHeader">
                            <%=Resources.lang.ModelGroup%><label class="jslblRelyOnModelNo lblprompt"></label>
                        </div>
                        <div class="borderright InfoTable">
                            <asp:TreeView runat="server" ID="tvmodelgroup" ShowLines="true" ClientIDMode="Static">
                            </asp:TreeView>
                        </div>
                    </div>
                    <div class="divBottomRight">
                        <div class="divHeader">
                            <%=Resources.lang.GroupInfo%><label class="jslblRelyOnModelNo lblprompt"></label>
                        </div>
                        <div id="divModelRelyOn" runat="server" clientidmode="Static" class="borderleft InfoTable">
                        </div>
                    </div>
                </div>
                <div class="clear5">
                </div>
            </div>
        </div>
        <div style="min-height: 385px; overflow: auto;">
            <%--选项卡内容-流程信息--%>
            <div id="infoTabContent-7">
                <%--下一流程 --%>
                <div>
                    <div class="divHeader">
                        <%=Resources.lang.FlowPathInfo%><label class="jslblProduct lblprompt"></label>
                    </div>
                    <div id="divNextFlowPath" runat="server" clientidmode="Static">
                    </div>
                </div>
            </div>
        </div>
        <div style="min-height: 385px; overflow: auto;">
            <%--选项卡内容-拼板信息--%>
            <div id="infoTabContent-8">
                <%--工单信息上半部 --%>
                <div class="divTop">
                    <div class="divLeft">
                        <div class="divHeader">
                            <%=Resources.lang.HistoryRecords%><label class="jslblOrderNo lblprompt"></label>
                        </div>
                        <div id="divProductOrderHistory" runat="server" clientidmode="Static" class="InfoTable borderright">
                        </div>
                    </div>
                    <div class="divRight">
                        <div class="divHeader">
                            <%=Resources.lang.DetailInfo%><label class="jslblOrderNo lblprompt"></label>
                        </div>
                        <div id="divProductOrderDetailInfo" runat="server" clientidmode="Static" class="InfoTable borderleft">
                        </div>
                    </div>
                </div>
                <div class="clear5">
                </div>
                <%--拼板信息下半部 --%>
                <div class="divBottom" style="display:none">
                    <div class="divHeader" style="margin-top: 35px;">
                        <span>拼板包含产品</span><label class="jslblPanelNo lblprompt"></label>
                        <div id="divPOproductPaging">
                            <ul>
                            </ul>
                        </div>
                    </div>
                    <div id="divPOproductlist" runat="server" clientidmode="Static">
                    </div>
                </div>
                <div class="clear5">
                </div>
            </div>
        </div>
        <div style="min-height: 385px; overflow: auto;">
            <%--选项卡内容-不良维修信息--%>
            <div id="infoTabContent-9">
                <%--不良维修信息 --%>
                <div class="divTop">
                    <div id="div1">
                        <table class="ListTable ListTableHeader" style="white-space: normal;">
                            <tr>
                                <th style="width: 85px;">不良现象代码
                                </th>
                                <th>不良现象描述
                                </th>
                                <th style="width: 60px;">状态
                                </th>
                                <th style="width: 80px;">操作员
                                </th>
                                <th style="width: 80px;">操作时间
                                </th>
                                <th style="width: 100px;">不良站位
                                </th>
                                <th style="width: 80px;">备注
                                </th>
                            </tr>
                            <asp:Repeater ID="rptNCCodeRepair" runat="server">
                                <ItemTemplate>
                                    <tr>
                                        <td style="max-width: 400px;">
                                            <%#Eval("NCCode")%>
                                        </td>
                                        <td style="max-width: 400px;">
                                            <%#Eval("NCCodeDesc")%>
                                        </td>
                                        <td style="max-width: 400px;">
                                            <%#Eval("Status")%>
                                        </td>
                                        <td style="max-width: 400px;">
                                            <%#Eval("UserName")%>
                                        </td>
                                        <td style="max-width: 400px;">
                                            <%#Eval("CreateDateTime")%>
                                        </td>
                                        <td style="max-width: 400px;">
                                            <%#Eval("Station")%>
                                        </td>
                                        <td style="max-width: 400px;">
                                            <%#Eval("Remark")%>
                                        </td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                        </table>
                    </div>
                </div>
                <div class="clear5">
                </div>
            </div>
        </div>
        <div style="min-height: 385px; overflow: auto;">
            <%--选项卡内容-出货信息--%>
            <%--出货信息上半部 --%>
            <div class="divTop">
                <div>
                    <div class="divHeader">
                        <%=Resources.lang.SummaryInfo%><label class="jslblProduct lblprompt"></label>
                    </div>
                    <div id="divOutStock" runat="server" clientidmode="Static" class="InfoTable"
                        style="overflow-x: hidden; height: 150px;">
                    </div>
                </div>
            </div>
            <div class="clear5">
            </div>
            <%--出货信息下半部 --%>
            <div class="divBottom">
                <div class="divHeader">
                    <%=Resources.lang.OutStockInfo%><label class="jslblProduct lblprompt"></label>
                </div>
                <div id="divOutStockHistoryRPT">
                    <table class="ListTable ListTableHeader">
                        <tr>
                            <th style="width: 15%">
                                <%=Resources.lang.LineNo%>
                            </th>
                            <th style="width: 20%">
                                <%=Resources.lang.FinishedProductCode%>
                            </th>
                            <th style="width: 20%">
                                <%=Resources.lang.FinishedProductName%>
                            </th>
                            <th style="width: 15%">
                                <%=Resources.lang.PlanOutQty %>
                            </th>
                            <th style="width: 15%">
                                <%=Resources.lang.CurrentQty%>
                            </th>
                        </tr>
                        <asp:Repeater ID="Repeater1" runat="server">
                            <ItemTemplate>
                                <tr onclick="OutStockCheck(<%#Eval("SalOrderDtlID")%>)">
                                    <td>
                                        <%#Eval("SalOrderDtlID")%>
                                    </td>
                                    <td>
                                        <%#Eval("ItemCode")%>
                                    </td>
                                    <td>
                                        <%#Eval("ItemName")%>
                                    </td>
                                    <td>
                                        <%#Convert.ToDouble(Eval("PlanQty"))%>
                                    </td>
                                    <td>
                                        <%#Convert.ToDouble(Eval("CurrentQty"))%>
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </table>
                </div>
            </div>
            <div class="clear5">
            </div>
        </div>
        
    </div>
    <div id="infoTabContent" class="infoTabContent">
        <div class='divwait'>
            <img src="../Content/theme/Metro/images/bigloading.gif" alt='数据加载中' />
        </div>
    </div>
    <%-- 脚本块 --%>
    <script type="text/javascript" src="../Content/js/jquery-3.1.0.min.js"></script>
    <script type="text/javascript" charset="utf-8" src="../Content/plugin/jquery-easyui-1.4.2/layer/layer.js"></script>
    <script type="text/javascript">
        $(document).ready(function(){          
            $("#wrap_tb_container").css("height",($(window).height()-142)+"px");

            $("#txtSerialNumber").focus(function (){
                $("#rdoSerialNumber").click();
            });
            $("#txtBoxNumber").focus(function (){
                $("#rdoBoxNumber").click();
            });
            $("#txtProductOrder").focus(function (){
                $("#rdoProductOrder").click();
            });
            $("#txtModelNo").focus(function (){
                $("#rdoModelNo").click();
            });
            $("#txtVersions").focus(function (){
                $("#rdoModelNo").click();
            });
        });
            
        /* 
        用途：检查输入字符串是否为空或者全部都是空格 
        输入：str 
        返回：如果全是空返回true,否则返回false 
        */
        function isNull(str) {
            if (str == "") return true;
            var regu = "^[ ]+$";
            var re = new RegExp(regu);
            return re.test(str);
        }


        //按下之后是否允许提交
        function btSearch() {   //JQuery在获取或设置checked的时候，使用attr可能会有问题。  比如radio在页面上是未选中，但是checked的值仍然是checked。
            //使用prop代替attr。   prop返回的是true ,false。
            if ($("#rdoSerialNumber").prop("checked")) {
                //清空其他的项
                //$("#txtSerialNumber").val('');
                $("#txtProductOrder").val('');
                $("#txtBoxNumber").val('');
                $("#txtModelNo").val('');
                $("#txtVersions").val('');
                if(isNull($("#txtSerialNumber").val()))
                {
                    alert("请输入序列号/客户序列号");
                    $("#txtSerialNumber").focus();
                    return false;
                }
                $(".divwait").show();
                return true;
            }
            else if ($("#rdoProductOrder").prop("checked") ) {
                //清空其他的项
                $("#txtSerialNumber").val('');
                //$("#txtProductOrder").val('');
                $("#txtBoxNumber").val('');
                $("#txtModelNo").val('');
                $("#txtVersions").val('');
                if(isNull($("#txtProductOrder").val()))
                {
                    alert("请输入工单号");  
                    $("#txtProductOrder").focus()
                    return false;              
                }
                $(".divwait").show();
                return true;
            }
            else if ($("#rdoBoxNumber").prop("checked") ) {

                //清空其他的项
                $("#txtSerialNumber").val('');
                $("#txtProductOrder").val('');
                //$("#txtBoxNumber").val('');
                $("#txtModelNo").val('');
                $("#txtVersions").val('');
                if(isNull($("#txtBoxNumber").val()))
                {
                    alert("请输入箱号"); 
                    $("#txtBoxNumber").focus() 
                    return false;                      
                }
                $(".divwait").show();
                return true;
            }
            else if ($("#rdoModelNo").prop("checked")) {
                if(isNull($("#txtModelNo").val()) || isNull($("#txtVersions").val()))
                {
                    //清空其他的项
                    $("#txtSerialNumber").val('');
                    $("#txtProductOrder").val('');
                    $("#txtBoxNumber").val('');
                    //$("#txtModelNo").val('');
                    //$("#txtVersions").val('');
                    alert("如果选择按型号和版本查询，那么请输入型号和版本！");
                    $("#txtModelNo").focus();
                    return false;
                }
                $(".divwait").show();
                return true;
            }
        }

        //物料信息的复选框被单击
        function GetAllItem(checked)
        {            
            var sn = "";

            if(prompt){ sn = prompt; }
            
            if(packclickproduct){ sn = packclickproduct; }


            //显示所有使用的物料(被删除的采用删除线样式)
            if(sn)
            {
                if (checked) {
                    var innerhtml1="";

                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxManufacture.GetAllItem(sn, 1);
                    if (ajax.error == null) {
                        var list = ajax.value;
                        for(var i=0 ; i<list.length; i++)
                        {
                            if(list[i].IsRemoved)
                            {
                                innerhtml1 = innerhtml1 + "<option value='" + list[i].ItemID + "'class='textLine'>" + list[i].ItemName + "</option>";
                            }
                            else
                            {
                                innerhtml1 = innerhtml1 + "<option value='" + list[i].ItemID + "'>" + list[i].ItemName + "</option>";
                            }
                        }

                        $("#listboxUseItem").html("");
                        $("#listboxUseItem").html(innerhtml1);
                    }
                    else {
                        alert(ajax.error.Message);
                        return false;
                    }
                }
                else //不显示被删除的
                {
                    var innerhtml2="";

                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxManufacture.GetAllItem(sn, 0);
                    if (ajax.error == null) {
                        var list = ajax.value;
                        for (var i = 0; i < list.length; i++) {
                            innerhtml2 = innerhtml2 + "<option value='" + list[i].ItemID + "'>" + list[i].ItemName + "</option>";
                        }

                        $("#listboxUseItem").html("");
                        $("#listboxUseItem").html(innerhtml2);
                    }
                    else {
                        alert(ajax.error.Message);
                        return false;
                    }
                }
            }
        }

        //树控件被点击的时候
        <%--var timer = null;
        $("#treeBoardCount span:gt(0)").click(function(){
            $(".jslblUseItem").text("(<%=Resources.lang.Material%>:" + $(this).html() + ")");
            var itemId = $(this).attr("href");
            timer = setTimeout(function(){
                var sn = "";
                if(prompt){ sn = prompt; }
                var innerHtml = "";
                var entity = {};
                entity.SN = sn;
                entity.ItemId = itemId;
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxManufacture.GetRepairReplaceMaterial(entity);
                if(ajax.value != null){           
                    var list = ajax.value;
                    if(list != null && list.length > 0)
                    {
                        for (var i = 0; i < list.length; i++) {
                            innerHtml += "<tr>" +
                                "<td>" + formatDate(list[i].CreateDateTime) + "</td>" +
                                "<td>" + list[i].GRN + "</td>" +
                                "<td>" + list[i].ItemCodeBefore + "</td>" +
                                "<td>" + list[i].Num + "</td>" +
                                "<td>" + list[i].DateCodeBefore + "</td>" +
                                "<td>" + list[i].LotCodeBefore + "</td>" +
                                "<td>" + list[i].ReplaceGRN + "</td>" +
                                "<td>" + list[i].ItemCodeAfter + "</td>" +
                                "<td>" + list[i].DateCodeAfter + "</td>" +
                                "<td>" + list[i].LotCodeAfter + "</td>" +
                                "</tr>";
                        }
                        $("#divItemDetailInfo tbody").html(innerHtml);
                    }
                    else
                    {
                        $("#divItemDetailInfo tbody").html("<tr><td style=\"text-align:center\" colspan=\"10\"><%=Resources.Messages.NotConformToTheConditionsOfInformation %></td></tr>");
                    }
                }
                else {
                    $("#divItemDetailInfo tbody").html("");
                   // alert(ajax.error.Message);
                    return false;
                }
            },300)
            // }
        })--%>

        //格式化时间格式为日期
        function formatDate(date){
            if(date != null && date != ""){
                var date = new Date(date);  
                return date.getFullYear() + '-' + (date.getMonth() + 1) + '-' + date.getDate();  
            }
            return "";
        }

        //物料组件被单击后，显示该物料组件的详细信息。
        $("#listboxUseItem").click(function(){

            if($("#listboxUseItem option:selected").val())
            {
                $(".jslblUseItem").text("(<%=Resources.lang.Material%>:" + $("#listboxUseItem option:selected").text() + ")")

                    var sn = "";

                    if(prompt){ sn = prompt; }
            
                    if(packclickproduct){ sn = packclickproduct; }

                    var innerHtml = "";

                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxManufacture.GetItemDetailInfo(sn ,$("#listboxUseItem option:selected").val());

                    if (ajax.error == null) {           
                        var info = ajax.value;
                        if(info != null )
                        {
                            innerHtml += "<table><tr><td><%=Resources.lang.AddOfPerson%>：</td><td>"+ info.CreateBy +"</td></tr>";
                        innerHtml += "<tr><td><%=Resources.lang.AddOfStation%>：</td><td>"+ info.InsertOperation +"</td></tr>";
                        innerHtml += "<tr><td><%=Resources.lang.AddTime%>：</td><td>"+ info.CreateDateTime +"</td></tr>";
                        innerHtml += "<tr><td><%=Resources.lang.RemovedOfPerson%>：</td><td>"+ info.RemoveUserName +"</td></tr>";
                        innerHtml += "<tr><td><%=Resources.lang.RemovedOfStation%>：</td><td>"+ info.RemoveOperation +"</td></tr>";
                        innerHtml += "<tr><td><%=Resources.lang.RemovedTime%>：</td><td>"+ info.RemoveTime +"</td></tr></table>";

                        $("#divItemDetailInfo").html(innerHtml);
                    }
                    else
                    {
                        $("#divItemDetailInfo").html("<%=Resources.Messages.NotConformToTheConditionsOfInformation %>");
                    }
                }
                else {
                    alert(ajax.error.Message);
                    return false;
                }
            }
            })

        //物料组件被单击后，显示该物料组件的详细信息。
        $("#treeAssemble span").click(function(){
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxManufacture.GetAssyDataDetailInfo($(this).text(),$.trim($("#txtSerialNumber").val()));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            if(ajax.value !=null && ajax.value.length>0){
                var entityAry = ajax.value;
                var innerHtml = "";
                var dataTag = "";      
                   
                innerHtml="<table style='margin-left:10px;'><tr><td align='right'>组件条码</td><td>&nbsp;&nbsp;&nbsp;<b>"+$(this).text()+"</b></td></tr>";
                for (var i = 0; i < entityAry.length; i++) {
                     
                    var entityData = entityAry[i];
                    dataTag = entityData.Required == false ? entityData.DataTag : entityData.DataTag + "<em>*</em>";

                    innerHtml+="<tr><td align='right' >"+dataTag+"</td><td>&nbsp;&nbsp;&nbsp;"+entityData.FieldValue+"</td></tr>";

                }

                innerHtml+="</table>";
                $("#divAssyDetailInfo").html(innerHtml);
            }
            else{
                $("#divAssyDetailInfo").html("");
            }
        })

        //包装信息的列表，选中某个产品之后，展示该产品的基础信息和物料信息。  
        $("#tvBoxPack span:gt(0)").click(function () {
            
            //只有通过箱号查询的情况下，单击箱内产品序列号，才会调取产品信息。
            if(rdoindex == 3)
            {
                packclickproduct = $(this).text();
                
                /*********物料使用记录********/
                var ajax1 = SKT.LeanMES.Web.AjaxServices.AjaxManufacture.GetItemUseHistory(packclickproduct);
                if (ajax1.error == null) {
                    var list1 = ajax1.value;
                    var innerhtml1="<tr><th style='width:25%'><%=Resources.lang.ItemName%></th>"
                                  +"<th style='width:20%'><%=Resources.lang.Operater%></th>"
                                  +"<th style='width:20%'><%=Resources.lang.OperationStation%></th>"
                                  +"<th style='width:20%'><%=Resources.lang.OperationTime%></th>"
                                  +"<th style='width:15%'><%=Resources.lang.AC_Operate%></th></tr>";

                        for (var i = 0; i < list1.length; i++) {
                            innerhtml1 += "<tr><td>"+list1[i].ItemName+"</td>"
                                       +"<td>"+list1[i].InsertUserName+"</td>"
                                       +"<td>"+list1[i].InsertOperation+"</td>"
                                       +"<td>"+list1[i].InsertTime+"</td>"
                                       +"<td>"+list1[i].Remark+"</td></tr>";
                        }

                        $("#divItemHistoryRPT table").html("");
                        $("#divItemHistoryRPT table").html(innerhtml1);
                    }
                    else {
                        alert(ajax1.error.Message);
                        return false;
                    }

                    /*********已使用物料名称列表********/
                    var ajax2 = SKT.LeanMES.Web.AjaxServices.AjaxManufacture.GetUseItemList(packclickproduct,0);
                    if (ajax2.error == null) {
                        var list2 = ajax2.value;
                        var innerhtml2="";
                        for (var i = 0; i < list2.length; i++) {
                            innerhtml2 = innerhtml2 + "<option value='" + list2[i].ItemID + "'>" + list2[i].ItemName + "</option>";
                        }

                        $("#listboxUseItem").html("");
                        $("#listboxUseItem").html(innerhtml2);
                    }
                    else
                    {
                        alert(ajax2.error.Message);
                        return false;
                    }

                    /*********产品简要信息********/
                    var ajax3 = SKT.LeanMES.Web.AjaxServices.AjaxManufacture.GetProductSummaryInfo(packclickproduct);
                    if (ajax3.error == null) {                   
                        if(ajax3.value==null){
                            return;
                        }
                        var list3 = ajax3.value;
                        var innerhtml3="<table><tr><td><%=Resources.lang.AC_Operation %>：</td><td>"+list3.Operation+"</td></tr>"
                                   +"<tr><td><%=Resources.lang.Status %>：</td><td>"+list3.UnitStatus+"</td></tr>"
                                  +"<tr><td><%=Resources.lang.Line%>：</td><td>"+list3.LineName+"</td></tr>"
                                  +"<tr><td><%=Resources.lang.Staff %>：</td><td>"+list3.LoginID+"</td></tr>"
                                  +"<tr><td><%= Resources.lang.ModelNo%>：</td><td>"+list3.ItemName+"</td></tr>"
                                  +"<tr><td><%= Resources.lang.ShopOrder%>：</td><td>"+list3.ProductionOrder+"</td></tr>"
                                  +"<tr><td><%=Resources.lang.CreateDateTime%>：</td><td>"+list3.EnterTimeStr+"</td></tr>"
                                  +"<tr><td><%=Resources.lang.LastUpdateTime%>：</td><td>"+list3.ExitTimeStr+"</td></tr></table>";

                        $("#divProductSummaryInfo").html(innerhtml3);
                    }
                    else
                    {
                        alert(ajax3.error.Message);
                        return false;
                    }

                    /*********产品生产记录********/
                    var ajax4 = SKT.LeanMES.Web.AjaxServices.AjaxManufacture.GetProductHistory(packclickproduct);
                    if (ajax4.error == null) {
                        var list4 = ajax4.value;
                        var innerhtml4=" <tr><th style='width:15%'><%=Resources.lang.AC_Operation %></th>"
                                  +"<th style='width:15%'><%=Resources.lang.IsPass %></th>"
                                  +"<th style='width:20%'><%=Resources.lang.EnterTime %></th>"
                                  +"<th style='width:20%'><%=Resources.lang.ExitTime %></th>"
                                  +"<th style='width:15%'><%=Resources.lang.Staff %></th>"
                                  +"<th style='width:15%'><%=Resources.lang.AC_Resource%></th></tr>";
                                  
                        for (var i = 0; i < list4.length; i++) {
                            innerhtml4 += "<tr><td>"+list4[i].Operation+"</td>"
                                       +"<td>"+list4[i].IsPass+"</td>"
                                       +"<td>"+list4[i].EnterTimeStr+"</td>"
                                       +"<td>"+list4[i].ExitTimeStr+"</td>"
                                       +"<td>"+list4[i].LoginID+"</td>"
                                       +"<td>"+list4[i].ResName+"</td></tr>";
                        }


                        $("#divProductHistoryRPT table").html("");
                        $("#divProductHistoryRPT table").html(innerhtml4);
                    }
                    else
                    {
                        alert(ajax4.error.Message);
                        return false;
                    }

                    //选项卡跳转到产品基础信息
                    selectTab(1);
                
                    //设置产品序列号label
                    $(".jslblProduct").text("(<%=Resources.lang.AC_RSN_Item%>：" + packclickproduct +")");
                }
            })

            //设置选项卡样式
            function selectTab(index)
            {
                index--;
                $(".wrap_tb ul li").eq(index).click();
            }

            //根据搜索条件，将相应的选项卡显示出来。 
            function SetTabDisplay()
            {
                switch(rdoindex)
                {
                    case 1:selectTab(1)
                        break;
                    case 2:selectTab(7)
                        break;
                    case 3:selectTab(4);
                        break;
                    case 4:selectTab(5)
                        break;
                    default:;
                        break;
                }
            }

            //设置相应的提示信息
            function SetLable() {        
                switch (rdoindex) {
                    case 1: $(".jslblProduct").text("(<%=Resources.lang.AC_RSN_Item%>：" + prompt +")");
                        $(".jslblPack").text("(<%= Resources.lang.BoxNumber%>："+  boxNumber  +")");
                        $(".jslblOrderNo").text("(<%= Resources.lang.ShopOrder%>："+  productOrderNo  +")");
                        $(".jslblPanelNo").text("(拼板号:" + PanelNo + ")");
                        $(".jslblModelNo").text("(<%= Resources.lang.ModelNo%>："+ getOmitletters(modelCurrentName,42) +")");
                        $(".jslblRelyOnModelNo").text("(<%= Resources.lang.ItemGroupName%>："+ modelGroupName +")");
                        break;
                    case 2: $(".jslblOrderNo").text("(<%= Resources.lang.ShopOrder%>："+ prompt  +")");
                        break;
                    case 3: $(".jslblPack").text("(<%= Resources.lang.BoxNumber%>："+ prompt  +")");
                        break;
                    case 4: $(".jslblModelNo").text("(<%= Resources.lang.ModelNo%>："+ prompt  +")");
                        $(".jslblRelyOnModelNo").text("(<%= Resources.lang.ItemGroupName%>：" + modelGroupName + ")");
                        break;
                    default: ;
                        break;
                }

            }

            function getOmitletters(letter,num){
                if(letter.length>num){
                    return letter.substring(0,num)+"...";
                }
                else{
                    return letter;
                }
            }
            /******************全局区域开始*********************/
            var rdoindex = <%=GetRadioIndex()%>;
            var prompt = "<%=GetLabelTitle() %>";
        var packclickproduct ="";

        var productCountByOrderNo = <%=GetProductCountByOrderNo()%>;
        var productOrderNo = "<%=GetProductOrderNo() %>"
        var PanelNo = "<%= GetPanelNo() %>";
        var boxNumber = "<%=GetBoxNumber() %>";
        var modelGroupName = "<%=GetModelGroupName() %>";
        var modelCurrentName = "<%=GetModelCurrentName() %>";
        var pageSize = <%=pageSize %>;
        var pageNoLimit = 10;

        $(document).ready(function(){    
            SetTabDisplay();      
            SetLable();
            //ProductPaging(-1);  //wenshun  这里不显示工单的内容，显示拼板的内容      
            switch(rdoindex)
            {
                case 1: $("#txtSerialNumber").select();
                    break;
                case 2: $("#txtProductOrder").select();
                    break;
                case 3: $("#txtBoxNumber").select();
                    break;
                case 4: $("#txtModelNo").select();
                    break;
                default:$("#txtSerialNumber").select();
                    break;
            }
        })
        /******************全局区域结束********************/           

        //工单产品列表中，页码列表的展示。
        function ProductPaging(pageNo)
        {
            if((rdoindex == 1 && prompt != "") || rdoindex == 2 || productCountByOrderNo > pageSize)
            {
                var pageNoCount = (productCountByOrderNo % pageSize) == 0 ? productCountByOrderNo / pageSize : Math.floor(productCountByOrderNo / pageSize) +1 ;
                var innerhtml = "";

                if(pageNoCount <= pageNoLimit)
                {
                    for (var i = 1 ; i <= pageNoCount ; i++)
                    {
                        if((pageNo == -1 && i == 1) || i == pageNo)
                        {
                            innerhtml += "<li onclick='pageNoClick(this)' class='bold'>"+ i +"</li>" ;
                        }
                        else
                        {
                            innerhtml += "<li onclick='pageNoClick(this)'>"+ i +"</li>" ;
                        }

                    }
                }
                else
                {
                    pageNoStart = Math.floor(pageNo / pageNoLimit) * pageNoLimit ;

                    if(pageNo > pageNoLimit && pageNo <= pageNoCount - pageNoLimit)
                    {
                        innerhtml +="<li onclick='pageNoClick(this)'>"+ 1 +"</li>" ;
                        innerhtml +="<li onclick='pageNoClick(this)'><<</li>" ;

                        for (var i = pageNoStart; i <= pageNoStart + pageNoLimit ; i++)
                        {
                            if(i == pageNo)
                            {
                                innerhtml += "<li onclick='pageNoClick(this)' class='bold'>"+ i +"</li>" ;
                            }
                            else
                            {
                                innerhtml += "<li onclick='pageNoClick(this)'>"+ i +"</li>" ;
                            }
                        }
                        innerhtml +="<li onclick='pageNoClick(this)'>>></li>" ;
                        innerhtml +="<li onclick='pageNoClick(this)'>"+ pageNoCount +"</li>" ;
                    }
                    else
                        if(pageNo <= pageNoLimit)
                        {
                            for (var i = 1 ; i <= pageNoLimit ; i++)
                            {
                                if((pageNo == -1 && i == 1) || i == pageNo)
                                {
                                    innerhtml += "<li onclick='pageNoClick(this)' class='bold'>"+ i +"</li>" ;
                                }
                                else
                                {
                                    innerhtml += "<li onclick='pageNoClick(this)'>"+ i +"</li>" ;
                                }
                            }
                            innerhtml +="<li onclick='pageNoClick(this)'>>></li>" ;
                            innerhtml +="<li onclick='pageNoClick(this)'>"+ pageNoCount +"</li>" ;
                        }
                        else
                            if(pageNo > pageNoCount - pageNoLimit)
                            {
                                innerhtml +="<li onclick='pageNoClick(this)'>"+ 1 +"</li>" ;
                                innerhtml +="<li onclick='pageNoClick(this)'><<</li>" ;

                                for (var i = pageNoCount - pageNoLimit ; i <= pageNoCount ; i++)
                                {
                                    if(i == pageNo)
                                    {
                                        innerhtml += "<li onclick='pageNoClick(this)' class='bold'>"+ i +"</li>" ;
                                    }
                                    else
                                    {
                                        innerhtml += "<li onclick='pageNoClick(this)'>"+ i +"</li>" ;
                                    }
                                }

                            }
                }


                $("#divPOproductPaging ul").html(innerhtml);

            }
        }

        //页码被点击之后，更新产品列表。
        function pageNoClick(obj)
        {
            var clickPageNo = $(obj).text();
            var startRow;

            if(clickPageNo == "<<")
            {
                clickPageNo = parseInt($(obj).next().text())-1;

                startRow = ( clickPageNo - pageNoLimit ) * pageSize >= 0 ? ( clickPageNo - pageNoLimit ) * pageSize : 0;
            }
            else
                if(clickPageNo == ">>")
                {
                    clickPageNo = parseInt($(obj).prev().text())+1; 

                    startRow = ( clickPageNo - 1 ) * pageSize;
                }
                else
                {
                    startRow = ( clickPageNo - 1 ) * pageSize;
                
                }

            //刷新页码列表
            ProductPaging(clickPageNo);


            //更新产品列表
            var plihtml = "";
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxManufacture.ProductListPaging(productOrderNo, startRow, pageSize, 1);

            if(ajax.error==null)
            {
                var plist = ajax.value;
                
                for(var j = 0; j<plist.length; j++)
                {
                    plihtml += "<li>"+plist[j].SerialNumber+"</li>"
                }

                $("#divPOproductlist ul").html(plihtml);
            }
            else
            {
                alert(ajax.error.Message);
                return false;
            }

            
        }


        function OutStockCheck(id){
            var data="<div>";
            data+="<table class='ListTable ListTableHeader'>"
            data+="<tbody>"
            data+="<tr><th>扫描编码</th><th>关联卡通箱</th><th>关联SN</th></tr>"
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxManufacture.GetMemberHistoryList(id);
            if (ajax.error != null) {
                alert(ajax.error.Message);
            }
            for (var i = 0; i < ajax.value.length; i++) {
                data+="<tr><td>"+ajax.value[i].Number+"</td><td>"+ajax.value[i].CartonCode+"</td><td>"+ajax.value[i].Code+"</td></tr>";
            }
               
            data+="</tbody></table></div>";
            layer.open({
                type: 1,
                area: ['45%', '65%'],
                shadeClose: true, //点击遮罩关闭
                content: data
            });
        }

        function showTestXml(recordID){
            if (recordID == "" || recordID == undefined) return false;

            openWinUrl = "ShowTestData.aspx?RecordID=" + recordID;
            dialog({ title: "测试数据展示", src: openWinUrl, width: 1030, height: 600,resizeable:false });
        }
    </script>
</asp:Content>
