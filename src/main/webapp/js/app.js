/*Ext.onReady(function() { // 创建一个面板
	var myPanel = new Ext.Panel({
		renderTo : Ext.getBody(),
		title : '哈哈哈',
		width : 300,
		height : 300,
		html : 'test面板'
	});

	alert('h');
});*/
Ext.onReady(function(){
	if(Ext.BLANK_IMAGE_URL.substring(0,4) != "data"){
		Ext.BLANK_IMAGE_URL = "../extjs/resources/images/s.gif";
	}
});

Ext.application({
	name:"springmvc",		//全局命名空间
	appFolder:"js",	//表示从哪个目录加载文件
	controllers:["Student"],
	launch:function(){
		console.debug("launch");
		Ext.create("Ext.container.Viewport",{
			layout:"fit",
			items:[
				{
					xtype:'student.list'
				}
			]
		});
	}

});



/*
{
	xtype:"panel",
		title:"hello 4",
	html:"欢迎进入ext4"
},*/


