Ext.onReady(function() {
    Ext.QuickTips.init();

    // Create a variable to hold our EXT Form Panel.
    // Assign various config options as seen.
    var login = new Ext.FormPanel({
        labelWidth:80,
        url:'/yat/security/login',
        frame:true,
        title:'请输入用户名和密码',
        defaultType:'textfield',
        monitorValid:true,
        // Specific attributes for the text fields for username / password.
        // The "name" attribute defines the name of variables sent to the server.
        items:[
            {
                fieldLabel:'用户名',
                name:'loginUsername',
                allowBlank:false
            },
            {
                fieldLabel:'密码',
                name:'loginPassword',
                inputType:'password',
                allowBlank:false
            }
        ],

        // All the magic happens after the user clicks the button
        buttons:[
            {
                text:'登录',
                formBind: true,
                // Function that fires when user clicks the button
                handler:function() {
                    login.getForm().submit({
                        method:'POST',
                        waitTitle:'Connecting',
                        waitMsg:'Sending data...',

                        // Functions that fire (success or failure) when the server responds.
                        // The one that executes is determined by the
                        // response that comes from login.asp as seen below. The server would
                        // actually respond with valid JSON,
                        // something like: response.write "{ success: true}" or
                        // response.write "{ success: false, errors: { reason: 'Login failed. Try again.' }}"
                        // depending on the logic contained within your server script.
                        // If a success occurs, the user is notified with an alert messagebox,
                        // and when they click "OK", they are redirected to whatever page
                        // you define as redirect.

                        success:function(form, action) {
                            Ext.Msg.alert('Status', '登录成功!', function(btn, text) {
                                if (btn == 'ok') {
                                    obj = Ext.util.JSON.decode(action.response.responseText);
                                    var redirect = obj.uri;
                                    window.location = redirect;
                                }
                            });
                        },

                        // Failure function, see comment above re: success and failure.
                        // You can see here, if login fails, it throws a messagebox
                        // at the user telling him / her as much.

                        failure:function(form, action) {
                            if (action.failureType == 'server') {
                                obj = Ext.util.JSON.decode(action.response.responseText);
                                Ext.Msg.alert('登录失败!', obj.errors.reason);
                            } else {
                                Ext.Msg.alert('Warning!', 'Authentication server is unreachable : ' + action.response.responseText);
                            }
                            login.getForm().reset();
                        }
                    });
                }
            }
        ]
    });


    // This just creates a window to wrap the login form.
    // The login object is passed to the items collection.
    var win = new Ext.Window({
        layout:'fit',
        width:300,
        height:150,
        closable: false,
        resizable: false,
        plain: true,
        border: false,
        items: [login]
    });
    win.show();
});