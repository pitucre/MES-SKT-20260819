<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/Masters.master" AutoEventWireup="true"
    CodeBehind="ESOPFileManage.aspx.cs" Inherits="SKT.LeanMES.Web.ESOP.ESOPFileManage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/ligerTree/skins/Aqua/css/ligerui-tree.css" rel="stylesheet" type="text/css" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/ligerTree/js/core/base.js"" type="text/javascript"></script>  
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/ligerTree/js/plugins/ligerTree.js"" type="text/javascript"></script> 
   
    <link href="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/css/layui.css" rel="stylesheet" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/layui.all.js"></script>
        <style type="text/css">
        #layermsg {
            position: absolute;
            left: 50%;
            top: 50%;
            width:700px;
            height:500px;
            margin-left:-350px;
            margin-top:-250px; 
            display:none;
            z-index:999;
        }
      
        #layer { 
            background-color:#F1F3F8; 
            left:0; 
            opacity:0.8; 
            position:absolute; 
            top:0; 
            z-index:3; 
            filter:alpha(opacity=80); 
            -moz-opacity:0.8; 
            -khtml-opacity:0.8; 
            display:none;
        } 
        
        #divClose{
            color:#fff;
            width:15px;           
            background:red;
            text-align:center;
            cursor:pointer;
            position: absolute;
            right: 10px;
            top: 10px;
         }
    </style> 
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="position: absolute; width: 180px; height: 93%; padding-top:5px; border: 1px solid #ccc; overflow:auto;">
         <ul id="ItemCategory">     
        </ul>
    </div>
 
    <div style="margin-left: 185px;">
        <div style="margin-top: 0px;">
        <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
            <table class="EditeContentTable" width="100%">
                <tr>
                    <td class="Label3">
                        ESOP工序<em>*</em>
                    </td>
                    <td class="Field3">
                        <input type="text" class="aspNetDisabled TextBox" id="txtStation" name="txtStation"
                            disabled="disabled" IsRequired="1" /><input type="button" id="Button1" class="ButtonBox" value="..."
                                title="<%=Resources.lang.ChooseOperation %>" onclick="selectStation();" />
                        <input type="hidden" id="hidStationId" name="hidStationId" value="-1" />
                    </td>
                    <td class="Label3">
                        ESOP名称<em>*</em>
                    </td>
                    <td class="Field3">
                        <input type="text" id="txtESopName" name="txtESopName"  IsRequired="1" maxlength="20" value="" class="TextBox" />
                        <input type="hidden" id="hidESOPID" name="hidESOPID" value="0" />
                    </td>
                    <td class="Label3" style=" width:100px;">
                        切屏间隔<em>*</em> 
                    </td>
                    <td class="Field3">
                        <input type="text" id="txtCutTime" name="txtCutTime" IsRequired="1" MinValue="1"  maxlength="5" class="TextBox" style="width: 40px; text-align:center;" />
                        <span>秒</span>
                    </td>
                </tr>
            </table>
            <div class="clear5">
            </div>
            <table class="EditeContentTable" width="100%">
                <tr>
                    <td class="Label" style="width: 49%; text-align: center; font-weight: bold;">
                        <asp:Label ID="Label5" runat="server" Text="可选的产品代码"></asp:Label>
                    </td>
                    <td class="Label" style="width: 2%; text-align: center;">
                    </td>
                    <td class="Label" style="width: 49%; text-align: center; font-weight: bold;">
                        <asp:Label ID="Label6" runat="server" Text="已选的产品代码 "></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="Field" style="width: 45%; vertical-align: top;">
                        <iframe name="frmRoleChooseList" id="fromChooseList" frameborder="0" style="width: 99%;
                            height: 265px;" src="ESOPPreItem.aspx?ID=<%= Request.QueryString["ID"] %>"></iframe>
                    </td>
                    <td class="Field" style="width: 10%; text-align: center; vertical-align: middle;">
                        <input type="button" id="btnLeftChoose" runat="server" class="rightButton" onclick="btnChooseOnClick(0);" />
                        <br />
                        <br />
                        <br />
                        <br />
                        <input type="button" id="btnRightChoose" runat="server" class="leftButton" onclick="btnChooseOnClick(1);" />
                    </td>
                    <td class="Field" style="width: 45%; vertical-align: top;">
                        <iframe name="frmUserRoleList" id="IfrHasChooseList" frameborder="0" style="width: 99%;
                            height: 265px; padding: 0px;"></iframe>
                    </td>
                </tr>
            </table>
        </div>
        <div style="margin-top: -1px;">
            <div class="ListTableTitle">
                <div style="left: 5px; line-height: 18px;">
                    ESOP文件上传
                </div>
            </div>
            <table class="EditeContentTable" width="100%" style="height: 40px;">
                <tr>
                    <td width="30%">
                        &nbsp;&nbsp;<span>请选择上传文件（可显示像素为1366*540）</span><em>*</em>
                    </td>
                    <td>
                        <div class="layui-upload">
                            <button type="button" class="layui-btn" style="height: 26px; line-height: 26px; margin: 5px;" id="upload-image"><span>上传文件</span></button>
                        </div>
                        <%--<div style="padding-top: 10px;">
                            <input type="file" name="fileUpload" id="fileUpload" style="width: 73px;" /></div>--%>
                    </td>
                    <td>
                        <div id="fileQueue">
                        </div>
                    </td>
                </tr>
            </table>
            <table class="ListTable" width="100%" style="margin-top: -1px;">
                <thead>
                    <tr class="ListTableHeader">
                        <th style=" text-align:center;">
                            文件名称
                        </th>
                        <th style=" width:150px; text-align:center;">
                            文件属性
                        </th>
                         <th style=" width:150px; text-align:center;">
                            文件预览
                        </th>
                        <th style=" width:150px; text-align:center;">
                            操作
                        </th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
    </div>
        <div id="layer"></div>
     <div id="layermsg" >     
     
      </div>  
    <link type="text/css" href="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/uploadify/uploadify.css"
        rel="Stylesheet" />
    <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/uploadify/jquery.uploadify.min.js"></script>

    <script type="text/javascript">
           var userName = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>';
            var  ESOPID=-1;
            layui.use('upload', function () {
                var $ = layui.jquery, upload = layui.upload;
                //图片上传
                upload.render({
                    elem: '#upload-image',
                    url: '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/UploadHander.ashx',
                    data:{ESOPID:ESOPID,userName:userName},
                    exts: 'jpg|jpge|gif|png|pdf|mp4|xls|xlsx|webm', //只允许上传excel文件
                    size: 10240,//限制文件大小，单位 KB
                    multiple: true,
                    //done
                    done: function (res) {
                        
                        //如果上传失败
                        if (res.Msg != "") {
                            alert("上传失败:" + res.Msg);
                            return false;
                        }
                        //上传成功
                        var sequence = 0;
                        if($(".ListTable>tbody tr").length > 0){
                            sequence = parseInt($(".ListTable>tbody tr:last").find("input[name=hidSequence]").val())+1
                        }
                        var display = "";
                        if(res.FileType.toLowerCase()=="pdf"){
                            display="none";
                        }
                        var fileUrl = GetFilePath("", res.EsopFileName.replaceAll(/%20/g, '_').replaceAll(' ', '_'));
                        var display = "<td align='center'><img src ="+fileUrl+"  onclick='showPic(this.src)' style='width:60px; height:50px; cursor:pointer; ' /></td>";
                        if(res.FileType.toLowerCase()=="pdf"){
                            display = "<td align='center'><a href=" + fileUrl + " onclick=delelPDF('" + res.EsopFileName.replaceAll(/%20/g, '_').replaceAll(' ', '_') +"')>"+res.FileName+"</td>";
                        }
                        if(res.FileType.toLowerCase()=="mp4" || res.FileType.toLowerCase()=="webm"){
                            display="<td align='center'><a href="+fileUrl+" >"+res.FileName+"</td>";
                        }
                        $(".ListTable tbody").append("<tr class='ListTableOddRow'>"
                        +"<td>" + res.FileName + "<input type='hidden' name='hidEsopFileName' value='" + res.EsopFileName + "' /></td>"
                        +"<td align='center'>" + res.FileType + "<input type='hidden' name='hidFileType' value='"+ res.FileType +"' /></td>"
                        +display
                        +"<td align='center'><input type='button' value='上移' onclick='moveCell(0,this,"+ res.ESOPFileId +")' />&nbsp;"
                        //+"<input type='button' value='下移' onclick='moveCell(1,this)' />&nbsp;"
                        +"<input type='button' value='删除' onclick='deleteFileFtp(\""+ res.ESOPFileId +"\",\""+ res.FTPUrl +"\",this)' />"
                        +"<input type='hidden' name='hidFileUrl' value='" + res.FTPUrl + "' />"
                        +"<input type='hidden' name='hidSequence' value='" + sequence + "' /></td></tr>");                     
                     
                    },
                    before: function(obj){
                        this.data.ESOPID = ESOPID;
                        this.data.userName = userName;
                       
                    },
                    error: function () {
                        //debugger;
                        alert("上传失败！");
                    }
                });

            });
    var  manager;
    var ftpType = "1";
        $(function(){
             loadTree();  
             manager = $("#ItemCategory").ligerGetTreeManager(); 
              
            var esopId = parseInt($("#hidESOPID").val());
            var iframe2 = document.getElementById("IfrHasChooseList");
            iframe2.src = "ESOPInItem.aspx?ID="+esopId+"";
            //uplaod(esopId);
            //myUpload(esopId);
           $("#txtCutTime").bind("keyup",function(){
                getIntVal(this);
           });          
         }); 

     function loadTree() {
         $("#ItemCategory").ligerTree({
             nodeDraggable: true,
             idFieldName: 'id',
             parentIDFieldName: 'pId',
             data: <%= fileNodes.ToString() %>,
             isExpand: 4,
             checkbox: false,
             //nodeWidth: 100,
             onSelect: function (node) {                 
                 var parentObj = manager.getParent(node,1);
                 if(parentObj != null){
                     var esopId = node.data.id;
                     var esopName = node.data.text;
                     var stationId = parentObj.id.replace('p','');
                     var station = parentObj.text;
                     checkTree(esopId,esopName,stationId,station);
                 }else {
                     if (node.data.pId!="0") {
                         var esopId = node.data.id;
                         var esopName = node.data.text;
                         var stationId = node.data.pId.replace('p','');
                         var station = "";
                         checkTree(esopId,esopName,stationId,station);
                     }
                 }
             }
         });
     }


    
        function selectStation(){
            var searchCondition = "  ParentStationId =-1 ";
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=8&PageCondition=" + searchCondition + "&Multiple=false&rnd=" + Math.random(), width: 650, height: 350 });
        }

        function getChooseValue(list) {            
            if(list[0][0]=="-1"){
                 $("#txtStation").val("");
            }
            else{
                $("#txtStation").val(list[0][1] + "(" + list[0][2] + ")");
            }
            $("#hidStationId").val(list[0][0]);
        }
              
        function checkTree(esopId,esopName,stationId,station){
            if(stationId != null){
                $("#txtStation").val(station);
                $("#hidStationId").val(stationId);
                $("#txtESopName").val(esopName);
                $("#hidESOPID").val(esopId);
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEsop.GetEsopByID(esopId);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return;
                }else
                {
                     $("#txtCutTime").val(ajax.value[0].CutTime);
                }
                 var iframe1 = document.getElementById("fromChooseList");
                iframe1.src = "ESOPPreItem.aspx?ID="+esopId+"";

                var iframe2 = document.getElementById("IfrHasChooseList");
                iframe2.src = "ESOPInItem.aspx?ID="+esopId+"";
     
                if(esopId !=0){
                    ESOPID=esopId
                    editFile(esopId); 
                    //uplaod(esopId);
                    //myUpload(esopId);
                }
            }
        }
                
        function moveCell(type,obj,fileId){
            var $movedTr = $(obj).parent().parent();            
            var trIndex =  $movedTr.index();
            var currentSequence = $movedTr.find("input[name=hidSequence]").val();
         
            
            if(type==0){
                if(trIndex != 0){                             
                  
                    var prevId = $movedTr.prev().find("input[name=hidFileId]").attr("id");
                    $movedTr.insertBefore($movedTr.prev());
                    var oldSquence ;
                    var newSquence;
                    if(trIndex == 1){
                        newSquence = --trIndex;
                        oldSquence = ++trIndex;
                    }
                    else{
                        oldSquence = trIndex ;
                        newSquence = --trIndex;
                    }
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEsop.EsopFileSquenceEdit(fileId,prevId,oldSquence,newSquence);
                    if (ajax.error != null) {
                        alert(ajax.error.Message);
                        return;
                    }
                }
            }else{
              
                $movedTr.insertAfter($movedTr.next());
            }
          
        }
               
        function deleteFileFtp(esopFileId,ftpUrl,obj){
            if(confirm("此操作不可逆，确定删除？")){
                if(esopFileId=="undefined"){
                    alert("文件未上传成功，删除失败！");
                    return false;
                }
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEsop.DeleteEsopFile(esopFileId,ftpUrl);
                if(ajax.error == null){
                    alert("删除成功！");
                    $(obj).parent().parent().remove();
                }else{
                    alert(ajax.error.Message);
                }

            }
        }

        function Add(){
            location.href=location.href;
        }

        function editFile(esopId){
            $(".ListTable tbody").html("");
          
            var esopId = parseInt(esopId);
            //加载被选中的产品
            var ajaxFiles = SKT.LeanMES.Web.AjaxServices.AjaxEsop.GetESOPFiles(esopId);
            if(ajaxFiles.error == null){
                var fileList = ajaxFiles.value;
                if(fileList.length>0){
                    for(var i = 0; i<fileList.length; i++){                       
                        var fileName = fileList[i].EsopFileName.substring(0,fileList[i].EsopFileName.lastIndexOf('.'));
                        var fileUrl = GetFilePath("", fileList[i].EsopFileName.replaceAll(/%20/g, '_').replaceAll(' ', '_'));
                         var display = "<td align='center'><img src ="+fileUrl+"  onclick='showPic(this.src)' style='width:60px; height:50px; cursor:pointer;' /></td>";
                           if(fileList[i].FileType.toLowerCase()=="pdf"){
                               display = "<td align='center'><a href=" + fileUrl + "  onclick=delelPDF('" + fileList[i].EsopFileName.replaceAll(/%20/g, '_').replaceAll(' ', '_') +"') >"+fileName+"</td>";
                           }
                           if(fileList[i].FileType.toLowerCase()=="mp4"||fileList[i].FileType.toLowerCase()=="webm"){
                               display="<td align='center'><a href="+fileUrl+"   >"+fileName+"</td>";
                           } 
                        $(".ListTable tbody").append("<tr class='ListTableOddRow'>"
                            +"<td>" + fileName + "<input type='hidden' name='hidEsopFileName' value='" + fileList[i].EsopFileName + "' /></td>"
                            +"<td align='center'>" + fileList[i].FileType + "<input type='hidden' name='hidFileType' value='"+ fileList[i].FileType +"' /></td>"
                            +display
                            +"<td align='center'><input type='button' value='上移' onclick='moveCell(0,this," + fileList[i].EsopFileId + ")' />&nbsp;"
                            //+"<input type='button' value='下移' onclick='moveCell(1,this," + fileList[i].EsopFileId + ")' />&nbsp;"
                            +"<input type='button' value='删除' name='hidFileId' id='" + fileList[i].EsopFileId + "' onclick='deleteFileFtp(" + fileList[i].EsopFileId + ",\""+ fileList[i].EsopFileUrl +"\",this)' />"
                            +"<input type='hidden' name='hidFileUrl' value='" + fileList[i].EsopFileUrl + "' />"
                            +"<input type='hidden' name='hidSequence' value='" + fileList[i].Sequence + "' /></td></tr>");
                        
                        
                    }
                }
             
            }else{
                alert(ajaxFiles.error.Message);
            }
        }
        
        /**
        **删除ESOP文件
        **/
        function Delete(){
            var esopId = parseInt($("#hidESOPID").val());
            if(esopId==0){
                alert("请选择要删除的ESOP");
                return;
            }
            if(confirm("确定删除？")){
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEsop.DeleteESOP(esopId);
                if(ajax.error==null){
                    alert("删除成功！");
                    location.href=location.href;
                }else{
                    alert(ajax.error.Message);
                    return false;
                }
            }
        }

        //esop删减产品
         function btnChooseOnClick(index) {
            var stationId =parseInt($("#hidStationId").val());
            var esopName= $("#txtESopName").val();
            var esopId = parseInt($("#hidESOPID").val());
            if(stationId==-1)
            {
                alert("请先选择ESOP工序！");
                return;
            }
            if(esopName==""){
                alert("请输入ESOP名称！");
                $("#txtESopName").focus();
                return;
            } 
            var CutTime=$("#txtCutTime").val();
            if($("#txtCutTime").val()==""){
                alert("请输入切屏时间！");
                $("#txtCutTime").focus();
                return;
            }
            else if(parseInt(CutTime)<1){
                alert("切屏时间不可小于1秒！");
                $("#txtCutTime").focus();
                return;
            }
           
            var ItemIDString="";
            if (index == 0) {//添加 
                    ItemIDString = window.frames[0].window.getSelectedValues(); 
            }
            else {
                   ItemIDString = window.frames[1].window.getSelectedValues(); 
            }
            
            if (ItemIDString == "") {
                alert("<%= Resources.Messages.RequireOperateRecord %>");
                return;
            }
            
            /*分配产品到到已选产品列表中*/
            //保存esop信息到主表Prod_ESOP 以及保存ESOP主表及产品关系表
            if (index == 0) {
                
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEsop.SaveEsopInItem(esopId,stationId,esopName,CutTime,ItemIDString);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return;
                }
                $("#hidESOPID").val(ajax.value);                
            }
            else {/*从Esop产品关系表(Prod_ESOPFile_Item)中删除数据*/
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEsop.RemoveEsopOutItem(stationId,esopName, ItemIDString);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return;
                }
            }
                 
            if(esopId==0){                    
                     var iframe1 = document.getElementById("fromChooseList");
                     iframe1.src = "ESOPPreItem.aspx?ID="+ajax.value+"";

                    var iframe2 = document.getElementById("IfrHasChooseList");
                    iframe2.src = "ESOPInItem.aspx?ID="+ajax.value+"";

                    //uplaod(ajax.value);
                    myUpload(ajax.value);
                }
                else{
                    window.frames[0].window.document.forms[0].submit();
                    window.frames[1].window.document.forms[0].submit(); 
                }
   
  

         }
     
        
      

        //保存ESOP数据
        function Save(){
            var stationId =parseInt($("#hidStationId").val());
            var esopName= $("#txtESopName").val();
            var esopId = parseInt($("#hidESOPID").val());
            var cutTime=$("#txtCutTime").val();
            if(stationId==-1)
            {
                alert("请先选中工序！");
                return;
            }
            if(esopName==""){
                alert("请输入ESOP名称！")
                return;
            }
            if($("#txtCutTime").val()==""){
                alert("请输入切屏时间！")
                return;
            }
              if(!/^[0-9]+$/.test(cutTime)){
                    alert("切屏时间只能输入正整数!");
                    return false;
              }
           var CutTime=parseInt($("#txtCutTime").val());
           var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEsop.SaveEsop(esopId,stationId,esopName,CutTime);
        
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return;
                }else{
                    alert("保存成功!");
                    $("#hidESOPID").val(ajax.value);
                    ESOPID = ajax.value;
                    //location.href=location.href;
                }
        }

        //预览图片
        function showPic(picUrl) {            
            var picContent = "<div id='divClose' title='关闭'>X</div><img width=\"700\" height=\"500\" src="+picUrl+" />"; 
            var bodyheight = $("body").height(); 
            var bodywidth = $("body").width();

            $("#layermsg").html(picContent).show();
            $("#layermsg").bind("click",function(){$("#layermsg,#layer").hide();});
            $("#layer").css({ 
                height:bodyheight, 
                width:bodywidth, 
                display:"block" 
            });     
        }

        //删除预览PDF
        function delelPDF(fileName){         
            //删除缓存文件
            setTimeout(function () {               
                    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEsop.DeleteFtpFile(fileName);                 
            }, 10000);
        }
    </script>
</asp:Content>
