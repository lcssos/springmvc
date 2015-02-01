<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Insert title here</title>
    <link rel="stylesheet" type="text/css" href="<c:url value="/ext-5.1.0.zip/packages/ext-theme-crisp/build/resources/ext-theme-crisp-all-debug.css"/>" />
    <link rel="stylesheet" type="text/css" href="<c:url value="/ext-5.1.0.zip/packages/ext-theme-crisp/build/resources/bootstrap.css"/>" />
    <script type="text/javascript" src="<c:url value="/ext-5.1.0.zip/build/bootstrap.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/ext-5.1.0.zip/build/packages/ext-locale/build/ext-locale-zh_CN.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/js/common.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/js/jquery.min.js"/>"></script>

    <script type="text/javascript" draggable="O">
        Ext.onReady(function(){
            Ext.require([
                'Ext.panel.Panel'
                ,'Ext.container.Viewport'
                ,'Ext.form'
            ]);

            Ext.define('WK.Person',{
                age: 0
                ,name: ''
                ,showInfo: function(){
                    Ext.Msg.alert('HELLO','I am ' + this.name + ',and I am ' + this.age);
                }
                ,constructor: function(name,age){
                    this.name = name;
                    this.age = age;
                }
            });

            //var developer = new WK.Person('wukong',20);

            var panelTop = Ext.create('Ext.panel.Panel',{
                region: 'north'
                ,height: 60
                //,style: 'border-top: 2px solid #23a786;'
                ,border: false
                ,bodyStyle: 'line-height: 60px;color: white;font-size: 14px;font-weight: bold;background: url("<c:url value="/icons/bell.png"/>") no-repeat left center #47484a;'
                ,html: '<div class="statusLabel">......</div><div class="btn btn-xs pull-right btn_no_bg" style="margin: 20px 5px;text-decoration: underline;" onclick="sysExit()">退出</div>'
                + '<div class="btn btn-xs pull-right btn_no_bg" style="margin: 20px 5px;text-decoration: underline;" onclick="changePwd()">修改密码</div>'
                + '<div class="pull-right" style="margin: 0 5px;">张三</div>'
            });


            var navStore = Ext.create('Ext.data.TreeStore',{
                root: {
                    expanded: false
                    ,children: [{
                        text: "医生管理"
                        ,expanded: false
                        ,children: [{
                            text: "医院", leaf: true
                        },{
                            text: "专家", leaf: true
                        },{
                            text: "医生", leaf: true
                        }]
                    },{
                        text: "账单管理"
                        ,expanded: false
                        ,children: [{
                            text: "医生结算", leaf: true
                        },{
                            text: "专家结算", leaf: true
                        },{
                            text: "平台结算", leaf: true
                        },{
                            text: "咨询单", leaf: true
                        },{
                            text: "咨询单交易流水", leaf: true
                        },{
                            text: "交易流水明细", leaf: true
                        },{
                            text: "医生账户余额", leaf: true
                        }]
                    },{
                        text: "运营分析"
                        ,expanded: true
                        ,children: [{
                            text: "平台历史统计数据", leaf: true
                            ,id: 'initSelectedNode'
                        },{
                            text: "本日活跃度", leaf: true
                        },{
                            text: "近期异常情况", leaf: true
                        },{
                            text: "反馈列表", leaf: true
                        }]
                    },{
                        text: "系统配置"
                        ,expanded: false
                        ,children: [{
                            text: "患者同意函", leaf: true
                        },{
                            text: "许可协议", leaf: true
                        },{
                            text: "推送消息", leaf: true
                        },{
                            text: "what's new", leaf: true
                        }]
                    },{
                        text: "运营开关"
                        ,leaf: true
                    }]
                }
            });


            var navTree =Ext.create('Ext.tree.Panel', {
                width: 240
                ,id: 'navTree'
                ,store: navStore
                ,rootVisible: false
                ,region: 'west'
                ,scroll: false
                ,hideHeaders: true

                ,bodyPadding: '10px 10px 10px 10px'

                ,listeners: {
                    cellclick: function(t, td, cellIndex, record, tr, rowIndex){
                        //alert(record.get('text'))
                        switchPage(record.get('text'));
                    }
                    ,afterrender: function(){
                        this.getSelectionModel().select(this.getStore().getNodeById('initSelectedNode'));
                    }
                }
            });

            var mainPanel = Ext.create('Ext.panel.Panel',{
                layout: 'fit'
                ,region: 'center'
                ,border: false
                ,html: "<iframe name='mainArea' id='mainArea' width='100%' height='100%' frameborder=0 src='<c:url value="/webbase/showHistory.do"/>'></iframe>"
            });

            var fullViewport = Ext.create('Ext.container.Viewport', {
                layout: 'border'
                ,items: [panelTop,navTree,mainPanel]
                ,listeners: {
                    render: function(){
                        //getStatus();
                        $('.statusLabel').html('正常运营...');
                        $('.statusLabel').removeClass('stopStyle');
                    }
                }
            })



        });


        function switchPage(text){
            var pageMapping = {
                '医院': WK.basePath + '/webbase/showHospital.do'
                ,'专家': WK.basePath + '/webbase/showExpertHome.do'
                ,'医生': WK.basePath + '/webbase/showDoctorHome.do'

                ,'专家结算': WK.basePath + '/webbase/showExpertAccount.do'
                ,'医生结算': WK.basePath + '/webbase/showDoctorAccount.do'
                ,'平台结算': WK.basePath + '/webbase/showNQAccount.do'
                ,'咨询单': WK.basePath + '/webbase/showConsult.do'
                ,'咨询单交易流水': WK.basePath + '/webbase/showConsultationDealFlow.do'
                ,'交易流水明细': WK.basePath + '/webbase/showDealFlow.do'
                ,'医生账户余额': WK.basePath + '/webbase/showBalance.do'

                ,'平台历史统计数据': WK.basePath + '/webbase/showHistory.do'
                ,'近期异常情况': WK.basePath + '/webbase/showException.do'
                ,'本日活跃度': WK.basePath + '/webbase/showActivity.do'
                ,'反馈列表': WK.basePath + '/webbase/showReflect.do'

                ,'患者同意函': WK.basePath + '/webbase/showConfirmation.do'
                ,'许可协议': WK.basePath + '/webbase/showLiscense.do'
                ,'推送消息': WK.basePath + '/webbase/showMessage.do'
                ,'what\'s new': WK.basePath + '/webbase/showNew.do'

                ,'运营开关': WK.basePath + '/webbase/showSwitch.do'
            };

            if(pageMapping[text]){
                Ext.getDom('mainArea').src = pageMapping[text];
            }
        }


    </script>




    <style>
        body {
            animation-name: initAnimationXX;
            animation-duration: 1s;
            animation-timing-function: ease-inXX;
            -moz-animation-name: initAnimationXX;
            -moz-animation-duration: 1s;
        }

        @keyframes initAnimation {
            0% {
                transform: translateY(0px);
            }
            50% {
                transform: translateY(-4px);
            }
            100% {
                transform: translateY(0px);
            }
        }
        @-moz-keyframes initAnimation {
            0% {
                transform: translateY(0px);
            }
            50% {
                transform: translateY(-4px);
            }
            100% {
                transform: translateY(0px);
            }
        }
        @-webkit-keyframes initAnimation {
            0% {
                -webkit-transform: translateY(0px);
            }
            50% {
                -webkit-transform: translateY(-4px);
            }
            100% {
                -webkit-transform: translateY(0px);
            }
        }

        .statusLabel {
            float: right;
            height: 35px;
            line-height: 15px;
            background: darkorange;
            margin: 12px 7px 0 10px;
            padding: 0 20px;
            font-size: 12px;

        }

        .stopStyle {
            background: red;
            animation-name: initAnimation;
            animation-duration: 0.5s;
            animation-iteration-count: infinite;

            -moz-animation-name: initAnimation;
            -moz-animation-duration: 0.5s;
            -moz-animation-iteration-count: infinite;

            -webkit-animation-name: initAnimation;
            -webkit-animation-duration: 0.5s;
            -webkit-animation-iteration-count: infinite;
        }

        .statusLabel:before {
            content: '';
            display: block;
            border-color: darkorange transparent transparent transparent;
            border-width: 5px;
            border-style: solid;
            height: 0;
            width: 0;
            position: relative;
            bottom: -35px;
            left: 23px;
        }

        .stopStyle:before {
            border-color: red transparent transparent transparent;
        }

        .btn_no_bg:hover {
            color: #23a786;
            font-weight: bold;
        }

    </style>
</head>
<body>

</body>
</html>