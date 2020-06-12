# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

from os import path
from os import listdir
import json

from libqtile.config import Key, Screen, Group, Drag, Click
from libqtile.lazy import lazy
from libqtile import layout, bar, widget

from typing import List  # noqa: F401


# Configuration of thems: material-darker, dracula
qtile_path = path.join(path.expanduser("~"), ".config", "qtile")
theme = "dracula"
theme_path = path.join(qtile_path, "themes", theme)

# Colors of theme
with open(path.join(theme_path, "colors.json")) as f:
    colors = json.load(f)

# Icon of theme
img = {}
img_path = path.join(theme_path, "img")
icon_layout = path.join(qtile_path, "icons")

for i in listdir(img_path):
    img[i.split(".")[0]] = path.join(img_path, i)


mod = "mod4"
myTerm="/usr/bin/urxvt"
myIDE="/usr/bin/idea/bin/idea.sh"


keys = [
    Key(
        [mod], "k",
        lazy.layout.down(),
        desc='Switch between windows in current stack pane'
        ),
    Key(
        [mod], "j",
        lazy.layout.up(),
        desc='Switch between windows in current stack pane'
        ),
    Key(
        [mod, "control"], "k", 
        lazy.layout.section_up(),
        desc='Move up a section treetab'
        ),
    Key(
        [mod, "control"], "j", 
        lazy.layout.shuffle_up(),
        desc='Move down a section treetab'
        ),
    Key(
        [mod], "space",
        lazy.layout.next(),
        desc='Switch window focus to other pane(s) of stack'
        ),
    Key(
        [mod, "shift"], "space",
        lazy.layout.rotate(),
        desc='Swap panes of split stack'
        ),
    Key(
        [mod, "shift"], "Return",
        lazy.layout.toggle_split(),
        desc='Toogle between split and unsplit sides of layouts'
        ),
    Key(
        [mod], "Return",
        lazy.spawn(myTerm),
        desc='Launches My terminal with URXVT'
        ),
    Key(
        [mod], "Tab",
        lazy.next_layout(),
        desc='Toggle through layouts'
        ),
    Key(
        [mod], "w",
        lazy.window.kill(),
        desc='Kill active window'
        ),
    Key(
        [mod, "control"], "r",
        lazy.restart(),
        desc='Restart Qtile'
        ),
    Key(
        [mod, "control"], "q",
        lazy.shutdown(),
        desc='Shutdown Qtile'
        ),
    Key(
        [mod], "r", 
        lazy.spawncmd(),
        desc='Run command bar'
        ),
    Key(
        [mod, "shift"], "m",
        lazy.to_screen(0),
        desc='Keyboard focus to monitor1'
        ),
    Key(
        [mod, "shift"], "n",
        lazy.to_screen(1),
        desc='Keyboard focus to monitor2'
        ),
    Key(
        [mod], "f",
        lazy.spawn(myTerm + " -e ranger"),
        desc='File Manager'
        ),
    Key(
        [mod], "n",
        lazy.layout.normalize(),
        desc='Normalize window size ratios'
        ),
    Key(
        [mod], "m",
        lazy.layout.maximize(),
        desc='Toggle window betwwen minimin and maximum sizes'
        ),
     Key(
         [mod], "d",
         lazy.spawn(myIDE),
         desc='Launches My IDE intellij'
         ),
     Key(
         [mod], "v",
         lazy.spawn("code"),
         desc='Launches My IDE intellij'
         )
]

group_names = [
        ('WWW', {'layout': 'max'}),
        ('DEV', {'layout': 'monadtall'}),
        ('SYS', {'layout': 'monadtall'}),
        ('TRM', {'layout': 'matrix'}),
        ('FSY', {'layout': 'monadwide'}),
        ('MDA', {'layout': 'stack'}),
        ('DCS', {'layout': 'floating'})
        ]

groups = [Group(name, **kwargs) for name, kwargs in group_names]

for i, (name, kwargs) in enumerate(group_names, 1):
    keys.extend([
        Key([mod], str(i), lazy.group[name].toscreen()), # mod1 + letter of group = switch to group
        Key([mod, "shift"], str(i), lazy.window.togroup(name)),  # mod1 + shift + letter of group = switch to & move focused window to group
    ])

layout_conf= {
        'border_width': 1,
        'margin': 4,
        'border_focus': colors['primary'][0],
    }    

layouts = [
    layout.Max(**layout_conf),
    layout.Stack(num_stacks=2, **layout_conf),
    layout.MonadTall(**layout_conf),
    layout.MonadWide(**layout_conf),
    layout.Matrix(columns=2, **layout_conf),
    layout.Floating(**layout_conf),
]

# Set cofigurations of widgets
# Base configuration
def w_base_color(fg = 'light', bg= 'dark'):
    return {
        'foreground': colors[fg],
        'background': colors[bg]
    }

# Conf of object of widgets
w_separator = {
    **w_base_color(),
    'linewidth': 0,
    'padding': 5
}

w_group_box = {
    **w_base_color(),
    'font': 'Ubuntu Bold',
    'fontsize': 10,
    'margin_y': 5,
    'margin_x': 0,
    'padding_y': 8,
    'padding_x': 5,
    'borderwidth': 1,
    'active': colors['light'],
    'inactive': colors['light'],
    'rounded': False,
    'highlight_method': 'block',
    'this_current_screen_border': colors['primary'],
    'this_screen_border': colors['grey'],
    'other_current_screen_border': colors['dark'],
    'other_screen_border': colors['dark']
}

w_window_name = {
    **w_base_color(fg = 'primary'),
    'font': 'Ubuntu',
    'fontsize': 11,
    'padding': 5
}

