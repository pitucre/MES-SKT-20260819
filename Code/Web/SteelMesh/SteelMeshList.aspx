<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="True"
    CodeBehind="SteelMeshList.aspx.cs" Inherits="SKT.LeanMES.Web.SteelMesh.SteelMeshList"
    Title="SteelMesh List Page" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <style type="text/css">
        .hidden{
            display:none;
        }
    </style>
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">
                设备编号
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtSteelMeshCode" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">
                设备名称
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtSteelMeshName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">
                当前状态
            </td>
            <td class="Field3">
                <asp:DropDownList runat="server" ID="ddlSteelStatus">
                    <asp:ListItem Value="-1">请选择</asp:ListItem>
                    <asp:ListItem Value="0">暂存</asp:ListItem>
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
                产品编码
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtMainItemCode" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox><input
                    type="button" id="btnSelectItem" class="ButtonBox" value="..." title="<%=Resources.lang.ChooseItem %>"
                    onclick="ChoosePage();" /> 
                <asp:HiddenField ID="hdnMainItemId" runat="server" Value="-1" />
            </td>
             <td class="Label3"><%= Resources.lang.Layout %></td>
            <td class="Field3">
                <asp:DropDownList ID="ddlLayout" runat="server" >   
                     <asp:ListItem Value="-1">请选择</asp:ListItem>
                    <asp:ListItem Value="T">T</asp:ListItem>
                    <asp:ListItem Value="B">B</asp:ListItem>
                    <asp:ListItem Value="TB">TB</asp:ListItem>                
                </asp:DropDownList>
            </td>
            <td class="Label3">
                产线
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtLineName" runat="server" CssClass="TextBox" ClientIDMode="Static" ></asp:TextBox><input 
                    type="button" id="btnSelectLine" class="ButtonBox" value="..." title="Select" onclick="ChooseLine()" />
            </td>
        </tr>
        <tr>
             <td class="Label3">
                PCB型号
            </td>
            <td class="Field3" colspan="5">
                <asp:TextBox ID="txtPCBModel" runat="server" CssClass="TextBox" ClientIDMode="Static" ></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" OnRowDataBound="GridView1_RowDataBound" style="table-layout:fixed;word-wrap:break-word;word-break:break-all">
        <Columns>
            <%-- To Do --%>
           <asp:BoundField DataField="EquipmentCode" HeaderText="设备编号" HeaderStyle-Width="100px"/>
           <asp:BoundField DataField="EquipmentName" HeaderText="设备名称" HeaderStyle-Width="100px"/>
           <asp:BoundField DataField="EquipmentTypeName" HeaderText="设备类型" HeaderStyle-Width="100px"/>
           <asp:BoundField DataField="PCBModel" HeaderText="PCB型号" HeaderStyle-Width="100px"/>
           <asp:BoundField DataField="EquNoodles" HeaderText="面别" HeaderStyle-Width="100px"/>
           <asp:BoundField DataField="UsableCount" HeaderText="可使用次数" HeaderStyle-Width="100px"/>
           <asp:BoundField DataField="StandarLive" HeaderText="<%$ Resources:lang, StandarLive %>" HeaderStyle-Width="100px"/>
           <asp:BoundField DataField="UseCount" HeaderText="<%$ Resources:lang, UserCount %>" HeaderStyle-Width="100px"/>
           <asp:BoundField DataField="PositionName" HeaderText="存放位置" HeaderStyle-Width="80px"/>
           <asp:BoundField DataField="CurPosition" HeaderText="当前位置" HeaderStyle-Width="80px"/>
           <asp:BoundField DataField="StatusDesc" HeaderText="当前状态" HeaderStyle-Width="100px" ItemStyle-CssClass="StatusDesc"/>
           <asp:BoundField DataField="InspectionStatusName" HeaderText="检验状态" HeaderStyle-Width="100px"/>
           <asp:BoundField DataField="InspectionUserName" HeaderText="检验人" HeaderStyle-Width="80px"/>
           <asp:BoundField DataField="StartInspectionDateTime" HeaderText="检验开始时间" HeaderStyle-Width="180px"/>
           <asp:BoundField DataField="InspectionDateTime" HeaderText="检验结束时间" HeaderStyle-Width="180px"/>
           <asp:BoundField DataField="VendorName" HeaderText="供应商" HeaderStyle-Width="100px"/>
           <asp:BoundField DataField="VendorBarcode" HeaderText="供应商条码编号" HeaderStyle-Width="100px"/>
           <asp:BoundField DataField="MKLand" HeaderText="<%$ Resources:lang, Thick %>" HeaderStyle-Width="100px"/>
           <asp:BoundField DataField="FactoryDate" HeaderText="<%$ Resources:lang, EnterFactoryDate %>"  DataFormatString="{0:yyyy-MM-dd}" HeaderStyle-Width="100px"/>
           <asp:BoundField DataField="CreateBy" HeaderText="<%$ Resources:lang, CreateBy %>" HeaderStyle-Width="80px"/>
           <asp:BoundField DataField="CreateDateTime" HeaderText="<%$ Resources:lang, CreateDateTime %>" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" HeaderStyle-Width="180px"/>  
           <asp:BoundField DataField="ParentTypeName" HeaderText="上级设备类型" HeaderStyle-Width="100px" ItemStyle-CssClass="ParentTypeName" />
            <asp:BoundField DataField="ParentTypeId" HeaderText="ParentTypeId">
                <HeaderStyle CssClass="hidden"/>
                <ItemStyle CssClass="hidden hide"/>
                <FooterStyle CssClass="hidden" />
           </asp:BoundField >
           <asp:BoundField DataField="ModifyBy" HeaderText="<%$ Resources:lang, ModifyBy %>" HeaderStyle-Width="80px" />            
            <asp:BoundField DataField="ModifyDateTime" HeaderText="<%$ Resources:lang, ModifyDateTime %>"   HeaderStyle-Width="100px" DataFormatString="{0:yyyy-MM-dd}" />
            <asp:BoundField DataField="Remark" HeaderText="<%$ Resources:lang, Remark %>" HeaderStyle-Width="80px" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Equipment.BLL.Equipments"
        SelectMethod="GetAllNew" SelectCountMethod="GetCount"> 
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script type="text/javascript">
        isMultiple = false;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");
        $(function () {
            gridCellsChangeNo = true;
        });
        function AddKnife() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SteelMesh/SteelMeshEdit.aspx?name=SteelAddKnife&ID=-1&Type=Knife";
            dialog({ title: "<%=Resources.Pages.SteelAddKnife %>", src: openWinUrl, width: 800, height: 480 });
        }

        function AddSteel() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SteelMesh/SteelMeshEdit.aspx?name=SteelAddSteel&ID=-1&Type=Steel";
            dialog({ title: "<%=Resources.Pages.SteelAddSteel %>", src: openWinUrl, width: 800, height: 480 });   
        }
        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            //获取指定值
            var title = "";
            var parentTypeId = getOneRecordCellTextByFiled("ParentTypeId");     //父级设备类别ID
            var statusDesc = getOneRecordCellTextByFiled("StatusDesc");         //当前状态描述
            var equipmentName = getOneRecordCellTextByFiled("EquipmentName");   //设备名称

            if (statusDesc == "已报废" || statusDesc == "检验不合格") {
                alert("【" + equipmentName + "】已报废或者检验不合格，不能编辑！");
                return false;
            }
            var eqtype = "Steel"
            if (parentTypeId == "-3") {
                eqtype = "Knife";
                title = "<%=Resources.Pages.SteelEditKnife %>【" + equipmentName + "】";
            }
            else if (parentTypeId == "-2") {
                eqtype = "Steel";
                title = "<%=Resources.Pages.SteelMeshEdit %>【" + equipmentName + "】";
            }
            
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SteelMesh/SteelMeshEdit.aspx?name=SteelMeshEdit&ID=" + idStr + "&Type=" + eqtype;
            dialog({ title: title, src: openWinUrl, width: 800, height: 460 });
        }
        //报废
        function Scrap() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            //xiang.yan 2024-4-28  列取值由索引改为列明
            // 2 改为 EquipmentName
            // 11 改为 StatusDesc
            var equipmentName = getOneRecordCellTextByFiled("EquipmentName");
            var statusDesc = getOneRecordCellTextByFiled("StatusDesc");

            if (statusDesc != "在库") {
                alert(equipmentName + "不是“在库”状态，不能报废！");
                return false;
            }
            if (!confirm("是否确认报废？")) return false;
            hdnOperate.val("scrap");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }
        //查看
        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SteelMesh/SteelMeshView.aspx?name=SteelMeshView&ID=" + idStr;
            //xiang.yan 2024-4-28  列取值由索引改为列明
            // 2 改为 EquipmentName
            // 10 改为 CurPosition
            var equipmentName = getOneRecordCellTextByFiled("EquipmentName");
            var curPosition = getOneRecordCellTextByFiled("CurPosition");
            dialog({ title: mesLang("查看") + curPosition + "【" + equipmentName + "】", src: openWinUrl, width: 800, height: 380 });
        }
        function Refresh() {
            document.forms[0].submit();
        }
        function UpdateList(namestr) {
            $("#<%=this.txtSteelMeshName.ClientID %>").val(namestr);
            document.forms[0].submit();
        }
        function UpdateCodeList(namestr) {
            $("#<%=this.txtSteelMeshCode.ClientID %>").val(namestr);
            document.forms[0].submit();
        }
        //检验
        function InspectionTo() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;

            //xiang.yan 2024-4-28  列取值由索引改为列明
            // 2 改为 EquipmentName
            // 10 改为 CurPosition
            // 11 改为 StatusDesc
            var equipmentName = getOneRecordCellTextByFiled("EquipmentName");
            var curPosition = getOneRecordCellTextByFiled("CurPosition");
            var statusDesc = getOneRecordCellTextByFiled("StatusDesc");

            if (statusDesc != "暂存") {
                alert("" + statusDesc + "【" + equipmentName + "】不是暂存状态，不能进行检验！");
                return false;
            }
            var EquipmentTypeName = getOneRecordCellTextByFiled("ParentTypeName");
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SteelMesh/SteelMeshDoInspectio.aspx?name=SteelMeshDoInspectio&ID=" + idStr + "&EquipmentTypeName=" + EquipmentTypeName;
            dialog({ title: mesLang("检验") + curPosition + "【" + equipmentName + "】", src: openWinUrl, width: 800, height: 480 });
        }
        //导出
        function Import() {
            hdnOperate.val("ExportExcel");
            document.forms[0].submit();
            hdnOperate.val("");
        }
        //入库
        function In() {
            var idStr = getOneRecordId();
            if (idStr == "") {
                return false;
            }

            var parentTypeName = getOneRecordCellTextByFiled("ParentTypeName");

            var model = { Alpha2: (parentTypeName == "钢网" ? "IsSteelNetInStock" : "IsDrawKnifeInStock") };
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipment.GetSteelConfig(model);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var entity = ajax.value;
            if (!entity) {
                alert("未获取到" + parentTypeName + "出入库配置信息");
                return false;
            }
            if (entity.Alpha3 == 0) {
                alert(parentTypeName + "配置为不需要进行入库");
                return false;
            }

           // if (getOneRecordCellText(11) == "检验合格" || getOneRecordCellText(11) == "已清洗") {
                if (!confirm("是否确认入库操作？")) {
                    return false;
                }
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipment.EquiepmentInStockNew(idStr);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                alert("入库操作成功!");
                document.forms[0].submit();
            //}
            //else {
            //    alert("只有“已清洗”或“检验合格”状态的治具，可以进行入库操作，即（仅允许“已清洗”或“检验合格”的治具状态可以进行入库操作），当前状态属于其他状态的治具，禁止入库操作！")
            //    return false;
            //}
        }
        //出库
        function Out() {
            var idStr = getOneRecordId();
            if (idStr == "") {
                return false;
            }

            var parentTypeName = getOneRecordCellTextByFiled("ParentTypeName");
            var model = { Alpha2: (parentTypeName == "钢网" ? "IsSteelNetInStock" : "IsDrawKnifeInStock") };
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipment.GetSteelConfig(model);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var entity = ajax.value;
            if (!entity) {
                alert("未获取到" + parentTypeName + "出入库配置信息");
                return false;
            }
            if (entity.Alpha3 == 0) {
                alert(parentTypeName + "配置为不需要进行出库");
                return false;
            }

            //if (getOneRecordCellText(11) == "在库") {
                if (!confirm("是否确认出库操作？")) {
                    return false;
                }
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipment.EquiepmentOutStockNew(idStr);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                alert("出库操作成功!");
                document.forms[0].submit();
            //}
            //else {
            //    alert("只有“在库”状态的治具，可以进行出库操作，即（仅允许“在库”状态的治具可以进行出库操作），当前状态属于其他状态的治具，禁止出库操作！")
            //    return false;
            //}
        }
        //删除
        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;

            //xiang.yan 2024-4-28  列取值由索引改为列明
            // 2 改为 EquipmentName
            // 11 改为 StatusDesc
            debugger
            var equipmentName = getOneRecordCellTextByFiled("EquipmentName");
            var statusDesc = getOneRecordCellTextByFiled("StatusDesc");

            if (statusDesc != "在库" && statusDesc != "暂存") {
                alert("【" + equipmentName + "】不是“在库”或“暂存”状态，不能删除！");
                return false;
            }
            if (!confirm("是否确认删除？")) return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
            hdnOperate.val("");

        }

        ///清洗
        function Clear() {
            var idStr = getOneRecordId();
            if (idStr == "") {
                return false;
            }

            var parentTypeName = getOneRecordCellTextByFiled("ParentTypeName");
            var model = { Alpha2: (parentTypeName == "钢网" ? "IsSteelNetNeedClear" : "IsDrawKnifeNeedClear") };
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipment.GetSteelConfig(model);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var entity = ajax.value;
            if (!entity) {
                alert("未获取到" + parentTypeName + "清洗配置信息");
                return false;
            }
            if (entity.Alpha3 == 0) {
                alert(parentTypeName + "配置为不需要进行清洗");
                return false;
            }

            if (getOneRecordCellTextByFiled("StatusDesc") == "已下线") {
                openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SteelMesh/SteelIn.aspx?name=SteelMeshClear&ID=" + idStr;
                dialog({ title: "<%=Resources.Pages.SteelMeshView %>", src: openWinUrl, width: 800, height: 380 });
            }
            else {
                alert("只有“已下线”状态的治具，可以进行“清洗”操作，当前状态属于其他状态的治具，禁止清洗操作！")
                return false;
            }
        }
        function ChoosePage() {
            flag = "1";
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=" + flag + "&Multiple=false&rnd=" + Math.random(), width: 650, height: 350 });
        }

        function getChooseValue(list) {         
             $("#<%=this.txtMainItemCode.ClientID %>").val(list[0][2]);
                $("#hdnMainItemId").val(list[0][0]);               
           
        }

        function ChooseLine() {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=21&Multiple=false&CallBackFunc=setLine&rnd=" + Math.random(), width: 650, height: 300 });
        }
        
        function setLine(list) {
            $("#<%=this.txtLineName.ClientID %>").val(list[0][1]);
        }

        function Refresh() {
            document.forms[0].submit();
        }

        //根据样式名获取文本
        function getTextByClass(cls) {
            return $.trim($("#<%=this.GridView1.ClientID%> tbody input[name=\"chkSelect\"]:checked").parent().siblings("." + cls).text());
        }
    </script>
</asp:Content>
