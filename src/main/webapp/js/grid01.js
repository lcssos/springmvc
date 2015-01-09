/**
 * Created by martin on 2015-01-08.
 */

Ext.onReady(function () {
    Ext.tip.QuickTipManager.init();

    Ext.define("Person", {
        extend: "Ext.data.Model",
        fields: [{
            name: 'name',
            type: 'auto'
        }, {
            name: 'age',
            type: 'int'
        }, {
            name: 'id',
            type: 'auto'
        }]
    });


    var store = Ext.create("Ext.data.Store", {
        model: "Person",
        autoLoad: true,
        proxy: {
            type: "ajax",
            url: "admin/user/page",
            reader: {
                type: "json",
                root: "rows"
            },
            writer: {
                type: "json"
            }
        }
    });


    var grid = Ext.create("Ext.grid.Panel", {
        title: "我的表格",
        store: store,
        renderTo: Ext.getBody(),
        frame: true,     //填充
        //frameHeader: false,
        //forceFit: true,  //宽度自适应
        width: '90%',
        height: '90%',
        selType:"checkboxmodel",
        plugins: [{ptype: 'cellediting', clicksToEdit: 1}],
        //disableSelection:true,
        //field与plugin一起，启用编辑模式
        columns: [
            {text: "姓名", dataIndex: "name",width:200,field:{
                xtype:"textfield",
                allowBlank:false
            }},
            {text: "年龄", dataIndex: "age",width:100,field:{
                xtype:"numberfield"
            }},
            {text: "id", dataIndex: "id",width:500}
        ],
        tbar: [
            {xtype: "button", text: "添加", iconCls: "table_add",handler:function(button){
                alert("add");
            }},
            {xtype: "button", text: "修改", iconCls: "table_edit"}, "-",
            {xtype: "button", text: "删除", iconCls: "table_delete"}, "->",
            {xtype: "button", text: "查看", iconCls: "table_add"}
        ],
        bbar: {
            xtype: "pagingtoolbar",
            store: store,
            displayInfo: true
        }
    });

});