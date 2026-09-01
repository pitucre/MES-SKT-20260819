<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="True"
    CodeBehind="SparePartsList.aspx.cs" Inherits="SKT.LeanMES.Web.Sparepart.PartsList" Title="Parts List Page" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" Runat="Server">
    <style type="text/css">
 td {
     max-width: 150px;
     /* overflow-wrap: break-word;*/
     overflow: hidden;
 }
 #dialogMaintain{display:none;}
 #dialogUpdateTerm{display:none;}
</style> 
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
         <tr>
           
              <td class="Label3">工具名称/编码</td>
            <td class="Field3">
                <asp:TextBox ID="txtToolName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td> 
            <td class="Label3">状态</td>
            <td class="Field3">
                <asp:DropDownList ID="ddlStates" runat="server" AutoPostBack="false" ClientIDMode="Static">
                    <asp:ListItem Value="-1">全部</asp:ListItem>
                    <asp:ListItem Value="1">可使用</asp:ListItem>                    
                    <asp:ListItem Value="2">报废</asp:ListItem>
                </asp:DropDownList>
            </td>
             <td class="Label3"><%=Resources.lang.Category%></td>
            <td class="Field3">
                <asp:TextBox runat="server" ID="txtPartCategory" CssClass="TextBox"  ></asp:TextBox>
                <input type="button" value="..." class="ButtonBox" onclick="selectEqType()" />
            </td> 
        </tr>
        <tr>
            <td class="Label3">蚀刻编号
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtSupplier" 
                    runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">存放库位
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtPartLocation" runat="server" CssClass="TextBox"
                 ClientIDMode="Static">
                </asp:TextBox>
            </td>
            <td class="Label3">规格
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtPartStandard" runat="server" CssClass="TextBox"
                 ClientIDMode="Static">
                </asp:TextBox>
            </td>
        </tr>
        <tr>
              <td class="Label3">产品编码
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtItemCode" 
                    runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
    <div id="dialogMaintain" title="添加保养信息">
            <table class="EditeContentTable" width="100%">
                <tr>
                    <td class="Label1">保养内容<em>*</em></td>
                    <td class="Field1">
                        <asp:TextBox ID="txtMaintainRemark" runat="server" CssClass="TextArea" TextMode="MultiLine"  MaxLength="50" Width="200px" Height="100px"></asp:TextBox>
                    </td> 
                </tr>
                <tr>
                    <td class="Label1" colspan="2">
                        <input id="btnSavedialogMaintain" type="button" onclick="SavedialogMaintain()" value="保存保养信息" />&nbsp;&nbsp;
                    </td>
                </tr>
          </table>
    </div>
    <div id="dialogUpdateTerm" title="使用期限变更">
        <table class="EditeContentTable" width="100%">
                <tr>
                    <td class="Label1">使用期限<em>*</em></td>
                    <td class="Field1">
                        <asp:TextBox ID="txtServiceLife" runat="server" CssClass="DateTimeBox" IsRequired='1'
                    Width="100px"></asp:TextBox>
                    </td> 
                </tr>
                <tr>
                    <td class="Label1">变更原因<em>*</em></td>
                    <td class="Field1">
                        <asp:TextBox ID="txtUpdateRemark" runat="server" CssClass="TextArea" TextMode="MultiLine"  MaxLength="50" Width="200px" Height="100px"></asp:TextBox>
                    </td> 
                </tr>
                <tr>
                    <td class="Label1" colspan="2">
                        <input id="btnSavedialogUpdateTerm" type="button" onclick="SavedialogUpdateTerm()" value="保存变更信息" />&nbsp;&nbsp;
                    </td>
                </tr>
          </table>
    </div>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" Runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" OnRowDataBound="GridView1_OnRowDataBound"  style="table-layout:fixed;word-wrap:break-word;word-break:break-all">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="PartNickName" HeaderText="<%$ Resources:lang, ToolCode %>" HeaderStyle-Width="140px" />
            <asp:BoundField DataField="PartName" HeaderText="<%$ Resources:lang, ToolName %>" HeaderStyle-Width="140px"  />
            <asp:BoundField DataField="PartStandard" HeaderText="<%$ Resources:lang, PartStandard %>" HeaderStyle-Width="140px" />
            <asp:BoundField DataField="PartCategory" HeaderText="类别" HeaderStyle-Width="60px" />
            <%--<asp:BoundField DataField="PartMachine" HeaderText="<%$ Resources:lang, PartMachine %>" />--%>
            <asp:BoundField DataField="PartLocation" HeaderText="存放库位" HeaderStyle-Width="140px" />
            <asp:BoundField DataField="VenName" HeaderText="蚀刻编号" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="ServiceLife" HeaderText="使用期限" DataFormatString="{0:yyyy-MM-dd}" HeaderStyle-Width="80px" />
            <asp:BoundField DataField="PartQty" HeaderText="初始数量" HeaderStyle-Width="60px" />
            <asp:BoundField DataField="InStockQty" HeaderText="在库数量" HeaderStyle-Width="60px" />
            <asp:BoundField DataField="OnLineQty" HeaderText="在线数量" HeaderStyle-Width="60px" />
            <asp:BoundField DataField="ScrapQty" HeaderText="报废数量" HeaderStyle-Width="60px" />
            <%--<asp:BoundField DataField="PartQty" HeaderText="<%$ Resources:lang, PartQty %>" />
            <asp:BoundField DataField="PartUnit" HeaderText="<%$ Resources:lang, PartUnit %>" />--%>
             <asp:BoundField DataField="CreateBy" HeaderText="创建人" HeaderStyle-Width="60px" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="创建时间" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" HeaderStyle-Width="140px" />
             <asp:BoundField DataField="ModifyBy" HeaderText="修改人" HeaderStyle-Width="60px" />
            <asp:BoundField DataField="ModifyDateTime" HeaderText="修改时间" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" HeaderStyle-Width="140px" />
            <asp:BoundField DataField="Remark" HeaderText="备注" HeaderStyle-Width="60px" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" 
        StartRowIndexParameterName="startRow" MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" 
        TypeName="SKT.LeanMES.Sparepart.BLL.Sparepart" SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value=""/>
    <input type="hidden" id="hdnIdString" name="hdnIdString"  value=""/>

    <script type="text/javascript">
        //isMultiple = true;
        var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");
        var NotdoSearch = 1;
        $(function ()
        {

             $("#dialogMaintain").attr("title", mesLang("添加保养信息"));
        $("#dialogUpdateTerm").attr("title", mesLang("使用期限变更"));

        })
        function Import() {
            hdnOperate.val("ExportExcel");
            document.forms[0].submit();
            hdnOperate.val("");
        }
        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            dialog({ title: mesLang("查看工具"), src: "SparePartsView.aspx?name=Anormal_TypeView&ID=" + idStr, width: 800, height: 460, resizeable: false });
        }
        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Sparepart/SparePartsEdit.aspx?name=Production_SparepartAdd&ID=-1";
            dialog({ title: mesLang("新增工具"), src: openWinUrl, width: 800, height: 460 });
        }
        function Maintain() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            var scrapQty = getRecordCellTextsByFiled("ScrapQty");
            var partQty = getRecordCellTextsByFiled("PartQty");
            var partName = getRecordCellTextsByFiled("PartName");
            if (partQty == scrapQty) {
                alert("工具[" + partName + "]已报废不能进行保养!");
                return false;
            }
            $("#dialogMaintain").dialog({
                resizable: false,
                height: 300,
                width: 400,
                modal: true
            });
        }
        function UpdateTerm() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            $("#dialogUpdateTerm").dialog({
                resizable: false,
                height: 300,
                width: 400,
                modal: true
            });
        }

        function SavedialogMaintain() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            var MaintainRemark = $("#<%=this.txtMaintainRemark.ClientID%>").val();
            if (MaintainRemark=="") {
                alert("请填写保养内容");
                return;
            }
            var entity = {};
            entity.PartNickID = idStr;
            entity.MaintainRemark = MaintainRemark;
            entity.UserName = userName;
            var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspSparePartMaintainSave", JSON.stringify(entity));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert("保存成功！");
            $("#dialogMaintain").dialog("close");
        }
        
        function SavedialogUpdateTerm() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            var UpdateRemark = $("#<%=this.txtUpdateRemark.ClientID%>").val();
            var ServiceLife = $("#<%=this.txtServiceLife.ClientID%>").val();
            if (UpdateRemark == "") {
                alert("请填写变更原因");
                return;
            }
            if (ServiceLife == "") {
                alert("请填写使用期限");
                return;
            }
            var entity = {};
         
            entity.PartNickID = idStr;
            entity.UpdateRemark = UpdateRemark;
            entity.ServiceLife = ServiceLife;
            entity.UserName = userName;
            var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspSparePartUpdateTermSave", JSON.stringify(entity));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert("变更成功！");
            $("#dialogUpdateTerm").dialog("close");
        }
        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Sparepart/SparePartsEdit.aspx?name=Production_SparepartEdit&ID=" + idStr;
            dialog({ title: mesLang("编辑工具"), src: openWinUrl, width: 800, height: 460 });
        }

        function Delete() {
            var idStr = getDeletingRecordIdString(); 
            if (idStr == "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }

        function Scrap() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Sparepart/SpareScrap.aspx?name=Production_SpareScrap&ID=" + idStr;
            dialog({ title: mesLang("工具报废"), src: openWinUrl, width: 420, height: 250 });
        }

        //入库
        function In() {
            var idStr = getOneRecordIdOnly();
            if (idStr == "") {
                openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Sparepart/InComing.aspx?name=Production_SparepartIn";
                dialog({ title: mesLang("工具入库"), src: openWinUrl, width: 630, height: 420 });
            }
            else if (idStr != "" && idStr != "a") {

                //xiang.yan 2024-4-28  列取值由索引改为列明,功能已去除
                // 2 改为 PartName
                var partName = getOneRecordCellTextByFiled("PartName");
                openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Sparepart/InComing.aspx?name=Production_SparepartIn&ID=" + idStr + "&CodeR=" + partName;
                dialog({ title: mesLang("工具归还"), src: openWinUrl, width: 630, height: 420 });
            }
            else if (idStr == "a") {
                return false;
            }
        }
        //出库
        function Out() {
            var idStr = getOneRecordIdOnly();
            if (idStr == "") {
                openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Sparepart/OutComing.aspx?name=Production_SparepartOut";
                dialog({ title: mesLang("工具归还"), src: openWinUrl, width: 630, height: 420 });
            }
            else if (idStr != "" && idStr != "a") {
                //xiang.yan 2024-4-28  列取值由索引改为列明,功能已去除
                // 2 改为 PartName
                var partName = getOneRecordCellTextByFiled("PartName");
                openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Sparepart/OutComing.aspx?name=Production_SparepartOut&ID=" + idStr + "&CodeR=" + partName;
                dialog({ title: mesLang("工具领用"), src: openWinUrl, width: 630, height: 420 });
            }
            else if (idStr == "a") {
                return false;
            }
        }
        function Refresh() {
            document.forms[0].submit();
        }
         /*选择供应商*/
        <%--function selectSupplier() {
            chooseFlag = 35;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=34&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }--%>
        /*存放位置*/
        function selectPosition() {
            chooseFlag = 1;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=609&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }
        
       function selectEqType() {
            var openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/EquimentTypeDialog.aspx?name=QC_InspectionItemDialog&controlId=3";
            dialog({ title: "工具类别", src: openWinUrl, width: 255, height: 350 });
       }
          SetValue = function (list) {
                closeDialog();
                $("#<%=txtPartCategory.ClientID%>").val(list[0].name);
         }

           <%--function getChooseValue(list) {
            if(chooseFlag==1){
                $("#<%=this.txtPartLocation.ClientID %>").val(list[0][1]);
                $("#<%=this.HiddenPosition.ClientID %>").val(list[0][0]);
           
            }else if (chooseFlag == 35) {
                   $("#<%=this.txtSupplier.ClientID %>").val(list[0][2]);
               }
           }--%>
    </script>
</asp:Content>

