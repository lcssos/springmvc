/**
 * Created by martin on 2015-01-07.
 */

Ext.create('Ext.Viewport', {
    layout: 'border',
    title: 'Ext Layout Browser',
    items: [{
        xtype: 'box',
        id: 'header',
        region: 'north',
        html: '<h1> Ext.Layout.Browser</h1>',
        height: 30
    },{
        layout: 'border',
        id: 'layout-browser',
        region:'west',
        border: false,
        split:true,
        margins: '2 0 5 5',
        width: 290,
        minSize: 100,
        maxSize: 500
    }
    ],
    renderTo: Ext.getBody()
});