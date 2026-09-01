<%@ Page Title="" Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/EditMaster.master" 
    CodeBehind="Navigation.aspx.cs" Inherits="SKT.LeanMES.Web.Navigation.Navigation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <style type="text/css">
        li{list-style: none;
        }
        div, ul, li span {
            margin: 0;
        }
        .ll{width:80px; height:80px;text-align:center;padding-top:15px;}
        .ll img{padding-bottom:10px; }
        #df{float:left; width:80px;}
        #cf{float:left; width:80px; }
        #jh{margin-bottom:100px; width:90%;}
        .sp{float:left;padding-top:20px;margin-left:10px;margin-right:10px;text-align:center;}
        #ds{width:90%;}                  
    </style>
    <div style="width:100%;">
        <div id="jh">
            <div id="df">
                <div class="ll">
                    <img src="../Content/theme/Metro/images/icon/用户管理.png" />
                    <p>用户以及权限管理</p>
                </div>
                <ul></ul>
            </div>
            <div class="sp"><img /></div>
            <div id="df">
                <div class="ll">
                    <img src="../Content/theme/Metro/images/icon/工厂建模.png"/>
                    <p>工厂建模</p>
                </div>
                <ul></ul>
            </div>
            <div class="sp"><img /></div>
            <div id="df">
                <div class="ll">
                    <img src="../Content/theme/Metro/images/icon/基本资料1.png" />
                    <p>基本资料建立</p>
                </div> 
                <ul></ul>
            </div>
            <div class="sp"><img /></div>
            <div id="df">
                <div class="ll">
                    <img src="../Content/theme/Metro/images/icon/条码规则.png"/>
                    <p>条码规则建立</p>
                </div>
                <ul></ul>
            </div>       
        </div>
        <div style="width:10%;float:right;"></div>
        <div id="ds" >
            <div id="cf">
                <div class="ll">
                    <img src="../Content/theme/Metro/images/icon/标签规则.png" />
                    <p>标签规则建立</p>
                </div>
                <ul></ul>
            </div>
            <div class="sp"><img /></div>
            <div id="cf">
                <div class="ll">
                    <img src="../Content/theme/Metro/images/icon/SMT防上错料.png" />
                    <p>SMT防上错料</p>
                </div>
                <ul></ul>
            </div>
            <div class="sp"><img /></div>
             <div id="cf">
                <div class="ll">
                    <img src="../Content/theme/Metro/images/icon/SMT其他管理.png" />
                    <p>SMT其他管理</p>
                </div>
                <ul></ul>
            </div>
            <div class="sp"><img /></div>
             <div id="cf">
                <div class="ll">
                    <img src="../Content/theme/Metro/images/icon/生产过站.png" />
                    <p>生产过站</p>
                </div>
                <ul></ul>
            </div>
            <div class="sp"><img /></div>
        </div>
    </div>
    <script type="text/javascript">

    </script>

</asp:Content>



    

