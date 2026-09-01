<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="UnHoldImport.aspx.cs" Inherits="SKT.LeanMES.Web.Hold.UnHoldImport" %>
<%--<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="ElectronicCallSet.aspx.cs" Inherits="SKT.LeanMES.Web.Client.ElectronicCallSet" %>--%>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <div class="wrap_tb" style="min-width: 650px;">
        <div class="tb_c" style="min-height: 300px; overflow: auto;">
            <%--  <div class="infoTips">
                <%=Resources.Messages.WithAsteriskIsRequired %>
            </div>--%>

            <table class="EditeContentTable" width="650px">
                <tr>
                    <td class="Label1" style="text-align: center">文件名：
                       <select id="slt" >
                           <%-- <option value=”aaa”>bbb</option>--%>
                        </select>  
                         <input type="button" value="保存" class="SearchButton" onclick="save()" />             
                    </td>
                </tr>
                
            </table>
            <div style="height: 10px"></div>
            <table class="ListTable" id="data">
                <tr class="ListTableHeader">
                    <th style="width:230px; text-align: center">编号</th>                   
                    <th style="width:230px; text-align: center">操作人</th>
                     <th style="width:230px; text-align: center">操作时间</th>
                </tr>
            </table>
        </div>
    </div>
    <script src="../Content/js/jquery.min.js" type="text/javascript"></script>
<script type="text/javascript">
       var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>"
    var msg1="";
    var msg2="";
    $(function () {
        $("#slt").change(function () {          
           var fileName=this.value
           var List = SKT.LeanMES.Web.AjaxServices.AjaxQuality.GetUnQholdALL(fileName);
            if (List.error != null) {
                alert(List.error.Message);
                return false;
            } else {
                $("#data tr:not(:first)").remove();
                for (var i = 0; i < List.value.length; i++) {

                    var setTable = document.getElementById("data");
                    row = setTable.insertRow(setTable.rows.length);
                    row.className = "ListTableOddRow";
                    cell = row.insertCell(0);
                    cell.align = "center";
                    cell.innerHTML = List.value[i].ObjectCode;

                    cell = row.insertCell(1);
                    cell.align = "center";
                    cell.innerHTML = List.value[i].OperatePerson;

                    cell = row.insertCell(2);
                    cell.align = "center";
                    cell.innerHTML = List.value[i].OperateDateTime;
                }
            }
        })
        loadFileName();

    })
    function loadFileName(){
     var fileNameList = SKT.LeanMES.Web.AjaxServices.AjaxQuality.GetFileName();
      if (fileNameList.error != null) {
                alert(fileNameList.error.Message);
                return false;
      } else {
         var list=fileNameList.value;
        $("select").append('<option value="-1" >-请选择-</option>');
         for (var i = 0; i < list.length; i++) {
             $("select").append('<option value=' + list[i].ObjectCode + ' >' + list[i].ObjectCode + '</option>');
                 }
            }
    
    }

  function save(){  
   var fileName=$("#slt").find("option:selected").text();
    if (fileName == "-请选择-") {
      alert("暂无未保存的数据!");
      return;
  }
    var SNList="";
    $("#data .ListTableOddRow").each(function(){
      SNList+=this.childNodes[0].innerText+",";    
        });
    if(SNList==""){
        alert("暂未保存的数据");
        return;
    }
   var objectFlag=4;//表示在制品
   var tag=2;//表示UnHold
    var result=SKT.LeanMES.Web.AjaxServices.AjaxQuality.SaveUnQHold(SNList, 4, userName, 2,fileName,msg1,msg2);
     if (result.error != null) {
                alert(result.error.Message);
                return false;
            } else {
                alert("<%=Resources.Messages.SaveInSuccess %>");
                                        parent.window.UnHoldLoad(result.value);
                                             window.close(); 
            }
    }
 

</script>
</asp:Content>

