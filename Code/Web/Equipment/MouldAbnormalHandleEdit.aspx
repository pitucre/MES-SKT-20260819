<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="MouldAbnormalHandleEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.MouldAbnormalHandleEdit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <div class="infoTips">
     带<em>*</em>为必填项
    </div>

   
            <table class="EditeContentTable" width="100%">
                <tr>
                    <td class="Label3">设备名称<em>*</em>
                    </td>
                    <td class="Field3">
                       <asp:TextBox ID="txtEquimentCode" runat="server" CssClass="TextBox" IsRequired='1'></asp:TextBox>
                     <input type="button" value="..." class="ButtonBox" onclick="selectDequiment()" />
                      <asp:HiddenField ID="hdnEquimentId" runat="server" ClientIDMode="Static" />
                    </td>
                     <td class="Label3"><%=Resources.lang.MouldName%><em>*</em>
                    </td>
                    <td class="Field3" >
                    <asp:TextBox ID="txtBomName" runat="server" CssClass="TextBox" IsRequired='1'></asp:TextBox>
                     <input type="button" value="..." class="ButtonBox" onclick="selectMouldBom()" />
                      <asp:HiddenField ID="hdMouldBomId" runat="server" ClientIDMode="Static" />
                    </td>
                    <td rowspan="4" class="Field3" style="text-align: center; "> 
                        <div class="layui-upload">
                         
                          <div class="layui-upload-list">
                             <asp:Image runat="server" CssClass="layui-upload-img" ID="image1"/>
                            <p id="demoText"></p>
                          </div>
                             <button type="button" class="layui-btn" style="background-color: #4E8CD4" id="test1">上传图片</button>
                             <asp:Label runat="server" ClientIDMode="Static" ID="lbFileReady" CssClass="redFont hide" ForeColor="Red" >未载入</asp:Label>
                        </div>  
                    </td>
                </tr>
               <tr>
                    <%--<td class="Label3">粉体类型<em>*</em>
                    </td>
                    <td class="Field3" >
                        <asp:TextBox ID="txtResourceType" CssClass="TextBox"  runat="server" IsRequired='1'
                         ClientIDMode="Static" ></asp:TextBox>
                        <input type="button" value="..." class="ButtonBox" onclick="selectResourceType()" />
                      <asp:HiddenField ID="hdResourceTypeId" runat="server" ClientIDMode="Static" />
                    </td>--%>
                   <td class="Label3">异常开始时间<em>*</em>
                    </td>
                    <td class="Field3" colspan="3">
                        <asp:TextBox ID="txtStartTime" runat="server" CssClass="DateTime" IsRequired='1'></asp:TextBox>
                    </td>

                   
                </tr>
                 <tr>
                    <td class="Label3">
                        异常现象<em>*</em>
                    </td>
                    <td class="Field3" colspan="3">
                    <%-- <asp:TextBox ID="txtAbnormalPhenomenon" CssClass="TextArea" TextMode="MultiLine" runat="server" IsRequired='1'
                    ClientIDMode="Static" Width="99%" Height="75" ></asp:TextBox>--%>
                        <asp:TextBox ID="txtAbnormalPhenomenon" runat="server" CssClass="TextBox" IsRequired='1' ReadOnly="true"  Width="96%"  ></asp:TextBox><input type="button" value="..." class="ButtonBox" onclick="selectAnormal()" />
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
      <table id="tblExpand" cellspacing="0" cellpadding="4" style="border-width: 0px; width: 100%;  border-collapse: collapse; margin-top: 5px;"
            class="EditeContentTable">
            <tr class="ListTableHeader" style="text-align: center">
                 <th scope="col" style="width: 10%;">序号
                </th>
                <th scope="col" style="width: 15%;">构件名称
                </th>
                <%--<th scope="col" style="width: 15%;" >可替换构件
                </th>--%>
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
                       <asp:CheckBox runat="server" ID="ckeIsLeak" value="0"/>
                       <input type="hidden" runat="server" ID="hdIsLeak" />
                    </td>
                    <td class="Label3">结论<em>*</em>
                    </td>
                    <td class="Field3" colspan="2">
                        <asp:TextBox ID="txtConclusion" runat="server" CssClass="TextBox" Width="400px" IsRequired='1'></asp:TextBox>
                    </td>
                   
                </tr>
                <tr>
                       <td class="Label3">异常类型<em>*</em>
                    </td>
                    <td class="Field3" >
                        <asp:TextBox ID="txtAnormalType" CssClass="TextBox"  runat="server" IsRequired='1'
                         ClientIDMode="Static" ></asp:TextBox><input type="button" value="..." class="ButtonBox" onclick="selectAnormalType()" />
                      <asp:HiddenField ID="hdAnormalTypeId" runat="server" ClientIDMode="Static" />
                    </td>
                     <td class="Label3">异常结束时间<em>*</em>
                    </td>
                    <td class="Field3" colspan="2">
                        <asp:TextBox ID="txtEndTime" runat="server" CssClass="DateTime" IsRequired='1'></asp:TextBox>
                    </td>
                </tr>
                    <tr>
                    <td class="Label3">处理人<em>*</em>
                    </td>
                    <td class="Field3">
                        
                        <asp:Label runat="server" ID="lblHandlePerson"></asp:Label>
                        <asp:HiddenField ID="hdHandlePerson" runat="server" />
                       
                    </td>
                    <td class="Label3">负责人<em>*</em>
                    </td>
                    <td class="Field3" colspan="2">
                        <asp:TextBox ID="txtMangerPerson" runat="server" CssClass="TextBox" IsRequired='1'></asp:TextBox><input type="button" value="..." class="ButtonBox" onclick="selectUser(4)" />
                        <asp:HiddenField ID="hdMangerPerson" runat="server" />
                    </td>
                </tr>
            <tr>
            <td class="Label3">文件上传</td>
            <td class="Field3" colspan="5">
                <input type="file" id="Filedata" name="Filedata" title="文件上传"/><br/>
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


             //cell = row.insertCell(2);
             //cell.align = "center";
             //cell.className = "Field pointer";
             //cell.innerHTML = entity.ComponentCode;

             cell = row.insertCell(2);
             cell.align = "center";
             cell.className = "Field";
             cell.width = "80px";
             cell.innerHTML = entity.Describe;

             var result1 = GetEquimentMouldAll($("#<%=this.hdnEquimentId.ClientID%>").val(), entity.MouldTypeId);
             if (null != result1 && result1.value.length > 0) {
                    
                 cell = row.insertCell(3);
                 cell.align = "center";
                 cell.className = "Field pointer";
                 cell.innerHTML =result1.value[0].MouldCode;

             } else {
                  
                 cell = row.insertCell(3);
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
             cell.innerHTML =" <input type=\"hidden\" class=\"hdMouldBomChildId\" value=\"" + entity.MouldBomChildId + "\" />" +entity.CompomentCode;
             
             cell = row.insertCell(2);
             cell.align = "center";
             cell.className = "Field";
             cell.width = "80px";
             cell.innerHTML = entity.Describe;
  
             cell = row.insertCell(3);
             cell.align = "center";
             cell.className = "Field pointer";
             cell.innerHTML =entity.MouldCode;

             
         }
    </script>
     <script type="text/javascript">
         var chooseFlag = -1;
         /*粉体类型*/
         function selectResourceType() {
              chooseFlag = 1;
             dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=5&Multiple=false&rnd=" + Math.random(), width: 500, height: 300 });
         }

         /*异常类型*/
         function selectAnormalType() {
             chooseFlag = 2;
             dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=702&Multiple=false&rnd=" + Math.random(), width: 500, height: 300 });
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
                 <%-- $("#<%=this.txtResourceType.ClientID %>").val(list[0][1]);
                 $("#<%=this.hdResourceTypeId.ClientID %>").val(list[0][0]);--%>
             } else if (chooseFlag == 2) {
                 $("#<%=this.txtAnormalType.ClientID %>").val(list[0][1]);
                 $("#<%=this.hdAnormalTypeId.ClientID %>").val(list[0][0]);
             } else if (chooseFlag == 3) {
                 $("#<%=this.txtEquimentCode.ClientID %>").val(list[0][2]);
                 $("#<%=this.hdnEquimentId.ClientID %>").val(list[0][0]); 
             }  else if(chooseFlag ==4){
                 $("#<%=this.hdMangerPerson.ClientID %>").val(list[0][2]);
                 $("#<%=this.txtMangerPerson.ClientID %>").val(list[0][3]);
             } else if (chooseFlag == 11) {
                 $("#<%=this.txtBomName.ClientID %>").val(list[0][1]);
                 $("#<%=this.hdMouldBomId.ClientID %>").val(list[0][0]);

                 GetMouldBomChild(list[0][0]);

             }else if (chooseFlag == 702) {
                 var anormal = "";
                 for(var i=0;i<list.length;i++){
                     anormal += list[i][1]+",";
                 }
                 anormal = anormal.substring(0,anormal.length-1);

                 $("#<%=this.txtAbnormalPhenomenon.ClientID %>").val(anormal);
             }
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
                    obj.preview(function(index, file, result) {
                        $('#<%=this.image1.ClientID%>').attr('src', result); //图片链接（base64）
                    });
                },
                done: function(res) {
               
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
           

            if (Id != -1) {
                $("#Filedata").hide();
                $("#showUploadCtrl").html("<a href='#'>重新上传</a>").click(function() {
                    $(this).hide();
                    $("#Filedata").show();
                });


                //如果已审核则不能编辑
                if ($("#<%=this.hdStatus.ClientID%>").val() == 2) {
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


            

            var docXml = "<Root>";
            var mouldBomChildId = "";
            var douldCode = "";
            var counts=$("#tblExpand tr:gt(0)").length;

            var j = 0;
            for (var i = 0; i < counts; i++) {
                var data = $("#tblExpand tr:gt(0)")[i];
                mouldBomChildId = $(data).find("td:eq(1) .hdMouldBomChildId").val();
               
                douldCode = $(data).find("td:eq(3)").html();

                docXml += "<Detail MouldBomChildId='" + mouldBomChildId + "' MouldCode='" + douldCode + "'></Detail>";
            }

           
            docXml += "</Root>";

            //if (j == 0) {
            //    alert("没有申请更换的模具");
            //    return false;
            //}
           

           
            var picUrl = $("#<%=this.lbFileReady.ClientID%>").html();
            var entity = {};
            entity.Id = Id;
            entity.MouldBomId = $("#<%=this.hdMouldBomId.ClientID%>").val();
            entity.EquipmentId = $("#<%=this.hdnEquimentId.ClientID%>").val();
            entity.AnormalTypeId = $("#<%=this.hdAnormalTypeId.ClientID%>").val();;

            entity.ResourceTypeId = -1;
            entity.AbnormalReason = $("#<%=this.txtAbnormalReason.ClientID%>").val();
            entity.AbnormalPhenomenon = $("#<%=this.txtAbnormalPhenomenon.ClientID%>").val();

            entity.Conclusion = $("#<%=this.txtConclusion.ClientID%>").val();
            entity.HandlePerson = $("#<%=this.hdHandlePerson.ClientID%>").val();
            entity.MangerPerson = $("#<%=this.hdMangerPerson.ClientID%>").val();

            entity.StartTime =new Date($("#<%=this.txtStartTime.ClientID %>").val().replace(/-/g, "\/"));
            entity.EndTime =new Date($("#<%=this.txtEndTime.ClientID %>").val().replace(/-/g, "\/"));
            entity.PicFile = picUrl;

            entity.IsLeak = $("#<%=this.ckeIsLeak.ClientID%>").is(':checked')?1:0;
            entity.Remark = "";
            entity.DocXml = docXml;
            try {
                if ($("#Filedata").val() != "") {
                    UploadRCCA(entity);
                }
                else {
                    entity.Rcca = $("#<%=this.hdnRCCAFilePath.ClientID%>").val();
                    SaveAnormal(entity);
                    parent.refresh();
                }
                
            }
            catch (ex)
            {
                alert(ex);
            }    
        }


           function UploadRCCA(entity)
        {
                var form = new FormData($("#form1")[0]);
                try {
                    $.ajax({
                        type: "POST",  //提交方式  
                        url: "../Handler/UploadHander.ashx?Action=UploadRCCA&rnd=" + Math.random(),//路径  
                        data: form,//数据
                        contentType: false, //禁止设置请求类型
                        processData: false, //禁止jquery对DAta数据的处理,默认会处理
                        success: function (data) {//返回数据根据结果进行相应的处理  
                            $("#<%=this.lblRCCAPath.ClientID%>").text(data.substring(data.lastIndexOf("/") + 1));
                            $("#<%=this.hdnRCCAFilePath.ClientID%>").val(data);
                            entity.Rcca = data;
                            SaveAnormal(entity);
                            parent.refresh();
                        },
                        error: function (xhr, status, error) {
                             
                        }
                    });
                }
                catch (ex) {
                    alert(ex);
                }
          
        }

        function SaveAnormal(entity)
        {
            var ajax = SKT.LeanMES.Web.Equipment.MouldAbnormalHandleEdit.Edit(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert('<%=Resources.Messages.SaveInSuccess %>');
            parent.window.UpdateList();
        
        }

         /*选择用户*/
         function selectUser(type) {

             chooseFlag = type;
             dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=12&Multiple=false&rnd=" + Math.random(), width: 500, height: 300 });
         }

    </script>
</asp:Content>
