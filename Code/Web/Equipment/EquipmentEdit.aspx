<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EquipmentEdit.aspx.cs"
    Inherits="SKT.LeanMES.Web.Equipment.EquipmentEdit" MasterPageFile="~/Masters/EditMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
   
     <div class="wrap_tb" style="min-height: 350px; min-width: 600px">
        <ul class="tb">
            <li class="current" title="<%= Resources.lang.BaseInfo%>">
               <%= Resources.lang.BaseInfo%>
            </li>
          <%--  <li title="其他信息">其他信息</li>--%>
                <li title="扩展信息">扩展信息</li>
        </ul>
  
 <div class="tb_c">
     <table class="EditeContentTable" width="100%">
<%--        <tr>
            <td class="Label3">上传图片
            </td>
            <td class="Field3">
                <asp:FileUpload ID="fuLoadingList" runat="server" onchange="uploadFile(this.value)" ClientIDMode="Static" />
                <asp:LinkButton ID="linkUploadFile" runat="server" OnClick="linkUploadFile_Click" ClientIDMode="Static"></asp:LinkButton>
                <asp:Label runat="server" ClientIDMode="Static" ID="lbFileReady" CssClass="redFont" ForeColor="Red">未载入</asp:Label>
                <asp:Label runat="server" ClientIDMode="Static" ID="Label1" CssClass="redFont" Visible="false">111</asp:Label>
            </td>
           
            
        </tr>--%>
        <tr>
            <td class="Label3">
                <%= Resources.lang.EquipmentCode%><em>*</em>
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtEquipmentCode" runat="server" CssClass="TextBox" MaxLength="50"
                    IsRequired='1' ClientIDMode="Static"></asp:TextBox><%-- <input type="checkbox" class="check_ico_docu"/>自动生成--%>
            </td>
            <td class="Label3">
                <%= Resources.lang.EquipmentName%><em>*</em>
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtEquipmentName" runat="server" CssClass="TextBox" MaxLength="50"
                    IsRequired='1' ClientIDMode="Static"></asp:TextBox>
            </td>
            <td rowspan="7" class="Field3" style="text-align: center; "> 
                <div class="layui-upload">
                  <button type="button" class="layui-btn" style="background-color: #4E8CD4" id="test1"><span>上传图片</span></button>
                  <div class="layui-upload-list">
                     <asp:Image runat="server" CssClass="layui-upload-img" ID="image1"/>
                    
                     <p style="color:red"><span>支持图片格式：GIF/JPG/PNG/BMP 图片大小：不超过1MB</span></p>
                    <p id="demoText"></p>
                  </div>
                     <asp:Label runat="server" ClientIDMode="Static" ID="lbFileReady" CssClass="redFont hide" ForeColor="Red" >未载入</asp:Label>
                </div>  
            </td>
        </tr>
        <tr>
             <td class="Label3">
                <%= Resources.lang.EquipmentType%><em>*</em>
            </td>
            <td class="Field3">
                <asp:TextBox runat="server" ID="ddlEquipmentType" CssClass="TextBox" Enabled="false" IsRequired="1"></asp:TextBox>
                <input type="button" value="..." class="ButtonBox" onclick="selectEqType()" />
                <asp:HiddenField ID="HiddenEquipmentTypeId" Value="-1" runat="server" ClientIDMode="Static" />
            </td>

            <td class="Label3">
                <%= Resources.lang.EquipmentModels%><em>*</em>
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtEquipmentModel" runat="server" CssClass="TextBox" MaxLength="150"
                    IsRequired='1' ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr>
         <tr>
              <td class="Label3">
                <%= Resources.lang.venCode %><em></em>
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtVerdorName" runat="server" CssClass="TextBox" ></asp:TextBox>
                <%--<asp:TextBox ID="txtVerdorName" runat="server" CssClass="TextBox" Enabled="false"
                    ReadOnly="true"></asp:TextBox><input type="button" id="btnPartSupplier" class="ButtonBox"
                        value="..." onclick="selecFactory()" />--%>
                <asp:HiddenField ID="hdnVendorCode" runat="server" Value="" />
            </td>
            <td class="Label3">
                <%= Resources.lang.Supplier %>
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtSupplierName" runat="server" CssClass="TextBox" Enabled="false" 
                    ReadOnly="true"></asp:TextBox><input type="button"  class="ButtonBox"
                        value="..." onclick="selectSupplier()" />
                <asp:HiddenField ID="hdnSupplierCode" runat="server" Value="" />
            </td>
        </tr>
         <tr>
           <td class="Label3">存放位置<em>*</em>
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtPosition" runat="server" CssClass="TextBox" MaxLength="50" IsRequired="1"
                    Enabled="false" ClientIDMode="Static">
                </asp:TextBox>
                <input type="button" value="..." class="ButtonBox" onclick="selectPosition()" />
                <asp:HiddenField ID="HiddenPosition" Value="-1" runat="server" ClientIDMode="Static" />
            </td>
            <td class="Label3">
                <%= Resources.lang.EnterFactoryDate%><em></em>
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtFactortTime" runat="server" CssClass="DateTimeBox" MaxLength="50" 
                    Width="140" ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr>
         <tr>
               <td class="Label3">
                <%= Resources.lang.EquipmentStatus%><em>*</em>
            </td>
            <td class="Field3">
                <asp:DropDownList ID="ddlStatus" ClientIDMode="Static" runat="server" Width="100">
                    <asp:ListItem Value="0">新购买</asp:ListItem>
                    <asp:ListItem Value="1">生产中</asp:ListItem>
                    <asp:ListItem Value="2">待机中</asp:ListItem>
                    <asp:ListItem Value="3">换线中</asp:ListItem>
                    <asp:ListItem Value="4">维修中</asp:ListItem>
                    <asp:ListItem Value="5">已报废</asp:ListItem>
                    <asp:ListItem Value="6">故障中</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td class="Label3">
               资产编号
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtAssetNumber" runat="server"  MaxLength="50"  Width="140" ClientIDMode="Static" ></asp:TextBox>
            </td>
         </tr>
          <tr>
           <td class="Label3">过保日期
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtOverGuaranteeTime" runat="server" CssClass="DateTimeBox" MaxLength="50"  Width="140" ClientIDMode="Static"></asp:TextBox>
            </td>
            <td class="Label3">
                保修期（天）
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtGuaranteeDay" runat="server"  MaxLength="50"   Width="140" ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr>
         <tr>
              <td class="Label3">工序
            </td>
             <td class="Field3">
                     <asp:TextBox ID="txtStation" runat="server" CssClass="TextBox" MaxLength="50"
                    Enabled="false" ClientIDMode="Static">
                </asp:TextBox>
                <input type="button" value="..." class="ButtonBox" onclick="selectStation()" />
                <asp:HiddenField ID="HiddenStation" Value="-1" runat="server" ClientIDMode="Static" />
            </td>
                      <td class="Label3">
             <%= Resources.lang.LineName%>
         </td>
         <td class="Field3">
             <asp:DropDownList ID="ddlLine" runat="server" ClientIDMode="Static" Width="100">
             </asp:DropDownList>
         </td>
         </tr>
         <tr>
           <td class="Label3">IP地址</td>
            <td class="Field3">
                <asp:TextBox ID="txtEquipmentIP" runat="server" MaxLength="50"  Width="140" ClientIDMode="Static"></asp:TextBox>
            </td>
            <td class="Label3">端口号</td>
            <td class="Field3">
                <asp:TextBox ID="txtEquipmentPort" runat="server"  MaxLength="50"   Width="140" ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr>
    </table>
     </div>
    
         <div>
                <table id="tblExtensionInfos" class="EditeContentTable" width="100%">
                <tr id="trNewInfo">
                    <td colspan="4" style="text-align: center;">
                        <%=Resources.lang.NoExtendedInfos %>
                    </td>
                </tr>
            </table>
        </div>
              <div style="display:none" >
         <table class="EditeContentTable" width="100%">
              <tr>
         <td class="Label3">购置方式
        </td>
        <td class="Field3">
            <asp:DropDownList ID="ddPurchase" ClientIDMode="Static" runat="server" Width="100">
                <asp:ListItem Value="0">购买</asp:ListItem>
                <asp:ListItem Value="1">租赁</asp:ListItem>
                <asp:ListItem Value="2">赠送</asp:ListItem>
                <asp:ListItem Value="3">借用</asp:ListItem>
            </asp:DropDownList>
        </td>

        <td class="Label3">计量单位
        </td>
        <td class="Field3">
            <asp:TextBox ID="txtUnitname" runat="server" CssClass="TextBox" MaxLength="50"
                Enabled="false" ClientIDMode="Static">
            </asp:TextBox>
            <input type="button" value="..." class="ButtonBox" onclick="selectUnitName()" />
        </td>
    </tr>  
    <tr>
       
       <td class="Label2">
            <%= Resources.lang.MachineSequenceInLine%> 
        </td>
        <td class="Field2" >
            <asp:TextBox ID="txtSequenceNo" CssClass="NumericBox50" runat="server" IsNumber='1' onkeyup="this.value=this.value.replace(/[^\d.]/g,'')" onafterpaste="this.value=this.value.replace(/[^\d.]/g,'')"></asp:TextBox>
      </td>
    </tr>
   
    <tr>
        <td class="Label3">保管部门
        </td>
        <td class="Field3">
            <asp:TextBox ID="txtDep" runat="server" CssClass="TextBox" MaxLength="50"
                Enabled="false" ClientIDMode="Static">
            </asp:TextBox>
            <input type="button" value="..." class="ButtonBox" onclick="selectDep()" />
            <asp:HiddenField ID="HiddDep" runat="server" ClientIDMode="Static" />
        </td>
        <td class="Label3">保管人
        </td>
        <td class="Field3">
            <asp:TextBox ID="txtBy" runat="server" CssClass="TextBox" MaxLength="50"
                Enabled="false" ClientIDMode="Static">
            </asp:TextBox>
            <input type="button" value="..." class="ButtonBox" onclick="selectBy()" />
            <asp:HiddenField ID="HiddBy" runat="server" ClientIDMode="Static" />
        </td>
    </tr>
 <tr>
       
         <td class="Label3">使用次数
        </td>
        <td class="Field3" >
            <asp:TextBox ID="txtUseCount" runat="server" CssClass="TextBox" MaxLength="50" IsNumber='1' ClientIDMode="Static">
            </asp:TextBox>
        </td>
       <td class="Label3">
        </td>
        <td class="Field3" >
            
        </td>
    </tr>
    <tr>
        <td class="Label3">
            <%= Resources.lang.Remark%>
        </td>
        <td class="Field3" colspan="3">
            <asp:TextBox ID="txtRemark" CssClass="TextArea" TextMode="MultiLine" runat="server"
                ClientIDMode="Static" Width="99%" Height="75"></asp:TextBox>
        </td>
    </tr>
         </table>
     </div>
  </div>

    <div class="clear5">
    </div>
    <asp:HiddenField ID="filepaths" runat="server" Value="-1" ClientIDMode="Static" />

    <script type="text/javascript" src="../Content/js/jquery-3.1.0.min.js"></script>

    <link href="../Content/plugin/layui/css/layui.css" rel="stylesheet" />
    <script src="../Content/plugin/layui/layui.all.js"></script>
    <script type="text/javascript" language="javascript">

        layui.use('upload', function() {
            var $ = layui.jquery, upload = layui.upload;

            //普通图片上传
            var uploadInst = upload.render({
                elem: '#test1',
                accept:'images',
                exts: 'jpg|jpge|gif|png|bmp',
                size: 1024,//限制文件大小，单位 KB
                url: '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/UploadHander.ashx?Action=FileUploadEquiment',
                before: function(obj) {
                    //预读本地文件示例，不支持ie8
                    obj.preview(function(index, file, result) {
                        $('#<%=this.image1.ClientID%>').attr('src', result); //图片链接（base64）
                    });
                },
                done: function (res) {
                    //如果上传失败
                    if (res.code > 0) {
                        return layer.msg('上传失败');
                    }
                  
                    var fileUrl = GetFilePath("FileUploadEquiment", res.data.FileName);
                    $('#<%=this.image1.ClientID%>').attr('src', fileUrl);
                    var n = 0;
                    if (fileUrl.indexOf('=') > 0) {
                        var n = fileUrl.lastIndexOf("=");
                    } else {
                        var n = fileUrl.lastIndexOf("/");
                    }
                  
                    $("#<%=this.lbFileReady.ClientID%>").html(fileUrl.substring(n+1, fileUrl.length));
                },
                error: function () {
                    var demoText = $('#demoText');
                    demoText.html('<span style="color: #FF5722;">上传失败</span> <a class="layui-btn layui-btn-mini demo-reload">重试</a>');
                    demoText.find('.demo-reload').on('click', function() {
                        uploadInst.upload();
                    });
                }
            });
        });
        var Flag = 0;
        var Id = '<%= Request.QueryString["Id"] == null ? -1 : Convert.ToInt32(Request.QueryString["Id"].ToString())%>';
        <%--  function uploadFile(filePath) {
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
                //$("#linkUploadFile").click();
            }
        }--%>



        function Save() {
          
            var errStr = "";
            var equipmentCode = $("#txtEquipmentCode").val();  //设备编码
            var equipmentName = $("#txtEquipmentName").val();  //设备名称
            var equipmentTypeId = $("#HiddenEquipmentTypeId").val();  //类别
            if (equipmentTypeId == -1 || equipmentTypeId == "") {
                alert("请选择设备类型！");
                $("#ddlEquipmentType").focus();
                return false;
            }
             var txtEquipmentModel = $("#txtEquipmentModel").val();  //型号规格
            <%-- var factoryCode = $("#<%=this.hdnVendorCode.ClientID %>").val();  //生厂厂商--%>
             var  factoryCode=$("#<%=this.txtVerdorName.ClientID %>").val();  //生厂厂商,修改成手动输入 by beichang.zhong 2020.1.6
             var  supplierCode=$("#<%=this.hdnSupplierCode.ClientID %>").val();  //供应商
            var txtEquipmentIP = $("#txtEquipmentIP").val();  //IP地址
            var txtEquipmentPort = $("#txtEquipmentPort").val();  //端口号

            var lineId = $("#ddlLine").val();
            var sequenceNo = $("#<%=this.txtSequenceNo.ClientID %>").val();
           if (lineId < 0) {
               if (sequenceNo != "") {
                  alert("设备在线别上的序号不为空，请选择产线名称！");
                $("#ddlLine").focus();
                return false;
               }
           }
            if (sequenceNo == "") {
                sequenceNo = "-1";
            }

            var status = $("#ddlStatus").val();
            var txtFactoryTime = $("#txtFactortTime").val();
            var txtRemark = $("#txtRemark").val();

      <%--   var supplierId = $("#<%=this.hdnSupplierId.ClientID %>").val();--%>
            var P = $("#<%=this.lbFileReady.ClientID%>").html();


            if (errStr != "") {
                alert(errStr);
                return false;
            }
            var txtoverGuaranteeTime = $("#<%=this.txtOverGuaranteeTime.ClientID %>").val();
            var entity = {}
            entity.EquipmentId = Id;
            entity.EquipmentCode = equipmentCode;
            entity.EquipmentName = equipmentName;
            entity.EquipmentTypeId = equipmentTypeId;
            entity.EquipmentModel = txtEquipmentModel;

            entity.Status = status;
            entity.LineId = lineId;
            entity.SequenceNo = sequenceNo;
            entity.StationId = $("#<%=this.HiddenStation.ClientID %>").val();
            entity.StationName = $("#<%=this.txtStation.ClientID %>").text();
           
            entity.Remark = txtRemark;
            entity.VenCode = factoryCode;  //生产厂商
            entity.SupplierCode = supplierCode;  
            entity.Thick = 0.00;
            entity.Position = $("#<%=this.HiddenPosition.ClientID %>").val();
            entity.VendorBarcode = "";
            entity.StandarLive = 0;

            entity.UseCount = $("#txtUseCount").val() == "" ? 0 : $("#txtUseCount").val();
            entity.WarningCount = 0;
            entity.CurPosition = "";
            entity.InOrOut = 1;
            entity.IsClear = 1;
            entity.StoreName = "";
            entity.Purchase = $("#ddPurchase").val();
            entity.UnitName = $("#<%=this.txtUnitname.ClientID %>").val();
            entity.CareDepNo = $("#<%=this.HiddDep.ClientID %>").val();
            entity.CareBy = $("#<%=this.txtBy.ClientID %>").val();
            entity.PictureName = P;
            entity.GuaranteeDay = $("#<%=this.txtGuaranteeDay.ClientID %>").val() == "" ? 0 : parseInt($("#<%=this.txtGuaranteeDay.ClientID %>").val());
            entity.AssetNumber = $("#<%=this.txtAssetNumber.ClientID %>").val();
            entity.EquipmentIP = txtEquipmentIP;
            entity.EquipmentPort = txtEquipmentPort;
         

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipment.EditEquipment(entity, txtFactoryTime, txtoverGuaranteeTime);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }


            //保存扩展信息
            var extIds = new Array();
            $("input[class='ExtId']").each(function () {
                extIds.push($(this).val());
            });
            var extFieldsIds = new Array();
            $("input[class='ExtFieldsId']").each(function () {
                extFieldsIds.push($(this).val());
            });
            var extFieldValues = new Array();
            $("input.ExtFieldValue").each(function () {
                if ($(this).attr("type") == "radio") {
                    if ($(this).is(":checked")) {
                        extFieldValues.push($(this).val().toString());
                    } else {
                        extFieldValues.push("null");
                    }
                } else {
                    if ($(this).val() != null && $(this).val() != "") {
                        extFieldValues.push($(this).val().toString());
                    } else {
                        extFieldValues.push("null");
                    }
                }
            });
            var extIdStrs = extIds.join(',') + ',';
            var extFieldsIdStrs = extFieldsIds.join(',') + ',';
            var extFieldValueStrs = extFieldValues.join(',') + ',';
            var extAjax = SKT.LeanMES.Web.AjaxServices.AjaxBaseExt.BaseExtInfoListEdit(extIdStrs, extFieldsIdStrs, extFieldValueStrs, Id, "Basal_Equipment");
            if (extAjax.error != null) {
                alert(extAjax.error.Message);
                return false;
            }


            alert('<%=Resources.Messages.SaveSuccess%>');

            parent.window.UpdateList(equipmentCode);

        }
        function selectEqType() {
           chooseFlag = 100;
           SearchCondition = "";
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=680&Multiple=false&SearchCondition="+SearchCondition+"&rnd=" + Math.random(), width: 600, height: 300 });
           <%-- var openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/EquimentTypeDialog.aspx?name=QC_InspectionItemDialog&controlId=controlId";
            dialog({ title: "设备类型", src: openWinUrl, width: 255, height: 350 });--%>
        }

        

          /*选择厂商*/
        function selecFactory() {
            chooseFlag = 35;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=34&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }
        /*选择供应商*/
        function selectSupplier() {
            chooseFlag = 34;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=34&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }
        /*单位*/
        function selectUnitName() {
            chooseFlag = 1;
            SearchCondition = "  DicProperty ='Unit'";
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=3&SearchCondition=" + SearchCondition + "&Multiple=false&rnd=" + Math.random(), width: 600, height: 400 });
        }
        /*保管部门*/
        function selectDep() {
            chooseFlag = 2;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=13&Multiple=false&rnd=" + Math.random(), width: 500, height: 300 });
        }
        /*保管人*/
        function selectBy() {
            chooseFlag = 3;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=12&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }
        /*保管人*/
        function selectPosition() {
            chooseFlag = 4;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=609&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }
        //工序
        function  selectStation()
        {
            chooseFlag = 8;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=8&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }
        function getChooseValue(list) {
            if (chooseFlag == 1) {
                $("#<%=this.txtUnitname.ClientID %>").val(list[0][2]);
            } else if (chooseFlag == 2) {
                $("#<%=this.txtDep.ClientID %>").val(list[0][2]);
                $("#<%=this.HiddDep.ClientID %>").val(list[0][1]);
            } else if (chooseFlag == 3) {
                $("#<%=this.txtBy.ClientID %>").val(list[0][2]);
                $("#<%=this.HiddBy.ClientID %>").val(list[0][1]);
            } else if (chooseFlag == 4) {

                $("#<%=this.txtPosition.ClientID %>").val(list[0][1]);
                $("#<%=this.HiddenPosition.ClientID %>").val(list[0][0]);
            } else if (chooseFlag == 34) {
                $("#<%=this.txtSupplierName.ClientID %>").val(list[0][2]);
                $("#<%=this.hdnSupplierCode.ClientID %>").val(list[0][1]);
            }else if (chooseFlag == 35) {
                $("#<%=this.txtVerdorName.ClientID %>").val(list[0][2]);
                $("#<%=this.hdnVendorCode.ClientID %>").val(list[0][1]);
            }else if (chooseFlag == 100) {
                $("#HiddenEquipmentTypeId").val(list[0][0]);
                $("#<%=ddlEquipmentType.ClientID%>").val(list[0][1]);
            }
            else if(chooseFlag==8)
            {
                $("#<%=this.txtStation.ClientID %>").val(list[0][1]);
                $("#<%=this.HiddenStation.ClientID %>").val(list[0][0]);
            }
        }
        SetValue = function (list) {
            closeDialog();
            $("#HiddenEquipmentTypeId").val(list[0].id);
            $("#<%=ddlEquipmentType.ClientID%>").val(list[0].name);
        }
    </script>
    <script type="text/javascript">
        /*Comment by Hanson.Lei 2016/10/13*/
        $(function () {
            $(".DateTimeBox").attr("readOnly", "readOnly");
        });
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

                    //必填的判断，modified by zhi.li 20180824
                    var extensionFieldIsAllowNull = 0;
                    if (list[i].ExtFieldIsAllowNull == false) {
                        extensionFieldIsAllowNull = 1;
                        r += "<td class='Label2'><label id='lblExtFieldDescription" + i + "' name='ExtFieldDescription'>" + list[i].ExtFieldDescription + "</label><em>*</em>";
                    }
                    else {
                        r += "<td class='Label2'><label id='lblExtFieldDescription" + i + "' name='ExtFieldDescription'>" + list[i].ExtFieldDescription + "</label>";
                    }


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
                    r += "<input type='text' id='txtExtFieldValue" + i + "' name='dateExtFields' class='ExtFieldValue' IsRequired='" + extensionFieldIsAllowNull + "'  readonly value='";
                    if (list[i].ExtFieldValue != null && list[i].ExtFieldValue != undefined && list[i].ExtFieldValue != "") {
                        r += list[i].ExtFieldValue;
                    }
                } else if (list[i].ExtFieldType == "int") {
                    r += "<input type='text' id='txtExtFieldValue" + i + "' name='intExtFields' class='ExtFieldValue' IsRequired='" + extensionFieldIsAllowNull + "'  value='";
                    if (list[i].ExtFieldValue != null && list[i].ExtFieldValue != undefined && list[i].ExtFieldValue != "") {
                        r += list[i].ExtFieldValue;
                    }
                } else { //字段类型为字符
                    r += "<input type='text' id='txtExtFieldValue" + i + "' name='txtExtFields' class='ExtFieldValue' IsRequired='" + extensionFieldIsAllowNull + "'  value='";
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
            $("#trNewInfo").remove();
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
