<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="ESOPMacEdit.aspx.cs" Inherits="SKT.LeanMES.Web.ESOP.ESOPMacEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
    <table width="100%" class="EditeContentTable">
            <tr>
            <td class="Label1">
                设备名称
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtMacName" runat="server" CssClass="TextBox" MaxLength="50" ClientIDMode="Static" ></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                MAC地址<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtMAC" runat="server" CssClass="TextBox" MaxLength="50" ClientIDMode="Static" IsRequired="1" ></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                工序<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtStation" runat="server" CssClass="TextBox" ClientIDMode="Static" ReadOnly="true" IsRequired="1" ></asp:TextBox><input
                    type="button" id="btnSelectStation" class="ButtonBox" value="..." title="<%=Resources.lang.Choose %>"
                    onclick="selectStation();" />
                <asp:HiddenField ID="hdnStationId" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
        </tr>
        <tr>
            <td class="Label1">
                资源<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtResource" runat="server" CssClass="TextBox" ClientIDMode="Static" ReadOnly="true" IsRequired="1" ></asp:TextBox><input
                    type="button" id="Button1" class="ButtonBox" value="..." title="<%=Resources.lang.Choose %>"
                    onclick="selectResource();" />
                <asp:HiddenField ID="hdnResourceId" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
        </tr>
        <tr>
            <td class="Label1">
                是否默认工序
            </td>
            <td class="Field1">
                <asp:CheckBox ID="chkIsDefault" runat="server" ClientIDMode="Static" />
            </td>
        </tr>
        <tr>
            <td class="Label1">
                是否切换
            </td>
            <td class="Field1">
                <asp:CheckBox ID="chkIsSwitch" runat="server" ClientIDMode="Static" />
            </td>
        </tr>
        <tr>
            <td class="Label1">
                备注
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtRemark" runat="server" CssClass="TextArea" ClientIDMode="Static" TextMode="MultiLine"
                    MaxLength="100"></asp:TextBox>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        var eSOPMacId = '<%=Request.QueryString["ID"]%>';
        var action = '<%=Request.QueryString["Action"] %>';
        /*保存数据*/
        function Save() {
            var txtMacName = $.trim($("#<%=this.txtMacName.ClientID%>").val());
            var txtMAC = $.trim($("#<%=this.txtMAC.ClientID%>").val());
            var txtStationId = $("#<%=this.hdnStationId.ClientID%>").val();
            var txtResourceId = $("#<%=this.hdnResourceId.ClientID%>").val();
            var txtIsDefault = $("#<%=this.chkIsDefault.ClientID%>").prop("checked");  
            var txtIsSwitch = $("#<%=this.chkIsSwitch.ClientID%>").prop("checked");           
            var txtRemark = $.trim($("#<%=this.txtRemark.ClientID%>").val());


            /*表单验证*/
            /*如需表单验证可以此处处理验证 开始*/


            var entity = {};
            if (action.toLocaleLowerCase() == "copy") {
                entity.ESOPMacId = -1;
            }
            else {
                entity.ESOPMacId = eSOPMacId;
            }            
            entity.MAC = txtMAC;
            entity.MacName = txtMacName;
            entity.StationId = txtStationId;
            entity.ResourceId = txtResourceId;
            entity.IsSwitch = txtIsSwitch;
            entity.Remark = txtRemark;
            entity.IsDefault = txtIsDefault;
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEsop.ESOPMacEdit(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert('<%=Resources.Messages.SaveInSuccess%>')

            parent.window.Refresh();
        }
        var chooseFlag = 0;
        /*选择工序*/
        function selectStation() {
            chooseFlag = 1;
            var PageCondition = " ParentStationId<=0 ";
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=8&Multiple=false&PageCondition="+escape(PageCondition)+"&rnd=" + Math.random(), width: 680, height: 300 });
        }
        /*选择资源*/
        function selectResource() {
            if ($("#hdnStationId").val() == "-1") {
                alert("请先选择工序！");
                return false ;
            }
            chooseFlag = 2;
            var PageCondition = " ResourceId in(select ResourceId from Basal_ResourceTypeMember where ResourceTypeId=(select StationResTypeId from basal_station where stationid="+$("#hdnStationId").val()+")) ";
          
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=6&Multiple=false&PageCondition=" + escape(PageCondition) + "&rnd=" + Math.random(), width: 680, height: 300 });
        }
        /*选择产品*/
        function selectItem() {
            chooseFlag = 3;
            if ($("#hdnStationId").val() == "-1") {
                alert("请先选择工序！");
                return false;
            }
            var PageCondition = " ItemId in(SELECT  b.ItemId FROM dbo.Prod_ESOP a  " +
            " INNER JOIN dbo.Prod_ESOPFileItemRelation b ON a.ESOPId = b.ESOPFileID   " +
            //" WHERE a.StationId=(SELECT ParentStationId FROM dbo.Basal_Station WHERE StationId= " + $("#hdnStationId").val() + ")) ";
            " WHERE a.StationId=" + $("#hdnStationId").val()+" )";
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=1&Multiple=false&PageCondition=" + escape(PageCondition) + "&rnd=" + Math.random(), width: 680, height: 300 });
        }

        function getChooseValue(list) {
            if (chooseFlag == 1) {
                $("#hdnStationId").val(list[0][0]);
                $("#txtStation").val(list[0][1]);
                $("#hdnResourceId").val(-1);
                $("#txtResource").val("");
//                $("#hdnItemId").val(-1);
//                $("#txtItemName").val("");
            }
            else if (chooseFlag == 2) {
                $("#hdnResourceId").val(list[0][0]);
                $("#txtResource").val(list[0][1]);
                
            }
            else if (chooseFlag == 3) {
                $("#hdnItemId").val(list[0][0]);
                $("#txtItemName").val(list[0][1]);
                
            }
            
        }
    </script>
</asp:Content>
