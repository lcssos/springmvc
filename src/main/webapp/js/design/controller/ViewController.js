/**
 * Created by martin on 2015-01-09.
 */

Ext.define("Martin.controller.ViewController",{
    extend:"Ext.app.Controller",
    views:[""],
    init:function(){
        //console.debug("student controller init");
        this.control({
            //属性窗口编辑完成事件
            "tableproperty":{
                "edit":function(e){
                    debugger;
                    alert(Ext.Date.format(12345,"U"));
                    e.record.commit();
                }
            }
        })
    },
    views:["Table","TableProperty"],
    models:["Table"]
});

//,"ColumnProperty","ButtonProperty"