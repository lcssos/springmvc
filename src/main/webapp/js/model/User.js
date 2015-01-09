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
    validations: [
        {type: 'length', field: 'name', min: 2, max: 6},
        {type: 'age', field: "age", min: 0, max: 150}
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