<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="ShipmentListConfig.aspx.cs" Inherits="SKT.LeanMES.Web.PackPrint.ShipmentListConfig" %>

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
        min-width: 760px; width: 100%; overflow: auto; border-collapse: collapse;" id="tbPackLevel">
        <tr class="ListTableHeader">
            <th scope="col" align="center">
                部件名称<em>*</em>
            </th>
            <th scope="col" align="center">
                一级料号<em>*</em>
            </th>
            <th scope="col" align="center">
                二级料号
            </th>
             <th scope="col" align="center">
                三级料号
            </th>
            <th scope="col" align="center">
                是否扫描或者输入
            </th>
            <th scope="col" align="center">
                是否从系统抓取
            </th>
            <th scope="col" align="center">
                扫描顺序
            </th>
            <th scope="col" onclick="addPackLevelDetail(null);" style="color: #0066CC; cursor: pointer;
                width: 100px;" align="center">
                +<%= Resources.Buttons.COM_Add%>
            </th>
        </tr>
    </table>
    <script type="text/javascript">
        var tab = document.getElementById("tbPackLevel");
        var condition = "";
        //全局变量ID
        var cONTAINERId = -1;
        $(function () {        
            cONTAINERId=<% =Request.QueryString["ID"]%>;
            initItemOnHold(cONTAINERId);
            if (tab.rows.length < 2) {
                addPackLevelDetail(null);
            }
        });
    //实例化Table
    function initItemOnHold(Id){
        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxServiceShipmentListConfig.GetShipmentListConfigs(Id);
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
        var ShipmentListConfigs=[];
        var s={};
        var trList = $("#tbPackLevel").find("tr");
        var sn=$("#ContentPlaceHolder1_EditContent_txtItemCode")[0].outerText;
        var errorMessage='';        
        if($("#tbPackLevel").find("tr").length<2)
        {
            alert("需要保存一笔明细，请确认");
            return;
        }
        //从第2行开始，止点不用加1了
        for (var i=1;i<trList.length;i++) {
            s={};
            var tdArr = trList.eq(i).find("td");
            s.ItemId = <%=itemId%>;//SN码            
            var PartNameConfigId=tdArr.eq(0).find("input[type='hidden']")[0].value;           
            if(PartNameConfigId=="")
            {
                errorMessage="请选择部件名称"+'\n\n'; 
                break;    
            }
            else
            {
                s.PartNameConfigId = parseInt(PartNameConfigId);
            }
            var OnePart=tdArr.eq(1).find("input[type='hidden']").val();//一级料号
            if(OnePart=="")
            {
                errorMessage="请选择一级料号"+'\n\n'; 
                break;                
            }
            else
            {
                s.OnePartId =OnePart;
            }
            var TwoPart=tdArr.eq(2).find("input[type='hidden']").val();//二级料号
            if(TwoPart=="")
            {
                s.TwoPartId =-1;                
            }
            else
            {
                s.TwoPartId =TwoPart ;
            }
            var ThreePart=tdArr.eq(3).find("input[type='hidden']").val();//三级料号
            if(ThreePart=="")
            {
                s.ThreePartId =-1;                  
            }
            else
            {
                s.ThreePartId =ThreePart ;
            }
            s.IsScanOrInput = getNumberByCode(tdArr.eq(4).find("select").val());//是否需要扫描或者输入
            s.IsFromSystem=getNumberByCode(tdArr.eq(5).find("select").val());//是否从系统抓取
            var ScanOrder=tdArr.eq(6).find("input[type='text']").val();//顺序
            if(ScanOrder=="")
            {
                errorMessage="请输入顺序"+'\n\n'; 
                break;                 
            }
            else if(isNaN(ScanOrder)==true)
            {
                errorMessage="输入顺序项不是数值型，请检查"+'\n\n'; 
                break;                     
            }
            else
            {              
                s.ScanOrder=parseInt(ScanOrder);
            }
            //隐藏域，要修改的哪个出货清单明细
            s.ShipConfigID=tdArr.eq(0).find("input[type='hidden']")[1].value;
            s.Oporater = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>";
            ShipmentListConfigs.push(s);
        }
        //以下是校验
        if(ShipmentListConfigs.length<1)
        {
            errorMessage="请选择必填项"+'\n\n';
        }

        //这个防呆暂时拿掉，后期可能不需要了
//        //这两项选择是否弄相同了
//        for(var i=0;i<ShipmentListConfigs.length;i++)
//        { 
//            if (ShipmentListConfigs[i].IsScanOrInput==1 && ShipmentListConfigs[i].IsFromSystem==1)
//            { 
//                errorMessage="是否需要扫描或者输入与是否从系统抓取存在矛盾，请检查"+'\n\n';
//            }
//            if (ShipmentListConfigs[i].IsScanOrInput==0 && ShipmentListConfigs[i].IsFromSystem==0)
//            { 
//                errorMessage="是否需要扫描或者输入与是否从系统抓取存在矛盾，请检查"+'\n\n';
//            }
//            if(errorMessage!="")
//            {
//              break;             
//            }
//         }
        if(ShipmentListConfigs.length>=2)
        {
            if(isRepeat(ShipmentListConfigs,'ScanOrder')==true)
            {
                errorMessage+='列表中排序存在重复，请检查！'+'\n\n';
            }
            if(isRepeat(ShipmentListConfigs,'PartNameConfigId')==true)
            {
                errorMessage+='列表中部件存在重复，请检查！'+'\n\n';
            }
        }
        if(errorMessage!="")
        {
           alert(errorMessage);        
           return;
        }
        //保存到后台数据库中
        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxServiceShipmentListConfig.EditShipmentListConfig(ShipmentListConfigs);
        if (ajax.error !=null) 
        {
            alert(ajax.error.Message);
            return false;
        }
        alert('保存成功！');
        //关闭窗体
        window.parent.closeDialog();
    }
    //部件或者顺序是否有重复的项
   function isRepeat(ary,name)
   {
        var nary=ary.sort(); 
        var Repeat=false;
        for(var i=0;i<ary.length-1;i++)
        { 
           if(name=='ScanOrder')
           {
               if (nary[i].ScanOrder==nary[i+1].ScanOrder)
               { 
                  Repeat=true;
                }
                if(Repeat==true)
                {
                    return Repeat;
                    break; 
                }
            }
            else if(name=='PartNameConfigId')
            {
               if (nary[i].PartNameConfigId==nary[i+1].PartNameConfigId)
               { 
                  Repeat=true;
                }
                if(Repeat==true)
                {
                    return Repeat;
                    break; 
                }            
            }
        }
    }
    //把YN转成数字
    function getNumberByCode(str)
    {
        var num=0;
        if(str=="Y")
        {
          num=1;
        }
        return num;
    }
     var option=0;
     var flag = -1;
     var rowObj = null;
      //增加PackLevel
     function addPackLevelDetail(entity) {
        if(entity == null){
            entity = {};
            entity.ShipConfigID=-1;
            entity.ItemId=-1;
            entity.PartNameConfigId = -1;
            entity.OnePartId ="";
            entity.TwoPartId = "";
            entity.ThreePartId="";
            //默认选中
            entity.IsScanOrInput = 1;
            entity.IsFromSystem = 0;
            entity.ScanOrder =0;
            entity.PartName="";
            entity.OnePart   ="";
            entity.TwoPart   = "";
            entity.ThreePart ="";
        }
        var row, cell,disabled;
        rowNewIdx = tab.rows.length;
        row = tab.insertRow(rowNewIdx);
        row.className = "ListTableOddRow";
        //
        cell = row.insertCell(0);
        cell.align = "center";
        cell.innerHTML = "<input type=\"text\" name=\"txtPackingLevelValue\" class='TextBox' IsRequired='1'  style=\"width:110px;float:left;\"   value=\""+entity.PartName+"\" disabled=\"disabled\">"
        +"<input type=\"hidden\" name=\"txtPackingLevelValue1\" class='TextBox'  style=\"width:110px;float:left;\"   value=\""+entity.PartNameConfigId+"\" disabled=\"disabled\">"
        +"<input type=\"hidden\" name=\"txtPackingLevelValue1\" class='TextBox'  style=\"width:110px;float:left;\"   value=\""+entity.ShipConfigID+"\" disabled=\"disabled\">"
        + "<input type=\"button\" id=\"btnSelectItems\" class='ButtonBox' onclick=\"selectShipmentListConfigs(this);\" style='float:left' class=\"ButtonBox\"  value=\"...\"  />";
        cell = row.insertCell(1);
        cell.align = "center";
        cell.innerHTML = "<input type=\"text\" name=\"txtPackingLevelValue\"  IsRequired='1' style=\"width:110px;float:left;\"   value=\""+entity.OnePart+"\" disabled=\"disabled\">"
        +"<input type=\"hidden\" name=\"txtPackingLevelValue1\" class='TextBox'  style=\"width:110px;float:left;\"   value=\""+entity.OnePartId+"\" disabled=\"disabled\">"
        + "<input type=\"button\" id=\"btnSelectItems\" onclick=\"selectOneItems(this);\" style='float:left' class=\"ButtonBox\"  value=\"...\"  />";

        cell = row.insertCell(2);
        cell.align = "center";
        cell.innerHTML = "<input type=\"text\" name=\"txtPackingLevelValue\"  style=\"width:110px;float:left;\"   value=\""+entity.TwoPart+"\" disabled=\"disabled\">"
        +"<input type=\"hidden\" name=\"txtPackingLevelValue1\" class='TextBox'  style=\"width:110px;float:left;\"   value=\""+entity.TwoPartId+"\" disabled=\"disabled\">"
        + "<input type=\"button\" id=\"btnSelectItems\" onclick=\"selectTwoItems(this);\" style='float:left' class=\"ButtonBox\"  value=\"...\"  />";
        
        cell = row.insertCell(3);
        cell.align = "center";
        cell.innerHTML = "<input type=\"text\" name=\"txtPackingLevelValue\"  style=\"width:110px;float:left;\"   value=\""+entity.ThreePart+"\" disabled=\"disabled\">"
        +"<input type=\"hidden\" name=\"txtPackingLevelValue1\" class='TextBox'  style=\"width:110px;float:left;\"   value=\""+entity.ThreePartId+"\" disabled=\"disabled\">"
        + "<input type=\"button\" id=\"btnSelectItems\" onclick=\"selectThreeItems(this);\" style='float:left' class=\"ButtonBox\"  value=\"...\"  />";
        

        cell = row.insertCell(4);
        cell.align = "center";
        //是否扫描或者输入，如果是新增或者原来的值为1，给是选中
        if(entity.IsScanOrInput==1 || entity.IsScanOrInput==null )
        {
             cell.innerHTML ="<select    name=\"option\"  style=\"width:70px;\"><option value =\"Y\" selected=\"selected\">是</option><option value =\"N\">否</option></select>";
        }
        else
        {
             cell.innerHTML ="<select    name=\"option\"  style=\"width:70px;\"><option value =\"Y\">是</option><option value =\"N\" selected=\"selected\">否</option></select>";        
        }            
        cell = row.insertCell(5);
        cell.align = "center";
        //是否从系统抓取，如果是新增或者原来的值为1，给是选中
        if(entity.IsFromSystem==1 || entity.IsFromSystem==null)
        {
            cell.innerHTML = "<select    name=\"option\"  style=\"width:70px;\"><option value =\"Y\" selected=\"selected\">是</option><option value =\"N\">否</option></select>";        
        }
        else{
            cell.innerHTML = "<select    name=\"option\"  style=\"width:70px;\"><option value =\"Y\">是</option><option value =\"N\" selected=\"selected\">否</option></select>";        
        }                              
        cell = row.insertCell(6);
        cell.align = "center";
        cell.innerHTML = "<input type=\"text\" name=\"txtRevision\" style=\"width:68px;\"   value=\""+entity.ScanOrder+"\"   />";

        cell = row.insertCell(7);
        cell.align = "center";
        cell.width="100px";
        cell.innerHTML = "<span style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"deleteItem(this)\"><%= Resources.Buttons.COM_Delete %></span>";   
    }
       var rowDocument = null;  
      //取得部件的列表
        function selectShipmentListConfigs(obj)
        {
            flag=1;//用于赋不同的值
            rowObj = obj.parentElement.parentElement;            
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=57&Multiple=false&rnd=" + Math.random(), width: 600, height: 350 });
        }
        //一级料号
        function selectOneItems(obj)
        {
            flag=2;
            rowObj = obj.parentElement.parentElement;            
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=1&Multiple=false&rnd=" + Math.random(), width: 640, height: 350 });
        }
        //二级料
        function selectTwoItems(obj)
        {
            flag=3;
            rowObj = obj.parentElement.parentElement;            
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=1&Multiple=false&rnd=" + Math.random(), width: 640, height: 350 });
        }
         //三级料
        function selectThreeItems(obj)
        {
            flag=4;
            rowObj = obj.parentElement.parentElement;            
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=1&Multiple=false&rnd=" + Math.random(), width: 640, height: 350 });
        }
        //选中之后的赋值
         function getChooseValue(list) {
            if(flag==1)
            {
                rowObj.cells[0].children[0].value = list[0][2];
                //隐藏域赋值
                rowObj.cells[0].children[1].value = list[0][1];
            }
            if(flag==2)
            {
                rowObj.cells[1].children[0].value = list[0][1];
                //隐藏域
                rowObj.cells[1].children[1].value = list[0][0];
            }
            if(flag==3)
            {
                rowObj.cells[2].children[0].value = list[0][1];
                //隐藏域
                rowObj.cells[2].children[1].value = list[0][0];
            }
            if(flag==4)
            {
                rowObj.cells[3].children[0].value = list[0][1];
                //隐藏域
                rowObj.cells[3].children[1].value = list[0][0];
            }
        }
        //删除容器信息包装列表信息
        function deleteItem(obj) {
            tab.deleteRow(obj.parentElement.parentElement.rowIndex);
        }     
    //转成十进制可带小数点
   function toDecimal(x)   
   {    
      var f = parseFloat(x);    
      if (isNaN(f))   
      {    
          return 0;    
      }
      else
      {
        return f;
      }    
   }  
    </script>
</asp:Content>
