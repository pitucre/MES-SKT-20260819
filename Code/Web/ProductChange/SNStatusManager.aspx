<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="SNStatusManager.aspx.cs" Inherits="SKT.LeanMES.Web.ProductChange.SNStatusManager" %>

<%@ MasterType VirtualPath="~/Masters/EditHeadMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <div class="divHeader">
        <div style="position: absolute; left: 10px;">
            <img src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/Images/icon/labels.png"
                alt="" style="vertical-align: middle;" />&nbsp;<asp:Label runat="server" ID="pageTitle"></asp:Label>
        </div>
    </div>
    <div style="height: 100px; width: 100%; line-height: 27px;">
        <table style="width: 69%; margin: 39px auto; text-align: center; letter-spacing: 3px">
            <tr>
                <td>
                    <div style="border: 0px solid #ccc;">
                        <span>工单:</span><asp:TextBox ID="txtOrder" runat="server" CssClass="TextBox" Enabled="false"></asp:TextBox><input
                            type="button" id="btnOrder" class="ButtonBox" value="..." title="<%=Resources.lang.ChooseOrder %>"
                            onclick="selectOrder();" />
                        <asp:HiddenField ID="hftxtOrderId" runat="server" Value="-1" />
                    </div>
                </td>
              <td>
                    <input type="radio" id="rdoScrap" name="chkSNoperater" checked="checked" />
                    <label>
                        <%=Resources.lang.Scrap %></label>
                </td>
               <%-- <td>
                    <input type="radio" id="rdoRestore" name="chkSNoperater" />
                    <label>
                        <%=Resources.lang.Restore %></label>
                </td>--%>
                <td>
                    <input type="radio" id="rdoDelete" name="chkSNoperater" checked="checked" />
                    <label>
                        <%=Resources.lang.Delete %></label>
                </td>
                <td align="right">
                    <%=Resources.lang.ScanOrInputSerialNumber%>:
                </td>
                <td align="left">
                    <input type="text" id="txtSN" title="<%=Resources.Messages.ScanOrInputSerialNumber%>"
                        style="width: 179px;" onkeypress="return SNkeypress(event)" />
                </td>
                <td>
                    <input type="button" id="btSNsub" value="<%=Resources.Buttons.Sub %>" onclick="Sub()"
                        class="ButtonBox" style="width: 45px; border-left-width: 1px; border-top-left-radius: 4px; border-bottom-left-radius: 4px; line-height: 20px;" />
                </td>
            </tr>
        </table>
    </div>
    <div class="divHeader">
        <div style="position: absolute; left: 10px;">
            <img src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/Images/icon/list.png" alt=""
                style="vertical-align: middle;" />&nbsp;<%=Resources.lang.OperaterResult%>
            <input type="checkbox" id="CheckAlls" />全选<br />
        </div>
    </div>
    <div style="width: 100%; height: 440px; line-height: 23px;">
        <div style="width: 20%; height: 440px; overflow-y: scroll; float: left; padding-left: 5px"
            id="divSNList">
            <div id="OrderSnList">
                <span>已选工单SN列表：</span><br />
            </div>
        </div>
        <div style="width: 79%; height: 440px; overflow-y: scroll; float: left; padding-left: 5px;"
            id="divSNoperaterResult">
        </div>
        <!--
        <div style="width: 35%; height: 290px; float: left;">
            <table style="width: 50%; margin: 50px auto;">
                <tr>
                    <td align="center">
                        <%=Resources.lang.SampleColor%>
                    </td>
                    <td>
                        <%=Resources.lang.Explain%>
                    </td>
                </tr>
                <%--<tr>
                    <td>
                        <hr style="height: 7px; width: 90px; border: 0px; background-color: Black" />
                    </td>
                    <td>
                        <%=Resources.lang.Restore %>
                    </td>
                </tr>
                <tr>
                    <td>
                        <hr style="height: 7px; width: 90px; border: 0px; background-color: Blue" />
                    </td>
                    <td>
                        <%=Resources.lang.Scrap %>
                    </td>
                </tr>--%>
                <tr>
                    <td>
                        <hr style="height: 7px; width: 90px; border: 0px; background-color: #F007F9" />
                    </td>
                    <td>
                        <%=Resources.lang.Delete %>
                    </td>
                </tr>
                <%--<tr>
                    <td>
                        <hr style="height: 7px; width: 90px; border: 0px; background-color: Red" />
                    </td>
                    <td>
                        <%=Resources.lang.Fail%>
                    </td>
                </tr>--%>
            </table>
        </div>
        -->
        <div style="clear: both">
        </div>
    </div>
    <script type="text/javascript">
        //回车后执行操作（执行事件后，返回false，是为了阻止其它的控件响应回车事件。）
        function SNkeypress(event) {
            var e = event || window.event;
            if (e && e.keyCode == 13) {
                Sub();
                return false;
            }
            return true
        }

        //更改SN状态
        function ChangeSn(sn) {
            //检验SN
            //            if (!isNumbOrLett(sn)) {
            //                alert("<%= Resources.Messages.SerialNumberError %>");
            //                $("#txtSN").val("");
            //                return false;
            //            }
            //还原
            //if (document.getElementById("rdoRestore").checked == true) {
            //    Restore(sn);
            //}
            //报废
            if (document.getElementById("rdoScrap").checked == true) {
                Scrap(sn);
            }
            //删除
            if (document.getElementById("rdoDelete").checked == true) {
                Delete(sn);
            }
        }
        //执行操作调度
        function Sub() {
            var way;
            //操作类型 0：删除 1：报废
            if (document.getElementById("rdoDelete").checked) {
                way = 0;
            } else if (document.getElementById("rdoScrap").checked) {
                way = 1;
            } else {
                alert("请选择操作类型");
                return;
            }

            var txtSN = document.getElementById("txtSN").value;
            if (txtSN != null && txtSN != 'undefined' && txtSN.length > 0) {
                var guid = newGuid();//获取批次号
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSN.AddBatchTmp(guid, txtSN, 1);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    AppendMsg(txtSN, way, 0);//错误消息                    
                    $("#txtSN").val("");
                    return;
                }
                if (way == 0) {
                    ajax = SKT.LeanMES.Web.AjaxServices.AjaxSN.SNDelete(guid);
                } else {
                    ajax = SKT.LeanMES.Web.AjaxServices.AjaxSN.SNScrap(guid);
                }
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    AppendMsg(txtSN, way, 0);//错误消息
                    $("#txtSN").val("");
                    return;
                } else {
                    AppendMsg(txtSN, way, 1);//成功消息
                }
            } else {
                //操作所选工单中选定SN
                var guid = newGuid();//获取批次号
                var items = $("#OrderSnList input:checked");
                var sns = "";//单次要操作的SN Id
                var snList = "";//所有勾选的SN
                var num = 800;//一次提交到后台的SN个数
                var idx = 0;
                var ajax;
                if (items.length <= 0) {
                    alert("请选择输入或选择条码");
                    return;
                }
                for (i = 0; i < items.length; i++) {
                    sns += idx == 0 ? items[i].value : "," + items[i].value;
                    snList += i == 0 ? items[i].getAttribute("sn") : "," + items[i].getAttribute("sn");
                    if (idx == num - 1 || i == items.length - 1) {
                        ajax = SKT.LeanMES.Web.AjaxServices.AjaxSN.AddBatchTmp(guid, sns, 0);
                        if (ajax.error != null) {
                            alert(ajax.error.Message);
                            AppendMsg(snList, way, 0);//错误消息
                            $("#txtSN").val("");
                            return;
                        }
                        //重置
                        sns = "";
                        idx = 0;
                    } else {
                        idx++;
                    }
                }
                if (way == 0) {
                    ajax = SKT.LeanMES.Web.AjaxServices.AjaxSN.SNDelete(guid);
                } else {
                    ajax = SKT.LeanMES.Web.AjaxServices.AjaxSN.SNScrap(guid);
                }
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    AppendMsg(snList, way, 0);//错误消息                    
                    $("#txtSN").val("");
                    return;
                } else {
                    AppendMsg(snList, way, 1);//成功消息
                    $("#OrderSnList input:checked").remove();
                }
            }
        }

        //拼接显示消息  way 0：删除 1：报废  type 0：失败 1：成功
        function AppendMsg(sns, way, type) {
            var arr = sns.split(',');
            var str = "";
            var color = "";
            var result = "";
            var wayName = way == 0 ? "<%=Resources.lang.Delete %>" : "<%=Resources.lang.Scrap %>";
            if (type == 0) {
                color = "red";
                result = wayName + " <%=Resources.lang.Fail %>";
            } else {
                switch (way) {
                    case 0: color = "#f007f9"; break;
                    case 1: color = "blue"; break;
                }
                result = wayName + " <%=Resources.lang.Succeed %>";
            }
            for (var j = 0; j < arr.length; j++) {
                str = "<p>" + arr[j] + "---------" + result + "</p>" + str;
            }
            WriteInDiv("<div style=\"color:" + color + "\">" + str + "</div>");
        }

        //简单获取GUID
        function newGuid() {
            var guid = "";
            for (var i = 1; i <= 32; i++) {
                var n = Math.floor(Math.random() * 16.0).toString(16);
                guid += n;
                if ((i == 8) || (i == 12) || (i == 16) || (i == 20))
                    guid += "-";
            }
            return guid;
        }

        //恢复 干掉这个该死的恢复功能 2018-03-22 
        function Restore(SN) {
            var str;
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSN.SNRetore(SN);
            if (ajax.error != null) {
                str = '<font color="red">' + SN + '---------<%=Resources.lang.Restore %> <%=Resources.lang.Fail %></font></br>';
                WriteInDiv(str);
                alert(ajax.error.Message);
                $("#txtSN").val("");
                return false;
            }

            str = '<font color="black">' + SN + '---------<%=Resources.lang.Restore %> <%=Resources.lang.Succeed %></font></br>';
            WriteInDiv(str);

        }

        //报废
        function Scrap(SN) {
            var str;
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSN.SNScrap(SN);
            if (ajax.error != null) {
                str = '<font color="red">' + SN + '---------<%=Resources.lang.Scrap %> <%=Resources.lang.Fail %></font></br>';
                WriteInDiv(str);
                alert(ajax.error.Message);
                $("#txtSN").val("");
                return false;
            }

            str = '<font color="blue">' + SN + '---------<%=Resources.lang.Scrap %> <%=Resources.lang.Succeed %></font></br>';
            WriteInDiv(str);

        }

        //删除
        function Delete(SN) {
            var str;
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSN.SNDelete(SN);
            if (ajax.error != null) {
                str = '<font color="red">' + SN + '---------<%=Resources.lang.Delete %> <%=Resources.lang.Fail %></font></br>';
                WriteInDiv(str);
                alert(ajax.error.Message);
                $("#txtSN").val("");
                return false;
            }

            str = '<font color="#F007F9">' + SN + '---------<%=Resources.lang.Delete %> <%=Resources.lang.Succeed %></font></br>';
            WriteInDiv(str);

        }

        //操作结果写入div
        function WriteInDiv(str) {
            //var divhtml = document.getElementById("divSNoperaterResult").innerHTML;
            //document.getElementById("divSNoperaterResult").innerHTML = str + divhtml;
            $("#divSNoperaterResult").prepend(str);
        }


        /* 
        用途：检查输入字符串是否只由汉字、字母、数字组成 并限制字符串长度不超过50
        输入：value：字符串 
        返回：如果通过验证返回true,否则返回false 
        */
        function isNumbOrLett(s) {
            var regu = "^[0-9a-zA-Z_-]{1,50}$";
            var re = new RegExp(regu);
            if (re.test(s)) {
                return true;
            } else {
                return false;
            }
        }
        function insertSNtoList(orderSn) {
            $("#CheckAlls").prop("checked", null);
            $("#txtSN").val("");
            $("#OrderSnList").empty();
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSN.GetOrderSnList(orderSn);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            } else {
                if (ajax.value.length > 0) {
                    //for (i = 0; i < ajax.value.length; i++) {
                    //    $("#OrderSnList").append('<input type="checkbox" value="' + ajax.value[i] + '" >&nbsp;&nbsp;&nbsp;' + ajax.value[i] + '</input><br/>');
                    //}
                    //$("#OrderSnList").html(html);
                    var html = "";
                    for (i = 0; i < ajax.value.length; i++) {
                        html += "<p><input type=\"checkbox\" value=\"" + ajax.value[i].UnitId + "\" sn=\"" + ajax.value[i].SNVALUE + "\">" + ajax.value[i].SNVALUE + "<p/>"
                    }
                    document.getElementById("OrderSnList").innerHTML = html;
                }
            }

        }
        /*选择Order*/
        function selectOrder() {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=37&CallBackFunc=getChooseselectOrder&Multiple=false&rnd=" + Math.random(), width: 680, height: 300 });
        }
        function getChooseselectOrder(list) {
            $("#<%=this.txtOrder.ClientID %>").val(list[0][1]);
            $("#<%=this.hftxtOrderId.ClientID %>").val(list[0][1] + "|" + list[0][2]);
            if (list[0][1].length === 0) return false; //BirongLiang 2016-12-22

            insertSNtoList(list[0][1]);

        }
        //全选操作
        $("#CheckAlls").click(function () {
            if ($("#CheckAlls:checked").length == 1) {
                $("#OrderSnList input").each(function (i, j) {
                    $(j).prop("checked", "checked");
                });
            } else {
                $("#OrderSnList input").each(function (i, j) {
                    $(j).prop("checked", null);
                });
            }
        });
    </script>
</asp:Content>