/**
 * Created by martin on 2015-01-10.
 */


Ext.define("Martin.model.Table", {
    extend: "Ext.data.Model",
    fields: [{
        name: 'id',
        type: 'string'
    }, {
        name: 'name',
        type: 'string'
    }, {
        name: 'title',
        type: 'string'
    } , {
        name: 'rownumber',
        type: 'boolean'
    }
    ],
    proxy: {
        type: 'ajax',
        api: {
            create: 'design/table/save',
            read: 'design/table/get',
            update: 'design/table/save',
            destroy: 'design/table/delete'
        }
    }
});