/**
 * Created by martin on 2015-01-10.
 */

Ext.onReady(function () {
    /*    var labelArray = Ext.dom.Query.select("label");
     Ext.Array.each(labelArray, function (obj) {
     //Ext.create("Ext.form.Label", {renderTo: obj});
     });

     var txtArray = Ext.dom.Query.select("input[type=text]");
     Ext.Array.each(txtArray, function (obj) {
     //Ext.create("Ext.form.field.Text", {renderTo: obj});
     });*/

    /*    var divArray = Ext.dom.Query.select("div[class=form]");
     Ext.Array.each(divArray, function (obj) {
     Ext.create("Ext.form.Panel", {title:"标题",frame:true,renderTo: obj});
     });*/


    Ext.define("Person",{
       extend:"Ext.data.Model",
        fields:["name","password","email"]
    });

    var p = Ext.create("Person",{
        name:"张三",
        password:"fdfd",
        email:"12@123.com"
    });

    //扩展类
    Ext.apply(Ext.form.field.VTypes, {
        IPAddress:  function(v) {
            return /^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$/.test(v);
        },
        IPAddressText: 'Must be a numeric IP address',
        IPAddressMask: /[\d\.]/i,
        password:function(v){
            return /[123]/.test(v);
        },
        passwordText:"密码错误"
    });

    Ext.create("Ext.form.Panel", {
        title: "标题",
        bodyStyle: "padding:10px",
        frame: true,
        height: 200,
        width: 800,
        defaultType: "textfield",
        //Panel中的子控件的默认属性
        defaults: {
            labelSeparator: "：",
            labelWidth: 50,
            width: 200,
            msgTarget: "side"
        },
        renderTo: Ext.getBody(),
        items: [
            {
                fieldLabel: "姓名", name: "name", allowBlank: false
            }, {
                fieldLabel: "密码", name: "password",
                vtype:"password"
            },
            {
                fieldLabel: "邮件", name: "email",
                //regex: /\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/,
                //regexText: "必须输入邮件"
                vtype:"IPAddress"
            }
        ],
        buttons: [
            {
                text: "登录系统", handler: function (o) {
                //alert('x');
                alert(o.ownerCt.ownerCt.getForm().findField("name").getValue());
            }
            },{
                text:"装载数据",handler:function(o){
                    o.ownerCt.ownerCt.getForm().loadRecord(p);
                }
            }
        ]
    });

});