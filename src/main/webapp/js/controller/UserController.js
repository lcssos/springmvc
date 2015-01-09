/**
 * Created by martin on 2015-01-09.
 */

Ext.define("My.controller.UserController",{
    extend:"Ext.app.Controller",
    init:function(){

        this.control({
            'userview button[id=btn_delete]':{
                click:function(o){
                    alert(o.text);
                }
            },
            'userview actioncolumn[id=act_delete]':{
                click:function(o,item,rowIndex,colIndex,e){
                    alert('xx');
                }
            }


        });
    },
    views:["UserView"],
    models:["User"],
    stores:["Users"]
});