Ext.onReady(function() {
    Ext.QuickTips.init();

    var vp = new Ext.Viewport({
        layout: 'border',
        items: [
            {
                region: 'west',
                collapsible: true,
                title: '组织结构',
                xtype: 'treepanel',
                width: 200,
                autoScroll: true,
                split: true,
                loader: new Ext.tree.TreeLoader({
                  url:'/yat/query/group',
                  requestMethod:'GET',
                  baseParams:{format:'json'}
                }),
                root: new Ext.tree.AsyncTreeNode({
                    id: '0',
                    text: '*****',
                    expanded: true
                }),
                rootVisible: false,
                listeners: {
                    click: function(n) {
//			Ext.getCmp('my-grid').store.load({params: {id: n.attributes.id}});
                        Ext.Msg.alert('Navigation Tree Click', 'You clicked: "' + n.attributes.text + '"');
                    }
                }
            },
            {
                region: 'center',
                xtype: 'tabpanel'
            }
        ]
    });
});