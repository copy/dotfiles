"use strict";
// TODO:
// clear all useless crap


const {classes: Cc, interfaces: Ci, utils: Cu} = Components;
//const nsIEnvironment = Cc["@mozilla.org/process/environment;1"].getService(Ci.nsIEnvironment)
//const nsIStyleSheetService = Cc['@mozilla.org/content/style-sheet-service;1'].getService(Ci.nsIStyleSheetService)
//const nsIWindowWatcher = Cc["@mozilla.org/embedcomp/window-watcher;1"].getService(Ci.nsIWindowWatcher)
//const nsIXULRuntime = Cc['@mozilla.org/xre/app-info;1'].getService(Ci.nsIXULRuntime)
//const {OS} = Cu.import('resource://gre/modules/osfile.jsm')

Cu.import('resource://gre/modules/XPCOMUtils.jsm');
//XPCOMUtils.defineLazyModuleGetter(this, 'AddonManager', 'resource://gre/modules/AddonManager.jsm')
//XPCOMUtils.defineLazyModuleGetter(this, 'NetUtil', 'resource://gre/modules/NetUtil.jsm');
//XPCOMUtils.defineLazyModuleGetter(this, 'PlacesUtils', 'resource://gre/modules/PlacesUtils.jsm');
//XPCOMUtils.defineLazyModuleGetter(this, 'PopupNotifications', 'resource://gre/modules/PopupNotifications.jsm')
XPCOMUtils.defineLazyModuleGetter(this, 'Preferences', 'resource://gre/modules/Preferences.jsm');

// https://github.com/akhodakivskiy/VimFx/blob/master/extension/lib/defaults.coffee
// https://github.com/akhodakivskiy/VimFx/blob/master/documentation/config-file.md
// https://github.com/akhodakivskiy/VimFx/blob/master/documentation/api.md#configjs-api

// The <late> special key makes the shortcut in question run after the handling
// of keypresses in the current page, allowing the current page to override it.

vimfx.set('mode.normal.tab_select_previous', '<force><c-j>');
vimfx.set('mode.normal.tab_select_next', '<force><c-k>');
vimfx.set('mode.normal.history_back', '<force><c-o> H');
vimfx.set('mode.normal.history_forward', '<force><c-i> L');
vimfx.set('mode.normal.tab_restore', 'e');
//vimfx.set('mode.normal.tab_select_previous', 'e');

vimfx.set('mode.normal.tab_select_last', '<force><c-0>');
vimfx.set('mode.normal.tab_select_most_recent', 'v');

vimfx.set('mode.normal.find', '');
vimfx.set('mode.normal.find_highlight_all', '/ ?');

vimfx.set('mode.normal.stop', '');
vimfx.set('mode.normal.tab_toggle_pinned', 's');

vimfx.set('mode.normal.paste_and_go', '');
vimfx.set('mode.normal.paste_and_go_in_tab', 'p');

vimfx.set('mode.normal.copy_current_url', 'y');

//vimfx.set('mode.normal.tab_restore', '');
vimfx.set('custom.mode.normal.tab_close_and_move_left', 'X');
vimfx.addCommand(
    {
        name: 'tab_close_and_move_left',
        description: 'tab_close_and_move_left',
        category: 'tabs',
    },
    (vim, count) => {
        // XXX
        let tabs = Array.from(vim.vim.window.gBrowser.tabs);
        let index = tabs.indexOf(vim.vim.window.gBrowser.selectedTab);
        //console.assert(index >= 0);
        //console.log(index);
        //console.log(vim.vim.window.gBrowser.selectedTab);
        vim.vim.window.gBrowser.removeCurrentTab();
        //vim.vim.window.gBrowser.previousTab();
        vim.vim.window.gBrowser.selectTabAtIndex(Math.max(index - 1, 0));
    }
);

vimfx.set('prevent_autofocus', true);
vimfx.set('notify_entered_keys', true);


function selectTab(index, vim, count)
{
    let window = vim.vim.window;
    window.setTimeout(() => {
        //window.gBrowser.moveTabTo(window.gBrowser.selectedTab, count - 1)
        //console.log(window.gBrowser);
        window.gBrowser.selectTabAtIndex(index);
    }, 0);
}

[1, 2, 3, 4, 5, 6, 7, 8, 9].forEach(i => {
    let name = "abcdefghijk"[i]; // can't be numeric
    vimfx.addCommand(
        {
            name: 'tab_move_to_index_' + name,
            description: 'tab_move_to_index_' + name,
            category: 'tabs',
        },
        selectTab.bind(this, i - 1)
    );
    vimfx.set('custom.mode.normal.tab_move_to_index_' + name, '<force><c-' + i + '>');
});


vimfx.addCommand({
    name: 'goto_downloads',
    description: 'Downloads',
}, vim => {
    // vim.window.switchToTabHavingURI('about:downloads', true);
    vim.vim.window.DownloadsPanel.showDownloadsHistory();
});
vimfx.set('custom.mode.normal.goto_downloads', 'gd <f3>');

