<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PickListEdit.aspx.cs" MasterPageFile="~/Masters/EditHeadMaster.master"
    Inherits="SKT.LeanMES.Web.SMT.PickListEdit" %>

<%@ MasterType VirtualPath="~/Masters/EditHeadMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="infoTips">
                <%=Resources.Messages.WithAsteriskIsRequired %></div>
    <table class="EditeContentTable" width="100%">
        <tr>
             <td class="Label2">
                <%= Resources.lang.ItemsName %><em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtModelName" name="ModelName" runat="server" CssClass="TextBox"
                    Enabled="false" ClientIDMode="Static" Width="64%" isrequired="1"></asp:TextBox><input
                        type="button" id="btnSelectItems" onclick="selectItems(this);" class="ButtonBox"
                        value="..." />
                <asp:HiddenField ID="hdnItemId" runat="server" Value="-1" ClientIDMode="Static" />
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
                上料清单名
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtPickListName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>           
            <td class="Label2">
                <%=Resources.lang.Status %><em>*</em>
            </td>
            <td class="Field2">
                <asp:DropDownList ID="ddlStatus" isrequired="1" ClientIDMode="Static" runat="server">
                </asp:DropDownList>
            </td>
        </tr>      
        <tr>
           <td class="Label2">
                <%= Resources.lang.Revision %>
                <em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtRev" runat="server" CssClass="TextBox" isrequired="1" ></asp:TextBox>
            </td>
            <td class="Label2">
                备注
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtRemark" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <div class="ListTableTitle">
        <span>上料清单明细</span><span id="demo1"></span></div>
    <div style="height: 200px; overflow: scroll;">
        <asp:GridView ID="GridView1" AutoGenerateColumns="true" runat="server" DataSourceID="ObjectDataSource1">
            <Columns>
                <asp:BoundField DataField="ItemCode" HeaderText="产品编码" SortExpression="ItemCode" />
                <asp:BoundField DataField="Qty" HeaderText="数量" SortExpression="Qty" />
                <asp:BoundField DataField="GroupCode" HeaderText="扣料组编码" SortExpression="GroupCode" />
                <asp:BoundField DataField="GroupDesc" HeaderText="扣料组描述" SortExpression="GroupDesc" />
                <asp:BoundField DataField="Remark" HeaderText="备注" SortExpression="a.Remark" />
            </Columns>
        </asp:GridView>
        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
            MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.SMT.BLL.PickListDetail"
            SelectMethod="GetAll" SelectCountMethod="GetCount">
            <SelectParameters>
                <asp:Parameter Name="searchSettings" Type="Object" />
            </SelectParameters>
        </asp:ObjectDataSource>
    </div>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script type="text/javascript">
        loadfloatButtons("demo1");
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");
        isMultiple = true;
        var pickListId = <%= Request.QueryString["ID"] == null ? -1 : Convert.ToInt32(Request.QueryString["ID"].ToString())%>;
        var errStr = "";

        function selectItems(obj) {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=1&Multiple=false&rnd=" + Math.random(), width: 680, height: 300 });
        }
        function getChooseValue(list) {
            $("#<%=this.txtModelName.ClientID %>").val(list[0][1]);
            $("#<%=this.hdnItemId.ClientID %>").val(list[0][0]);

        }

          
        function selectCustomer(obj) {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=10&Multiple=false&CallBackFunc=getChooseValueCustomer&rnd=" + Math.random(), width: 680, height: 300 });
        }
        //编辑保存功能
        function Save() {
            var txtListName = $("#<%=this.txtPickListName.ClientID %>").val();            
            var hdnItemId = $("#<%=this.hdnItemId.ClientID %>").val();                      
            var StatusID = $("#<%=this.ddlStatus.ClientID %>").val();
            var Revision = $("#<%=this.txtRev.ClientID %>").val();
            var Remark = $("#<%=this.txtRemark.ClientID %>").val();
            var isFullSet = ($("#<%=this.cbFullSet.ClientID%>").is(":checked"));     
 
            var entity = {};
            entity.ListID = pickListId;
            entity.ListName = txtListName;
            entity.ItemID =  hdnItemId;
            entity.StationID = -1;
            entity.LineID = -1;
            entity.CustomerID = -1;
            entity.StatusID = StatusID;         
            entity.IsFullSet = isFullSet;
            entity.Revision = Revision;
            entity.Remark = Remark;
            entity.ModifyBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPickList.pickListEdit(entity);

            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert("<%=Resources.Messages.SaveInSuccess %>");
            parent.window.UpdateList(txtListName);
         }
          //编辑
        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SMT/PickListDetailEdit.aspx?name=PickListDetailEdit&PickListID=" + pickListId + "&ID=" + idStr;
            dialog({ title: "上料明细编辑", src: openWinUrl, width: 800, height: 350 });
        }

        //新增
        function  Add(){
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/SMT/PickListDetailEdit.aspx?name=PickListDetailEdit&PickListID=" + pickListId + "&ID=-1";
            dialog({ title: "上料明细新增", src: openWinUrl, width: 800, height: 350 });
        }

        //删除功能
        function  Delete(){
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            $(hdnOperate).val("Delete");
            $(hdnIdString).val(idStr);
            document.forms[0].submit();
        }
        //使用粉碎料
        function UseCrush() {
            //var idStr = getDeletingRecordIdString();
            $(hdnOperate).val("UseCrush");
            //$(hdnIdString).val(idStr);
            document.forms[0].submit();
        }
        //使用原材料
        function UseRaw() {
            //var idStr = getDeletingRecordIdString();
            $(hdnOperate).val("UseRaw");          
           // $(hdnIdString).val(idStr);
            document.forms[0].submit();
        }
        function UpdateList() {
            document.forms[0].submit();
        }  
    </script>
</asp:Content>
