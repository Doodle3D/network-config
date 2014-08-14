/*
 * TODO
 * - first! try to use the other dbus module...
 * - the code getService seems to call a Notify method?
 *
 * MODULES
 * - docs in the sidodares link contain some more refs to implementations, of which only this one has recent/many commits: https://github.com/Shouqun/node-dbus
 * - https://github.com/sidorares/node-dbus (114 commits, 1m old, native)
 * - https://github.com/Motorola-Mobility/node-dbus (38 commits, 9m old, more deps?)
 * - https://github.com/agnat/node_libdbus (20 commits, 4yrs old)
 * - https://github.com/ThinkDigital/node-msgbus (25 commits, 3yrs old)
 *
 * NOTES
 * - dbus intro: http://cheesehead-techblog.blogspot.nl/2012/08/dbus-tutorial-introspection-figuring.html
 * - *changing* wlan config: http://comments.gmane.org/gmane.linux.network.networkmanager.devel/21303
 * - api (readable): http://people.redhat.com/dcbw/NetworkManager/NetworkManager%20DBUS%20API.txt
 * - api (less readable, more complete): https://developer.gnome.org/NetworkManager/unstable/spec.html
 */
'use strict';

const DBus = require('dbus');

const dbus = new DBus();

const sysBus = dbus.getBus('system');

sysBus.getInterface('org.freedesktop.NetworkManager', '/org/freedesktop/NetworkManager', 'org.freedesktop.NetworkManager', function(err, iface) {
	if (err) {
		console.log('could get interface (' + err + ')');
		process.exit(1);
	}

	console.log('obtained interface');

	// iface.SomeMethod['timeout'] = 1000;
	// iface.SomeMethod['finish'] = function(obj) {
	// 	console.log(obj);
	// };
	// iface.SomeMethod();

	iface.getProperties(function(err, props) {
		if (err) console.log('error: ' + err);
		else console.log(props);
	});
});
