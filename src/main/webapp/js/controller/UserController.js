/**
 * Created by martin on 2015-01-09.
 */

Ext.define("My.controller.UserController",{
    extend:"Ext.app.Controller",
    init:function(){

        this.control({
            //表格中的单元格的编辑事件
            'userview':{
                edit:function(editor,e){
                    //e.record.commit();
                }
            },
            //表格工具栏中增加保存按钮
            'userview button[id=btn_save]':{
                click:function(o){
                    var grid = o.ownerCt.ownerCt;
                    var st = grid.getStore();
                    st.sync();
                    var records = st.getUpdatedRecords();
                    Ext.Array.each(records,function(model){
                        model.save();
                        model.commit();
                    });

                }
            },
            //工具栏中的操作按钮点击事件
            'userview button[id=btn_delete]':{
                click:function(o){
                    alert(o.text);
                }
            },
            //列中的操作按钮点击事件
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