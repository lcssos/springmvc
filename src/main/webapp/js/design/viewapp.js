/**
 * Created by martin on 2015-01-09.
 */

Ext.onReady(function () {
    //Ext.tip.QuickTipManager.init();
    Ext.Loader.setConfig({
        enable: true
    });

    Ext.application({
        name: "Martin",
        appFolder: "../js/design",
        controllers: ["ViewController"],
        launch: function () {  //当前页面加载完成执行
            Ext.create("Ext.container.Viewport", {
                layout: "border",   //自动布局
                items: [
                    {xtype: "tableview", title: "表格面板",region:"center",layout:'fit'},
                    {xtype: "tableproperty", title: "表格属性",region:"east",layout:"fit"}
                ]
            });
        }
    });

});