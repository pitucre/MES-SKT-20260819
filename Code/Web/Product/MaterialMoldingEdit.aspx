<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/EditMaster.master"
    CodeBehind="MaterialMoldingEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Product.MaterialMoldingEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <style type="text/css">
        .txtbox
        {
            height: 100%;
            width: 60px;
        }
    </style>
    <!--产品-->
    <table class="EditeContentTable" style="width: 100%;">
        <tr>
            <td class="Label2">
                <em>*</em><%= Resources.lang.ItemCode %>
            </td>
            <td class="Field2">
                <input type="text" id="txtItemCode" class="TextBox" isrequired='1' runat="server"
                    readonly="ReadOnly" />
                <input type="button" class="ButtonBox" value="..." onclick="openChoosePage(1,'Item');" />
                <input type="hidden" id="hidItemId" runat="server" value="0" />
            </td>
            <td class="Label2">
                <%= Resources.lang.ItemName %>
            </td>
            <td class="Field2" id="labItemName">&nbsp;</td>
        </tr>
        <tr>
            <td class="Label2">导入明细
            </td>
            <td class="Field2">
                <asp:FileUpload ID="fileUploads" runat="server" onchange="uploadFile(this.value)" />
                <asp:LinkButton ID="linkUploadFile" runat="server" OnClick="linkUploadFile_Click"></asp:LinkButton>
                <input type="hidden" runat="server" id="hidMoldingId" value="0" />
            </td>
            <td class="Field2" colspan="2">
                <em>*</em><span><a href="../ExcelTemplate/前加工物料明细模板.xlsx" style="text-decoration: underline;" id="downloads">点击这里下载导入明细的数据模板</a></span>
            </td>
        </tr>
    </table>
    <!--前加工明细-->
    <div style="position: relative; top: 0px;" class="toolBar">
        <div class="toolbar-btn">
            <span style="font-weight: bold;">前加工物料明细</span>
        </div>
        &nbsp;
        <div class="toolbar-btn" title="新增" onclick="AddMember('',1)">
            <div class="icon-16-add">
            </div>
            <div class="btn-text">
                添加明细
            </div>
        </div>
        <div class="btn-line">
        </div>
        <div class="toolbar-btn" title="编辑" onclick="EditMember()">
            <div class="icon-16-edit">
            </div>
            <div class="btn-text">
                编辑明细
            </div>
        </div>
        <div class="btn-line">
        </div>
        <div class="toolbar-btn" title="删除" onclick="DeleteMember()">
            <div class="icon-16-delete">
            </div>
            <div class="btn-text">
                删除明细
            </div>
        </div>
        <div class="btn-line">
        </div>
        <div class="clear5">
        </div>
    </div>
    <table class="ListTable" cellspacing="0" cellpadding="4" style="border-width: 0px; width: 100%; border-collapse: collapse;"
        id="tbMoldings">
        <thead>
            <tr class="ListTableHeader">
                <th scope="col" style="width: 40px; text-align: center;">
                    <input type="checkbox" id="cbAll" onclick="ckAll(this);" name="cbr" />
                </th>
                <th scope="col" style="width: 100px;">加工类型
                </th>
                <th scope="col" style="width: 150px;">物料编码
                </th>
                <%--<th scope="col">
                    物料规格
                </th>--%>
                <th scope="col" style="width: 100px;">用量
                </th>
                <th scope="col">位置
                </th>
                <th scope="col" style="width: 100px;">工位
                </th>
                <th scope="col">规格/尺寸
                </th>
                <th scope="col">是否烧录
                </th>
                <th scope="col" >加工后物料编码
                </th>
                <th scope="col">备注
                </th>
            </tr>
        </thead>
        <tbody>
        </tbody>
    </table>
    <!--JS代码-->
    <script type="text/javascript">
       var isCopy = "<%=IsCopy %>";
      
        $(document).ready(function () {
            Init();
        });

        function uploadFile(filePath) {
            if (filePath.length > 0) {
                var str = '';
                var postback = $('#<%= linkUploadFile.ClientID %>').attr('href');
                var funcStartIndex = postback.indexOf('\'');
                var funcEndIndex = postback.indexOf('\',');
                if (funcStartIndex != -1 && funcEndIndex != -1) {
                    var str = postback.substring(funcStartIndex + 1, funcEndIndex);
                    __doPostBack(str, '');
                } else {
                    return false;
                }
            }
        }

        function Save() {
            var members = GetMember();
            if(members == false){
                return false;
            
             }
       
            var entity =
            {
                MoldingId: moldingId,
                ItemId: $("#<%=hidItemId.ClientID %>").val(),
                Member: members
            };
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMolding.SaveMolding(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert('<%=Resources.Messages.SaveInSuccess%>');
            Refresh();
        }

        function Refresh() {
            parent.window.UpdateList($("#<%=txtItemCode.ClientID %>").val());
        }

        function Import() {
            $("#<%=fileUploads.ClientID %>").click();
        }

        function Export() {
            var text = "<table border='1'><tr><th>加工类型</th><th>物料编码</th><th>用量</th><th>位置</th><th x:str>工位</th><th>规格/尺寸</th><th>是否烧录</th><th>加工后物料编码</th><th>备注</th></tr>";
            $("#tbMoldings tbody tr input[type='hidden'][name='Operate'][value!='1']").each(function () {
                text += "<TR>";

                $(this).parent().parent().find("td").each(function () {
                    if ($(this).find("input[type='checkbox'][name='cbr']").length === 0) {
                        text += String.format("<TD style='vnd.ms-excel.numberformat:@'>{0}</TD>", $(this).find(".labFlag").html());
                    }
                });

                text += "</TR>"; ;
            });
         
           expToExcel(text + "</table>");
        }

        function Init() {
            moldingId = parseInt(String.getUrlParam("ID"));

            $("#<%=hidMoldingId.ClientID %>").val(moldingId);

            if (moldingId > 0) {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMolding.GetMolding(moldingId);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }

                if (isCopy != "") {
                    $("#<%=hidItemId.ClientID %>").val("");
                    $("#<%=txtItemCode.ClientID %>").val("");
                    $("#labItemName").html("");
                    moldingId = 0;
                } else {
                    $("#<%=hidItemId.ClientID %>").val(ajax.value.ItemId);
                    $("#<%=txtItemCode.ClientID %>").val(ajax.value.ItemCode);
                    $("#labItemName").html(ajax.value.ItemName);
                }

                $("#tbMoldings tbody").html("");
                $.each(ajax.value.Member, function () {
                    AddMember(this, 0);

                    $("#tbMoldings tbody tr:last").find("select[name='MachineType'] option[value='" + this.MachineType + "']").prop("selected", true);
                    $("#tbMoldings tbody tr:last").find("input[type='checkbox'][name='IsProgrammer']").prop("checked", this.IsProgrammer)
                });
            }
        }

        function EditMember() {
            var $cbs = $("input[type='checkbox'][name='cbr'][id!='cbAll']:checked");
            if ($cbs.length < 1) { alert("请先选择物料明细!"); return; }
            $.each($cbs, function (i, e) {
                var $tr, $opt;
                $tr = $(this).parent().parent();
                $opt = $tr.find("input[type='hidden'][name='Operate']");
                if (parseInt($opt.val()) != 0) { return true; }

                $tr.find(".labFlag").hide();
                $tr.find(".ctrFlag").show(); ;
                $opt.val(2);
            });

            //重置所有选中框
            $("input[type='checkbox'][name='cbr']").prop("checked", false);
        }

        function GetMember() {            
            var entities = new Array();
            var bresult = 0;
             $("#tbMoldings tbody tr input[type='hidden'][name='Operate']").each(function (t, i) {
            // getList(entities,bresult,this);
             var $row = $(this).parent().parent();
                if($row.find("input[type='text'][name='Usage']").length == 1){
                    if ($row.find("input[type='text'][name='Usage']").val()=="") {
                        $row.find("input[type='text'][name='Usage']").val("").focus();
                        alert("用量列不能为空");
                        bresult = 1;
                        return;
                    }
                    var SourceItemId = $row.find("input[type='hidden'][name='SourceItemId']").val();
                    if (SourceItemId == 0 || SourceItemId == -1 || SourceItemId == "") {
                        alert("请选择物料编码");
                        bresult = 1;
                        return false;
                    }
                    var StationId = $row.find("input[type='hidden'][name='StationId']").val();
                    if (StationId == 0 || StationId == -1 || StationId == "") {
                        alert("请选择工位");
                        bresult = 1;
                        return false;
                    }
                    var TargetItemId = $row.find("input[type='hidden'][name='TargetItemId']").val();
                    if (TargetItemId == 0 || TargetItemId == -1 || TargetItemId == "") {
                        alert("请选择加工后物料编码");
                        bresult = 1;
                        return false;
                    }

                    var t =
                    {
                        Operate: isCopy!=""?1:$row.find("input[type='hidden'][name='Operate']").val(),
                        MoldingMemberId: $row.find("input[type='hidden'][name='MoldingMemberId']").val(),
                        MachineType: $row.find("select[name='MachineType']").val(),
                        StationId: $row.find("input[type='hidden'][name='StationId']").val(),
                        SourceItemId: $row.find("input[type='hidden'][name='SourceItemId']").val(),
                        TargetItemId: $row.find("input[type='hidden'][name='TargetItemId']").val(),
                        Usage: parseFloat($row.find("input[type='text'][name='Usage']").val()),
                        Location: $row.find("input[type='text'][name='Location']").val(),
                        Specification: $row.find("input[type='text'][name='Specification']").val(),
                        IsProgrammer: $row.find("input[type='checkbox'][name='IsProgrammer']").prop("checked"),
                        Remark: $row.find("input[type='text'][name='Remark']").val()
                    };
                    entities.push(t);
                 }
            });
            if (bresult == 1 ) {                
                return false;
            }
            else {
                return entities;
            }           
       }

        function DeleteMember() {
            var $cbs = $("input[type='checkbox'][name='cbr'][id!='cbAll']:checked");
            if ($cbs.length < 1) { alert("请先选择要删除的行!"); return; }

            if ($("input[type='checkbox'][name='cbr'][id!='cbAll']:checked").parent().
            find("input[type='hidden'][name='MoldingMemberId'][value!='0']").length > 0) {
                if (!confirm("确认删除这些明细？")) {
                    return false;
                }
            }

            var ajax, strDID = "";

            /*取值*/
            $.each($cbs, function () {
                $(this).parent().parent().addClass("deleted");
                var DID = parseInt($(this).parent().find("input[type='hidden'][name='MoldingMemberId']").val());
                if (DID > 0) {
                    strDID += (DID + ",");
                }
            });

            /*删除*/
            ajax = SKT.LeanMES.Web.AjaxServices.AjaxMolding.DeleteMoldingMember(strDID);
            if (ajax.error != null) {
                $(".deleted").removeClass("deleted");
                alert(ajax.error.Message);
                return false;
            }

            //移除
            $(".deleted").remove();
        }

        //添加手插物料(@data:store,@opt:操作方式,0:默认,1:新增,2:修改)
        function AddMember(data, opt) {
            var p =
            {
                Operate: opt,
                MoldingMemberId: 0,
                MoldingId: 0,
                MachineType: 0,
                StationId: 0,
                StationName: '',
                SourceItemId: 0,
                SourceItemCode: '',
                SourceItemName: '',
                TargetItemId: 0,
                TargetItemCode: '',
                Usage: '',
                Location: '',
                Specification: '',
                IsProgrammer: 0,
                Remark: ''
            };

            //判断是否为json格式并赋值
            if (typeof (data) == 'object' && Object.prototype.toString.call(data).toLowerCase() == '[object object]' && !data.length) {
                p.MoldingMemberId = data.MoldingMemberId;
                p.MoldingId = data.MoldingId;
                p.MachineType = data.MachineType;
                p.StationId = data.StationId;
                p.StationName = data.StationName;
                p.SourceItemId = data.SourceItemId;
                p.SourceItemCode = data.SourceItemCode;
                p.SourceItemName = data.SourceItemName;
                p.TargetItemId = data.TargetItemId;
                p.TargetItemCode = data.TargetItemCode;
                p.Usage = data.Usage;
                p.Location = data.Location;
                p.Specification = data.Specification;
                p.IsProgrammer = data.IsProgrammer;
                p.Remark = data.Remark;
            }

            /*组装类型*/
            var strMachineType = "";
            if (p.MachineType === 1) { strMachineType = "不变料号"; }
            else if (p.MachineType === 2) { strMachineType = "变料号"; }
            else if (p.MachineType === 3) { strMachineType = "组合料"; }

            /*是否烧录*/
            var strIsProgrammer = "N";
            if (p.IsProgrammer === true) { strIsProgrammer = "Y"; }

            /*组装明细*/
            var tbodyText = "<tr class='ListTableOddRow'>" +
                             "<td style='text-align: center; margin: 0px; padding: 0px;'>" +
                                    "<input type='checkbox' name='cbr' />" +
                                    "<input type='hidden' name='Operate' value='" + p.Operate + "'/>" +
                                    "<input type='hidden' name='MoldingId' value='" + p.MoldingId + "'/>" +
                                    "<input type='hidden' name='MoldingMemberId' value='" + p.MoldingMemberId + "' />" +
                             "</td>" +
                             "<td style='text-align: center; margin: 0px; padding: 0px;'>" +
                                    "<select style='width:100px;' name='MachineType' class='ctrFlag' onchange='setUpSourceItemCode(this);'><option value='1' selected='selected'>不变料号</option><option value='2'>变料号</option></select>" +
                                    "<label style='display:none;' class='labFlag'>" + strMachineType + "</label>" +
                             "</td>" +
                             "<td style='text-align: center; margin: 0px; padding: 0px;'>" +
                                    "<input type='text' name='SourceItemCode' style='width:85px'  class='txtbox ctrFlag' IsRequired='1' ReadOnly='true' value='" + p.SourceItemCode + "'/>" +
                                    "<input type='button' class='ButtonBox ctrFlag' value='...' onclick='openChoosePage(1,\"SourceItem\",this);'/>" +
                                    "<input type='hidden' name='SourceItemId' value='" + p.SourceItemId + "'/>" +
                                    "<label style='display:none;' class='labFlag'>" + p.SourceItemCode + "</label>" +
                             "</td>" +
            //"<td style='text-align: center; margin: 0px; padding: 0px;'>" +
            //       "<span name='SourceItemName'>" + p.SourceItemName + "</span>" +
            //"</td>" +
                             "<td style='text-align: center; margin: 0px; padding: 0px;'>" +
                                    "<input type='text' name='Usage' IsNumber='1' class='txtbox ctrFlag' value='" + p.Usage + "'/>" +
                                    "<label style='display:none;' class='labFlag'>" + p.Usage + "</label>" +
                             "</td>" +
                             "<td style='text-align: center; margin: 0px; padding: 0px;'>" +
                                    "<input type='text' name='Location' class='txtbox ctrFlag' value='" + p.Location + "'/>" +
                                    "<label style='display:none;' class='labFlag'>" + p.Location + "</label>" +
                             "</td>" +
                             "<td style='text-align: center; margin: 0px; padding: 0px;'>" +
                                    "<input type='text' name='StationName' class='txtbox ctrFlag' ReadOnly='true' value='" + p.StationName + "'/>" +
                                    "<input type='button' class='ButtonBox ctrFlag' value='...' onclick='openChoosePage(8,\"Station\",this);'/>" +
                                    "<input type='hidden' name='StationId' value='" + p.StationId + "'/>" +
                                    "<label style='display:none;' class='labFlag'>" + p.StationName + "</label>" +
                            "</td>" +
                            "<td style='text-align: center; margin: 0px; padding: 0px;'>" +
                                    "<input type='text' name='Specification' class='txtbox ctrFlag' value='" + p.Specification + "'/>" +
                                    "<label style='display:none;' class='labFlag'>" + p.Specification + "</label>" +
                            "</td>" +
                            "<td style='text-align: center; margin: 0px; padding: 0px;'>" +
                                    "<input type='checkbox' name='IsProgrammer' class='ctrFlag'/>" +
                                    "<label style='display:none;' class='labFlag'>" + strIsProgrammer + "</label>" +
                           "</td>" +
                           "<td style='text-align: center; margin: 0px; padding: 0px;'>" +
                                    "<input type='text' name='TargetItemCode' style='width:85px'  class='txtbox ctrFlag' ReadOnly='true' value='" + p.TargetItemCode + "'/>" +
                                    "<input type='button' name='btnTargetItemId' class='ButtonBox ctrFlag' value='...' onclick='openChoosePage(505,\"TargetItem\",this);'  " + (strMachineType == "变料号" ? "" : "disabled='disabled'") + "/>" +
                                    "<input type='hidden' name='TargetItemId' value='" + p.TargetItemId + "'/>" +
                                    "<label style='display:none;' class='labFlag'>" + p.TargetItemCode + "</label>" +
                            "</td>" +
                            "<td style='text-align: center; margin: 0px; padding: 0px;'>" +
                                    "<input type='text' name='Remark' class='txtbox ctrFlag' value='" + p.Remark + "'/>" +
                                    "<label style='display:none;' class='labFlag'>" + p.Remark + "</label>" +
                           "</td>" +
                       "</tr>";
            $("#tbMoldings tbody").append(tbodyText);

            if (opt === 0) {
                $("#tbMoldings tbody tr:last").find(".labFlag,.ctrFlag").toggle();
            }
        }
    </script>
    <script type="text/javascript">
        function ckAll(obj) {
            $("input[type='checkbox'][name='cbr'][id!='cbAll']").prop("checked", $(obj).prop("checked"));
        }
    </script>
    <script type="text/javascript">
        function openChoosePage() {
            var condition = "";            
            flag = arguments[0];
            if (flag == "505") {
                if ($("#<%=txtItemCode.ClientID %>").val() != "") {
                    condition = "BomItemCode='" + $("#<%=txtItemCode.ClientID %>").val() + "'";
                }
                else {
                    flag = 1;
                }
            }
            pageType = arguments[1];
            setObject = arguments[2];
            dialog({
                title: "选择窗口",
                src: "../Framework/ChoosePage.aspx?PageId=" +
                flag +
                "&Multiple=false&SearchCondition=" +
                condition +
                "&CallBackFunc=getChooseValue" +
                "&rnd=" +
                Math.random(),
                width: 680,
                height: 350
            });
        }

        function getChooseValue(list) {
            switch (pageType) {
                case "Item":
                    $("#<%=txtItemCode.ClientID %>").val(list[0][2]);
                    $("#labItemName").html(list[0][1]);
                    $("#<%=hidItemId.ClientID %>").val(list[0][0]);
                    break;
                case "SourceItem":
                    $(setObject).parent().find("input[type='hidden'][name='SourceItemId']").val(list[0][0]);
                    $(setObject).parent().find("input[type='text'][name='SourceItemCode']").val(list[0][2]);

                    var entity = {};
                    entity.ItemCode = list[0][2];
                    entity.ItemId = list[0][0];
                    var obj = $(setObject).parent().parent();
                    entity.trobj=obj;
                    entity.value = obj.find("option:selected").val();
                    setUpSourceItemCode(entity);
                    break;
                case "TargetItem":
                    $(setObject).parent().find("input[type='hidden'][name='TargetItemId']").val(list[0][0]);
                    $(setObject).parent().find("input[type='text'][name='TargetItemCode']").val(list[0][2]);
                    break;
                case "Station":
                    $(setObject).parent().find("input[type='hidden'][name='StationId']").val(list[0][0]);
                    $(setObject).parent().find("input[type='text'][name='StationName']").val(list[0][1]);
                    break;
            }
        }
        function setUpSourceItemCode(obj) {
            //加工类型为不变号料时，加工后料号与物料号一致
            if (obj.value == 1) {
                if (obj.ItemId != null) {
                    obj.trobj.find("input[name=TargetItemCode]").val(obj.ItemCode);
                    obj.trobj.find("input[name=TargetItemId]").val(obj.ItemId);
                    //不变料号，将目标物料编号的按钮禁用
                    obj.trobj.find("input[name=btnTargetItemId]").attr("disabled", "disabled");
                } else {
                    var trObj = $(obj).parent().parent();
                    var txtSourceItemCode = trObj.find("input[name=SourceItemCode]").val();
                    var txtSourceItemId = trObj.find("input[name=SourceItemId]").val();
                    trObj.find("input[name=TargetItemCode]").val(txtSourceItemCode);
                    trObj.find("input[name=TargetItemId]").val(txtSourceItemId);
                    //不变料号，将目标物料编号的按钮禁用
                    trObj.find("input[name=btnTargetItemId]").attr("disabled", "disabled");
                }               
            }
            else {
                if (obj.ItemId != null) {
                    //变料号，将目标物料编号的按钮禁用
                    obj.trobj.find("input[name=btnTargetItemId]").removeAttr("disabled");
                }
                else {
                    var trObj = $(obj).parent().parent();
                    //变料号，将目标物料编号的按钮禁用
                    trObj.find("input[name=btnTargetItemId]").removeAttr("disabled");
                }
            }
        }
    </script>
</asp:Content>
