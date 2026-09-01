<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="EquipmentInspectionTemplateCopy.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.EquipmentInspectionTemplateCopy" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <script src="../Content/plugin/tabs/jPlugin-tabs.js"></script>
    <link href="../Content/plugin/tabs/tabs.css" rel="stylesheet" />
    <link href="../Content/plugin/bootstrap/css/bootstrap.css" rel="stylesheet" />
    <style type="text/css">
        .btn-view {
            font-size: 12px;
        }

        .td-upload a.btn {
            padding: 3px 20px;
        }

        .ListTableHeader th {
            background: none no-repeat #f5f5f5
        }

        .uploadify-button {
            text-align: center;
        }

        #div-upload {
            overflow: hidden;
        }

        .file-input {
            width: 180px;
            position: absolute;
            left: -100px;
            top: 0;
            z-index: 1;
            -moz-opacity: 0;
            -ms-opacity: 0;
            -webkit-opacity: 0;
            opacity: 0;
            filter: alpha(opacity=0);
            cursor: pointer;
        }

        .layui-upload-img {
            height: 50px;
            width: 50px;
        }
    </style>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td colspan="6" class="Label"> <span>点击[添加点检项目]可新增点检项目</span>, <em>*</em><span>为必填项</span>
            </td>
        </tr>
        <tr>
            <td class="Label3">
                <%=Resources.lang.InspectionTemplateName %><em>*</em>
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtInspectionTemplateName" runat="server" CssClass="TextBox" IsRequired="1"></asp:TextBox>
            </td>
            <td class="Label3">
                <%=Resources.lang.InspectionTypeId%>
            </td>
            <td class="Field3">
                <asp:DropDownList ID="ddlInspectionType" runat="server">
                </asp:DropDownList>
            </td>
            <td class="Label3">
                <%=Resources.lang.Status %>
            </td>
            <td class="Field3">
                <asp:HiddenField ID="txtHideInspectionTemplateId" runat="server" />
                <asp:HiddenField ID="txtHideCreateTime" runat="server" />
                <asp:HiddenField ID="txtHideCreater" runat="server" />
                <asp:DropDownList runat="server" ID="ddlStatus">
                    <asp:ListItem>启用</asp:ListItem>
                    <asp:ListItem>禁用</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="Label3">
                <%=Resources.lang.AC_OBA_Rev%>
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtVersion" MaxLength="50" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">
                <%=Resources.lang.Description%>
            </td>
            <td class="Field3" colspan="4">
                <asp:TextBox ID="txtDescription" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
    </table>
    <table id="tblExpand" cellspacing="0" cellpadding="4" style="border-width: 0px; width: 100%; border-collapse: collapse; margin-top: 5px;"
        class="EditeContentTable">
        <tr class="ListTableHeader" style="text-align: center">
            <th scope="col" style="width: 5%;">序号
            </th>
            <th scope="col" style="width: 13%;">点检项名称
            </th>
            <th scope="col" style="width: 20%;">工序

            </th>
            <%--         <th scope="col" style="width: 15%;">
                <%=Resources.lang.TestMethod %>
            <--%>
            <th scope="col" style="width: 13%;" id="trJcyj">
                <%=Resources.lang.TestBasis %>
            </th>
            <th scope="col" style="width: 8%;" id="trLrfs">录入方式
            </th>
            <th scope="col" style="width: 10%;" id="trPdbz">判断标准
            </th>
            <th scope="col" style="width: 10%;" id="trDw">单位
            </th>
            <th scope="col" style="width: 15%;">检验方法
            </th>
            <th scope="col" style="width: 10%;">是否上传图片
            </th>
            <th scope="col" style="width: 15%;">备注
            </th>
            <th scope="col" onclick="chooseInspectionItem(null);" style="color: #0066CC; cursor: pointer; width: 5%;">+
               <%=Resources.lang.AddInspection%>
            </th>
            <th scope="col" style="width: 15%;">图片上传
            </th>
            <th scope="col" style="width: 15%;">已上传图片
            </th>

        </tr>
        <tr id="trNewInfo" class="ListTableOddRow">
            <td colspan="9" style="text-align: center;">
                <%=Resources.Messages.HaveNothingData%>
            </td>
        </tr>
    </table>
    <input type="hidden" id="controlId" />
    <input type="hidden" id="hdInspectionTypeId" runat="server" />
    <input type="hidden" id="hdinspecType" value="-1" />

     <div style="        display: none;">
        <asp:HiddenField ID="hidInspectionTemplateId" runat="server" ClientIDMode="Static" />
        <asp:HiddenField ID="hidInspectionItemId" runat="server" ClientIDMode="Static" />
        <asp:HiddenField ID="hidFileType" runat="server" ClientIDMode="Static" />
    </div>
     <%--文件上传--%>
    <div id="div-upload" style="        position: relative;
        display: none;">
        <a class="btn btn-link"><span class="">上传</span></a>
        <input type="file" name="file" onchange="uploadFileFormData(this.value)" class="file-input" />
    </div>

    <script type="text/javascript" src="../Content/plugin/uploadify/jquery.uploadify.js"></script>
    <style type="text/css">
        .selectRow td {
            background-color: #C4C4C4;
        }

        .pointer {
            cursor: pointer;
        }
    </style>
    <script language="javascript" type="text/javascript">
        var tab = document.getElementById("tblExpand");
        var selectRowClass = "selectRow";
        var index = 1;
        var inspecType = -1;
        var upurl = '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/UploadHander.ashx';
        var isFirst = true;
        var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
        var userCName = "<%= SKT.LeanMES.Web.AccountController.GetCurrentUser().EmployeeCName %>";
        var modifyBy = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
        $(function () {
            $("#form1").attr({ "method": "post", "onsubmit": "return upload(this)", "enctype": "multipart/form-data" });
            //上传
            $(".td-upload").live("hover", function () {
                var Id = $(this).parent().parent().find("input.hdInspectionItemId").val();
                if (isFirst) {
                    isFirst = false;
                    var height = $(".td-upload div").first().height() + 12;
                    var width = $(".td-upload div").first().width();
                    //$(".uploadify-button").css({ "height": height, "width": width });
                    //$("#div-upload").css({ "height": height, "width": width });
                    //$("#fileUpload").css({ "height": height, "width": width });
                    $("#div-upload").css({ "width": width });
                }
                if ($(this).find("#div-upload").length > 0) {
                    return;
                }
                if ($(this).find(".file-upload").is(":hidden")) {
                    return;
                }
                var obj = $(this).parent();
                //$("#hidInspectionId").val(obj.attr("InspectionId"));
                $("#hidInspectionItemId").val(Id);
                $("#hidFileType").val($(this).attr("file-type"));
                $(this).find(".file-upload").hide().closest("tr").siblings().find(".file-upload").show();
                $(this).closest("td").siblings().find(".file-upload").show();
                $("#div-upload").show().prependTo($(this));
            });

            //查看
            $(".btn-view").live("click", function () {
                var serverFileName = $(this).closest("td").attr("fileNameServer");
                if (serverFileName) {
                    FileSave(serverFileName);
                }
            });

            //删除文件
            $(".delete-upload").live("click", function () {
                var serverFileName = $(this).closest("td").attr("fileNameServer");
                if (!serverFileName) {
                    return false;
                }
                if (!confirm("确认要删除吗？")) {
                    return false;
                }
                alert("删除成功！");
                $(this).parent().parent().parent().prev().prev().prev().find("select").val(0);
                $(this).parent().parent().parent().attr("filenameserver", "");
                $(this).parent().parent().parent().attr("title", "");
                $(this).parent().parent().parent().next().html("");
                //移除查看、删除按钮
                $(this).siblings(".btn-view").remove();
                $(this).remove();


            });

        });
        function uploadFileFormData(filePath) {
            if (filePath.length > 0) {
                upload($("#form1")[0]);
                return false;
            }
        }

        function xhrupload(fd, url) {
            var xhr = new XMLHttpRequest();
            xhr.open("post", url, true);
            xhr.onreadystatechange = function () {
                if (xhr.readyState == 4) {
                    //清空上传文本框中的文件
                    $("#div-upload input[type=\"file\"]")[0].value = "";

                    if (200 == xhr.status) {
                        var entity = JSON.parse(xhr.responseText);
                        if (entity.code == 1) {
                            alert("上传失败！" + entity.Msg);
                            return;
                        } else {
                            //上传成功后，可以查看、删除文件
                            //var hl = "<a class=\"btn-view btn btn-link\"><span class=\"\">查看</span></a><a class=\"delete-upload btn btn-link\"><span class=\"\">删除</span></a>";

                            var hl = "<a class=\"delete-upload btn btn-link\"><span class=\"\">删除</span></a>";
                            $("#div-upload").siblings("div").find("a.file-upload").nextAll().remove();
                            $("#div-upload").siblings("div").find("a.file-upload").after(hl);
                            $("#div-upload").closest("td").attr({ "fileNameServer": entity.data.FileName, "title": entity.data.FileName });
                            alert("上传成功");

                            $("#div-upload").parent().parent().parent().find("td:last").html("");
                            $("#div-upload").parent().parent().parent().find("td:last").append("<img  class=\"layui-upload-img\" src=\"/ESOP/DownLoad.aspx?Action=EquipmentTemplateItemFile&amp;fileName=" + entity.data.FileName + "\">");
                            //$("#IsUpLoadImg").val(1);  
                            return;
                        }
                    }
                    else {
                        alert('发生错误\nstatus:' + xhr.status + '\n返回内容:' + xhr.responseText);
                    }
                }
            }
            xhr.send(fd);
        }
        function upload(f) {
            if (window.FormData) {
                var fd = new FormData();
                fd.append("Action", "EquipmentTemplateItemFile");

                fd.append("file", f.file.files[0]);
                fd.append("InspectionTemplateId", $.trim(ReqId));
                fd.append("InspectionItemId", $.trim($("#hidInspectionItemId").val()));
                fd.append("fileType", $.trim($("#hidFileType").val()));
                fd.append("userName", userName);
                xhrupload(fd, upurl);
                return false;//阻止表单提交
            }
            else {
                alert('不支持html5 ajax上传！');
            }
            return false;
        }


        function FileSave(data) {
            var path = '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>' + "/ESOP/DownLoad.aspx?Action=FileUploadEquiment&amp;fileName=" + data;
            window.open(path);
        }


        $(function () {

            inspecType = $("#<%=this.hdInspectionTypeId.ClientID%>").val();

            if (inspecType == "") {
                $("#hdinspecType").val(-1);
            } else {
                $("#hdinspecType").val(inspecType);
            }

            $("#<%=this.ddlInspectionType.ClientID %>").change(function () {
                var inspecType = this.value;
                var entity = SKT.LeanMES.Web.Quality.InspectionTemplateEdit.GetInspectionTypeInf(inspecType).value;

                $("#hdinspecType").val(entity.SystemType);
                SetCoum();

            });
            var listArr = GetInspectionTemplateMember();
            if (null != listArr) {
                index = 1;
                for (var i = 0; i < listArr.length; i++) {
                    addDetail(listArr[i], index);
                    index++;
                }
            }
            SetCoum();
        });

        function SetCoum() {
            var inspecType = $("#hdinspecType").val();

            if (inspecType == 2) {

                for (var i = 0; i < tab.rows.length; i++) {

                    tab.rows[i].cells[1].style.display = "";
                    tab.rows[i].cells[2].style.display = "";
                    tab.rows[i].cells[3].style.display = "none";
                    tab.rows[i].cells[4].style.display = "none";
                    tab.rows[i].cells[5].style.display = "none";
                }

                //$("#trLrfs").hide();
                //$("#trPdbz").hide();
                //$("#trDw").hide();
            } else {

                for (var i = 0; i < tab.rows.length; i++) {
                    tab.rows[i].cells[2].style.display = "none";
                    tab.rows[i].cells[3].style.display = "";
                    tab.rows[i].cells[4].style.display = "";
                    tab.rows[i].cells[5].style.display = "";
                }
                //$("#trLrfs").show();
                //$("#trPdbz").show();
                //$("#trDw").show();
            }
        }


        function chooseInspectionItem() {
            var openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/EquipmentInspectionItemDialog.aspx?name=Equipment_InspectionItemDialog&controlId=controlId";
            dialog({ title: "<%=Resources.Pages.InspectionItem %>", src: openWinUrl, width: 255, height: 350 });
        }

        function SetValue(list) {
            closeDialog();
            var obj = $(".hdInspectionItemId");
            for (var i = 0; i < list.length; i++) {
                var flag = true;
                for (var j = 0; j < obj.length; j++) {
                    if ($(obj[j]).val() == list[i].InspectionItemId) {
                        flag = false;
                        break;
                    }
                }
                if (flag && !list[i].IsParent) {
                    list[i].MaxValue = 0;
                    list[i].MinValue = 0;
                    list[i].SpecialRequest = "无";
                    list[i].InspectionAccording = "";
                    list[i].InspectJuge = "";
                    addDetail(list[i], index);
                    index++;
                }
            }
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
            cell.innerHTML = " <input type=\"hidden\" class=\"hdInspectionItemId\" value=\"" + entity.InspectionItemId + "\" />" + entity.InspectionItemName;


            $(cell).click(function () {
                var className = $(this.parentNode).attr("class");
                if (className.indexOf(selectRowClass) > -1) {
                    $(this.parentNode).removeClass(selectRowClass);
                }
                else {
                    $(tab).find("tr").removeClass(selectRowClass);
                    $(this.parentNode).addClass(selectRowClass);
                }
            })


            //cell = row.insertCell(2);
            //cell.align = "center";
            //cell.className = "Field pointer";
            //cell.innerHTML =entity.TestMethod;


            cell = row.insertCell(2);
            cell.align = "center";
            cell.className = "Field pointer";
            cell.innerHTML = "<input type=\"text\" name=\"txtOpenName\"  value='" + entity.OpenName + "' class=\"TextBox txtOpenName\"  disabled=\"disabled\" style=\" width:65%;\"  />"
                + "<input type=\"button\" onclick=\"selectOpenName(" + entity.InspectionItemId + ",this);\" class=\"ButtonBox\" value=\"...\" />"
                + "<input type=\"hidden\" name=\"hdOpenID\" class=\"hdOpenID\" value='" + entity.OpenID + "'  />";


            cell = row.insertCell(3);
            cell.align = "center";
            cell.className = "Field pointer";
            cell.innerHTML = '<input type="text" class="InspectionAccording" value="' + entity.InspectionAccording + '" MaxLength="50"  style="width:70px;height:25px;"/>'



            cell = row.insertCell(4);
            cell.align = "center";
            cell.className = "Field";
            cell.width = "80px";
            cell.id = entity.InspectionMethodId;



            if (typeof (entity.InspectionMethodId) == "undefined") {
                cell.innerHTML = "请维护检验项的录入方式";
                cell = row.insertCell(5);
                cell.align = "center";
                cell.className = "Field";
                cell.innerHTML = '';

            } else {
                cell.innerHTML = (entity.InspectionMethodId == 1 ? "固定结果" : "指定值");

                cell = row.insertCell(5);
                cell.align = "center";
                cell.className = "Field";
                cell.innerHTML = (entity.InspectionMethodId == 1 ? "OK/NG" : ' <input type="text" class="InspectionAccording" MaxLength="50" readonly="readonly" value="'
                    + (typeof (entity.InspectionMethodValue) == "undefined" ? "" : entity.InspectionMethodValue)
                    + '" style="width:40%;"/><input type="button" onclick="Set(this)" style="width:80px;margin-left:7px" value="' + mesLang('设置') +'"></input>');
            }



            cell = row.insertCell(6);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = ' <input type="text" MaxLength="50" value="' + (typeof (entity.UnitName) == "undefined" ? "" : entity.UnitName) + '" style="width:30%;" class="txtUnit"/>' +
                '<input type=\"button\" onclick=\"selectUnit(this);\" class=\"ButtonBox\" value=\"...\" /><input name="txtOffsetUnit" type="hidden" value="' + entity.OffsetUnitName + '" />';



            cell = row.insertCell(7);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = ' <input type="text" MaxLength="200" value="' + (typeof (entity.CheckFashion) == "undefined" ? "" : entity.CheckFashion) + '" style="width:80%;" class="txtInspectionmethods"/>' +
                '<input type=\"button\" onclick=\"selectInspectionmethods(this);\" class=\"ButtonBox\" value=\"...\" />';


            if (entity.IsUpLoadImg == 1) {
                cell = row.insertCell(8);
                cell.align = "center";
                cell.className = "Field";
                cell.innerHTML = "<select id=\"IsUpLoadImg\" name=\"IsUpLoadImg\"><option value=\"1\" >是</option><option value=\"0\">否</option></select>";
            }
            else {
                cell = row.insertCell(8);
                cell.align = "center";
                cell.className = "Field";
                cell.innerHTML = "<select id=\"IsUpLoadImg\" name=\"IsUpLoadImg\"><option value=\"0\">否</option><option value=\"1\">是</option></select>";
            }
            //begin: fred, 221124
            cell = row.insertCell(9);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = ' <input type="text" MaxLength="200" value="' + (typeof (entity.NoteText) == "undefined" ? "" : entity.NoteText) + '" style="width:80%;" class="txtNoteText"/>';
            // end: 221124


            cell = row.insertCell(10);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<span style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"deleteItem(this)\"><%= Resources.Buttons.COM_Delete %></span>";

            cell = row.insertCell(11);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<span class=\"td-upload\" file-type=\"1\"><div style=\"position: relative\"><a class=\"file-upload btn btn-link\"><span class=\"upload-txt\">" + mesLang("上传") +"</span></a></div></span>";

            /*已上传图片*/
            cell = row.insertCell(12);
            cell.align = "center";
            cell.className = "Field";
            if (entity.OpenName != null && entity.OpenName != "") {
                cell.innerHTML = "<img class=\"layui-upload-img\" src=\"/ESOP/DownLoad.aspx?Action=EquipmentTemplateItemFile&amp;fileName=" + entity.OpenName + "   \" />";
                $(cell).prev().attr("filenameserver", entity.OpenName)
            }
            BindIsPercentage("IsPercentage" + entity.InspectionItemId);
        }

        //获取单位
        var rowObj1 = null;
        function selectUnit(obj) {
            rowObj1 = obj.parentElement.parentElement;
            var searchCondition = " DicProperty='Unit' ";
            dialog({
                title: "<%=Resources.Common.ChooseWindow %>"
                , src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=3&CallBackFunc=getChooseValuesselectUnit&PageCondition= " + searchCondition + "&Multiple=false&rnd=" + Math.random(), width: 650, height: 350
            });
        }

        function getChooseValuesselectUnit(list) {
            $(rowObj1).find(".txtUnit").val(list[0][1]);
        }

        //获取检验方法
        var rowObj2 = null;
        function selectInspectionmethods(obj) {
            rowObj2 = obj.parentElement.parentElement;
            var searchCondition = " DicProperty='Inspectionmethod' ";
            dialog({
                title: "<%=Resources.Common.ChooseWindow %>"
                , src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=822&CallBackFunc=getChooseValuesselectInspectionmethods&PageCondition= " + searchCondition + "&Multiple=false&rnd=" + Math.random(), width: 650, height: 350
            });
        }

        function getChooseValuesselectInspectionmethods(list) {
            $(rowObj2).find(".txtInspectionmethods").val(list[0][1]);
        }

        var GetValue = function (data, Id) {
            closeDialog();
            data = data.replace('&gt;', ">");
            data = data.replace('&lt;', "<");


            $("#tblExpand tr").eq(Id).find("td:eq(4) input[type='text']").val(data);
        }

        var Set = function (result) {
            var Id = $(result).parent().parent().find("td:eq(0)").html();
            var InspectionMethodValue = $(result).parent().find("input.InspectionAccording").val();
            var openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Quality/InspectionTemplateEditValue.aspx?name=InspectionTemplateEditValue&value=" + InspectionMethodValue + "&Id=" + Id;
            dialog({ title: "<%=Resources.Pages.InspectionTemplateEditValue %>", src: openWinUrl, width: 500, height: 300 });
        }
