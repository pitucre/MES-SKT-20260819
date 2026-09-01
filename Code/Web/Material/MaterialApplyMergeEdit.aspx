<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master"
    AutoEventWireup="true" CodeBehind="MaterialApplyMergeEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Material.MaterialApplyMergeEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label4">领料单<em>*</em>
            </td>
            <td class="Field4">
                <asp:TextBox ID="txtApplyNo" runat="server" CssClass="TextBox"  ClientIDMode="Static"></asp:TextBox>
                <input type="button" id="bnOper" class="ButtonBox" onclick="selectPickingList()" value="..." />
            </td>
        </tr>
    </table>
    <div style="height: 5px"></div>
    <table class="ListTable" width="100%" id="tbApplyList" >
        <thead>
            <tr class="ListTableHeader" style="text-align: center">
                <th width="5%">序号</th>
                <th>领料单号码</th>
                <th>物料项次数</th>
                <th>操作</th>
            </tr>
        </thead>
        <tbody>
            <tr id="trLast" class="ListTableOddRow">
                <td colspan="4" style="text-align: center;">暂无数据
                </td>
            </tr>
        </tbody>
    </table>
    <script type="text/javascript" src="../Content/js/jquery-3.1.0.min.js"></script>
    <script type="text/javascript" src="../Content/plugin/jquery-easyui-1.4.2/layer/layer.js"></script>
    <script type="text/javascript">
        var arrApply = [];//

        $(function () {
            $("#txtApplyNo").keydown(function (e) {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    GetApplyDtlInfo();
                    return false;
                }
            });

        })

        //选择领料单
        function selectPickingList() {
            var searchCondition = " Statue =0 and ApplyClass=-1";
            
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=83&PageCondition="
                + escape(searchCondition) + "&Multiple=false&CallBackFunc=getChooseValue&rnd=" + Math.random(), width: 650, height: 340
            });
        }
        function getChooseValue(list) {
            $("#txtApplyNo").val(list[0][1]);
            GetApplyDtlInfo();
        }
        //通过领料单查询明细信息
        function GetApplyDtlInfo() {
            var ApplyNo = $("#txtApplyNo").val();

            //判断领料单是否已经添加
            if (existsApply(ApplyNo)) {
                alert("该领料单已经添加");
                return false;
            }

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialApply.GetApplyDtlInfo(ApplyNo);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                $("#txtApplyNo").val("");
                return false;
            }
            var entity = ajax.value;
            if (entity != null) {
                var obj = {};
                obj.ApplyNo = entity.ApplyNo;
                obj.ItemQty = entity.ItemQty;
                arrApply.push(obj);
                Show();
            }
            $("#txtApplyNo").val("");
        }

        //判断领料单是否已经添加
        function existsApply(ApplyNo) {
            for (var i = 0; i < arrApply.length; i++) {
                if (arrApply[i].ApplyNo == ApplyNo) {
                    return true;
                }
            }
        }

        //加载列表
        function Show() {
            var data = "";
            $("#tbApplyList tbody").html("");
            //将GRN数组拼接成HTML代码
            var html = ApplyHtml();
            $("#tbApplyList tbody").append(html);
        }

        //将数组拼接成HTML代码
        function ApplyHtml() {
            var html = "";
            for (var i = 0; i < arrApply.length; i++) {
                var s = "";
                html += "<tr onclick='trClick(this)'><td class='Field1' style='width:5%;text-align: center;'>" + (i + 1) + "</td>"
                    + "<td class='Field1' style='text-align: center;'>" + arrApply[i].ApplyNo + "</td>"
                    + "<td class='Field1' style='text-align: center;'>" + arrApply[i].ItemQty + "</td>"
                    + "<td class='Field1' style='text-align: center;'><img title='删除' src='../Content/images/delete.gif' onclick=Delet('" + arrApply[i].ApplyNo + "')></img></td></tr>";
            }
            return html;
        }

        //删除
        function Delet(ApplyNo) {
            var idx = -1;
            for (var i = 0; i < arrApply.length; i++) {
                if (arrApply[i].ApplyNo == ApplyNo) {
                    idx = i;
                    break;
                }
            }
            if (idx > -1) {
                arrApply.splice(idx, 1);
            }
            //重置列表
            var html = ApplyHtml();
            $("#tbApplyList tbody").html(html);
        }
        //行点击事件
        function trClick(obj, Model) {
            $("#tbApplyList tbody").find("td").css('background', '#fff');
            $(obj).find("td").css('background', '#ACBAD4');
        }

        /*保存数据*/
        function Save() {
           
            /*表单验证*/
            /*如需表单验证可以此处处理验证 开始*/

            var list = [];
            for (var i = 0; i < arrApply.length; i++) {
                var entity = {};
                entity.RowId = (i + 1);
                entity.ApplyNo = arrApply[i].ApplyNo;
                entity.ItemQty = arrApply[i].ItemQty;
                list.push(entity);
            }

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialApply.SaveMergeApply(list);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert('保存成功！')

            parent.window.Refresh();
        }
    </script>
</asp:Content>
