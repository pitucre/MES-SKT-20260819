<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/EditMaster.master"
    CodeBehind="LineEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Resource.LineEdit" %>

<%@ Import Namespace="Resources" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="wrap_tb" style="min-height: 350px; min-width: 600px">
        <ul class="tb">
            <li class="current" title="<%= Resources.lang.BaseInfo%>">
                <%= Resources.lang.BaseInfo%>
            </li>
            <li title="<%= Resources.lang.Tab_BindResource%>">
                <%= Resources.lang.Tab_BindResource%>
            </li>
            <li title="生产时段">生产时段 </li>
            <li title="AGV地标与线别关系">AGV地标与线别关系</li>
        </ul>
        <!--基础信息-->
        <div class="tb_c">
            <div class="infoTips">
                <%=Resources.Messages.WithAsteriskIsRequired %>
            </div>
            <table class="EditeContentTable" width="100%">
                <tr>
                    <td class="Label2">
                        <%=Resources.lang.Line%><em>*</em>
                    </td>
                    <td class="Field2">
                        <asp:TextBox ID="txtLineName" runat="server" CssClass="TextBox" ClientIDMode="Static"
                            IsRequired='1'></asp:TextBox>
                    </td>
                </tr>
                 <tr>
                 <td class="Label2">
                    线别编码<em>*</em>
                 </td>
                 <td class="Field2">
                     <asp:TextBox ID="txtLineCode" runat="server" CssClass="TextBox" ClientIDMode="Static"
                         IsRequired='1'></asp:TextBox>
                 </td>
             </tr>
                <tr>
                    <td class="Label2">
                        <%=Resources.lang.EquipmentLineType%>
                    </td>
                    <td class="Field2">
                        <asp:TextBox runat="server" ID="txtEquipmentLineType" ReadOnly="True" CssClass="TextBox"></asp:TextBox>
                        <input type="button" id="Button1" class="ButtonBox" value="..." onclick="EquipmentLineType()" />
                    </td>
                </tr>
                <tr>
                    <td class="Label2">
                        <%= Resources.lang.WorkShopName %>
                    </td>
                    <td class="Field2">
                        <asp:TextBox runat="server" ID="txtWorkShopName" ReadOnly="True" CssClass="TextBox"></asp:TextBox>
                        <input type="button" id="btnWorkShopName" class="ButtonBox" value="..." onclick="SelectWorkShopName()" />
                        <asp:HiddenField ID="hdnWorkShopName" runat="server" Value="-1" ClientIDMode="Static" />
                    </td>
                </tr>
                <tr>
                    <td class="Label2">
                        <%=Resources.lang.Description%>
                    </td>
                    <td class="Field2">
                        <asp:TextBox ID="txtDescription" runat="server" CssClass="TextArea" TextMode="MultiLine"
                            ClientIDMode="Static" Width="350px" Height="90px"></asp:TextBox>
                    </td>
                </tr>
            </table>
        </div>
        <!--绑定资源-->
        <div>
            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td align="center" valign="top">
                        <div style="width: 253px;">
                            <div class="divHeader" style="text-align: left">
                                <img src="../Content/images/icon/list.png" style="vertical-align: middle;">
                                <%=Resources.lang.AvailableResource%>
                            </div>
                            <div id="avilableLineList" style="display: block; margin-top: -7px; margin-left: -3px;">
                                <asp:ListBox ID="lbAvilableResource" runat="server" Height="300px" Width="253px"
                                    SelectionMode="Multiple" CssClass="TextArea" ClientIDMode="Static"></asp:ListBox>
                            </div>
                        </div>
                    </td>
                    <td align="center" valign="middle">
                        <div style="width: 90px; text-align: center">
                            <input type="button" class="rightButton" onclick="assignToListBox('lbAvilableResource', 'lbAssignResource');" />
                            <br />
                            <br />
                            <br />
                            <input type="button" class="leftButton" onclick="deleteFromListBox('lbAssignResource', 'lbAvilableResource');" />
                        </div>
                    </td>
                    <td align="center" valign="top">
                        <div style="width: 253px;">
                            <div class="divHeader" style="text-align: left">
                                <img src="../Content/images/icon/list.png" style="vertical-align: middle;">
                                <%=Resources.lang.RequiredResource%>
                            </div>
                            <div id="assignLineList" style="display: block; margin-top: -7px; margin-left: -3px;">
                                <asp:ListBox ID="lbAssignResource" runat="server" Height="300px" Width="253px" SelectionMode="Multiple"
                                    ClientIDMode="Static" CssClass="Padd7"></asp:ListBox>
                            </div>
                        </div>
                        <select>
                            <option selected="selected"></option>
                        </select>
                    </td>
                </tr>
            </table>
        </div>
        <!--生产时段-->
        <div>
            <div class="infoTips">
                <span>生产时长以小时为单位不能大于24小时</span>

            </div>
            <div>
                <table id="tblExpand" cellspacing="0" cellpadding="4" style="border-width: 0px; width: 100%; border-collapse: collapse; margin-top: 5px;"
                    class="EditeContentTable">
                    <tr class="ListTableHeader" style="text-align: center">
                        <th scope="col" style="width: 40%; text-align: center">
                            <%=Resources.lang.ProdDate%>
                        </th>
                        <th scope="col" style="width: 40%;">
                            <%=Resources.lang.ProdTime%>
                        </th>
                        <th scope="col" onclick="addDetail(null);" style="color: #0066CC; cursor: pointer;">
                            <img src="../Content/images/icon/Add.png" style="vertical-align: middle;" />
                            <%=Resources.lang.Add%>
                        </th>
                    </tr>
                </table>
            </div>
        </div>
        <!--AGV地标与线别关系-->
        <div>
            <div class="infoTips">
                <span>AGV地标不可重复</span>
            </div>
            <div>
                <table id="tblExpandAgv" cellspacing="0" cellpadding="4" style="border-width: 0px; width: 100%; border-collapse: collapse; margin-top: 5px;"
                    class="EditeContentTable">
                    <tr class="ListTableHeader" style="text-align: center">
                        <th scope="col">地标条码
                        </th>
                         <th scope="col">是否空位区
                        </th>
                        <th scope="col" onclick="addAgvDetail(null);" style="color: #0066CC; cursor: pointer;">
                            <img src="../Content/images/icon/Add.png" style="vertical-align: middle;" />
                            <%=Resources.lang.Add%>
                        </th>
                    </tr>
                </table>
            </div>
        </div>
    </div>
    <link href="../Content/plugin/tabs/tabs.css" rel="stylesheet" type="text/css" />
    <script src="../Content/plugin/tabs/jPlugin-tabs.js" type="text/javascript"></script>
    <script type="text/javascript">
        var lineId = '<%=Request.QueryString["ID"] %>';
        var tab = document.getElementById("tblExpand");
        var tabAgv = document.getElementById("tblExpandAgv");
        var rowObj = null;
        var rowIndex = 0;
        var flag = -1;

        //$("#txtLineName").on("keydown", function (e) {


        //    var str = $(this).val().replace("&", "").replace("$", "").replace("@", "").replace("#", "").replace("^", "").replace("*", "").replace("!", "");
        //    $(this).val(str);
        //});

        $("#txtLineName").bind("input propertychange", function (event) {
            var str = $(this).val().replace("&", "").replace("$", "").replace("@", "").replace("#", "").replace("^", "").replace("*", "").replace("!", "");
            $(this).val(str);
        });

        if (lineId == -1) {
            $(".EditeContentTable tr:eq(1)").css("display", "none").find("input:eq(0)").attr("isrequired", null);
        }
        function EquipmentLineType() {
            flag = 1;
            //Modify By Alen Liu 2017-07-06 PageId=203 由于和8.5.0冲突，8.5.1 PageId 从500开始 PageId=501
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=501&Multiple=false&rnd=" + Math.random(), width: 620, height: 350 });
        }

        function getChooseValue(list) {
            if (flag == 1) {
                $("#<%=txtEquipmentLineType.ClientID%>").val(list[0][1]);
            }
            else if (flag == 2) {
                $("#<%=txtWorkShopName.ClientID%>").val(list[0][1]);
                $("#<%=hdnWorkShopName.ClientID%>").val(list[0][0]);
            }
        }

        function SelectWorkShopName() {
            flag = 2;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=122&Multiple=false&rnd=" + Math.random(), width: 550, height: 300 });
        }
        /*绑定资源*/
        function assignToListBox(fromListBoxId, toListBoxId) {
            var selectedCert = $("#" + fromListBoxId + " option:selected").length;
            if (selectedCert <= 0) {
                alert("<%=Resources.Messages.ResourceIsRequired %>");
                return false;
            }
            $("#" + fromListBoxId + " option").each(function () {
                if ($(this).attr("selected")) {
                    $("#" + toListBoxId + "").append("<option value=\"" + $(this).val() + "\">" + $(this).text() + "</option>");
                    $(this).remove();
                }
            });
        }

        /*移除已绑定的资源*/
        function deleteFromListBox(fromListBoxId, toListBoxId) {
            var selectedCert = $("#" + fromListBoxId + " option:selected").length;
            if (selectedCert <= 0) {
                alert("<%=Resources.Messages.ResourceIsRequired %>");
                return false;
            }
            $("#" + fromListBoxId + " option").each(function () {
                if ($(this).attr("selected")) {
                    $("#" + toListBoxId + "").append("<option value=\"" + $(this).val() + "\">" + $(this).text() + "</option>");
                    $(this).remove();
                }
            });
        }

        /*保存*/
        function Save() {
            try {
                if (CheckLimit()) {
                    alert("<%=Resources.Messages.LineQtyLimit %>");
                    return false;
                }
                if (isNull($("#txtLineName").val())) {
                    alert("<%=Resources.Messages.WithAsteriskIsRequiredAlert %>");
                    return false;
                }

                var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";

                /*基本信息*/
                var entity = {};
                var action = '<%=Request.QueryString["Action"] %>';
                if (action == "Copy") {
                    entity.LineId = -1;
                }
                else {
                    entity.LineId = lineId;
                }
                var workshopId = $.trim($("#hdnWorkShopName").val());
                entity.LineName = $.trim($("#txtLineName").val());
                entity.LimitValue = 0
                entity.EcPatch = 0
                entity.LineDescription = $("#txtDescription").val();
                entity.CreateBy = userName;
                entity.ModifyBy = userName;
                entity.Remark = "";
                entity.WorkShopId = workshopId;
                entity.LineCode = $.trim($("#txtLineCode").val());
                /*
                    添加线别绑定线别设备类型功能 chenglong.zhu 2017/5/25 10:51
                    wenshun 2017/09/30 去掉线别设备类型必填的验证，不是所有的线别都需要线别设备类型
                */
                entity.LineMachineRelation = $("#<%=txtEquipmentLineType.ClientID%>").val();
                if (lineId != -1 && entity.LineMachineRelation != "") {
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxServiceResource.CheckLineMachineTypeRelation(entity.LineMachineRelation, lineId);
                    if (ajax.error != null) {
                        alert(ajax.error.Message);
                        return false;
                    }
                }
                /*绑定资源*/
                var resIdString = "";
                $("#lbAssignResource option").each(function () {
                    if ($(this).text() != "") {
                        resIdString += $(this).val() + ",";
                    }
                });
                /*Add By Alen 2016-06-20 增加线别的生产时段*/
                var dateTimeStr = GetArrValue($(".DateTimeBox")) + "|" + GetArrValue($(".endDate"));

                /*增加Agv码*/
                var agvStr = GetArrValue($(".AgvCode"));
              
                

                var agvAaary = agvStr.split(',');
                var filter = agvAaary.filter((item, index) => agvAaary.indexOf(item) !== index);
                if (filter.length > 0) {
                    alert("包含重复的AGV编码【" + filter[0] + "】");
                    return;
                }
                var isIdleStr = GetArrValue($(".IsIdle"));
                var AgvStrs= agvStr + '|' + isIdleStr

                /*Save Event*/
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxServiceResource.EditLine(entity, resIdString, dateTimeStr, AgvStrs);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                alert("<%=Resources.Messages.SaveInSuccess %>");
                window.parent.UpdateList(entity.LineName);
            }
            catch (e) {
                alert(e);
            }
        }

        /*
        *检测线别限制
        */
        function CheckLimit() {
            var result = false;
            if (lineId == "-1") {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxServiceResource.LineIsLimited();
                result = ajax.value;
            }
            return result;
        }


        function addDetail(entity) {
            if (entity == null) {
                entity = {};
                entity.ProdDate = "";
                entity.ProdTime = "";
            }

            var row, cell;
            rowNewIdx = tab.rows.length;
            row = tab.insertRow(rowNewIdx);
            row.className = "ListTableOddRow";

            cell = row.insertCell(0);
            cell.align = "center";
            cell.className = "Field";
            //cell.innerHTML = "<input type=\"text\" IsRequired='1'  style=\" width:120px;\" class=\"startDate\" value=\"" + entity.startTime + "\" onblur=\"ValTime(this)\" onkeyup=\"this.value=this.value.replace(/\D/g,'')\" onafterpaste=\"this.value=this.value.replace(/\D/g,'')\" />";
            cell.innerHTML = "<input type=\"text\" IsRequired='1' readonly=\"readonly\"  style=\" width:140px;\" class=\"DateTimeBox\" re value=\"" + entity.ProdDate + "\" options=\"{showHms:'false'}\"  />";



            cell = row.insertCell(1);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<input type=\"text\" IsRequired='1'  style=\" width:120px;\" class=\"endDate\" value=\""
                + entity.ProdTime + "\" onblur=\"ValTime(this)\" onkeyup=\"this.value=this.value.replace(/\D/g,'')\" onafterpaste=\"this.value=this.value.replace(/\D/g,'')\" />";

            cell = row.insertCell(2);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<span style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"deleteItem(this)\"><%= Resources.Buttons.COM_Delete %></span>";

            $(".DateTimeBox").datepicker({
                showOn: "button",
                buttonImageOnly: true,
                showHms: _isHms,
                minDate: 0,
                buttonText: "<%=Resources.Common.ChooseDate %>",
                onSelect: function () {
                    if (_isHms) {
                        var objme = $(this);
                        if (typeof (objme.attr("_isHms")) == "undefined") {
                            if (objme.val().length > 10) {
                                objme.css("width", "140px");
                            }
                        } else { objme.val(objme.val().substring(0, 10)); }
                    }
                }
            });

        }

        function deleteItem(obj) {
            if (typeof (obj) == "number") {
                tab.deleteRow(rowIndex);
            }
            else {
                tab.deleteRow(obj.parentElement.parentElement.rowIndex);
            }
        }

        function addAgvDetail(entity) {
            if (entity == null) {
                entity = {};
                entity.AgvCode = "";
            }

            var row, cell;
            rowNewIdx = tabAgv.rows.length;
            row = tabAgv.insertRow(rowNewIdx);
            row.className = "ListTableOddRow";
         
            cell = row.insertCell(0);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<input type=\"text\" IsRequired='1'  style=\" width:120px;\" class=\"AgvCode\" value=\"" + entity.AgvCode + "\" />";

            cell = row.insertCell(1);
            cell.align = "center";
            cell.className = "Field";

            if (entity.IsIdle == "是") {
                cell.innerHTML = "<select class=\"IsIdle\" ><option value='是' selected=\"selected\" >是</option><option value='否'>否</option></select>";

            } else {
                cell.innerHTML = "<select class=\"IsIdle\" ><option value='是'  >是</option><option value='否' selected=\"selected\">否</option></select>";

            }

            cell = row.insertCell(2);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<span style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"deleteAgv(this)\"><%= Resources.Buttons.COM_Delete %></span>";
        }

        function deleteAgv(obj) {
            if (typeof (obj) == "number") {
                tabAgv.deleteRow(rowIndex);
            }
            else {
                tabAgv.deleteRow(obj.parentElement.parentElement.rowIndex);
            }
        }

        //function ValTime(obj) {
        //    var timeValue = $(obj).val();
        //    if (timeValue.length <= 0) {
        //        return;
        //    }

        //    $(obj).val(intToTime($(obj).val()));
        //    timeValue = $(obj).val();
        //    var reg = /^(\d{1,2}):(\d{1,2})$/;
        //    var r = timeValue.match(reg);
        //    if (r == null) {
        //        alert("输入格式不正确，请按HH:mm的格式输入！");
        //        $(obj).val("");
        //        $(obj).focus();
        //        return;
        //    }
        //    var strs = new Array();
        //    strs = timeValue.split(":");
        //    if (parseInt(strs[0]) > 23 || parseInt(strs[1]) > 59) {
        //        alert("时间值不正确，小时不得大小23，分钟不得大于59！");
        //        $(obj).val("");
        //        $(obj).focus();
        //        return;
        //    }
        //    if ($(obj).attr("class") == "endDate") {
        //        checkProTime(obj);
        //    }
        //}

        function ValTime(obj) {
            var timeValue = $(obj).val();
            if (timeValue.length <= 0) {
                return;
            }
            var reg = /(^[1-9]\d*$)/;
            if (!reg.test(timeValue) || timeValue < 0 || timeValue > 24) {
                alert("输入不正确，请输入大于0小于25正整数！");
                $(obj).val("");
                $(obj).focus();
                return;
            }

        }
        ////验证时间段大小
        //function checkProTime(obj) {
        //    var startTime = $(obj).parent().parent().find("input").eq(0).val().replace(":", "");
        //    var endTime = $(obj).val().replace(":", "");

        //    if (parseInt(startTime) > parseInt(endTime)) {
        //        alert("开始时间不能大于结束时间！");
        //        $(obj).focus();
        //        return false;
        //    }
        //}

        //获取对象数组里的val值，返回'1,2,3,4,5'
        function GetArrValue(o) {
            var str = "";
            for (var i = 0; i < o.length; i++) {
                if (i == 0) {
                    str = $(o[i]).val();
                }
                else {
                    str += "," + $(o[i]).val();
                }
            }
            return str;
        }

        function innt() {
            if (parseInt(lineId) > 0) {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxServiceResource.GetLineProdList(lineId);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                } 
                if (ajax.value.Tables[0].Rows.length > 0) {
                    for (var i = 0; i < ajax.value.Tables[0].Rows.length; i++) {
                        addDetail(ajax.value.Tables[0].Rows[i]);
                    }
                }

                if (ajax.value.Tables[1].Rows.length > 0) {
                    for (var i = 0; i < ajax.value.Tables[1].Rows.length; i++) {
                        addAgvDetail(ajax.value.Tables[1].Rows[i]);
                    }
                }
            }
        }

        $(function () {
            $("#ContentPlaceHolder1_EditContent_EquipmentLineType").val('');
            innt();
        });

    </script>
</asp:Content>
