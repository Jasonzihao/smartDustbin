<%--
  Created by IntelliJ IDEA.
  User: 13545
  Date: 2024/10/21
  Time: 22:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

    <meta name="keywords" content="百度地图,百度地图API，百度地图自定义工具，百度地图所见即所得工具" />
    <meta name="description" content="百度地图API自定义地图，帮助用户在可视化操作下生成百度地图" />

    <title>后台管理</title>
    <link rel="stylesheet" href="//unpkg.com/layui@2.6.8/dist/css/layui.css">
    <script src="${pageContext.request.contextPath}/static/js/jquery-3.4.1.js" type="text/javascript" charset="utf-8"></script>

    <style type="text/css">
        html{height:100%;width:100%;}
        body{height:100%;width:100%;margin:0;padding:0;}
        .iw_poi_title {color:#CC5522;font-size:14px;font-weight:bold;overflow:hidden;padding-right:13px;white-space:nowrap}
        .iw_poi_content {font:12px arial,sans-serif;overflow:visible;padding-top:4px;white-space:-moz-pre-wrap;word-wrap:break-word}
    </style>
    <script src="//api.map.baidu.com/api?type=webgl&v=1.0&ak=nO2qttA7vkIY1ypXEL1IyyfcNmkck6Jo"></script>

</head>
<body>
<div class="layui-layout layui-layout-admin">
    <div class="layui-header">
        <div class="layui-logo layui-hide-xs layui-bg-black">后台管理</div>
        <!-- 头部区域（可配合layui 已有的水平导航） -->
        <ul class="layui-nav layui-layout-left">
            <!-- 移动端显示 -->
            <li class="layui-nav-item layui-show-xs-inline-block layui-hide-sm" lay-header-event="menuLeft">
                <i class="layui-icon layui-icon-spread-left"></i>
            </li>
            <li class="layui-nav-item layui-hide-xs">欢迎使用华中科技大学智能垃圾桶系统</li>
        </ul>

        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item">${admin}</li>
            <li class="layui-nav-item"><a href="/admin/adminLogout">退出登录</a></li>
        </ul>
    </div>

    <div class="layui-side layui-bg-black">
        <div class="layui-side-scroll">
            <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
            <ul class="layui-nav layui-nav-tree layui-bg-black" lay-filter="test">
                <li class="layui-nav-item"><a href="/admin/mainpage">智能垃圾桶管理</a></li>
                <li class="layui-nav-item"><a href="/admin/orderpage">租用管理</a></li>
                <li class="layui-nav-item"><a href="/admin/nodeinfo">节点管理</a></li>
                <li class="layui-nav-item"><a href="/admin/infopage">用户管理</a></li>
            </ul>
        </div>
    </div>

    <div class="layui-body">
        <!-- 内容主体区域 -->
        <div style="padding: 15px;">
            <div style="width:1600px;height:800px;border:#ccc solid 1px;" id="container"></div>
            <table class="layui-hide" id="test" lay-filter="demo"></table>
            <script type="text/html" id="barDemo">
<%--                <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="put">投放</a>--%>
<%--                <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="recycle">查看</a>--%>
            </script>
        </div>
    </div>

</div>
<script src="//unpkg.com/layui@2.6.8/dist/layui.js"></script>
<script>
    //JS
</script>

<script type="text/javascript">

    // window.onload = function(){
    //         alert("开始");
    //         var param1 = 1;
    //         $.ajax({
    //             type:"POST",
    //             url:"/powerbank/showcount",
    //             data:{'param1': param1},
    //             success:function(data){
    //                 alert(data);
    //             }
    //         });
    //     alert("结束");
    //
    // }


    var map = new BMapGL.Map('container');
    map.enableScrollWheelZoom(true);
    // 设置地图初始中心点和缩放级别（可按需调整）
    var name= '<%=request.getSession().getAttribute("username")%>';
    // 使用$.ajax获取后端数据并处理
    $.ajax({
        url: '/node/findAll',
        type: 'POST',
        success: function (data) {
            var responseData = JSON.parse(data);
            // 遍历后端返回的节点数据
            console.log(responseData);
            var nodeList = responseData.data;
            console.log(nodeList);
            nodeList.forEach(function (node) {
                console.log(node)
                var point = new BMapGL.Point(node.jingdu, node.weidu);
                // 创建点标记
                var marker = new BMapGL.Marker(point);
                map.addOverlay(marker);
                // 创建信息窗口配置和内容
                var opts = {
                    width: 150,
                    height: 50,
                    title: node.id
                };
                var html = '欢迎使用' + node.id + '号节点' +'<br><input id="lent" type="button" value="查看"  onclick="return Display_1(' + node.id + ')"/> ';
                var infoWindow = new BMapGL.InfoWindow(html, opts);
                // 为点标记添加点击事件，点击时打开信息窗口
                marker.addEventListener('click', function () {
                    map.openInfoWindow(infoWindow, point);
                });
            });
        },
        error: function (jqXHR, textStatus, errorMessage) {
            console.error('请求后端数据出错：', errorMessage);
        }
    });
    var initialPoint = new BMapGL.Point(114.4271257316, 30.513994357);
    map.centerAndZoom(initialPoint, 15);



    // var point = new BMapGL.Point(114.4271257316,30.513994357);
    // var point2=new BMapGL.Point(114.43420027110278,30.515745159695935);
    // var point3=new BMapGL.Point(113.407495,23.060832);
    // map.centerAndZoom(point, 18);
    // map.centerAndZoom(point2, 18);
    // map.centerAndZoom(point3,18);
    // 创建点标记
    // var marker = new BMapGL.Marker(point);
    // var marker2=new BMapGL.Marker(point2);
    // var marker3=new BMapGL.Marker(point3);
    // map.addOverlay(marker);
    // map.addOverlay(marker2);
    // map.addOverlay(marker3);
    // 创建信息窗口
    // var opts = {
    //     width: 150,
    //     height: 50,
    //     title: '8号垃圾桶'
    // };
    // var opts2 = {
    //     width: 150,
    //     height: 50,
    //     title: '6号垃圾桶'
    // };
    // var opts3 = {
    //     width: 150,
    //     height: 50,
    //     title: '4栋充电宝'
    // };
    // var html_1='欢迎使用3号垃圾桶<br><input id="lent" type="button" value="查看"  onclick="return Display_1()"/> ';
    // var html_2='欢迎使用2号垃圾桶<br><input id="lent" type="button" value="查看"  onclick="return Display_1()"/> ';
    // var html_3='欢迎使用1号柜<br><input id="lent" type="button" value="查看"  onclick="return Display_1()"/> ';
    // var infoWindow = new BMapGL.InfoWindow(html_1, opts);
    // var infoWindow2 = new BMapGL.InfoWindow(html_2, opts2);
    // var infoWindow3 = new BMapGL.InfoWindow(html_3, opts3);
    // 点标记添加点击事件
    // marker.addEventListener('click', function () {
    //     map.openInfoWindow(infoWindow, point); // 开启信息窗口
    // });
    // marker2.addEventListener('click', function () {
    //     map.openInfoWindow(infoWindow2, point2); // 开启信息窗口
    // });
    // marker3.addEventListener('click', function () {
    //     map.openInfoWindow(infoWindow3, point3); // 开启信息窗口
    // });

    function Display_1(rubbishId){
        console.log(rubbishId)
        layui.use('table', function () {
            var table = layui.table;
            table.render({
                elem: '#test'
                , url: '/rubbish/selectByNodeId'
                , method: 'POST'
                , where: {"id": rubbishId}
                , cols: [[
                    {field: 'rubbishId', width: 80, title: '编号', sort: true}
                    , {field: 'rubbishCapacity', width: 120, title: '容积', sort: true}
                    , {field: 'rubbishHumidity', width: 120, title: '可用垃圾桶', sort: true}
                    ,{field: 'rubbishTemperature', width: 120, title: '温度'}
                    // , {field: 'right', title: '操作', toolbar: "#barDemo"}
                ]]
                , page: false
                , height: 298
                , id: 'testTable'
            });
        });

    }
    //
    // $("#logout").click(function () {
    //
    //     $.ajax({
    //         type : "get",// 请求方式
    //         url : "/admin/adminLogout",// 发送请求地址
    //
    //         // 请求成功后的回调函数有两个参数
    //
    //         success : function(data, textStatus) {
    //
    //
    //         }
    //
    //     });
    // })

    layui.use('table', function () {
        var table = layui.table;

        //监听工具条
        table.on('tool(demo)', function (obj) {
            var data = obj.data;
            //投放充电宝
            if (obj.event === 'put') {
                layer.confirm('确定投放', function (index) {
                    $.ajax({
                        url: "/powerbank/putPobk",
                        type: "POST",
                        data: {"cup_id": data.cupboardId},
                        success: function (data) {
                            console.log(data);
                            var json = JSON.parse(data);
                            if (json.result == "1") {
                                //关闭弹框
                                layer.close(index);
                                layer.msg("投放成功", {icon: 6});
                                Display_1();//刷新页面
                            } else {
                                layer.msg("投放失败", {icon: 5});
                            }
                        }
                    });
                    // layer.alert("借用+查看ID : " + data.cupboardId + " 的行");
                });
            }
            //回收充电宝
            else if (obj.event === 'recycle') {
                layer.open({
                    type:2,
                    title:'请选择要回收的垃圾桶',
                    shadeClose:false,           //弹框外的地方是否可以点击
                    offset:'30%',
                    area:['40%','60%'],
                    content:'/powerbank/pobkpage?cup_id='+data.cupboardId,
                    cancel: function() {
                        // 你点击右上角 X 取消后要做什么
                        setTimeout('Display_1()', 1);
                    }
                });

            }
        });
    });
</script>
</body>
</html>
