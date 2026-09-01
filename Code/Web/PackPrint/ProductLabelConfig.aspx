<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="ProductLabelConfig.aspx.cs" Inherits="SKT.LeanMES.Web.PackPrint.ProductLabelConfig" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">
                产品类型
            </td>
            <td class="Field2">
                <asp:DropDownList ID="ddlItemType" runat="server">
                </asp:DropDownList>
            </td>
            <td class="Label2">
                产品编码
            </td>
            <td class="Field2">
                <asp:Label ID="txtItemCode" runat="server" CssClass="Label"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                产品名称
            </td>
            <td class="Field2">
                <asp:Label ID="txtItemName" runat="server" CssClass="Label"></asp:Label>
            </td>
            <td class="Label2">
                版本
            </td>
            <td class="Field2">
                <asp:Label ID="txtItemRev" runat="server" CssClass="Label"></asp:Label>
            </td>
        </tr>
    </table>
    <div class="clear5">
    </div>
    <table class="ListTable" cellspacing="0" cellpadding="4" style="border-width: 0px;
        min-width: 600px; width: 100%; overflow: auto; border-collapse: collapse;" id="tbPackLevel">
        <tr class="ListTableHeader">
            
            <th scope="col" align="center">
            </th>
            <th scope="col" align="center">
                项目
            </th>
            <th scope="col" align="center">
                备注
            </th>
        </tr>
    </table>
    <script type="text/javascript">

        var tab = document.getElementById("tbPackLevel");
        var condition = "";
        //全局变量ID
        var cONTAINERId = -1;
        var listtype;
        $(function () {        
            cONTAINERId=<% =Request.QueryString["ID"]%>;
            listtype=<%=Request.QueryString["listtype"]%>;
            initItemOnHold(cONTAINERId);
        });

    //实例化Table
    function initItemOnHold(Id){
        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxServiceListingConfig.GetListingConfigs(Id,listtype);
        if(ajax.error == null){
            var entityAry = ajax.value;
            for(var i=0; i < entityAry.length; i++){
                addPackLevelDetail(entityAry[i]);
            }
        }else{
            alert(ajax.error.Message);
            return false;
        }
     }

    function Save()
    {       
        var listingConfigs=[];
        var s={};
        var trList = $("#tbPackLevel").find("tr");
        var sn=$("#ContentPlaceHolder1_EditContent_txtItemCode")[0].outerText;
        var errorMessage='';        

        //从第2行开始，止点不用加1了
        for (var i=1;i<trList.length;i++) {
            s={};
            var tdArr = trList.eq(i).find("td");
            var isCheck = tdArr.eq(0).find("input[type='checkbox']")[0].checked; 
            var listingFieldId=tdArr.eq(1).find("input[type='hidden']")[0].value;  
            var listingDetailId=tdArr.eq(1).find("input[type='hidden']")[1].value;  
            var listingDetailField=tdArr.eq(2).find("input[type='text']")[0].value;

            if(isCheck==false)//只有选择了保存
             {
                 tdArr.eq(1).find("input[type='hidden']")[1].value="0"; 
                 if(i==trList.length-1&&listingConfigs.length<=0)//如果没有勾选的则传入产品与类型，以完成存储过程删除操作
                   {
                     s.ListingDetailId=-1;
                     s.ItemId= cONTAINERId;
                     s.ListingFieldId=listingFieldId;
                     s.FildValue="";
                     s.FieldType="";
                     s.FileldValueFormula="";
                     s.Oporater="";
                     listingConfigs.push(s);
                  }
                continue;
             }   

            s.ListingDetailId=listingDetailId;
            s.ItemId= cONTAINERId;
            s.ListingFieldId=listingFieldId;
            s.FildValue=listingDetailField;
            s.FieldType="";
            s.FileldValueFormula="";
            s.Oporater="<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>";
                               
            listingConfigs.push(s);
        }
        if(errorMessage!="")
        {
           alert(errorMessage);        
           return;
        }
        //保存到后台数据库中
        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxServiceListingDetail.EditListingConfig(listingConfigs);
        if (ajax.error !=null) 
        {
            alert(ajax.error.Message);
            return false;
        }
        alert('保存成功！');
        //关闭窗体
    }

     var option=0;
     var flag = -1;
     var rowObj = null;
      //增加ListingField 
     function addPackLevelDetail(entity) {
        var row, cell,disabled,isCheck;
        rowNewIdx = tab.rows.length;
        row = tab.insertRow(rowNewIdx);
        row.className = "ListTableOddRow";

        cell = row.insertCell(0);
        cell.align = "center";
        if(entity.ListingDetailId!=0||entity.ListingTypeId=="1")
        {
          isCheck="checked";
         }
         else
         {
           isCheck="";
         }
        cell.innerHTML="<input id=\"isCheck\" type=\"checkbox\" "+isCheck+"/>";

        cell = row.insertCell(1);
        cell.align = "center";
        cell.innerHTML = entity.FieldName
        +"<input type=\"hidden\" name=\"txtListingFieldId\" class='TextBox'  style=\"width:130px;float:left;\"   value=\""+entity.ListingFieldId+"\" disabled=\"disabled\">"
        +"<input type=\"hidden\" name=\"txtListingDetailId\" class='TextBox'  style=\"width:130px;float:left;\"   value=\""+entity.ListingDetailId+"\" disabled=\"disabled\">";
        
        cell = row.insertCell(2);
        cell.setAttribute("align", "center");
        cell.innerHTML = "<input type=\"text\" name=\"txtDetailFieldValue\"  style=\"width:130px;float:left;\"  MaxLength='90' value=\""+entity.DetailFieldValue+"\" >";   
      }    
    </script>
</asp:Content>
