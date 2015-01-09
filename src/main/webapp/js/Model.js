Ext.onReady(function () {

    Ext.data.validations.lengthMessage = "长度不正确";

    //自定义验证器
    Ext.apply(Ext.data.validations,{
        age:function(config,value){
            if(value < config.min || value > config.max){
                return false;
            }else{
                return true;
            }
        },
        ageMessage : "年龄不正确"
    });

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
            {type: 'length', field: 'name', min: 2,max:6},
            {type:'age',field:"age",min:0,max:150}
        ]
    });

    // 被弃用，不推荐使用
    Ext.regModel("User", {
        fields: [{
            name: 'name',
            type: 'auto'
        }, {
            name: 'age',
            type: 'int'
        }, {
            name: 'id',
            type: 'auto'
        }]
    });


    var p = Ext.create("Person", {
        name: "张三张三张",
        age: 160
    });
    //alert(p.get('email'));


    var errors = p.validate();
    if(!errors.isValid()){
        errors.each(function(v){
            alert(v.field +'-->' + v.message);
        });
    }


});