<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/EditMaster.master" CodeBehind="SaleReturnEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Warehouse.SaleReturnEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">

    <link href="../Content/plugin/bootstrap-v3.3.5/css/bootstrap.css" rel="stylesheet" />
    <link href="../Content/plugin/bootstrap-fileinput/css/fileinput.css" rel="stylesheet" />
    <script src="../Content/js/jquery-1.10.2.js"></script>
    <script src="../Content/plugin/bootstrap-v3.3.5/js/bootstrap.js"></script>
    <script src="../Content/plugin/bootstrap-fileinput/js/fileinput.js"></script>
    <script src="../Content/plugin/bootstrap-fileinput/js/fileinput_locale_zh.js"></script>

    <style type="text/css">
        .ListTableHeader th { background: none no-repeat #f5f5f5 }
        #item-list .EquipmentCode { width: 120px; float: left; }
        #item-list .ItemCode { width: 120px; float: left; }
        #item-list .ScrapItemCode { width: 120px; float: left; }
        #item-list .GreaterThanOrEqualZero { width: 60px; }
        .delete a { color: #0000ee; }
        .add-item { display: none; }

        .file-drop-zone-title { padding: 10px 0px; }
        .TestStartFileName { display: none; }
        .TestEndFileName { display: none; }
    </style>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">客户编码<em>*</em></td>
            <td class="Field2">
                <asp:TextBox ID="txtCustomer" runat="server" CssClass="TextBox" Enabled="false" ClientIDMode="Static"></asp:TextBox><input
                    type="button" id="btnSelectCustomer" class="ButtonBox" runat="server" value="..." title="Select"
                    onclick="openChoosePage(10,this);" />
                <asp:HiddenField ID="hdnCustomerId" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
        </tr>
        <tr class="quality-edit trNo"  style="display:none">
            <td class="Label2 trNo">退货单号<em>*</em></td>
            <td class="Field2 trNo">
                <asp:TextBox runat="server" ID="txtSaleReturnNo" ClientIDMode="Static" Width="160"></asp:TextBox>
            </td>
        </tr>
        <tr class="quality-edit">
            <td class="Label2">退货时间<em>*</em></td>
            <td class="Field2">
                <asp:TextBox runat="server" ID="TestEndTime" CssClass="DateTimeBox" ClientIDMode="Static" Width="160"></asp:TextBox>
            </td>
        </tr>
        <tr class="base">
            <td class="Label2">退货备注</td>
            <td class="Field2" >
                <asp:TextBox runat="server" ID="SendRemark" CssClass="TextArea" ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr>
    </table>
    <table class="ListTable" width="100%" id="item-list">
        <thead>
            <tr class="ListTableHeader">
                <th style="width: 40px;">序号</th>
                <th>备货单号</th>
                <th>备货单行号</th>
                <th>产品编码</th>
                <th>仓库编码</th>
                <th>退货数量</th>
                <th class="delete"><a type="button" href="#" onclick="add(null)">新增</a></th>
            </tr>
        </thead>
        <tbody>
        </tbody>
    </table>

    <script type="text/javascript">
        var SaleReturnId = "<%=Request.QueryString["SaleReturnId"]%>"; 
        var pageFlag = -1;
        var flag = -1;
        var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
        var userId = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserId %>";
        var currentTime = "<%=DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")%>";
        var chooseObj = null;

        $(document).ready(function () {
            $("#item-list").on("click", ".delete-item", function () {
                $(this).closest("tr").remove();
                //序号重新排列
                refreshRowNum();
            });

            if (SaleReturnId != "" && SaleReturnId != "-1") {
                //退料明细表ID查询退料表ID并替换
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSaleReturn.GetSaleReturnByDel(parseInt(SaleReturnId));
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }

                var listM = ajax.value;
                if (!listM || !listM[0].SaleReturnId) {
                    alert("未获取到退货信息");
                    return false;
                }

                SaleReturnId = listM[0].SaleReturnId

                $(".trNo").css("display","");
                pageFlag = 2;
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSaleReturn.GetSaleReturnDetailAll(parseInt(SaleReturnId));
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                var list = ajax.value;
                if (!list || !list[0].SaleReturnId) {
                    alert("未获取到退货信息");
                    return false;
                }

                if (list == null || list.length <= 0) {
                    return;
                }
                var entity = list[0];

                $("#txtCustomer").val(entity.CustomerCode);
                $("#txtSaleReturnNo").val(entity.SaleReturnNo);
                $("#TestEndTime").val(entity.SaleReturnDate);
                $("#SendRemark").val(entity.Remark);

                add(list);
            } else {
                //新增
                pageFlag = 1;
                add(null);
            }
        });

       
        //新增
        function add(list) {
            if (list == null) {
                list = [];
                list.push({
                    DNCode: "",
                    DNRowId: "",
                    ItemCode: "",
                    CWhCode: "",
                    SaleReturnQty: 0
                });
            }
            var hl = "";
            for (var i = 0; i < list.length; i++) {
                var entity = list[i];

                hl += "<tr class=\"ListTableOddRow\">" +
                    "<td class=\"row\"></td>" +
                    "<td style=\"width:170px;\"><input type=\"text\" class=\"DNCode\" value=\"" + entity.DNCode + "\" style=\"width:100px;\"/><input type=\"button\" class=\"ButtonBox\" onclick=\"selectSalOrder(this)\" value=\"...\" /></td>" +
                    "<td class=\"DNRowId\">" + entity.DNRowId + "</td>" +
                    /*<input type=\"button\" class=\"ButtonBox\" onclick=\"openChoosePage('1_1',this)\" value=\"...\" />*/
                    "<td style=\"width:150px;\"><input type=\"text\" class=\"ItemCode\" value=\"" + entity.ItemCode + "\" style=\"width:100px;\"/></td>" +
                    "<td style=\"width:170px;\"><input type=\"text\" class=\"CWhCode\" value=\"" + entity.CWhCode + "\" style=\"width:100px;\"/><input type=\"button\" class=\"ButtonBox\" onclick=\"openChoosePage('14',this)\" value=\"...\" /></td>" +
                    "<td style=\"width:80px;\"><input type=\"text\" class=\"SaleReturnQty\" value=\"" + entity.SaleReturnQty + "\" style=\"width:80px;\"/></td>" +
                    /*"<td class=\"SaleReturnQty\">" + entity.SaleReturnQty + "</td>" +*/
                    "<td class=\"delete\"><a href=\"#\" class=\"delete-item\">删除</a></td>" +
                    "</tr>";
            }
            $("#item-list tbody").append(hl);

            //序号重新排列
            refreshRowNum();
        }

        //保存数据
        function Save() {
            var trs = $("#item-list tbody tr");
            if (trs.length <= 0) {
                alert("请先添加明细信息");
                return;
            }

            var entity = {};
            entity.SaleReturnId = parseInt(SaleReturnId);
            entity.FactoryCode = '';
            entity.CustomerCode = $.trim($("#txtCustomer").val());
            entity.SaleReturnType = 0;
            entity.SaleReturnDate = $.trim($("#TestEndTime").val());
            entity.Remark = $.trim($("#SendRemark").val());
            entity.Status = 0;
            entity.ReturnBy = userName;
            entity.ReturnTime = $.trim($("#TestEndTime").val());
            entity.UserName = userName;
           
            //遍历需要新增、编辑的数据
            var arr = [];
            var trObj;
            var item = {};
            var isOk = true;
            var arrItem = [];
            var i = 1;
            trs.each(function () {
                trObj = $(this);
                item = {};
                item.Num = i;
                item.FactoryCode = "";
                item.DNCode = $.trim(trObj.find(".DNCode").val());  //备料单
                item.DNRowId = parseInt($.trim(trObj.find(".DNRowId").html()));  //备料单行号
                item.SaleOrderNo = "";
                item.SaleOrderItem = 0;
                item.ItemCode = $.trim(trObj.find(".ItemCode").val());  //产品编码
                item.CustomerOrderNo = "";
                item.CustomerOrderItem = "";
                item.CWhCode = $.trim(trObj.find(".CWhCode").val());  //仓库编码
                item.SaleReturnQty = parseInt($.trim(trObj.find(".SaleReturnQty").val()));;  //退料数量
                item.CurrentReturnQty = parseInt($.trim(trObj.find(".SaleReturnQty").val())); ;  //退料数量
                item.Remark = "";
                item.Status = 0;
                item.UserName = userName;

                if (item.ItemCode == "") {
                    trObj.find(".ItemCode").val("").focus();
                    alert("产品编码不能为空");
                    isOk = false;
                    return false;
                }
                if (arrItem.indexOf(item.ItemCode) > -1) {
                    alert("产品编码[" + item.ItemCode + "]重复，请检查");
                    isOk = false;
                    return false;
                }
                var txtSaleReturnQty = $.trim(trObj.find(".SaleReturnQty").val()); 
                if (/^\d+$/.test(txtSaleReturnQty) == false)
                {
                    trObj.find(".SaleReturnQty").focus();
                    alert("退货数量只能是整数，且不能小于等于0");
                    isOk = false;
                    return false;
                }
                if (item.SaleReturnQty <= 0 || Number.isNaN(item.SaleReturnQty)||item.SaleReturnQty==undefined) {
                    trObj.find(".SaleReturnQty").focus();
                    alert("退货数量不能小于等于0");
                    isOk = false;
                    return false;
                }
                arr.push(item);
                arrItem.push(item.ItemCode);
                i++;
            });
            if (!isOk) {
                return false;
            }

            entity.ItemList = JSON.stringify(arr);
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSaleReturn.SaleReturnEdit(JSON.stringify(entity));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert('<%=Resources.Messages.SaveInSuccess%>');
            window.parent.Refresh();
        }

        //序号重新排列
        function refreshRowNum() {
            $("#item-list tbody tr td.row").each(function (i) {
                $(this).text(i + 1);
            });
        }

        //选择页面
        function openChoosePage(flags, obj) {
            flag = flags;
            var pageId = flags;
            if (flags == "1_1") {
                pageId = 1;
                chooseObj = $(obj).siblings(".ItemCode");
            } else if (flags == 14) {
                chooseObj = $(obj).siblings(".CWhCode");
            }

            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=" + pageId + "&Multiple=false&rnd=" + Math.random(), width: 700, height: 350 });
        }

        function selectSalOrder(obj) {
            flag = 842;
            chooseObj = $(obj).siblings(".DNCode");
            var searchCondition = " Status<>4 "; // "Status=1"; 
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=842&PageCondition= " + searchCondition + "&Multiple=false&rnd=" + Math.random(), width: 550, height: 300 });
        }

        //获取选择值
        function getChooseValue(list) {
            if (flag == "1_1") {
                //产品(跟备料单一起选择)
            } else if (flag == 10) {
                //客户编码
                $("#txtCustomer").val(list[0][2]);
            } else if (flag == 14) {
                //仓库编码
                chooseObj.val(list[0][1]);
            } else if (flag == 842) {
                //备料单
                chooseObj.val(list[0][1]);
                chooseObj.parent().parent().find(".DNRowId").html(list[0][2]);
                chooseObj.parent().siblings().find(".ItemCode").val(list[0][3]);
            }
            flag = -1;
        }

        //获取时间字符串形式
        function getDateString(date) {
            if (!date) {
                return "";
            }
            var today = new Date(date);
            return today.Format();
        }

        //时间转字符串
        Date.prototype.Format = function (fmt) {
            if (undefined == fmt || null == fmt) {
                fmt = "yyyy-MM-dd HH:mm:ss";
            }
            var t = this;
            var tf = function (str, len) {
                if (str.length < len) {
                    for (var i = 0; i < len - str.length; i++) {
                        str = "0" + str;
                    }
                }
                return str
            };
            var opt = {
                "y+": t.getFullYear().toString(),        // 年
                "M+": (t.getMonth() + 1).toString(),     // 月
                "d+": t.getDate().toString(),            // 日
                "H+": t.getHours().toString(),           // 时
                "m+": t.getMinutes().toString(),         // 分
                "s+": t.getSeconds().toString()          // 秒
                // 有其他格式化字符需求可以继续添加，必须转化成字符串
            };
            var ret;
            for (var k in opt) {
                ret = new RegExp("(" + k + ")").exec(fmt);
                if (ret) {
                    fmt = fmt.replace(ret[1], ret[1].length == 1 ? opt[k] : tf(opt[k], ret[1].length));
                }
            }
            return fmt;
        }

        
    </script>
</asp:Content>
