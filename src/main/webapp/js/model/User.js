/**
 * Created by martin on 2015-01-08.
 */

Ext.define("My.model.User", {
    extend: "Ext.data.Model",
    fields: [{
        name: 'id',
        type: 'string'
    }, {
        name: 'name',
        type: 'string'
    }, {
        name: 'age',
        type: 'int'
    } , {
            name: 'birthday',
            type: 'string'
        } , {
            name: 'isIt',
            type: 'string'
        }
    ],
    proxy: {
        type: 'ajax',
        api: {
            create: 'admin/user/save',
            read: 'admin/user/get',
            update: 'admin/user/save',
            destroy: 'admin/user/delete'
        }
    }
});