<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="EAIInspectionSN.aspx.cs" Inherits="SKT.LeanMES.Web.Client.EAIInspectionSN" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <div class="infoTips">
        录入产品序列号后，请点击【保存检验项】按钮保存录入值 ！</div>
    <table id="tabTmplContent" class="EditeContentTable" style="width: 100%; margin-bottom: 5px;">
        <tr>
            <td class="Label1" align="right">检验结果<em>*</em>
            </td>
            <td class="Field1">
                <input type="checkbox" id="chkOK" value="OK" style="height:16px;width:16px;" onclick="setResult(this.value)" /><span style="color:green;">合格</span> &nbsp;
                <input type="checkbox" id="chkNG" value="NG"  style="height:16px;width:16px;"  onclick="setResult(this.value)" /><span style="color:red;">不合格</span>
            </td>
        </tr>
        <tr>
            <td class="Label2" align="right">产品序列号<em>*</em>
            </td>
            <td class="Field2">
                <input type="text" id="txtSNByProduct" IsRequired="1" />
            </td>
        </tr>
        <tr>
            <td class="Label2" align="right">不良现象
            </td>
            <td class="Field2">
                <input type="text" id="txtNGCode" />
            </td>
        </tr>
        <tr>
            <td class="Label2" align="right">
            </td>
            <td class="Field2">
             <input id="btnSaveEAICode"   onclick="saveSN()" type="button"
                        title="添加" style="cursor: pointer;" value=" 添 加 " />

                <input id="btnClose"   onclick="closeDailog()" type="button"
                        title="保存" style="cursor: pointer;margin-left:15px;" value=" 关 闭 " />
            </td>
        </tr>
    </table>

    <table class="ListTable" id="tabTurnOverList" width="100%">
            <tr class="ListTableHeader" style="height: 30px;">
                <th scope="col"  >产品序列号
                </th>
                <th scope="col" style="width: 60px">检验结果
                </th>
                <th scope="col" >不良现象
                </th>
                <th scope="col" style="width: 140px;">扫描时间
                </th>
                <th scope="col" style="width: 50px">操作
                </th>  
            </tr>
           <tbody id="checkSNTb">
                <tr  class="ListTableOddRow">
                <td colspan="8" style="text-align: center;">暂无数据
                </td>
            </tr>
           </tbody>
           
        </table>

    <script type="text/javascript">

        $().ready(function () {
            console.log(parent.EAISNArr);
            addTrContent(parent.EAISNArr);

            //扫描框回车事件
            $("#txtSNByProduct").keydown(
                function (e) {
                    var curKey = 0, e = e || window.event;
                    curKey = e.keyCode || e.which || e.charCode;

                    if (curKey == 13) {
                        stopDefault(e);
                        e.stopPropagation();
                        e.preventDefault();
                        if (this.value == "") {
                            return;
                        }
                        afterScanByProduct();
                        return false;
                    }
                    if (curKey == 46) {
                        $("#txtSNByProduct").val("");
                    }
                }
            );
        });
        
        function afterScanByProduct() {
            var resultNG = $("#chkNG").prop("checked");
            var resultOK = $("#chkOK").prop("checked");            ;
            if (resultNG == false && resultOK == false) {
                alert("请选择检验结果！");
                setTimeout(function () {
                    $("#txtSNByProduct").select();
                }, 100);
                return false;
            }
            if (resultOK == true) {               
                saveSN();
            }            
        }

        function setResult(result) {
            if (result == "OK") {
                $("#chkNG").prop("checked", false);
                $("#chkOK").prop("checked", true);
                $("#txtNGCode").val("").attr("disabled", "disabled"); 
            }
            else {
                $("#chkNG").prop("checked", true);
                $("#chkOK").prop("checked", false);
                $("#txtNGCode").removeAttr("disabled"); 
            }
            $("#txtSNByProduct").focus();
        }

        function saveSN() {
            var resultNG = $("#chkNG").prop("checked");
            var resultOK = $("#chkOK").prop("checked");
            var result = "";
            if (resultNG == false && resultOK == false) {
                alert("请选择检验结果！");
                return false;
            }
            if (resultNG == true) {
                result = "NG";
            }
            else {
                result = "OK";
            }
            //单纯点击保存时不验证产品序列号文本框是否有值
            var sn = $.trim($("#txtSNByProduct").val());
            if (sn == "") {
                alert("请输入产品序列号！");
                $("#txtSNByProduct").focus();
                return false;
            }
            
            var ncCode = $.trim($("#txtNGCode").val());
            //if (result == "NG" && ncCode == "") {
            //    alert("当前检验结果为[不合格]，请输入不良现象！");
            //    $("#txtNGCode").focus()
            //    return false;
            //}
            var isExist = false;
            parent.EAISNArr.forEach(function (obj) {
                if (obj.SN == sn) {
                    isExist = true;
                }
            });

            if (isExist) {
                alert("产品序列号[" + sn + "]已存在列表中，不可重复添加！");
                setTimeout(function () {
                    $("#txtSNByProduct").select();
                }, 100);
                return;
            }

            if (!checkEAISN(sn)) {
                return false;
            }

            var entity = {};
            entity.IOMemberId = -1;
            entity.Result = result;
            entity.SN = sn;
            entity.NCCode = ncCode;
            entity.ScanTime =  '<%=DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") %>';
            parent.EAISNArr.push(entity);
            addTrContent(parent.EAISNArr);

            //$("#chkOK,#chkNG").prop("checked", false);            
            $("#txtNGCode").val("");//.removeAttr("disabled");
            setTimeout(function () {
                $("#txtSNByProduct").val("").select();
            }, 100);
        }

        function checkEAISN(sn) {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxQC.CheckEAISN(parent.OrderId, sn);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                setTimeout(function () {
                    $("#txtSNByProduct").select();
                }, 100);
                return false;
            }
            return true;
        }

        function addTrContent(list) {             
            var tbObj = $("#checkSNTb");
            var trHtml = "";
            var entity;
            
            for (var i = 0; i < list.length; i++) {
                entity = list[i];

                trHtml += "<tr class='ListTableOddRow'><td>" + entity.SN + "</td><td>" + entity.Result + "</td><td>" + entity.NCCode + "</td><td>" + entity.ScanTime + "</td><td><span   style='color:blue;cursor:pointer'  onclick=\"cancel('" + entity.SN + "')\"> 删 除 </button></td>";
            }
            tbObj.html(trHtml);
        }

        function cancel(sn) {
            parent.EAISNArr.forEach(function (obj,i) {
                if (obj.SN == sn) {
                     parent.EAISNArr.splice(i, 1);
                }
            });
            addTrContent(parent.EAISNArr);
        }

        function closeDailog() {
            parent.closeDialog();
        }
    </script>
</asp:Content>
