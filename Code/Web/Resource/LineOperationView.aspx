<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="true" CodeBehind="LineOperationView.aspx.cs" Inherits="SKT.LeanMES.Web.Resource.LineOperationView" %>
<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="server">
 <table width="100%" class="EditeContentTable">

        <tr>
            <td class="Label1">
                作业编号<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtSectionName" runat="server" CssClass="TextBox" Enabled="false"></asp:TextBox>
                <input type="button" id="btnSectionName" class="ButtonBox" value="..." onclick="selectSectionName();" />
            </td>
           
        </tr>
    </table>
    <div class="clear5">
    </div>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label" style="width: 45%; text-align: center; font-weight: bold;">
                <strong>
                    <label id="lbleft">
                        可选择的线别
                    </label>
                </strong>
            </td>
            <td class="Label" style="width: 10%; text-align: center;" id="tdMsg">
            </td>
            <td class="Label" style="width: 45%; text-align: center; font-weight: bold;">
                <label id="lbright">
                    已选择的线别
                </label>
            </td>
        </tr>
        <tr style="height: 300px; padding: 2px;" valign="top">
            <td class="Field" align="center" style="width: 45%; vertical-align: top; overflow:auto; height:360px">
                <iframe name="frmUserChooseList" id="frmLeftChooseList" frameborder="0" style="width: 99%;
                    height: 360px;" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Resource/SectionChooseList.aspx"></iframe>
            </td>
            <td class="Field" style="width: 10%; text-align: center; vertical-align: middle;">
                <input type="button" id="btnLeftChoose" runat="server" value=" >> " class="SearchButton"
                    onclick="btnChooseOnClick(0);" />
                <br />
                <br />
                <br />
                <br />
                <input type="button" id="btnRightChoose" runat="server" value=" << " class="SearchButton"
                    onclick="btnChooseOnClick(1);" />
            </td>
            <td class="Field" align="center" style="width: 45%; vertical-align: top; overflow:auto; height:360px">
                <iframe name="frmRoleUsersList" id="frmRightUsersList" frameborder="0" style="width: 99%;
                    height: 360px;" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Resource/SectionChooseList.aspx"></iframe>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        var iframe1 = document.getElementById("frmLeftChooseList");
        var iframe2 = document.getElementById("frmRightUsersList");
        var workseq = "";


        /*选择工段*/
        function selectSectionName() {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=50&Multiple=false&rnd=" + Math.random(), width: 600, height: 340 });
        }

        function getChooseValue(list) {

            $("#<%=this.txtSectionName.ClientID %>").val(list[0][1]);
            workseq = list[0][1];
            loadRelationList();
        }


        function loadRelationList() {
            iframe1.src = "";
            iframe2.src = "";
            setMsg("", "");

            iframe1.src = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + '/Resource/SectionChooseList.aspx?workseq=' + workseq + "&flag=1";
            iframe2.src = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + '/Resource/SectionChooseList.aspx?workseq=' + workseq + "&flag=2";
        }

        function setMsg(msg, color) {
            $("#tdMsg").html(msg).css("color", color);
        }

        /*左右移动,index为0是左向右移，1为右向左移*/ 
        function btnChooseOnClick(index) {
            /*取到的id字符串*/
            var chooseId = "";
            if (index == 0) {
                chooseId = document.frames[0].window.getSelectedValues();
            }
            else if (index == 1) {
                chooseId = document.frames[1].window.getSelectedValues();
            }
            if (chooseId == "") {
                alert("<%= Resources.Messages.RequireOperateRecord %>");
                return false;
            }

            //左移到右，添加
            if (index == 0) {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSectionLine.InsertToSectionLine(chooseId, workseq);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
            }

            //右移到左，删除
            else {
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSectionLine.DeleteSectionLine(chooseId, workseq);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
            }
            loadRelationList();
        }
    </script>
</asp:Content>
