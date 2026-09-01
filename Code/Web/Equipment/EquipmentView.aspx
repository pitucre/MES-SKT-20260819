<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EquipmentView.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.EquipmentView" MasterPageFile="~/Masters/ViewMaster.master" %>

<asp:Content ContentPlaceHolderID="viewcontent" runat="server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">
                <%= Resources.lang.EquipmentCode%>
            </td>
            <td class="Field3">
                <asp:Label ID="lblEquipmentCode" runat="server"></asp:Label>
            </td>
            <td class="Label3">
                <%= Resources.lang.EquipmentName%>
            </td>
            <td class="Field3">
                <asp:Label ID="lblEquipmentName" runat="server"></asp:Label>
            </td>
            <td rowspan="6" class="Field3" style="text-align: center;">
                <div id="layer-photos-demo" class="layer-photos-demo">
                    <asp:Image runat="server" ID="txtimg" alt="查看图片" Style="width: 139px; height: 135px;" />
                </div>
            </td>
        </tr>
        <tr>
            <td class="Label3">
                <%= Resources.lang.EquipmentType%>
            </td>
            <td class="Field3">
                <asp:Label ID="lblEquipmentTypeName" runat="server"></asp:Label>
            </td>
            <td class="Label3">
                <%= Resources.lang.EquipmentModels%>
            </td>
            <td class="Field3">
                <asp:Label ID="lblEquipmentModels" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label3">
                <%= Resources.lang.venCode %>
            </td>
            <td class="Field3">
                <asp:Label ID="lblVenCode" runat="server"></asp:Label>
            </td>
            <td class="Label3">
                <%= Resources.lang.Supplier %>
            </td>
            <td class="Field3">
                <asp:Label ID="lblSupplier" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label3">存放位置
            </td>
            <td class="Field3">
                <asp:Label ID="lblLocation" runat="server"></asp:Label>
            </td>
            <td class="Label3">
                <%= Resources.lang.EnterFactoryDate%>
            </td>
            <td class="Field3">
                <asp:Label ID="lblFactoryDate" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label3">
                <%= Resources.lang.EquipmentStatus%>
            </td>
            <td class="Field3" >
                <asp:Label ID="lblStatus" runat="server"></asp:Label>
            </td>
             <td class="Label3">
               资产编号
            </td>
            <td class="Field3">
                 <asp:Label ID="txtAssetNumber" runat="server"></asp:Label>
             
            </td>
        </tr>
        <tr>
           <td class="Label3">过保日期
            </td>
            <td class="Field3">
                    <asp:Label ID="txtOverGuaranteeTime" runat="server"></asp:Label>
             
            </td>
            <td class="Label3">
                保修期（天）
            </td>
            <td class="Field3">
                  <asp:Label ID="txtGuaranteeDay" runat="server"></asp:Label>
                
            </td>
        </tr>
    </table>

    <div class="clear5">
    </div>
    <div class="wrap_tb" id="wrap_tb">
        <ul class="tb">
            <li class="current" id="Div1">基础资料</li>
            <li>适用机种</li>
            <li>相关文件</li>
            <li>备件列表</li>
            <li>维修列表</li>
            <li>保养计划</li>
            <li>保养记录</li>
            <li>校验计划</li>
            <li>校验记录</li>
            <li>子设备</li>
            <li>扩展信息</li>
        </ul>
        <div class="tb_c tb_content">
            <div id="divDtl">
            </div>
            <br />
            <table class="EditeContentTable" width="100%">
                <tr>
                    <td class="Label3">
                        <%= Resources.lang.Line%> 
                    </td>
                    <td class="Field3">
                        <asp:Label runat="server" ID="lblLineName"></asp:Label>
                    </td>
                    <td class="Label3">
                        <%= Resources.lang.MachineSequenceInLine%> 
                    </td>
                    <td class="Field3">
                        <asp:Label runat="server" ID="txtSequenceNo"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="Label3">购置方式
                    </td>
                    <td class="Field3">
                        <asp:Label ID="ddPurchase" runat="server"></asp:Label>
                    </td>
                    <td class="Label3">计量单位
                    </td>
                    <td class="Field3">
                        <asp:Label ID="txtUnitname" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="Label3">保管部门
                    </td>
                    <td class="Field3">
                        <asp:Label ID="txtDep" runat="server"></asp:Label>
                    </td>
                    <td class="Label3">保管人
                    </td>
                    <td class="Field3">
                        <asp:Label ID="txtBy" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="Label3">使用次数
                    </td>
                    <td class="Field3" colspan="3">
                        <asp:Label ID="txtUseCount" runat="server"></asp:Label>
                    </td>
                    <%--<td class="Label3">查看图片
                    </td>
                    <td class="Field3">
                        <input type="button" value="查看图片" onclick="Look()"  />
                    </td>--%>
                </tr>

                <tr>
                    <td class="Label3">
                        <%= Resources.lang.Remark%>
                    </td>
                    <td class="Field3" colspan="3">
                        <asp:TextBox ID="txtRemark" CssClass="TextArea" TextMode="MultiLine" runat="server"
                            ClientIDMode="Static" Width="99%" Height="75" ReadOnly="true"></asp:TextBox>
                    </td>
                </tr>
            </table>
        </div>
        <div id="ItemCodeInfo" runat="server">
        </div>
        <div id="FileInfo" runat="server">
        </div>
        <div id="PartInfo" runat="server">
        </div>
        <div id="RepairInfo" runat="server">
        </div>

        <div id="MaintenanceplanInfo" runat="server">
        </div>
        <div id="MaintenanceInfo" runat="server">
        </div>
        <div id="TestPlanInfo" runat="server">
        </div>
        <div id="CheckRecordInfo" runat="server">
        </div>
        <div id="divEquipmentChild" runat="server">
            <table id="tblExpand" cellspacing="0" cellpadding="4" style="border-width: 0px; width: 100%; border-collapse: collapse; margin-top: 5px;"
                class="EditeContentTable">
                <tr class="ListTableHeader" style="text-align: center">
                    <th scope="col" style="width: 8%;">序号
                    </th>
                    <th scope="col" style="width: 15%;">设备编码
                    </th>

                    <th scope="coh" style="width: 15%;" id="trJcyj">设备名称
                    </th>
                    <th scope="col" style="width: 8%;" id="trLrfs">规格型号
                    </th>

                    <th scope="col" onclick="addChildEquiment();" style="color: #0066CC; cursor: pointer; width: 5%;"><span>添加子设备</span>
                    </th>
                </tr>
                <tr id="trNewInfo" class="ListTableOddRow">
                    <td colspan="8" style="text-align: center;">
                        <%=Resources.Messages.HaveNothingData%>
                    </td>
                </tr>
            </table>
        </div>
        <div>
          <table id="tblExtensionInfos" class="EditeContentTable" width="100%">
                <tr id="trNewInfo2">
                    <td colspan="4" style="text-align: center;">
                        <%=Resources.lang.NoExtendedInfos %>
                    </td>
                </tr>
            </table>
        </div>
    
    </div>
    <div id="div11" class="hide" style="display: ">
        <table class="ListTable" id="tbDemo" style="width: 95%;">
            <tr class="ListTableHeader">
                <th style="width: 5%;">序号
                </th>
                <th style="width: 20%;">
                    <%= Resources.lang.MaintenanceDemoName%>
                </th>
                <th style="width: 30%;">作业项编号
                </th>
                <th style="width: 30%;">作业项名称
                </th>
                <th style="width: 30%;">作业内容
                </th>
            </tr>
            <tbody id="tbody1">
            </tbody>
        </table>
    </div>
    <asp:HiddenField ID="lbFileReady" runat="server" Value="-1" ClientIDMode="Static" />
    <asp:HiddenField ID="HiddenField1" runat="server" Value="-1" ClientIDMode="Static" />
    <script type="text/javascript" src="../Content/js/jquery-3.1.0.min.js"></script>
    <script type="text/javascript" charset="utf-8" src="../Content/plugin/jquery-easyui-1.4.2/layer/layer.js"></script>
    <script type="text/javascript">
        var Id = <%= Request.QueryString["Id"] == null ? -1 : Convert.ToInt32(Request.QueryString["Id"].ToString())%>;

        $(function () {
            var _width = $("#<%=this.txtimg.ClientID%>").parent().width();
            var _height = $("#<%=this.txtimg.ClientID%>").parent().height();
           
            LoadChildEquimentList();

            layer.ready(function(){ //为了layer.ext.js加载完毕再执行
                layer.photos({
                    photos: '#layer-photos-demo'
                    ,shift: 5 //0-6的选择，指定弹出图片动画类型，默认随机
                });
            });

        });

               
        
        //编辑
        function Edit() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/EquipmentEdit.aspx?name=Equipment_EquipmentEdit&Id=" + Id;
            $(".dlg-title.text", parent.window.document).html("<%= Resources.Pages.Equipment_EquipmentEdit %>");
            window.location.href = openWinUrl
        }
        function Look() {
            var filename = $("#<%=this.lbFileReady.ClientID%>").val();
            if (filename == "") {
                alert("没有上传图片");
                return false;
            }
            var path = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/UploadFiles/EQPicture" + "/" + filename;
            var path1 = '<%=SKT.LeanMES.Web.WebHelper.EQPictureFileRoot %>' + filename;
            var img = "<img src='" + path + "' >";

            layer.open({
                title: "图片",
                type: 1,
                maxmin: true,
                area: ['90%', '90%'],
                //offset: ['10px', '10px'],
                shadeClose: true, //点击遮罩关闭
                content: img
            });
        }

        function Down(data) {
            var name = $(data).parent().parent().find("td:eq(1)").html();
            var path = '<%=SKT.LeanMES.Web.WebHelper.EQFileRoot %>' + name;
            window.open(path);
        }
    </script>
    <script type="text/javascript">
        /*通过计划id获取保养项目列表*/
        function GetDemoListByPlanId(planId){
            var demoIdString = "";
            var notSubDemoNameString = "";

            var myajax = SKT.LeanMES.Web.AjaxServices.AjaxMaintenancRelation.GetMyRelationList(planId);
            if (myajax.error != null) {
                alert(myajax.error.Message);
                return false;
            }
           
            //var html = "<table class='ListTable' id='tbDemo' style='width: 100%;'>";
            //html+="<tr class='ListTableHeader'>";
            // html+="<th style='width: 20%;'>保养项目</th>";
            // html+="<th style='width: 30%;'>作业项编号</th>";
            // html+="<th style='width: 30%;'>作业项名称</th>";
            // html+="<th style='width: 30%;'>作业内容</th></tr>";
       
  
            if (myajax != null) {
                var html = "";
                $("#tbody1").html("");
                var tbody = $("#tbody1");

                var demoID;
                var objTd;
                var count;
                if (myajax.value.Rows.length > 0) {


                    for (var i = 0; i < myajax.value.Rows.length; i++) {
                        html = "";
                        html += "<tr class='ListTableOddRow' name='tr" + myajax.value.Rows[i].DemoId + "'>";

                        demoID = myajax.value.Rows[i].DemoId;
                        objTd = $("#td_" + demoID);
                        if (parseInt(objTd.length) <= 0 || objTd == null) {
                            demoIdString = demoIdString + demoID.toString() + ",";
                            count = 0;
                            for (var j = 0; j < myajax.value.Rows.length; j++) {
                                if (myajax.value.Rows[j].DemoId == demoID) {
                                    count += 1;
                                }
                            }
                            html += count > 1 ? "<td id='td_" + demoID + "' rowspan='" + count + "'  >" : "<td id='td_" + demoID + "'>";
                            html += i+1;
                            html += "</td>";


                            html += count > 1 ? "<td id='td_" + demoID + "' rowspan='" + count + "'  >" : "<td id='td_" + demoID + "'>";
                            html += myajax.value.Rows[i].DemoName;
                            html += "</td>";
                        }

                        //作业编码
                        html += "<td style='text-align:center;'>";
                        html += myajax.value.Rows[i].DemoSubCode;
                        html += "</td>";

                        //作业名称
                        html += "<td style='text-align:center;'>";
                        html += myajax.value.Rows[i].DemoSubName;
                        html += "</td>";

               
                        //作业内容
                        html += "<td style='text-align:center;'>";
                        html += myajax.value.Rows[i].Remark;
                        html += "</td>";
                       
                      

                        html += '</tr>';
                        tbody.append(html);
                        count = 0;

                    }
                } else {
                    //作业内容
                    html += "<td style='text-align:center;' colspan='4'>未查询到保养项目数据";
                    html += "</td>";
                    html += '</tr>';
                    tbody.append(html);
                }


                //html+='</table>";';  


            } 
            layer.open({
                type: 1,
                title: '保养项目',
                offset: 'auto',
                id: 'layerDemo1' //防止重复弹出
                ,
                content: $("#div11").html(),
                btn: '关闭',
                maxWidth: 900
                ,maxHeight:900  
                ,btnAlign: 'c' //按钮居中
                ,shade: 0 //不显示遮罩
                ,yes: function(){
                    layer.closeAll();
                }
            });
        }

    </script>
    <script type="text/javascript">
        var selectRowClass = "selectRow";
       var tab = document.getElementById("tblExpand");

        function LoadChildEquimentList() {

            if (Id > 0) {
                var result = SKT.LeanMES.Web.Equipment.EquipmentView.GetChildEquimentList(Id+"");
                if (result.error != null) {
                    alert(result.error.Message);
                    return false;
                }
                if (result.value.length > 0 > 0) {
                    for (var i = 0; i < result.value.length; i++) {
                        var row, cell;
                        rowNewIdx = GetIndex();
                        row = tab.insertRow(rowNewIdx);
                        row.className = "ListTableOddRow";

                        $("#trNewInfo").remove();

                        cell = row.insertCell(0);
                        cell.align = "center";
                        cell.className = "Field pointer";
                        cell.innerHTML = i+1;

                        cell = row.insertCell(1);
                        cell.align = "center";
                        cell.className = "Field pointer";
                        cell.innerHTML = " <input type=\"hidden\" class=\"hdEquimentId\" value=\"" + result.value[i].EquipmentChildId + "\" />" + result.value[i].EquipmentCodeChild;


                        cell = row.insertCell(2);
                        cell.align = "center";
                        cell.className = "Field pointer";
                        cell.innerHTML = result.value[i].EquipmentNameChild;
           

                        cell = row.insertCell(3);
                        cell.align = "center";
                        cell.className = "Field pointer";
                       
                        cell.innerHTML = result.value[i].ChildEquimentModel;
           
                        cell = row.insertCell(4);
                        cell.align = "center";
                        cell.className = "Field";
                        cell.innerHTML = "<span style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"deleteItem(this, "+result.value[i].EquipmentChildId+")\"><%= Resources.Buttons.COM_Delete %></span>";
                    }
                }
           
            }
          }
        function addChildEquiment() {
            temp = 1;
            var condition = "EquipmentCode!='"+$("#<%=this.lblEquipmentCode.ClientID %>").text()+"'";
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=54&Multiple=false&PageCondition=" +
                condition +
                "&rnd=" + Math.random(), width: 620, height:450 });
        }


       function getChooseValue(list) {
           debugger;
            if (temp == 1) {
                closeDialog();
                var obj = $(".hdEquimentId");
                var flag = true;
                for (var j = 0; j < obj.length; j++) {
                 
                        if ($(obj[j]).val() == list[0][0]) {
                            flag = false;
                            break;
                        }
                }
               
                if (flag == false) {
                    alert("你选择的设备(" + list[0][1] + ")已经添加了.");
                } else {

                    var result = SKT.LeanMES.Web.Equipment.EquipmentView.EquimentParentChild(Id,list[0][0]);
                    if (result.error != null) {
                        alert(result.error.Message);
                        return false;
                    }
                    AddEntityEquiment(list,obj.length+1);
                }

             
            } 
       }
       

      function deleteItem(obj,childid) {
             if (confirm("确定删除子设备？")) {
                 debugger;
                  var result = SKT.LeanMES.Web.Equipment.EquipmentView.EquimentParentChildDelete(Id,childid);
                 if (result.error != null) {
                            alert(result.error.Message);
                            return false;
                 }
                if (typeof (obj) == "number") {
                    tab.deleteRow(rowIndex);
                }
                else {
                    tab.deleteRow(obj.parentElement.parentElement.rowIndex);
                }
                  var obj1 = $(".hdEquimentId");
                  for (var j = 1; j <= obj1.length; j++) {
                      $(tab).find("tr").eq(j).find("td").eq(0).text(j);
                  }
           }
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

       function AddEntityEquiment(entity,i) {
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
            cell.innerHTML = " <input type=\"hidden\" class=\"hdEquimentId\" value=\"" + entity[0][0] + "\" />" + entity[0][1];


            cell = row.insertCell(2);
            cell.align = "center";
            cell.className = "Field pointer";
            cell.innerHTML = entity[0][2];
           

            cell = row.insertCell(3);
            cell.align = "center";
            cell.className = "Field";
            cell.width = "80px";
            cell.innerHTML = entity[0][3];
           
            cell = row.insertCell(4);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<span style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"deleteItem(this,"+entity[0][0]+")\"><%= Resources.Buttons.COM_Delete %></span>";
       }
    </script>

     <script type="text/javascript">      
/*加载扩展字段信息*/
function loadExtsionInfos() {
    var itemId = '<%= Request.QueryString["ID"] %>';
    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxBaseExt.GetExtsionInfoListByItemId(itemId, "Basal_Equipment");
            if (ajax.error != null) {
                return false;
            }

            var list = ajax.value;
            if (list != null && list != undefined && list.length > 0) {
                /*显示扩展字段信息*/
                var r = "";
                var listLength = list.length;
                for (var i = 0; i < listLength; i++) {
                    if (i % 2 == 0) {
                        r += "<tr>";
                    }
                    r += "<td class='Label2'><label id='lblExtFieldDescription" + i + "' name='ExtFieldDescription'>" + list[i].ExtFieldDescription + "</label>";
                    r += "<input type='hidden' id='txtExtId" + i + "' class='ExtId' value='" + (list[i].ExtId == null ? -1 : list[i].ExtId) + "' /><input type='hidden' id='txtExtFieldsId" + i + "' class='ExtFieldsId' value='" + list[i].ExtFieldsId + "' /><input type='hidden' id='txtSequence" + i + "' class='Sequence' value='" + list[i].Sequence + "' />";
                    r += "</td><td class='Field2'>";
                    //字段类型为布尔
                    if (list[i].ExtFieldType == "bit" || list[i].ExtFieldType == "bool") {
                        if (list[i].ExtFieldValue == "true" || list[i].ExtFieldValue == "True") {
                            r += "<%=Resources.lang.Yes %><input type='radio' id='radExtFieldValue" + i + "' tag='radExtFields' name='radExtFields" + list[i].ExtFieldName + "' class='ExtFieldValue' checked='checked' value='true' />&nbsp;&nbsp;&nbsp;&nbsp;<%=Resources.lang.No %><input type='radio' id='radExtFieldValue" + i + "" + i + "' tag='radExtFields' name='radExtFields" + list[i].ExtFieldName + "' value='false";
                        } else if (list[i].ExtFieldValue == "false" || list[i].ExtFieldValue == "False") {
                            r += "<%=Resources.lang.Yes %><input type='radio' id='radExtFieldValue" + i + "' tag='radExtFields' name='radExtFields" + list[i].ExtFieldName + "' value='true' />&nbsp;&nbsp;&nbsp;&nbsp;<%=Resources.lang.No %><input type='radio' id='radExtFieldValue" + i + "" + i + "' tag='radExtFields' name='radExtFields" + list[i].ExtFieldName + "' class='ExtFieldValue' value='false' checked='checked";
                        } else {
                            r += "<%=Resources.lang.Yes %><input type='radio' id='radExtFieldValue" + i + "' tag='radExtFields' name='radExtFields" + list[i].ExtFieldName + "' class='ExtFieldValue' value='true' />&nbsp;&nbsp;&nbsp;&nbsp;<%=Resources.lang.No %><input type='radio' id='radExtFieldValue" + i + "" + i + "' tag='radExtFields' name='radExtFields" + list[i].ExtFieldName + "' value='false";
                        }
                } else if (list[i].ExtFieldType == "datetime") { //字段类型为时间
                    r += "<input type='text' id='txtExtFieldValue" + i + "' name='dateExtFields' class='ExtFieldValue' readonly value='";
                    if (list[i].ExtFieldValue != null && list[i].ExtFieldValue != undefined && list[i].ExtFieldValue != "") {
                        r += list[i].ExtFieldValue;
                    }
                } else if (list[i].ExtFieldType == "int") {
                    r += "<input type='text' id='txtExtFieldValue" + i + "' name='intExtFields' class='ExtFieldValue'  value='";
                    if (list[i].ExtFieldValue != null && list[i].ExtFieldValue != undefined && list[i].ExtFieldValue != "") {
                        r += list[i].ExtFieldValue;
                    }
                } else { //字段类型为字符
                    r += "<input type='text' id='txtExtFieldValue" + i + "' name='txtExtFields' class='ExtFieldValue' value='";
                    if (list[i].ExtFieldValue != null && list[i].ExtFieldValue != undefined && list[i].ExtFieldValue != "") {
                        r += list[i].ExtFieldValue;
                    }
                }

                r += "' /></td>";
                if (i % 2 == 0 && i == listLength - 1) {
                    r += "<td class='Label2'></td><td class='Field2'></td></tr>";
                } else if (i % 2 != 0) {
                    r += "</tr>";
                } else {
                    r += "";
                }
            }
            $("#trNewInfo2").remove();
            $("#tblExtensionInfos").append(r);
        } else {
            $("#tblExtensionInfos tr").remove();
            $("#tblExtensionInfos").append("<tr><td colspan='4' style='text-align:center;'><font color='red'><%=Resources.lang.NoExtendedInfos %>！</font></td>");
        }
}

        
    $(function () {
        loadExtsionInfos();
        $("input[name='dateExtFields']").datepicker({
            showHms: false
        });
        $("input[name='intExtFields']").change(function () {
            if (!this.value.match(/^(?:[\+\-]?\d+(?:\.\d+)?|\.\d*?)?$/)) {
                this.value = "";
                alert("只能输入数字");
                this.focus();
            }
        });
        changeRadioClass();
    });

    function changeRadioClass() {
        $('input[tag="radExtFields"]').click(function () {
            $(this).attr('class', 'ExtFieldValue');
            $(this).siblings().removeClass();
        });
    }

    </script>

</asp:Content>
