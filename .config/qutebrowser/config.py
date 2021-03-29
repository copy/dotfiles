# This is useful:
# qute://settings
# https://qutebrowser.org/doc/help/settings.html
# https://peter.sh/experiments/chromium-command-line-switches/

# TODO:
# - Force fonts
# - Disable JavaScript by default and override it per top-level domain, show status in tab title


#config.set('content.images', False, '*://example.com/')
#with config.pattern('*://example.com/') as p:
#    p.content.images = False

config.load_autoconfig()

c.aliases["qa"] = "quit"

def bind_all_modes(key, command):
    config.bind(key, command)
    config.bind(key, command, mode="insert")

#config.bind("d", "scroll-page 0 0.5")
#config.bind("u", "scroll-page 0 -0.5")

config.bind("d", "run-with-count 10 scroll down")
config.bind("<ctrl-d>", "run-with-count 10 scroll down")
config.bind("u", "run-with-count 10 scroll up")
config.bind("<ctrl-u>", "run-with-count 10 scroll up")

#config.bind("j", "repeat 3 scroll down")
#config.bind("j", "run-with-count 3 scroll down")
#config.bind("k", "repeat 3 scroll up")
#config.bind("k", "run-with-count 3 scroll up")

bind_all_modes("<ctrl-o>", "back")
bind_all_modes("<ctrl-i>", "forward")

config.bind("t", "set-cmd-text -s :open -t ")
config.bind("x", "tab-close")
config.bind("e", "undo")
bind_all_modes("<ctrl-j>", "tab-prev")
bind_all_modes("<ctrl-k>", "tab-next")

bind_all_modes("<ctrl-1>", "tab-focus 1")
bind_all_modes("<ctrl-2>", "tab-focus 2")
bind_all_modes("<ctrl-3>", "tab-focus 3")
bind_all_modes("<ctrl-4>", "tab-focus 4")
bind_all_modes("<ctrl-5>", "tab-focus 5")
bind_all_modes("<ctrl-6>", "tab-focus 6")
bind_all_modes("<ctrl-7>", "tab-focus 7")
bind_all_modes("<ctrl-8>", "tab-focus 8")
bind_all_modes("<ctrl-9>", "tab-focus 9")
bind_all_modes("<ctrl-0>", "tab-focus -1")

config.bind("<insert>", "mode-enter passthrough")
config.bind("<insert>", "mode-leave", mode="passthrough")
config.unbind("<ctrl-v>") # default maps to passthrough mode

config.bind("O", "set-cmd-text :open {url:pretty}")

config.bind("s", "tab-pin")
config.bind("p", "open -t -- {clipboard}")
config.bind("v", "tab-focus last")

config.bind("<ctrl-w>", "rl-backward-kill-word", mode="command")

config.bind("<ctrl-m>", "tab-mute")

font_family = "DejaVu Sans Mono"
font_family = "PragmataPro Mono"
font = "9pt " + font_family
bigfont = "11pt " + font_family
c.fonts.completion.category = font
c.fonts.completion.entry = font
c.fonts.statusbar = font
c.fonts.tabs.selected = bigfont
c.fonts.tabs.unselected = bigfont
c.fonts.hints = font
c.fonts.debug_console = font
c.fonts.messages.error = font
c.fonts.messages.warning = font
c.fonts.messages.info = font
c.fonts.downloads = font
c.fonts.keyhint = font

c.scrolling.smooth = True
c.tabs.title.format = "{perc}{audio}{index}: {current_title}"
c.tabs.background = True

# never let javascript ask for stupid features
c.content.geolocation = False
c.content.desktop_capture = False
c.content.notifications = False
#c.content.media_capture = False
c.content.register_protocol_handler = False
c.content.pdfjs = True
c.content.headers.do_not_track = None

c.content.cookies.accept = "no-3rdparty"


# contains piwik.org (?) by default
c.content.blocking.whitelist = []

c.colors.hints.bg = "rgb(255, 197, 66)"


c.url.searchengines = {
    #"DEFAULT": "https://encrypted.google.com/search?q={}",
    #"DEFAULT": "https://duckduckgo.com/?q={}",
    "DEFAULT": "https://duckduckgo.com/html/?q={}", # version without javascript
    #"DEFAULT": "https://www.startpage.com/do/dsearch?query={}",
}
c.url.start_pages = ["about:blank"]
c.url.default_page = "about:blank"

c.auto_save.session = True
c.session.lazy_restore = True

c.content.user_stylesheets = ["override.css"]

#c.qt.args = ["disable-remote-fonts"]
#c.qt.highdpi = True

#c.input.spatial_navigation = True

# This only sets the default font, doesn't force it
#c.fonts.web.family.cursive = "DejaVu Sans Mono"
#c.fonts.web.family.fantasy = "DejaVu Sans Mono"
#c.fonts.web.family.fixed = "DejaVu Sans Mono"
#c.fonts.web.family.sans_serif = "DejaVu Sans Mono"
#c.fonts.web.family.serif = "DejaVu Sans Mono"
#c.fonts.web.family.standard = "DejaVu Sans Mono"
