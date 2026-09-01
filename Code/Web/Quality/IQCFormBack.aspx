<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="IQCFormBack.aspx.cs" Inherits="SKT.LeanMES.Web.Material.IQCFormBack" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <table id="tabTmplContent1" class="EditeContentTable" style="width: 100%;">
        <tr id="idGrn">
            <td class="Label1">
                物料条码扫描
            </td>
            <td class="Field1">
                <input type="text" value="" id="txtGRN" class="TextBox" style="width: 250px; height: 25px;
                    font-size: 16px; font-weight: bold; text-transform: uppercase;" />
            </td>
        </tr>
    </table>
    <br />
    <table id="tbGrnInfo" class="EditeContentTable" style="width: 100%;">
        <tr>
            <td class='Label1' style='text-align: center; width: 15%'>
                物料条码
            </td>
            <td class='Label1' style='text-align: center; width: 15%'>
                料号
            </td>
            <td class='Label1' style='text-align: center; width: 12%'>
                物料总数量
            </td>
            <td class='Label1' style='text-align: center; width: 12%'>
                合格数
            </td>
            <td class='Label1' style='text-align: center; width: 13%'>
                不合格数
            </td>
            <td class='Label1' style='text-align: center; width: 18%'>
                备注
            </td>
            <td class='Label1' style='text-align: center; width: 10%'>
                操作
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        var InsId = '<%=Request.QueryString["ID"] %>';
        var OrderStatue = '<%=Request.QueryString["OrderStatue"] %>';
        var List = [];
        var isGrn = 1;
        $(function () {
            /*扫描条码*/
            $("#txtGRN").keydown(function () {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    if ($.trim($("#txtGRN").val()) != "") {
                        showDelList();
                        return false;
                    } else {
                        alert("请先扫描GRN");
                        $("#txtGRN").focus();
                        $("#txtGRN").select();
                        return false;
                    }
                }
            });
            getGrnBackInfo();
        });

        function getGrnBackInfo() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxInspection.GetIQCFormGrnBack(InsId);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return;
            }

            //判断是否条码
            var en = $.parseJSON(ajax.value);
            if (en.data[0].IsGRN === 0 || OrderStatue=="3") {
                $("#idGrn").css("display", "none");
                isGrn = 0;
            }

            //加载退货信息
            List = en.data1;
            $.grep(List, function (o, j) {
                AddDtl(o);
            });
        }

        //不合格数
        function ChangeNg(totalQty, Grn, t) {
            var qty = $.trim($(t).val());
            if (!isNumber($.trim($(t).val()))) {
                alert("不合格数量格式填写错误");
                $(t).val("");
                return;
            }
            if (totalQty < qty) {
                alert("不合格数量超过总数量");
                $(t).val("");
                return;
            }
            $.grep(List, function (o, j) {
                if (o.GRN == Grn) {
                    o.NgQty = $.trim($(t).val());
                    o.OKQty = o.TotalQty - o.NgQty;
                    $(t).parent().parent().find("label").text(o.OKQty)
                };
            });
        }

        //备注
        function ChangeRemark(Grn, t) {
            $.grep(List, function (o, j) {
                if (o.GRN == Grn) {
                    o.Remark = $.trim($(t).val());
                };
            });
        }

        //删除行
        function deleteRow(Grn, t) {
            var index = -1;
            $.grep(List, function (o, j) {
                if (o.GRN == Grn) {
                    index = j;
                }
            });
            $(t).parent().parent().remove();
            List.splice(index, 1);
        }

        //根据GRN取得信息
        function showDelList() {
            var GRN = $.trim($("#txtGRN").val());
            //判断存在以否
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxInspection.GetIQCFormGrnBackByGrnIqcId(GRN, InsId);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return;
            }
            var en = $.parseJSON(ajax.value);
            
            if (!en.IQCGrnNgId) {
                alert("GRN条码不存在或不属于该检验单");
                $("#txtGRN").focus();
                $("#txtGRN").select();
                $("#txtGRN").val("");
                return;
            }

            //添加
            var index = -1;
            $.grep(List, function (o, j) {
                if (o.GRN === GRN) {
                    index = j;
                }
            });
            if (index === -1) {
                AddDtl(en);
                List.push(en);
            }
            $("#txtGRN").val("");
        }

        function AddDtl(e) {
            var tr = "<tr>" +
                        "<td class='Field1' style=' width:15%'>" + e.GRN + "</td>" +
                        "<td class='Field1' style=' width:15%'>" + e.ItemCode + "</td>" +
                        "<td class='Field1' style=' width:12%'>" + e.TotalQty + "</td>" +
                        "<td class='Field1' style=' width:12%'><label>" + e.OKQty + "</label></td>" +
                        "<td class='Field1' style=' width:13%'><input type='text' IsNumber='1' IsRequired='1' value= '" +
                            e.NgQty + "' style='width:90%' onchange='ChangeNg(" + e.TotalQty + ", " + e.GRN + ", $(this))'/></td>" +
                        "<td class='Field1' style=' width:18%'><input type='text' value= '" + e.Remark + "' style='width:90%' onchange='ChangeRemark(" + e.GRN + ", $(this))'/></td>" +
                        "<td class='Field1' style=' text-align:center; width:10%'>" +
                            (isGrn === 0 || OrderStatue == "3" ? "" : ("<span style='font-size:15px; color:Red' onclick= 'deleteRow( " +
                            e.GRN + ", $(this));' >移除</span>")) + "</td></tr>";
            $('#tbGrnInfo').append(tr);
        }

        //保存
        function Save() {
            if (OrderStatue == "3") {
                alert("该检验单已交接确认，不能修改");
                return;
            }
            var entity = {};
            entity.InspectionId = InsId;
            entity.tbGRNDtl = JSON.stringify(List);

            //判断存在以否
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxInspection.SaveIqcGrnBack(JSON.stringify(entity));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return;
            }
            alert("保存成功");
            window.parent.closeDialog();
        }

    </script>
</asp:Content>