<%--        function addDetail(entity, i) {
            var row, cell;
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
            cell.innerHTML = " <input type=\"hidden\" class=\"hdInspectionItemId\" value=\"" + entity.InspectionItemId + "\" />" + entity.InspectionItemName;


            $(cell).click(function () {
                var className = $(this.parentNode).attr("class");
                if (className.indexOf(selectRowClass) > -1) {
                    $(this.parentNode).removeClass(selectRowClass);
                }
                else {
                    $(tab).find("tr").removeClass(selectRowClass);
                    $(this.parentNode).addClass(selectRowClass);
                }
            })

            cell = row.insertCell(2);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = ' <input type="text" class="InspectJuge" value="' + entity.InspectJuge + '" style="width:80%;"/>';

            cell = row.insertCell(3);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = ' <input type="text" class="InspectionAccording" value="' + entity.InspectionAccording + '" style="width:80%;"/>';

            cell = row.insertCell(4);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<span style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"deleteItem(this)\"><%= Resources.Buttons.COM_Delete %></span>";

            BindIsPercentage("IsPercentage" + entity.InspectionItemId);
        }--%>

        function BindIsPercentage(id) {
            $("#" + id).click(function () {
                id = $(this).attr("id");
                var value = parseInt($("#hd" + id).val());;
                if (value == 1) {
                    value = 0;
                }
                else {
                    value = 1
                }
                $("#hd" + id).val(value);
            });
        }

        function deleteItem(obj) {
            if (typeof (obj) == "number") {
                tab.deleteRow(rowIndex);
            }
            else {
                tab.deleteRow(obj.parentElement.parentElement.rowIndex);
            }
        }

        var rowObj = null;
        var rowIndex = 0;

        var ReqId = '<%=Request.QueryString["ID"] %>';
        $("select").css("width", "140px");

        /*保存数据*/
        function Save() {
            var IIObject = $(".hdInspectionItemId");
            var InspectionAccordingObj = $(".InspectionAccording");
            var SamplingRateObj = $(".SamplingRate");

            var InspectionItemIdList = "";
            for (var i = 0; i < IIObject.length; i++) {
                InspectionItemIdList += (InspectionItemIdList == "" ? $(IIObject[i]).val() : "," + $(IIObject[i]).val());
            }
            var entity = {};
            entity.InspectionTemplateId = -1;
            entity.InspectionTemplateName = $("#<%=this.txtInspectionTemplateName.ClientID %>").val();
            entity.CreateTime = new Date($("#<%=this.txtHideCreateTime.ClientID %>").val());
            entity.Creater = $("#<%=this.txtHideCreater.ClientID %>").val();
            entity.Status = $("#<%=this.ddlStatus.ClientID %>").val() === '启用' ? true : false;
            entity.Description = $("#<%=this.txtDescription.ClientID %>").val();
            entity.InspectionItemIdList = InspectionItemIdList;
            entity.InspectionTypeId = $("#<%=this.ddlInspectionType.ClientID %>").val();
            entity.Creater = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
            entity.Version = $("#<%=this.txtVersion.ClientID %>").val();
            if (entity.InspectionTemplateId === '') {
                entity.InspectionTemplateId = ReqId;
            }
            if (ReqId == -1) {
                entity.CreateTime = new Date();
            }
            var list = [];
            for (var i = 0; i < $("#tblExpand tr:gt(0)").length; i++) {
                var data = $("#tblExpand tr:gt(0)")[i];

                var en = {};
                //  $(o[i]).val();
                en.InspectionTemplateId = entity.InspectionTemplateId;
                en.InspectionItemId = $($(".hdInspectionItemId")[i]).val();
                if (en.InspectionItemId == null || en.InspectionItemId == "undefined") {
                    alert("请添加检验项目");
                    return;
                }
                en.MaxValue = 0;
                en.MinValue = 0;
                en.SpecialRequest = "";
                en.InspectionAccording = $(data).find("td:eq(3) input").val();
                en.SamplingRate = 0;
                en.Remark = "";
                en.IsPercentage = -1;
                en.AQLRuleId = -1;
                en.InspectJuge = "";


                en.InspectionMethodId = $(data).find("td:eq(4)").attr("id");

                if (en.InspectionMethodId == 1) {
                    en.InspectionMethodValue = "OK/NG";
                } else {
                    en.InspectionMethodValue = $(data).find("td:eq(5) input:first").val();
                }
                //en.InspectionMethodValue = $($(".InspectionAccording")[i]).val();
                en.UnitName = $(data).find("td:eq(6) input.txtUnit").val();
                en.OffsetUnitName = $(data).find("td:eq(6) input[name='txtOffsetUnit']").val();
                en.CheckFashion = $(data).find("td:eq(7) input").val();
                en.OpenId = $(data).find("td:eq(2) [name='hdOpenID']").val();
                if ($(data).find("td:eq(11)").attr("filenameserver") != null && $(data).find("td:eq(11)").attr("filenameserver") != undefined && $(data).find("td:eq(11)").attr("filenameserver") != "") {
                    en.IsUpLoadImg = 1;
                } else {
                    en.IsUpLoadImg = 0;
                }
                en.NoteText = $(data).find("td:eq(9) input.txtNoteText").val();
                if ($(data).find("td:eq(11)").attr("filenameserver") != null && $(data).find("td:eq(11)").attr("filenameserver") != undefined && $(data).find("td:eq(11)").attr("filenameserver") != "") {
                    en.ImgUrl = $(data).find("td:eq(11)").attr("filenameserver");

                } else {
                    en.ImgUrl = "";
                }
                list.push(en);
            }
            if (list.length == 0) {
                alert("请添加检验项目");
                return;
            }
            entity.TempItems = JSON.stringify(list);

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipmentInspectionItem.EquipmentInspectionTemplateEdit(JSON.stringify(entity));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert('<%=Resources.Messages.SaveInSuccess %>');
            parent.window.UpdateList($("#<%=this.ddlStatus.ClientID %>").val());
            return ajax;
        }


