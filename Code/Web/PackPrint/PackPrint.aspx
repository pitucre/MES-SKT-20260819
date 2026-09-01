<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PackPrint.aspx.cs" ValidateRequest="false" Inherits="SKT.LeanMES.Web.PackPrint.PackPrint" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
     <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/jquery.min.js"></script>
    <style type="text/css">
        
        @media Print
        {
            .Noprn
            {
                display: none;
            }
        }
        .tb12
        {
            width:600px;
            cellspacing:0px;
            border-collapse:collapse;
            margin-top:20px;
        }
        .little
        {
            width: 55px;
            height: 40px;
            font-size:20px;
        }
        .little2
        {
            width: 81px;
            height: 40px;
            font-size:20px;
        }     
        .tdbold
        {
          border: medium double #333333;
        }
        .tdthin
        {
            border: thin solid #CCCCFF;
        }
         .tdthinleft
        {
            border-left:thin solid #CCCCFF;
        }
         .tdthinright
        {
            border-right:thin solid #CCCCFF;
        }
                .tdthinleft2
        {
            border-left:0 solid #CCCCFF;
        }
         .tdthinright2
        {
            border-right:0 solid #CCCCFF;
        }
        .tdspan
        {
            height:15px;
        }
        .ftsize
        {
            font-size:20px;
        } 
             
        /*现票打印css*/
         .tr
        {
            height:20px;
        } 
         .head
        {
            height: 36px;
            font-size:60px;
            font-weight:bold;
            padding-left:10PX;
        }
        
        .boldline
        {
            font-size:30px;
         }
         
         .num
         {
             font-weight:bold;
             font-size:50px;
         }
        .tab1
        {
            width:500px; margin:0 auto; font-weight:lighter;
        }
        
        /*出货清单序列*/      
         .tb6
        {
            width:600px;
            cellspacing:0px;
            border-collapse:collapse;
            margin-top:50px;
            margin:0 auto;
            text-align:center;
            font-size:16px;
            font-weight:normal;
            border: 4px solid #808080;
        }
        .tb6 tr
        { 
            height:30px;
           
        }
        .tb6 td
        {
            width:25%; 
        }
                    
         .head6
        {
            height: 40px; 
            font-size:25px;
            font-weight:bolder;
            border-bottom: 4px solid #808080;
            border-right: 1px solid #808080;
        }        
        .thin1
        {
         border-right:1px solid #808080;
         border-bottom: 2px solid #808080;
        } 
        .thin2
        {
           border-right:4px solid #808080;
         border-bottom: 2px solid #808080;
        } 
                    
  
    </style>
</head>
<body>
    <form id="form1" runat="server">
  <div id="div1">
      <center>
      <table class="tbWidth" id="tbPackLevel">
      <%-- 
      <tr>
        <td class="little tdbold">物料编号</td>
        <td colspan="4" class="tdbold" id="headList"></td>
      </tr>
      --%>
      <%-- 
       <tr class="tdspan">
      <td class="tdthin"></td><td  class="tdthin"></td>
      <td class="tdthin"></td>
      <td  class="tdthin"></td><td  class="tdthin"> </td>
      </tr>
      <tr>
      <td class="little tdbold"></td><td class="tdthin"></td>
      <td class="little tdthin"></td>
      <td class="little tdbold"></td><td class="tdthin"></td>
      </tr>
      --%>
      </table>
      </center>
     </div>
         <object classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2" height="0" id="WebBrowser"
        width="0">
    </object>
    </form>
