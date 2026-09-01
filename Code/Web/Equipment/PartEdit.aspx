<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="True"
    CodeBehind="PartEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.PartEdit" Title="Edit Part" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
     <div class="wrap_tb" style="min-height: 350px; min-width: 600px">
        <ul class="tb">
            <li class="current" title="<%= Resources.lang.BaseInfo%>">
                <%= Resources.lang.BaseInfo%>
            </li>
           <%-- <li title="备件与设备关联">备件与设备关联 </li>--%>
       
        </ul>
    
     <div class="tb_c">
         <div class="infoTips">
                <%=Resources.Messages.WithAsteriskIsRequired %></div>
                <table width="100%" class="EditeContentTable">
     
        <tr>
             <td class="Label2">
               <%= Resources.lang.PartCode %><em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtPartCode" runat="server" isRequired="1" CssClass="TextBox" MaxLength="50"></asp:TextBox>
                <asp:HiddenField runat="server" ID="hndPardId" Value="-1"/>
            </td>
            <td class="Label2">
                <%= Resources.lang.myPartName%><em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtPartName" runat="server" isRequired="1" CssClass="TextBox" MaxLength="50"></asp:TextBox>
            </td>
         
        </tr>
         <tr>
            <td class="Label2">
                备件类别<em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox runat="server" ID="ddlEquipmentType" CssClass="TextBox" Enabled="false" IsRequired="1"></asp:TextBox>
                <input type="button" value="..." class="ButtonBox" onclick="selectEqType()" />
                <asp:HiddenField ID="HiddenEquipmentTypeId" runat="server" ClientIDMode="Static" />
            </td>
              <td class="Label2">
               规格型号
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtPartStand" runat="server" CssClass="TextBox" MaxLength="50"></asp:TextBox>
            </td>

        </tr>
                <tr>
              <td class="Label2">
               生产厂商
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtFactoryName" runat="server" CssClass="TextBox" Enabled="false"
                    ReadOnly="true"></asp:TextBox><input type="button" id="btnPartSupplier" class="ButtonBox"
                        value="..." onclick="selectPartFactory()" />
                <asp:HiddenField ID="hdnFactoryId" runat="server" Value="-1" />
            </td>
            <td class="Label2">
                <%= Resources.lang.VendorName %>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtPartSupplierName" runat="server" CssClass="TextBox" Enabled="false"
                    ReadOnly="true"></asp:TextBox><input type="button" id="btnFactory" class="ButtonBox"
                        value="..." onclick="selectPartSupplier()" />
                <asp:HiddenField ID="hdnPartSupplierId" runat="server" Value="-1" />
            </td>
           
        </tr>
        <tr>
           <td class="Label2">存放位置
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtPosition" runat="server" CssClass="TextBox" MaxLength="50"
                    Enabled="false" ClientIDMode="Static">
                </asp:TextBox>
                <input type="button" value="..." class="ButtonBox" onclick="selectPosition()" />
                <asp:HiddenField ID="HiddenPosition" runat="server" ClientIDMode="Static" />
            </td>
            <td class="Label2">
               配件更换周期
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtPartLive" runat="server" IsNumber="1" CssClass="TextBox" MaxLength="50"></asp:TextBox>&nbsp;
                <select id="selectDemp" runat="server">
                    <option>天</option>
                    <option>次</option>
                </select>
            </td>
           
        </tr>
        <tr>
            <td class="Label2">最小库存
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtMinStock" runat="server" CssClass="TextBox" MaxLength="50" IsNumber="1"   onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" onafterpaste="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}"></asp:TextBox>
            </td>
            <td class="Label2">最大库存
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtMaxStock" runat="server" CssClass="TextBox" MaxLength="50" IsNumber="1"  onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" onafterpaste="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">当前库存<em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtCuStock" runat="server" CssClass="TextBox" MaxLength="50" IsNumber="1" isRequired="1" onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" onafterpaste="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}"></asp:TextBox>
            </td>
           <td class="Label2">计量单位
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtUnitname" runat="server" CssClass="TextBox" MaxLength="50"
                    Enabled="false" ClientIDMode="Static">
                </asp:TextBox>
                <input type="button" value="..." class="ButtonBox" onclick="selectUnitName()" />
            </td>
        </tr>

       <%-- <tr>
             <td class="Label2">
                <%= Resources.lang.PartBrand %><em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtPartBrand" runat="server" CssClass="TextBox" MaxLength="50"></asp:TextBox>
            </td>
            <td class="Label2">
                <%= Resources.lang.Status %>
            </td>
            <td class="Field2">
                <select id="selectStatus" runat="server">
                    <option value="0">新购买</option>
                    <option value="1">维修中</option>
                    <option value="2">保养中</option>
                    <option value="3">故障中</option>
                    <option value="4">报废</option>
                </select>
            </td>
        </tr>--%>
        <%--<tr>
            <td class="Label2">
                <%= Resources.lang.EquipmentName %><em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtEquipmentName" runat="server" CssClass="TextBox" Enabled="false"
                    ReadOnly="true"></asp:TextBox><input type="button" id="btnEquipmentName" class="ButtonBox"
                        value="..." onclick="selectEquipmentName()" />
                <asp:HiddenField ID="hdnEquipmentId" runat="server" Value="-1" />
            </td>
             <td class="Label2">
                <%= Resources.lang.EnterFactoryDate %>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtFactoryDate" runat="server" CssClass="DateTimeBox"></asp:TextBox>
            </td>
        </tr>--%>
        <tr>
            <td class="Label2">
                <%= Resources.lang.Remark %>
            </td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtRemark" runat="server" CssClass="TextArea" TextMode="MultiLine"
                    MaxLength="200" Width="99%"></asp:TextBox>
            </td>

        </tr>
    </table>
        </div>
    <div>   
          <table class="EditeContentTable" width="100%">
                <tr>
                    <td class="Label" style="width: 49%; text-align: center; font-weight: bold;">
                        <asp:Label ID="lbl1" runat="server" Text="可选的设备列表"></asp:Label>
                    </td>
                    <td class="Label" style="width: 2%; text-align: center;">
                    </td>
                    <td class="Label" style="width: 49%; text-align: center; font-weight: bold;">
                        <asp:Label ID="lbl2" runat="server" Text="已关联设备列表 "></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="Field" style="width: 45%; vertical-align: top;">
                        <iframe name="frmRoleChooseList" id="fromChooseList1" frameborder="0" style="width: 99%;
                            height: 265px;" src="EquipmentPreItem.aspx?ID=<%= Request.QueryString["ID"] %>"></iframe>
                    </td>
                    <td class="Field" style="width: 10%; text-align: center; vertical-align: middle;">
                        <input type="button" id="btnLeftChoose1" runat="server" class="rightButton" onclick="btnChooseOnClick(0);" />
                        <br />
                        <br />
                        <br />
                        <br />
                        <input type="button" id="btnRightChoose2" runat="server" class="leftButton" onclick="btnChooseOnClick(1);" />
                    </td>
                    <td class="Field" style="width: 45%; vertical-align: top;">
                        <iframe name="frmUserRoleList" id="IfrHasChooseList" frameborder="0" style="width: 99%;
                            height: 265px; padding: 0px;"></iframe>
                    </td>
                </tr>
            </table>  
   </div>

     </div>
    <script type="text/javascript">
        var temp = 0;

        var partId =<%= Request.QueryString["ID"] == null ? -1 : Convert.ToInt32(Request.QueryString["ID"].ToString())%>
     
        /*保存数据*/
        function Save() {
           
            var txtPartName = $.trim($("#<%=this.txtPartName.ClientID%>").val());    //备件名称
            var txtPartCode = $.trim($("#<%=this.txtPartCode.ClientID%>").val());    //备件编码
            var txtPartStand = $.trim($("#<%=this.txtPartStand.ClientID%>").val());    //规格
            
            var txtPosition = $("#<%=this.HiddenPosition.ClientID%>").val();  //供应商
            var txtquipmentTypeId = $.trim($("#<%=this.HiddenEquipmentTypeId.ClientID%>").val());   //备件类别
            var txtPartSupplierId = $("#<%=this.hdnPartSupplierId.ClientID%>").val();  //供应商
            var txthdnFactoryId = $("#<%=this.hdnFactoryId.ClientID%>").val();  //工厂 
            var txtUnitname = $("#<%=this.txtUnitname.ClientID%>").val();  //计量单位 
             <%--   var txtFactoryDate = $("#<%=this.txtFactoryDate.ClientID%>").val() == "" ? "9999-12-31" : $("#<%=this.txtFactoryDate.ClientID%>").val();--%>
            var txtPartLive = "";
            if ($("#<%=this.txtPartLive.ClientID%>").val() == "") {    //配换周期
                txtPartLive = "";
            }
            else {
                txtPartLive = $.trim($("#<%=this.txtPartLive.ClientID%>").val()) + "," + $("#<%=this.selectDemp.ClientID%>").val();
            }
            var txtMinStock = $.trim($("#<%=this.txtMinStock.ClientID%>").val());   //最小库存
            var txtMaxStock = $.trim($("#<%=this.txtMaxStock.ClientID%>").val());    //最大库存
            var txtCuStock = $.trim($("#<%=this.txtCuStock.ClientID%>").val());    //初始库存

            if(txtMinStock!="" && txtMaxStock!="")
            if (parseInt(txtMaxStock) < parseInt(txtMinStock)) {
                alert("最大库存不能小于最小库存");
                return false;
            }
        <%--    var txtPartStatus = $("#<%=this.selectStatus.ClientID%>").val();
            var txtEquimentId = $("#<%=this.hdnEquipmentId.ClientID%>").val();--%>
            var txtRemark = $.trim($("#<%=this.txtRemark.ClientID%>").val());


            /*表单验证*/
            /*如需表单验证可以此处处理验证 开始*/
            //if (txtEquimentId == -1) {
            //    alert("请选择设备!");
            //    return false;
            //}
            var entity = {};
            entity.PartId = partId;
            entity.PartName = txtPartName;
            entity.PartCode = txtPartCode;
            entity.EquipmentTypeId = parseInt(txtquipmentTypeId);
            entity.PartStand = txtPartStand;
            entity.FactoryId = parseInt(txthdnFactoryId);
            entity.PartSupplierId = parseInt(txtPartSupplierId);
            entity.Position = parseInt(txtPosition);
            entity.PartLive = txtPartLive;
            entity.MinStock = parseInt(txtMinStock);
            entity.MaxStock = parseInt(txtMaxStock);
            entity.CurrentStock = parseInt(txtCuStock);
            entity.Remark = txtRemark;
            entity.UnitName = txtUnitname;
            entity.Qty = 0;
             
           
            //entity.PartStatus = parseInt(txtPartStatus);
            //entity.EquimentId = parseInt(txtquipmentTypeId);

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPart.PartEdit(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
           
           $("#<%=hndPardId.ClientID%>").val(ajax.value);   //设置备件ID值

            var isAdd = '<%= Request.QueryString["name"] %>';
           if (isAdd == "PartEdit") {
                alert('<%=Resources.Messages.SaveInSuccess%>');
               if ('<%=Request.QueryString["inMenu"] %>' == "true") {
                   openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/PartEdit.aspx?name=PartEdit&ID=" + parseInt(ajax.value);
                   location.href = openWinUrl;
               } else {
                   parent.window.Refresh();
               }
           } else {

                var iframe2 = document.getElementById("IfrHasChooseList");
                iframe2.src = "EquipmentInItem.aspx?ID="+ajax.value+"";


               alert("保存成功");
               parent.window.Refresh();
            
           }
           
        }

        function selectEquipmentName() {
            temp = 1;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=54&Multiple=false&rnd=" + Math.random(), width: 650, height: 320 });
        }
        function selectPartSupplier() {
            temp = 2;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=34&Multiple=false&rnd=" + Math.random(), width: 650, height: 320 });
        }

        
        function getChooseValue(list) {
          <%--  if (temp == 1) {
                $("#<%=this.txtEquipmentName.ClientID %>").val(list[0][1] + "|(" + list[0][2] + ")");
                $("#<%=this.hdnEquipmentId.ClientID %>").val(list[0][0]);
            }
            else--%> if (temp == 2) {
                $("#<%=this.txtPartSupplierName.ClientID %>").val(list[0][2]);
                $("#<%=this.hdnPartSupplierId.ClientID %>").val(list[0][0]);
            } else if (temp == 3) {
                $("#<%=this.txtUnitname.ClientID %>").val(list[0][1]);
            }else if (temp == 4) {
               
                $("#<%=this.txtPosition.ClientID %>").val(list[0][1]);
                $("#<%=this.HiddenPosition.ClientID %>").val(list[0][0]);
            } else if (temp == 47) {
                $("#<%=this.txtFactoryName.ClientID %>").val(list[0][2]);
                $("#<%=this.hdnFactoryId.ClientID %>").val(list[0][0]);
            }
        }

       function selectEqType() {
            var openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/EquimentTypeDialog.aspx?name=Equipment_EquimentTypeDialog&controlId=4";
            dialog({ title: "备件类别", src: openWinUrl, width: 255, height: 350 });
       }

        /*存放位置*/
        function selectPosition() {
            temp = 4;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=609&Multiple=false&rnd=" + Math.random(), width: 650, height: 320 });
        }
               /*选择生产厂商*/
        function selectPartFactory() {
            temp = 47;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=34&Multiple=false&rnd=" + Math.random(), width: 650, height: 320 });
        }

         /*单位*/
        function selectUnitName() {
            temp = 3;
            SearchCondition = "  DicProperty ='Unit'";
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=3&SearchCondition=" + SearchCondition + "&Multiple=false&rnd=" + Math.random(), width: 650, height: 320 });
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

           var partId = parseInt($("#<%=hndPardId.ClientID%>").val());
            var iframe2 = document.getElementById("IfrHasChooseList");
                iframe2.src = "EquipmentInItem.aspx?ID="+partId+"";

         function btnChooseOnClick(index) {
            partId = parseInt($("#<%=hndPardId.ClientID%>").val());
            if(partId==-1)
            {
                alert("请先保存备件信息！");
                return;
            }
            var ItemIDString="";
            if (index == 0) {//添加 
                    ItemIDString = window.frames[0].window.getSelectedValues(); 
            }
            else {
                   ItemIDString = window.frames[1].window.getSelectedValues(); 
            }
            
            if (ItemIDString == "") {
                alert("<%= Resources.Messages.RequireOperateRecord %>");
                return;
            }

    
           
            if (index == 0) {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPart.SavePartInEquiment(partId,ItemIDString);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return;
                }
                $("#<%=hndPardId.ClientID%>").val(ajax.value);                
            }
            else {
                /*从备件设备关系表(Basal_PartOnEquiment)中删除数据*/
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPart.RemovePartOutEquipment(partId,ItemIDString);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return;
                }
            }
                       
            if(partId==-1){                    
                     var iframe1 = document.getElementById("fromChooseList");
                     iframe1.src = "EquipmentPreItem.aspx?ID="+ajax.value+"";

                    var iframe2 = document.getElementById("IfrHasChooseList");
                    iframe2.src = "EquipmentInItem.aspx?ID="+ajax.value+"";
                }
                else{
                    window.frames[0].window.document.forms[0].submit();
                    window.frames[1].window.document.forms[0].submit(); 
                }  
        }
        
        
        function assignToListBox(fromListBoxId, toListBoxId, listFlag) {
            var selectedCert = $("#" + fromListBoxId + " option:selected").length;
            if (selectedCert <= 0) {
                var msg = '<%=Resources.Messages.QualificationCertificatinIsRequired %>';
                if (listFlag == 2) {
                    msg = "请选择工序！";
                }
                alert(msg);
                return false;
            }
            $("#" + fromListBoxId + " option").each(function () {
                if ($(this).attr("selected")) {
                    $("#" + toListBoxId + "").append("<option value=\"" + $(this).val() + "\">" + $(this).text() + "</option>");
                    $(this).remove();
                }
            });
        }
    </script>
</asp:Content>
