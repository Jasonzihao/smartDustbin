<%--
  Created by IntelliJ IDEA.
  User: lin
  Date: 2024/10/23
  Time: 15:14
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">


    <title>节点管理</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/layui/css/layui.css">
    <script src="${pageContext.request.contextPath}/static/js/jquery-3.4.1.js" type="text/javascript" charset="utf-8"></script>

    <style type="text/css">
        html,body{margin:0;padding:0;}
        .iw_poi_title {color:#CC5522;font-size:14px;font-weight:bold;overflow:hidden;padding-right:13px;white-space:nowrap}
        .iw_poi_content {font:12px arial,sans-serif;overflow:visible;padding-top:4px;white-space:-moz-pre-wrap;word-wrap:break-word}
    </style>

</head>
<body>

<div class="layui-layout layui-layout-admin">
    <div class="layui-header">
        <div class="layui-logo layui-hide-xs layui-bg-black">节点管理</div>
        <!-- 头部区域（可配合layui 已有的水平导航） -->
        <ul class="layui-nav layui-layout-left">
            <!-- 移动端显示 -->
            <li class="layui-nav-item layui-show-xs-inline-block layui-hide-sm" lay-header-event="menuLeft">
                <i class="layui-icon layui-icon-spread-left"></i>
            </li>
            <li class="layui-nav-item layui-hide-xs">查看节点</li>
        </ul>

        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item">${admin}</li>
            <li class="layui-nav-item"><a href="${pageContext.request.contextPath}/admin/adminLogout">退出登录</a></li>
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
    <script type="text/html" id="toolbarDemo">
        <div class="layui-btn-container">
            <button class="layui-btn layui-btn-sm" lay-event="addNode">新增节点</button>
        </div>
    </script>
    <div class="layui-body">
        <!-- 内容主体区域 -->
        <div style="padding: 15px;">
            <table class="layui-hide" id="test" lay-filter="demo"></table>
            <script type="text/html" id="barDemo">
                <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
                <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
            </script>

        </div>
    </div>

</div>
<%--弹出表单--%>
<div id="addOrUpdateNodeDiv" style="display: none; margin: 10px">
    <form id="dataFrm" method="post" class="layui-form  layui-form-pane" lay-filter="dataFrm">
        <!-- 隐藏域，保存当前账单的ID -->
        <input type="hidden" name="id">

        <div class="layui-form-item">
            <label class="layui-form-label">经度</label>
            <div class="layui-input-inline">
                <input type="text" name="jingdu"   lay-verify="number" placeholder="请输入经度"  lay-reqText="请输入经度"   autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">纬度</label>
            <div class="layui-input-inline">
                <input type="text" name="weidu"   lay-verify="number" placeholder="请输入纬度"  lay-reqText="请输入纬度"   autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">节点状态</label>
            <div class="layui-input-block">
                <input type="radio" name="status" value="1" title="正常" checked="">
                <input type="radio" name="status" value="0" title="异常">
            </div>
        </div>

        <div class="layui-form-item" style="text-align: center;">
            <button type="button" class="layui-btn" lay-submit lay-filter="doSubmit">提交</button>
            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
        </div>
    </form>
</div>

<script src="//unpkg.com/layui@2.6.8/dist/layui.js"></script>
<%--<script src="${pageContext.request.contextPath}/static/layui/layui.js"></script>--%>
<script type="text/javascript">

    layui.use(['table', 'layer', "jquery", "form"], function () {
        var table = layui.table;
        var layer = layui.layer;
        var $ = layui.jquery;
        var form = layui.form;
        var tableIns = table.render({
            elem: '#test'
            , url: '/node/findAll'
            , toolbar: '#toolbarDemo'
            , method: 'POST'
            , cols: [[
                {field: 'id', width: 120, title: '节点编号', sort: true}
                ,{field: 'jingdu', width: 120, title: '经度'}
                ,{field: 'weidu', width: 120, title: '纬度'}
                ,{field: 'status', width: 120, title: '状态'}
                ,{field: 'createtime', width: 200, title: '创建时间'}
                ,{field: 'updatetime', width: 200, title: '修改时间'}
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
        //监听表格行工具栏事件
        table.on("tool(demo)",function (obj) {
            switch (obj.event) {
                //编辑
                case 'edit':
                    openUpdateWindow(obj.data);
                    break;
                //删除
                case 'del':
                    deleteById(obj.data);
                    break;
            }
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
                    url = "/node/addNode";

                }
            })
        }
        function openUpdateWindow(data) {
            console.log(data);
            mainIndex = layer.open({
                type: 1,
                title:"更新节点",
                area: ['800px', '600px'],
                content:$("#addOrUpdateNodeDiv"),
                success:function() {
                    //表单数据回显
                    form.val("dataFrm",data);
                    url = "/node/updateNode";

                }
            })
        }
        function deleteById(data) {
            //提示用户确认是否删除
            layer.confirm("确定要删除该节点吗？",{icon:3,title:"提示"},function (index) {
                //发送ajax请求
                $.post("/node/delNode",{"id":data.id},function(result){
                    if(result.result){
                        layer.alert(result.message,{icon:1});
                        //刷新数据表格
                        tableIns.reload();
                    }else{
                        layer.alert(result.message,{icon:2});
                    }
                },"json");

                //关闭提示框
                layer.close(index);
            });
        }


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




    });

</script>
</body>
</html>