</body>
</html>
<script type="text/javascript">

    var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
    var itemId = '<%=Request.QueryString["itemId"]%>';
    var listingTypeId = '<%=Request.QueryString["listingTypeId"]%>';
    var SN = '<%=Request.QueryString["SN"]%>';
    var itemCode = '<%=Request.QueryString["itemCode"]%>';

    var tab = document.getElementById("tbPackLevel");

    $(document).ready(function () {
        loadPickDetailList();
        Print();
        LogPrintOperation();
    })

    function Print() {
        pagesetup_null();
        if (document.all.WebBrowser) {
            document.all.WebBrowser.ExecWB(7, 1)
        }
        else {
            window.print();
        }

    }

    //保存操作记录
    function LogPrintOperation() {
        var ajax = SKT.LeanMES.Web.AjaxServices.AjaxListPrintHistory.Edit(itemId, listingTypeId);
        if (ajax.error != null) {
            alert(ajax.error.Message);
            return false;
        }
    }

    var hkey_root, hkey_path, hkey_key
    hkey_root = "HKEY_CURRENT_USER"
    hkey_path = "\\Software\\Microsoft\\Internet Explorer\\PageSetup\\"
    //设置网页打印的页眉页脚为空
    function pagesetup_null() {
        try {
            var RegWsh = new ActiveXObject("WScript.Shell")
            hkey_key = "header"
            RegWsh.RegWrite(hkey_root + hkey_path + hkey_key, "")
            hkey_key = "footer"
            RegWsh.RegWrite(hkey_root + hkey_path + hkey_key, "")
        } catch (e) { }
    }

    function addPackLevelDetail1(entity1, entity2) {

        var entity, row, cell;

        //加载SN好结束

        for (var i = 0; i < 2; i++) {
            if (i == 0) {
                entity = entity1;
            }
            if (i == 1) {
                entity = entity2;
            }
            if (entity.FieldName == "CDS" || entity.FieldName == "MEF") //CDS和MEF值
            {

                rowNewIdx = tab.rows.length;
                row = tab.insertRow(rowNewIdx);
                row.className = "tr";


                cell = row.insertCell(0);
                cell.align = "left";
                cell.className = "boldline";
                cell.innerHTML = entity.DetailFieldValue;

                cell = row.insertCell(1);
                cell.align = "left";

                rowNewIdx = tab.rows.length;
                row = tab.insertRow(rowNewIdx);
                row.className = "tr";

                cell = row.insertCell(0);
                cell.align = "left";
                cell.innerHTML = "*" + entity.DetailFieldValue + "*";

                cell = row.insertCell(1);
                cell.align = "left";
            }

            if (entity.FieldName == "B")//B值
            {
                rowNewIdx = tab.rows.length;
                row = tab.insertRow(rowNewIdx);
                row.className = "tr";


                cell = row.insertCell(0);
                cell.align = "left";
                cell.className = "boldline";
                cell.innerHTML = entity.DetailFieldValue;

                cell = row.insertCell(1);
                cell.align = "left";
                cell.setAttribute("rowspan", 2);

                rowNewIdx = tab.rows.length;
                row = tab.insertRow(rowNewIdx);
                row.className = "tr";


                cell = row.insertCell(0);
                cell.align = "left";
                cell.innerHTML = "*" + entity.DetailFieldValue + "*";

            }
            if (entity.FieldName == "Three") //3值
            {
                $("#tbPackLevel tr:eq(6) td:eq(1)").html(entity.DetailFieldValue);
                $("#tbPackLevel tr:eq(6) td:eq(1)").addClass("num");
            }

        }
    }

    function addPackLevelDetail2(entity1, entity2) {

        var row, cell;
        rowNewIdx = tab.rows.length;
        row = tab.insertRow(rowNewIdx);

        cell = row.insertCell(0);
        cell.align = "center";
        cell.className = "little tdbold";
        if (entity1.ListingDetailId != "0") {
            cell.innerHTML = "&radic;";
        }

        cell = row.insertCell(1);
        cell.align = "left";
        cell.className = "ftsize";
        cell.innerHTML = entity1.FieldName;

        cell = row.insertCell(2);
        cell.align = "center";
        cell.className = "little";

        cell = row.insertCell(3);
        cell.align = "center";
        if (entity2 != null) {
            cell.className = "little2 tdbold";
            if (entity2.ListingDetailId != "0") {
                cell.innerHTML = "&radic;";
            }
        } else {
            cell.className = "litttle2 tdbold";
        }

        cell = row.insertCell(4);
        cell.align = "left";
        cell.className = "ftsize";

        if (entity2 != null) {
            cell.innerHTML = entity2.FieldName;
        }

    }

    //供应商配置
    function addPackLevelDetail5(entity1, entity2) {
        var row, cell;
        rowNewIdx = tab.rows.length;
        row = tab.insertRow(rowNewIdx);


        cell = row.insertCell(0);
        cell.align = "center";
        cell.className = "little tdbold";
        if (entity1.ListingDetailId != "0") {
            cell.innerHTML = "&radic;";
        }

        cell = row.insertCell(1);
        cell.align = "center";
        cell.className = "tdthin ftsize";
        cell.innerHTML = entity1.FieldName;

        cell = row.insertCell(2);
        cell.align = "center";
        cell.className = "little tdthin";

        cell = row.insertCell(3);
        cell.align = "center";
        if (entity2 != null) {
            cell.className = "little tdbold";
            if (entity2.ListingDetailId != "0") {
                cell.innerHTML = "&radic;";
            }
        } else {
            cell.className = "litttle tdbold";
        }

        cell = row.insertCell(4);
        cell.align = "center";
        cell.className = "tdthin ftsize";

        if (entity2 != null) {
            cell.innerHTML = entity2.FieldName;
        }
    }



    function addPackLevelDetail6(entity1, entity2) {

        var row, cell;
        rowNewIdx = tab.rows.length;
        row = tab.insertRow(rowNewIdx);

        cell = row.insertCell(0);
        cell.align = "center";
        cell.className = "thin1";
        cell.innerHTML = entity1.PartName;

        cell = row.insertCell(1);
        cell.align = "center";
        cell.className = "thin2";
        cell.innerHTML = entity1.SN;

        cell = row.insertCell(2);
        cell.align = "center";
        cell.className = "thin1";

        if (entity2 != null) {
            cell.innerHTML = entity2.PartName;
        }

        cell = row.insertCell(3);
        cell.align = "center";
        cell.className = "thin2";
        if (entity2 != null) {
            cell.innerHTML = entity2.SN;
        }
    }

    function gennerateList(entity1, entity2) {

        if (listingTypeId == "1")//现票品
        {
            addPackLevelDetail1(entity1, entity2)
        }

        if (listingTypeId == "2")//作业内容标示
        {
            addPackLevelDetail2(entity1, entity2)
        }

        if (listingTypeId == "5")//供应商配置
        {
            addPackLevelDetail5(entity1, entity2)
        }
        if (listingTypeId == "6")//出货清单
        {
            addPackLevelDetail6(entity1, entity2)
        }

    }

    function loadHead1()
    {

        var entity, row, cell;

        //加载SN号 开始
        rowNewIdx = tab.rows.length;
        row = tab.insertRow(rowNewIdx);
        row.className = "tr";

        cell = row.insertCell(0);
        cell.align = "left";
        cell.className = "head";
        cell.innerHTML = SN;

        cell = row.insertCell(1);
        cell.align = "left";

        rowNewIdx = tab.rows.length;
        row = tab.insertRow(rowNewIdx);
        row.className = "tr";

        cell = row.insertCell(0);
        cell.align = "left";
        cell.innerHTML = "*" + SN + "*";

        cell = row.insertCell(1);
        cell.align = "left";

    }

    function loadHead2()//作业内容
    {
        var row, cell;
        rowNewIdx = tab.rows.length;
        row = tab.insertRow(rowNewIdx);
        rowNewIdx = tab.rows.length;
        row = tab.insertRow(rowNewIdx);

        cell = row.insertCell(0);
        cell.align = "center";
        cell.className = "little2 tdbold tdthinright2";
        cell.innerHTML = "物料编号";

        cell = row.insertCell(1);
        cell.className = "tdbold ftsize tdthinleft2";
        cell.setAttribute("align", "center");
        cell.setAttribute("colspan", 4);
        cell.innerHTML = itemCode;


        row = tab.insertRow(rowNewIdx);
        rowNewIdx = tab.rows.length;
        row = tab.insertRow(rowNewIdx);
        row.className = "tdspan";

        cell = row.insertCell(0);
        cell = row.insertCell(1);
        cell = row.insertCell(2);
        cell = row.insertCell(3);
        cell = row.insertCell(4);
    }

    function loadHead5()//供应商
    {
        var row, cell;
        rowNewIdx = tab.rows.length;
        row = tab.insertRow(rowNewIdx);
        rowNewIdx = tab.rows.length;
        row = tab.insertRow(rowNewIdx);

        cell = row.insertCell(0);
        cell.align = "center";
        cell.className = "little tdthinright";
        cell.innerHTML = "物料编号";

        cell = row.insertCell(1);
        cell.className = "tdbold ftsize tdthinleft";
        cell.setAttribute("align", "center");
        cell.setAttribute("colspan", 4);
        cell.innerHTML = itemCode;

        row = tab.insertRow(rowNewIdx);
        rowNewIdx = tab.rows.length;
        row = tab.insertRow(rowNewIdx);
        row.className = "tdspan";

        cell = row.insertCell(0);
        cell.className = "tdthin";

        cell = row.insertCell(1);
        cell.className = "tdthin";

        cell = row.insertCell(2);
        cell.className = "tdthin ";

        cell = row.insertCell(3);
        cell.className = "tdthin";

        cell = row.insertCell(4);
        cell.className = "tdthin";

    }

    function loadHead6()//出货清单
    {
        var row, cell;
        rowNewIdx = tab.rows.length;
        row = tab.insertRow(rowNewIdx);

        cell = row.insertCell(0);
        cell.align = "center";
        cell.className = "head6";
        cell.setAttribute("align", "center");
        cell.innerHTML = "主题NO";

        cell = row.insertCell(1);
        cell.className = "head6";
        cell.setAttribute("align", "center");
        cell.setAttribute("colspan", 3);
        cell.innerHTML = itemCode;

    }

    function loadHead() {

        if (listingTypeId == "1")//现票品
        {
            loadHead1();
        }

        if (listingTypeId == "2")//作业内容标示
        {
            loadHead2();
        }

        if (listingTypeId == "5")//供应商配置
        {
            loadHead5();
        }
        if (listingTypeId == "6")//出货清单
        {
            loadHead6();
        }

    }

    //加载分检单明细列表
    function loadPickDetailList() {

        var row, cell;

        if (itemId == null || listingTypeId == null)
            return;

        $("#headList").html(itemCode);

        if (listingTypeId == "1") {
            $("#tbPackLevel").addClass("tb1");
        }
        else if (listingTypeId == "6") {
            $("#tbPackLevel").addClass("tb6");   
        }else {
            $("#tbPackLevel").addClass("tb12");
        }
              
        loadHead();

        var ajax;
        if (listingTypeId == "6") { //出货清单
            ajax = SKT.LeanMES.Web.AjaxServices.AjaxServiceListingConfig.GetPackingDetail(itemId);
        } else {
            ajax = SKT.LeanMES.Web.AjaxServices.AjaxServiceListingConfig.GetListingConfigs(itemId, listingTypeId);
        }
        
        if (ajax.error == null) {
            var entityAry = ajax.value;
            for (var i = 0; i < entityAry.length; i++) {
                if (i <= entityAry.length - 2) {
                    gennerateList(entityAry[i], entityAry[i + 1]);
                }
                if (i == entityAry.length - 1) {
                    gennerateList(entityAry[i], null);
                }
                i++;
            }
        } else {
            alert(ajax.error.Message);
            return false;
        }
    }

    //内容

</script>
<script src="../Content/plugin/barCode/jquery-barcode.js" type="text/javascript"></script>
