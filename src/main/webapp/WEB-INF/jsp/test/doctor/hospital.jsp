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
		
		var majorLevel = {'0': '一级',1: '二级',2: '二级甲等',3: '三级','4':'三级甲等'};
		var minorLevel = {'-1': '其他',0: '特等',1: '甲等',2: '乙等',3: '丙等'};
		
		Ext.define('hospitalModel', {
	    	extend: 'Ext.data.Model'
	    	,fields: [{
	    		name: 'hospitalid',type: 'string'
	    	},{
	    		name: 'name',type: 'string'
	    	},{
	    		name: 'provinceName',type: 'string'
	    	},{
	    		name: 'cityName',type: 'string'
	    	},{
	    		name: 'majorlevel',type: 'string'
	    	//},{
	    		//name: 'minorlevel',type: 'string'
	    	},{
	    		name: 'doctorNum',type: 'string'
	    	},{
	    		name: 'rdpaddress'
	    	}]
	    });
		
	    //省份信息
	    var provinceStore = Ext.create('Ext.data.Store', {
	        fields: ['provinceid','name']
	        ,proxy: {
	            type: 'ajax'
	            ,headers: {'Content-Type': "application/x-www-form-urlencoded"}
	            //,actionMethods: {create: "GET", read: "GET", update: "POST", destroy: "POST"}
	            ,url: WK.basePath + '/system/getProvince.do'
	            
	            ,reader: {
	                type: 'json'
	                ,rootProperty: 'list'
	            }
	        }
	        ,autoLoad: true
	    });

		//城市信息
	    var cityStore = Ext.create('Ext.data.Store', {
	        fields: ['cityid','name']
	        ,proxy: {
	            type: 'ajax'
	            ,actionMethods: {create: "POST", read: "POST", update: "POST", destroy: "POST"}
	            ,headers: {'Content-Type': "application/x-www-form-urlencoded"}
	            ,url: WK.basePath + '/system/getCity.do'
	            ,reader: {
	                type: 'json'
	                ,rootProperty: 'list'
	            }
	        }
	    });

		//医院信息
	    var hospitalStore = Ext.create('Ext.data.Store', {
	        model: 'hospitalModel'
	        ,proxy: {
	            type: 'ajax'
	            ,headers: {'Content-Type': "application/x-www-form-urlencoded"}
	            ,actionMethods: {create: "POST", read: "POST", update: "POST", destroy: "POST"}
	            ,url: WK.basePath + '/system/listHospital.do'
	         
	            ,paramsAsJson: true
	            ,pageParam: ''
	            ,startParam: ''
	            ,limitParam: ''
	         
	            ,reader: {
	                type: 'json'
	                ,rootProperty: 'hospital'
	            }
	        }
	        ,autoLoad: true
	    });
	 
		var hospitalGrid = Ext.create('Ext.grid.Panel',{
			store: hospitalStore
			,forceFit: true
			
			,cls: 'wukong'
			,border: false
			
			,tbar: {
				xtype: 'customToolbar'
				,items: [{
					xtype: 'npacsbutton'
					,text: '创建'
					,handler: function(){
						basicAction();
					}
				},'-',{
					xtype: 'npacsbutton'
					,text: '刷新'
					,handler: function(){
						hospitalStore.reload();
					}
				}]
			}
			
			,columns: [{
				xtype: 'rownumberer'
			},{
				text: '名称',dataIndex: 'name'
			},{
				text: '位置',dataIndex: 'provinceName'
				,renderer: function(v,m,r){
					return v + ' --> ' + r.get('cityName');
				}
			},{
				text: '级别',dataIndex: 'majorlevel'
				,renderer: function(v,m,r){
					return majorLevel[v];
				}
			},{
				text: '医生数',dataIndex: 'doctorNum'
			},{
				text: '远程桌面地址'
				,dataIndex: 'rdpaddress'
				,renderer: function(v,m,r,rowIndex){
					return '<div><img onclick="WK.editRemote(' + rowIndex + ');" onmouseover="WK.tip(this,\'编辑远程桌面地址\');" style="float: right;" src="' + WK.basePath + '/ext-5.1.0/packages/ext-theme-crisp/build/resources/images/npacs/setting.png" />' + v + '<div>'
				}
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
           			,handler: function(v,rowIndex,c,i,e,r){
           				hospitalGrid.getSelectionModel().select(r);
        				showDetail(v,rowIndex,c,i,e,r);
    				}
                },{
                    iconCls: 'editActionIcon'
                    ,tooltip: '编辑'
           			,handler: function(v,rowIndex,c,i,e,r){
           				hospitalGrid.getSelectionModel().select(r);
        				basicAction(r);
						//expertRecordAction(true,r);
    				}
                }]
			}]
			,region: 'center'
		});

		function showDetail(v,rowIndex,c,i,e,r){
			Ext.Ajax.request({
	            url: '/system/hospitalDetail.do'
	            ,method: 'POST'
	            ,params: {
	            	hospitalId: r.get('hospitalid')
	            }
			    ,success: function(response){
			    	var returnJson = Ext.decode(response.responseText);
			    	if(Number(returnJson.status) !== 200){
			    		Ext.Msg.alert('提示','获取失败！');
			    		return;
			    	}
			    	
					var dataObj = returnJson.hospital[0];
					var hospitalHtmlFunc = new HtmlFunc();
					
					var html = '<table class="profileTable" border=0 cellspacing=0 cellpadding=10>';

					html += hospitalHtmlFunc.generateTableRow('',hospitalHtmlFunc.colorText(dataObj.name,true,'black','20'),'');
					html += hospitalHtmlFunc.generateTableRow('位置',dataObj.provinceName + ' --> ' + dataObj.cityName);

					html += hospitalHtmlFunc.generateTableRow('级别',majorLevel[dataObj.majorlevel]);
					
					html += hospitalHtmlFunc.generateTableRow('远程桌面地址',dataObj.rdpaddress || '---');
					html += hospitalHtmlFunc.generateTableRow('账号',dataObj.rdpuser || '---');
					html += hospitalHtmlFunc.generateTableRow('密码',dataObj.rdppassword ? '*'.repeatByLength(dataObj.rdppassword.length) : '---');
					html += hospitalHtmlFunc.generateTableRow('医生数',dataObj.doctorNum);
					html += '</table>';
					
					//资质信息
					var doctorHtml = '<table class="table table-striped table-bordered table-condensed" style="margin: 10px 0;border-top: 1px solid #ccc;">'
					doctorHtml += '<tr><td>姓名</td><td>邮箱</td><td>科室</td><td>职称</td>'
					for(var i = 0;i < returnJson.hospital[0].doctorList.length;i++){
						doctorHtml += '<tr><td>' + returnJson.hospital[0].doctorList[i]['name'] + '</td><td>'
							+ returnJson.hospital[0].doctorList[i]['email'] + '</td><td>'
							+ returnJson.hospital[0].doctorList[i]['department'] + '</td><td>'
							+ returnJson.hospital[0].doctorList[i]['title'] + '</td></tr>';
					}
					doctorHtml += '</table>';
					html += doctorHtml;
					//html += hospitalHtmlFunc.generateTableRow('',doctorHtml);
					html += '</table>';
					
					var detailWin = Ext.create('Ext.window.Window',{
						title: '医院详情'
						,bodyStyle: 'padding: 20px;'
						,html: html
						,width: 600
						,height: 520
						,autoScroll: true
						,modal: true
						,buttonAlign: 'center'
						,buttons: [{
							text: '关闭'
							,handler: function(){
								detailWin.close();
							}
						}]
					});
					detailWin.show();
		    	}
			});
		}
		
		WK.editRemote = function(rowIndex){
			basicAction(hospitalStore.getAt(rowIndex),true);
		}
		
		function basicAction(r,quick){
			if(r){
				cityStore.getProxy().setExtraParams({provinceid: r.get('provinceid')});
				cityStore.reload({});
			}
			var addForm = Ext.create('Ext.form.Panel',{
				defaultType: 'textfield'
				,autoWidth: true
				,defaults: {
					width: 400
					,labelWidth: 100
					,labelStyle: 'text-align: center'
				}
				,border: false
				,autoHeight: true
				,items: [{
					xtype: 'forcetextfield'
					,fieldLabel: '名称'
					,name: 'hospitalName'
					,maxLength: 20
					,value: r ? r.get('name') : ''
							
					,disabled: !!quick
					,hidden: !!quick
				},{
					xtype: "forcecombobox"
					,fieldLabel: '省份'
					,forceSelection: true		
					,editable: false
					,valueField: "provinceid"
					,displayField: "name"
					,name: 'provinceid'
					,hiddenName: 'provinceid'
					,triggerAction: "all"
					,store: provinceStore
					,allowBlank: false
					,maxLength: 20
					,listeners: {
						select: function(c,records){
							cityStore.removeAll();
							cityStore.getProxy().setExtraParams({provinceid: records[0].get('provinceid')});
							cityStore.reload();
						}
					}
					,value: r ? r.get('provinceid') : ''
							
					,disabled: !!quick
					,hidden: !!quick
				},{
					xtype: "forcecombobox"
					,fieldLabel: '城市'
					,forceSelection: true		
					,editable: false
					,valueField: "cityid"
					,displayField: "name"
					,hiddenName: 'cityid'
					,name: 'cityid'
					,triggerAction: "all"
					,store: cityStore
					,allowBlank: false
							
					,disabled: !!quick
					,hidden: !!quick
				},{
					xtype: "forcecombobox"
					,fieldLabel: '级别'
					,forceSelection: true		
					,editable: false
					,mode: "local"
					,valueField: "value"
					,displayField: "name"
					,hiddenName: 'majorlevel'
					,name: 'majorlevel'
					,triggerAction: "all"
					,store: new Ext.data.SimpleStore({
						fields: ['value','name']   
						,data: [
					        ['0','一级']
					        ,['1','二级']
					        ,['2','二级甲等']
					        ,['3','三级']
					        ,['4','三级甲等']
				        ]
					})
					,allowBlank: false
					,value: r ? r.get('majorlevel') : ''
							
					,disabled: !!quick
					,hidden: !!quick
				},{
					fieldLabel: '远程桌面地址'
					,name: 'rdpaddress'
					,maxLength: 30
					,value: r ? r.get('rdpaddress') : ''
				},{
		            fieldLabel: '账号'
					,name: 'rdpuser'
					,maxLength: 20
					,value: r ? r.get('rdpuser') : ''
		        },{
		            fieldLabel: '密码'
		            ,inputType: 'password'
					,name: 'rdppassword'
					,maxLength: 10
					,value: r ? r.get('rdppassword') : ''
				}]
				,listeners: {
					render: function(f){
						if(r){
							var cityField = formFindItem(addForm,2);
							cityField.setRawValue(r.get('cityName'));
							cityField.setValue(r.get('cityid'),false);
						}
					}
				}
			});
			var addWindow = Ext.create('Ext.window.Window',{
				title: r ? (quick ? '编辑远程桌面地址' : '编辑医院') : '新增医院'
				,autoWidth: true
				,autoHeight: true
				,modal: true
				,bodyStyle: 'padding: 20px;'
				,autoScroll: true
				,items: addForm
				,buttonAlign: 'center'
				,buttons: [{
					text: '提交'
					,handler: function(){
						if(addForm.getForm().isValid()){
							var formData = addForm.getForm().getValues();
							if(r){
								formData[quick ? 'hospitalId' : 'hospitalid'] = r.get('hospitalid');
							}
							Ext.Ajax.request({
								url: r ? (WK.basePath + (quick ? '/system/updateRemoteaccess.do' : '/system/updateHospital.do')) : (WK.basePath + '/system/addHospital.do')
								,method: 'POST'
								,headers: {'Content-Type': "application/x-www-form-urlencoded;charset=utf-8"}
								,params: formData
								,success: function(response, opts) {
							        var returnJson = Ext.decode(response.responseText);
							        if(Number(returnJson.status) == 200){
										addWindow.close();
										Ext.Msg.alert('提示','操作成功！');
										hospitalStore.reload();
							        }else{
										Ext.Msg.alert('提示','操作失败！');
							        }
							    }
								,failure: function(response, opts) {
									Ext.Msg.alert('提示','操作失败！');
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
						if(r){
							var cityField = formFindItem(addForm,2);
							cityField.setRawValue(r.get('cityName'));
							cityField.setValue(r.get('cityid'));
						}
						//Ext.getCmp('nameField').focus();
					}
				}
			});
			addWindow.show();
		}

		Ext.create('Ext.container.Viewport', {
	        layout: 'fit'
	        ,items: hospitalGrid
	    })
	});
	</script>
	</head>
	<body>
	</body>
</html>