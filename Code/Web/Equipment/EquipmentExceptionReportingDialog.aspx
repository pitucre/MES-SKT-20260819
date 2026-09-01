<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="EquipmentExceptionReportingDialog.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.EquipmentExceptionReportingDialog" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
<div class="infoTips">
                带<em>*</em>为必填项</div>
    <table class="EditeContentTable" width="100%">        
        <tr>
            <asp:HiddenField ID="txtHideInspectionTypeId" runat="server" />
            <asp:HiddenField ID="txtHideCreater" runat="server" />
            <asp:HiddenField ID="txtHideCreateTime" runat="server" />
            <td class="Label2">
                异常等级<em>*</em>
            </td>
            <td class="Field2" colspan="3">
                <select id="ddlExceptionReportingGrade">
                    <option value="一级异常">一级异常</option>
                    <option value="二级异常">二级异常</option>
                    <option value="三级异常">三级异常</option>
                </select>
            </td>
        </tr>
        <tr>
        <td class="Label2">
                超时时长<em>*</em>
            </td>
           <td class="Field2">                  
                <asp:TextBox runat="server" ID="txtTimeOutLength" ClientIDMode="Static" IsRequired="1" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label2">
                单位<em>*</em>
            </td>
            <td class="Field2">
                <select id="ddlTimeOutUnit">
                    <option value="分钟">分钟</option>
                    <option value="小时">小时</option>
                    <option value="天">天</option>
                </select>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                预警接收人<em>*</em>
            </td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtReportingUserName" runat="server" CssClass="TextBox" ReadOnly="true" IsRequired="1" Width="180" ClientIDMode="Static"></asp:TextBox><input type="button" class="ButtonBox" value="..." onclick="selectFirst();" />
                <asp:HiddenField ID="hdReportingUser" runat="server" ClientIDMode="Static" />
                <asp:HiddenField ID="hdReportingUserName" runat="server" ClientIDMode="Static" />
                <asp:HiddenField ID="hdReportingUserEmail" runat="server" ClientIDMode="Static" />
            </td>
        </tr>
    </table>
    <script language="javascript" type="text/javascript">

        function selectFirst() {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=12&Multiple=true&rnd=" + Math.random(), width: 700, height: 400 });
        }

        function getChooseValue(list) {
            debugger
            var hdReportingUser = "";
            var hdReportingUserName = "";
            var hdReportingUserEmail = "";
            for (var i = 0; i < list.length; i++) {
                if (list[i][7].length > 5) {
                    hdReportingUser += list[i][2] + ",";
                    hdReportingUserName += list[i][3] + ",";
                    hdReportingUserEmail += list[i][5] + ",";
                }
            }
            if (hdReportingUser == "") {
                alert("选择的人员手机号码！");
                return false;
            }
            /*去掉最后一个逗号*/
            hdReportingUser = hdReportingUser.substring(0, hdReportingUser.length - 1);
            hdReportingUserName = hdReportingUserName.substring(0, hdReportingUserName.length - 1);
            hdReportingUserEmail = hdReportingUserEmail.substring(0, hdReportingUserEmail.length - 1);

            $("#hdReportingUser").val(hdReportingUser);
            $("#hdReportingUserName").val(hdReportingUserName);
            $("#hdReportingUserEmail").val(hdReportingUserEmail);
            $("#txtReportingUserName").val(hdReportingUserName);
        }

        /*保存数据*/
        function Save() {
            var entity = {};
            entity.ExceptionReportingGrade = $("#ddlExceptionReportingGrade").val();
            entity.ReportingUser = $("#hdReportingUser").val();
            entity.ReportingUserEmail = $("#hdReportingUserEmail").val();
            entity.ReportingUserName = $("#hdReportingUserName").val();
            entity.TimeOutLength = $("#txtTimeOutLength").val();
            entity.TimeOutUnit = $("#ddlTimeOutUnit").val();

            parent.SetValue(entity);
        }
    </script>
</asp:Content>
