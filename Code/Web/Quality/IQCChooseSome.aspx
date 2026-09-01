<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="IQCChooseSome.aspx.cs" Inherits="SKT.LeanMES.Web.Quality.IQCChooseSome" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <table id="tabTmplContent1" class="EditeContentTable" style="width: 100%;">
        <tr id="idGrn">
            <td class="Label1">
                GRN扫描
            </td>
            <td class="Field1">
                <input type="text" class="TextBox" id="txtGrn" onchange="changeGrn(this)" />
            </td>
        </tr>
        <tr>
            <td class="Label1">
                是否挑选完毕
            </td>
            <td class="Field1">
                <input type="checkbox" id="checkAll" />
            </td>
        </tr>
    </table>
    <br />
    <table id="tbGrnInfo" class="EditeContentTable" style="width: 100%;">
        <tr>
            <td class='Label1' style='text-align: center; width: 15%'>
                半成品条码
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
        </tr>
    </table>
    <script type="text/javascript">
        var InsId = '<%=Request.QueryString["ID"] %>';
        var List = [];
        var isGrn = 1;
        $(function () {
            getGrnBackInfo();
            //input 事件焦点设定
            $('input').click(function () {
                this.blur();
                this.focus();
            });
        })
        //根据IQC检验单带出物料信息
        function getGrnBackInfo() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.GetIQCFormGrn(InsId);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return;
            }

            //判断是否条码
            var en = $.parseJSON(ajax.value);
            if (en.data[0].IsGRN === 0) {
                $("#idGrn").css("display", "none");
                isGrn = 0;
            }

            //加载GRN信息
            List = en.data1;
            $.grep(List, function (o, j) {
                if (o.ChooseQty == "") {
                    o.ChooseQty = 0;
                }
                if (o.ScrapQty == "") {
                    o.ScrapQty = 0;
                }
                AddDtl(o);
            });
        }
        //根据GRN取得信息
        function changeGrn(t) {
            var GRN = $.trim($(t).val());
            showGrn(GRN);
            $(t).val("");
        }
        function showGrn(GRN) {
            //判断存在以否
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.GetMaterialIQCHandleGrn(GRN, InsId);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return;
            }
            var en = $.parseJSON(ajax.value);
            if (!en.IQCGrnNgId) {
                alert("GRN条码不存在或不属于该检验单");
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
        //挑选数
        function ChangeNg(totalQty, Grn, t) {
            var qty = $.trim($(t).val());
            if (!isNumber($.trim($(t).val()))) {
                alert("数量格式填写错误");
                $(t).val(0);
                qty = 0;
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
                    $(t).parent().parent().find("label").text(o.OKQty);
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

        function AddDtl(e) {
            var tr = "<tr>" +
                        "<td class='Field1' style=' width:15%'>" + e.GRN + "</td>" +
                        "<td class='Field1' style=' width:15%'>" + e.ItemCode + "</td>" +
                        "<td class='Field1' style=' width:12%'>" + e.TotalQty + "</td>" +
                        "<td class='Field1' style=' width:12%'><label>" + e.OKQty + "</label></td>" +
                        "<td class='Field1' style=' width:13%'><input type='text' IsNumber='1' IsRequired='1' value= '" +
                            e.NgQty + "' style='width:90%' onchange='ChangeNg(" + e.TotalQty + ", " + e.GRN + ", $(this))'/></td>" +
                        "<td class='Field1' style=' width:18%'><input type='text' value= '" + e.Remark + "' style='width:90%' onchange='ChangeRemark(" + e.GRN + ", $(this))'/></td>" +
                        "</tr>";
            $('#tbGrnInfo').append(tr);
        }

        //保存
        function Save() {
            var isFinish = 0;
            if ($('#checkAll').attr('checked')) {
                isFinish = 1;
            }
            if (List.length == 0) {
                alert("请输入数据后再保存!");
                return;
            }
            var entity = {};
            entity.InspectionId = InsId;
            entity.isFinish = isFinish; //是否挑选完毕
            entity.tbDtl = JSON.stringify(List);
            //判断存在以否
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.SaveIQCFormAttendGRN(JSON.stringify(entity));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return;
            }
            alert("保存成功");
            parent.window.refresh();
        }
    </script>
</asp:Content>
