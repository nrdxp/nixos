{ autostart, screenshots, touchtoggle, dzvol, stoggle }:
''
  -- Function for fullscreen toggle
  fullToggle :: X ()
  fullToggle = do
    spawn "${stoggle}"
    sendMessage $ Toggle NBFULL
    sendMessage $ SetStruts [] [minBound .. maxBound]

  -- function to call dzen2 and show volume in the middle of the screen
  dzcall :: String
  dzcall = "${dzvol}/bin/dzvol -fn 'DejaVu Sans Mono for Powerline-16:normal'"

  myAutostart :: X ()
  myAutostart = do
    spawn "${autostart}"
    setWMName "LG3D"
    sendMessage $ SetStruts [] [minBound .. maxBound]
    setDefaultCursor xC_left_ptr

  -- Set custom keybinds below following the structure:
  -- ( ( ModifierKey, KeyPress ), Action )
  myKeys :: [ ( ( KeyMask, KeySym ), X () ) ]
  myKeys =
    -- toggle fullscreen, along with power state
    [ ( ( myModKey                              , xK_f                    )
      , fullToggle
      )
    -- resize windows in master pane
    , ( ( myModKey                              , xK_Left                 )
      , sendMessage MirrorExpand
      )
    , ( ( myModKey                              , xK_Right                )
      , sendMessage MirrorShrink
      )
    , ( ( myModKey                              , xK_Up                   )
      , sendMessage MirrorExpand
      )
    , ( ( myModKey                              , xK_Down                 )
      , sendMessage MirrorShrink
      )
    -- toggle systray
    , ( ( myModKey .|. shiftMask                , xK_f                    )
      , sendMessage ToggleStruts
      )
    -- dmenu with larger font
    , ( ( myModKey                              , xK_p                    )
      , spawn "dmenu_run -fn 'DejaVu Sans Mono for Powerline-16:normal'"
      )
    -- lower volume
    , ( ( 0                                     , xF86XK_AudioLowerVolume )
      , spawn dzcall
      )
    -- raise volume
    , ( ( 0                                     , xF86XK_AudioRaiseVolume )
      , spawn dzcall
      )
    -- mute volume
    , ( ( 0                                     , xF86XK_AudioMute        )
      , spawn dzcall
      )
    -- start qutebrowser
    , ( ( myModKey                              , xK_b                    )
      , spawn "qutebrowser --enable-webengine-inspector"
      )
    -- screen lock
    , ( ( myModKey .|. shiftMask                , xK_l                    )

      , spawn "loginctl lock-session"
      )
    -- screenshot
    , ( ( myModKey                              , xK_Print                )
      , spawn "maim -u \
        \ | png2ff | xz -9 - \
        \ > ~/${screenshots}/$(date +%m.%d.%y_%I.%M.%S_%p).ff.xz"
      )
    -- screenshot focused window
    , ( ( myModKey .|. shiftMask                , xK_Print                )

      , spawn "maim -u -i$(xdotool getactivewindow) \
        \ | png2ff \
        \ | xz -9 - \
        \ > ~/${screenshots}/$(date +%m.%d.%y_%I.%M.%S_%p).ff.xz"
      )
    -- screenshot selection to clipboard
    , ( ( myModKey .|. controlMask              , xK_Print                )

      , spawn "maim -s -u \
        \ | xclip -selection clipboard -t image/png"
      )
    -- screenshot selection file
    , ( ( myModKey .|. controlMask .|. shiftMask, xK_Print                )

      , spawn "maim -s -u \
        \ | png2ff \
        \ | xz -9 - \
        \ > ~/${screenshots}/$(date +%m.%d.%y_%I.%M.%S_%p).ff.xz"
      )
    -- screenshot selection to imgur and paste url in clipboard
    , ( ( myModKey .|. shiftMask                , xK_i                    )

      , spawn "maim -s -u /tmp/img.png; \
        \ imgurbash2 /tmp/img.png; \
        \ rm /tmp/img.png"
      )
    -- toggle touchpad
    , ( ( myModKey .|. shiftMask                , xK_t                    )

      , spawn "${touchtoggle}"
      )
    -- dmenu frontend for network manager
    , ( ( myModKey                              , xK_n                    )
      , spawn "networkmanager_dmenu -fn 'DejaVu Sans Mono for Powerline-16:normal'"
      )
    -- dmenu frontend for network manager
    , ( ( myModKey .|. shiftMask                , xK_p                    )

      , spawn "passdmenu -- -fn 'DejaVu Sans Mono for Powerline-16:normal'"
      )
    ]
''
