<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/EditMaster.master"
    CodeBehind="ResourceManageEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Resource.ResourceManageEdit" %>


<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">

    <div style="min-width: 600px; min-height: 300px;">

        <div class="wrap_tb">

            <div class="tb_c">
                <div class="infoTips">
                    <%=Resources.Messages.WithAsteriskIsRequired %>
                </div>
                <table class="EditeContentTable" id="tblExpand" width="100%">

                    <tr>
                        <td class="Label2">产品编码<em>*</em>
                        </td>
                        <td class="Field2">
                            <asp:TextBox ID="txtItemCode" runat="server" CssClass="TextBox" Enabled="false" IsRequired='1'  ClientIDMode="Static"></asp:TextBox><input
                                type="button" id="btnSelectItem" class="ButtonBox" value="..." title="选择产品"
                                onclick="selectItem();" />
                            <asp:HiddenField ID="hdnItemId" runat="server" Value="-1" ClientIDMode="Static" />
                        </td>
                        <td class="Label2">产品名称<em>*</em>
                        </td>
                        <td class="Field2">
                            <asp:Label runat="server" ID="lblItemName"></asp:Label>
                        </td>
                    </tr>
                    <tr>

                        <td class="Label2">产品规格<em>*</em>
                        </td>
                        <td class="Field2">
                            <asp:Label runat="server" ID="lblItemSpec"></asp:Label>
                        </td>
                       <%-- <td class="Label2">工序<em>*</em>
                        </td>
                        <td class="Field2">
                            <asp:TextBox ID="txtStation" runat="server" CssClass="TextBox" ClientIDMode="Static"
                                IsRequired='1'></asp:TextBox><input type="button" id="btnStation" class="ButtonBox" value="..." title="选择工作工序"
                                    onclick="selectStation();" />
                            <asp:HiddenField ID="hdnStationId" runat="server" Value="-1" ClientIDMode="Static" />
                        </td>--%>
                        
                        <td class="Label2">资源<em>*</em>
                        </td>
                        <td class="Field2">
                            <span id="spanRes" >
                                <asp:TextBox ID="txtResName" runat="server" CssClass="TextBox" ClientIDMode="Static"
                                             IsRequired='1'></asp:TextBox><input
                                                                              type="button" id="btnRes" class="ButtonBox" value="..." title="选择资源"
                                                                              onclick="selectRes();" />
                                <asp:HiddenField ID="hdnResourceId" runat="server" Value="-1" ClientIDMode="Static" />
                            </span>
                        </td>
                       <%--  <td class="Label2">线别<em>*</em></td>
                        <td class="Field2">
                            <asp:TextBox ID="txtLineName" runat="server" CssClass="TextBox" IsRequired='1' Enabled="false" ClientIDMode="Static"></asp:TextBox><input
                                type="button" id="btnSelectDefaultOpt" class="ButtonBox" value="..." title="选择线别"
                                onclick="selectLine();" />
                            <asp:HiddenField ID="hdnLineId" runat="server" Value="-1" ClientIDMode="Static" />
                        </td>--%>
                    </tr>
                  <%--  <tr>
                        <td class="Label2">资源<em>*</em>
                        </td>
                        <td class="Field2">
                            <span id="spanRes" style="display: none;">
                                <asp:TextBox ID="txtResName" runat="server" CssClass="TextBox" ClientIDMode="Static"
                                    IsRequired='1'></asp:TextBox><input
                                        type="button" id="btnRes" class="ButtonBox" value="..." title="选择资源"
                                        onclick="selectRes();" />
                                <asp:HiddenField ID="hdnResourceId" runat="server" Value="-1" ClientIDMode="Static" />
                            </span>
                        </td>
                        <td class="Label2">面别<em>*</em></td>
                        <td class="Field2">
                             <asp:DropDownList ID="ddlLayout" runat="server" CssClass="TextBox" IsRequired='1'>
                            </asp:DropDownList>
                        </td>
                    </tr>--%>
                    <%-- <tr>
                        <td class="Label2"><%= Resources.lang.EquipmentCode %><em>*</em></td>
                        <td class="Field2">
                            <asp:TextBox ID="txtEqCode" runat="server" CssClass="TextBox"
                                ReadOnly="true"></asp:TextBox><input type="button" id="btnEquipmentCode" class="ButtonBox"
                                    value="..." onclick="selectEquiment()" title="选择设备" />
                              <asp:HiddenField ID="hdnEquimentId" runat="server" Value="-1" ClientIDMode="Static" />
                        </td>
                        <td class="Label2"><%= Resources.lang.EquipmentName %><em>*</em></td>
                        <td class="Field2">
                            <asp:Label runat="server" ID="lblEqName"></asp:Label>

                        </td>
                    </tr>--%>
                    <%--<tr>
                        <td class="Label2">线别<em>*</em></td>
                        <td class="Field2" colspan="3">
                            <asp:TextBox ID="txtLineName" runat="server" CssClass="TextBox" Enabled="false" ClientIDMode="Static" ></asp:TextBox><input
                                type="button" id="btnSelectDefaultOpt" class="ButtonBox" value="..." title="选择线别"
                                onclick="selectLine();" />
                            <asp:HiddenField ID="hdnLineId" runat="server" Value="-1" ClientIDMode="Static" />
                        </td>

                    </tr>--%>
                    <tr>
                        <td class="Label2">前置时间<em>*</em></td>
                        <td class="Field2">
                            <asp:TextBox runat="server" ID="txtFrontTime" Text="0" Width="110px" IsNumber="1"></asp:TextBox>
                            <asp:DropDownList runat="server" ID="drpFrontTime" ClientIDMode="Static">
                                 <asp:ListItem Value="Minute" Text="<%$ Resources:lang,Min %>"></asp:ListItem>
                                <asp:ListItem Value="Second" Text="<%$ Resources:lang,Second %>"></asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td class="Label2">后置时间<em>*</em>
                        </td>
                        <td class="Field2">
                            <asp:TextBox ID="txtPostTime" runat="server" Text="0" CssClass="TextBox" Width="110px" ClientIDMode="Static"
                                IsRequired='1' IsNumber="1"></asp:TextBox>
                            <asp:DropDownList runat="server" ID="drpPostTime" ClientIDMode="Static">
                                <asp:ListItem Value="Minute" Text="<%$ Resources:lang,Min %>"></asp:ListItem>
                                <asp:ListItem Value="Second" Text="<%$ Resources:lang,Second %>"></asp:ListItem>
                            </asp:DropDownList>
                        </td>

                    </tr>
                    <tr>
                        <td class="Label2">产能<em>*</em>
                        </td>
                        <td class="Field2">
                            <asp:TextBox ID="txtCapacity" runat="server" IsNumber="1" Width="95px" CssClass="TextBox" ClientIDMode="Static"
                                IsRequired='1'></asp:TextBox>
                            <asp:DropDownList runat="server" ID="drpCapacity" ClientIDMode="Static">
                                 <asp:ListItem Value="Hour">Hour</asp:ListItem>
                                 <asp:ListItem Value="Minute">Minute</asp:ListItem>
                                <asp:ListItem Value="Day">Day</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td class="Label2">工作效率因子<em>*</em>
                        </td>
                        <td class="Field2">
                            <asp:TextBox ID="txtEfficiencyFactor" runat="server" IsNumber="1" CssClass="TextBox" ClientIDMode="Static"
                                IsRequired='1'></asp:TextBox>
                        </td>
                    </tr>
                    <tr style="height:39px">
                        
                        <td class="Label2">SMT</td>
                        <td class="Field2">
                            <asp:Label runat="server" ID="lblIsSmt"></asp:Label>
                        </td>
                        <td class="Label2 IsSmtCss" > 面别<em>*</em></td>
                        <td class="Field2 IsSmtCss">
                           <asp:DropDownList ID="ddlLayout" runat="server" CssClass="TextBox"  IsRequired="1">
                            </asp:DropDownList>
                        </td>
                       


                    </tr>
                     <tr>
                        <td class="Label2">激活状态<em>*</em></td>
                        <td class="Field2">
                            <asp:DropDownList runat="server" ID="drpActiveState" ClientIDMode="Static">
                                 <asp:ListItem Value="0" Text="<%$ Resources:lang,Yes %>"></asp:ListItem>
                                 <asp:ListItem Value="1" Text="<%$ Resources:lang,No %>"></asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td class="Label2">优先级<em>*</em>
                        </td>
                        <td class="Field2" colspan="3">
                            <asp:TextBox ID="txtPriority" runat="server" CssClass="TextBox" ClientIDMode="Static"  Text="100"
                                IsRequired='1' IsNumber="1"></asp:TextBox>
                        </td>


                    </tr>
                    <tr>
                        <td class="Label2">
                            <%=Resources.lang.Description%>
                        </td>
                        <td class="Field2" colspan="3">
                            <asp:TextBox ID="txtRemark" runat="server" CssClass="TextArea" TextMode="MultiLine"
                                ClientIDMode="Static" Width="450px" Height="90px"></asp:TextBox>
                        </td>

                    </tr>
                </table>
            </div>
        </div>
    </div>
    <link href="../Content/plugin/tabs/tabs.css" rel="stylesheet" type="text/css" />
    <script src="../Content/plugin/tabs/jPlugin-tabs.js" type="text/javascript"></script>
    <script type="text/javascript">
        var resId = '<%=Request.QueryString["ID"] %>';
        var isCopy='<%=Request.QueryString["Action"] %>';
        var tab = document.getElementById("tblExpand");
        var CategoryType = <%=CategoryType%>;
        var flag = -1;
        var rowIndex = -1;
        var rowObj = null;
        var isMultiple = false;

        function IsShowSmt() {
            if ($("#<%=this.lblIsSmt.ClientID%>").text() == "是") {
                $(".IsSmtCss").show();
            } else {
                $(".IsSmtCss").hide();
            }
        }
        $(function() {
            if (resId > 0) {
                $("#spanRes").show();
            }
            else{
                isMultiple = true;//新增时线别和资源均可以多选
            }
            IsShowSmt();
          

            //if ($("#chkIsSMT").prop("checked")) {
            //    $(".IsSmtCss").show();
            //} else {
            //    $(".IsSmtCss").hide();
            //}

            //$("#chkIsSMT").click(function () {
            //    if ($("#chkIsSMT").prop("checked")) {
            //    $(".IsSmtCss").show();
            //} else {
            //    $(".IsSmtCss").hide();
            //} });

            if (isCopy != "") {
                resId = -1;
            }
        });
       
        /*选择线别*/
        function selectLine() {
            flag = 1;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=21&Multiple="+isMultiple+"&rnd=" + Math.random(), width: 600, height: 300 });
        }

        /*选择产品*/
        function selectItem() {
            flag = 3;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=1&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }

        /*选择工序*/
        function selectStation() {
            flag = 4;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=8&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }

        /*选择资源*/
        function selectRes() {
            flag = 6;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=6&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }

        /*设置从选择窗口选取的值*/
        function getChooseValue(list) {
            var idStr = "";
            var valStr = "";
            if (flag == 1) {//线别

                if (list.length > 0) {
                    for (var i = 0; i < list.length; i++) {
                        idStr += list[i][0] + ",";
                        valStr += list[i][1] + ",";
                    }
                    idStr = idStr.substring(0, idStr.length - 1);
                    valStr = valStr.substring(0, valStr.length - 1);
                }
                 
             <%--   $("#<%=this.hdnLineId.ClientID%>").val(idStr);
                $("#<%=this.txtLineName.ClientID%>").val(valStr);--%>
              <%--  $("#<%=this.hdnResourceId.ClientID%>").val(-1);
                $("#<%=this.txtResName.ClientID%>").val("");--%>
                $("#spanRes").show();
            }else if (flag == 3) {
               
                $("#<%=this.hdnItemId.ClientID%>").val(list[0][0]);
                $("#<%=this.txtItemCode.ClientID%>").val(list[0][2]);
                $("#<%=this.lblItemName.ClientID%>").text(list[0][1]);
                $("#<%=this.lblItemSpec.ClientID%>").text(list[0][6]);
                $("#<%=this.lblIsSmt.ClientID%>").text(list[0][7]);
                IsShowSmt();
            } else if(flag==4) {
              <%--  $("#<%=this.hdnStationId.ClientID%>").val(list[0][0]);
                $("#<%=this.txtStation.ClientID%>").val(list[0][1]);--%>
            }else if (flag == 6) {//资源
                if (list.length > 0) {
                    for (var i = 0; i < list.length; i++) {
                        idStr += list[i][0] + ",";
                        valStr += list[i][1] + ",";
                    }
                    idStr = idStr.substring(0, idStr.length - 1);
                    valStr = valStr.substring(0, valStr.length - 1);
                }
              $("#<%=this.hdnResourceId.ClientID%>").val(idStr);
                $("#<%=this.txtResName.ClientID%>").val(valStr);
                $("#<%=this.txtPriority.ClientID%>").val(list[0][3]);
          
            }
    flag = -1;
}

