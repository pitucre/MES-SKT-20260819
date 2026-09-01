<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PCD.ascx.cs" Inherits="SKT.LeanMES.Web.AppCode.Controls.PCD" %>
<script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.PCDjson.js"
    type="text/javascript"></script>
<select id="selProvince" isrequired="1">
    <option value="" >=请选择省份=</option>
</select>
<select id="selCity" isrequired="1">
    <option value="">=请选择城市=</option>
</select>
<select id="selDistrict" isrequired="1">
    <option value="">=请选择区/县=</option>
</select>
<script type="text/javascript" language="javascript">
    $(function () {
        /*绑定省*/
        $.each(PCDjsondata, function (k, p) {
            var option1 = "<option value='" + p.name + "'>" + p.name + "</option>";
            $("#selProvince").append(option1);
        });

        $("#selProvince").change(function () {
            var selValue = $(this).val();
            $("#selCity option:gt(0)").remove();
            $("#selDistrict option:gt(0)").remove();

            $.each(PCDjsondata, function (k, p) {
                if (p.name == selValue) {
                    $.each(p.city, function (k1, p1) {
                        var option = "<option value='" + p1.name + "'>" + p1.name + "</option>";
                        $("#selCity").append(option);
                    })

                }
            });

        });

        $("#selCity").change(function () {
            var selValue = $(this).val();
            var selProValue = $("#selProvince").val();
            $("#selDistrict option:gt(0)").remove();

            $.each(PCDjsondata, function (k, p) {
                if (p.name == selProValue) {
                    $.each(p.city, function (k2, p2) {
                        if (p2.name == selValue) {
                            $.each(p2.area, function (k3, p3) {
                                var option = "<option value='" + p3 + "'>" + p3 + "</option>";
                                $("#selDistrict").append(option);
                            });
                        }
                    });
                    
                }
            });
        });
    });

    function bindCity(prov) {
        var selValue = prov;
        $("#selCity option:gt(0)").remove();
        $("#selDistrict option:gt(0)").remove();

        $.each(PCDjsondata, function (k, p) {
            if (p.name == selValue) {
                $.each(p.city, function (k1, p1) {
                    var option = "<option value='" + p1.name + "'>" + p1.name + "</option>";
                    $("#selCity").append(option);
                })

            }
        });
    }

    function bindDist(city) {
        var selValue = city;
        var selProValue = $("#selProvince").val();
        $("#selDistrict option:gt(0)").remove();

        $.each(PCDjsondata, function (k, p) {
            if (p.name == selProValue) {
                $.each(p.city, function (k2, p2) {
                    if (p2.name == selValue) {
                        $.each(p2.area, function (k3, p3) {
                            var option = "<option value='" + p3 + "'>" + p3 + "</option>";
                            $("#selDistrict").append(option);
                        });
                    }
                });

            }
        });
    }
</script>
