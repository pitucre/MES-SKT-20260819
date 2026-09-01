<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="True"
    CodeBehind="ESOPAuditList.aspx.cs" Inherits="SKT.LeanMES.Web.ESOP.ESOPAuditList" Title="Parts List Page" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" Runat="Server">
    <script src="../Content/js/jquery.media.js" type="text/javascript"></script>
    <style type="text/css">

 #layermsg {
            position: absolute;
            width:1000px;
            height:800px;
            margin-top:-250px; 
            display:none;
            z-index:999;
        }
      
        #layer { 
            background-color:#F1F3F8; 
            left:0; 
            opacity:0.8; 
            position:absolute; 
            top:0; 
            z-index:3; 
            filter:alpha(opacity=80); 
            -moz-opacity:0.8; 
            -khtml-opacity:0.8; 
            display:none;
        } 
 #dialogMaintain{display:none;}
 #dialogUpdateTerm{display:none;}
  #dialogApproval{display:none;}
</style> 
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
         <tr>
           
            <td class="Label3">审核单号</td>
            <td class="Field3">
                <asp:TextBox ID="txtAuditNo" runat="server" CssClass="TextBox"></asp:TextBox>
            </td> 
            <td class="Label3">ESOP名称</td>
            <td class="Field3">
                <asp:TextBox ID="txtESOPName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td> 
            <td class="Label3">ESOP工序</td>
            <td class="Field3">
                <asp:TextBox runat="server" ID="txtESOPStationName" CssClass="TextBox"  ></asp:TextBox>
            </td> 
        </tr>
        <tr>
            <td class="Label3">审核结果
            </td>
            <td class="Field3">
                <asp:DropDownList runat="server" ID="ddlIsEnableName">
                    <asp:ListItem Value="-1">全部</asp:ListItem>
                    <asp:ListItem Value="启用">启用</asp:ListItem>
                    <asp:ListItem Value="未启用">未启用</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td class="Label3">审核状态
            </td>
            <td class="Field3">
                <asp:DropDownList runat="server" ID="ddlAuditStates">
                    <asp:ListItem Value="-1">全部</asp:ListItem>
                    <asp:ListItem Value="待审核">待审核</asp:ListItem>
                    <asp:ListItem Value="已审核">已审核</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td class="Label3">批准状态
            </td>
            <td class="Field3">
                <asp:DropDownList runat="server" ID="ddlApprovalStates">
                    <asp:ListItem Value="待批准">待批准</asp:ListItem>
                    <asp:ListItem Value="-1">全部</asp:ListItem>
                    <asp:ListItem Value="通过">通过</asp:ListItem>
                    <asp:ListItem Value="不通过">不通过</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
    </table>
    <div id="dialogUpdateTerm" title="ESOP审核">
        <table class="EditeContentTable" width="100%">
                <tr>
                    <td class="Label1">审核结果<em>*</em></td>
                    <td class="Field1">
                        <asp:DropDownList runat="server" ID="ddlIsEnableNameSave">
                            <asp:ListItem Value="-1">--请选择--</asp:ListItem>
                            <asp:ListItem Value="1">启用</asp:ListItem>
                            <asp:ListItem Value="0">不启用</asp:ListItem>
                        </asp:DropDownList>
                    </td> 
                </tr>
                <tr>
                    <td class="Label1">审核备注</td>
                    <td class="Field1">
                        <asp:TextBox ID="txtAuditRemark" runat="server" CssClass="TextArea" TextMode="MultiLine"  MaxLength="50" Width="200px" Height="100px"></asp:TextBox>
                    </td> 
                </tr>
                <tr>
                    <td class="Label1" colspan="2">
                        <input id="btnSavedialogUpdateTerm" type="button" onclick="SavedialogUpdateTerm()" value="确认审核" />&nbsp;&nbsp;
                    </td>
                </tr>
          </table>
    </div>
    <div id="dialogApproval" title="ESOP批准">
        <table class="EditeContentTable" width="100%">
                <tr>
                    <td class="Label1">批准结果<em>*</em></td>
                    <td class="Field1">
                        <asp:DropDownList runat="server" ID="ddlIsEnableApproval">
                            <asp:ListItem Value="-1">--请选择--</asp:ListItem>
                            <asp:ListItem Value="1">通过</asp:ListItem>
                            <asp:ListItem Value="0">不通过</asp:ListItem>
                        </asp:DropDownList>
                    </td> 
                </tr>
                <tr>
                    <td class="Label1">批准备注</td>
                    <td class="Field1">
                        <asp:TextBox ID="txtApprovalRemark" runat="server" CssClass="TextArea" TextMode="MultiLine"  MaxLength="50" Width="200px" Height="100px"></asp:TextBox>
                    </td> 
                </tr>
                <tr>
                    <td class="Label1" colspan="2">
                        <input id="btnSavedialogApproval" type="button" onclick="SavedialogApproval()" value="确认批准" />&nbsp;&nbsp;
                    </td>
                </tr>
          </table>
    </div>
    <div id="layer"></div>
     <div id="layermsg" >     
     
      </div>  
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" Runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" OnRowDataBound="GridView1_OnRowDataBound" Style="table-layout: fixed; word-wrap: break-word; word-break: break-all">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="AuditNo" HeaderText="审核单号" HeaderStyle-Width="130"  />
            <asp:BoundField DataField="ESOPName" HeaderText="ESOP名称" HeaderStyle-Width="120" />
            <asp:BoundField DataField="StationName" HeaderText="ESOP工序" HeaderStyle-Width="70" />
            <%--<asp:BoundField DataField="ESOPFileName" HeaderText="文件名称" HeaderStyle-Width="120" />--%>
            <asp:TemplateField HeaderText="文件预览" ItemStyle-Wrap="false" HeaderStyle-Width="120">
                <ItemTemplate>
                   <%-- <%#Eval("ESOPFileNameURL")%>--%>
                    <%--<a class='media' href="../UploadFiles/ESOP/中电五十八所MES项目整体计划V1.1.pdf" target="_blank">阿斯顿撒旦撒旦</a>--%>
