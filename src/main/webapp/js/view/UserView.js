/**
 * Created by martin on 2015-01-09.
 */

Ext.define("My.view.UserView", {
    extend: "Ext.grid.Panel",
    //alias:"widget.userlist",
    alias: "widget.userview",
    frame: true,     //填充
    width: '90%',
    height: 500,
    selType: "checkboxmodel",       //增加选择框
    plugins: [{ptype: 'cellediting', clicksToEdit: 1}],
    //field与plugin一起，启用编辑模式
    columns: [
        Ext.create("Ext.grid.RowNumberer", {}),
        {text: "id", dataIndex: "id", width: 250},
        {
            text: "姓名", dataIndex: "name", width: 100, field: {
            xtype: "textfield",
            allowBlank: false
        }
        },
        {
            text: "年龄", dataIndex: "age", width: 100, field: {
            xtype: "numberfield",
            summaryType: 'average',
            summaryRenderer: function(value, summaryData, dataIndex) {
                //alert(value);
                //return Ext.String.format('平均年龄是：{0}', value);
                return value;
            }
        }
        }, {
            xtype: "booleancolumn",
            text: "IT人员",
            width: 50,
            dataIndex: "isIt",
            trueText: "是",
            falseText: "否"
        }, {
            text: "生日",
            dataIndex: "birthday",
            width: 150,
            xtype: 'datecolumn',
            format: 'U'
        },
        {xtype: "templatecolumn", tpl: "用户的姓名是{name}，年龄是{age}", width: 200},
        {
            xtype: 'actioncolumn',
            width: 50,
            text: "操作",
            items: [
                {
                    id: 'act_delete',
                    iconCls: 'table_edit',
                    tooltip: '编辑'/*,
                 handler:function(grid,row,col){
                 alert("f");
                 }*/
                }
            ]
        }
    ],
    tbar: [
        {
            xtype: "button", text: "添加", iconCls: "table_add", handler: function (button) {
            alert("add");
        }
        },
        {xtype: "button", text: "修改", iconCls: "table_edit"}, "-",
        {xtype: "button", text: "删除", id: "btn_delete", iconCls: "table_delete"}, "->",
        {
            xtype: "button", text: "查看", iconCls: "table_add", handler: function (o) {

            var grid = o.ownerCt.ownerCt;          //获取grid
            var sm = grid.getSelectionModel();     //获取选择器
            //sm.deselect(0);
            var data = sm.getSelection();          //获取选择的Model数组
            sm.getLastSelected();                   //获取最后被选中的数据
            alert(sm.isSelected(0));                //判断指定行是否被选中
            sm.selectRange(2, 3);                    //选中指定的行

        }
        }
    ],
    bbar: {
        xtype: "pagingtoolbar",
        store: "Users",
        displayInfo: true
    },
    store: "Users",
    initComponent: function () {
        this.callParent(arguments);
    },
    features: [
        {
            ftype: 'summary'/*,
            getAdditionalData: function (data, rowIndex, record, orig) {
                var headerCt = this.view.headerCt,
                    colspan = headerCt.getColumnCount();
                return {
                    rowBody: '<div style="padding: 1em">' + record.get("id") + '</div>',
                    rowBodyCls: "my-body-class",
                    rowBodyColspan: colspan
                };
            }*/
        }]
});