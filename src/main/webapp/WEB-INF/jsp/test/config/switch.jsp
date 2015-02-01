<%@ page contentType="text/html;charset=utf-8"  %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
    <head>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8">
    <title>管理平台</title>
		<link rel="stylesheet" type="text/css" href="<c:url value="/ext-5.1.0/packages/ext-theme-crisp/build/resources/ext-theme-crisp-all-debug.css"/>" />
		<link rel="stylesheet" type="text/css" href="<c:url value="/ext-5.1.0/packages/ext-theme-crisp/build/resources/bootstrap.css"/>" />
		<script type="text/javascript" src="<c:url value="/ext-5.1.0/build/bootstrap.js"/>"></script>
		<script type="text/javascript" src="<c:url value="/ext-5.1.0/build/packages/ext-locale/build/ext-locale-zh_CN.js"/>"></script>
		<script type="text/javascript"
				src="<c:url value="/js/common.js"/>"></script>
    
    <script type="text/javascript" draggable="O">
	Ext.onReady(function(){
		window.onunload = function(){
			//window.parent.Ext.getBody().mask('正在跳转...');
		}
		
		var animationCloseFlag = window.location.search === '?animation=no';
		
       	//更新数据
       	var statusJson = {
    		'A': '正常运营...' 
     		,'M': '<span style="color: white;">暂停运营...</span>' 
       	};
       	
		function getStatus(){
			Ext.Ajax.request({
	            url: WK.basePath + '/system/findSysemStatus.do'
			    ,success: function(response){
			        var returnJson = Ext.decode(response.responseText);
			        
			        if(Number(returnJson.status) == 200){
			        	document.getElementById('statusField').innerHTML = '当前状态：' + statusJson[returnJson.sysstatus];
			        	
			        	//$('.btn-danger:last').attr('disabled',returnJson.sysstatus != 'A');
			        	//$('.btn-success:last').attr('disabled',returnJson.sysstatus == 'A');
			        }else{
			        	Ext.Msg.alert('错误','数据获取失败！');
			        }
			    }
			});
		}
		
		function switchStatus(value){
			Ext.Ajax.request({
	            url: WK.basePath + '/system/changeSystemStatus.do'
				,method: 'POST'
				//,headers: {'Content-Type': "application/json;charset=utf-8"}
				//,jsonData: {status: value}
				,params: {status: value}
			    ,success: function(response){
			        var returnJson = Ext.decode(response.responseText);
			        
			        if(Number(returnJson.status) == 200){
			        	Ext.Msg.alert('提示',(value == 'A' ? '恢复运营' : '暂停运营' ) + '成功！');
			        	document.getElementById('statusField').innerHTML = '当前状态：' + statusJson[value];
			        	
			        	//$('.btn-danger:last').attr('disabled',value != 'A');
			        	//$('.btn-success:last').attr('disabled',value == 'A');
			        }else{
			        	Ext.Msg.alert('错误','操作失败！');
			        }
			    }
			});
		}
		
		Ext.create('Ext.container.Viewport', {
	        layout: 'fit'
	        ,items: {
				tbar: {
					xtype: 'customToolbar'
					,items: [{
						xtype: 'npacsbutton'
						,text: '刷新'
						,handler: function(){
		        			getStatus();
						}
					}]
				}
				,html: '<h1 id="statusField">当前状态：---</h1>'
					+ '<div class="btn btn-success btn-sm pull-left" style="margin: 10px;">恢复运营</div>'
					+ '<div class="btn btn-danger btn-sm pull-left" style="margin: 10px;">暂停运营</div>'
	        	,listeners: {
	        		render: function(){
	        			//getStatus();
/*			        	$('.btn-danger:last').click(function(){
			        		Ext.Msg.confirm('提示','暂停运营时，移动终端无法执行任何操作(仅web系统可访问)，您确定要暂停运营吗?',function(btn){
			        			if(btn == 'yes'){
									//switchStatus('M');
									//window.parent.$('.statusLabel').addClass('stopStyle');
									//window.parent.$('.statusLabel').html('暂停运营...');
			        			}
			        		});
			        	});
			        	$('.btn-success:last').click(function(){
			        		Ext.Msg.confirm('提示','您确定要恢复运营吗?',function(btn){
			        			if(btn == 'yes'){
									switchStatus('A');			        				
									//window.parent.$('.statusLabel').removeClass('stopStyle');
									//window.parent.$('.statusLabel').html('正常运营...');
			        			}
			        		});
			        	});*/
	        		}
	        	}
			}
	    })
	});
	</script>
	<style>
		body {
			width: 100%;
			height: 100%;
			margin: 0;
			padding: 0;
		}
		h1#statusField {
			height: 40px;
			background: #333;
			color: white;
			font-weight: bold;
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
			font-weight: bold;
			font-size: 12px;
			line-height: 30px;
			text-align: center;
			margin: 10px 0 0 10px;
			padding: 0px;
		}
		
	</style>
	</head>
	<body>
	</body>
</html>