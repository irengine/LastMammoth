Ext.onReady(function() {
    Ext.QuickTips.init();

    var navigatorPanel = new Ext.tree.TreePanel({
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
        root: new Ext.tree.AsyncTreeNode(),
        rootVisible: false,
        listeners: {
            click: function(n) {
                //			Ext.getCmp('my-grid').store.load({params: {id: n.attributes.id}});
                Ext.Msg.alert('Navigation Tree Click', 'You clicked: "' + n.attributes.id + '"');
            }
        }
    });
//
//    var handleAction = function(action) {
//        Ext.Msg.alert('You clicked "' + action + '"');
//    };

    var contentPanel = {
        region: 'center',
        title: '员工列表'
    };

    var vp = new Ext.Viewport({
        layout: 'border',
        items: [
            navigatorPanel,
            contentPanel
        ]
    });
});