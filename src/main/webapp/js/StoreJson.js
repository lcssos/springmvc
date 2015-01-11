/**
 * Created by martin on 2015-01-08.
 */

Ext.onReady(function () {
    Ext.define('User', {
        extend: 'Ext.data.Model',
        fields: [
            {name: 'id', type: 'string'},
            {name: 'name', type: 'string'},
            {name: 'age', type: 'int'}
        ],
        proxy: {
            type: 'ajax',
            api: {
                create: '/controller/new',
                read: '/controller/load',
                update: '/controller/update',
                destroy: '/controller/destroy_action'
            }
        }

    });

    Ext.define("Ext.ux.MyStore", {
        extend:"Ext.data.Store",
        alias:"store.mystore",
        constructor: function (config) {
            config = Ext.apply({
                pageSize: 30,
                autoLoad: true,
                model:"User",
                proxy: {
                    type: "ajax",
                    reader: {
                        type: 'json',
                        root: "rows",
                        totalProperty: 'total'
                    }
                }
            }, config);
            this.callParent([config]);
        }
    });

    var store = Ext.create("Ext.ux.MyStore", {
        autoLoad: true,
        model: "User",
        proxy: {
            url: "admin/user/page"
        }
    });

    /*   var store = Ext.create('Ext.data.Store', {
     //自动加载ajax
     autoLoad: true,
     model: 'User',
     pageSize: 30,
     proxy: {
     type: 'ajax',
     url: 'admin/user/page',
     reader: {
     type: 'json',
     root: "rows",
     totalProperty: 'total'
     }
     }
     });*/

    //store.loadPage(1);

    Ext.create("Ext.grid.Panel", {
        title: "Ext.grid.Panel",
        renderTo: Ext.getBody(),
        frame: true,
        height: '100%',
        width: '100%',
        store: store,
        columns: [
            {header: "ID", width: 350, dataIndex: "id", sortable: false},
            {header: "姓名", width: 100, dataIndex: "name", sortable: false},
            {header: "年龄", width: 135, dataIndex: "age", sortable: false}
        ],
        bbar: Ext.create('Ext.PagingToolbar', {
            store: store,
            displayInfo: true,
            displayMsg: '显示{0}-{1}条，共{2}条',
            emptyMsg: "没有数据"
        })
    });

});