<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="True"
    CodeBehind="PartInOrOut.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.PartInOrOut" Title="Edit Part" %>

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
                <%= Resources.lang.PartCode%><em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox runat="server" ID="txtPart"  ></asp:TextBox><input type="button" id="btnPart" class="ButtonBox"
                    value="..." onclick="selectPart()" />
                <input type="hidden" id="hidPartId" value="0"/>
            </td>
        </tr>
             <tr>
            <td class="Label1"> <%= Resources.lang.PartName%>
            </td>
            <td class="Field1">
               <asp:Label runat="server" id="lblPartName"></asp:Label>
            </td>
        </tr>
                   <tr>
            <td class="Label1"> 规格型号
            </td>
            <td class="Field1">
               <asp:Label runat="server" id="lblPartStand"></asp:Label>
            </td>
        </tr>
             <tr>
            <td class="Label1">当前库存
            </td>
            <td class="Field1">
                <asp:Label runat="server" id="lblCurrentStock"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label1">在线数量
            </td>
            <td class="Field1">
                <asp:Label runat="server" id="lblQty"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label1"><label id="lblInOutType"><span>入库类型</span></label><em>*</em>
            </td>
            <td class="Field1">
                

                <asp:DropDownList ID="ddInType" ClientIDMode="Static" runat="server" Width="100" >
                    <asp:ListItem Value="0" Selected="True" >新增入库</asp:ListItem>
                    <asp:ListItem Value="1" >产线入库</asp:ListItem>
                </asp:DropDownList>
                
                <asp:DropDownList ID="ddOutType" ClientIDMode="Static" runat="server" Width="100" >
                  
                    <asp:ListItem Value="0" >使用出库</asp:ListItem>
                    <asp:ListItem Value="1" >报废出库</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="Label1">数量<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtQty" runat="server" CssClass="TextBox" MaxLength="50" IsNumber="1" isRequired="1" onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" onafterpaste="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}"></asp:TextBox>&nbsp;&nbsp;<label id="lblError" style="color:red"></label>
            </td>
        </tr>
       <tr>
            <td class="Label1">
                <%= Resources.lang.Remark %>
            </td>
            <td class="Field1" >
                <asp:TextBox ID="txtRemark" runat="server" CssClass="TextArea" TextMode="MultiLine"
                    MaxLength="100" Width="90%"></asp:TextBox>
            </td>

        </tr>
    </table>
    <script type="text/javascript">
        var temp = 0;
        var partId =<%= Request.QueryString["ID"] == null ? -1 : Convert.ToInt32(Request.QueryString["ID"].ToString())%>;
        var type =<%= Request.QueryString["type"]%>;
        var part ='<%= Request.QueryString["part"]%>';
       
        $(function() {
         

            if (type == "2")
            {
                $("#lblInOutType").text(mesLang("出库类型"));
                $("#<%=this.ddInType.ClientID%>").css("display", "none");
            } else {
                $("#lblInOutType").text(mesLang("入库类型"));
                $("#<%=this.ddOutType.ClientID%>").css("display","none");
            }
            $("#hidPartId").val(partId);
            if (part != "" && part != "null") {
                 $("#<%=this.txtPart.ClientID%>").val(part);
                GetPart(part);
            } else {
                $("#<%=this.txtPart.ClientID%>").val("");
            }
          
            $("#<%=this.txtPart.ClientID%>").blur(function() {
               if (this.value != "") {
                   GetPart(this.value);
               }
            });
          
            $("#<%=this.txtQty.ClientID%>").blur(function() {
                if (this.value == "") {
                     $("#lblError").html("请输入数量！");
                    return;
                }
                if (type == "2") { //如果是出库操作
                  
                    var currentStock = $("#<%=this.lblCurrentStock.ClientID%>").html();
                    if (currentStock != "") { //判断当前库存值是否为空

                        if (parseInt(this.value) > parseInt(currentStock)) {

                            $("#lblError").html("输入的数量大于当前库存！");
                            return;
                        } else {
                            $("#lblError").html("");
                        }
                    }
                } 
            });
        });
      
        function GetPart(partCode) {

            var entity= SKT.LeanMES.Web.AjaxServices.AjaxPart.GetPartInfo(partCode).value;
           
            if (entity != null) {
                $("#<%=this.lblPartName.ClientID%>").html(entity.PartName);
                $("#<%=this.lblPartStand.ClientID%>").html(entity.PartStand);
                $("#<%=this.lblCurrentStock.ClientID%>").html(entity.CurrentStock);
                $("#<%=this.lblQty.ClientID%>").html(entity.Qty);
                
                $("#lblError").html("");
            } else {
                $("#hidPartId").val(0);
                $("#<%=this.lblPartName.ClientID%>").html("");
                 $("#<%=this.lblPartStand.ClientID%>").html("");
                $("#<%=this.lblCurrentStock.ClientID%>").html("");
                $("#<%=this.lblQty.ClientID%>").html("");
                $("#lblError").html("输入的备件编码不存在！");
               
                return;
            }
        }



        /*保存数据*/
        function Save() {
            var Qty=$("#<%=this.txtQty.ClientID%>").val();
            var partID = $("#hidPartId").val();
            var remark = $("#<%=this.txtRemark.ClientID%>").val();
            var ddInType =type==1? $("#<%=this.ddInType.ClientID%>").val():$("#<%=this.ddOutType.ClientID%>").val();
          
            if (partID <= 0) {
                
                $("#lblError").html("请输入可用的备件编码！");
                return false;
            }

            if(parseInt(Qty)==0){
                $("#lblError").html("请输入数量！");
               
                return false;
            }
            if (type == 2 && ddInType == 1) {
                if (remark == "") {
                    $("#lblError").html("请输入备注信息！");
                    return false;
                }
            }
            
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPart.InOut(partID,type,Qty,remark,ddInType);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            if(type==1){
                if (confirm("入库成功，是否继续操作?")) {
                    Clear();
                } else {
                    parent.window.Refresh();
                };

            }else{
                if (confirm("出库成功，是否继续操作?")) {
                    Clear();
                } else {
                    parent.window.Refresh();
                };
               
            }
           
        }
         /*选择备件*/
        function selectPart() {
            temp = 47;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=670&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }
         function getChooseValue(list) {
           if (temp == 47) {
               $("#<%=this.txtPart.ClientID %>").val(list[0][1]);
               $("#hidPartId").val(list[0][0]);
               GetPart(list[0][1]);
           }
         }
        function Clear() {
                    $("#<%=this.txtPart.ClientID%>").val("");
                    $("#hidPartId").val(0);
                    $("#<%=this.lblPartName.ClientID%>").html("");
                    $("#<%=this.lblCurrentStock.ClientID%>").html("");
                    $("#<%=this.txtQty.ClientID%>").val("");
        }
    </script>
</asp:Content>
