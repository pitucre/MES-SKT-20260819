<%@ Page Language="C#" MasterPageFile="~/Masters/EditHeadMaster.master" AutoEventWireup="True"
    CodeBehind="SteelMeshEdit.aspx.cs" Inherits="SKT.LeanMES.Web.SteelMesh.SteelMeshEdit"
    Title="Edit SteelMesh" %>

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
            <td class="Label3">
                设备名称<em>*</em>
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtEquipmentName" runat="server" CssClass="TextBox" Width="100px"
                    MaxLength="50" IsRequired="1"></asp:TextBox>
            </td>
            <td class="Label3">
                设备编号<em>*</em>
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtEquipmentCode" runat="server" CssClass="TextBox" Width="100px"
                    MaxLength="50" IsRequired="1"></asp:TextBox>
            </td>
            <td class="Label3">
                设备类型<em>*</em>
            </td>
            <td class="Field3">
                <asp:DropDownList ID="ddlEquipmentType" runat="server" Width="100" IsRequired="1">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="Label3">
                设备型号<em>*</em>
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtEquipmentModel" runat="server" CssClass="TextBox" Width="100px"
                    MaxLength="50" IsRequired="1"></asp:TextBox>
            </td>
            <td class="Label3">存放位置<em>*</em>
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtPosition" runat="server" CssClass="TextBox" MaxLength="50" Width="140px"
                    Enabled="false" ClientIDMode="Static" IsRequired="1">
                </asp:TextBox>
                <input type="button" value="..." class="ButtonBox" onclick="selectPosition()" />
                <asp:HiddenField ID="HiddenPosition" runat="server" ClientIDMode="Static" />
            </td>
            <td class="Label3">
                状态
            </td>
            <td class="Field3">
                <asp:DropDownList ID="ddlStatus" ClientIDMode="Static" Enabled="false" runat="server" Width="100">
                    <asp:ListItem Value="0" Selected="True">暂存</asp:ListItem>
                    <asp:ListItem Value="1">检验合格</asp:ListItem>
                    <asp:ListItem Value="2">检验不合格</asp:ListItem>
                    <asp:ListItem Value="3">在库</asp:ListItem>
                    <asp:ListItem Value="4">在产线</asp:ListItem>
                    <asp:ListItem Value="5">已上线</asp:ListItem>
                    <asp:ListItem Value="6">已下线</asp:ListItem>
                    <asp:ListItem Value="7">已清洗</asp:ListItem>
                    <asp:ListItem Value="8">已报废</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="Label3">
                <%= Resources.lang.thick%>
            </td>
            <td class="Field3" style="display:none">
                <asp:TextBox ID="txtThick" runat="server" CssClass="TextBox" MaxLength="10" Text="0" Width="100px" isNumber="1" ></asp:TextBox>
            </td>
            <td class="Field3" >
                <asp:TextBox ID="txtMKLand" runat="server" CssClass="TextBox"  Text="0" Width="100px" ></asp:TextBox>
            </td>
            <td class="Label3">
                供应商<em>*</em>
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtVendorName" runat="server" CssClass="TextBox" Enabled="false"
                    Width="85px" IsRequired="1"></asp:TextBox>
                <input type="button" id="btnVendorName" class="ButtonBox" value="..." title="选择厂商"
                    onclick="selectVendorName();" />
                <asp:HiddenField ID="hdnVendorCode" runat="server" Value="-1" />
            </td>
            <td class="Label3">
                <%= Resources.lang.VendorBarNo %>
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtVendorBarcodeNum" runat="server" CssClass="TextBox" MaxLength="100"
                    Width="100px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label3">
                <%= Resources.lang.EnterFactoryDate%><em>*</em>
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtFactoryDate" runat="server" CssClass="DateTimeBox" IsRequired='1'
                    Width="90px"></asp:TextBox>
            </td>
            <td class="Label3">
                <%= Resources.lang.ProduceDate%><em>*</em>
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtProduceDate" runat="server" CssClass="DateTimeBox" IsRequired='1'
                    Width="95px"></asp:TextBox>
            </td>
            <td class="Label3">
                线别
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtlineName" runat="server" CssClass="TextBox" Enabled="false" Width="85px"></asp:TextBox><input
                    type="button" id="btnChooseLine" class="ButtonBox" value="..." title="选择线别" onclick="selectLine(21);" />
                <asp:HiddenField ID="hdLineId" runat="server" Value="-1" />
            </td>
        </tr>
        <tr>
            <td class="Label3">
                <%= Resources.lang.StandarLive%>（次数）
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtStandarLive" runat="server" CssClass="TextBox" Text="100000" Width="100px"
                    MaxLength="15" onchange="formatNum(this)"></asp:TextBox>
            </td>
            <td class="Label3">
                <%= Resources.lang.UserCount%>
            </td>
            <td class="Field3">
                <asp:Label ID="lblUseCount" runat="server" Text="0"></asp:Label>
            </td>
            <td class="Label3">
                保养预警
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtWarningCount" runat="server" CssClass="TextBox" Text="0" MaxLength="15"
                    Width="100px" onchange="formatNum(this)"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label3">
                当前位置
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtCurPosition" runat="server" CssClass="TextBox" Width="100px"
                    MaxLength="50"></asp:TextBox>
            </td>
            <td class="Label3">
                属性<em>*</em>
            </td>
            <td class="Field3">
                <asp:DropDownList ID="ddlAttribute" ClientIDMode="Static"  runat="server" Width="110" IsRequired="1">
                    <asp:ListItem Value="钢网">钢网</asp:ListItem>
                    <asp:ListItem Value="有铅">有铅</asp:ListItem>
                    <asp:ListItem Value="无铅">无铅</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td class="Label3" style="display:none;">
                面别
            </td>
            <td class="Field3" style="display:none;">
                <asp:DropDownList ID="ddlNoodles" ClientIDMode="Static" runat="server" Width="100">
                    <asp:ListItem Text="请选择" Value="" Selected="True"></asp:ListItem>
                    <asp:ListItem Text="T" Value="T" ></asp:ListItem>
                    <asp:ListItem Text="B" Value="B"></asp:ListItem>
                    <asp:ListItem Text="TB" Value="TB"></asp:ListItem>
                </asp:DropDownList>
            </td>
            <td class="Label3" style="display:none;">
                在库状态
            </td>
            <td class="Field3" style="display:none;">
                <asp:DropDownList ID="ddlInOrOut" ClientIDMode="Static" runat="server" Width="100">
                    <asp:ListItem Text="已入库" Value="1" Selected="True"></asp:ListItem>
                    <asp:ListItem Text="在产线" Value="0"></asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
         <tr>
            <td class="Label3">
              PCB型号
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtPCBModel" runat="server" CssClass="TextBox"  Width="160px"
                     ></asp:TextBox>
            </td>
            <td class="Label3">
               使用工艺
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtMKUsingTechnology" runat="server" CssClass="TextBox"  Width="160px"
                    ></asp:TextBox>
            </td>
            <td class="Label3">
                使用类型
            </td>
            <td class="Field3">
               <asp:TextBox ID="txtMKUsingType" runat="server" CssClass="TextBox"  Width="100px"
                    ></asp:TextBox>
            </td>
        </tr>
         <tr>
            <td class="Label3">
              工艺要求
            </td>
            <td class="Field3">
              <asp:TextBox ID="txtMKTechnologyAsk" runat="server" CssClass="TextBox"  Width="160px"
                    ></asp:TextBox>
            </td>
            <td class="Label3">
            </td>
            <td class="Field3">   
            </td>
            <td class="Label3">
            </td>
            <td class="Field3">
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.Remark%>
            </td>
            <td class="Field2" colspan="5">
                <asp:TextBox ID="txtRemark" runat="server" CssClass="TextArea" TextMode="MultiLine"
                    MaxLength="50" Width="99%" Height="25px"></asp:TextBox>
            </td>
        </tr>
        <tr style="display:none;">
            <td class="Label3" style="display:none;">
                清洗状态
            </td>
            <td class="Field3" style="display:none;">
                <asp:DropDownList ID="ddlIsClear" ClientIDMode="Static" runat="server" Width="100">
                    <asp:ListItem Text="已清洗" Value="1" Selected="True"></asp:ListItem>
                    <asp:ListItem Text="未清洗" Value="0"></asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
    </table>
    <asp:HiddenField ID="hdnIsNeedAdd" runat="server" Value="0" /><!-- 0表示要继续保存,1表示可刷新 -->
    <script type="text/javascript">
        var Id = <%= Request.QueryString["ID"] == null ? -1 : Convert.ToInt32(Request.QueryString["ID"].ToString())%>;
        var temp=0;
        $(function (){
            if(Id!=-1){//编辑
                $("#btnVendorName").attr("disabled",true);
                //$("#<%=this.ddlEquipmentType.ClientID%>").css
            }
        })
        function formatNum(obj){
            var value = $(obj).val().replace(/,/g,"");
            if(isNaN(value)) {
                $(obj).focus();
                $(obj).select();                
                alert("只能是数字类型");                
            }
            else{
                $(obj).val(toThousands(value));
            }
        }

        function toThousands(num) {
            return (num || 0).toString().replace(/(\d)(?=(?:\d{3})+$)/g, '$1,');
        }

        /*保存数据*/ 
        function Save() { 
            var txtEquipmentName = $.trim($("#<%=this.txtEquipmentName.ClientID%>").val());
            var txtEquipmentCode = $.trim($("#<%=this.txtEquipmentCode.ClientID%>").val());
            var ddlEquipmentType = $.trim($("#<%=this.ddlEquipmentType.ClientID%>").val());
            var txtEquipmentModel = $.trim($("#<%=this.txtEquipmentModel.ClientID%>").val());
            var txtPosition = $.trim($("#<%=this.HiddenPosition.ClientID%>").val());
            var txtRemark = $.trim($("#<%=this.txtRemark.ClientID%>").val());
            var ddlStatus = $.trim($("#<%=this.ddlStatus.ClientID%>").val());
            var txtThick = $.trim($("#<%=this.txtThick.ClientID%>").val());
            var hdnVendorCode = $("#<%=this.hdnVendorCode.ClientID%>").val();
            var txtVendorBarcodeNum = $.trim($("#<%=this.txtVendorBarcodeNum.ClientID%>").val());
            var txtFactoryDate = $("#<%=this.txtFactoryDate.ClientID%>").val();
            var txtProduceDate = $("#<%=this.txtProduceDate.ClientID%>").val();
            var hdLineId = $("#<%=this.hdLineId.ClientID%>").val();
            var txtStandarLive = $("#<%=this.txtStandarLive.ClientID%>").val().replace(/,/g,"");
            var lblUseCount = $("#<%=this.lblUseCount.ClientID%>").text().replace(/,/g,"");
            var txtWarningCount  = $("#<%=this.txtWarningCount.ClientID%>").val().replace(/,/g,"");
            var lblCurPosition = $("#<%=this.txtCurPosition.ClientID%>").val();
            var ddlInOrOut = $.trim($("#<%=this.ddlInOrOut.ClientID%>").val());
            var ddlIsClear = $.trim($("#<%=this.ddlIsClear.ClientID%>").val());
            var txtPCBModel= $.trim($("#<%=this.txtPCBModel.ClientID%>").val());
            var txtMKUsingTechnology= $.trim($("#<%=this.txtMKUsingTechnology.ClientID%>").val());
            var txtMKUsingType= $.trim($("#<%=this.txtMKUsingType.ClientID%>").val());
            var txtMKTechnologyAsk= $.trim($("#<%=this.txtMKTechnologyAsk.ClientID%>").val());
            var txtMKLand= $.trim($("#<%=this.txtMKLand.ClientID%>").val());
            var ddlNoodles=$.trim($("#<%=this.ddlNoodles.ClientID%>").val());
            var ddlAttribute = $.trim($("#<%=this.ddlAttribute.ClientID%>").val());
            if(isNaN(txtWarningCount)){
                alert("预警次数必须是数字");
                $("#<%=this.txtWarningCount.ClientID%>").focus();
                $("#<%=this.txtWarningCount.ClientID%>").select();                
                return;
            }

            if(isNaN(txtStandarLive)){                
                alert("标准寿命次数必须是数字");
                $("#<%=this.txtStandarLive.ClientID%>").focus();
                $("#<%=this.txtStandarLive.ClientID%>").select();
                return;
            }

            if(parseInt(txtWarningCount)> parseInt(txtStandarLive)){
                alert("预警次数要小于标准寿命次数");
                return;
            }
            
            
            /*表单验证*/
            /*如需表单验证可以此处处理验证 开始*/
            var entity = {};
            entity.EquipmentId = Id;
            entity.StationId = -1;
            entity.EquipmentName = txtEquipmentName;
            entity.EquipmentCode = txtEquipmentCode;
            entity.EquipmentModel = txtEquipmentModel;
            entity.EquipmentTypeId = ddlEquipmentType;
            entity.LineId = hdLineId;
            entity.Remark = txtRemark;
            entity.VenCode = hdnVendorCode;
            entity.Thick = parseFloat(txtThick);
            entity.Position = txtPosition;
            entity.VendorBarcode = txtVendorBarcodeNum;
            entity.Status = ddlStatus;
            entity.SequenceNo = -1;
            entity.FactoryDate = new Date(txtFactoryDate);
            entity.ProduceDate = new Date(txtProduceDate);  
            entity.StandarLive = txtStandarLive;
            entity.UseCount = lblUseCount;
            entity.WarningCount = txtWarningCount;
            entity.CurPosition = lblCurPosition;
            entity.InOrOut = ddlInOrOut;
            entity.IsClear = ddlIsClear;
            entity.PCBModel= txtPCBModel;
            entity.MKUsingTechnology= txtMKUsingTechnology;
            entity.MKUsingType= txtMKUsingType;
            entity.MKTechnologyAsk= txtMKTechnologyAsk;
            entity.MKLand= txtMKLand;
            entity.EquNoodles="";
            entity.Attribute=ddlAttribute;
            //var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipment.EquipmentEdit(entity);

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipment.EquipmentEditNew(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            
            alert('<%=Resources.Messages.SaveInSuccess%>')
            if ($("#<%= hdnIsNeedAdd.ClientID %>").val() == '1') {
                var type= '<%= Request.QueryString["Type"] == null ? "" : Request.QueryString["Type"].ToString() %>'
                openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SteelMesh/SteelMeshEdit.aspx?name=SteelMeshEdit&ID=" + ajax.value + "&Type=" + type;
                location.href = openWinUrl;
            }
            else {
                window.parent.UpdateList(txtEquipmentName);
            }
        }
        //选择厂商
        function selectVendorName() {
            temp=1;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=34&Multiple=false&rnd=" + Math.random(), width: 650, height:350 });
        }
        function selectLine(flag){
            temp=flag;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=21&Multiple=false&rnd=" + Math.random(), width: 650, height:350 });
        }
         /*存放位置*/
        function selectPosition() {
            temp = 3;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=609&Multiple=false&rnd=" + Math.random(), width: 650, height: 350 });
        }

        function getChooseValue(list) {
            if (temp == 1) {
                $("#<%=this.txtVendorName.ClientID %>").val(list[0][2]);
                $("#<%=this.hdnVendorCode.ClientID %>").val(list[0][1]);
            } else if (temp == 21) {
                $("#<%=this.txtlineName.ClientID %>").val(list[0][1]);
                $("#<%=this.hdLineId.ClientID %>").val(list[0][0]);
            } else if (temp == 3) {

                $("#<%=this.txtPosition.ClientID %>").val(list[0][1]);
                $("#<%=this.HiddenPosition.ClientID %>").val(list[0][0]);
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
            SelectMethod="GetAll" SelectCountMethod="GetCount">
            <SelectParameters>
                <asp:Parameter Name="searchSettings" Type="Object" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
        <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
        <script type="text/javascript">
            loadfloatButtons("bomCompList");
            isMultiple = true;
            $(function () {
                /*comment by Hanson Lei 2016-10-12 验证厚度输入类型并保留两位小数(四舍五入) */
                $("#<%=this.txtThick.ClientID%>").blur(function () {
                    var thickVal = $(this).val();
                    if ($.trim(thickVal) != "") {
                        if (!isNaN(thickVal)) { $(this).val(parseFloat(thickVal).toFixed(2)); }
                        //else { $(this).focus(); $(this).val('');}
                    }
                });

                //入场日期设为只读
                $(".DateTimeBox").attr("readonly", "readonly");
            });

            function AddComponent() {
                if (Id == -1) {
                    alert("请先保存信息");
                    return false;
                }

                openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SteelMesh/SteelItemEdit.aspx?name=SteelMeshEdit&ID=" + Id;
                dialog({ title: "增加钢网,刮刀产品", src: openWinUrl, width: 700, height: 400 });
            }

            function RemoveComponent() {
                if (Id == -1) {
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

                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipment.DeleteItemSteel(idStr);
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
