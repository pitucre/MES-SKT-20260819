<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" 
    CodeBehind="SparePartsItemRelationEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Sparepart.SparePartsItemRelationEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %>
    </div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <%--  <td class="Label2"><%= Resources.lang.ItemCode %></td>
            <td class="Field2">
                <asp:TextBox ID="txtItemCode" runat="server" CssClass="TextBox" IsRequired='1' ReadOnly="true"
                    ClientIDMode="Static"></asp:TextBox><input type="button" id="btnSelectItem" class="ButtonBox" value="..." title="Select"
                        onclick="openChoosePage(1)" />
                <asp:HiddenField ID="hdnItemId" runat="server" Value="-1" ClientIDMode="Static" />
            </td>--%>
            <td class="Label2"><%= Resources.lang.EquipmentCode %><em>*</em></td>
            <td class="Field1" >
                <asp:TextBox ID="txtEqCode" runat="server" CssClass="TextBox" IsRequired='1'
                    ReadOnly="true"></asp:TextBox><input type="button" id="btnEquipmentName" class="ButtonBox"
                        value="..." onclick="selectSpareParts()" />
                <asp:HiddenField ID="HiddentxtEqCode" runat="server" Value="-1" />
            </td>
           
        </tr>
    </table>
    <div>
        <table class="EditeContentTable" width="100%">
            <tr>
                <td class="Label" style="width: 49%; text-align: center; font-weight: bold;">
                    <asp:Label ID="lbl1" runat="server" Text="可选的机种列表"></asp:Label>
                </td>
                <td class="Label" style="width: 2%; text-align: center;"></td>
                <td class="Label" style="width: 49%; text-align: center; font-weight: bold;">
                    <asp:Label ID="lbl2" runat="server" Text="已关联机种列表 "></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="Field" style="width: 45%; vertical-align: top;">
                    <iframe name="frmRoleChooseList" id="fromChooseList1" frameborder="0" style="width: 600px; height: 265px;"
                        src="ItemPreSpareParts.aspx?EqCode=<%= Request.QueryString["EqCode"] %>"></iframe>
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
                    <iframe name="frmUserRoleList" id="IfrHasChooseList" frameborder="0" style="width: 99%; height: 265px; padding: 0px;"></iframe>
                </td>
            </tr>
        </table>
    </div>
    <asp:HiddenField runat="server" ID="hdeqCode"/>
    <script type="text/javascript">
        
        var equipmentItemRelationId = '<%=Request.QueryString["ID"]%>';

        function selectSpareParts() {
            temp = 1;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=507&Multiple=false&rnd=" + Math.random(), width: 650, height: 350 });
           
        }
        <%--   function openChoosePage(flags) {
               var condition = "";
               temp = 2;
               dialog({
                   title: "<%= Resources.CommonoseWindow %>",
                   src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=" +
                       flags +
                       "&Multiple=false&SearchCondition=" +
                       condition +
                       "&rnd=" +
                       Math.random(),
                   width: 600,
                   height: 300
               });
           }--%>
        function getChooseValue(list) {
            if (temp == 1) {
                $("#<%=this.txtEqCode.ClientID%>").val(list[0][2]);
                var iframe2 = document.getElementById("IfrHasChooseList");
                iframe2.src = "ItemInSpareParts.aspx?EqCode=" + list[0][2] + "";
      
                var iframe1 = document.getElementById("fromChooseList1");
                iframe1.src = "ItemPreSpareParts.aspx?EqCode=" + list[0][2] + "";
            }
        }
        /*保存数据*/
        function Save() {
            <%-- var txtItemCode = $.trim($("#<%=this.txtItemCode.ClientID%>").val());--%>
          <%--  var txtEqCode = $.trim($("#<%=this.txtEqCode.ClientID%>").val());
            var txtCreateBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';


            /*表单验证*/
            /*如需表单验证可以此处处理验证 开始*/


            var entity = {};

            entity.EquipmentItemRelationId = equipmentItemRelationId
            entity.ItemCode = txtItemCode;
            entity.EqCode = txtEqCode;
            entity.CreateBy = txtCreateBy;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipmentItemRelation.EquipmentItemRelationEdits(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }--%>

            alert('<%=Resources.Messages.SaveInSuccess%>');
            parent.window.Refresh();
          <%--  if ('<%=Request.QueryString["inMenu"] %>' == "true") {
                openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/User/UserEdit.aspx?name=Account_UserEdit&ID=" + parseInt(ajax.value);
                location.href = openWinUrl;
            }
            else {
                parent.window.Refresh();
            }--%>
        }
    </script>
    <script type="text/javascript">
        var eqCode = "";
        $(function() {
             eqCode = $("#<%=txtEqCode.ClientID%>").val();
            if (eqCode != "") {
                var iframe2 = document.getElementById("IfrHasChooseList");
                iframe2.src = "ItemInSpareParts.aspx?EqCode=" + eqCode + "";
            }
        });

        function btnChooseOnClick(index) {
            eqCode = $("#<%=txtEqCode.ClientID%>").val();
            if(eqCode=="")
            {
                alert("请选择设备编码！");
                return;
            }
            var itemIdString="";
            if (index == 0) {//添加 
                itemIdString = window.frames[0].window.getSelectedValues(); 
            }
            else {
              
                itemIdString = window.frames[1].window.getSelectedValues(); 
            }
            
            if (itemIdString == "") {
                alert("<%= Resources.Messages.RequireOperateRecord %>");
                return;
            }

            if (index == 0) {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipmentItemRelation.SaveItemInEquiment(eqCode,itemIdString);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return;
                }
                $("#<%=txtEqCode.ClientID%>").val(ajax.value);                
            }
            else {
                /*从机种设备关系表(Basal_EquipmentItemRelation)中删除数据*/
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipmentItemRelation.RemoveItemOutEquipment(eqCode,itemIdString);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return;
                }
            }
                       
            if(equipmentItemRelationId==-1){                    
                var iframe1 = document.getElementById("fromChooseList1");
                iframe1.src = "ItemPreSpareParts.aspx?EqCode=" + eqCode + "";

                var iframe2 = document.getElementById("IfrHasChooseList");
                iframe2.src = "ItemInSpareParts.aspx?EqCode=" + eqCode + "";
            }
            else{
                window.frames[0].window.document.forms[0].submit();
                window.frames[1].window.document.forms[0].submit(); 
            }  
        }

    </script>
</asp:Content>
