<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SMTAddFeeding.aspx.cs"
    Inherits="SKT.LeanMES.Web.SMT.SMTAddFeeding" MasterPageFile="~/Masters/ViewMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="server">
 <object width="0" height="0" id="Object1" codebase="../Content/Component/Andon/Andon1.0.1.cab" classid="clsid:685F0A47-944D-4145-BF4E-76A02A422B02"></object>

<table width="100%" class="EditeContentTable">
    <tr>
        <td class="Label" colspan="2" align="left"><%=Resources.Messages.WithAsteriskIsRequired %></td>
    </tr>
        <tr>
            <td class="Label1"> 
              <%=Resources.lang.OrderNo%>  <em>*</em>
            </td>
            <td class="Field1">
            <input type="hidden" value="" id="Hidden1" />
             <input type="text" id="selOrder" class="TextBox"  onkeypress="return  Orderfirst(event)"/>
             <input type="button" id="btnOrder" class="ButtonBox" title="" onclick="selectOrder();"  value="..." />
            </td>
        </tr>
        <tr>
            <td class="Label1">
                旧的物料GRN<em>*</em>
            </td>
            <td class="Field1">
                <input id="txtOldGRN" type="text"  style="width: 250px; height: 25px;
                    text-transform: uppercase; font-size: 16px; font-weight: bold;" onkeypress="return  GRNSecond(event)"  />
            </td>
        </tr>
        <tr>
            <td class="Label1">
                新的物料GRN<em>*</em>
            </td>
            <td class="Field1">
                <input id="txtNewGRN" type="text"   style="width: 250px; height: 25px;
                    text-transform: uppercase; font-size: 16px; font-weight: bold;" />
            </td>
        </tr>
    </table>
    <div class="clear5"></div>
    <div style="text-align:center">
    <input id="btnSave" type="button" value="<%=Resources.lang.SMT_AddFeed%>" class="SearchButton" style="font-weight: bolder;
                        font-size: small;" />
    </div>
    <script type="text/javascript">
        function Orderfirst(event) {
            var e = event || window.event
            if (e && e.keyCode == 13) {
                $("#txtOldGRN")[0].focus();
             }
        }
        function GRNSecond(event) {
            var e = event || window.event
            if (e && e.keyCode == 13) {
                $("#txtNewGRN")[0].focus();
            }
        }
        var OrderNo = "";
        //关闭方法
        function Close() {
            HistoryGo();
        }


        var ProdOrderId = 0;

        function selectOrder() 
        {
            var SearchCondition = " ";
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=37&SearchCondition=" + SearchCondition + "&Multiple=false&rnd=" + Math.random(), width: 500, height: 300 });
        }

        function getChooseValue(list) 
        {
            ProdOrderId = list[0][0];
            $("#selOrder").val(list[0][1]);
            $("#txtOldGRN")[0].focus();
        }

        $(document).ready(function () {
            $("#selOrder").focus();
            $("#selOrder").change(function () {
                OrderNo = $("#selOrder").val();
            });

            //触发续料
            $("#txtNewGRN").keydown(function (event) {
                if (event.keyCode == 13) {
                    $("#btnSave").click();
                }
            });
            //续料时间
            $("#btnSave").click(function () {
                //执行之前判断该电脑是否有报警记录，如有不执行后来的数据如
                var status = 0;
                //                 HostName = document.getElementById("AndonActiveX").GetComputerName();
                HostName = document.getElementById("AndonActiveX");
                var ajaxErrorCode = SKT.LeanMES.Web.Controls.PageSQLService.Search("H0dZQmiL7S0XnDjnp1N1rtdGDglXMrsR6aYmv17CUxfZUQr/OT+kig==", "59Re+XIyDOk=",
            "59Re+XIyDOk=",
            "1FzU4DWWuP6PyHLnzbXfVRGijzltjAFa#{'" + HostName + "'}#z/n32SYuIf99rlMoCC9vYJKPkxdSh/jK#{" + status + "}#xgKJsRKfHKc=", "xgKJsRKfHKc=");
                if (ajaxErrorCode.value != "") {
                    alert("该机台正在报警，请解除报警后再进行上料验证！");
                    return false;
                }
                else {
                    var oldGrn = $("#txtOldGRN").val();
                    var newGrn = $("#txtNewGRN").val();
                    OrderNo = $("#selOrder").val();
                    if (OrderNo.length <= 0) {
                        alert("<%=Resources.Messages.OrderEmptyWei %>");
                        $("#selOrder")[0].focus();
                        return false;
                    }
                    if (oldGrn.length <= 0) {
                        alert("<%=Resources.Messages.OldGGRNNotEmpty %>");
                        $("#txtOldGRN")[0].focus();
                        return false;
                    }
                    else if (newGrn.length <= 0) {
                        alert("<%=Resources.Messages.NewGRNNotEmpty %>");
                        $("#txtNewGRN")[0].focus();
                        return false;
                    }

                    var cmd = "mzBT/KlGe4kAViGFkcQGShNp8DoToYaRqxYgmIzAYTg=";  //uspValidateSMTAddFeed
                    var params = [], param = {};
                    param.ParamName = "0iGfAlhgYRf/mTRU4ZRYug==";    //@oldGRN
                    param.ParamType = "FAFm7DhlNgpyDrXGfacQbw==";    //VARCHAR
                    param.ParamValue = oldGrn;
                    param.ParamSize = 50;
                    params.push(param);

                    param = {};
                    param.ParamName = "GUhntlxj9mHbga78diV0lw==";   //@newGRN
                    param.ParamType = "FAFm7DhlNgpyDrXGfacQbw==";   //VARCHAR
                    param.ParamValue = newGrn;
                    param.ParamSize = 50;
                    params.push(param);

                    param = {};
                    param.ParamName = "+QGaipU+VZwpMSvbCMshzA==";  //@OrderNo
                    param.ParamType = "9gCc5xRAjo9NHpCOpaJi5A==";          //NVARCHAR
                    param.ParamValue = OrderNo;
                    param.ParamSize = 100;
                    params.push(param);


                    var ajaxResult = SKT.LeanMES.Web.Controls.PageSQLService.ExecuteNonQuery(cmd, params);

                    if (ajaxResult.error != null) {
                        var ajaxValue = ajaxResult.value;
                        var msg = ajaxResult.error.Message;
                        if (msg != "" && msg != null) {
                            var arr = new Array();
                            arr = msg.split("|");
                            if (arr[2] == '1') {
                                try {
                                    var Computer_Name = document.getElementById("AndonActiveX").GetComputerName();
                                    if (Computer_Name == '') {
                                        alert("没有找到对应的电脑号");
                                        return false;
                                    }
                                    else {

                                        document.getElementById("AndonActiveX").AndonStart(true);
                                        alert("<%=Resources.Messages.StartAlert %>");

                                        var flage = 0;   //0表示报警记录，1表示关闭记录
                                        var Comment = "报警开始";
                                        var Action = 0;
                                        var Errcode = arr[0];
                                        var Status = 0;   //报警记录状态
                                        var ajaxsave = SKT.LeanMES.Web.AjaxServices.AjaxServicesLoadingList.SaveAlertHistory(flage, Computer_Name, Comment, Action, Errcode, Status);
                                        if (ajaxsave.error != null) {
                                            alert(ajaxsave.error.Message);
                                        }
                                    }
                                }
                                catch (e) {
                                    alert("<%=Resources.Messages.InvalidRelieveAlert %>")
                                }
                                alert(arr[1]);
                                return false;
                            }
                            if (arr[2] == '0') {
                                alert(arr[1]);
                                return false;
                            }
                        }
                    }
                    else {
                        alert("<%=Resources.Messages.ContinueFeedSuccess %>");
                        $("#txtOldGRN").val("");
                        $("#txtNewGRN").val("");
                    }
                }
            });
        });
        function Return() {
            HistoryGo();
        }
        function HistoryGo() {
            history.go(-1);
        }
    </script>
</asp:Content>
