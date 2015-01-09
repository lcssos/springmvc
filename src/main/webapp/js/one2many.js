/**
 * Created by martin on 2015-01-08.
 */

Ext.onReady(function(){

    Ext.define("Student",{
        extend: "Ext.data.Model",
        fields:[
            {name:'id',type:'auto'},
            {name:'name',type:'auto'},
            {name:'teacher_id',type:"auto"}
        ]
    });

    //一个老师有多个学生
    Ext.define("Teacher",{
        extend: "Ext.data.Model",
        fields:[
            {name:'id',type:'auto'},
            {name:'name',type:'auto'},
        ],
        //一对多级联关系
        hasMany:{
            model:"Student",name:"students",filterProperty:"teacher_id"
        }
    });

    var t = Ext.create("Teacher",{
        id:"t1",
        name:"老师1"
    });

    var s1 = Ext.create("Student",{
        id:"s1",
        name:"学生1",
        teacher_id:"t1"
    });
    var s2 = Ext.create("Student",{
        id:"s2",
        name:"学生2",
        teacher_id:"t2"
    });

    //得到子类的数据集合store
   var s = t.students();

    debugger;

});