<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/EditMaster.master"
    CodeBehind="ActivitiesConfigParam.aspx.cs" Inherits="SKT.LeanMES.Web.Activities.ActivitiesConfigParam" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <table class="EditeContentTable" id="tabParams" width="100%">
    </table>
    <script type="text/javascript">
        var acId = <%=Request.QueryString["ID"] %>;
        var ac_name = '<%=Request.QueryString["acname"] %>';
        var tabParam = document.getElementById("tabParams");

        $(function(){
            initParams(acId);
        });           
                
        function Save() {
            /*options list*/
            var hdnAOID = document.getElementsByName("hdnAOID");
            var txtAC_Param_Value = document.getElementsByName("txtAC_Param_Value");
            var aoidString = "", ac_param_valueString = "", seq = "^";

            for(var i=0; i < hdnAOID.length; i++){
                aoidString += hdnAOID[i].value + seq;
                ac_param_valueString += txtAC_Param_Value[i].value + seq;
            }        
            if (aoidString !=""){  
                /*save event*/
                var result = SKT.LeanMES.Web.AjaxServices.AjaxActivity.SaveConfigparams(aoidString,ac_param_valueString);
                if (result.error == null) {
                    alert("<%=Resources.Messages.SaveInSuccess %>");
                    window.parent.UpdateList(ac_name);
                }else{
                    alert("<%=Resources.Messages.UnknownError %>");
                }  
            }    
        }

        function addParams(entity) {
            var row, cell;
            row = tabParam.insertRow(tabParam.rows.length);

            cell = row.insertCell(0);
            cell.className = "Label1";
            cell.align = "right";
            cell.innerHTML = entity.AC_Param_Remark;

            cell = row.insertCell(1);
            cell.className="Field1";
            cell.align = "center";
            cell.innerHTML = "<input type=\"text\" style=\"width:180px;\" name=\"txtAC_Param_Value\" class=\"TextBox\" value=\""+entity.AC_Param_Value+"\"/><input type=\"hidden\" name=\"hdnAOID\" value=\""+entity.AOID+"\"/><span class='Tips'>(参数名：" + entity.AC_Param_Name+")</span>";
        }

        function initParams(acids){
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxActivity.GetActionByACID(acids);
            if(ajax.error == null){
                var entityAry = ajax.value;
                if (entityAry.length > 0){
                    for(var i=0; i < entityAry.length; i++){                 
                        addParams(entityAry[i]);
                    }
                }else{
                    $(tabParam).html("<tr><td class='ListTableEmptyDataRow'><%=Resources.lang.NoParameters %></td></tr>");
                }
            }else{
                alert(ajax.error.Message);
            }            
        }
    </script>
</asp:Content>
