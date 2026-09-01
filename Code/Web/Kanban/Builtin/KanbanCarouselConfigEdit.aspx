<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="KanbanCarouselConfigEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Kanban.Builtin.KanbanCarouselConfigEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <style type="text/css">
        .floatToolbar { left: 10px; }
    </style>
    <div class="infoTips">
        <%= Resources.Messages.WithAsteriskIsRequired %>
    </div>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">轮播看板名<em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtCarouselName" runat="server" CssClass="TextBox" IsRequired="1" ClientIDMode="Static"></asp:TextBox>
            </td>
            <td class="Label2">轮播时间(秒)<em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtCarouselTime" runat="server" CssClass="TextBox" IsRequired="1" ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">描述
            </td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtRemark" runat="server" TextMode="MultiLine" CssClass="TextArea" ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr>
    </table>

    <div class="ListTableTitle" style="margin: 2px 0px;">
        <span id="configList"></span>
    </div>

    <table id="tblExpand" style="width: 100%;" class="ListTable">
        <thead>
            <tr class="ListTableHeader" style="text-align: center">
                <th style="width: 5%;">
                    <input type="checkbox" id="chkAll" />
                </th>
                <th style="width: 10%;">播放顺序
                </th>
                <th style="width: 35%;">子看板名
                </th>
                <th style="width: 50%;">子看板URL
                </th>
            </tr>
        </thead>
        <tbody>
            <tr class="ListTableOddRow no-data">
                <td colspan="4" style="text-align: center;">
                    <%=Resources.Messages.HaveNothingData%>
                </td>
            </tr>
        </tbody>
    </table>
    <asp:HiddenField ID="hidCarouselConfigId" runat="server" Value="-1" ClientIDMode="Static" />
    <script language="javascript" type="text/javascript">

        $(function () {
            if (floatButtons != null) {
                document.getElementById("configList").innerHTML = floatButtons;
            }

            //全选/全不选
            $("#chkAll").change(function () {
                var checked = $(this).prop("checked");
                $("#tblExpand tbody .chk-item").prop("checked", checked);
            });

            //获取明细信息
            var carouselConfigId = $("#hidCarouselConfigId").val();
            if (carouselConfigId && carouselConfigId > -1) {
                var entity = {
                    CarouselConfigId: parseInt(carouselConfigId)
                };
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxKanban.GetKanBanCarouselConfigDetailByCarouselConfigId(entity);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                var list = ajax.value;
                var hl = "";
                for (var i = 0; i < list.length; i++) {
                    //hl += "<tr class=\"ListTableOddRow\"><td><input type=\"checkbox\" class=\"chk-item\" module=\"0\" detail-id=\"" + list[i].CarouselConfigDetailId + "\"/></td>"
                    //        + "<td>" + list[i].Sequence + "</td>"
                    //        + "<td>" + list[i].KanBanName + "</td>"
                    //        + "<td>" + list[i].KanBanURL + "</td>"
                    //        + "</tr>";
                    hl += LoadData(list[i], 0, false);
                }
                $("#tblExpand tbody").html(hl);
            }
        });

        //新增
        function Add() {
            removeEmptyRow();

            var hl = LoadData(null, 1, false);

            $("#tblExpand tbody").append(hl);
        }

        //加载数据
        function LoadData(entity, module, checked) {
            if (entity == null) {
                var seq = $("#tblExpand tbody tr:not(.no-data)").length;
                entity =
                {
                    CarouselConfigDetailId: -1,
                    Sequence: (seq + 1),
                    KanBanName: "",
                    KanBanURL: "",
                };
            }

            var url = entity.KanBanURL;
            if (url != "" && module == 0) {
                url = decodeURIComponent(url);
            }

            var hl = "<tr class=\"ListTableOddRow\"><td align=\"center\"><input type=\"checkbox\" class=\"chk-item\" detail-id=\"" + entity.CarouselConfigDetailId + "\" module=\"" + module + "\"/></td>"
                    + "<td class=\"td-seq\">" + (module == 0 ? entity.Sequence : "<input type=\"text\" class=\"TextBox kanban-seq\" style=\"width:40px;\" value=\"" + entity.Sequence + "\"/>") + "</td>"
                    + "<td class=\"td-name\">" + (module == 0 ? entity.KanBanName : "<input type=\"text\" class=\"TextBox kanban-name\" style=\"width:98%;\" value=\"" + entity.KanBanName + "\"/>") + "</td>"
                    + "<td class=\"td-url\">" + (module == 0 ? url : "<input type=\"text\" class=\"TextBox kanban-url\" style=\"width:98%;\" value=\"" + url + "\"/>") + "</td>"
                    + "</tr>";
            return hl;
        }


        //编辑
        function Edit() {
            var len = $("#tblExpand tbody .chk-item:checked").length;
            if (len <= 0) {
                alert("请选择记录。");
                return false;;
            }
            len = $("#tblExpand tbody .chk-item:checked[module=\"0\"]").length;
            if (len <= 0) {
                alert("选择的记录已是编辑模式");
                return false;;
            }

            //遍历
            $("#tblExpand tbody .chk-item:checked[module=\"0\"]").each(function () {
                var trObj = $(this).parents("tr");
                var entity =
                {
                    CarouselConfigDetailId: parseInt(trObj.find(".chk-item").attr("detail-id")),
                    Sequence: parseInt($.trim(trObj.find(".td-seq").text())),
                    KanBanName: $.trim(trObj.find(".td-name").text()),
                    KanBanURL: $.trim(trObj.find(".td-url").text()),
                };
                var hl = LoadData(entity, 1, trObj.find(".chk-item").prop("checked"));
                $(this).parent().parent().replaceWith(hl);
            });

        }

        //保存
        function Save() {
            var carouselConfigId = $.trim($("#hidCarouselConfigId").val());
            var carouselName = $.trim($("#txtCarouselName").val());
            var carouselTime = $.trim($("#txtCarouselTime").val());
            var remark = $.trim($("#txtRemark").val());
            if (!isPositiveInt(carouselTime)) {
                alert("轮播时间(秒)必须为正整数");
                $("#txtCarouselTime").val("").focus();
                return;
            }

            var entity =
            {
                CarouselConfigId: parseInt(carouselConfigId),
                CarouselName: carouselName,
                CarouselTime: parseInt(carouselTime),
                Remark: remark
            };

            var configDtl = [];
            var detailId;
            var kanbanSeq;
            var kanbanName;
            var kanbanURL;
            var module;
            var isOK = true;
            $("#tblExpand tbody tr:not(.no-data)").each(function () {
                detailId = $.trim($(this).find(".chk-item").attr("detail-id"));
                detailId == "" ? -1 : parseInt(detailId);
                module = $.trim($(this).find(".chk-item").attr("module"));

                kanbanSeq = module == 1 ? $.trim($(this).find(".kanban-seq").val()) : $.trim($(this).find(".td-seq").text());
                kanbanName = module == 1 ? $.trim($(this).find(".kanban-name").val()) : $.trim($(this).find(".td-name").text());
                kanbanURL = module == 1 ? $.trim($(this).find(".kanban-url").val()) : $.trim($(this).find(".td-url").text());

                if (kanbanSeq == "") {
                    alert("请输入顺序");
                    $(this).find(".kanban-seq").focus();
                    isOK = false;
                    return false;
                }
                if (!isPositiveInt(kanbanSeq)) {
                    alert("顺序必须为正整数");
                    $(this).find(".kanban-seq").val("").focus();
                    isOK = false;
                    return false;
                }
                if (kanbanName == "") {
                    alert("请输入子看板名称");
                    $(this).find(".kanban-name").focus();
                    isOK = false;
                    return false;
                }
                if (kanbanURL == "") {
                    alert("请输入子看板URL");
                    $(this).find(".kanban-url").focus();
                    isOK = false;
                    return false;
                }
                if (!isURL(kanbanURL)) {
                    alert("子看板URL格式不正确");
                    $(this).find(".kanban-url").focus();
                    isOK = false;
                    return false;
                }

                var entity =
                {
                    CarouselConfigDetailId: detailId,
                    KanBanName: kanbanName,
                    KanBanURL: encodeURIComponent(kanbanURL),
                    Sequence: parseInt(kanbanSeq),
                    Remark: ""
                };
                configDtl.push(entity);
            });
            if (!isOK) {
                return;
            }
            if (configDtl.length <= 0) {
                alert("请添加明细信息");
                return;
            }

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxKanban.KanBanCarouselConfigEdit(entity, JSON.stringify(configDtl));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert("<%=Resources.Messages.SaveInSuccess %>");
            parent.window.Refresh();
        }

        //删除
        function Delete() {
            var len = $("#tblExpand tbody .chk-item:checked").length;
            if (len <= 0) {
                alert("请选择记录。");
                return false;;
            }
            $("#tblExpand tbody .chk-item:checked").parent().parent().remove();
        }

        //是否为正整数
        function isPositiveInt(val) {
            var reg = /^[1-9]\d*$/;
            return reg.test(val);
        }

        //移除空行
        function removeEmptyRow() {
            $("#tblExpand tbody tr.no-data").remove();
        }

        //是否为URL
        function isURL(url) {
            //var strRegex = '^((https|http|ftp|rtsp|mms)?://)'
            //        + '?(([0-9a-z_!~*().&=+$%-]+: )?[0-9a-z_!~*().&=+$%-]+@)?' //ftp的user@
            //        + '(([0-9]{1,3}.){3}[0-9]{1,3}' // IP形式的URL- 199.194.52.184
            //        + '|' // 允许IP和DOMAIN（域名）
            //        + '([0-9a-z_!~*()-]+.)*' // 域名- www.
            //        + '([0-9a-z][0-9a-z-]{0,61})?[0-9a-z].' // 二级域名
            //        + '[a-z]{2,6})' // first level domain- .com or .museum
            //        + '(:[0-9]{1,4})?' // 端口- :80
            //        + '((/?)|' // a slash isn't required if there is no file name
            //        + '(/[0-9a-z_!~*().;?:@&=+$,%#-]+)+/?)$';
            //var re = new RegExp(strRegex);
            //if (re.test(url)) {
            //    return (true);
            //} else {
            //    return (false);
            //}

            ////var urlRegExp = /^((https|http|ftp|rtsp|mms)?:\/\/)+[A-Za-z0-9]+\.[A-Za-z0-9]+[\/=\?%\-&_~`@[\]\':+!]*([^<>\"\"])*$/;
            //by liwen 20200730
            ///var urlRegExp = /^(http|https|ftp|rtsp|mms)?(?:\:\/\/)?((?:[^\?#\/]+\.[^\?#\/]+))?(?::(\d+))?([^\?#]*)(?:\?([^#]*))(?:#(.*))$/;
            var urlRegExp = /^(http|ftp|https):\/\/[\w\-_]+([\w\-\.,@?^=%&:/~\+#]*[\w\-\@?^=%&/~\+#])?$/;
            if (urlRegExp.test(url)) {
                return true;
            } else {
                return false;
            }
            //return true;
        }

    </script>
</asp:Content>