vimfx.addCommand({
    name: 'toggle_https',
    description: 'Toggle HTTPS',
    category: 'location',
}, vim => {
    let url = vim.vim.window.gBrowser.selectedBrowser.currentURI.spec;
    if (url.startsWith('http://')) {
        url = url.replace(/^http:\/\//, 'https://');
    } else if (url.startsWith('https://')) {
        url = url.replace(/^https:\/\//, 'http://');
    }
    vim.vim.window.gBrowser.loadURI(url);
});
vimfx.set('custom.mode.normal.toggle_https', 'gs');


vimfx.addCommand({
    name: 'view_source',
    description: 'View Source',
    category: 'location',
}, vim => {
    let url = vim.vim.window.gBrowser.selectedBrowser.currentURI.spec;
    if (url.startsWith('view-source:')) {
        url = url.substring('view-source:'.length);
    } else {
        url = 'view-source:' + url;
    }
    vim.vim.window.gBrowser.loadURI(url);
    //let tab = vim.vim.window.gBrowser.addTab(url);
    //vim.vim.window.gBrowser.selectedTab = tab;
});
vimfx.set('custom.mode.normal.view_source', 'gf');

vimfx.addCommand({
    name: 'toggle_mute',
    description: 'Toggle mute',
    category: 'location',
}, vim => {
    console.log(vim);
    console.log(vim.vim.window);
    console.log(vim.vim.window.gBrowser);
    console.log(vim.vim.window.gBrowser.selectedBrowser);

    let browser = vim.vim.window.gBrowser.selectedBrowser;
    browser.audioMuted ? browser.unmute() : browser.mute();
    //browser.unmute();
    //browser.mute();
});
vimfx.set('custom.mode.normal.toggle_mute', '<c-m>');


if(false) // broken
{
    vimfx.addCommand({
        name: 'toggle_bookmark',
        description: 'Toggle bookmark',
        category: 'location',
    }, vim => {
        let bookmarks = PlacesUtils.bookmarks;
        let url = vim.vim.window.gBrowser.selectedBrowser.currentURI.spec;
        //console.log(vim.vim.window.gBrowser);
        //console.log(vim.vim.window.gBrowser.selectedBrowser);
        //console.log(vim.vim.window.gBrowser.selectedBrowser.currentURI);
        let title = vim.vim.window.gBrowser.selectedBrowser._contentWindow.document.title;
        let uri = NetUtil.newURI(url, null, null);
        if (bookmarks.isBookmarked(uri)) {
            let ids = bookmarks.getBookmarkIdsForURI(uri);
            let last_id = ids[ids.length - 1];
            bookmarks.removeItem(last_id);
            vim.vim.notify('Bookmark Removed');
        }
        else
        {
            bookmarks.insertBookmark(
                bookmarks.unfiledBookmarksFolder,
                uri,
                bookmarks.DEFAULT_INDEX,
                title);
            vim.vim.notify('Bookmark Added: ' + title);
        }
    });
    vimfx.set('custom.mode.normal.toggle_bookmark', 'a');
}

vimfx.set('mode.normal.follow_multiple', '');
vimfx.set('mode.normal.element_text_select', '');
vimfx.set('mode.normal.reload_all', '');
vimfx.set('mode.normal.reload_all_force', '');
vimfx.set('mode.normal.stop_all', '');
vimfx.set('mode.normal.enter_mode_ignore', '');

//vimfx.set('mode.find.exit', '<escape>');



// Resources:
// https://github.com/amq/firefox-debloat

// restore last session
Preferences.set('browser.startup.page', 3);

Preferences.set('findbar.highlightAll', true);

// always load tabs (not just when clicking)
Preferences.set('browser.sessionstore.restore_on_demand', false);

Preferences.set('browser.shell.checkDefaultBrowser', false);
Preferences.set('layout.css.visited_links_enabled', false);
Preferences.set('browser.newtabpage.enabled', false);
//Preferences.set('network.http.sendRefererHeader', true);
Preferences.set('network.http.referer.spoofSource', true);
Preferences.set('browser.search.update', false);
Preferences.set('browser.aboutHomeSnippets.updateUrl', "");
Preferences.set('media.gmp-gmpopenh264.enabled', false);
Preferences.set('browser.search.suggest.enabled', false);
Preferences.set('browser.search.geoip.url', "");

Preferences.set('browser.safebrowsing.enabled', false);
Preferences.set('browser.safebrowsing.downloads.enabled', false);
Preferences.set('browser.safebrowsing.malware.enabled', false);

Preferences.set('browser.selfsupport.url', "");
Preferences.set('browser.newtabpage.directory.ping', "");
Preferences.set('browser.newtab.preload', false);
Preferences.set('browser.newtabpage.enhanced', false);
Preferences.set('datareporting.healthreport.service.enabled', false);
Preferences.set('datareporting.healthreport.uploadEnabled', false);
Preferences.set('toolkit.telemetry.enabled', false);
Preferences.set('toolkit.telemetry.unified', false);
Preferences.set('privacy.trackingprotection.enabled', true);
Preferences.set('browser.polaris.enabled', true);
Preferences.set('browser.send_pings', false);
Preferences.set('device.sensors.enabled', false);
Preferences.set('media.getusermedia.screensharing.enabled', false);
Preferences.set('media.webspeech.recognition.enable', false);
Preferences.set('dom.telephony.enabled', false);
Preferences.set('media.peerconnection.enabled', false);

Preferences.set('media.eme.enabled', false);
Preferences.set('media.gmp-eme-adobe.enabled', false);

Preferences.set('dom.battery.enabled', false);

// Firefox connects to third-party (Telefonica) servers without asking for permission.
Preferences.set('loop.enabled', false);

Preferences.set('browser.pocket.enabled', false);
Preferences.set('extensions.pocket.enabled', false);
Preferences.set('reader.parse-on-load.enabled', false);

// force acceleration (2016/03: Makes game faster, but causes some glitches and lags in general browsing)
//Preferences.set('layers.acceleration.force-enabled', true);

Preferences.set('geo.enabled', false);

// how long a script can run before the "kill script?" dialog appears
Preferences.set('dom.max_script_run_time', 5);

// disable alt key showing menu bar
// Note: Gets reset when hiding the menu
Preferences.set('ui.key.menuAccessKeyFocuses', false);
