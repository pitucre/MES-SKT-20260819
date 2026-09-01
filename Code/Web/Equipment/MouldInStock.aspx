<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="True"
    CodeBehind="MouldInStock.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.MouldInStock" Title="Edit Mould" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <table width="100%" class="EditeContentTable">
        <tr>
            <td colspan="4" class="Label infoTips">
                <%=Resources.Messages.WithAsteriskIsRequired %>
            </td>
        </tr>
        <tr class="clear5">
        </tr>
        <tr>
            <td class="Label1">
                <%= Resources.lang.MouldCode%><em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox runat="server" ID="txtMouldCode"  style="width: 300px;" ></asp:TextBox><input type="button" id="btnMould"   class="ButtonBox"
                    value="..." onclick="selectMould()"  />
                <input type="hidden" id="hidmouldId" value="0"/>
            </td>
        </tr>
             <tr>
            <td class="Label1"> <%= Resources.lang.MouldName%>
            </td>
            <td class="Field1">
               <asp:Label runat="server" id="lblMouldName"></asp:Label>
            </td>
        </tr>
             <tr class="trHisLocation">
            <td class="Label1"> 历史库位
            </td>
            <td class="Field1">
               <asp:Label runat="server" id="lblHistoryLocation"></asp:Label>
            </td>
                       </tr>
         <tr id="trStork">
            <td class="Label1">
               库位条码<em>*</em>
            </td>
            <td class="Field1" >
                <asp:TextBox runat="server" ID="txtStockName"  ClientIDMode="Static" ></asp:TextBox><input type="button" id="btn1" class="ButtonBox"
                    value="..." onclick="selectStock()" />
                <input type="hidden" id="hidWarehouseLocationId" value="0"/>
            </td>
        </tr>
        <tr class="trOutStorkType">
           <td class="Label1">
               出库类型
           </td>
           <td class="Field1" >
                <select id="ddlOutStorkType" onchange="CheckType()">
                    <option value="产线">产线</option>
                    <option value="供应商">供应商</option>
                 </select>
           </td>
        </tr>
        <tr class="trOutStorSupplier" style=" display:none">
           <td class="Label1">
               供应商
           </td>
           <td class="Field1" >
                <asp:TextBox runat="server" ID="txtSupplerCode" ClientIDMode="Static"  ></asp:TextBox><input type="button" id="btn22" class="ButtonBox"
                    value="..." onclick="selectSupplier()" />
                <input type="hidden" id="hdnSupplierId" value="-1"/>
               <input type="hidden" id="hdnSupplierName" value=""/>
           </td>
        </tr>
        <tr class="trOutStorSupplier" style=" display:none">
           <td class="Label1">
               维修内容
           </td>
           <td class="Field1" >
                <asp:TextBox runat="server" ID="txtRepairedContent" ClientIDMode="Static" CssClass="TextArea" TextMode="MultiLine"  Columns="5" > </asp:TextBox>
           </td>
        </tr>
       <%-- <tr >
            <td class="Label1">
              设备编码
            </td>
            <td class="Field1" >
                <asp:TextBox runat="server" ID="txtEquipmentCode"  ></asp:TextBox><input type="button" id="btn22" class="ButtonBox"
                    value="..." onclick="selectEquipment()" />
                <input type="hidden" id="hdnEquipmentId" value="0"/>
            </td>
        </tr>--%>
       <%--  <tr >
            <td class="Label1">
              领用人
            </td>
            <td class="Field1" >
                <asp:TextBox runat="server" ID="txtLeader"  ></asp:TextBox>
            </td>

        </tr>--%>
    </table>

    <script type="text/javascript">
        var temp = 0;
       
        var mouldId =<%= Request.QueryString["Id"] == null ? "" : Request.QueryString["Id"].ToString()%>;
        var type =<%= Request.QueryString["type"]%>;
        $(function() {
           
            if (mouldId !="" ) {
                GetMould(mouldId);
            } 
            if (type == 0) {
                $("#trStork").hide();
                $(".trHisLocation").hide();
                
            }
            else{
               $(".trOutStorkType").hide();
               $(".trOutStorSupplier").hide();
            }   
            
        });

        function CheckType(){
           var value = $('select option:selected').val();
           if(value =="供应商"){
              $(".trOutStorSupplier").show();
           }
           else{
              $(".trOutStorSupplier").hide();
           }
        }
      
        function GetMould(mouldId) {

            var serachCondtion = "EquipmentId in("+mouldId+")";
            var list= SKT.LeanMES.Web.AjaxServices.AjaxEquipment.GetMouldInfoList(serachCondtion).value;
             
            if (list != null) {
                var equipmentNameStr = "";
                var equipmentCodeStr = ""
                ;
                for (var i = 0; i < list.length; i++) {
                   if (i > 0) {
                       equipmentNameStr += ",";
                       equipmentCodeStr += ",";
                   }
                   equipmentNameStr += list[i].EquipmentName;
                   equipmentCodeStr += list[i].EquipmentCode;
                }
                $("#<%=this.lblMouldName.ClientID%>").html(equipmentNameStr);
               <%-- $("#<%=this.lblMouldStand.ClientID%>").html(entity.EquipmentModel);--%>
                $("#<%=this.txtMouldCode.ClientID%>").val(equipmentCodeStr);
                $("#hidmouldId").val(mouldId);
                GetHistoryLoRecord(mouldId);
            } else {
                $("#hidmouldId").val(0);
                $("#<%=this.lblMouldName.ClientID%>").html("");
                <%--$("#<%=this.lblMouldStand.ClientID%>").html("");--%>
                alert("选择的模具不存在！");
               
                return;
            }
        }



        function GetHistoryLoRecord(mouldId) {
          
            var list= SKT.LeanMES.Web.AjaxServices.AjaxEquipment.GetMouldHistoryOutStockRecord(mouldId).value;
            if (list != null) {
                $("#<%=this.lblHistoryLocation.ClientID%>").text(list.join(","));
            }
        }

        /*保存数据*/
        function Save() {
         
            var mouldId = $("#hidmouldId").val();
            var hidWarehouseLocationId = $("#hidWarehouseLocationId").val();
            var mouldCode=$("#<%=this.txtMouldCode.ClientID%>").val();
            var ddlOutStorkType = $("#ddlOutStorkType").val();
            var SupplierId = $("#hdnSupplierId").val();
            
            if (mouldId <= 0) {
                
                alert("请选择可用的模具！");
                return false;
            }
            if (type == 1) {
                if (hidWarehouseLocationId <= 0) {
                    alert("请选择存放储位！");
                    return false;
                }
            }
            if(ddlOutStorkType == "供应商"){
                if(SupplierId == "-1"){
                   alert("请选择供应商！");
                    return false;
                }
            }
          
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipment.UpdateStock(mouldId,type,hidWarehouseLocationId,ddlOutStorkType,SupplierId);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            MouldOperateRecord();
            if(type==1){
                if (confirm("入库成功，是否继续操作?")) {
                    Clear();
                } else {
                    parent.window.UpdateList("");
                };

            }else{
                if (confirm("出库成功，是否继续操作?")) {
                    Clear();
                } else {
                    parent.window.UpdateList("");
                };
               
            }
           
        }

        /*记录模具操作履历*/
        function MouldOperateRecord() {
            var UserName = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
            var CName = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUserInfo().EmployeeCName%>';

            var entity = {};

            var txtStockName = $("#txtStockName").val();
            var ddlOutStorkType = $("#ddlOutStorkType").val();
            var hdnSupplierName = $("#hdnSupplierName").val();
            var repairedContent = $("#txtRepairedContent").val();

            var item1 = "";
            var item2 = "";
            var operateType = ""
            var remark = "";

            if(type == 1){
                operateType = "入库";
                item1 = txtStockName;                
            }
            else{
                if(ddlOutStorkType == "供应商"){
                    operateType = "出库到供应商";
                    item1 = hdnSupplierName;
                    item2 = repairedContent;
                }
                else{
                    operateType = "出库到产线";
                }
            }

            entity.MouldId = mouldId;
            entity.OperateType = operateType;
            entity.Operator = CName;
            entity.Item1 = item1;
            entity.Item2 = item2;
            entity.Item3 = "";
            entity.Remark = remark;
            entity.CreateBy = UserName;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMouldOperateRecord.Edit(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            <%--alert('<%=Resources.Messages.SaveInSuccess%>');
            parent.window.closeDialog();--%>

        }

         /*选择模具*/
        function selectMould() {
            temp = 1;
            var searchCondition = "  EquipmentTypeId=-4";
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=701&SearchCondition=" + searchCondition + "&Multiple=true&rnd=" + Math.random(), width: 600, height:400 });
        }

        /*选择库位*/
        function selectStock() {
            temp = 2;
            var searchCondition = " CWhName in('模具仓','模具报废仓')";
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=33&SearchCondition=" + searchCondition +"&Multiple=false&rnd=" + Math.random(), width: 600, height: 400 });
        }

        //选择供应商
        function selectSupplier(){
           temp = 3;
           dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=34&Multiple=false&rnd=" + Math.random(), width: 600, height:400 });
        }

        function getChooseValue(list) {

        
            if (temp == 1) {

                var mouldIdStr = "";
                
                ;
                for (var i = 0; i < list.length; i++) {
                    if (i > 0) {
                        mouldIdStr += ",";
                       
                    }
                    mouldIdStr += list[i][0];
                   
                }
             
              // $("#<%=this.txtMouldCode.ClientID %>").val(list[0][1]);
                $("#hidmouldId").val(mouldIdStr);

                GetMould(mouldIdStr);
           }else if (temp == 2) {
                $("#<%=this.txtStockName.ClientID %>").val(list[0][2]);
                $("#hidWarehouseLocationId").val(list[0][0]);
           }
           else if(temp == 3){
              $("#<%=this.txtSupplerCode.ClientID %>").val(list[0][1]);
               $("#hdnSupplierId").val(list[0][0]);
               $("#hdnSupplierName").val(list[0][2]);
               $("#txtRepairedContent").select();
           }
       }

        function Clear() {
            $("#<%=this.txtMouldCode.ClientID%>").val("");
            $("#hidmouldId").val(0);
            $("#<%=this.lblMouldName.ClientID%>").html("");
            $("#hidWarehouseLocationId").val(0);
            $("#<%=this.txtStockName.ClientID%>").html("");
            $("#<%=this.txtSupplerCode.ClientID %>").val("");
            $("#hdnSupplierId").val(0);
        }
    </script>
</asp:Content>
