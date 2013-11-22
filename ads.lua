 --[[
    
    
    local ads = require "ads"
    
    --call revmob
    
    --to show revmob ads "banner","fullscreen","show_pop":D
    --to hide "banner_hide" or "fullscreen_hide"
    
    ads.callrevmob("fullscreen") --show fullscreen ads
    
    --to show tapfortap ads "banner_top","banner_bottom","fullscreen","more_games":D
    --to hide "banner_hide" (banner only)
    
    ads.calltapfortap("fullscreen")
    
    --to show chartboost ads "fullscreen","more_games":D

    ads.callchartboost("fullscreen")
    
]]

local ads = {}

local AMAZON_APK = false

local _H = display.contentHeight
local _W = display.contentWidth

local RevMob = require"lib.revmob"
local RevMob = require("revmob")
local revmob_ANDROID = "APP ID REVMOB"
local revmob_IOS = "APP ID REVMOB"
local revmob_AMAZON = "APP ID REVMOB"

local REVMOB_IDS = { ["Android"] = revmob_ANDROID, ["iPhone OS"] = revmob_IOS }
if AMAZON_APK then REVMOB_IDS[REVMOB_ID_ANDROID] = revmob_AMAZON end
RevMob.startSession(REVMOB_IDS)

local banner_revmob = RevMob.createBanner({x = display.contentWidth / 2, y = _H - 50, width = _W, height = 100 })
banner_revmob:hide()

local fullscreen_revmob = RevMob.createFullscreen()
fullscreen_revmob:hide()

local show_pop = RevMob.createPopup()
show_pop:hide()

local TOP = 1
local CENTER = 2
local BOTTOM = 3
local LEFT = 1
local RIGHT = 3

local tapfortap = require "plugin.tapfortap"
tapfortap.initialize("tapfortap ID")
tapfortap.prepareInterstitial() --prepare fullscreen ads
tapfortap.prepareAppWall()

local function adViewListener(event)
    
    if event.event == "onReceiveAd" then
        
    elseif event.event == "onTapAd" then
        --trigger for ads tapped, cause tapfrotap banner won't remove if clicked
        tapfortap.removeAdView()
    elseif event.event == "onFailToReceiveAd" then
        --if tapfortap banner fail, put alternative ads revmob banner
    end
    
end

tapfortap.setAdViewListener(adViewListener)

local function interstitialListener(event)
    if event.event == "onReceiveAd" then
        
    elseif event.event == "onTapAd" then
        --trigger for ads tapped cause
    elseif event.event == "onFailToReceiveAd" then
        --if tapfortap fullscreen fail, put alternative ads revmob fullscreen
    end
end

tapfortap.setInterstitialListener(interstitialListener)

--tapfortap.createAdView(verticalAlignment, horizontalAlignment, xOffset, yOffset, scale)

local cbdata = require "ChartboostSDK.chartboostdata"
local cb = require "ChartboostSDK.chartboost"

local appId = "CHARTBOOST APP ID"
local appSignature = "CHARTBOOST SECRET"
local appBundle = "APP PACKAG"
local appVersion = "APP VERSION"

local delegate = {
    shouldRequestInterstitial = function(location) print("Chartboost: shouldRequestInterstitial " .. location .. "?"); return true end,
    shouldDisplayInterstitial = function(location) print("Chartboost: shouldDisplayInterstitial " .. location .. "?"); return true end,
    didCacheInterstitial = function(location) print("Chartboost: didCacheInterstitial " .. location); return end,
    didFailToLoadInterstitial = function(location) ads.calltapfortap("fullscreen")print("Chartboost: didFailToLoadInterstitial " .. location); return end,
    didDismissInterstitial = function(location) print("Chartboost: didDismissInterstitial " .. location); return end,
    didCloseInterstitial = function(location) print("Chartboost: didCloseInterstitial " .. location); return end,
    didClickInterstitial = function(location) print("Chartboost: didClickInterstitial " .. location); return end,
    didShowInterstitial = function(location) print("Chartboost: didShowInterstitial " .. location); return end,
    shouldDisplayLoadingViewForMoreApps = function() return true end,
    shouldRequestMoreApps = function() print("Chartboost: shouldRequestMoreApps"); return true end,
    shouldDisplayMoreApps = function() print("Chartboost: shouldDisplayMoreApps"); return true end,
    didCacheMoreApps = function() print("Chartboost: didCacheMoreApps"); return end,
    didFailToLoadMoreApps = function() print("Chartboost: didFailToLoadMoreApps"); return end,
    didDismissMoreApps = function() print("Chartboost: didDismissMoreApps"); return end,
    didCloseMoreApps = function() print("Chartboost: didCloseMoreApps"); return end,
    didClickMoreApps = function() print("Chartboost: didClickMoreApps"); return end,
    didShowMoreApps = function() print("Chartboost: didShowMoreApps"); return end,
    shouldRequestInterstitialsInFirstSession = function() return true end
}

cb.create{appId = appId,
    appSignature = appSignature,
    delegate = delegate,
    appVersion = appVersion,
appBundle = appBundle}
cb.startSession()

cb.cacheMoreApps() -- load more app's before showing
cb.cacheInterstitial() -- load fullscreen before showing

function ads.calltapfortap(action)
    if action == "banner_bottom" then
        tapfortap.createAdView(BOTTOM, CENTER, 0, 0, 1)
    elseif action == "banner_top" then
        tapfortap.createAdView(TOP,CENTER, 0, 0, 1)
    elseif action == "fullscreen" then
        tapfortap.showInterstitial()
    elseif action == "banner_hide" then
        tapfortap.removeAdView()
    elseif action == "more_games" then
        tapfortap.showAppWall()
    end
end

function ads.callrevmob (action)
    if action == "banner" then
        banner_revmob:show()
    elseif action == "fullscreen" then
        fullscreen_revmob:show()
    elseif action == "banner_hide" then
        banner_revmob:hide()
    elseif action == "fullscreen_hide" then
        fullscreen_revmob:hide()
    elseif action == "show_pop" then
        show_pop:show()
    end
end

function ads.callchartboost(action)
    if action == "more_games" then
        cb.showMoreApps() --find didFailToLoadMoreApps in delegate to have backup more apps if chartboost fail to load
    elseif action == "fullscreen" then
        cb.showInterstitial() --find didFailToLoadInterstitial in delegate to have backup fullscreen ads if chartboost fail to load
    end
end

return ads

