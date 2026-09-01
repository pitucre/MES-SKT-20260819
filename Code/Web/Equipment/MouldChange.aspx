<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="MouldChange.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.MouldChange" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">

  <div class="wrap_tb" style="min-height: 350px; min-width: 600px">
        <ul class="tb">
         
            <li class="current" title="换模信息">换模信息</li>
        </ul>
    <div class="tb_c">
        <table class="EditeContentTable" width="100%">
            <tr>
                <td class="Label3">
                  换模申请单号<em>*</em>
                </td>
                <td class="Field3">
                 <asp:Label runat="server" ID="Label2"></asp:Label>
                </td>
                <td class="Label3">
                    新产品名称
                </td>
                <td class="Field3">
                    <asp:TextBox ID="TextBox5" runat="server" CssClass="TextBox"></asp:TextBox>
                </td>
              
            </tr>
             <tr>
                <td class="Label3">
                  设备编码<em>*</em>
                </td>
                <td class="Field3">
                 <asp:Label runat="server" ID="Label3"></asp:Label>
                </td>
                <td class="Label3">
                    设备名称
                </td>
                <td class="Field3">
                    <asp:TextBox ID="TextBox6" runat="server" CssClass="TextBox"></asp:TextBox>
                </td>
              
            </tr>
                <tr>
                <td class="Label3">
                  需求使用时间<em>*</em>
                </td>
                <td class="Field3">
                  <asp:TextBox ID="TextBox7" runat="server" CssClass="DateTimeBox"></asp:TextBox>
                </td>
                <td class="Label3">
                    申请部门
                </td>
                <td class="Field3">
                    <asp:TextBox ID="TextBox8" runat="server" CssClass="TextBox"></asp:TextBox>
                </td>
              
            </tr>
            <tr>
                <td class="Label3">
                    <%=Resources.lang.Description%>
                </td>
                <td class="Field3" colspan="3">
                    <asp:TextBox ID="TextBox9" runat="server" CssClass="TextBox"></asp:TextBox>
                </td>
            </tr>
        </table>
        <table id="tblExpand1" cellspacing="0" cellpadding="4" style="border-width: 0px; width: 100%; border-collapse: collapse; margin-top: 5px;"
            class="EditeContentTable">
            <tr class="ListTableHeader" style="text-align: center">
                <th scope="col" style="width: 8%;">模具类型
                </th>
                <th scope="col" style="width: 8%;" >在机模具
                </th>
                <th scope="col" style="width: 35%;" >申请更换的模具
                </th>
            </tr>
            <tr id="trNewInfo1" class="ListTableOddRow">
                <td colspan="3" style="text-align: center;">
                    <%=Resources.Messages.HaveNothingData%>
                </td>
            </tr>
        </table>
       </div>
  
       </div>
    <input type="hidden" id="controlId" />
    <input type="hidden" id="hdInspectionTypeId" runat="server" />
    <input type="hidden" id="hdinspecType" value="-1"/>
    <script type="text/javascript" src="../Content/js/jquery-3.1.0.min.js"></script>
    <script type="text/javascript" charset="utf-8" src="../Content/plugin/jquery-easyui-1.4.2/layer/layer.js"></script>
    <style type="text/css">
        .selectRow td {
            background-color: #C4C4C4;
        }

        .pointer {
            cursor: pointer;
        }

    </style>
    <script language="javascript" type="text/javascript">

        var tab = document.getElementById("tblExpand");
        var selectRowClass = "selectRow";
        var index = 1;
        var inspecType = -1;
        $(function () {
         
        });

      
        function chooseInspectionItem() {
            var openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Quality/InspectionItemDialog.aspx?name=QC_InspectionItemDialog&controlId=controlId";
            dialog({ title: "<%=Resources.Pages.InspectionItem %>", src: openWinUrl, width: 255, height: 350 });
        }

        function SetValue(list) {
            closeDialog();
            var obj = $(".hdInspectionItemId");
            var alreadyItem = "";
            for (var i = 0; i < list.length; i++) {
                var flag = true;
                for (var j = 0; j < obj.length; j++) {
                    if ($(obj[j]).val() == list[i].InspectionItemId) {
                        alreadyItem += list[i].InspectionItemName + ",";
                        flag = false;
                        break;
                    }
                }
                if (flag && !list[i].IsParent) {
                    list[i].MaxValue = 0;
                    list[i].MinValue = 0;
                    list[i].SpecialRequest = "无";
                    list[i].InspectionAccording = "根据工艺";
                    list[i].InspectJuge = "";
                    addDetail(list[i], index);
                    index++;
                }
            }
          
            if (alreadyItem != "") {
                alert("你选择的检验项(" + alreadyItem + ")已经添加了.");
            }
            SetCoum();
        }

        function GetIndex() {
            var list = $(tab).find("tr");
            for (var i = 0; i < list.length; i++) {
                if ($(list[i]).attr("class").indexOf(selectRowClass) > -1) {
                    return i;
                }
            }
            return tab.rows.length;
        }

        function addDetail(entity, i) {
            var row, cell;
            rowNewIdx = GetIndex();
            row = tab.insertRow(rowNewIdx);
            row.className = "ListTableOddRow";

            $("#trNewInfo").remove();

            cell = row.insertCell(0);
            cell.align = "center";
            cell.className = "Field pointer";
            cell.innerHTML = i;

            cell = row.insertCell(1);
            cell.align = "center";
            cell.className = "Field pointer";
            cell.innerHTML = " <input type=\"hidden\" class=\"hdInspectionItemId\" value=\"" + entity.InspectionItemId + "\" />" + entity.InspectionItemName;


            $(cell).click(function () {
                var className = $(this.parentNode).attr("class");
                if (className.indexOf(selectRowClass) > -1) {
                    $(this.parentNode).removeClass(selectRowClass);
                }
                else {
                    $(tab).find("tr").removeClass(selectRowClass);
                    $(this.parentNode).addClass(selectRowClass);
                }
            })


            //cell = row.insertCell(2);
            //cell.align = "center";
            //cell.className = "Field pointer";
            //cell.innerHTML =entity.TestMethod;

            cell = row.insertCell(2);
            cell.align = "center";
            cell.className = "Field pointer";
            cell.innerHTML = '<input type="text" class="InspectionAccording" value="' + entity.InspectionAccording + '" MaxLength="50"  style="width:70px;height:25px;"/>'
           


            cell = row.insertCell(3);
            cell.align = "center";
            cell.className = "Field";
            cell.width = "80px";
            cell.id = entity.InspectionMethodId;
           


            if (typeof (entity.InspectionMethodId) == "undefined") {
                cell.innerHTML = "请维护检验项的录入方式";
                cell = row.insertCell(4);
                cell.align = "center";
                cell.className = "Field";
                cell.innerHTML = '';

            } else {
                cell.innerHTML = (entity.InspectionMethodId == 1 ? "固定结果" : "指定值");

                cell = row.insertCell(4);
                cell.align = "center";
                cell.className = "Field";
                cell.innerHTML = (entity.InspectionMethodId == 1 ? "OK/NG" : ' <input type="text" class="InspectionAccording" MaxLength="50" readonly="readonly" value="'
                    + (typeof (entity.InspectionMethodValue) == "undefined" ? "" : entity.InspectionMethodValue)
                    + '" style="width:40%;"/><input type="button" onclick="Set(this)" style="width:80px;margin-left:7px" value="设置"></input>');
            }
          

            
            cell = row.insertCell(5);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = ' <input type="text" MaxLength="50" value="' + (typeof (entity.UnitName) == "undefined" ? "" : entity.UnitName) + '" style="width:30%;"/>';
           


            cell = row.insertCell(6);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = ' <input type="text" MaxLength="50" value="' + (typeof (entity.CheckFashion) == "undefined" ? "" : entity.CheckFashion) + '" style="width:80%;"/>';

            cell = row.insertCell(7);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<span style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"deleteItem(this)\"><%= Resources.Buttons.COM_Delete %></span>";

            BindIsPercentage("IsPercentage" + entity.InspectionItemId);
        }


        var GetValue = function (data, Id) {
            closeDialog();
            data = data.replace('&gt;', ">");
            data = data.replace('&lt;', "<");


            $("#tblExpand tr").eq(Id).find("td:eq(4) input[type='text']").val(data);

        }
        var Set = function (result) {
            var Id = $(result).parent().parent().find("td:eq(0)").html();
            var openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Quality/InspectionTemplateEditValue.aspx?name=InspectionTemplateEditValue&Id=" + Id;
            dialog({ title: "<%=Resources.Pages.InspectionTemplateEditValue %>", src: openWinUrl, width: 500, height: 300 });

            //var data = "<table>";
            //for (var i = 0; i < length; i++) {

            //}
            //data += "<tr></tr>";
            //data += "<tr></tr>";
            //data += "<tr></tr>";
            //data += "</table>";
            //layer.open({
            //    type: 1,
            //    area: ['45%', '65%'],
            //    shadeClose: true, //点击遮罩关闭
            //    content: data
            //});
        }


        function BindIsPercentage(id) {
            $("#" + id).click(function () {
                id = $(this).attr("id");
                var value = parseInt($("#hd" + id).val());;
                if (value == 1) {
                    value = 0;
                }
                else {
                    value = 1
                }
                $("#hd" + id).val(value);
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

        var rowObj = null;
        var rowIndex = 0;

        var ReqId = '<%=Request.QueryString["ID"] %>';
        $("select").css("width", "140px");

        /*保存数据*/
        function Save() {
            var IIObject = $(".hdInspectionItemId");
          

            var InspectionItemIdList = "";
            for (var i = 0; i < IIObject.length; i++) {
                InspectionItemIdList += (InspectionItemIdList == "" ? $(IIObject[i]).val() : "," + $(IIObject[i]).val());
            }
            var entity = {};
   
            if (entity.InspectionTemplateId === '') {
                entity.InspectionTemplateId = ReqId;
            }
            if (ReqId == -1) {
                entity.CreateTime = new Date();
            }
            var list = [];
            for (var i = 0; i < $("#tblExpand tr:gt(0)").length; i++) {
                var data = $("#tblExpand tr:gt(0)")[i];

                var en = {};
                //  $(o[i]).val();
                en.InspectionTemplateId = entity.InspectionTemplateId;
                en.InspectionItemId = $($(".hdInspectionItemId")[i]).val();
                en.MaxValue = 0;
                en.MinValue = 0;
                en.SpecialRequest = "";
                en.InspectionAccording = $(data).find("td:eq(2) input").val();
                en.SamplingRate = 0;
                en.Remark = "";
                en.IsPercentage = -1;
                en.AQLRuleId = -1;
                en.InspectJuge = "";
               
                
                en.InspectionMethodId = $(data).find("td:eq(3)").attr("id");

                if (en.InspectionMethodId == 1) {
                    en.InspectionMethodValue = "OK/NG";
                } else {
                    en.InspectionMethodValue = $(data).find("td:eq(4) input:first").val();
                }
                //en.InspectionMethodValue = $($(".InspectionAccording")[i]).val();
                en.UnitName = $(data).find("td:eq(5) input").val();
                en.CheckFashion = $(data).find("td:eq(6) input").val();
                list.push(en);
            }
            if (list.length == 0) {
                alert("请添加检验项目");
                return;
            }
            entity.TempItems = JSON.stringify(list);

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxQuality.InspectionTemplateEdit(JSON.stringify(entity));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert('<%=Resources.Messages.SaveInSuccess %>');
         
            return ajax;
        }

        function selectInspectionTemplateValue() {
            dialog({
                title: "<%=Resources.Common.ChooseWindow %>",
                src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?" +
                    "PageId=74&CallBackFunc=getChooseValueInspectionTemplate&Multiple=true&rnd=" + Math.random(),
                width: 400,
                height: 250
            });
        }

   
    </script>
</asp:Content>
