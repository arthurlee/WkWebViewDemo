//
// WKWebView注入模板
// IBUser对象
//

// IBUser对象

window.IBUser = {
	user_id: 	'{{user_id}}',
	device_no:	'{{device_no}}',
	session_id: '{{session_id}}'
};

// 属性方法

var properties = {
	getUserID: 			'user_id',
	getDeviceNo: 		'device_no',
	getSessionID:		'session_id'
};

Object.getOwnPropertyNames(properties).forEach(function(name) {
	window.IBUser[name] = function() {
		return window.IBUser[properties[name]];
	}
});


// 通用的发送消息函数
window.IBUser.getPostMessage = function(name) {
	return function(params) {
		var obj = params;
		if (typeof params === 'string') {
			obj = JSON.parse(params);
		}
		obj.method = name;
		
		window.webkit.messageHandlers.ibuick.postMessage(obj);
	};
};

// 方法别名
var methods = ['share', 'praise'];
methods.forEach(function(name) {
	window.IBUser[name] = window.IBUser.getPostMessage(name);
});

// 给网页一个初始化的机会
window.IBUserReady && window.IBUserReady();
