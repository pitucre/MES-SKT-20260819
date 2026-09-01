<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="True"
    CodeBehind="MaintenanceDemoEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Maintenance.MaintenanceDemoEdit"
    Title="Edit MaintenanceDemo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
       <style type="text/css">
       .tdspan {
           display: block;
           border-top: 1px solid #d3d3d3;
           width: 105%;
           padding-bottom: 2px;
           margin-left: -7px;
       }

       .span0 {
           border: none;
       }

       #layermsg {
           position: absolute;
           left: 50%;
           top: 50%;
           width: 700px;
           height: 500px;
           margin-left: -350px;
           margin-top: -250px;
           display: none;
           z-index: 999;
       }
   </style>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td colspan="4" class="Label infoTips">
                <%=Resources.Messages.WithAsteriskIsRequired %>
            </td>
        </tr>
        <tr class="clear5"></tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.MaintenanceDemoNO%><em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtDemoCode" runat="server" CssClass="TextBox" MaxLength="50" isRequired="1"></asp:TextBox>
            </td>
            <td class="Label2">
                <%= Resources.lang.MaintenanceDemoName%><em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtDemoName" runat="server" CssClass="TextBox" MaxLength="50" isRequired="1"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.Description %>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtDescription" runat="server" CssClass="TextBox" MaxLength="200"></asp:TextBox>
            </td>
            <td class="Label2"></td>
            <td class="Field2"></td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.Remark %>
            </td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtRemark" runat="server" CssClass="TextArea" TextMode="MultiLine"
                    MaxLength="50" Width="99%" Height="50"></asp:TextBox>
            </td>
        </tr>
    </table>
    <div class="clear5">
    </div>
    <table class="ListTable" cellspacing="0" cellpadding="4" style="border-width: 0px; width: 100%; overflow: auto; border-collapse: collapse;"
        id="tbPackLevel">
        <tr class="ListTableHeader">
            <th scope="col" align="center" width="10%">作业编号
            </th>
            <th scope="col" align="center" width="25%">作业名称
            </th>
            <th scope="col" align="center" width="45%">作业说明
            </th>
            <th scope="col" align="center" width="45%">参考图片
            </th>
            
            <th scope="col" onclick="addPackLevelDetail(null);" style="color: #0066CC; cursor: pointer; width: 100px;"
                align="center" width="20%">+<%= Resources.Buttons.COM_Add%>
            </th>
        </tr>
    </table>
        <div id="layermsg">
    </div>
     <link href="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/css/layui.css" rel="stylesheet" />
 <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/layui.all.js"></script>
 <link type="text/css" href="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/uploadify/uploadify.css"
     rel="Stylesheet" />
 <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/uploadify/jquery.uploadify.min.js"></script>
    <script type="text/javascript">
        var tab = document.getElementById("tbPackLevel");
        var username = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
        var Id = <%= Request.QueryString["ID"] == null ? -1 : Convert.ToInt32(Request.QueryString["ID"].ToString())%>;
        /*页面加载时*/
        $(document).ready(function () {
            if (Id > 0) {
                GetDemoSubList(Id);
            }
        });
        function GetDemoSubList(demoId) {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaintenanceDemoSub.GetDemoSubList(demoId);
            if (ajax.error == null) {
                var entityAry = ajax.value;
                for (var i = 0; i < entityAry.length; i++) {
                    addPackLevelDetail(entityAry[i]);
                }
            }
            else {
                alert(ajax.error.Message);
            }
        }
        /*添加行*/
        function addPackLevelDetail(entity) {

            if (entity == null) {
                entity = {};
                entity.DemoSubId = -1;
                entity.DemoId = Id;
                entity.DemoSubCode = "";
                entity.DemoSubName = "";
                entity.Remark = "";
            }

            var DemoSubId = entity.DemoSubId == -1 ? 100 + tab.rows.length : entity.DemoSubId;
            var row, cell, optionvalue, disabled;
            rowNewIdx = tab.rows.length;
            row = tab.insertRow(rowNewIdx);
            row.className = "ListTableOddRow";
            row.id = DemoSubId;
            optionvalue = entity.PackingLevel;

            cell = row.insertCell(0);
            cell.align = "center";
            cell.innerHTML = "<input name=\"hdfSubId\" name=\"hidden\" type=\"hidden\" width=\"20\" value=\"" + entity.DemoSubId + "\"/><input type=\"text\" name=\"txtJobCode\" style=\"width:50px;\" maxlength=\"50\"  value=\"" + entity.DemoSubCode + "\" />";

            cell = row.insertCell(1);
            cell.align = "center";
            cell.innerHTML = "<input type=\"text\" name=\"txtJobName\" style=\"width:150px;\" maxlength=\"50\"  value=\"" + entity.DemoSubName + "\" />";

            cell = row.insertCell(2);
            cell.align = "center";
            cell.innerHTML = "<input type=\"text\" name=\"txtJobRemark\" style=\"width:300px;\" maxlength=\"50\"  value=\"" + entity.Remark + "\" />";


            cell = row.insertCell(3);
            cell.align = "center";
            cell.className = "ImageClass";
            if (entity.SaveFileName != "" && entity.SaveFileName != undefined) {
                var fileUrl = GetFilePath("EquipmentFailure", entity.SaveFileName);
                cell.innerHTML = "<img src =" + fileUrl + "  onclick='showPic(this.src)' style='width:60px; height:50px; cursor:pointer; ' /><input type='hidden' id='FileName" + +entity.DemoSubId + "' value='" + entity.SaveFileName + "'/>";
            } else {
                cell.innerHTML = "<input type='hidden' name='FileName' id='FileName" + +entity.DemoSubId + "' value=''/>";
            }

            cell = row.insertCell(4);
            cell.css = 'style="width: 15 %;"'
            cell.align = "center";
            cell.innerHTML = "<input style=\"CURSOR: pointer; COLOR: #0000ff;width:60px\" demoSubId='" + DemoSubId + "' value='上传图片'  name='ipfileUpload' id='upload-image" + DemoSubId + "'\" /><span style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"deleteItem(this)\"><%= Resources.Buttons.COM_Delete %></span>";

            
           
            layui.use('upload', function () {
                var $ = layui.jquery, upload = layui.upload;
         
                var idStr = '#upload-image' + DemoSubId
                    //图片上传
                    upload.render({
                        elem: idStr,
                        url: '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/UploadHander.ashx',
                  data: { Action: "EquipmentFailure", userName: username },
                  exts: 'jpg|jpge|gif|png', //只允许上传excel文件
                  size: 10240,//限制文件大小，单位 KB
                  multiple: true,
                  done: function (res) {
                      debugger;
                      //如果上传失败
                      if (res.msg != "上传成功") {
                          alert("上传失败:" + res.msg);
                          return false;
                      }
                      var fileUrl = GetFilePath("EquipmentFailure", res.data.FileName);
                      var display = "<img src =" + fileUrl + "  onclick='showPic(this.src)' style='width:60px; height:50px; cursor:pointer; ' /><input type='hidden' name='FileName' id='FileName" + DemoSubId + "' value='" + res.data.FileName + "'/>";
                      $("#" + DemoSubId).find("td").eq(3).html(display);


                  },
                  before: function (obj) {
                  },
                  error: function () {
                      //debugger;
                      alert("上传失败！");
                  }
                  });
             
                  });
        }

        //预览图片
        function showPic(picUrl) {
            var picContent = "<div id='divClose' title='关闭'>X</div><img width=\"700\" height=\"500\" src=" + picUrl + " />";
            var bodyheight = $("body").height();
            var bodywidth = $("body").width();

            $("#layermsg").html(picContent).show();
            $("#layermsg").bind("click", function () { $("#layermsg,#layer").hide(); });
            $("#layer").css({
                height: bodyheight,
                width: bodywidth,
                display: "block"
            });
        }
        function UpLoad() {
            
            var username = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
      
        }

        /*删除保养项作业行*/
        function deleteItem(obj) {
            tab.deleteRow(obj.parentElement.parentElement.rowIndex);
        }
        /*保养作业项保存*/
        function saveItem(obj) {
            var code = $(obj).parent().parent().find($("input[name='txtJobCode']")).val();
            var name = $(obj).parent().parent().find($("input[name='txtJobName']")).val();
            var remark = $(obj).parent().parent().find($("input[name='txtJobRemark']")).val();
            if (code == "") {
                alert("请输入保养项作业编号!");
                return false;
            }
            if (name == "") {
                alert("请输入保养项作业名称!");
                return false;
            }
            var entity = {};
            if ($("#hdfSubId").val() == "-1") {
                entity.DemoSubId = -1;
            }
            else {
                entity.DemoSubId = parseInt($(obj).parent().parent().find($("input[name='hidden']")).val());
            }
            if (Id == "-1") {
                alert("请先保存保养项主表信息!");
                return false;
            }
            entity.DemoId = Id;
            entity.DemoSubCode = code;
            entity.DemoSubName = name;
            entity.Remark = remark;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaintenanceDemoSub.Edit(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert('<%=Resources.Messages.SaveInSuccess%>')
        }
        /*保存数据*/
        function Save() {
            var txtDemoCode = $.trim($("#<%=this.txtDemoCode.ClientID%>").val());
            var txtDemoName = $.trim($("#<%=this.txtDemoName.ClientID%>").val());
            var txtDescription = $.trim($("#<%=this.txtDescription.ClientID%>").val());
            var txtRemark = $.trim($("#<%=this.txtRemark.ClientID%>").val());


            /*表单验证*/
            /*如需表单验证可以此处处理验证 开始*/

            var entity = {};

            entity.DemoId = Id
            entity.DemoCode = txtDemoCode;
            entity.DemoName = txtDemoName;
            entity.Description = txtDescription;
            entity.Remark = txtRemark;
            var code = "";
            var name = "";
            var remark = "";
            var fileName = "";
            var demoSubId = 0;

            var xmlStr = "<?xml version='1.0' encoding='gb2312'?><Root>";
            $("#tbPackLevel tr:not(:first)").each(function (index, element) {
                demoSubId = $(this).children("td:eq(0)").find("[name='hdfSubId']").val();
                code = $(this).children("td:eq(0)").find("[name='txtJobCode']").val();
                name = $(this).children("td:eq(1)").find("[name='txtJobName']").val();
                remark = $(this).children("td:eq(2)").find("[name='txtJobRemark']").val();
                fileName = $(this).children("td:eq(3)").find("[name='FileName']").val();
                xmlStr += "<Demo DemoSubId='" + demoSubId + "' DemoSubCode='" + code + "' DemoSubName='" + name + "'  Remark='" + remark + "' SaveFileName='" + fileName +"'></Demo>";

            });
            xmlStr += "</Root>";
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaintenanceDemo.MaintenanceDemoEdit(entity, xmlStr);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert('<%=Resources.Messages.SaveInSuccess%>')
            if ('<%=Request.QueryString["inMenu"] %>' == "true") {
                openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Maintenance/MaintenanceDemoEdit.aspx?name=MaintenanceDemoEdit&ID=" + parseInt(ajax.value);
                location.href = openWinUrl;
            }
            else {
                parent.window.Refresh();
            }
        }
    </script>
</asp:Content>
