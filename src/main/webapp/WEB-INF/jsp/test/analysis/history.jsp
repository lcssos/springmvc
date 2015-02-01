<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML>
<html>
<head>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8">
    <link rel="stylesheet" type="text/css"
          href="<c:url value="/ext-5.1.0/packages/ext-theme-crisp/build/resources/ext-theme-crisp-all-debug.css"/>"/>
    <link rel="stylesheet" type="text/css"
          href="<c:url value="/ext-5.1.0/packages/ext-theme-crisp/build/resources/bootstrap.css"/>"/>
    <script type="text/javascript" src="<c:url value="/ext-5.1.0/build/bootstrap.js"/>"></script>
    <script type="text/javascript"
            src="<c:url value="/ext-5.1.0/build/packages/ext-locale/build/ext-locale-zh_CN.js"/>"></script>
    <script type="text/javascript"
            src="<c:url value="/js/common.js"/>"></script>


    <script type="text/javascript" draggable="O">
        Ext.onReady(function(){
            window.onunload = function(){
               // window.parent.Ext.getBody().mask('正在跳转...');
            }

            var animationCloseFlag = window.location.search === '?animation=no';



            Ext.create('Ext.container.Viewport', {
                layout: 'fit'
                ,items: {
                    tbar: {
                        xtype: 'customToolbar'
                        ,items: [{
                            xtype: 'npacsbutton'
                            ,text: '刷新'
                            ,handler: function(){
                                //window.history.go(0);
                                //return;
                                getDayData();
                            }
                        }]
                    }
                    ,html: '<div class="' + 'dayStat' + (animationCloseFlag ? 'NoAnimation' : '') + '"><h1 id="statTimeInfo">统计截止时间：---</h1>'
                    + '<div class="stat1"><span>已完成咨询单数量</span><p id="statValue">---</p></div>'

                    + '<div class="stat2"><span>注册医生数量</span><p id="statValue1">---</p></div>'

                    + '<div class="stat4">专家数量<p id="statValue3">---</p></div>'
                    + '<div class="stat3">医生佣金返还金额<p id="statValue2">---</p></div>'
                    + '<div class="stat5">专家佣金返还金额<p id="statValue4">---</p></div>'
                    + '</div>'
                    ,listeners: {
                        render: function(){
                            getDayData();
                        }
                    }
                }
            })

        });

        function getDayData(){
            Ext.fly('statValue4').setHtml('333元');
        }

    </script>




    <style>
        body {
            width: 100%;
            height: 100%;
            margin: 0;
            padding: 0;
        }
        .dayStatNoAnimation h1 {
            height: 40px;
            background: #333;
            color: white;
            font-size: 14px;
            line-height: 30px;
            margin: 10px 10px 0 10px;
            padding:  5px 10px;
        }
        .dayStatNoAnimation div {
            float: left;
            height: 140px;
            width: 140px;
            color: white;
            font-weight: bold;
            font-size: 12px;
            line-height: 30px;
            text-align: center;
            margin: 10px 0 0 10px;
            padding: 0px;

            transition: zoom 0.2s;
            transition-timing-function: ease-in-out;
        }
        .dayStat h1 {
            height: 40px;
            background: #333;
            color: white;
            font-size: 14px;
            line-height: 30px;
            margin: 10px 10px 0 10px;
            padding:  5px 10px;
            animation: initAnimationH 1s 1;
            -moz-animation: initAnimationH 1s 1;
        }
        .dayStat div {
            float: left;
            height: 140px;
            width: 140px;
            color: white;
            font-weight: bold;
            font-size: 12px;
            line-height: 30px;
            text-align: center;
            margin: 10px 0 0 10px;
            padding: 0px;

            transition: zoom 0.2s;
            transition-timing-function: ease-in-out;

            animation-name: initAnimation;
            animation-duration: 1.5s;
            -moz-animation-name: initAnimation;
            -moz-animation-duration: 1.5s;
        }

        .stat1 {
            background: brown;
            border: 1px solid brown;
        }

        .stat1 p {
            color: brown;
        }

        .stat2 {
            background: darkolivegreen;
            border: 1px solid darkolivegreen;
            color: darkolivegreen;
        }
        .stat2 p {
            color: darkolivegreen;
        }


        .stat3 {
            background: chocolate;
            border: 1px solid chocolate;
            color: chocolate;
        }
        .stat3 p {
            color: chocolate;
        }


        .stat4 {
            background: #428bca;
            border: 1px solid #428bca;
            color: #428bca;
        }
        .stat4 p {
            color: #428bca;
        }


        .stat5 {
            background: darkslateblue;
            border: 1px solid darkslateblue;
            color: darkslateblue;
        }
        .stat5 p {
            color: darkslateblue;
        }


        .dayStat div span,.dayStatNoAnimation div span{
            display: block
        height: 40px;
            width: 100%;
            font-weight: bold;
            font-size: 12px;
            line-height: 30px;
            text-align: center;
        }

        .dayStat div:hover,.dayStatNoAnimation div:hover {
            zoom: 1.2;
        }

        .dayStat div p,.dayStatNoAnimation div p{
            height: 108px;
            font-weight: bold;
            font-size: 20px;
            line-height: 108px;
            text-align: center;
            margin: 0;
            padding: 0;
            background: white;
        }

        @keyframes initAnimation {
            0% {
                transform: rotate(0deg) scale(0);
                opacity: 0;
            }
            100% {
                transform: rotate(360deg) scale(1);
                opacity: 1;
            }
        }
        @-moz-keyframes initAnimation {
            0% {
                transform: rotate(0deg) scale(0);
                opacity: 0;
            }
            100% {
                transform: rotate(360deg) scale(1);
                opacity: 1;
            }
        }
        @keyframes initAnimationH {
            0% {
                margin-left: 1000px;
                opacity: 0;
            }
            100% {
                margin-left: 20px;
                opacity: 1;
            }
        }
        @-moz-keyframes initAnimationH {
            0% {
                margin-left: 1000px;
                opacity: 0;
            }
            100% {
                margin-left: 20px;
                opacity: 1;
            }
        }

        .dayStatSSS div:before {
            content: '';
            display: block;
            width: 0px;
            height: 0px;
            border-width: 10px;
            border-color: white white #23a786 #23a786;
            border-style: solid;
            background: white;
            position: relative;
            top: -10px;
            right: -110px;
        }

    </style>
</head>
<body>
123
</body>
</html>
