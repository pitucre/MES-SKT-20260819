<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="MouldAbnormalEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.MouldAbnormalEdit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <div class="infoTips">
     <em>*</em><span>为必填项</span>
    </div>
            <table class="EditeContentTable" width="100%">
                <tr>
                    <td class="Label3">设备名称<em>*</em>
                    </td>
                    <td class="Field3">
                       <asp:TextBox ID="txtEquimentCode" runat="server" CssClass="TextBox" IsRequired='1'></asp:TextBox><input type="button" value="..." class="ButtonBox" onclick="selectDequiment()" />
                      <asp:HiddenField ID="hdnEquimentId" runat="server" ClientIDMode="Static" Value="-1"/>
                    </td>
                    <td class="Label3"><%=Resources.lang.MouldName%><em>*</em>
                    </td>
                    <td class="Field3" >
                         <asp:TextBox ID="txtBomName" runat="server" CssClass="TextBox" IsRequired='1' ReadOnly="true"></asp:TextBox><%--<input type="button" value="..." class="ButtonBox" onclick="selectMouldBom()" />--%>
                      <asp:HiddenField ID="hdMouldBomId" runat="server" ClientIDMode="Static" />
                    </td>
                   
                    <td rowspan="4" class="Field3" style="text-align: center; "> 
                        <div class="layui-upload">
                          <button type="button" class="layui-btn" style="background-color: #4E8CD4" id="test1"><span>上传图片</span></button>
                          <div class="layui-upload-list">
                             <asp:Image runat="server" CssClass="layui-upload-img" ID="image1"/>
                               <p style="color:red"><span>支持图片格式：GIF/JPG/PNG/BMP 图片大小：不超过1MB</span></p>
                            <p id="demoText"></p>
                          </div>
                             <asp:Label runat="server" ClientIDMode="Static" ID="lbFileReady" CssClass="redFont hide" ForeColor="Red" >未载入</asp:Label>
                        </div>  
                    </td>
                </tr>
               <tr>
                    <%--<td class="Label3">粉体类型<em>*</em>
                    </td>
                    <td class="Field3" >
                        <asp:TextBox ID="txtResourceType" CssClass="TextBox"  runat="server"  
                         ClientIDMode="Static" ></asp:TextBox>
                        <input type="button" value="..." class="ButtonBox" onclick="selectResourceType()" />
                      <asp:HiddenField ID="hdResourceTypeId" runat="server" Value="-1" ClientIDMode="Static" />
                    </td>--%>
                   <td class="Label3">异常开始时间<em>*</em>
                    </td>
                    <td class="Field3" colspan="3">
                        <asp:TextBox ID="txtStartTime" runat="server" CssClass="DateTime" IsRequired='1' ></asp:TextBox>
                    </td>

                   
                </tr>
                 <tr>
                    <td class="Label3">
                        异常现象<em>*</em>
                    </td>
                    <td class="Field3" colspan="3">
                   <%--  <asp:TextBox ID="txtAbnormalPhenomenon" CssClass="TextArea" TextMode="MultiLine" runat="server" IsRequired='1'
                    ClientIDMode="Static" Width="99%" Height="75" ></asp:TextBox>--%>
                          <asp:TextBox ID="txtAbnormalPhenomenon" runat="server" CssClass="TextBox" IsRequired='1'    Width="96%"  ReadOnly="true" ></asp:TextBox><input type="button" value="..." class="ButtonBox" onclick="selectAnormal()" />
                      
                    </td>
                </tr>
                <tr>
                    <td class="Label3">
                        备注
                    </td>
                    <td class="Field3" colspan="3">
                          
                          <asp:TextBox ID="txtAbnormalReason" CssClass="TextArea" TextMode="MultiLine" runat="server" 
                    ClientIDMode="Static" Width="99%" Height="75" > </asp:TextBox>
                      
                    </td>
                </tr>
            
            </table>
     <table id="tblExpand" cellspacing="0" cellpadding="4" style="border-width: 0px; width: 100%; border-collapse: collapse; margin-top: 5px;"
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
             <tbody id="tblExpandBody"></tbody>
            <tr id="trNewInfo" class="ListTableOddRow">
                <td colspan="6" style="text-align: center;">
                    <%=Resources.Messages.HaveNothingData%>
                </td>
            </tr>
        </table>
    <input type="hidden" id="controlId" />
    <input type="hidden" id="hdCreateTime" runat="server" />
    <input type="hidden" id="hdActualStartTime" runat="server" />
     <input type="hidden" id="hdStatus" value="-1" runat="server" />
    <input type="hidden" id="hdinspecType" value="-1" />
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
             cell.innerHTML = " <input type=\"hidden\" class=\"hdMouldTypeId\" value=\"" + entity.MouldTypeId + "\" />" + entity.EquipmentTypeName;


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
                 cell.innerHTML = " <input type=\"hidden\" class=\"hdCurrentMouldId\" value=\"" + result1.value[0].MouldId + "\" />" + result1.value[0].MouldCode;

             } else {
                  
                 cell = row.insertCell(4);
                 cell.align = "center";
                 cell.className = "Field pointer";
                 cell.innerHTML = "无";
             }
         }
    </script>
     <script type="text/javascript">
         
      
         var chooseFlag = -1;
         /*粉体类型*/
         function selectResourceType() {
             chooseFlag = 1;
             dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=5&Multiple=false&rnd=" + Math.random(), width: 500, height: 300 });
         }
 
         /*选择设备*/
         function selectDequiment() {
             var searchCondition = "  ParentTypeId =1";
             chooseFlag = 3;
             dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=54&SearchCondition=" + searchCondition + "&Multiple=false&rnd=" + Math.random(), width: 600, height: 400 });
            
         }


         /*模具名称*/
         function selectMouldBom() {
             
             if ($("#<%=this.hdnEquimentId.ClientID %>").val() == -1) {
                 alert("请选择设备名称!");
                 return;
             }
             chooseFlag = 11;
             dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=705&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
         }

          /*异常名称*/
         function selectAnormal() {              
             chooseFlag = 702;
             dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=702&Multiple=true&rnd=" + Math.random(), width: 600, height: 300 });
         }

         function getChooseValue(list) {
             if (chooseFlag == 1) {
               
             } else if (chooseFlag == 3) {
                 if (getMouldBomId(list[0][0])) {
                     $("#<%=this.txtEquimentCode.ClientID %>").val(list[0][2]);
                     $("#<%=this.hdnEquimentId.ClientID %>").val(list[0][0]);
                 } else {
                     $("#<%=this.txtEquimentCode.ClientID %>").val("");
                     $("#<%=this.hdnEquimentId.ClientID %>").val(-1);
                 }

                
             }  else if (chooseFlag == 11) {
                 $("#<%=this.txtBomName.ClientID %>").val(list[0][1]);
                 $("#<%=this.hdMouldBomId.ClientID %>").val(list[0][0]);

                // GetMouldBomChild(list[0][0]);

             }else if (chooseFlag == 702) {
                 var anormal = "";
                 for(var i=0;i<list.length;i++){
                     anormal += list[i][1]+",";
                 }
                 anormal = anormal.substring(0,anormal.length-1);

                 $("#<%=this.txtAbnormalPhenomenon.ClientID %>").val(anormal);
             }
         }

         function getMouldBomId(equimentId){
             var result = SKT.LeanMES.Web.Equipment.MouldAbnormalEdit.GetMouldBomId(equimentId);
             if (result.error != null) {
                 alert(result.error.Message);
                 return false;
             }
             var entity = result.value;
             if(entity[0] == null || entity[0] == "") {
                 $("#<%=this.txtBomName.ClientID %>").val("");
                 $("#<%=this.hdMouldBomId.ClientID %>").val(-1);
                 GetMouldBomChild(-1);
                 alert("设备没有在机模具，请先进行更换模具作业！");
                 return false;
             }
             $("#<%=this.txtBomName.ClientID %>").val(entity[1]);
             $("#<%=this.hdMouldBomId.ClientID %>").val(entity[0]);
             GetMouldBomChild(entity[0]);
             return true;
         }
          
     </script>
    <script type="text/javascript" language="javascript">

        layui.use('upload', function() {
            var $ = layui.jquery, upload = layui.upload;
            //普通图片上传
            var uploadInst = upload.render({
                elem: '#test1',
                accept:'images',
                exts: 'jpg|jpge|gif|png|bmp',
                size: 1024,//限制文件大小，单位 KB
                url: '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/UploadHander.ashx?Action=MouldAnormal',
                before: function(obj) {
                    //预读本地文件示例，不支持ie8
                    obj.preview(function(index, file, result) {
                        $('#<%=this.image1.ClientID%>').attr('src', result); //图片链接（base64）
                    });
                },
                done: function(res) {
                    //如果上传失败
                    if (res.code > 0) {
                        return layer.msg('上传失败');
                    }
                    var fileUrl =GetFilePath("MouldAnormal", res.data.FileName);
                    $('#<%=this.image1.ClientID%>').attr('src', fileUrl);
                    var n = 0;
                    if (fileUrl.indexOf('=') > 0) {
                        var n = fileUrl.lastIndexOf("=");
                    } else {
                        var n = fileUrl.lastIndexOf("/");
                    }
                    $("#<%=this.lbFileReady.ClientID%>").html(fileUrl.substring(n+1, fileUrl.length));
                 
                   
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
            
            if (Id != -1) {
                $("#Filedata").hide();
                $("#showUploadCtrl").html("<a href='#'>重新上传</a>").click(function() {
                    $(this).hide();
                    $("#Filedata").show();
                });

                //如果已审核则不能编辑
                if ($("#<%=this.hdStatus.ClientID%>").val() == 1) {
                    $(" input").attr("disabled", true);
                    $(" .ui-datepicker-trigger").attr("disabled", true);
                    $("#<%=this.txtAbnormalPhenomenon.ClientID%>").attr("disabled", true);
                    $("#<%=this.txtAbnormalReason.ClientID%>").attr("disabled", true);
                    $("#showUploadCtrl").html("");
                }
               
            }
            else {
                $("#Filedata").show();
                $("#showUploadCtrl").html("");
            }
             
            $(".DateTime").datepicker({
                buttonImageOnly: true,
                showHms: true
            });
        });
        var ReqId = '<%=Request.QueryString["ID"] %>';
        $("select").css("width", "140px");



        /*保存数据*/
        function Save() {

            var picUrl = $("#<%=this.lbFileReady.ClientID%>").html();
            var entity = {};
            entity.Id = Id;

            entity.MouldBomId = $("#<%=this.hdMouldBomId.ClientID%>").val();
            entity.EquipmentId = $("#<%=this.hdnEquimentId.ClientID%>").val();
            entity.ResourceTypeId =  -1;
            entity.AbnormalReason = $("#<%=this.txtAbnormalReason.ClientID%>").val();
            entity.AbnormalPhenomenon = $("#<%=this.txtAbnormalPhenomenon.ClientID%>").val();
            entity.StartTime =new Date($("#<%=this.txtStartTime.ClientID %>").val().replace(/-/g, "\/"));
            entity.PicFile = picUrl;
            entity.Remark = "";
            SaveAnormal(entity);
              
        }


        
        function SaveAnormal(entity)
        {
            var ajax = SKT.LeanMES.Web.Equipment.MouldAbnormalEdit.Edit(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert('<%=Resources.Messages.SaveInSuccess %>');
            parent.window.UpdateList();
        
        }



    </script>
</asp:Content>
