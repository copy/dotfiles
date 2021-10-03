// https://github.com/ghacksuserjs/ghacks-user.js/
// https://github.com/pyllyukko/user.js

user_pref("browser.chrome.site_icons", true);
user_pref("accessibility.browsewithcaret_shortcut.enabled", false);
user_pref("accessibility.typeaheadfind.autostart", true);
user_pref("browser.display.use_document_fonts", 0);
user_pref("browser.search.suggest.enabled", false);
user_pref("browser.urlbar.suggest.searches", false);
user_pref("browser.urlbar.suggest.engines", false);
user_pref("browser.urlbar.groupLabels.enabled", false);
user_pref("browser.search.update", false);
user_pref("browser.startup.homepage", "about:blank");
user_pref("browser.newtabpage.enabled", false);
user_pref("browser.startup.page", 3); // resume last session
user_pref("browser.tabs.closeWindowWithLastTab", false);
user_pref("browser.tabs.crashReporting.sendReport", false);
user_pref("browser.tabs.closeWindowWithLastTab", false);
user_pref("browser.tabs.warnOnClose", false);
user_pref("toolkit.tabbox.switchByScrolling", true);
user_pref("browser.urlbar.clickSelectsAll", true);
user_pref("browser.urlbar.delay", 0);
user_pref("ui.key.menuAccessKeyFocuses", false);
user_pref("browser.zoom.full", true); // false: Only zoom text
user_pref("general.autoScroll", true);
user_pref("middlemouse.paste", false);
user_pref("browser.cache.disk.enable", false);
user_pref("browser.sessionstore.max_tabs_undo", 1000);
user_pref("network.protocol-handler.external.mailto", false); // disable "add as an application for mailto links" popup in outlook

// smoother scrolling: https://twitter.com/tumult/status/1183452749171585024
user_pref("general.smoothScroll.msdPhysics.enabled", true);
user_pref("general.smoothScroll.msdPhysics.motionBeginSpringConstant", 2500);
user_pref("general.smoothScroll.msdPhysics.regularSpringConstant", 2500);
user_pref("general.smoothScroll.msdPhysics.slowdownSpringConstant", 2500);

user_pref("browser.urlbar.ctrlCanonizesURLs", false);

user_pref("extensions.formautofill.addresses.enabled", false);
user_pref("extensions.formautofill.available", "off");
user_pref("extensions.formautofill.creditCards.enabled", false);
user_pref("extensions.formautofill.heuristics.enabled", false);

user_pref("signon.autofillForms", false); // use right-click to fill login

// https://wiki.mozilla.org/Media/getUserMedia
user_pref("media.navigator.enabled", false); // disable media device enumeration
user_pref("media.peerconnection.enabled", false); // disables webrtc; may want to undo

user_pref("media.getusermedia.screensharing.enabled", false);
user_pref("media.getusermedia.browser.enabled", false);
user_pref("media.getusermedia.audiocapture.enabled", false);
user_pref("geo.enabled", false);
user_pref("geo.wifi.uri", "");
user_pref("permissions.default.geo", 2);
user_pref("browser.search.geoip.url", "");

user_pref("browser.aboutConfig.showWarning", false);
user_pref("browser.shell.checkDefaultBrowser", false);

user_pref("dom.battery.enabled", false);

user_pref("browser.send_pings", false);
user_pref("browser.selfsupport.enabled", false);
user_pref("beacon.enabled", false);

// recommendations
user_pref("extensions.getAddons.showPane", false);
user_pref("extensions.htmlaboutaddons.recommendations.enabled", false);

user_pref("plugin.state.flash", 0);
user_pref("media.gmp-widevinecdm.visible", false);
user_pref("media.gmp-widevinecdm.enabled", false);
user_pref("media.eme.enabled", false);

user_pref("dom.serviceWorkers.enabled", false);
user_pref("dom.push.enabled", false); // mozilla's push server
user_pref("dom.push.userAgentID", "");

user_pref("dom.targetBlankNoOpener.enabled", true);

user_pref("browser.pagethumbnails.capturing_disabled", true);

// this delay is extremely annothing when using a window manager with autofocus
user_pref("security.dialog_enable_delay", 0);

user_pref("browser.cache.offline.enable", false);

// telemtry
user_pref("toolkit.telemetry.unified", false);
user_pref("toolkit.telemetry.enabled", false);
user_pref("toolkit.telemetry.server", "data:,");
user_pref("toolkit.telemetry.archive.enabled", false);
user_pref("toolkit.telemetry.newProfilePing.enabled", false);
user_pref("toolkit.telemetry.shutdownPingSender.enabled", false);
user_pref("toolkit.telemetry.updatePing.enabled", false);
user_pref("toolkit.telemetry.bhrPing.enabled", false);
user_pref("toolkit.telemetry.firstShutdownPing.enabled", false);
user_pref("toolkit.telemetry.coverage.opt-out", true);
user_pref("toolkit.coverage.opt-out", true);
user_pref("toolkit.coverage.endpoint.base", "");
user_pref("datareporting.healthreport.uploadEnabled", false);
user_pref("datareporting.policy.dataSubmissionEnabled", false);
user_pref("app.shield.optoutstudies.enabled", false);
user_pref("browser.discovery.enabled", false);
user_pref("breakpad.reportURL", "");
user_pref("browser.tabs.crashReporting.sendReport", false);
user_pref("browser.crashReports.unsubmittedCheck.enabled", false);
user_pref("browser.crashReports.unsubmittedCheck.autoSubmit2", false);
user_pref("captivedetect.canonicalURL", "");
user_pref("network.captive-portal-service.enabled", false);
user_pref("network.connectivity-service.enabled", false);

user_pref("extensions.webcompat-reporter.enabled", false);

// normandy/shield/experiments
user_pref("app.normandy.enabled", false);
user_pref("app.normandy.api_url", "");
user_pref("extensions.systemAddon.update.enabled", false);

user_pref("browser.safebrowsing.downloads.remote.enabled", false);
user_pref("browser.safebrowsing.downloads.remote.url", "");

user_pref("browser.fixup.alternate.enabled", false); // don't prepend www. or append .com
user_pref("browser.urlbar.trimURLs", false); // show full url
