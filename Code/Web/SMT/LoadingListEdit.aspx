<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditHeadMaster.master" AutoEventWireup="true"
    Inherits="SKT.LeanMES.Web.SMT.LoadingListEdit" CodeBehind="LoadingListEdit.aspx.cs" %>

<%@ MasterType VirtualPath="~/Masters/EditHeadMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server" ViewStateMode="Enabled">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %>
    </div>
    <div class="clear5"></div>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">模板类型：<em>*</em></td>
            <td class="Field2">
                <asp:DropDownList ID="ddlloadingType" ClientIDMode="Static" runat="server">
                </asp:DropDownList>
            </td>
            <td class="Label2">
                <%=Resources.lang.FullSet%>
            </td>
            <td class="Field2">
                <asp:CheckBox ID="cbFullSet" runat="server" Checked="true" />
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%=Resources.lang.SetupName %><em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtSetupName" runat="server" CssClass="TextBox" MaxLength='50' IsRequired="1" Width="70%"></asp:TextBox>
            </td>
            <td class="Label2">
                <%= Resources.lang.ItemsName %><em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtModelName" runat="server" CssClass="TextBox" IsRequired="1" Enabled="false"
                    ClientIDMode="Static" Width="64%"></asp:TextBox><input type="button" id="Button1"
                        onclick="selectItems(this);" class="ButtonBox" value="..." disabled="disabled" />
                <asp:HiddenField ID="txtModelID" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
        </tr>
        <tr>
            <td class="Label2">线别设备类型：<em>*</em></td>
            <td class="Field2">
                <asp:DropDownList ID="ddlEquipmentLine" runat="server" onchange="BindSeq(this)">
                </asp:DropDownList>
            </td>
            <td class="Label2">线别设备序号：<em>*</em></td>
            <td class="Field2 redFont">
                <asp:DropDownList ID="ddlSequenceNo" runat="server">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%=Resources.lang.Revision %><em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtRev" runat="server" CssClass="TextBox" IsRequired="1" MaxLength='10'></asp:TextBox>
            </td>
            <td class="Label2">
                <%=Resources.lang.Status %>
            </td>
            <td class="Field2">
                <asp:DropDownList ID="ddlStatus" ClientIDMode="Static" runat="server" disabled="disabled">
                    <asp:ListItem Value="0">未使用</asp:ListItem>
                    <asp:ListItem Value="1">使用中</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%=Resources.lang.Layout %><em>*</em>
            </td>
            <td class="Field2">
                <asp:DropDownList ID="ddlLayout" ClientIDMode="Static" runat="server">
                </asp:DropDownList>
            </td>
            <td class="Label2">
               扣料基数<em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtCLNumber" runat="server" Text="1" CssClass="TextBox" IsRequired="1" MaxLength='10'></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <div class="ListTableTitle">
        <span>上料清单明细</span><span id="demo1"></span>
    </div>
    <div style="height: 220px; overflow: scroll;">
        <asp:GridView ID="GridView1" AutoGenerateColumns="true" runat="server" DataSourceID="ObjectDataSource1">
            <Columns>
                <asp:BoundField DataField="SetupName" HeaderText="上料清单" SortExpression="SetupName" />
                <asp:BoundField DataField="Area" HeaderText="区"  SortExpression ="Area" ItemStyle-Width="40px" />
                <asp:BoundField DataField="Position" HeaderText="料站/插槽" SortExpression="Position" />
                <asp:BoundField DataField="ItemCode" HeaderText="物料编码" SortExpression="ItemCode" />
                <asp:BoundField DataField="SmtNum" HeaderText="需求用量" SortExpression="SmtNum" />
                <%--<asp:BoundField DataField="LocationType" HeaderText="位置"  SortExpression="LocationType" />--%>
                <asp:BoundField DataField="FeederType" HeaderText="飞达类型" SortExpression="FeederType" />
                <asp:BoundField DataField="Point" HeaderText="点位" SortExpression="Point" />
                <asp:BoundField DataField="ReplaceNum" HeaderText="替代料" SortExpression="ReplaceNum" />
            </Columns>
        </asp:GridView>
        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
            MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.SMT.BLL.LoadingList_DETAIL"
            SelectMethod="GetLoadingListDetailAll" SelectCountMethod="GetCount">
            <SelectParameters>
                <asp:Parameter Name="searchSettings" Type="Object" />
            </SelectParameters>
        </asp:ObjectDataSource>
    </div>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <asp:HiddenField ID="hdnTIDString" runat="server" ClientIDMode="Static" Value="-1" />
    <asp:HiddenField ID="hdnBoardItemID" runat="server" Value="-1" ClientIDMode="Static" />
    <asp:HiddenField ID="hdnIsSwitchable" runat="server" Value="-1" ClientIDMode="Static" />
    <asp:HiddenField ID="hdnIsRefDesignator" runat="server" Value="-1" ClientIDMode="Static" />
    <asp:HiddenField ID="hdnFamilyMatrixID" runat="server" Value="-1" ClientIDMode="Static" />
    <asp:HiddenField ID="hdnCreateTime" runat="server" Value="-1" ClientIDMode="Static" />
    <script type="text/javascript" src="../Content/js/jquery-3.1.0.min.js"></script>
    <script type="text/javascript">
        loadfloatButtons("demo1");
        var LoadingListId = '<%=Request.QueryString["ID"] %>';
        var user = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
        isMultiple = true;
        $(document).ready(function () {
                //$("input").attr("disabled", "disabled");
                //$("select").attr("disabled", "disabled");
                //$("tr").removeAttr("onclick");
                //$("tr").removeAttr("ondblclick");
        })

        function BindSeq(obj) {
            var ddlSequenceNo = document.getElementById("<%= ddlSequenceNo.ClientID %>");
            ddlSequenceNo.options.length = 0; //删除旧的方法

            var equipmentLineId = $(obj).val();
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxServicesLoadingList.GetEquipmentLineSeq(equipmentLineId);

            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            } else {
                strJson = ajax.value;
            }

            if (typeof strJson === 'undefined' || strJson === "") return false;
            objJson = $.parseJSON(strJson);

            for (var i = 0; i < objJson.length; i++) {
                var itemName = objJson[i].ItemName;
                var itemValue = objJson[i].ItemValue;
                ddlSequenceNo.options.add(new Option(itemName, itemValue));
            }
        }

        function Save() {
            $("#ddlStatus").removeAttr("disabled");//移除disabled  获取值
            var txtSetupName = $("#<%=this.txtSetupName.ClientID %>").val();
            var txtCustomerName = "";
            var txtModelName = $("#<%=this.hdnBoardItemID.ClientID %>").val();
            var txtModelID = $("#<%= this.txtModelID.ClientID %>").val();
            var txtStatus = $("#<%=this.ddlStatus.ClientID %>").val();
            var hdnCreateTime = $("#<%=this.hdnCreateTime.ClientID %>").val();
            var cbFullSet = $("#<%= this.cbFullSet.ClientID %>").prop("checked");
            var ddlloadingType = $("#<%= ddlloadingType.ClientID %>").val();
            var ddlEquipmentLine = $("#<%= ddlEquipmentLine.ClientID %>").val();
            var ddlSequenceNo = $("#<%= ddlSequenceNo.ClientID %>").val();
            var txtRev = $("#<%=this.txtRev.ClientID %>").val();
            var txtCLNumber = $("#<%=this.txtCLNumber.ClientID %>").val();

            var errStr = "";

            if (txtSetupName == "") {
                errStr += "<%=Resources.Messages.WithAsteriskIsRequiredAlert %>" + "\n";
            }
            //产品
            if (txtModelID == "-1" || txtModelID == "") {
                errStr += "<%=Resources.Messages.ItemIsRequired %>" + "\n";
            }
            //版本
            if (txtRev == "") {
                errStr += "<%=Resources.Messages.RevisionEmpty %>" + "\n";
            }
            //编号
            if (ddlSequenceNo == "") {
                errStr += "线别设备序号不能为空\n";
            }
            if (errStr != "") {
                alert(errStr.toString());
                return false;
            }

            var entity = {};
            entity.ID = LoadingListId;
            entity.SetupName = txtSetupName;
            entity.CustomerName = txtCustomerName;
            entity.Revision = txtRev;
            entity.IsFullSet = cbFullSet;
            entity.StatusID = txtStatus;
            entity.ItemId = txtModelID;
            entity.LoadingTypeId = ddlloadingType * 1;
            entity.EquipmentLineId = ddlEquipmentLine * 1;
            entity.SequenceNo = ddlSequenceNo * 1;
            entity.CreateBy = user;
            entity.SmtLayout = $("#<%=ddlLayout.ClientID %>").val();
            entity.CLNumber = parseFloat(txtCLNumber);
            
            /*entity.LastUpdate = new Date(hdnCreateTime);
            entity.CreationTime = new Date(hdnCreateTime);*/


            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxServicesLoadingList.LoadingListEdit(entity);

            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert("<%=Resources.Messages.SaveInSuccess %>");
            parent.window.UpdateList(txtSetupName);

        }


        function selectItems(obj) {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=5&Multiple=false&rnd=" + Math.random(), width: 680, height: 300 });
        }
        function getChooseValue(list) {
            // $("#txtModelName").val(list[0][1] + ' (' + list[0][2] + ')');
            $("#<%=this.txtModelName.ClientID %>").val(list[0][1]);
            $("#<%=this.txtModelID.ClientID %>").val(list[0][0]);
        }

        //编辑
        function Edit() {
          var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SMT/LoadingLitDetailEdit.aspx?name=LoadingListDetailEdit&ID=" + idStr + "&LoadingListId=" + LoadingListId + "";
            dialog({ title: "上料明细编辑", src: openWinUrl, width: 750, height: 400 });
        }

        //新增
        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SMT/LoadingLitDetailEdit.aspx?name=LoadingListDetailAdd&ID=-1&LoadingListId=" + LoadingListId + "";
            dialog({ title: "上料明细编辑", src: openWinUrl, width: 750, height: 400 });
        }

        function Delete() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxServicesLoadingList.LoadingListDetailDelete(idStr);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            UpdateList();
        }

        function UpdateList() {
            $("#ddlStatus").removeAttr("disabled");
            document.forms[0].submit();
            $("#ddlStatus").attr("disabled", "disabled");
        }
        function selectLine(obj) {
            dialog({
                title: "<%=Resources.Common.ChooseWindow %>"
            , src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=21&Multiple=false&CallBackFunc=getChooseLine&PageCondition=&rnd=" + Math.random(), width: 600, height: 300
            });

        }
        function getChooseLine(list) {
            $("#txtLineName").val(list[0][1]);
            $("#hfLineId").val(list[0][0]);
        }
    </script>
</asp:Content>
