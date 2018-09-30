{-
    TIP: Edit from within a nix-shell to get help from ghcid:

    $ hashell xmonad xmonad-contrib xmonad-extras
-}
import           Control.Monad              (void)

import           Data.Bits                  ((.|.))
import           Data.Default               (def)
import qualified Data.List                  as List
import qualified Data.Map                   as Map

import qualified Graphics.X11               as X11

import qualified System.IO                  as IO

import qualified XMonad.Actions.Volume      as Volume
import           XMonad.Config.Desktop      (desktopConfig)
import qualified XMonad.Core                as Core
import qualified XMonad.Hooks.DynamicLog    as DynamicLog
import qualified XMonad.Hooks.EwmhDesktops  as Hooks (fullscreenEventHook)
import qualified XMonad.Hooks.ManageDocks   as Hooks (avoidStruts, docks,
                                                      manageDocks)
import qualified XMonad.Hooks.ManageHelpers as Hooks (doFullFloat, isDialog,
                                                      isFullscreen)
import qualified XMonad.Hooks.SetWMName     as SetWMName
import qualified XMonad.Layout.NoBorders    as Layout (smartBorders)
import           XMonad.ManageHook          ((-->))
import qualified XMonad.Operations          as Operations
import qualified XMonad.Util.Run            as Run

import           XMonad.Main                (xmonad)

main :: IO.IO ()
main = do
    -- Kill the system bell.
    Core.spawn "xset -b"
    -- Kick off xmobar.
    xmobarProc <- Run.spawnPipe xmobarCmd
    let xmobarLogHook = DynamicLog.dynamicLogWithPP $ DynamicLog.xmobarPP
            { DynamicLog.ppOutput = IO.hPutStrLn xmobarProc
            , DynamicLog.ppTitle  = DynamicLog.xmobarColor "#b5bd68" ""
                . DynamicLog.shorten 80
            }
    let conf = myConfig { Core.logHook = xmobarLogHook }
    xmonad (Hooks.docks conf)

myConfig = desktopConfig
    { Core.modMask            = X11.mod1Mask  -- left alt
    , Core.keys               = myKeys
    , Core.terminal           = "kitty"
    , Core.focusedBorderColor = "#cc6666"
    , Core.normalBorderColor  = "#373b41"
    , Core.borderWidth        = 3
    , Core.startupHook        = SetWMName.setWMName "LG3D"  -- fixes some JVM issues?
    , Core.handleEventHook    = Hooks.fullscreenEventHook   -- fix chrome fullscreen
    , Core.manageHook         = Hooks.manageDocks
        <> (Hooks.isDialog --> Hooks.doFullFloat)
        <> (Hooks.isFullscreen --> Hooks.doFullFloat)
        <> Core.manageHook def
    , Core.layoutHook         = Layout.smartBorders
        $ Hooks.avoidStruts
        $ Core.layoutHook def
    }

myKeys conf@(Core.XConfig { Core.modMask = modMask }) = Map.union
    (Map.fromList keyList)
    (Core.keys def conf)
  where
    keyList =
        [
            -- mod + ctrl + return --> Launches terminal
          ( (modMask .|. X11.controlMask, X11.xK_Return)
          , Core.spawn (Core.terminal conf)
          )
        ,
            -- mod + ctrl + t --> Launches terminal
          ( (modMask .|. X11.controlMask, X11.xK_t)
          , Core.spawn (Core.terminal conf)
          )
        ,
            -- mod + p --> Launches dmenu
          ((modMask, X11.xK_p), Core.spawn dmenuCmd)
        ,
            -- ctrl + shift + d --> Closes current window
          ((X11.controlMask .|. X11.shiftMask, X11.xK_d), Operations.kill)
        ,
            -- Volume controls
          ((X11.noModMask, X11.xK_F5), void $ Volume.lowerVolume 10.0)
        , ((X11.noModMask, X11.xK_F6), void $ Volume.raiseVolume 10.0)
        , ((X11.noModMask, X11.xK_F3), void $ Volume.toggleMute)
        ,
            -- Brightness controls
          ((X11.noModMask, X11.xK_F8), Core.spawn "xbacklight - 10")
        , ((X11.noModMask, X11.xK_F9), Core.spawn "xbacklight + 10")
        ]

xmobarCmd :: String
xmobarCmd = "/run/current-system/sw/bin/xmobar"

dmenuCmd :: String
dmenuCmd =
    List.intercalate " "
        $ [ "dmenu_run"
          , "-b"
          , "-fn"
          , "'Hack'"         -- font
          , "-p"
          , "'Run:'"         -- prompt
          , "-nb"
          , green
          , "-nf"
          , black
          , "-sb"
          , black
          , "-sf"
          , green
          ]
  where
    black = "'#000000'"
    green = "'#19cb00'"

(<>) :: Monoid m => m -> m -> m
(<>) = mappend

-- https://wiki.haskell.org/Xmonad/General_xmonad.hs_config_tips
