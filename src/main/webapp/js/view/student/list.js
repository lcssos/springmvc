/**
 * Created by martin on 2015-01-06.
 */

Ext.define("springmvc.view.student.List", {
    extend: "Ext.grid.Panel",
    alias: "widget.student.list",
    title: "学生成绩列表",
    initComponent: function () {
        this.store = {
            fields: ['id', 'name', 'age', 'sex'],
            data: [
                {'id':1, 'name':'张三','age':12,'sex':'难'}
            ]
        };
        this.columns = [
            {header:"编号",dataIndex:"id",flex:1},
            {header:"姓名",dataIndex:"name",flex:1},
            {header:"年龄",dataIndex:"age",flex:1},
            {header:"性别",dataIndex:"sex",flex:1}
        ];
        this.callParent(arguments);
    }
});