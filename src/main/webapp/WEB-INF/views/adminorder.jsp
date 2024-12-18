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

    <title>智能垃圾桶后台管理</title>
    <link rel="stylesheet" href="//unpkg.com/layui@2.6.8/dist/css/layui.css">
    <script src="${pageContext.request.contextPath}/static/js/jquery-3.4.1.js" type="text/javascript" charset="utf-8"></script>

    <style type="text/css">
        html,body{margin:0;padding:0;}
        .iw_poi_title {color:#CC5522;font-size:14px;font-weight:bold;overflow:hidden;padding-right:13px;white-space:nowrap}
        .iw_poi_content {font:12px arial,sans-serif;overflow:visible;padding-top:4px;white-space:-moz-pre-wrap;word-wrap:break-word}
    </style>
    <script src="//api.map.baidu.com/api?type=webgl&v=1.0&ak=WLMuQubvCZbGYVubwtKw5aMhsp4XKmGg"></script>

</head>
<body>
<div class="layui-layout layui-layout-admin">
    <div class="layui-header">
        <div class="layui-logo layui-hide-xs layui-bg-black">智能垃圾桶后台管理</div>
        <!-- 头部区域（可配合layui 已有的水平导航） -->
        <ul class="layui-nav layui-layout-left">
            <!-- 移动端显示 -->
            <li class="layui-nav-item layui-show-xs-inline-block layui-hide-sm" lay-header-event="menuLeft">
                <i class="layui-icon layui-icon-spread-left"></i>
            </li>
            <li class="layui-nav-item layui-hide-xs">垃圾桶信息</li>
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
            <table class="layui-hide" id="test" lay-filter="demo"></table>
            <script type="text/html" id="barDemo">
                <a class="layui-btn layui-btn-xs" lay-event="update">修改</a>
                <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
            </script>

        </div>
    </div>
    <%--弹出表单--%>
    <div id="addOrUpdateNodeDiv" style="display: none; margin: 10px">
        <form id="dataFrm" method="post" class="layui-form  layui-form-pane" lay-filter="dataFrm">
            <!-- 隐藏域，保存当前账单的ID -->
            <input type="hidden" name="id">

            <div class="layui-form-item">
                <label class="layui-form-label">用户ID</label>
                <div class="layui-input-inline">
                    <input type="text" name="userId"   lay-verify="number" placeholder="请输入ID"  lay-reqText="请输入ID"   autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">节点ID</label>
                <div class="layui-input-inline">
                    <input type="text" name="nodeId"   lay-verify="number" placeholder="请输入ID"  lay-reqText="请输入ID"   autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">湿度</label>
                <div class="layui-input-inline">
                    <input type="text" name="humidity"   lay-verify="number" placeholder="请输入湿度"  lay-reqText="请输入湿度"   autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">温度</label>
                <div class="layui-input-inline">
                    <input type="text" name="temperature"   lay-verify="number" placeholder="请输入温度"  lay-reqText="请输入温度"   autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">容积</label>
                <div class="layui-input-inline">
                    <input type="text" name="capacity"   lay-verify="number" placeholder="请输入容积"  lay-reqText="请输入容积"   autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">酒精</label>
                <div class="layui-input-inline">
                    <input type="text" name="alcohol"   lay-verify="string" placeholder="请输入酒精是否超标"  lay-reqText="请输入酒精是否超标"   autocomplete="off" class="layui-input">
                </div>
            </div>

            <div class="layui-form-item" style="text-align: center;">
                <button type="button" class="layui-btn" lay-submit lay-filter="doSubmit">提交</button>
                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
            </div>
        </form>
    </div>

</div>
<script src="//unpkg.com/layui@2.6.8/dist/layui.js"></script>
<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm" lay-event="addNode">新增设备</button>
    </div>
</script>

<script type="text/javascript">
    // alert(name);
    layui.use(['table', 'form', 'jquery', 'layer'], function () {
        var table = layui.table;
        var $ = layui.jquery;
        var layer = layui.layer;
        var form = layui.form;
        var tableIns = table.render({
            elem: '#test'
            , url: '/rubbish/findAll'
            , toolbar: '#toolbarDemo'
            , method: 'POST'
            , cols: [[
                {field: 'rubbishId', width: 120, title: '设备编号', sort: true}
                , {field: 'rubbishUserid', width: 120, title: '用户id', sort: true}
                , {field: 'rubbishNodeid', width: 120, title: '节点编号', sort: true}
                ,{field: 'rubbishCreatetime', width: 200, title: '创建时间'}
                ,{field: 'rubbishUpdatetime', width: 200, title: '更新时间'}
                ,{field: 'rubbishHumidity', width: 80, title: '湿度'}
                ,{field: 'rubbishCapacity', width: 80, title: '容积'}
                ,{field: 'rubbishTemperature', width: 80, title: '温度'}
                ,{field: 'rubbishAlcohol', width: 80, title: '酒精'}
                , {field: 'right', title: '操作', toolbar: "#barDemo"}
            ]]
            , page: false
            , height: 700
            , id: 'testTable'
        });
        // 头部工具栏事件
        table.on('toolbar(demo)', function(obj){
            var id = obj.config.id;
            // var checkStatus = table.checkStatus(id);
            // var othis = lay(this);
            switch(obj.event){
                case 'addNode':
                    //弹出新表单，
                    openAddWindow();
                    break;
            }
        });
        //监听表单提交事件
        form.on("submit(doSubmit)",function (data) {
            $.post(url,data.field,function(result){
                console.log(result);
                if(result.result){
                    layer.alert(result.message,{icon:1});
                    //关闭窗口
                    layer.close(mainIndex);
                    //刷新数据表格
                    tableIns.reload();
                }else{
                    layer.alert(result.message,{icon:2});
                }
            },"json");
            return false;
        });

        var url;
        var mainIndex;
        function openAddWindow() {
            mainIndex = layer.open({
                type: 1,
                title:"新增节点",
                area: ['800px', '600px'],
                content:$("#addOrUpdateNodeDiv"),
                success:function() {
                    //清空表单数据
                    $("#dataFrm")[0].reset();//JavaScript中的方法
                    url = "/rubbish/addRubbish";

                }
            })
        }

    });

    layui.use('table', function () {
        var table = layui.table;
        //监听工具条
        table.on('tool(demo)', function (obj) {
            var data = obj.data;
            if (obj.event === 'update') {
                    layer.prompt({
                        formType: 0,
                        value: '',
                        title: '请输入修改后的节点号',
                        btn: ['确定','取消'], //按钮，
                        btnAlign: 'c'
                    }, function(value,index){
                        //此时获取到的数据为value
                        // layer.close(index);
                        $.ajax({
                            url: "/rubbish/changeNode",
                            type: "POST",
                            data: {"rubbishId": data.rubbishId,"newNode":value},
                            success: function (data) {
                                console.log(data);
                                var json = JSON.parse(data);
                                if (json.result == "1") {
                                    //关闭弹框
                                    layer.close(index);
                                    layer.msg("修改成功", {icon: 6});
                                    setTimeout('location.reload()',1000);//定时刷新
                                } else {
                                    layer.close(index);
                                    layer.msg("修改失败", {icon: 5});
                                }
                            },

                        });
                    });
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
