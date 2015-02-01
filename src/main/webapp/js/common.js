Ext.define('WK.CommonButton', {
    extend: 'Ext.Button'
    , width: 60
    , height: 32
    , margin: '5px 0'
    , xtype: 'npacsbutton'
});
Ext.define('WK.CustomToolbar', {
    extend: 'Ext.toolbar.Toolbar'
    , border: false
    , defaultButtonUI: 'default'
    , xtype: 'customToolbar'
});

Ext.define('WK.ForceTextField', {
    extend: 'Ext.form.field.Text'
    , allowBlank: false
    , afterLabelTextTpl: '<span style="color:#ff0000;font-weight:bold" data-qtip="Required">*</span>'
    , xtype: 'forcetextfield'
});

Ext.define('WK.ForceComboBoxField', {
    extend: 'Ext.form.field.ComboBox'
    , allowBlank: false
    , afterLabelTextTpl: '<span style="color:red;font-weight:bold" data-qtip="Required">*</span>'
    , xtype: 'forcecombobox'
});

var WK = {
    basePath: "/springmvc",
    tip: function (h, msg) {
        new Ext.ToolTip({html: msg, target: h});
        h.style.cursor = 'pointer';
    }
}

function formFindItem(form,index){
    return form.getForm().getFields().getAt(index);
}