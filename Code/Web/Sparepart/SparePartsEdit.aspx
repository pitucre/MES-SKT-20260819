<%@ Page Language="C#" MasterPageFile="~/Masters/EditHeadMaster.master" AutoEventWireup="True"
    CodeBehind="SparePartsEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Sparepart.SparePartsEdit"
    Title="Edit SpareParts" %>

<%@ MasterType VirtualPath="~/Masters/EditHeadMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="infoTips" colspan="6">
                <%=Resources.Messages.WithAsteriskIsRequired %>
            </td>
        </tr>
        <tr class="clear5">
        </tr>
        <tr>
            <td class="Label3">工具名称<em>*</em>
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtToolName" IsRequired='1' runat="server" CssClass="TextBox"  Width="130px"></asp:TextBox>
            </td>
            <td class="Label3">工具编号<em>*</em>
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtToolCode" IsRequired='1' runat="server" CssClass="TextBox"  Width="130px"></asp:TextBox>
            </td>
            <td class="Label3">存放库位
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtPartLocation" runat="server" CssClass="TextBox" ClientIDMode="Static"  Width="130px">
                </asp:TextBox>
                <input type="button" value="..." class="ButtonBox" onclick="selectPosition()" />
                <asp:HiddenField ID="HiddenPosition" runat="server" ClientIDMode="Static" />
            </td>
        </tr>
        <tr>
            <td class="Label3">
                <%= Resources.lang.PartStandard %>
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtPartStandard" runat="server" CssClass="TextBox" MaxLength="200"  Width="130px"></asp:TextBox>
            </td>
            <td class="Label3">工具类别<em>*</em>
            </td>
            <td class="Field3">
                <asp:TextBox runat="server" ID="txtPartCategory" CssClass="TextBox" Enabled="false" IsRequired="1"  Width="130px"></asp:TextBox>
                <input type="button" value="..." class="ButtonBox" onclick="selectEqType()" />
                <asp:HiddenField ID="HiddenEquipmentTypeId" runat="server" ClientIDMode="Static" />
            </td>
            <td class="Label3">蚀刻编号
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtFactory"  runat="server" CssClass="TextBox"  Width="130px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label3">
                <%= Resources.lang.EnterFactoryDate%><em>*</em>
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtFactoryDate" runat="server" CssClass="DateTimeBox" IsRequired='1'
                    Width="130px"></asp:TextBox>
            </td>
            <td class="Label3">
                <%= Resources.lang.ProduceDate%><em>*</em>
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtProduceDate" runat="server" CssClass="DateTimeBox" IsRequired='1'
                    Width="130px"></asp:TextBox>
            </td>
            <td class="Label3">供应商
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtSupplier" 
                    runat="server" CssClass="TextBox"  Width="130px"></asp:TextBox>
                <input type="button" value="..." class="ButtonBox" onclick="selectSupplier1()" />
            </td>
        </tr>
        <tr>
            <td class="Label3">
                <%= Resources.lang.PartUnit %>
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtPartUnit" runat="server" CssClass="TextBox" Enabled="false"   Width="130px"></asp:TextBox>
                <input type="button" id="btnSelecUnit" class="ButtonBox" value="..." onclick="selectUnit()" />
                <asp:HiddenField ID="hdnSelectUnitId" runat="server" Value="-1" />
            </td>
            <td class="Label3">
               初始数量<em>*</em>
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtPartQty" IsRequired='1' value="1" MinValue='0' IsNumber='1' MaxLength="10"  Width="130px"
                    runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">
                使用期限<em>*</em>
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtServiceLife" runat="server" CssClass="DateTimeBox" IsRequired='1'
                    Width="130px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label3">
                <%= Resources.lang.Remark %>
            </td>
            <td class="Field3" colspan="5">
                <asp:TextBox ID="txtRemark" runat="server" CssClass="TextArea" TextMode="MultiLine"
                    MaxLength="200" Width="99%"></asp:TextBox>
            </td>
        </tr>
    </table>
    <asp:HiddenField ID="hdnIsNeedAdd" runat="server" Value="0" /><!-- 0表示要继续保存,1表示可刷新 -->
    <script type="text/javascript">
        //var Id = <%= Request.QueryString["ID"] == null ? -1 : Convert.ToInt32(Request.QueryString["ID"].ToString())%>;
        var oldID=-1;//复制新增保留产品信息，记录复制源的ID
        var partsId = "";
        <% if (Request.QueryString["ID"] == null)
        { %>
        partsId = -1;
    <% }
        else
        { %>
        partsId = <%= Request.QueryString["ID"] %>;
        <% } %>

        $(function () {
            //设置编辑时，某些内容不可变更
            if (partsId!=-1) {
                $("#<%=this.txtToolName.ClientID%>").attr("disabled","true");
                $("#<%=this.txtToolCode.ClientID%>").attr("disabled","true");
                $("#<%=this.txtFactoryDate.ClientID%>").attr("disabled","true");
                $("#<%=this.txtProduceDate.ClientID%>").attr("disabled","true");
                $("#<%=this.txtPartQty.ClientID%>").attr("disabled","true");
                $("#<%=this.txtServiceLife.ClientID%>").attr("disabled","true");
            }
            
        });

        /*保存数据*/
        function Save() {
            //复制新增保存
            if (oldID!=-1) {
                var ajax =SKT.LeanMES.Web.AjaxServices.AjaxSparepart.CopyEditPart(Getentity(),oldID);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }

                alert('<%=Resources.Messages.SaveInSuccess%>')
                if ('<%=Request.QueryString["inMenu"] %>' == "true") {
                    openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Sparepart/SparePartsEdit.aspx?name=Production_SparepartEdit&ID=" + parseInt(ajax.value);
                    location.href = openWinUrl;
                }
                else {
                    window.parent.Refresh();
                }
            }
            //正常新增保存
            else
            {
                var ajax =SKT.LeanMES.Web.AjaxServices.AjaxSparepart.EditPart(Getentity());
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }

                alert('<%=Resources.Messages.SaveInSuccess%>')
                if ('<%=Request.QueryString["inMenu"] %>' == "true") {
                    openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Sparepart/SparePartsEdit.aspx?name=Production_SparepartEdit&ID=" + parseInt(ajax.value);
                    location.href = openWinUrl;
                }
                else {
                    window.parent.Refresh();
                }
            }
        }

       function ContinuedSave() {
           //if (oldID!=-1) {
           //    alert('不允许连续使用复制新增，请正常保存后在操作！');
           //    return;
           //}
           $("#<%=this.txtToolName.ClientID%>").attr("disabled",false);
           $("#<%=this.txtToolCode.ClientID%>").attr("disabled",false);
           $("#<%=this.txtFactoryDate.ClientID%>").attr("disabled",false);
           $("#<%=this.txtProduceDate.ClientID%>").attr("disabled",false);
           $("#<%=this.txtPartQty.ClientID%>").attr("disabled",false);
           $("#<%=this.txtServiceLife.ClientID%>").attr("disabled",false);
            var txtPartName = $.trim($("#<%=this.txtToolName.ClientID%>").val());
            var txtPartNickName = $.trim($("#<%=this.txtToolCode.ClientID%>").val());
          
            var txtPartCategory = $.trim($("#<%=this.txtPartCategory.ClientID%>").val());
          if (txtPartName == "" || txtPartNickName == "" || txtPartCategory=="") {
                alert("带*号不可为空！");
                return false;
            }
            var ajax =SKT.LeanMES.Web.AjaxServices.AjaxSparepart.EditPart(Getentity());
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
           alert('<%=Resources.Messages.SaveInSuccess%>');
          this.document.title = "新增工具";
           Clear();
       }

        function Getentity() {

        
            var txtPartName = $.trim($("#<%=this.txtToolName.ClientID%>").val());
            var txtPartNickName = $.trim($("#<%=this.txtToolCode.ClientID%>").val());
          
            var txtPartCategory = $.trim($("#<%=this.txtPartCategory.ClientID%>").val());
            var txtPartLocation = $.trim($("#<%=this.txtPartLocation.ClientID%>").val());
          
            var txtPartStandard = $.trim($("#<%=this.txtPartStandard.ClientID%>").val());
       
            var txtPartQty = $("#<%=this.txtPartQty.ClientID%>").val();
            var txtPartUnit = $("#<%=this.txtPartUnit.ClientID%>").val();
            var txtRemark = $.trim($("#<%=this.txtRemark.ClientID%>").val());
            var txtFactoryDate = $("#<%=this.txtFactoryDate.ClientID%>").val();
            var txtProduceDate = $("#<%=this.txtProduceDate.ClientID%>").val();
            var txtServiceLife = $("#<%=this.txtServiceLife.ClientID%>").val();
        
            var entity = {};

            entity.PartId = partsId;
            entity.PartName = txtPartName;
            entity.PartNickName = txtPartNickName;
            entity.PartCategory = txtPartCategory;
            entity.PartMachine = "";
            entity.PartLocation = txtPartLocation;
            entity.PartStandard = txtPartStandard;
            entity.PartParam = "";
            entity.PartQty = parseFloat(txtPartQty);
            entity.PartUnit = txtPartUnit;
            entity.FactoryDate = new Date(txtFactoryDate);
            entity.ProduceDate = new Date(txtProduceDate);  
            entity.ServiceLife = new Date(txtServiceLife);  
            entity.VenName= $("#<%=this.txtFactory.ClientID %>").val();
            entity.SupplierName= $("#<%=this.txtSupplier.ClientID %>").val();
            entity.Remark = txtRemark;
            return entity;
        }

        function CopySave() {
            //if (oldID!=-1) {
            //    alert('不允许连续使用复制新增，请正常保存后在操作！');
            //    return;
            //}
            $("#<%=this.txtToolName.ClientID%>").attr("disabled",false);
            $("#<%=this.txtToolCode.ClientID%>").attr("disabled",false);
            $("#<%=this.txtFactoryDate.ClientID%>").attr("disabled",false);
            $("#<%=this.txtProduceDate.ClientID%>").attr("disabled",false);
            $("#<%=this.txtPartQty.ClientID%>").attr("disabled",false);
            $("#<%=this.txtServiceLife.ClientID%>").attr("disabled",false);
          var txtPartName = $.trim($("#<%=this.txtToolName.ClientID%>").val());
            var txtPartNickName = $.trim($("#<%=this.txtToolCode.ClientID%>").val());
          
            var txtPartCategory = $.trim($("#<%=this.txtPartCategory.ClientID%>").val());
          if (txtPartName == "" || txtPartNickName == "" || txtPartCategory=="") {
                alert("带*号不可为空！");
                return false;
            }
            var ajax =SKT.LeanMES.Web.AjaxServices.AjaxSparepart.EditPart(Getentity());
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert('<%=Resources.Messages.SaveInSuccess%>');
           oldID=partsId;
           partsId = -1;
          this.document.title = "新增工具";
          $("#<%=this.txtToolName.ClientID %>").val("");
          $("#<%=this.txtToolCode.ClientID %>").val("");
       }

        function Clear() {
            $("#<%=this.txtToolName.ClientID%>").val("");
            $("#<%=this.txtToolCode.ClientID%>").val("");
          
            $("#<%=this.txtPartCategory.ClientID%>").val("");
            $("#<%=this.txtPartLocation.ClientID%>").val("");
            $("#<%=this.txtSupplier.ClientID %>").val("");
            $("#<%=this.txtFactory.ClientID %>").val("");
            $("#<%=this.txtPartStandard.ClientID%>").val("");
            $("#<%=this.txtRemark.ClientID%>").val("");
            $("#<%=this.txtPartQty.ClientID%>").val("");
            $("#<%=this.hdnSelectUnitId.ClientID%>").val("");
            partsId=-1;
        }


        /*选择供应商*/
        function selectSupplier1() {
            chooseFlag = 34;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=34&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }
        /*选择供应商*/
        function selectSupplier2() {
            chooseFlag = 35;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=34&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }
        /*存放位置*/
        function selectPosition() {
            chooseFlag = 1;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=609&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }
        //选择单位
        function selectUnit() {
            chooseFlag = 2;
            SearchCondition = "  DicProperty ='Unit'";
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=3&SearchCondition=" + SearchCondition +"&Multiple=false&rnd=" + Math.random(), width: 600, height: 400 });
        }

       function selectEqType() {
           var openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/EquimentTypeDialog.aspx?name=Equipment_EquimentTypeDialog&controlId=3";
            dialog({ title: "工具类别", src: openWinUrl, width: 255, height: 350 });
       }

        SetValue = function (list) {
                closeDialog();
                $("#HiddenEquipmentTypeId").val(list[0].id);
                $("#<%=txtPartCategory.ClientID%>").val(list[0].name);
         }
        function getChooseValue(list) {
            if(chooseFlag==1){
                $("#<%=this.txtPartLocation.ClientID %>").val(list[0][1]);
                $("#<%=this.HiddenPosition.ClientID %>").val(list[0][0]);
            }else if(chooseFlag==34){
            $("#<%=this.txtSupplier.ClientID %>").val(list[0][2]);
             
            }else if(chooseFlag==35){
                  $("#<%=this.txtFactory.ClientID %>").val(list[0][2]);
            }else{
                $("#<%=this.txtPartUnit.ClientID %>").val(list[0][2]);
               $("#<%=this.hdnSelectUnitId.ClientID %>").val(list[0][2]);
            }
}
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:Panel ID="plContent2" runat="server">
        <div class="ListTableTitle">
            <%=Resources.lang.Item%>&nbsp;<span id="bomCompList"></span>
        </div>
        <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1">
            <Columns>
                <%-- To Do --%>
                <asp:BoundField DataField="ItemCode" HeaderText="<%$ Resources:lang, ItemCode %>" />
                <asp:BoundField DataField="ItemName" HeaderText="<%$ Resources:lang, ItemName %>" />
                <asp:BoundField DataField="layout" HeaderText="面别" />
                <asp:BoundField DataField="ItemSpec" HeaderText="产品规格" />
            </Columns>
        </asp:GridView>
        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
            MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.SteelItem.BLL.SteelItem"
            SelectMethod="GetAll_Spare" SelectCountMethod="GetCount">
            <SelectParameters>
                <asp:Parameter Name="searchSettings" Type="Object" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
        <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
        <script type="text/javascript">
            loadfloatButtons("bomCompList");
            //isMultiple = true;
            $(function () {
                //入场日期设为只读
                $(".DateTimeBox").attr("readonly", "readonly");
            });

            function AddComponent() {
                if (partsId == -1) {
                    alert("请先保存信息");
                    return false;
                }

                openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SteelMesh/SteelItemEdit.aspx?name=SpareMeshEdit&ID=" + partsId;
                dialog({ title: "增加工具产品", src: openWinUrl, width: 700, height: 400 });
            }

            function RemoveComponent() {
                if (partsId == -1) {
                    alert("请先保存信息");
                    return false;
                }

                var idStr = getOneRecordId();
                if (idStr == "") {
                    return false;
                }

                if (!confirm("删除关联产品的记录,会影响SMT投入的过站!")) {
                    return false;
                }

                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipment.DeleteItemSpareInfo(idStr);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }

                alert("删除成功");
                document.forms[0].submit();
            }

            function refush() {
                document.forms[0].submit();
            }

            function closeOpen() {
                closeDialog();
            }
        </script>
    </asp:Panel>
</asp:Content>