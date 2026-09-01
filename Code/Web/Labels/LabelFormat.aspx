<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    Inherits="SKT.LeanMES.Web.Labels.LabelFormat" CodeBehind="LabelFormat.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="label-format">
        <div id="tblFormat" style="width: 220px; position: absolute; left: 0px; top: 0px;
            border-left: 1px solid #d3d3d3; border-right: 1px solid #d3d3d3; border-bottom: 1px solid #d3d3d3;
            background: #ffffff;">
            <div style="width: 220px; height: 30px; line-height: 28px; border-top: 1px solid #d3d3d3;
                font-weight: bold; text-align: center; background: url(../Content/images/l_bg_hover.gif) repeat-x;">
                标签列表</div>
            <div style="overflow: auto; display: block; margin-top: -5px;" id="tblFormatContent">
                <table width="100%" cellpadding="3" cellspacing="0" border="0" >
                     <tr>
                        <td class="Label2">
                            标签名
                        </td>
                        <td class="Field2">
                            <asp:TextBox ID="txtLabelName" runat="server"  CssClass="TextBox" ClientIDMode="Static" style="width:100px" onkeydown="entersearch()" ></asp:TextBox><input 
                                type="button" id="btnSelectLabelName" class="ButtonBox" value="..." title="Select" style="width:30px;" 
                                onclick="selLabelName()"/>
                        </td>
                    </tr>
                </table>
                <table width="100%" cellpadding="3" cellspacing="0" border="0" class="ListTable"
                    id="docList">
                   
                </table>
            </div>
        </div>
        <div style="width: 5px; position: absolute; left: 220px; top: 0px;">
        </div>
        <div id="lfrmatlist" style="width: auto; position: absolute; left: 230px; top: 0px;
            border-left: 1px solid #d3d3d3; border-right: 1px solid #d3d3d3; border-bottom: 1px solid #d3d3d3;
            background: #ffffff;">
            <div id="lbc" style="height: 30px; line-height: 28px; width: 100%; border-top: 1px solid #d3d3d3;
                font-weight: bold; text-align: center; background: url(../Content/images/l_bg_hover.gif) repeat-x;
                position: relative;">
                <div style="position: absolute; left: 5px; top: 0px; line-height: 28px;">
                    <%= Resources.lang.LabelFormat %>
                </div>
                <div style="position: absolute; right: 10px; top: 3px; cursor: pointer; font-weight: bold;"
                    onclick="selectLabelField();" title="添加标签字段">
                    <div class="icon-16-add">
                    </div><span style=" line-height:20px;">添加标签字段</span>
                </div>
            </div>
            <div id="formatlist" style="overflow: auto; margin-top: -3px; padding: 1px;">
                <div class="infoTips">请在左侧选择一个标签来为其设置格式。</div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        var RequireOnlyOneRecord = "<%=Resources.Messages.RequireOnlyOneRecord %>";
        var RequireOperateRecord = "<%=Resources.Messages.RequireOperateRecord %>";
        var ConfirmDelete = "<%=Resources.Messages.ConfirmDelete %>";
        var isMultiple = false;
        var currentRowIndex = -1;

        getLabels();

        $(function () {
            $("body").css("background", "#faf9f9");
            setHeight();
            $(window).resize(function () {
                setHeight();
            });
        });

        function setHeight() {
            $("#tblFormat").height($(window).height() - 45);
            $("#lbc").width($(window).width() - 235);
            $("#lfrmatlist").height($(window).height() - 45);
            $("#tblFormatContent").height($(window).height() - 70);
            $("#formatlist").height($(window).height() - 73);
            setFormatlabelWidth();
        }

        function getLabels() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxLabels.GetLabels();
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            var list = ajax.value;
            var h = "<tr style=\"display:none;\"><td colspan=\"2\"></td></tr>";
            var rowstyle = "ListTableOddRow";
            for (var i = 0; i < list.length; i++) {
                if (i % 2 == 0) {
                    rowstyle = "ListTableEvenRow";
                }
                else {
                    rowstyle = "ListTableOddRow";
                }
                h += "<tr class=\"" + rowstyle + "\" onmouseover=\"{try{mi(this);}catch (ex){}}\" onmouseout=\"{try{mo(this);}catch (ex){}}\">";
                h += "<td width=\"30px\" style=\"border-left:0px;\" align=\"center\">";
                h += "<input type=\"checkbox\" name=\"chkSelect\" onclick=\"checkedLabel(this)\" value=\"" + list[i].LabelDocumentId + "\"/> ";
                h += "</td><td onclick=\"checkedLabel1(this)\">";
                h += list[i].DocumentName;
                h += "</td></tr>";
            }
            $("#docList").html(h);
        }
        function selectLabelField() {
            var chkList = $("#docList input[name=chkSelect]:checked");
            if (chkList.length == 0) {
                alert("<%=Resources.Messages.SelectItemInTheLeft %>");
                return false;
            }
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=16&Multiple=true&rnd=" + Math.random(), width: 600, height: 400 });
        }

        function getChooseValue(list) {
            for (var i = 0; i < list.length; i++) {

                var s = setFormatString(list[i][0], list[i][1]);
                var chkList = $("#docList input[name=chkSelect]:checked");
                var f = false;

                if (list[i][0] * 1 === -1) return false;  //BirongLiang 2016-12-22 点击清除时返回

                $("#formatlist").children().each(function () {
                    if ($(this).children().children().eq(0).children().val() == list[i][0])
                        f = true;
                });
                if (f) {
                    alert("该标签字段已在标签格式中了");
                    return false;
                }

                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxLabels.AddLabelFormat(chkList.val(), list[i][0], list[i][1], '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>');
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                $("#formatlist").append(s);
                $(".infoTips").remove();
                setFormatlabelWidth();
            }
        }

        function checkedLabel(obj) {
            chkClk(obj);
            setLabelField(obj);
        }

        function setFormatString(l, n) {
            var s = "";
            s += "<div class=\"formatlabel\" onmouseover=\"mouseover(this);\" onmouseout=\"mouseout(this);\">";
            s += "<div style='position:absolute; left:5px; top:5px; width:280px;'><span><input type=\"hidden\" name=\"labelField\" value=\"" + l + "\"></span>";
            s += "<span>" + n + "</span></div>";
            s += "<div class=\"removelabelformat\"><span onclick=\"removeLabelFormat(this," + l + ")\"><img src=\"../Content/images/icon/delete.png\" width=\"16\" height=\"16\" title=\"<%=Resources.Buttons.Remove %>\"></span></div>";
            s += "</div>";
            return s;
        }

        function mouseover(obj) {
            $(obj).addClass("formatlabel-hover");
            $(obj).children().eq(1).show();
            setFormatlabelWidth();
        }

        function mouseout(obj) {
            $(obj).removeClass("formatlabel-hover");
            $(obj).children().eq(1).hide();
        }


        function setFormatlabelWidth() {
            $(".formatlabel").width($(window).width() - 255);
        }

        function getFormatInfo(id) {            
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxLabels.GetLabelFormatInfo(id);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var list = ajax.value;
            var s = "";
            for (var i = 0; i < list.Rows.length; i++) {
                s += setFormatString(list.Rows[i]["FieldDfID"], list.Rows[i]["FieldDesc"]);
            }
            if (s == "") {
                s = "<div class='infoTips'><%=Resources.Messages.NoLabelFormat %></div>";
            }

            $("#formatlist").html(s);
            setFormatlabelWidth();
        }

        function removeLabelFormat(obj, l) {
            if (confirm("<%=Resources.Messages.ConfirmToRemoveLabelFormat %>")) {
                var chkList = $("#docList input[name=chkSelect]:checked");
                var userName = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>';
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxLabels.DeleteLabelFormat(l, chkList.val(), userName);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                if (ajax.value == "") {
                    $(obj).parent().parent().remove();
                    if ($("#formatlist").html() == "") {
                        $("#formatlist").html("<div class=\"infoTips\"><%=Resources.Messages.NoLabelFormat %></div>");
                    }
                }
                else {
                    alert(ajax.value);
                }
            }
        }

        function checkedLabel1(obj) {
            var $this = $(obj).parent().children("td:eq(0)").children("input[type=checkbox]")[0];
            clk($this.parentElement.parentElement)
            setLabelField($this);
        }

        function setLabelField(obj) {
            if ($(obj).attr("checked")) {
                getFormatInfo($(obj).val());
            }
            else {
                $("#formatlist").html("<div class=\"infoTips\">请在左侧选择一个标签来为其设置格式。</div>");
            }
        }
        function selLabelName() {          
            var dd =$.trim($("#txtLabelName").val());
            if (dd != null && dd != "") {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxLabels.GetName(dd);              
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }

                var list = ajax.value;                           
                var h = "<tr style=\"display:none;\"><td colspan=\"2\"></td></tr>";
                var rowstyle = "ListTableOddRow";
                for (var i = 0; i < list.length; i++) {
                     if (i % 2 == 0) {
                         rowstyle = "ListTableEvenRow";
                     }
                     else {
                          rowstyle = "ListTableOddRow";
                    }
                    h += "<tr class=\"" + rowstyle + "\" onmouseover=\"{try{mi(this);}catch (ex){}}\" onmouseout=\"{try{mo(this);}catch (ex){}}\">";
                    h += "<td width=\"30px\" style=\"border-left:0px;\" align=\"center\">";
                    h += "<input type=\"checkbox\" name=\"chkSelect\" onclick=\"checkedLabel(this)\" value=\"" + list[i].LabelDocumentId + "\"/> ";
                    h += "</td><td onclick=\"checkedLabel1(this)\">";
                    h += list[i].DocumentName;
                    h += "</td></tr>";
                 }
                $("#docList").html(h);
                
                
            }
            else
            {
               
                getLabels();
                setLabelField();
            }
            setTimeout(function () {
                try {
                    document.getElementById('txtLabelName').focus();
                } catch (e) { }
            }, 200);
            
        }

        function entersearch() {
            var enter = window.enter || arguments.callee.caller.arguments[0];
            if (enter.keyCode==13)
            {
                selLabelName();
                
            }
        }




    </script>
    <script src="../Content/js/skt.utility.tablelist.js?v=20211209" type="text/javascript"></script>
</asp:Content>