w_systray = {
    'background': colors['light'],
    'padding': 5
}

w_text_box = {
    'font': 'Ubuntu Bold',
    'fontsize': 15,
    'padding': 5
}

w_pacman = {
    'execute': 'urxvtc',
    'update_interval': 1800
}

w_net = {
    'interface': 'enp0s3',
    'format': '{down} '
}

w_current_layout_icon = {
    'scale': 0.65
}

w_current_layout = {
    'padding': 5
}

w_clock = {
    'format': '%d/%m/%Y-%H:%M '
}

w_memory = {
    'padding': 5,
 #   'foreground': colors['light'],
    'background': colors['secondary']
}

w_cpu = {
     'padding': 5,
  #   'foreground': colors['light'],
     'background': colors['primary'],
#     'fmt': 'cpu:{use}%',
}

w_disk = {         
      'padding': 5,                  
   #   'foreground': colors['light'],
#      'background': colors['secondary'],
      'measure': 'G',
      'partition': '/'
}

w_volume = {
    'foreground': colors['light'],
    'background': colors['dark'],
    'padding': 5
}



# Conf of Workspace with widgets
def wk_workspaces_base():
    return [
        widget.Sep(**w_separator),
        widget.GroupBox(**w_group_box),
        widget.Sep(**w_separator),
        widget.WindowName(**w_window_name),
        widget.Prompt(),
        widget.Memory(**w_memory),
        widget.CPU(**w_cpu),
    ]

def wk_powerline_base():
    return [
        widget.CurrentLayoutIcon(**w_base_color(bg='secondary'), **w_current_layout_icon),
        #widget.CurrentLayout(**w_base_color(bg='secondary'), **w_current_layout),
        #widget.Volume(**w_volume),
        #widget.Image(filename = img['primary']),
        #widget.Clock(**w_base_color(bg='primary'), **w_clock),
        #widget.TextBox(**w_base_color(bg='primary'), **w_text_box, text ='' ),
        #widget.Clock(**w_base_color(bg='primary'), **w_clock)
    ]

screen_primary = {
    #*wk_workspaces_base(),
     widget.Sep(**w_separator),
     widget.GroupBox(**w_group_box),
     widget.Sep(**w_separator),
     widget.WindowName(**w_window_name),
     widget.Sep(**w_separator),
     widget.Prompt(),
     #widget.Sep(**w_separator),
     #widget.Memory(**w_memory),
     #widget.Sep(**w_separator),
     #widget.CPU(**w_cpu),
     #widget.Sep(**w_separator),

    #widget.Sep(**w_separator),
    #widget.Systray(**w_systray),
    #widget.Sep(**w_separator),
    #widget.Image(filename = img['bg-to-secondary']),
        #widget.Memory(**w_memory),
    #widget.TextBox(**w_base_color(bg = 'secondary'), **w_text_box, text=''),
    #widget.Pacman(**w_base_color(bg = 'secondary'), **w_pacman),
    #widget.Image(filename = img['primary']),
    #widget.TextBox(**w_base_color(bg = 'primary'), **w_text_box, text='')
    #widget.Sep(**w_separator),
    #widget.Image(filename = img['primary']),
    #widget.Sep(**w_separator),
        #widget.CPU(**w_cpu),
    #widget.Image(filename = img['secondary']),
    #widget.DF(),
    #widget.Image(filename = img['bg-to-primary']),
    
    #widget.Net(**w_base_color(bg = 'secondary'), **w_net),
    #widget.Sep(**w_separator),
    #widget.Image(filename = img['secondary']),
        #*wk_powerline_base()
    widget.CurrentLayoutIcon(**w_base_color(bg='secondary'), **w_current_layout_icon),
    #widget.Clock(**w_base_color(bg='primary'), **w_clock),

}

screen_secondary = {
    *wk_workspaces_base(),
    widget.Image(filename = img['bg-to-secondary']),
    *wk_powerline_base()
}

widget_defaults = dict(
    font='Roboto Mono',
    fontsize=12,
    padding=1,
)

extension_defaults = widget_defaults.copy()

screens = [
    Screen(top = bar.Bar(screen_primary, 24, opacity=0.5))
]

#screens = [
#    Screen(
#        top=bar.Bar(
#            [
#                widget.CurrentLayout(),
#                widget.GroupBox(),
#                widget.Prompt(),
#                widget.WindowName(),
#                widget.TextBox("default config", name="default"),
#                widget.Systray(),
#                #widget.Net(interface="enp0s3"),
#                widget.Clock(format='%Y-%m-%d %a %I:%M %p'),
#                widget.QuickExit(),
#            ],
#            24,
#        ),
#    ),
#]

# Drag floating layouts.
mouse = [
#    Drag([mod], "Button1", lazy.window.set_position_floating(),
    Drag([mod], "Button1", lazy.window.set_position(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    {'wmclass': 'confirm'},
    {'wmclass': 'dialog'},
    {'wmclass': 'download'},
    {'wmclass': 'error'},
    {'wmclass': 'file_progress'},
    {'wmclass': 'notification'},
    {'wmclass': 'splash'},
    {'wmclass': 'toolbar'},
    {'wmclass': 'confirmreset'},  # gitk
    {'wmclass': 'makebranch'},  # gitk
    {'wmclass': 'maketag'},  # gitk
    {'wname': 'branchdialog'},  # gitk
    {'wname': 'pinentry'},  # GPG key password entry
    {'wmclass': 'ssh-askpass'},  # ssh-askpass
],
 border_focus=colors['secondary'][0]
)
auto_fullscreen = True
focus_on_window_activation = "smart"

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