<%--                    <img src ="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/ESOP/DownLoad.aspx?fileName=<%#Eval("ESOPFileName")%>"  onclick='showPic(this.src)' style='width:60px; height:50px; cursor:pointer;' />--%>
                    <a href='javascript:void(0)'  class="down-load" onclick='showPic(this)' ><%#Eval("ESOPFileName")%></a>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="AuditStates" HeaderText="审核状态" HeaderStyle-Width="50" />
            <asp:BoundField DataField="IsEnableName" HeaderText="审核结果" HeaderStyle-Width="50" />
            <asp:BoundField DataField="AuditUserName" HeaderText="审核人" HeaderStyle-Width="50" />
            <asp:BoundField DataField="AuditDatatime" HeaderText="审核时间"  DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" HeaderStyle-Width="140" />
            <asp:BoundField DataField="AuditRemark" HeaderText="审核备注" HeaderStyle-Width="120" />
            <asp:BoundField DataField="ApprovalUser" HeaderText="批准人" HeaderStyle-Width="50" />
            <asp:BoundField DataField="IsEnableApproval" HeaderText="批准结果" HeaderStyle-Width="60" />
            <asp:BoundField DataField="ApprovalDatatime" HeaderText="批准时间"  DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" HeaderStyle-Width="140" />
            <asp:BoundField DataField="ApprovalRemark" HeaderText="批准备注" HeaderStyle-Width="120" />
            <asp:BoundField DataField="ModifyBy" HeaderText="修改人"  DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" HeaderStyle-Width="140" />
            <asp:BoundField DataField="ModifyDate" HeaderText="修改时间" HeaderStyle-Width="120" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" 
        StartRowIndexParameterName="startRow" MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" 
        TypeName="SKT.LeanMES.ESOP.BLL.ESOPFile" SelectMethod="GetAllAuditList" SelectCountMethod="GetCount">
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
      
        $(function(){
        
          
      $(".down-load").parent().attr("style","");
        
        
        })
      

        //审核
        function ESOPAudit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            //xiang.yan 2024-4-26  列取值由索引改为列明
            // 5 改为 AuditStates
            var AuditName = getOneRecordCellTextByFiled("AuditStates");
            if (AuditName == "已审核") {
                alert("选择的ESOP已审核！");
                return;
            }
            $("#dialogUpdateTerm").dialog({
                resizable: false,
                height: 300,
                width: 400,
                modal: true
            });
        }
        //批准
        function ESOPApproval() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            //xiang.yan 2024-4-26  列取值由索引改为列明
            // 5 改为 AuditStates
            // 6 改为 IsEnableName
            var AuditName = getOneRecordCellTextByFiled("AuditStates");
            var AuditResult = getOneRecordCellTextByFiled("IsEnableName");
            if (AuditName == "待审核") {
                alert("请先进行ESOP审核！");
                return;
            }
            if (AuditResult == "未启用") {
                alert("ESOP审核为不通过，不需要进行批准操作！");
                return;
            }
            $("#dialogApproval").dialog({
                resizable: false,
                height: 300,
                width: 400,
                modal: true
            });
        }
        //保存审核
        function SavedialogUpdateTerm() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            var IsEnableName = $("#<%=this.ddlIsEnableNameSave.ClientID%>").val();
            var AuditRemark = $("#<%=this.txtAuditRemark.ClientID%>").val();
            if (IsEnableName == "" || IsEnableName == "-1") {
                alert("请选择是否启用ESOP！");
                return;
            }
            var entity = {};
            entity.ESOPId = idStr;
            entity.IsEnableName = IsEnableName;
            entity.AuditRemark = AuditRemark;
            entity.UserName = userName;
            var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("Prod_ESOP_AuditSave", JSON.stringify(entity));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert("ESOP审核成功！");
            $("#dialogUpdateTerm").dialog("close");
            document.forms[0].submit();
        }

        //保存批准
        function SavedialogApproval() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            var myIsEnableApproval = $("#<%=this.ddlIsEnableApproval.ClientID%>").val();
            var myApprovalRemark = $("#<%=this.txtApprovalRemark.ClientID%>").val();
            if (myIsEnableApproval == "" || myIsEnableApproval == "-1") {
                alert("请选择批准结果！");
                return;
            }
            var entity = {};
            entity.ESOPId = idStr;
            entity.IsEnableApproval = myIsEnableApproval;
            entity.ApprovalRemark = myApprovalRemark;
            entity.UserName = userName;
            var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("Prod_ESOP_ApprovalSave", JSON.stringify(entity));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert("ESOP批准成功！");
            $("#dialogApproval").dialog("close");
            document.forms[0].submit();
        }

        //预览图片
        function showPic(obj) {
            var fileName = $(obj).text();
            var picUrl = GetFilePath("", fileName);
            var n = 0;
            if (picUrl.indexOf('.') > 0) {
                var n = picUrl.lastIndexOf(".");
            }
            var imgArr = ['png', 'jpg', 'jpeg', 'bmp', 'gif'];
            var ext = picUrl.substring(n + 1);
            if (imgArr.indexOf(ext.toLowerCase()) !== -1) {
                    var picContent = "<div id='divClose' title='关闭'>X</div><img src=" + picUrl + " />";
                    var bodyheight = $("body").height();
                    var bodywidth = $("body").width();

                    $("#layermsg").html(picContent).show();
                    $("#layermsg").bind("click", function () { $("#layermsg,#layer").hide(); });
                    $("#layer").css({
                        height: bodyheight,
                        width: bodywidth,
                        display: "block"
                    });
                    $("#layermsg").css({
                        "text-align": "center",
                        "margin-top": "10px",
                         height: bodyheight-100,
                         width: bodywidth - 100
                         
                    });

            } else {
                window.open(picUrl);
            }
        }

        //删除预览PDF
        function delelPDF(fileName) {
            //删除缓存文件
            setTimeout(function () {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEsop.DeleteFtpFile(fileName);
            }, 10000);
        }
       
    </script>
</asp:Content>