/*保存*/
function Save() {
    var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
          
            var txtItemCode=$("#<%=this.txtItemCode.ClientID%>").val();
           
            var txtFrontTime=$("#<%=this.txtFrontTime.ClientID%>").val();
            var txtPostTime=$("#<%=this.txtPostTime.ClientID%>").val();
            var txtCapacity = $("#<%=this.txtCapacity.ClientID%>").val();
            var drpFrontTime=$("#<%=this.drpFrontTime.ClientID%>").val();  //前置时间单位
            var drpPostTime=$("#<%=this.drpPostTime.ClientID%>").val();     //后置时间单位

        <%--    var hdnLineId = $("#<%=this.hdnLineId.ClientID%>").val();--%>
            var hdnItemId=$("#<%=this.hdnItemId.ClientID%>").val();
            var hdnResourceId = $("#<%=this.hdnResourceId.ClientID%>").val();
           
            var hdnStationId = -1;
            var txtEfficiencyFactor=$("#<%=this.txtEfficiencyFactor.ClientID%>").val();
            var txtPriority=$("#<%=this.txtPriority.ClientID%>").val();
            var txtRemark=$("#<%=this.txtRemark.ClientID%>").val();
            var drpCapacity=$("#<%=this.drpCapacity.ClientID%>").val(); //产能单位
            var face = $("#<%=this.ddlLayout.ClientID%>").val();
         <%--   var lineId=$("#<%=this.hdnLineId.ClientID%>").val();--%>
            var drpActiveState=$("#<%=this.drpActiveState.ClientID%>").val(); //激活状态

              if (isNull(face))
            {
               alert("<%= Resources.Messages.WithAsteriskIsRequiredAlert %>");
               return false;
            }
            var entity = {};
            entity.Id = resId;
            entity.ItemId = hdnItemId;
            entity.ResourceIdArr = hdnResourceId;
            entity.LineId = -1;
            entity.StationId =hdnStationId;
            entity.EfficiencyFactor = txtEfficiencyFactor;
            entity.Priority = txtPriority;
            entity.FrontTime = txtFrontTime;
            entity.PostTime = txtPostTime;
            entity.Capacity = txtCapacity;
            entity.CreateBy = userName;
            entity.Remark = txtRemark;
            entity.FrontUnit = drpFrontTime;
            entity.PostUnit = drpPostTime;
            entity.CapacityUnit = drpCapacity;
            entity.Face = face;
            entity.ResourceId = hdnResourceId;
            entity.ActiveState = drpActiveState;
            entity.IsSmt =$("#<%=this.lblIsSmt.ClientID%>").text()=='是'?1:0;
            var ajax = SKT.LeanMES.Web.Resource.ResourceManageEdit.Edit(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            if (confirm("保存成功，是否继续新增?")) {
                SetVal();
            } else {
                window.parent.UpdateList(txtItemCode);
            }
            // alert("<%=Resources.Messages.SaveInSuccess %>");
            
        }

        function SetVal() {
          <%--  $("#<%=this.hdnLineId.ClientID%>").val(-1);--%>
           $("#<%=this.hdnResourceId.ClientID%>").val(-1);
           <%-- $("#<%=this.txtLineName.ClientID%>").val("");--%>
          $("#<%=this.txtResName.ClientID%>").val("");
            resId = -1;
        }

      
    </script>
</asp:Content>