<%--        /*保存数据*/
        function Save() {
            var IIObject = $(".hdInspectionItemId");
            var InspectionAccordingObj = $(".InspectionAccording");
            var SamplingRateObj = $(".SamplingRate");

            var InspectionItemIdList = "";
            for (var i = 0; i < IIObject.length; i++) {
                InspectionItemIdList += (InspectionItemIdList == "" ? $(IIObject[i]).val() : "," + $(IIObject[i]).val());
            }
            var entity = {};
            entity.InspectionTemplateId = -1;
            entity.InspectionTemplateName = $("#<%=this.txtInspectionTemplateName.ClientID %>").val();
            entity.CreateTime = new Date($("#<%=this.txtHideCreateTime.ClientID %>").val());
            entity.Creater = $("#<%=this.txtHideCreater.ClientID %>").val();
            entity.Status = $("#<%=this.ddlStatus.ClientID %>").val() === '启用' ? true : false;
            entity.Description = $("#<%=this.txtDescription.ClientID %>").val();
            entity.InspectionItemIdList = InspectionItemIdList;
            entity.InspectionTypeId = $("#<%=this.ddlInspectionType.ClientID %>").val();
            entity.Creater = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
            if (entity.InspectionTemplateId === '') {
                entity.InspectionTemplateId = ReqId;
            }
            if (ReqId == -1) {
                entity.CreateTime = new Date();
            }
            var list = [];
            for (var i = 0; i < $("#tblExpand tr:gt(0)").length; i++) {
                var data = $("#tblExpand tr:gt(0)")[i];

                var en = {};
                //  $(o[i]).val();
                en.InspectionTemplateId = entity.InspectionTemplateId;
                en.InspectionItemId = $($(".hdInspectionItemId")[i]).val();
                en.MaxValue = 0;
                en.MinValue = 0;
                en.SpecialRequest = "";
                en.InspectionAccording = $(data).find("td:eq(2) input").val();
                en.SamplingRate = 0;
                en.Remark = "";
                en.IsPercentage = -1;
                en.AQLRuleId = -1;
                en.InspectJuge = "";//$($(".InspectJuge")[i]).val();

                en.InspectionMethodId = $(data).find("td:eq(3)").attr("id");
                if (en.InspectionMethodId == 1) {
                    en.InspectionMethodValue = "OK/NG";
                } else {
                    en.InspectionMethodValue = $(data).find("td:eq(4) input:first").val();
                }
                //en.InspectionMethodValue = $($(".InspectionAccording")[i]).val();
                en.UnitName = $(data).find("td:eq(5) input").val();
                en.CheckFashion = $(data).find("td:eq(6) input").val();
                list.push(en);
            }
            if (list.length == 0) {
                alert("请添加检验项目");
                return;
            }
            entity.TempItems = JSON.stringify(list);

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxQuality.InspectionTemplateEdit(JSON.stringify(entity));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert('<%=Resources.Messages.SaveInSuccess %>');
            parent.window.UpdateList($("#<%=this.ddlStatus.ClientID %>").val());
            return ajax;
        }--%>

        function selectInspectionTemplateValue() {
            dialog({
                title: "<%=Resources.Common.ChooseWindow %>",
                src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?" +
                    "PageId=58&CallBackFunc=getChooseValueInspectionTemplate&Multiple=true&rnd=" + Math.random(),
                width: 400,
                height: 250
            });
        }

        function GetInspectionTemplateMember() {
            var InspectionTemplateId = $("#<%=this.txtHideInspectionTemplateId.ClientID %>").val();
            if (InspectionTemplateId == "" || parseInt(InspectionTemplateId) == -1) {
                return null;
            }
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipmentInspectionItem.GetInspectionTemplateMemberByTempId(InspectionTemplateId);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return null;
            }
            return ajax.value;
        }

       
    </script>
</asp:Content>
