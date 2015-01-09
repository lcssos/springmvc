/**
 * Created by martin on 2015-01-07.
 */

Ext.onReady(function () {


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
        }],
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

    Person.load("402823814ac4b55d014ac4b646fe0000", {
        scope: this,
        success: function (record, operation) {
            //alert(record.data.name);

            alert(record.get('name'));

            record.save();

        },
        failure: function (record, operation) {
            //do something if the load failed
        },
        callback: function (record, operation) {
            //do something whether the load succeeded or failed
        }

    });

    /*    var p = Ext.ModelManager.getModel("Person");
     p.load(1,{
     scope:this,
     success:function(record, operation){
     alert(record.data.name);
     //debugger;
     }
     });*/


});