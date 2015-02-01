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
		
		Ext.define('messageModel', {
	    	extend: 'Ext.data.Model'
	    	,fields: [{
	    		name: 'bcmsgid',type: 'string'
	    	},{
	    		name: 'content',type: 'string'
	    	},{
	    		name: 'submittime',type: 'string'
	    	}]
	    });
	    
	    var messageStore = Ext.create('Ext.data.Store', {
	        model: 'messageModel'
	        ,proxy: {
	            type: 'ajax'
        		//,headers: {'Content-Type': "application/json;charset=UTF-8"}
	            ,url: WK.basePath + '/system/listSystemInform.do'
	            ,pageParam: ''
	            ,startParam: ''
	            ,limitParam: ''
	            ,reader: {
	                type: 'json'
	                ,rootProperty: 'list'
	            }
	        }
	        ,autoLoad: true
	    });
	    
		var messageGrid = Ext.create('Ext.grid.Panel',{
			store: messageStore
			,forceFit: true
			
			,cls: 'wukong'
			,border: false
			
			,tbar: {
				xtype: 'customToolbar'
				,items: [{
					xtype: 'npacsbutton'
					,text: '创建'
					,handler: function(){
		    			var addForm = Ext.create('Ext.form.Panel',{
		    				defaultType: 'textfield'
		    				,style: 'padding: 10px;'
		 					,autoWidth: true
		    				,defaults: {
		    					width: 400
		    					,labelWidth: 60
		    					,labelStyle: 'text-align: center'
		    				}
		    				,border: false
		    				,frame: false
		    				,method: 'POST'
		    				,autoHeight: true
		    				,items: [{
	    					    xtype: 'textareafield'
			    				,fieldLabel: '消息内容'
			    				,name: 'content'
	    					    ,allowBlank: false
			    				,maxLength: 100
			    				,validator: function(v){
			    					if(v.length){
				    					if(v.replace(/^\s+/,'').length){
				    						return true;
				    					}
				    					return '内容不允许为空!';
			    					}else{
			    						return true;
			    					}
			    				}
		    				}]
		    			});
		    			var addWindow = Ext.create('Ext.window.Window',{
		    				title: '创建消息'
		    				,autoWidth: true
		    				,autoHeight: true
		    				,modal: true
		    				,bodyStyle: 'padding: 10px;'
		    				,autoScroll: true
		    				//,layout: 'center'
		    				,items: addForm
		    				,buttonAlign: 'center'
		    				,buttons: [{
		    					text: '提交'
		    					,handler: function(){
		    						if(addForm.getForm().isValid()){
		    							Ext.Msg.confirm('提示','您确定要推送此消息给用户吗?',function(btn){
		    								if(btn == 'yes'){
				    							var formData = addForm.getForm().getValues();
			    								Ext.Ajax.request({
			    									url: WK.basePath + '/system/sendSystemInform.do'
			    									,method: 'POST'
													//,headers: {'Content-Type': "application/json;charset=utf-8"}
			    									,params: formData
			    									,success: function(response, opts) {
			    								        var returnJson = Ext.decode(response.responseText);
			    								        if(Number(returnJson.status) == 200){
			    											addWindow.close();
			    											Ext.Msg.alert('提示','操作成功！');
			    											messageStore.reload();
			    								        }else{
			    											Ext.Msg.alert('提示','操作失败！');
			    								        }
			    								    }
			    									,failure: function(response, opts) {
			    										Ext.Msg.alert('提示','操作失败！');
			    									}
			    								});
		    								}
		    							});
		    						}else{
		    							Ext.Msg.alert('提示','请检查输入值！');
		    						}
		    					}
		    			    },{
		    					text: '取消'
		    					,handler: function(){
		    						addWindow.close();
		    					}
		    				}]
		    				,listeners: {
		    					show: function(){
		    						//Ext.getCmp('editor').focus();
		    					}
		    				}
		    			});
		    			addWindow.show();
					}
				},'-',{
					xtype: 'npacsbutton'
					,text: '刷新'
					,handler: function(){
						messageStore.reload({params: {}});
					}
				}]
			}
		
			//,bbar: pager
			
			,columns: [{
				xtype: 'rownumberer'
			},{
				text: '创建时间',dataIndex: 'submittime'
				,width: 100
				,renderer: function(v){
					//return new Date(Number(v)).getFullFormat()
					return v;
				}
			},{
				text: '内容',dataIndex: 'content'
				,width: 400
			},{
            	menuDisabled: false
                ,sortable: false
                ,xtype: 'actioncolumn'
                ,width: 160
                ,fixed: true
                ,align: 'center'
                ,items: [{
                    iconCls: 'showDetail'
                    ,tooltip: '详情'
           			,handler: function(g,rowIndex,c,i,e,r){
           				messageGrid.getSelectionModel().select(r);
           				var detailWindow = Ext.create('Ext.window.Window',{
           					title: '详情'
		                    ,modal: true
		                    ,bodyStyle: 'padding: 20px;'
		                    ,height: 520
		                    ,width: 400
		                    ,autoScroll: true
           					,html: ('<div class="detailHeader">'
    					        + '创建时间：' + new Date(Number(r.get('submittime'))).getFullFormat()
    					        + '</div><br />'
    					        + r.get('content'))
           					,buttonAlign: 'center'
           					,buttons: [{
           						text: '关闭'
           						,handler: function(){
           							detailWindow.close();
           						}
           					}]
           				});
           				detailWindow.show();
    				}
                }]
			}]
		});
		
		Ext.create('Ext.container.Viewport', {
	        layout: 'fit'
	        ,items: messageGrid
	    })
	});
	</script>
	<style>
		strong {
			font-weight: bold;
		}
	</style>
	</head>
	<body>
	</body>
</html>