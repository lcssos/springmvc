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
  
    <script type="text/javascript" src="<%=contextPath%>/script/jquery-1.8.2.min.js"></script>
    <script type="text/javascript" src="<%=contextPath%>/script/highcharts.src.js"></script>
    <script type="text/javascript" src="<%=contextPath%>/script/no-data-to-display.src.js"></script>
    <script type="text/javascript" src="<%=contextPath%>/script/highcharts-3d.js"></script>
    
    <script type="text/javascript" draggable="O">
	Ext.onReady(function(){
		window.onunload = function(){
			window.parent.Ext.getBody().mask('正在跳转...');
		}
		
		Ext.QuickTips.init();
		
		var chartDivHeight = 0;
		chartDivHeight = window.document.body.clientHeight / 4;
		
		var todayDateObj = new Date();
		var dayBeginDate = todayDateObj.getFullFormat(true),dayEndDate;
		var beginDate,endDate;
		
		function getDayData(){
			var dayEndDate = new Date().getFullFormat();
			Ext.Ajax.request({
	            url: WK.basePath + '/account/get_activity_info'
				,headers: {'Content-Type': "application/json;charset=UTF-8"}
	       		,method: 'POST'
	       		,jsonData: {'begin_date': dayBeginDate,'end_date': dayEndDate}
	       		
			    ,success: function(response){
			        var returnJson = Ext.decode(response.responseText);
			        if(returnJson.status == 200){
			        	//更新数据
			        	var returnData = returnJson.data;
			        	
			        	document.getElementById('statTimeInfo').innerHTML = '统计时间：' + dayBeginDate + ' --- ' + dayEndDate;

			        	document.getElementById('statValue').innerHTML = returnJson.data[0]['new_doctor_count'];
			        	document.getElementById('statValue1').innerHTML = returnJson.data[0]['login_doctor_count'];
			        	document.getElementById('statValue2').innerHTML = returnJson.data[0]['order_doctor_count'];
			        	document.getElementById('statValue3').innerHTML = returnJson.data[0]['new_order_count'];
			        	document.getElementById('statValue4').innerHTML = returnJson.data[0]['doctor_brokerage_amount'];
			        	document.getElementById('statValue5').innerHTML = returnJson.data[0]['expert_brokerage_amount'];
			        }else{
			        	Ext.Msg.alert('错误','数据获取失败！');
			        }
			    }
			});
		}
		
		var chartPanel = Ext.create('Ext.panel.Panel',{
			defaultType: 'panel'
			,title: '近期趋势图'
			,layout:{    
	            type:'vbox'
			    ,align: 'stretch'  
			    ,pack: 'center'  
	        }
			,border: false
			,listeners: {
				render: function(){
				}
			}
			
			,style: 'background: white;'
			
			,tbar: Ext.create('Ext.toolbar.Toolbar',{
				style: 'margin: 10px 0;'
				,border: false
				,defaultButtonUI: 'default'
				,items: [{
					xtype: 'datefield'
					,fieldLabel: '开始时间'
					,width: 300
					,labelWidth: 70
					,id: 'timeFrom'
					,format: 'Y-m-d'
					,altFormats: 'Y-m-d'
				},{
					xtype: 'datefield'
					,fieldLabel: '结束时间'
					,width: 300
					,labelWidth: 70
					,id: 'timeTo'
					,format: 'Y-m-d'
					,altFormats: 'Y-m-d'
				},{
					text: '确定'
					,width: 80
					,handler: function(){
						quickQuery();
					}
				},'-',{
					text: '7天'
					,width: 80
					,handler: function(){
						var tmpDateObj = new Date();
						tmpDateObj.setDate(tmpDateObj.getDate() - 6);
						Ext.getCmp('timeTo').setValue(todayDateObj.getFullFormat(true).replace(' 00:00:00',''));
						Ext.getCmp('timeFrom').setValue(tmpDateObj.getFullFormat(true).replace(' 00:00:00',''));
						quickQuery();
					}
				},'-',{
					text: '10天'
					,width: 80
					,handler: function(){
						var tmpDateObj = new Date();
						tmpDateObj.setDate(tmpDateObj.getDate() - 9);
						Ext.getCmp('timeTo').setValue(todayDateObj.getFullFormat(true).replace(' 00:00:00',''));
						Ext.getCmp('timeFrom').setValue(tmpDateObj.getFullFormat(true).replace(' 00:00:00',''));
						quickQuery();
					}
				},'-',{
					text: '30天'
					,width: 80
					,handler: function(){
						var tmpDateObj = new Date();
						tmpDateObj.setDate(tmpDateObj.getDate() - 29);
						Ext.getCmp('timeTo').setValue(todayDateObj.getFullFormat(true).replace(' 00:00:00',''));
						Ext.getCmp('timeFrom').setValue(tmpDateObj.getFullFormat(true).replace(' 00:00:00',''));
						quickQuery();
					}
				}]
			})
			
			,items: [{
				flex: 1
				,html: '<div id="chartDiv" style="background: white;height: 25%;width: 100%;">&nbsp;&nbsp;</div>'
				,border: false
				
				,dockedItems: {
			        xtype: 'toolbar'
			        ,dock: 'top'
			        ,border: false
			        ,style: 'font-weight: normal;color: brown;'
			        ,items: [{xtype: 'tbfill'},{
						xtype: 'checkbox'
						,boxLabel: '新增的注册医生数量'
						,checked: true
						,id: 'typeCheckbox'
						,listeners: {
							change: function(c,newValue){
								//(隐藏有BUG)
							    $('#chartDiv').highcharts().series[0].setVisible(newValue);
								//直接删除
							    //$('#chartDiv').highcharts().series[0].remove();
							}
						}
					},{
						xtype: 'checkbox'
						,checked: true
						,id: 'typeCheckbox1'
						,boxLabel: '登录成功的注册医生数量'
						,listeners: {
							change: function(c,newValue){
							    $('#chartDiv').highcharts().series[1].setVisible(newValue);
							}
						}
					},{
						xtype: 'checkbox'
						,checked: true
						,id: 'typeCheckbox2'
						,boxLabel: '下单的注册医生数量'
						,listeners: {
							change: function(c,newValue){
							    $('#chartDiv').highcharts().series[2].setVisible(newValue);
							}
						}
					}]
			    }
				
				,listeners: {
					render: function(){
						 $('#chartDiv').highcharts({
					        chart: {
				                type: 'spline'
				                ,style: {
				                	background: 'gold'
				                }
				            }
					        ,legend: {
					            align: 'right'
					            ,verticalAlign: 'middle'
					            ,layout: 'vertical'
					            ,width: 200
					            ,padding: 0
					            ,itemMarginTop: 0
					            ,itemMarginBottom: 0
					            ,itemStyle: {
					            	lineHeight: '14px'
					            }
					        }
				            ,title: {
			               		margin: 0
				                ,text: ''
				            }
				            ,xAxis: {
				                categories: []
				            }
				            ,yAxis: {
				                title: {
				             		margin: 0
					                ,text: ''
					                ,y: 0
				                }
              		            ,min: 0
              		            ,minTickInterval: 1
				            }
				            ,plotOptions: {
				                line: {
				                    dataLabels: {
				                        enabled: true
				                    }
				                    ,enableMouseTracking: false
				                }
			                    ,series: {
			                    	events: {
										legendItemClick: function(){
											return false;
										}
									}
								}
				            }
				            ,series: [{
				                name: '新增医生数量'
				            }, {
				                name: '登录成功医生数量'
				            }, {
				                name: '下单医生数量'
				            }]
					    });
					}
				}
			},{
				flex: 1
				,html: '<div id="chartDiv1" style="background: white;height: 25%;width: 100%;">&nbsp;&nbsp;</div>'
				,border: false
				
				,dockedItems: {
			        xtype: 'toolbar'
			        ,dock: 'top'
			        ,border: false
			        ,style: 'font-weight: normal;color: green;'
			        ,items: [{xtype: 'tbfill'},{
						xtype: 'checkbox'
						,boxLabel: '新增咨询单数量'
						,checked: true
						,id: 'typeCheckbox3'
						,listeners: {
							change: function(c,newValue){
							    $('#chartDiv1').highcharts().series[0].setVisible(newValue);
							}
						}
					}]
			    }
				,listeners: {
					render: function(){
						 $('#chartDiv1').highcharts({
					         chart: {
				                type: 'spline'
				                ,style: {
				                	background: 'gold'
				                }
				            }
					        ,legend: {
					            align: 'right'
					            ,verticalAlign: 'middle'
					            ,layout: 'vertical'
					            ,width: 200
					            ,padding: 0
					            ,itemMarginTop: 0
					            ,itemMarginBottom: 0
					            ,itemStyle: {
					            	lineHeight: '14px'
					            }
					        }
				            ,title: {
			               		margin: 0
				                ,text: ''
				            }
				            ,xAxis: {
				                categories: []
				            }
				            ,yAxis: {
				                title: {
				             		margin: 0
					                ,text: ''
					                ,y: 0
				                }
              		            ,min: 0
              		            ,minTickInterval: 1
				            }
				            ,plotOptions: {
				                line: {
				                    dataLabels: {
				                        enabled: true
				                    },
				                    enableMouseTracking: false
				                }
			                    ,series: {
			                    	events: {
										legendItemClick: function(){
											return false;
										}
									}
								}
				            }
				            ,series: [{
				                name: '新增咨询单数量'
				            }]
					    });
					}
				}
			},{
				flex: 1
				,html: '<div id="chartDiv2" style="background: white;height: 25%;width: 100%;">&nbsp;&nbsp;</div>'
				,border: false
				
				,dockedItems: {
			        xtype: 'toolbar'
			        ,dock: 'top'
			        ,border: false
			        ,style: 'font-weight: normal;color: olive;'
			        ,items: [{xtype: 'tbfill'},{
						xtype: 'checkbox'
						,boxLabel: '医生佣金返还金额'
						,checked: true
						,id: 'typeCheckbox4'
						,listeners: {
							change: function(c,newValue){
							    $('#chartDiv2').highcharts().series[0].setVisible(newValue);
							}
						}
					},{
						xtype: 'checkbox'
						,boxLabel: '专家佣金返还金额'
						,checked: true
						,id: 'typeCheckbox5'
						,listeners: {
							change: function(c,newValue){
							    $('#chartDiv2').highcharts().series[1].setVisible(newValue);
							}
						}
					}]
			    }
				,listeners: {
					render: function(){
						 $('#chartDiv2').highcharts({
							 chart: {
					                type: 'spline'
					                ,style: {
					                	background: 'gold'
					                }
					            }
						        ,legend: {
						            align: 'right'
						            ,verticalAlign: 'middle'
						            ,layout: 'vertical'
						            ,width: 200
						            ,padding: 0
						            ,itemMarginTop: 0
						            ,itemMarginBottom: 0
						            ,itemStyle: {
						            	lineHeight: '14px'
						            }
						        }
					            ,title: {
				               		margin: 0
					                ,text: ''
					            }
					            ,xAxis: {
					                categories: []
					            }
					            ,yAxis: {
					                title: {
					             		margin: 0
						                ,text: ''
						                ,y: 0
					                }
              		            	,min: 0
              		            	,minTickInterval: 1
					            }
					            ,plotOptions: {
					                line: {
					                    dataLabels: {
					                        enabled: true
					                    },
					                    enableMouseTracking: false
					                }
				                    ,series: {
				                    	events: {
											legendItemClick: function(){
												return false;
											}
										}
									}
					            }
					            ,series: [{
					               	name: '医生佣金返还金额'
					            }, {
						        	name: '专家佣金返还金额'
					            }]
					    });
					}
				}
			}]
		});
		
		function quickQuery(){
			if(Ext.getCmp('timeFrom').getValue() && Ext.getCmp('timeTo').getValue()){
				var fromValue = false;
				var toValue = false;
				var fromObj = Ext.getCmp('timeFrom').getValue();
				var toObj = Ext.getCmp('timeTo').getValue();
				
				toObj.setHours(23);
				toObj.setMinutes(59);
				toObj.setSeconds(59);
				
				var diff = toObj - fromObj;
				
				//必须限制在1--31天
				if(diff >= 24 * 60 * 60 * 1000 && diff <= 2678400000){
					beginDate = fromObj.getFullFormat();
					endDate = toObj.getFullFormat();
					//发送请求
					Ext.Ajax.request({
			            url: WK.basePath + '/account/get_activity_info'
						,headers: {'Content-Type': "application/json;charset=UTF-8"}
			       		,method: 'POST'
			       		//,jsonData: {'begin_date': '2014-07-14 00:00:00','end_date': '2014-07-23 23:59:59'}
			       		,jsonData: {'begin_date': beginDate,'end_date': endDate}
			       		
					    ,success: function(response){
					        var returnJson = Ext.decode(response.responseText);
					        if(returnJson.status == 200){
					        	//更新图表
					        	var returnData = returnJson.data;
					        	
					        	var chart = $('#chartDiv').highcharts();
					        	var chart1 = $('#chartDiv1').highcharts();
					        	var chart2 = $('#chartDiv2').highcharts();
					        	
					        	var labelArr = [],labelArr1 = [],labelArr2 = [];
				        		var valueArr=[],valueArr1=[],valueArr2=[];
				        		var valueArr3=[];
				        		var valueArr4=[],valueArr5=[];

				        		var dataLength = returnJson.data.length;
					        	
				        		while(dataLength--){
					        		labelArr.push(getFormatDateByStamp(returnJson.data[returnJson.data.length - dataLength - 1]['date']));
					        		labelArr1.push(getFormatDateByStamp(returnJson.data[returnJson.data.length - dataLength - 1]['date']));
					        		labelArr2.push(getFormatDateByStamp(returnJson.data[returnJson.data.length - dataLength - 1]['date']));
					        	
					        		//更新数据
							        valueArr.push(returnJson.data[returnJson.data.length - dataLength - 1]['new_doctor_count']);
							        valueArr1.push(returnJson.data[returnJson.data.length - dataLength - 1]['login_doctor_count']);
							        valueArr2.push(returnJson.data[returnJson.data.length - dataLength - 1]['order_doctor_count']);

							        valueArr3.push(returnJson.data[returnJson.data.length - dataLength - 1]['new_order_count']);

							        valueArr4.push(returnJson.data[returnJson.data.length - dataLength - 1]['doctor_brokerage_amount']);
							        valueArr5.push(returnJson.data[returnJson.data.length - dataLength - 1]['expert_brokerage_amount']);
					        	}
					        	
						        chart.series[0].update({
						        	name: '新增的注册医生数量'
						        	,data: valueArr
						        	,visible: Ext.getCmp('typeCheckbox').getValue()
						        });
						        chart.series[1].update({
						        	name: '登录成功的医生数量'
						        	,data: valueArr1
						        	,visible: Ext.getCmp('typeCheckbox1').getValue()
						        });
						        chart.series[2].update({
						        	name: '下单的注册医生数量'
						        	,data: valueArr2
						        	,visible: Ext.getCmp('typeCheckbox2').getValue()
						        });
						        
						        chart1.series[0].update({
						        	name: '新增咨询单数量'
						        	,data: valueArr3
						        	,visible: Ext.getCmp('typeCheckbox3').getValue()
						        });
						        
						        chart2.series[0].update({
						        	name: '医生佣金返还金额'
						        	,data: valueArr4
						        	,visible: Ext.getCmp('typeCheckbox4').getValue()
						        });
						        chart2.series[1].update({
						        	name: '专家佣金返还金额'
						        	,data: valueArr5
						        	,visible: Ext.getCmp('typeCheckbox5').getValue()
						        });
				        		
				        		
					            chart.xAxis[0].setCategories(labelArr);
					            chart1.xAxis[0].setCategories(labelArr1);
					            chart2.xAxis[0].setCategories(labelArr2);
					        }else{
					        	Ext.Msg.alert('错误','数据获取失败！');
					        }
					    }
					});
					
				}else{
					Ext.Msg.alert('警告','开始日期与结束日期间隔限定在1~31天!');
				}
				
			}else{
				Ext.Msg.alert('警告','请输入正确格式的开始/结束时间!');
			}
		}
		
		Ext.create('Ext.container.Viewport', {
	        layout: 'fit'
	        ,items: Ext.create('Ext.tab.Panel',{
				activeTab: 0
				,tabPosition: 'right'
				,items: [{
					title: '本日活跃度'
					,tbar: {
						xtype: 'customToolbar'
						,items: [{
							xtype: 'npacsbutton'
							,text: '刷新'
							,handler: function(){
								getDayData();
							}
						}]
					}
					,html: '<div class="dayStat"><h1 id="statTimeInfo">统计时间：---</h1>'
						+ '<div>新增的注册医生数量<p id="statValue">---</p></div>'
						+ '<div>登录成功的注册医生数量<p id="statValue1">---</p></div>'
						+ '<div>下单的注册医生数量<p id="statValue2">---</p></div>'
						
						+ '<div style="clear: both;background: chocolate;">新增咨询单数量<p id="statValue3">---</p></div>'

						+ '<div style="clear: both;background: darkslateblue;">医生佣金返还金额<p id="statValue4">---</p></div>'
						+ '<div  style="background: darkslateblue;">专家佣金返还金额<p id="statValue5">---</p></div>'
						+ '</div>'
		        	,listeners: {
		        		render: function(){
		        			getDayData();
		        		}
		        	}
				},chartPanel]
			})
			
			,listeners: {
				render: function(){
					//备注：SAFARI/CHROME下图表显示异常
					chartDivHeight = window.document.body.clientHeight / 4;
					//document.getElementById('chartDiv').style.height = chartDivHeight + 'px';
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
			
			
			/* Rotate div */
			
		}
		.dayStat h1 {
			height: 40px;
			background: #333;
			color: white;
			font-size: 14px;
			line-height: 30px;
			margin: 10px 10px 0 10px;
			padding:  5px 10px;
		}
		.dayStat div {
			float: left;
			height: 120px;
			width: 200px;
			background: brown;
			color: white;
			font-weight: bold;
			font-size: 12px;
			line-height: 30px;
			text-align: center;
			margin: 10px 0 0 10px;
			padding: 10px;
		}
		.dayStat div p{
			font-weight: bold;
			font-size: 60px;
			line-height: 70px;
			text-align: center;
			margin: 0;
		}
		
		.dayStatXX div:after {
			content: '';
			display: block;
			width: 0px;
			height: 0px;
			border-width: 10px;
			border-color: #666 #666 white white;
			border-style: solid;
			background: white;
			position: relative;
			bottom: 10px;
			right: 10px;
		}
	
	</style>
	</head>
	<body>
	</body>
</html>