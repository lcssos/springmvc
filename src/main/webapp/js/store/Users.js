/**
 * Created by martin on 2015-01-08.
 */

Ext.define("My.store.Users",{
    extend:"Ext.data.Store",
    storeId:"s_user",
    model:"My.model.User",
    autoLoad: true,
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
});