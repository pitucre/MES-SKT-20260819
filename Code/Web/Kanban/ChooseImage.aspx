<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ChooseImage.aspx.cs" Inherits="SKT.LeanMES.Web.Kanban.ChooseImage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=8" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/jquery.min.js" type="text/javascript"></script>
    <link href="../Content/Main.css" rel="stylesheet" type="text/css" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.tablelist.js?v=20211209"
        type="text/javascript"></script>
    <title></title>
    <style type="text/css">
        img {
            max-width: 200px;
            max-height: 200px;
            
        }
        li {
            display:inline;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <div id="divSelected" style=" border: 1px solid #d3d3d3; background: #eceff1;
                                          height: 30px;">
        <div style="display: inline-block;">
            <input type="text" id="imgPicker" style="display: none"  />
            选择图片：
            <input type="text" id="imgName" width="100px" runat="server"/>
            <input type="button" id="btnOK" value="确定" />
            <input type="button" id="btnDelete" value="删除此图片" />
        </div>
        <div style="display: inline-block; float:right" >
            <asp:FileUpload ID="impUpload" runat="server" ClientIDMode="Static"/>
            <input type="button" id="btnUpload"  value="上传新图片"/>
        </div>
        <div style="display: inline-block">

        </div>
    </div>
    <div id="divShow">
        
    </div>
    </div>
    
    <asp:HiddenField runat="server" id="hfImgList" ClientIDMode="Static"/>
    <asp:HiddenField runat="server" ID="hfOperate" Value="-1" ClientIDMode="Static" />
    </form>
</body>
</html>
<script type="text/javascript">
    var folder = '<%=Request.QueryString["Folder"]%>';
    var picRootPath = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/OnlineService/KanbanImage/";

    $(document)
        .ready(function() {

            showPicList();

            $(".picInList")
                .live("click",
                    function() {
                        $("#imgPicker").val($(this).attr("src"));
                        $("#imgName").val($(this).attr("id"));
                        $(".picInList").css("border", "");
                        $(this).css("border", "3px solid #E62448");
                    });
        });

    $("#btnUpload")
        .click(function () {
            document.forms[0].submit();
        });

    $("#btnDelete")
        .click(function () {
            $("#hfOperate").val('delete');
            document.forms[0].submit();
        });

        //使用getImage
    $("#btnOK")
        .click(function() {
            window.parent.getImage($("#imgPicker").val());
            try {
                window.parent.closeDialog();
                window.parent.document.focus();
            } catch (ex) {}
        }); 

    function showPicList() {
        var strList = $("#hfImgList").val();
        //alert(strList);
        var objList = JSON.parse(strList);
        var strHtml = "<ul>";
        for (var i = 0; i < objList.length; i++) {
            strHtml += "<li class='picList'><div style='display: inline-block;'>" +
                "<a href='#'><img class='picInList' id='" + objList[i] + "' src='" + picRootPath + objList[i] + "'></a>" +
                "</div></li>";            
        }

        strHtml += "</ul>";
        $("#divShow").html(strHtml);
    }
</script>
