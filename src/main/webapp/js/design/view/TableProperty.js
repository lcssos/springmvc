/**
 * Created by martin on 2015-01-10.
 */

Ext.define("Martin.view.TableProperty",{
    extend:"Ext.grid.property.Grid",
    title:"表格属性",
    alias:'widget.tableproperty',
    width:"30%",
    height:"100%",
    source:{
        'id':"",
        "名称":"",
        "标题":"空",
        "是否显示行号":false
    }


});