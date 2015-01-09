/**
 * Created by martin on 2015-01-06.
 */

Ext.define("springmvc.controller.Student",{
    extend:"Ext.app.Controller",
    views:["student.List"],
    init:function(){
        console.debug("student controller init");
        this.control({
            'SysTree':{
             itemclick:this.putTabPanel
        }
    })
    },
    putTabPanel:function(view, record, element, index, eventObject,object){}
});