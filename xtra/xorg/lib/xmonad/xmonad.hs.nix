{ pkgs, usr, ... }:
with pkgs; with builtins;
let
  autostart = writeScript "xmonad-autostart"
    usr.xmonad.scripts.autostart;

  stoggle =  writeScript "xmonad-stoggle"
    usr.xmonad.scripts.stoggle ;

  touchtoggle = writeScript "xmonad-touchtoggle"
    usr.xmonad.scripts.touchtoggle ;
in
''
import           XMonad
import           XMonad.Config.Desktop               (desktopConfig)
import           XMonad.Hooks.EwmhDesktops           (ewmh)
import           XMonad.Hooks.ICCCMFocus             (takeTopFocus)
import           XMonad.Hooks.ManageDocks
import           XMonad.Util.EZConfig                (additionalKeys)

import           Data.Maybe                          (fromMaybe)
import           Graphics.X11.ExtraTypes.XF86        (xF86XK_AudioLowerVolume,
                                                      xF86XK_AudioMute,
                                                      xF86XK_AudioRaiseVolume)
import           Graphics.X11.Types                  (KeyMask, KeySym, Window)
import           System.Environment                  (lookupEnv)
import           XMonad.Layout.MultiToggle
import           XMonad.Layout.MultiToggle.Instances

import           Control.Monad                       (liftM2)
import           Data.Monoid                         (Endo)
import           XMonad.Core                         (Layout, Query,
                                                      ScreenDetail, ScreenId,
                                                      WorkspaceId, X)
import           XMonad.Hooks.SetWMName              (setWMName)
import           XMonad.Layout.NoBorders             (smartBorders)
import           XMonad.Layout.PerWorkspace          (onWorkspace)
import           XMonad.Layout.Reflect               (reflectHoriz)
import           XMonad.Util.Cursor
import qualified XMonad.StackSet                     as S (StackSet, greedyView,
                                                           shift)

myLayout = smartBorders
   .  mkToggle ( NBFULL ?? EOT)
   . onWorkspace "7:im" ( half ||| Mirror half ||| tiled ||| reflectHoriz tiled )
   $ tiled ||| reflectHoriz tiled ||| half ||| Mirror half
    where
      tiled     = Tall nmaster delta ratiot
      half      = Tall nmaster delta ratioh
      nmaster   = 1
      ratiot    = 309/500
      ratioh    = 1/2
      delta     = 1/9

myWorkspaces :: [ [Char] ]
myWorkspaces = ["1:main", "2:art", "3:torrent", "4:pdf", "5:game", "6:media", "7:im", "8", "9"]

myAutostart :: X ()
myAutostart = do
  spawn "${ autostart }"
  setWMName "LG3D"
  sendMessage $ SetStruts [] [minBound .. maxBound]
  setDefaultCursor xC_left_ptr

-- Move Programs by X11 Class to specific workspaces on opening
myManageHook :: Query
  ( Endo
    ( S.StackSet WorkspaceId (Layout Window) Window ScreenId ScreenDetail )
  )
myManageHook = composeAll
  [ className =? "st-256color" --> viewShift "1:main"
  , className =? "qutebrowser" --> viewShift "1:main"
  , className =? "Gimp-2.99" --> viewShift "2:art"
  , className =? "krita" --> viewShift "2:art"
  , className =? "qBittorrent" --> viewShift "3:torrent"
  , className =? "PCSX2" --> viewShift "5:game"
  , className =? "RPCS3" --> viewShift "5:game"
  , className =? "mpv" --> viewShift "6:media"
  , className =? "Google Play Music Desktop Player" --> viewShift "6:media"
  , className =? "Zathura" --> viewShift "4:pdf"
  , className =? "Evince" --> viewShift "4:pdf"
  , className =? "Riot" --> doShift "7:im"
  , className =? "Signal" --> doShift "7:im"
  , className =? "Steam" --> doFloat
  , className =? "Wine" --> doFloat
  ]
    where viewShift = doF . liftM2 (.) S.greedyView S.shift

-- Set ModKey to the Windows Key
myModKey :: KeyMask
myModKey = mod4Mask

-- function to call dzen2 and show volume in the middle of the screen
dzcall :: [Char]
dzcall = "${dzvol}/bin/dzvol -fn 'DejaVu Sans Mono for Powerline-16:normal'"

-- Function for fullscreen toggle
fullToggle :: X ()
fullToggle = do
  spawn "${ stoggle }"
  sendMessage $ Toggle NBFULL
  sendMessage $ SetStruts [] [minBound .. maxBound]

-- Set custom keybinds below following the structure:
-- ( ( ModifierKey, KeyPress ), Action )
myKeys :: [ ( ( KeyMask, KeySym ), X () ) ]
myKeys =
  -- toggle fullscreen, along with power state
  [ ( ( myModKey                              , xK_f                    )
    , fullToggle
    )
  -- don't rebuild in nixos since it will fail just call autostart script
  , ( ( myModKey                              , xK_q                    )
    , spawn "${ autostart }"
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
      \ > ~/Pictures/shots/$(date +%m.%d.%y_%I.%M.%S_%p).ff.xz"
    )
  -- screenshot focused window
  , ( ( myModKey .|. shiftMask                , xK_Print                )

    , spawn "maim -u -i$(xdotool getactivewindow) \
      \ | png2ff \
      \ | xz -9 - \
      \ > ~/Pictures/shots/$(date +%m.%d.%y_%I.%M.%S_%p).ff.xz"
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
      \ > ~/Pictures/shots/$(date +%m.%d.%y_%I.%M.%S_%p).ff.xz"
    )
  -- screenshot selection to imgur and paste url in clipboard
  , ( ( myModKey .|. shiftMask                , xK_i                    )

    , spawn "maim -s -u /tmp/img.png; \
      \ imgurbash2 /tmp/img.png; \
      \ rm /tmp/img.png"
    )
  -- toggle touchpad
  , ( ( myModKey .|. shiftMask                , xK_t                    )

    , spawn "${ touchtoggle }"
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

main :: IO ()
main =
  xmonad . ewmh $ desktopConfig
  { terminal           = "st"
  , modMask            = myModKey
  , layoutHook         = avoidStruts $ myLayout
  , workspaces         = myWorkspaces
  , startupHook        = myAutostart
  , manageHook         = myManageHook
                         <+> manageHook defaultConfig
                         <+> manageDocks
  , borderWidth        = 1
  , logHook            = takeTopFocus
  }
  `additionalKeys` myKeys
''
