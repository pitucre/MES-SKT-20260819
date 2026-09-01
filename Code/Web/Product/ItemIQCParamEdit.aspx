<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="True"
    CodeBehind="ItemIQCParamEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Product.ItemIQCParamEdit" Title="Edit ItemIQCParam" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label2"><%= Resources.lang.ItemsName %></td>
            <td class="Field2">
                <asp:Label ID="lblItemName" runat="server" ClientIDMode="Static"></asp:Label>
            </td>
        </tr>
    </table>
    <br /><br />
    <div class="toolBar">
        <div class="toolbar-btn" onclick="AddParam()">
            <div class="icon-16-add"></div>
            <div class="btn-text">新增参数</div>
        </div>
    </div>

    <table id="tableParam" width="100%" class="ListTable" cellpadding="0px" cellspacing="0px" style="text-align:center">
        <thead>
            <tr class="ListTableTitle" style="text-align:center">
                <th></th><th style="width:30%">参数名称</th><th style="width:60%">参数检验标准</th><th style="width:10%">操作</th>
            </tr>
        </thead>

        <tr class="ListTableEvenRow">
            <td>
                <input type="hidden" style="display:none" value="-1" name="hdnIqcParamId"/>
            </td>

            <td>
                <input type="text"  style="width:96%" name="txtParamName" IsRequired="1" IsRepetition="0"/>
                <div style="position:relative"></div>
            </td>

            <td>
                <input type="text" style="width:96%" name="txtParamStand" IsRequired="1"/>
            </td>
            <td>
                <input type="button" value="删除" onclick="DeleteParam(this)"/>
            </td>
        </tr>
    
    </table>

    <script type="text/javascript">

        var Id = <%= Request.QueryString["Id"] == null ? -1 : Convert.ToInt32(Request.QueryString["Id"].ToString())%>
        var isRepetition = false; //是否已经有一项参数名重复

        $(document).ready(function()
        {
            ShowParamList();
        })

        //新增一个参数
        function AddParam()
        {
            var tableParam = document.getElementById("tableParam");
                
            var row , cel

                row = tableParam.insertRow(tableParam.rows.length);
                row.className = "ListTableEvenRow";

                cel = row.insertCell(0);
                cel.innerHTML = '<input type="hidden" style="display:none" value="-1" name="hdnIqcParamId"/>';

                cel = row.insertCell(1);
                cel.innerHTML = '<input type="text" style="width:96%" name="txtParamName" IsRequired="1" onblur = "CheckParamName(this)"  IsRepetition="0"/>';
                cel.innerHTML += '<div style="position:relative"></div>';

                cel = row.insertCell(2);
                cel.innerHTML = '<input type="text" style="width:96%" name="txtParamStand" IsRequired="1"/>';

                cel = row.insertCell(3);
                cel.innerHTML = '<input type="button" value="删除" onclick="DeleteParam(this)"/>';

        }

        //删除一个参数
        function DeleteParam(obj)
        {
            $(obj).parent().parent().remove();
        }

        //显示已配置参数列表
        function ShowParamList()
        {
            var tableParam = document.getElementById("tableParam");
                
            var row , cel

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxProduct.GetItemIQCParamList(Id);

            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            else if(ajax.value != null && ajax.value.length>0)
           {
                $("#tableParam tr:eq(1)").remove();
                var entity = ajax.value;
                for(var i = 0 ; i < entity.length ; i++)
                {
                    row = tableParam.insertRow( tableParam.rows.length );
                    row.className = "ListTableEvenRow";

                    cel = row.insertCell(0);
                    cel.innerHTML = '<input type="hidden" style="display:none" value="'+ entity[i].ItemIQCParamId +'" name="hdnIqcParamId"/>';

                    cel = row.insertCell(1);
                    cel.innerHTML = '<input type="text" style="width:96%;" value="'+ entity[i].ParamName +'" name="txtParamName" IsRequired="1"  onblur = "CheckParamName(this)"  IsRepetition="0"/>';
                    cel.innerHTML += '<div style="position:relative"></div>';

                    cel = row.insertCell(2);
                    cel.innerHTML = '<input type="text" style="width:96%"  value="'+ entity[i].ParamStandard +'" name="txtParamStand" IsRequired="1"/>';

                    cel = row.insertCell(3);
                    cel.innerHTML = '<input type="button" value="删除" onclick="DeleteParam(this)"/>';
                }
            }
        }

        /*检验参数名是否有重复*/
        function CheckParamName(obj)
        {
            var oldtxt = $(obj).val();
            var count = 0;

            if(isNull(oldtxt))
            {
                $(obj).css("background-color","").prop("IsRepetition","0");
                $(obj).next().html('');
                isRepetition = false;
                return false;
            }

            //如果已存在重复，那么不再往下执行。
            if(isRepetition && $(obj).prop("IsRepetition") != "1")
            {
                return false;
            }

            $("#tableParam tr").each(function(i,e)
            {
                if(i > 0)
                {
                    if(oldtxt == $(e).find("[name='txtParamName']").val())
                    {
                        count ++;
                    }
                }
            })

            if(count > 1)
            {
                isRepetition = true;
                $(obj).next().html('<div class="arrows"><%=Resources.Messages.ParamNameRepetition%></div>');
                $(obj).focus().css("background-color","yellow").prop("IsRepetition","1");
            }else
            {
                $(obj).css("background-color","").prop("IsRepetition","0");
                $(obj).next().html('');
                isRepetition = false;
            }
        }


        /*保存数据*/
        function Save() {

            //如果已存在重复，那么不再往下执行。
            if(isRepetition)
            {
                alert("<%=Resources.Messages.ParamNameRepetition%>");
                return false;
            }

            var paramXML = '<ParamList>';

                $("#tableParam tr").each(function(i,e)
                {
                    if(i > 0)
                    {
                        paramXML += '<Data>'
                            paramXML += '<IQCParamId>'+$(e).find("[name='hdnIqcParamId']").val()+'</IQCParamId>'
                            paramXML += '<ParamName>'+$(e).find("[name='txtParamName']").val()+'</ParamName>'
                            paramXML += '<ParamStandard>'+$(e).find("[name='txtParamStand']").val()+'</ParamStandard>'
                        paramXML += '</Data>'
                    }
                })

                paramXML +='</ParamList>';


            var entity = {};

            entity.ItemId = Id;
            entity.ParamName = paramXML;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxProduct.ItemIQCParamEdit(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert('<%=Resources.Messages.SaveInSuccess%>')
            parent.window.closeDialog();

        }
    </script>

</asp:Content>