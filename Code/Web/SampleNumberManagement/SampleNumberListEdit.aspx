<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SampleNumberListEdit.aspx.cs" MasterPageFile="~/Masters/EditMaster.master"
    Inherits="SKT.LeanMES.Web.SampleNumberManagement.SampleNumberListEdit" %>


<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">产品编码<em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtItemCode" runat="server" CssClass="TextBox" Enabled="false" IsRequired='1' ClientIDMode="Static"></asp:TextBox><input
                    type="button" id="btnSelectItem" class="ButtonBox" value="..." title="选择产品"
                    onclick="selectItem();" />
                <asp:HiddenField ID="hdnItemId" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
            <td class="Label2">产品名称
            </td>
            <td class="Field2">
                <asp:Label runat="server" ID="lblItemName" ClientIDMode="Static"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">产品规格
            </td>
            <td class="Field2">
                <asp:Label runat="server" ID="lblItemSpec" ClientIDMode="Static"></asp:Label>
            </td>
            <td class="Label2"></td>
            <td class="Field2">
                <input type="button" value="导入" id="btnImport" style="width: 65px;" />
            </td>
        </tr>
    </table>
    <table cellspacing="0" cellpadding="4" style="border-width: 0px; width: 100%; border-collapse: collapse; margin-top: 5px;"
        class="EditeContentTable">
        <thead>
            <tr class="ListTableHeader">
                <th scope="col" style="width: 15%;">样品序号<em>*</em>
                </th>
                <th scope="col" style="width: 15%;">样品名称<em>*</em>
                </th>
                <th scope="col" style="width: 15%;">工序<em>*</em>
                </th>
                <th scope="col" style="width: 15%;">失效日期<em>*</em>
                </th>
                <th scope="col" style="width: 10%;">样机属性<em>*</em>
                </th>
                <th scope="col" style="width: 15%;">不良代码
                </th>
                <th scope="col" style="width: 10%;">备注
                </th>
                <th scope="col" id="thAddDetail" onclick="addDetail(null);" style="color: #0066CC; cursor: pointer; width: 5%;">+添加
                </th>
            </tr>
        </thead>
        <tbody id="tblExpand">
            <tr id="trNewInfo" class="ListTableOddRow">
                <td colspan="8" style="text-align: center;">
                    <%=Resources.Messages.HaveNothingData%>
                </td>
            </tr>
        </tbody>
    </table>
    <script type="text/javascript">
        var Id = '<%=Request.QueryString["ID"]%>';
        var itemCode = "<%=Request.QueryString["ItemCode"]%>";
        var chooseFlag = 0;
        var objectFlag = 1; //默认工单
        var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>"
        var tab = document.getElementById("tblExpand");
        var rowObj = null;
        var IsInti = false;
        _isHms = false;

        $(document).ready(function () {
            if (Id == -1) {
                addDetail(null);
            } else {
                //编辑
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSampleNumber.GetInfo({ ItemCode: itemCode });
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                var list = ajax.value;
                if (list == null || list.length <= 0) {
                    return;
                }
                Id = list[0].SampleNumberMainId;
                $("#txtItemCode").val(list[0].ItemCode);
                $("#lblItemName").html(list[0].ItemName);
                $("#lblItemSpec").text(list[0].ItemSpec);
                $("#<%=this.hdnItemId.ClientID%>").val(list[0].ItemId);
                addDetail(list);
            }
            $("#btnImport").click(function () {
                var ItemCode = $("#txtItemCode").val();
                if (ItemCode == "") {
                    alert("产品编码不能为空，请选择!");
                    return false;
                }
                var openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SampleNumberManagement/SampleNumberImport.aspx?name=SampleNumberImport";
                dialog({ title: "导入样品序号", src: openWinUrl, width: 450, height: 300 });
            });

            //删除不良代码
            $(".delete-nc-code").live("click", function () {
                $(this).parent(".nc-code").remove();
            });

        })
        /*选择产品*/
        function selectItem() {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=1&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }
        function getChooseValue(list) {
            $("#<%=this.hdnItemId.ClientID%>").val(list[0][0]);
            $("#<%=this.txtItemCode.ClientID%>").val(list[0][2]);
            $("#<%=this.lblItemName.ClientID%>").text($.trim(list[0][1]));
            $("#<%=this.lblItemSpec.ClientID%>").text($.trim(list[0][6]));
        }
        //获取空实体对象
        function getEmptyEntity() {
            var entity = {
                SampleNumber: "",
                SampleName: "",
                StationId: "",
                Station: "",
                ExpirationDate: "",
                PrototypeAttr: 1,
                NcCodes: "",
                Remark: "",
                SubId: -1,
            };
            return entity;
        }
        //添加样品明细
        function addDetail(list, flag) {
            if (list == null) {
                list = [];
                list.push(getEmptyEntity());
            }
            if (flag == 1) {
                $("#tblExpand").html("");
            }

            $("#trNewInfo").remove();
            var row, cell;
            for (var i = 0; i < list.length; i++) {
                var entity = list[i];
                var rowNewIdx = tab.rows.length;
                row = tab.insertRow(rowNewIdx);
                row.setAttribute('subId', entity.SubId);
                row.className = "ListTableOddRow item-row";

                cell = row.insertCell(0);
                cell.align = "center";
                cell.className = "Field";
                cell.innerHTML = "<input type=\"text\" IsRequired='1'  style=\"width:120px;\"  class=\"TextBox SampleNumber\" value=\"" + entity.SampleNumber + "\" />";

                cell = row.insertCell(1);
                cell.align = "center";
                cell.className = "Field";
                cell.innerHTML = "<input type=\"text\" IsRequired='1'  style=\"width:120px;\"  class=\"TextBox SampleName\" value=\"" + entity.SampleName + "\" />";

                cell = row.insertCell(2);
                cell.align = "center";
                cell.className = "Field";
                cell.innerHTML = "<input type=\"text\" name=\"txtStationName\"  IsRequired='1' class=\"TextBox station\" station-id=\"" + entity.StationId + "\" value=\"" + entity.Station + "\" disabled=\"disabled\" style=\" width:100px;\" >"
                    + "<input type=\"button\" id=\"btnSelectItems\" onclick=\"selectStation(this);\" class=\"ButtonBox\" value=\"...\"/>"

                cell = row.insertCell(3);
                cell.align = "center";
                cell.className = "Field";
                var isExpDis = entity.SubId == -1 ? "" : "disabled=\"disabled\"";
                cell.innerHTML = "<input type=\"text\" value='" + getDateString(entity.ExpirationDate) + "' style='width: 70%' class='DateTimeBox ExpirationDate' " + isExpDis + " readonly='readonly' IsRequired='1' />";

                cell = row.insertCell(4);
                cell.align = "center";
                cell.className = "Field";
                var htmlstring = "<select class=\"PrototypeAttr\">";
                if (entity.PrototypeAttr == "1")
                {
                    htmlstring += "<option value=\"1\" selected=\"selected\">" + mesLang("良品") + "</option><option value=\"0\">" + mesLang("不良品") + "</option></select>";
                }
                else {
                    htmlstring += "<option value=\"1\">" + mesLang("良品") + "</option><option value=\"0\" selected=\"selected\">" + mesLang("不良品") + "option></select>";
                }
                cell.innerHTML = htmlstring;

                var hl = "";
                if (entity.NcCodes) {
                    var arr = entity.NcCodes.split(",");
                    for (var j = 0; j < arr.length; j++) {
                        hl += getNcCodeHtml(arr[j]);;
                    }
                }
                cell = row.insertCell(5);
                cell.align = "center";
                cell.className = "Field";
                cell.innerHTML = "<input type=\"button\" onclick=\"selectNcCode(this);\" class=\"Button\" value=\"" + mesLang("选择") + "\" style=\"width:50px;\"/><div class=\"nc-codes\">" + hl + "</div>"

                cell = row.insertCell(6);
                cell.align = "center";
                cell.className = "Field";
                cell.innerHTML = "<input type=\"text\" style=\"width:60px;\"  class=\"TextBox Remark\" value=\"" + entity.Remark + "\" />";

                cell = row.insertCell(7);
                cell.align = "center";
                cell.className = "Field";
                cell.innerHTML = "<span style=\"CURSOR: pointer; COLOR: #0000ff;\"  onclick=\"deleteItem(this)\"><%= Resources.Buttons.COM_Delete %></span>";
            }


            //时间选择
            $(".DateTimeBox").datepicker({
                showOn: "button",
                buttonImageOnly: true,
                showHms: _isHms,
                buttonText: "<%=Resources.Common.ChooseDate %>",
                onSelect: function () {
                    if (_isHms) {
                        var objme = $(this);
                        if (typeof (objme.attr("_isHms")) == "undefined") {
                        } else { objme.val(objme.val().substring(0, 10)); }
                    }
                },
                gotoCurrent: true,
                changeMonth: true,
                changeYear: true
            });

            $("#tblExpand tr.item-row[subId!=-1]").each(function () {
                $(this).find("img.ui-datepicker-trigger").hide();
            });
            //if (flag == 1) {
            //    $("#dialogWin").hide();
            //    $("#shadowdiv").hide();
            //}
        }
        //序号重新排列
        function refreshRowNum() {
            $("#set-list tbody tr td.row").each(function (i) {
                $(this).text(i + 1);
            });
        }

        function deleteItem(obj) {
            var trObj = $(obj).parent().parent(); //获取TR对象     
            trObj.remove();
        }

        //选择不良代码
        function selectNcCode(obj) {
            var station = $.trim($(obj).closest("tr").find(".station").val());
            if (station == "") {
                alert("请先选择工序");
                return;
            }
            rowObj = $(obj);
            var searchCondition = " Status ='Enabled' AND Category = 'Failure' AND Station = '" + station + "' ";
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=805&PageCondition=" + escape(searchCondition) + "&CallBackFunc=getChooseValueNcCode&Multiple=true&rnd=" + Math.random(), width: 500, height: 300 });
        }

        //选择不良代码
        function getChooseValueNcCode(list) {
            if (list == null || list[0][0] == -1) {
                return;
            }
            var ncCodeObj = rowObj.siblings(".nc-codes");
            var hl = "";
            for (var i = 0; i < list.length; i++) {
                var ncCode = list[i][1];
                if (ncCodeObj.find(".nc-code[nc-code=\"" + ncCode + "\"]").length <= 0) {
                    hl += getNcCodeHtml(ncCode);
                }
            }
            ncCodeObj.append(hl);
        }

        function getNcCodeHtml(ncCode) {
            return "<div class=\"nc-code\" nc-code=\"" + ncCode + "\">" + ncCode + "  <a href=\"javascript:void(0);\" title=\"删除\" class=\"delete-nc-code\">X</a></div>";
        }

        //保存数据
        function Save() {
            var ItemId = parseInt($.trim($("#hdnItemId").val()));
            if (ItemId == -1) {
                alert("请选择产品!");
                return false;
            }
            var ItemCode = $.trim($("#txtItemCode").val());
            //var ItemName = $.trim($("#lblItemName").html());
            //var ItemSpec = $.trim($("#lblItemSpec").text());
            var SampleNumberDtl = [];
            var isOK = true;
            $("#tblExpand tr.item-row").each(function () {
                var SampleNumber = $.trim($(this).find(".SampleNumber").val()); //序列号
                var SampleName = $.trim($(this).find(".SampleName").val()); //样品名称
                var Station = $.trim($(this).find(".station").val()); //工序
                var PrototypeAttr = parseInt($.trim($(this).find(".PrototypeAttr").val())); //不良属性（0：不良品 1：良品）
                var ExpirationDate = $.trim($(this).find(".ExpirationDate").val()); //失效日期                
                var NcCodes = "";
                if (PrototypeAttr == 0) {
                    //遍历不良代码
                    var ncCodeObjs = $(this).find(".nc-codes .nc-code");
                    ncCodeObjs.each(function (idx) {
                        NcCodes += (idx == 0 ? "" : ",") + $(this).attr("nc-code");
                    });
                    if (NcCodes == "") {
                        alert("样机属性为不良品时，请选择不良代码");
                        isOK = false;
                        return false;
                    }
                }
                var Remark = $.trim($(this).find(".Remark").val());  //备注
                SampleNumberDtl.push({ "SampleNumber": SampleNumber, "SampleName": SampleName, "Station": Station, "ExpirationDate": ExpirationDate, "PrototypeAttr": PrototypeAttr, "NcCodes": NcCodes, "Remark": Remark, "SampleNumberMainId": -1 });
            });
            if (!isOK) {
                return false;
            }
            var entity = {};
            entity.Id = Id;
            //entity.ItemId = ItemId;
            entity.ItemCode = ItemCode;
            //entity.ItemName = ItemName;
            //entity.ItemSpec = ItemSpec;
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSampleNumber.SampleNumberEdit(entity, JSON.stringify(SampleNumberDtl), 1);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            else {
                alert('<%=Resources.Messages.SaveSuccess %>');
                parent.window.UpdateList(entity.ItemCode);
            }
        }
        function uploadFile(filePath) {
            if (filePath.length > 0) {
                $("#btnUpload").click();
            }
        }


        function selectStation(obj) {
            rowObj = $(obj);
            dialog({
                title: "<%=Resources.Common.ChooseWindow %>"
                , src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=8&CallBackFunc=getChooseValueStation&Multiple=false&rnd="
                    + Math.random(), width: 600, height: 300
            });
        }
        function getChooseValueStation(list) {
            var stationId = list[0][0];
            var station = list[0][1];
            rowObj.siblings(".station").attr("station-id", stationId);
            rowObj.siblings(".station").val(station);
            return true;
        }

        function getDateString(date) {
            if (!date) {
                return "";
            }
            var today = new Date(date);
            return today.Format("yyyy-MM-dd");
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
