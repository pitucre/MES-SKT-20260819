<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SelectImg.aspx.cs" Inherits="SKT.LeanMES.Web.Labels.SelectImg" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>选择图片</title>
    <script src="../Content/js/jquery-2.0.0.min.js"></script>
    <script type="text/javascript">
        function uploadFile(filePath) {
            if (filePath.length > 0) {
                $("#btnUpload").click();
            }
        }
        var selectImgName;
        function onSelect(node) {
            selectImgName = $(node).attr("src");
            $(".selectimg").removeClass("selectimg");
            $(node).addClass("selectimg");
        }
        function loaddata() {
            var obj = $("#imgs").empty();
            $.ajax({
                type: "POST",
                cache: false,
                data: { action: "getdata" },
                url: "SelectImg.aspx?id=<%=LabledId%>",
                success: function (data) {
                    data = JSON.parse(data);
                    for (var i = 0; i < data.length; i++) {
                        var html = "<div>";
                        html += "<img onclick=\"onSelect(this)\" src='<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/UploadFiles/PdfImg/<%=LabledId%>/" + data[i] + "'>";
                        html += "<input type=\"button\"  onclick=\"deleteImg('" + data[i] +"')\"  value=\"删除\"/>";
                        html += "</div>";
                        obj.append(html);
                    }
                }
            });
        }
        $(function () {
            loaddata();
        });

        function deleteImg(fileName) {
            $.ajax({
                type: "POST",
                cache: false,
                data: { action: "deleteImg", fileName: fileName },
                url: "SelectImg.aspx?id=<%=LabledId%>",
                success: function (data) {
                    loaddata();
                }
            });
        }
    </script>
    <style type="text/css">
        #imgs img {
            height: 130px;
            width: 130px;
            margin: 5px;
            border: 1px solid #ccc;
            margin-left:auto;
            margin-right:auto;
            display:block;
        }

            #imgs img:hover {
                border: 1px solid red;
            }

        .selectimg {
            border: 1px solid red !important;
        }

        #imgs div {
            display:inline-block;
            height: 180px;
            width: 150px;
        }

        #imgs input {
            margin-left:auto;
            margin-right:auto;
            display:block;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:FileUpload ID="fileBomUrl" ClientIDMode="Static" runat="server" onchange="uploadFile(this.value)" />
            <asp:Button ID="btnUpload" runat="server" OnClick="Upload_Click" ClientIDMode="Static" Style="display: none;" />
        </div>
        <div id="imgs">
            
        </div>
    </form>
</body>
</html>
