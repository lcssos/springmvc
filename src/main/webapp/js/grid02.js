/**
 * Created by martin on 2015-01-08.
 */

Ext.onReady(function () {
    //Ext.tip.QuickTipManager.init();
    Ext.Loader.setConfig({
        enable: true
    });

    Ext.application({
        name: "My",
        appFolder: "js",
        controllers: ["UserController"],
        launch: function () {  //当前页面加载完成执行
            Ext.create("Ext.container.Viewport", {
                layout: "auto",   //自动布局
                items: [
                    {xtype: "userview", title: "用户列表"}
                ]
            });
        }
    });

});