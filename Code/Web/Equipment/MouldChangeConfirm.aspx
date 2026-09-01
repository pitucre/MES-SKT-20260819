<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="MouldChangeConfirm.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.MouldChangeConfirm" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <div class="infoTips">
     带<em>*</em>为必填项
    </div>
    <div class="wrap_tb" style="min-height: 350px; min-width: 600px">
        <ul class="tb">
            <li class="current" title="换模确认">换模确认
            </li>
        </ul>
        <div class="tb_c">
            <table class="EditeContentTable" width="100%">
                <tr>
                    <td class="Label3">换模申请单号
                    </td>
                    <td class="Field3" colspan="3">
                          <asp:Label runat="server" ID="lblChangeNo"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="Label3">换模确认结果<em>*</em>
                    </td>
                    <td class="Field3" colspan="3">
                        <input type="radio" name="rdoHege" value="0" checked="checked"/>合格 <input type="radio" name="rdoHege" value="1"/>不合格
                    </td>
                </tr>
               <tr>
                    <td class="Label3">确认换模备注
                    </td>
                    <td class="Field3" colspan="3">
                        <asp:TextBox ID="txtRemark" CssClass="TextArea" TextMode="MultiLine" runat="server"
                    ClientIDMode="Static" Width="99%" Height="75"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="Label3">准备时长(h)
                    </td>
                    <td class="Field3">
                        <asp:TextBox ID="txtPlanTime" runat="server" CssClass="TextBox" Enabled="False"></asp:TextBox>
                    </td>
                    <td class="Label3">实作时长(h)
                    </td>
                    <td class="Field3">
                        <asp:TextBox ID="txtActualTimeLength" runat="server" CssClass="TextBox" Enabled="False"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="Label3">换模确认完成时间
                    </td>
                    <td class="Field3" colspan="3">
                        <asp:TextBox ID="txtActualFinish" runat="server" CssClass="TextBox" Enabled="False"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                <td class="Label3">
                初始压制数<em>*</em>
                </td>
                <td class="Field3">
                <asp:TextBox ID="txtInitialPress" runat="server" ClientIDMode="Static"  IsRequired='1'></asp:TextBox>    
                </td>
                <td class="Label3">
                当前压制数<em>*</em>
                </td>
                <td class="Field3">
                <asp:TextBox ID="txtCurrentPress" runat="server"  ClientIDMode="Static"  IsRequired='1'></asp:TextBox>
                </td>
            </tr>
                <tr>
                    <td class="Label3">申请人
                    </td>
                    <td class="Field3">
                        <asp:TextBox ID="txtCreateBy" runat="server" CssClass="TextBox" Enabled="False"></asp:TextBox>
                    </td>
                    <td class="Label3">换模人
                    </td>
                    <td class="Field3">
                        <asp:TextBox ID="txtOperator" runat="server" CssClass="TextBox" Enabled="False"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="Label3">
                        申请换模原因
                    </td>
                    <td class="Field3" colspan="3">
                    
                        
                          <asp:TextBox ID="txtApplyRemark" CssClass="TextArea" TextMode="MultiLine" runat="server"
                    ClientIDMode="Static" Width="99%" Height="75" Enabled="False"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="Label3">
                        换模备注
                    </td>
                    <td class="Field3" colspan="3">
                          
                          <asp:TextBox ID="txtChangeOverRemark" CssClass="TextArea" TextMode="MultiLine" runat="server"
                    ClientIDMode="Static" Width="99%" Height="75" Enabled="False"> </asp:TextBox>
                      
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <input type="hidden" id="controlId" />
    <input type="hidden" id="hdCreateTime" runat="server" />
    <input type="hidden" id="hdActualStartTime" runat="server" />
     <input type="hidden" id="hdStatus" value="-1" runat="server" />
    <input type="hidden" id="hdinspecType" value="-1" />
    <script type="text/javascript" src="../Content/js/jquery-3.1.0.min.js"></script>
    <script type="text/javascript" charset="utf-8" src="../Content/plugin/jquery-easyui-1.4.2/layer/layer.js"></script>
    <style type="text/css" >
        .selectRow td {
            background-color: #C4C4C4;
        }
        .pointer {
            cursor: pointer;
        }
    </style>
    <script language="javascript" type="text/javascript">
        var Id = <%= Request.QueryString["ID"] == null ? -1 : Convert.ToInt32(Request.QueryString["ID"].ToString())%>;
        $(function () {
            
                if ($("#<%=this.hdStatus.ClientID%>").val() == 3) {
                    $(" input").attr("disabled", true);
                 
                    $("#<%=this.txtRemark.ClientID%>").attr("disabled", true);

                }
        });
        var ReqId = '<%=Request.QueryString["ID"] %>';
        $("select").css("width", "140px");

        /*保存数据*/
        function Save() {
            var isHege=$("input[name='rdoHege']:checked").val();
            var txtActualFinish= new Date($("#<%=this.txtActualFinish.ClientID %>").val().replace(/-/g, "\/"));
            var remark=$("#<%=this.txtRemark.ClientID %>").val();
            if ($("#<%=this.hdStatus.ClientID%>").val() != 2) {
                alert("换模状态非《换模中》不能确认！");
                return false;
            }
            var ajax = SKT.LeanMES.Web.Equipment.MouldChangeConfirm.Edit(Id, isHege, remark,txtActualFinish);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert('<%=Resources.Messages.SaveInSuccess %>');
            parent.window.UpdateList($("#<%=this.lblChangeNo.ClientID %>").text());
            return ajax;
        }





    </script>
</asp:Content>
