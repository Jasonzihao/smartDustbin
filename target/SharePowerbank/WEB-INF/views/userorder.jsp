<%--
  Created by IntelliJ IDEA.
  User: 13545
  Date: 2021/6/22
  Time: 23:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

    <meta name="keywords" content="百度地图,百度地图API，百度地图自定义工具，百度地图所见即所得工具" />
    <meta name="description" content="百度地图API自定义地图，帮助用户在可视化操作下生成百度地图" />

    <title>用户中心</title>
    <link rel="stylesheet" href="//unpkg.com/layui@2.6.8/dist/css/layui.css">
    <script src="${pageContext.request.contextPath}/static/js/jquery-3.4.1.js" type="text/javascript" charset="utf-8"></script>

    <style type="text/css">
        html,body{margin:0;padding:0;}
        .iw_poi_title {color:#CC5522;font-size:14px;font-weight:bold;overflow:hidden;padding-right:13px;white-space:nowrap}
        .iw_poi_content {font:12px arial,sans-serif;overflow:visible;padding-top:4px;white-space:-moz-pre-wrap;word-wrap:break-word}
    </style>
    <script src="//api.map.baidu.com/api?type=webgl&v=1.0&ak=vNFOMHB02Ey6oGS0nQH6Hg4ju9u5T7jS"></script>

</head>
<body>
<div class="layui-layout layui-layout-admin">
    <div class="layui-header">
        <div class="layui-logo layui-hide-xs layui-bg-black">用户中心</div>
        <!-- 头部区域（可配合layui 已有的水平导航） -->
        <ul class="layui-nav layui-layout-left">
            <!-- 移动端显示 -->
            <li class="layui-nav-item layui-show-xs-inline-block layui-hide-sm" lay-header-event="menuLeft">
                <i class="layui-icon layui-icon-spread-left"></i>
            </li>
            <li class="layui-nav-item layui-hide-xs">查看垃圾桶</li>
        </ul>

        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item">${username}</li>
            <li class="layui-nav-item"><a href="/user/userLogout">退出登录</a></li>
        </ul>
    </div>

    <div class="layui-side layui-bg-black">
        <div class="layui-side-scroll">
            <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
            <ul class="layui-nav layui-nav-tree layui-bg-black" lay-filter="test">
                <li class="layui-nav-item"><a href="/user/mainpage">总览</a></li>
                <li class="layui-nav-item"><a href="/user/orderpage">我的垃圾桶</a></li>
                <li class="layui-nav-item"><a href="/user/infopage">个人信息</a></li>
            </ul>
        </div>
    </div>

    <div class="layui-body">
        <!-- 内容主体区域 -->
        <div style="padding: 15px;">
                <table class="layui-hide" id="test" lay-filter="demo"></table>
                <script type="text/html" id="barDemo">
<%--                    <a class="layui-btn  layui-btn-xs" lay-event="pay">支付</a>--%>
                    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
                </script>

        </div>
    </div>

</div>
<script src="//unpkg.com/layui@2.6.8/dist/layui.js"></script>
<script>
    //JS
</script>

<script type="text/javascript">
    var name= '<%=request.getSession().getAttribute("username")%>';
    // alert(name);
    layui.use('table', function () {
        var table = layui.table;
        table.render({
            elem: '#test'
            , url: '/rubbish/findRubbishByName'
            ,method:'post'
            ,where:{"username":name}
            , cols: [[
                {field: 'rubbishId', width: 120, title: '垃圾桶编号', sort: true}
                // , {field: 'rubbishUserid', width: 120, title: '用户id', sort: true}
                ,{field: 'rubbishCreatetime', width: 200, title: '创建时间'}
                ,{field: 'rubbishUpdatetime', width: 200, title: '更新时间'}
                ,{field: 'rubbishHumidity', width: 120, title: '湿度'}
                ,{field: 'rubbishTemperature', width: 120, title: '温度'}
                ,{field: 'rubbishCapacity', width: 120, title: '容量'}
                ,{field: 'rubbishAlcohol', width: 120, title: '酒精'}
                , {field: 'right', title: '操作', toolbar: "#barDemo"}
            ]]
            , page: false
            , height: 700
            , id: 'testTable'
        });
    });

    layui.use('table', function () {
        var table = layui.table;
        //监听工具条
        table.on('tool(demo)', function (obj) {
            var data = obj.data;
            if (obj.event === 'pay') {
                if(data.orderStatus!="未支付"){
                    // layer.close(index);
                    layer.msg("不在可支付状态", {icon: 5});
                }else{
                    layer.confirm('确定支付', function (index) {

                        $.ajax({
                            url: "/orders/payorder",
                            type: "POST",
                            data: {"order_id": data.orderId,"username":name},
                            success: function (data) {
                                var json = JSON.parse(data);
                                if (json.result == "1") {
                                    //关闭弹框
                                    layer.close(index);
                                    layer.msg("支付成功", {icon: 6});
                                    setTimeout('location.reload()',1000);//定时刷新
                                } else {
                                    layer.msg("支付失败", {icon: 5});
                                }
                            }
                        });
                        // layer.alert("支付+查看ID : " + data.orderId + " 的行"+name);
                    });
                }

            }
            if (obj.event === 'del') {
                layer.confirm('确定删除', function (index) {
                    $.ajax({
                        url: "/rubbish/delRubbish",
                        type: "POST",
                        data: {"rubbishId": data.rubbishId},
                        success: function (data) {
                            var json = JSON.parse(data);
                            if (json.result == "1") {
                                //关闭弹框
                                layer.close(index);
                                layer.msg("删除成功", {icon: 6});
                                setTimeout('location.reload()',1000);//定时刷新
                            } else {
                                layer.msg("删除失败", {icon: 5});
                            }
                        }
                    });

                });
            }
        });
    });
</script>
</body>
</html>
