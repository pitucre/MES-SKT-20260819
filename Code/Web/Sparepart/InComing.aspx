<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="InComing.aspx.cs" Inherits="SKT.LeanMES.Web.Sparepart.InComing" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">
              工具编码&nbsp;
                <asp:HiddenField ID="hdfPartId" runat="server" />
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtPart_NO" runat="server" IsRequired='1' CssClass="TextBox" MaxLength="50"
                    ClientIDMode="Static"></asp:TextBox><input id="btnQuery" type="button" value="查询" 
                style="height: 22px; width: 80px; border-style: outset; cursor: pointer; font-weight: bold; padding-top: 0px" />
            </td>
        </tr>
        <tr>
            <td class="Label1">生产部门<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtDeptCode" runat="server" IsRequired='1' CssClass="TextBox" ClientIDMode="Static"
                    ReadOnly="true"></asp:TextBox><input id="button2" class="ButtonBox" type="button" onclick="selectDeptCodeCC()" value="..."
                        title="选择部门" />
                <asp:HiddenField ID="hdnDeptId" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%=Resources.lang.IncomingQty%><em>*</em>
            </td>
            <td class="Field1" id="tdtxtAddQty">
                <asp:TextBox ID="txtAddQty" runat="server" CssClass="TextBox" Width="80" patterns="ufloat"
                    ClientIDMode="Static" IsRequired='1' MaxLength='8' MinValue='0' IsNumber='1'></asp:TextBox>&nbsp;
                <%--                <select id="ddlOutType">
                    <option value="1" selected="selected">
                        <%=Resources.lang.PickIn%></option>
                    <option value="2">
                        <%=Resources.lang.BrrBackIn%></option>
                    <option value="3">
                        <%=Resources.lang.TimeIn%></option>
                    <option value="4">
                        <%=Resources.lang.UnIn%></option>
                </select>--%>
            </td>
        </tr>
        <tr>
            <td class="Label1">归还原因<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="TextBox1" runat="server" IsRequired='1' CssClass="TextBox" ClientIDMode="Static"
                    ReadOnly="true"></asp:TextBox><input id="button3" class="ButtonBox" type="button" onclick="selectR()" value="..."
                        title="选择原因" />
                <asp:HiddenField ID="HiddenField1" runat="server" Value="-1" ClientIDMode="Static" />
                <input id="btnSave" type="button" value="确认归还" onclick="Save();"
                    style="height: 22px; width: 80px; border-style: outset; cursor: pointer; font-weight: bold; padding-top: 0px" />
            </td>
        </tr>
        <tr>
            <td class="Label1">
               工具名称
            </td>
            <td class="Field1" id="tdPartName">
                <asp:Label ID="lbPartName" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label1">
              工具编码
            </td>
            <td class="Field1" id="tdPartNickName">
                <asp:Label ID="lbPartNickName" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%=Resources.lang.PartSafeQty %>
            </td>
            <td class="Field1" id="tdPartSafeQty">
                <asp:Label ID="lbPartSafeQty" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%=Resources.lang.PartQty %>
            </td>
            <td class="Field1" id="tdPartQty">
                <asp:Label ID="lbPartQty" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label1">
            工具类别
            </td>
            <td class="Field1" id="tdPartCategory">
                <asp:Label ID="lbPartCategory" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%=Resources.lang.PartMachine %>
            </td>
            <td class="Field1" id="tdPartMachine">
                <asp:Label ID="lbPartMachine" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%=Resources.lang.PartLocation %>
            </td>
            <td class="Field1" id="tdPartLocation">
                <asp:Label ID="lbPartLocation" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%=Resources.lang.PartBrand%>
            </td>
            <td class="Field1" id="tdPartBrand">
                <asp:Label ID="lbPartBrand" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%=Resources.lang.PartStandard %>
            </td>
            <td class="Field1" id="tdPartStandard">
                <asp:Label ID="lbPartStandard" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%=Resources.lang.PartParam %>
            </td>
            <td class="Field1" id="tdPartParam">
                <asp:Label ID="lbPartParam" runat="server"></asp:Label>
            </td>
        </tr>
    </table>

    <script type="text/javascript">
        var ID = "";
        var code = "";

        <% if (Request.QueryString["ID"] == null)
        { %>
        $("#<%=this.txtPart_NO.ClientID%>").focus();
        <% }
        else
        { %>
        ID = <%= Request.QueryString["ID"] %>;
        $("#<%=this.hdfPartId.ClientID%>").val(ID);
        <% } %>

        <% if (Request.QueryString["CodeR"] == null)
        { %>
              $("#txtPart_NO").focus();
        <% }
        else
        { %>
                  code = "<%= Request.QueryString["CodeR"] %>";
        
                  $("#<%=this.txtPart_NO.ClientID%>").val(code);
        <% } %>


        $(function(){
            if(ID==""){
                $("#btnSave").attr({"disabled":"disabled"});
                $("#<%=this.txtAddQty.ClientID %>").attr("disabled","disabled");
            }
            else{
                $("#btnSave").removeAttr("disabled");
                $("#<%=this.txtAddQty.ClientID %>").removeAttr("disabled");
            }

          $("#btnQuery").click(function(obj) {
             if ($("#<%=this.txtPart_NO.ClientID%>").val() == "") {
                 alert("请输入工具编码！");
                 return false;
             }      
                SelectData();

            });


<%--             $("#<%=this.txtPart_NO.ClientID%>").keydown(function(event){
                event=document.all?window.event:event;
                if((event.keyCode || event.which)==13){
                    SelectData();
                }
            });--%>
        });
        //根据备件代码查询
        function SelectData(){
            var valueStr = $("#<%=this.txtPart_NO.ClientID%>").val();
            var data = SKT.LeanMES.Web.AjaxServices.AjaxSparepart.GetInfo(valueStr);
            if (data.error != null) {
                alert(data.error.Message);
                return false;
            }
            else{
                if(data.value == null)
                {
                    CheckValue();
                }
                else{
                    $("#<%=this.txtAddQty.ClientID %>").removeAttr("disabled");
                    $("#btnSave").removeAttr("disabled");
                    document.getElementById("tdPartName").innerText=data.value.PartName;
                    document.getElementById("tdPartNickName").innerText=data.value.PartNickName;
                    document.getElementById("tdPartSafeQty").innerText=data.value.PartSafeQty;
                    document.getElementById("tdPartQty").innerText=data.value.PartQty;
                    document.getElementById("tdPartCategory").innerText=data.value.PartCategory;
                    document.getElementById("tdPartMachine").innerText=data.value.PartMachine;
                    document.getElementById("tdPartLocation").innerText=data.value.PartLocation;
                    document.getElementById("tdPartBrand").innerText=data.value.PartBrand;
                    document.getElementById("tdPartStandard").innerText=data.value.PartStandard;
                    document.getElementById("tdPartParam").innerText=data.value.PartParam;
                    $("#<%=this.hdfPartId.ClientID%>").val(data.value.PartId)
               }
           }
       }
       //选择部门
       function selectDeptCodeCC() {
        
           dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=13&Multiple=false&CallBackFunc=setDeptCode&rnd=" + Math.random(), width: 500, height: 300 });
        }
        function setDeptCode(list) {
            var DeptCodes = list[0][1] + "|" + list[0][2];
            if (list[0][0] == "-1") {
                DeptCodes = "";
            }
            $("#<%=this.txtDeptCode.ClientID %>").val(DeptCodes);
          $("#hdnDeptId").val(list[0][0]);
      }
      //选择原因
        function selectR() {
            var pageCondition=" Type=2 ";
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=671&pageCondition="+pageCondition+"&Multiple=false&CallBackFunc=setRCode&rnd=" + Math.random(), width: 500, height: 300 });
        }
        function setRCode(list) {
            var DeptCodes =list[0][2];
            $("#<%=this.TextBox1.ClientID %>").val(DeptCodes);
            Reason=list[0][1];
            $("#ddlOutType").val(list[0][1]);
        }
        function Save(){
            var valueStr = $("#<%=this.txtPart_NO.ClientID%>").val();
            var data = SKT.LeanMES.Web.AjaxServices.AjaxSparepart.GetInfo(valueStr);
            if (data.error != null) {
                alert(data.error.Message);
                return false;
            }
            else{
                if(data.value==null){
                    CheckValue();
                }
                else{
                    if (SubmitValidation()) {
                        var quantity = $("#txtAddQty").val();
                        var entity = {};
                        entity.PartsHistoryId = -1;
                        entity.PartID = $("#<%=this.hdfPartId.ClientID%>").val();
                        entity.OperateType =Reason;// parseInt($("#ddlOutType").val());
                        entity.Quantity = parseInt(quantity);
                        //2表示入库
                        entity.OutOrIn =2;
                        entity.Requestor =  '';
                        entity.CreateBy =  '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>';
                        entity.Remark =$("#TextBox1").val();//$("#ddlOutType :selected").text().replace(/(^\s*)|(\s*$)/g, "");
                        entity.DeparmentId= $("#hdnDeptId").val();

                        var ajax =SKT.LeanMES.Web.AjaxServices.AjaxSparepart.EditPartHistory(entity);
                        if (ajax.error != null) {
                            alert(ajax.error.Message);
                            return false;
                        }
                        alert('<%=Resources.Messages.SaveInSuccess%>');
                            window.parent.Refresh();
                        }
                }
            }
          
        } 

        function CheckValue()
        {
            alert("备件号不存在!");
            $("#btnSave").attr({"disabled":"disabled"});
            $("#<%=this.txtAddQty.ClientID %>").attr("disabled","disabled");
            $("#<%=this.txtAddQty.ClientID %>").val("");
            document.getElementById("tdPartName").innerText="";
            document.getElementById("tdPartNickName").innerText="";
            document.getElementById("tdPartSafeQty").innerText="";
            document.getElementById("tdPartQty").innerText="";
            document.getElementById("tdPartCategory").innerText="";
            document.getElementById("tdPartMachine").innerText="";
            document.getElementById("tdPartLocation").innerText="";
            document.getElementById("tdPartBrand").innerText="";
            document.getElementById("tdPartStandard").innerText="";
            document.getElementById("tdPartParam").innerText="";
            $("#<%=this.hdfPartId.ClientID%>").val("");

            $("#<%=this.txtPart_NO.ClientID%>").select();
            $("#<%=this.txtPart_NO.ClientID%>").focus();
            return false;
        }
    </script>
</asp:Content>
