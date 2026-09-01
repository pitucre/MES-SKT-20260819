<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="MouldAbnormalView.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.MouldAbnormalView" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
            <table class="EditeContentTable" width="100%">
                <tr>
                  
                    <td class="Label3">设备名称<em></em>
                    </td>
                    <td class="Field3">
                          <asp:Label runat="server" ID="lblEquimentName"></asp:Label>  
                       <asp:HiddenField ID="hdnEquimentId" runat="server" ClientIDMode="Static" />
                    </td>
                      <td class="Label3"><%=Resources.lang.MouldName%><em></em>
                    </td>
                    <td class="Field3" >
                        
                        <asp:Label runat="server" ID="lblBomName"></asp:Label>  
                          <asp:HiddenField ID="hdMouldBomId" runat="server" ClientIDMode="Static" />
                    </td>
                    <td rowspan="4" class="Field3" style="text-align: center; "> 
                          <div id="layer-photos-demo" class="layer-photos-demo">
                      <asp:Image runat="server" ID="txtimg" alt="查看图片" Style="width: 139px; height: 135px;" />
                     </div>
                    </td>
                </tr>
               <tr>
                  <%--  <td class="Label3">粉体类型<em></em>
                    </td>
                    <td class="Field3" >
                          <asp:Label runat="server" ID="lblResourceType"></asp:Label>  
                       
                    </td>--%>
                      <td class="Label3">异常类型<em></em>
                    </td>
                    <td class="Field3" colspan="3" >
                          <asp:Label runat="server" ID="lblAnormalType"></asp:Label>  
                       
                    </td>
                </tr>
                 <tr>
                    <td class="Label3">
                        异常现象<em>*</em>
                    </td>
                    <td class="Field3" colspan="3">
                     <%--<asp:TextBox ID="txtAbnormalPhenomenon" CssClass="TextArea" TextMode="MultiLine" runat="server"
                    ClientIDMode="Static" Width="99%" Height="75" Enabled="False" ></asp:TextBox>--%>
                         <asp:TextBox ID="txtAbnormalPhenomenon"   runat="server" ClientIDMode="Static" Width="99%"   Enabled="False" ></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="Label3">
                        备注
                    </td>
                    <td class="Field3" colspan="3">
                          
                          <asp:TextBox ID="txtAbnormalReason" CssClass="TextArea" TextMode="MultiLine" runat="server"
                    ClientIDMode="Static" Width="99%" Height="75" Enabled="False" > </asp:TextBox>
                      
                    </td>
                </tr>
                </table>
       <table id="tblExpand" cellspacing="0" cellpadding="4" style="border-width: 0px; width: 100%;  border-collapse: collapse; margin-top: 5px;"
            class="EditeContentTable">
            <tr class="ListTableHeader" style="text-align: center">
                 <th scope="col" style="width: 10%;">序号
                </th>
                <th scope="col" style="width: 15%;">构件名称
                </th>
                <th scope="col" style="width: 15%;" >构件编码
                </th>
                <th scope="col" style="width: 25%;" >构件描述
                </th>
                <th scope="col" style="width: 15%;" >在机模具
                </th>
 
            </tr>
             <tbody id="tblExpandBody" style="height: 100px;"></tbody>
            <tr id="trNewInfo" class="ListTableOddRow" style="height: 100px;">
                <td colspan="6" style="text-align: center;">
                    <%=Resources.Messages.HaveNothingData%>
                </td>
            </tr>
        </table>
  <table class="EditeContentTable" width="100%">
                <tr>
                     <td class="Label3">是否遗留
                    </td>
                    <td class="Field3" >
                       <asp:CheckBox runat="server" ID="ckeIsLeak" value="0" Enabled="False"/>
                       
                    </td>
                    <td class="Label3">结论<em></em>
                    </td>
                    <td class="Field3" colspan="2">
                          <asp:Label runat="server" ID="lblConclusion"></asp:Label>  
                       
                    </td>
                   
                </tr>
                <tr>
                    <td class="Label3">异常开始时间<em></em>
                    </td>
                    <td class="Field3">
                          <asp:Label runat="server" ID="lblStarTime"></asp:Label>  
                      
                    </td>
                     <td class="Label3">异常结束时间<em></em>
                    </td>
                    <td class="Field3" colspan="2">
                          <asp:Label runat="server" ID="lblEndTime"></asp:Label>  
                     
                    </td>
                </tr>
                    <tr>
                    <td class="Label3">处理人<em></em>
                    </td>
                    <td class="Field3">
                          <asp:Label runat="server" ID="lblHandlePerson"></asp:Label>  
                      
                    </td>
                    <td class="Label3">负责人<em></em>
                    </td>
                    <td class="Field3" colspan="2">
                          <asp:Label runat="server" ID="lblMangerPerson"></asp:Label>  
                    </td>
                </tr>
               
                 <tr>
                    <td class="Label3">
                        异常审核备注
                    </td>
                    <td class="Field3" colspan="5"><asp:TextBox ID="txtRemark" CssClass="TextArea" TextMode="MultiLine" runat="server"
                    ClientIDMode="Static" Width="99%" Height="75"  Enabled="False"> </asp:TextBox>
                      
                    </td>
                </tr>
                
            <tr>
            <td class="Label3">文件上传</td>
            <td class="Field3" colspan="5">
                
                <asp:Label ID="lblRCCAPath" runat="server"></asp:Label> <span id="showUploadCtrl"></span>
                <asp:HiddenField ID="hdnRCCAFilePath" runat="server" Value=""/>
            </td>
        </tr>
            </table>
   
    <input type="hidden" id="controlId" />
    <input type="hidden" id="hdCreateTime" runat="server" />
    <input type="hidden" id="hdActualStartTime" runat="server" />
     <input type="hidden" id="hdStatus" value="-1" runat="server" />
    <input type="hidden" id="hdinspecType" value="-1" />
    <asp:HiddenField ID="lbFileReady" runat="server" Value="-1" ClientIDMode="Static" />
    <script type="text/javascript" src="../Content/js/jquery-3.1.0.min.js"></script>
    <script type="text/javascript" charset="utf-8" src="../Content/plugin/jquery-easyui-1.4.2/layer/layer.js"></script>
    <style type="text/css" >
        .selectRow td {
            background-color: #C4C4C4;
        }
        .pointer {
            cursor: pointer;
        }
    </style>
    <asp:HiddenField ID="filepaths" runat="server" Value="-1" ClientIDMode="Static" />
    <script type="text/javascript" src="../Content/js/jquery-3.1.0.min.js"></script>
    <link href="../Content/plugin/layui/css/layui.css" rel="stylesheet" />
    <script src="../Content/plugin/layui/layui.all.js"></script>
      <script type="text/javascript">
        var tab = document.getElementById("tblExpandBody");
        var selectRowClass = "selectRow";
        var index = 1;

         function GetMouldBomChild(bomId) {
             var result = SKT.LeanMES.Web.Equipment.MouldAbnormalEdit.GetMouldBomChild(bomId);
             if (result.error != null) {
                 alert(result.error.Message);
                 return false;
             }
             if (null != result) {
                 var index = 1;
                 $("#tblExpandBody ").html("");
                 for (var i = 0; i < result.value.length; i++) {
                     addDetail(result.value[i], index);
                     index++;
                 }
             }
             return result;
         }

         function GetAbnormalDetail(mouldAbnormalId) {
             var result = SKT.LeanMES.Web.Equipment.MouldAbnormalEdit.GetAbnormalDetail(mouldAbnormalId);
             if (result.error != null) {
                 alert(result.error.Message);
                 return false;
             }
             if (null != result) {
                 var index = 1;
                 $("#tblExpandBody ").html("");
                 for (var i = 0; i < result.value.length; i++) {
                     addDetailTwo(result.value[i], index);
                     index++;
                 }
             }
             return result;
         }

         function GetEquimentMouldAll(equimentId,equimentType) {
             var result = SKT.LeanMES.Web.Equipment.MouldAbnormalEdit.GetEquimentMouldAll(equimentId,equimentType);
             if (result.error != null) {
                 alert(result.error.Message);
                 return false;
             }
             return result;

         }
         function GetIndex() {
             var list = $(tab).find("tr");
             for (var i = 0; i < list.length; i++) {
                 if ($(list[i]).attr("class").indexOf(selectRowClass) > -1) {
                     return i;
                 }
             }
             return tab.rows.length;
         }

         function addDetail(entity, i) {
             var row, cell;
             if (null == entity) {
                 entity.MouldTypeId = -1;
                 entity.EquipmentTypeName = "";
                 entity.ComponentCode = "";
                 entity.Describe = "";
             }
             rowNewIdx = GetIndex();
             row = tab.insertRow(rowNewIdx);
             row.className = "ListTableOddRow";

             $("#trNewInfo").remove();

             cell = row.insertCell(0);
             cell.align = "center";
             cell.className = "Field pointer";
             cell.innerHTML = i;

             cell = row.insertCell(1);
             cell.align = "center";
             cell.className = "Field pointer";
             cell.innerHTML =" <input type=\"hidden\" class=\"hdMouldBomChildId\" value=\"" + entity.MouldBomChildId + "\" />" + entity.EquipmentTypeName;


             cell = row.insertCell(2);
             cell.align = "center";
             cell.className = "Field pointer";
             cell.innerHTML = entity.ComponentCode;

             cell = row.insertCell(3);
             cell.align = "center";
             cell.className = "Field";
             cell.width = "80px";
             cell.innerHTML = entity.Describe;

             var result1 = GetEquimentMouldAll($("#<%=this.hdnEquimentId.ClientID%>").val(), entity.MouldTypeId);
             if (null != result1 && result1.value.length > 0) {
                    
                 cell = row.insertCell(4);
                 cell.align = "center";
                 cell.className = "Field pointer";
                 cell.innerHTML =result1.value[0].MouldCode;

             } else {
                  
                 cell = row.insertCell(4);
                 cell.align = "center";
                 cell.className = "Field pointer";
                 cell.innerHTML = "无";
             }
         }

        function addDetailTwo(entity, i) {
             var row, cell;
             if (null == entity) {
                 entity.MouldType = "";
                 entity.MouldCode = "";
                 entity.CompomentCode = "";
                 entity.Describe = "";
             }
             rowNewIdx = GetIndex();
             row = tab.insertRow(rowNewIdx);
             row.className = "ListTableOddRow";

             $("#trNewInfo").remove();

             cell = row.insertCell(0);
             cell.align = "center";
             cell.className = "Field pointer";
             cell.innerHTML = i;

             cell = row.insertCell(1);
             cell.align = "center";
             cell.className = "Field pointer";
             cell.innerHTML =entity.MouldType;


             cell = row.insertCell(2);
             cell.align = "center";
             cell.className = "Field pointer";
             cell.innerHTML = entity.CompomentCode;

             cell = row.insertCell(3);
             cell.align = "center";
             cell.className = "Field";
             cell.width = "80px";
             cell.innerHTML = entity.Describe;
  
             cell = row.insertCell(4);
             cell.align = "center";
             cell.className = "Field pointer";
             cell.innerHTML =entity.MouldCode;

             
         }
    </script>
    <script type="text/javascript" language="javascript">

        layui.use('upload', function() {
            var $ = layui.jquery, upload = layui.upload;
            //普通图片上传
            var uploadInst = upload.render({
                elem: '#test1',
                url: '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/UploadHander.ashx?Action=MouldAnormal',
                before: function(obj) {
                    //预读本地文件示例，不支持ie8
                    obj.preview(function(index, file, result) {
                        $('#<%=this.txtimg.ClientID%>').attr('src', result); //图片链接（base64）
                    });
                },
                done: function(res) {
                    //如果上传失败
                    if (res.code > 0) {
                        return layer.msg('上传失败');
                    }
                    $("#<%=this.lbFileReady.ClientID%>").html(res.data.src);
                    alert(res.msg);
                    //上传成功
                },
                error: function() {
                    //演示失败状态，并实现重传
                    var demoText = $('#demoText');
                    demoText.html('<span style="color: #FF5722;">上传失败</span> <a class="layui-btn layui-btn-mini demo-reload">重试</a>');
                    demoText.find('.demo-reload').on('click', function() {
                        uploadInst.upload();
                    });
                }
            });
        });
        var Id = <%= Request.QueryString["ID"] == null ? -1 : Convert.ToInt32(Request.QueryString["ID"].ToString())%>;
        $(function () {

              if (Id > 0 && $("#<%=this.hdStatus.ClientID%>").val() == 2) {
                  GetAbnormalDetail(Id);
                } else {
                     GetMouldBomChild($("#<%=this.hdMouldBomId.ClientID%>").val());
                }

                $(".DateTime").datepicker({
                buttonImageOnly: true,
                showHms: true
               });
        });

          
       function Look() {
            var filename = $("#<%=this.lbFileReady.ClientID%>").val();
            if (filename == "") {
                alert("没有上传图片");
                return false;
            }
            var fileUrl =GetFilePath("MouldAnormal", filename);
            var img = "<img src='" + fileUrl + "' >";

            layer.open({
                title: "图片",
                type: 1,
                maxmin: true,
                area: ['90%', '90%'],
                //offset: ['10px', '10px'],
                shadeClose: true, //点击遮罩关闭
                content: img
            });
       }

       layer.ready(function(){ //为了layer.ext.js加载完毕再执行
            layer.photos({
                photos: '#layer-photos-demo'
                ,shift: 5 //0-6的选择，指定弹出图片动画类型，默认随机
            });
        });
        function Down(data) {
            var name = $(data).parent().parent().find("td:eq(1)").html();
            var path = '<%=SKT.LeanMES.Web.WebHelper.EQFileRoot %>' + name;
            window.open(path);
        }
        var ReqId = '<%=Request.QueryString["ID"] %>';
        $("select").css("width", "140px");



      

         



    </script>
</asp:Content>
