# This is useful:
# qute://settings
# https://qutebrowser.org/doc/help/settings.html
# https://peter.sh/experiments/chromium-command-line-switches/

# TODO:
# - Force fonts
# - Disable JavaScript by default and override it per top-level domain, show status in tab title

config.load_autoconfig()

c.aliases["qa"] = "quit"

#config.bind("d", "scroll-page 0 0.5")
#config.bind("u", "scroll-page 0 -0.5")
#config.bind("d", "repeat 10 scroll down")
config.bind("d", "run-with-count 10 scroll down")
#config.bind("u", "repeat 10 scroll up")
config.bind("u", "run-with-count 10 scroll up")

#config.bind("j", "repeat 3 scroll down")
config.bind("j", "run-with-count 3 scroll down")
#config.bind("k", "repeat 3 scroll up")
config.bind("k", "run-with-count 3 scroll up")

config.bind("<Control-o>", "back")
config.bind("<Control-i>", "forward")

config.bind("t", "set-cmd-text -s :open -t ")
config.bind("x", "tab-close")
config.bind("e", "undo")
config.bind("<ctrl-j>", "tab-prev")
config.bind("<ctrl-k>", "tab-next")

config.bind("<ctrl-1>", "tab-focus 1")
config.bind("<ctrl-2>", "tab-focus 2")
config.bind("<ctrl-3>", "tab-focus 3")
config.bind("<ctrl-4>", "tab-focus 4")
config.bind("<ctrl-5>", "tab-focus 5")
config.bind("<ctrl-6>", "tab-focus 6")
config.bind("<ctrl-7>", "tab-focus 7")

config.bind("O", "set-cmd-text :open {url:pretty}")

config.bind("s", "tab-pin")
config.bind("p", "open -t -- {clipboard}")
config.bind("v", "tab-focus last")

config.bind("<ctrl-w>", "rl-backward-kill-word", mode="command")

config.bind("<ctrl-m>", "tab-mute")

font = "9pt DejaVu Sans Mono"
c.fonts.completion.category = font
c.fonts.completion.entry = font
c.fonts.statusbar = font
c.fonts.tabs = font
c.fonts.hints = font
c.fonts.debug_console = font
c.fonts.messages.error = font
c.fonts.messages.warning = font
c.fonts.messages.info = font
c.fonts.downloads = font
c.fonts.keyhint = font

c.scrolling.smooth = True
c.tabs.title.format = "{perc}{audio}{index}: {title}"

# never let javascript ask for stupid features
c.content.geolocation = False
c.content.desktop_capture = False
c.content.notifications = False
c.content.media_capture = False
c.content.register_protocol_handler = False


# contains piwik.org (?) by default
c.content.host_blocking.whitelist = []

c.colors.hints.bg = "rgb(255, 197, 66)"

c.url.searchengines = {
    #"DEFAULT": "https://encrypted.google.com/search?q={}",
    #"DEFAULT": "https://duckduckgo.com/?q={}",
    "DEFAULT": "https://duckduckgo.com/html/?q={}", # version without javascript
    #"DEFAULT": "https://www.startpage.com/do/dsearch?query={}",
}
c.url.start_pages = ["about:blank"]

c.auto_save.session = True

c.content.user_stylesheets = ["override.css"]

c.qt.args = ["disable-remote-fonts"]
#c.qt.highdpi = True

#c.input.spatial_navigation = True

# This only sets the default font, doesn't force it
#c.fonts.web.family.cursive = "DejaVu Sans Mono"
#c.fonts.web.family.fantasy = "DejaVu Sans Mono"
#c.fonts.web.family.fixed = "DejaVu Sans Mono"
#c.fonts.web.family.sans_serif = "DejaVu Sans Mono"
#c.fonts.web.family.serif = "DejaVu Sans Mono"
#c.fonts.web.family.standard = "DejaVu Sans Mono"
