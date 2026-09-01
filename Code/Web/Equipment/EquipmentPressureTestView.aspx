<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="EquipmentPressureTestView.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.EquipmentPressureTestView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div id="printContext" style="width: 100%;">
        <div class="wrap_tb" style="min-width: 600px">
            <ul class="tb">
                <li class="current" title="<%= Resources.lang.BaseInfo%>">
                    <%= Resources.lang.BaseInfo%>
                </li>
                <%-- <li title="扩展信息">扩展信息</li>--%>
            </ul>

            <div class="tb_c" style="height:45px;">
                <table class="EditeContentTable" width="100%">

                    <tr>
                        <td class="Label3">
                          <%= Resources.lang.EquipmentCode %>
                        </td>
                        <td class="Field3">
                            <asp:Label runat="server" ID="lblEquipmentCode"></asp:Label>
                        </td>
                        <td class="Label3">
                           <%= Resources.lang.EquipmentName %>
                        </td>
                        <td class="Field3">
                            <asp:Label runat="server" ID="lblEquipmentName"></asp:Label>

                        </td>
                        <td class="Label3">
                          测试周期（天）
                        </td>
                        <td  class="Field3" style="text-align: center;">
                              <asp:Label runat="server" ID="lblTestCycel"></asp:Label>
                        </td>
                    </tr>                    
                </table>
            </div>
        </div>
        <div class="wrap_tb" style="min-width: 600px">
            <ul class="tb">
                <li class="current" >校验测试记录
                </li>
            </ul>

            <div class="tb_c" >
                <table class="ListTable" id="tbCompentList" style="border-width: 0px; width: 100%; border-collapse: collapse;"
                    cellspacing="0" cellpadding="2">
                    <tr class="ListTableHeader">
                        <th scope="col" style="text-align: center;" width="160px">操作时间
                        </th>
                        <th scope="col" style="text-align: center; width: 120px;">测试人
                        </th>
                        <th scope="col" style="text-align: center;">计算公式
                        </th>
                        <th scope="col" style="text-align: center;">机台标称压力
                        </th>                         
                    </tr>
                    <tbody id="historyTb">
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <script type="text/javascript" language="javascript">
        var Id = <%= Request.QueryString["Id"] == null ? -1 : Convert.ToInt32(Request.QueryString["Id"].ToString())%>;
        $(function () {             
            getOperateRecord();
        });

        function getOperateRecord(){
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipmentPressureTest.GetInfoDtl(Id);
            if(ajax.error != null){
                alert(ajax.value.ErrorMsg);
                return false;
            }
            bulidTable(ajax.value);
        }       
         
        function bulidTable(list) {
            if (list.lenght == 0) {
                return;
            }
            var obj = $("#historyTb");
            var html = "";

            for (var i = 0; i < list.length; i++) {
                var entity = {};
                entity = list[i];
                
                html += "<tr class=\"ListTableOddRow\"><td  width=\"175px\">" + entity.TestTime + "</td><td  width=\"80px\">" + entity.Tester + "</td><td>" + entity.Equation + "</td><td >" + entity.Pressure + "</td></tr>";
            }
            obj.html(html);
        }
         
       function PrintA4() {
           var currentTitle = window.parent.$("#dlg-title").children().eq(1).text();
           var title = window.top.document.title;
           var historyHTML = window.document.body.innerHTML;
           $(".noPrint").hide();
           //$(".noPrint,#toolbar,.infoTips").hide();
           $html = $("#printContext");
           //决绝打印时，文本框不出数据问题
           $("input[type='text']", $html).each(function () {
               $(this).attr("value", $(this).val());
           });

           $("select", $html).each(function () {
               var selected = $(this).val();
               $(this).children().each(function (j, m) {
                   if ($(m).val() == selected) {
                       $(m).attr("selected", true);
                   }
               });
           });

           window.document.body.innerHTML = "<div id='printContext'>" + $html.html() + "</div>";
           window.top.document.title = "校验测试记录";
           window.print();
           window.document.body.innerHTML = historyHTML;
           
           window.top.document.title = title;
       }

        
    </script>

</asp:Content>
