<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="ItemBomStrut.aspx.cs" Inherits="SKT.LeanMES.Web.Product.ItemBomStrut" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <link href="../Content/plugin/ligerTree/skins/Aqua/css/ligerui-tree.css" rel="stylesheet" type="text/css" />
    <script src="../Content/plugin/ligerTree/js/core/base.js"" type="text/javascript"></script>  
    <script src="../Content/plugin/ligerTree/js/plugins/ligerTree.js"" type="text/javascript"></script> 
    <style type="text/css">
        #layermsg {
            position: absolute;
            left: 50%;
            top: 50%;
            width:200px;
            height:100px;
            margin-left:-100px;
            margin-top:-50px; 
            display:none;
            z-index:999;
        }
      
        #layer { 
            background-color:#F1F3F8; 
            left:0; width: 216px;
            opacity:0.8; 
            position:absolute; 
            top:0; 
            z-index:3; 
            filter:alpha(opacity=80); 
            -moz-opacity:0.8; 
            -khtml-opacity:0.8; 
            display:none;
        } 
    </style> 
    <div class="infoTips">
         如需同步BOM数据到MES中间表，请选择产品后点击同步。</div>
        
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">
                <%= Resources.lang.ItemCode %><em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtItemCode" runat="server" CssClass="TextBox" IsRequired='1' ReadOnly="true"
                    ClientIDMode="Static"></asp:TextBox><input type="button" id="btnSelectItem" class="ButtonBox" value="..." title="Select"
                    onclick="openChoosePage(1);" />
                <asp:HiddenField ID="hdnItemId" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
            <td class="Label2">
                <%=Resources.lang.ItemsName %>
            </td>
            <td class="Field2">
                <asp:Label ID="lblItemName" runat="server" Text="" ClientIDMode="Static"></asp:Label>
            </td>
        </tr>
    </table> 
    <div id="layer"></div>
     <div id="layermsg" >
      <span style="  color: #21adf7; width:100%;  margin-left: auto; margin-right: auto;  line-height: 25px;">正在同步数据...<br />
      <img src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/dialog/skin/default/images/loadinga.gif" /></span>
      </div> 
        
        <div style="width:98%;  margin-top:10px; padding:10px;  border:1px solid #ccc; overflow:auto;  ">
        <ul id="productStruct">
     
        </ul>
    </div>   
 
      
 
    <script type="text/javascript">
        var itembomid = <%= Request.QueryString["ID"] %>;  
        var syncItemCode="" ;     
        var manage = null;

        $(function () {
         
            if(itembomid>0){                
                setItemInfo();
                loadStruct();
            } 
        });

        /**
        *获取物料结构信息
        **/
        function loadStruct(){
             $("#productStruct").ligerTree({
                nodeDraggable: true,
                nodeWidth: 'auto',
                isExpand: 2,
                checkbox: false,
                data: loadStructNode(),
                onExpand: function (node) {
                    if (node.data.bomid > 0) {
                        loadNextStructNode(node);
                    }
                },
                onCheck:function(node){
                    syncItemCode = node.data.text;
                },
                onSelect:function(node){
                    syncItemCode = node.data.text;
                }               
            });
            manager = $("#productStruct").ligerGetTreeManager();
        }

         /**
        *获取物料结构信息
        **/
        function loadStructNode() {                   
            var data = [];
            var child = [];
            var empty = [];
            var itemcode = $("#txtItemCode").val();
            
            var list = getStructInfo(itemcode, "", itembomid);

            for (var i = 0; i < list.length; i++) {
                var entity = list[i];
                 
                if (parseInt(entity.ItemBomId) < 0) {
                    child.push({ "text": entity.ItemCode, "bomid": entity.ItemBomId });
                }
                else {                    
                    child.push({ "text": entity.ItemCode, "bomid": entity.ItemBomId,"children":empty});
                }
            }
            
            data.push({ "text": itemcode,"bomid":-1, "children": child });
            return data;
        }

         /**
        *获取物料结构信息
        **/
        function getStructInfo(code, version, bomid) {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxProduct.GetBomStructInfo(code, version, bomid);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            return ajax.value;
        }

         /**
        *加载下级物料信息
        **/
        function loadNextStructNode(node) {  
            var list = getStructInfo(node.data.text, "", node.data.bomid);
            var child = [];
            var empty = [];

            for (var i = 0; i < list.length; i++) {
                var entity = list[i];

                if (parseInt(entity.ItemBomId) < 0) {
                    child.push({ "text": entity.ItemCode, "bomid": entity.ItemBomId });
                }
                else {                   
                    child.push({ "text": entity.ItemCode, "bomid": entity.ItemBomId, "children": empty });
                }
            }

            if (node) {               
                manager.reloadNode(node, child);
            }
            else {
                manager.reloadNode(null, child);
            }  
                    
        }   
        
         /**
        *设置页面产品信息 针对从BOM列表选择过来的
        **/
        function setItemInfo(){
             var ajax = SKT.LeanMES.Web.AjaxServices.AjaxProduct.GetItemByBomID(itembomid);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var entity = ajax.value;            
             $("#txtItemCode").val(entity.ItemCode);
             $("#lblItemName").html(entity.ItemName);  
        }

         /**
        *选择窗口操作
        **/
        function openChoosePage(flags) {
            var condition = "";
            flag = flags;
            dialog({
                title: "<%= Resources.Common.ChooseWindow %>",
                src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=" +
                flags +
                "&Multiple=false&SearchCondition=" +
                condition +
                "&rnd=" +
                Math.random(),
                width: 600,
                height: 300
            });
        } 

         /**
        *获取选择窗口返回值
        **/
        function getChooseValue(list) {
            if (flag == 1) {
                $("#txtItemCode").val(list[0][2]);
                $("#lblItemName").html(list[0][1]);
                itembomid = -1;                
                loadStruct();
            }
        } 

        /**
        *同步单个产品BOM到MES系统
        **/
        function Synchro() {
            var syncItemCode = $("#txtItemCode").val();
            if(syncItemCode==""){
                alert("请选择产品编码！");
                return false;
            }
           
           showlayer();
            setTimeout(function(){
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxProduct.SynchroItemBom(syncItemCode);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    $(".load").hide();
                    return false;
                }            
                alert("产品BOM数据同步成功！");
                loadStruct();
                syncItemCode="";
                $("#layer,#layermsg").hide();
            },100);           
        }

        function showlayer(){                
                var bh = $("body").height(); 
                var bw = $("body").width();
                $("#layermsg").show();
                $("#layer").css({ 
                    height:bh, 
                    width:bw, 
                    display:"block" 
                });     
        }
        
    </script>
</asp:Content>
