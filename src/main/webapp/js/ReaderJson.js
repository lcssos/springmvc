/**
 * Created by martin on 2015-01-08.
 */

Ext.onReady(function () {


    var userData = {
        total: 200,
        user: {
            userID: "1",
            name: "xx",
            orders: [
                {id: "001", name: "pen"}
            ]
        }
    };

    Ext.define("User", {
        extend: "Ext.data.Model",
        fields: [
            {name: "userID", type: "auto"},
            {name: "name", type: "auto"}
        ]
    });

    Ext.define("Order", {
        extend: "Ext.data.Model",
        fields: [
            {
                name: "id", type: "auto"
            }
            ,
            {
                name: "name", type: "auto"
            }
        ],
        belongsTo: {type: "belongsTo", type: "User"}
    });

    //创建一个内存代理
    var proxy = Ext.create("Ext.data.proxy.Memory",{
        model:"User",
        data:userData
    });



})
;