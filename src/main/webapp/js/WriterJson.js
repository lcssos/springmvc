Ext.define('Canna.mixins.GridUtil', {
    onAfterrender: function () {
        varme = this;
        if (!this.getStore && !this.getStore()) {
            return;
        }
        this.showLoadingMark();
        this.getStore().load({
            callback: function () {
                me.hideLoadingMark();
            }
        });
    },
    onSelectionchange: function (sm, selections) {
        this.view.panel.down('#removeButton').setDisabled(selections.length == 0);
    },
    onAddHandler: function () {
        varpanel = this.up('gridpanel');
        varstore = panel.getStore();
        if (store.storeId == 'ext-empty-store') {
            store = Ext.create('Ext.data.Store', {model: 'Ext.data.Model', fields: [], proxy: 'memory'});
            panel.bindStore(store);
        }
        varmodel = store.model;
        varr = Ext.create(model, {});
        panel.getStore().insert(0, r);
        if (panel.rowEditingAble) {
            varrowEditing = panel.getEditPlugin();
            rowEditing.cancelEdit();
            rowEditing.startEdit(0, 0);
        }
    },
    onDeleteHandler: function () {
        vargrid = this.up('gridpanel');
        varrecords = grid.getSelectionModel().getSelection();
        Ext.MessageBox.confirm('Confirm', '请确定删除!', function (buttonId) {
            if (buttonId == 'yes') {
                grid.getStore().remove(records);
            }
        });
    },
    showLoadingMark: function () {
        this.loadingMark = this.loadingMark || newExt.LoadMask(this, {msg: 'loading...'});
        this.loadingMark.show();
    },
    hideLoadingMark: function () {
        this.loadingMark.hide();
    },
    getEditPlugin: function () {
        returnthis.getPlugin(this._pluginId);
    },
    addRowEditPlugin: function () {
        varme = this;
        me._pluginId = 'rowEditing' + Math.random();
        varrowEditing = Ext.create('Ext.grid.plugin.RowEditing', {
            clicksToEdit: 2,
            autoCancel: true,
            pluginId: me._pluginId
        });
        me.plugins = [rowEditing];
    }
});//extend类
Ext.define('Canna.view.BaseGridPanel', {
    extend: 'Ext.grid.Panel',
    alias: 'widget.baseGridPanel',
    mixins: ['Canna.mixins.GridUtil'],
    initComponent: function () {
        //rowEditingAble
        // checkboxModelAble
        // simpleDockAble
        // autoLoadStore
        var me = this;
        if (this.rowEditingAble) {
            this.addRowEditPlugin();
        }
        if (this.autoLoadStore) {
            this.addListener('afterrender', me.onAfterrender);
        }
        if (this.checkboxModelAble) {
            this.selModel = Ext.create('Ext.selection.CheckboxModel', {
                listeners: {
                    selectionchange: me.onSelectionchange
                }
            });
        }
        if (this.simpleDockAble) {
            this.dockedItems = [{
                xtype: 'toolbar',
                items: [{
                    text: '添加', iconCls: 'add', handler: me.onAddHandler
                }, '-', {
                    itemId: 'removeButton',
                    text: '删除',
                    iconCls: 'remove',
                    disabled: true,
                    handler: me.onDeleteHandler
                }]
            }];
        }
        this.callParent(arguments);
    }
});