-- Make sure that you insert the billing permission if you are publishing on Android.
-- android = {
--      usesPermissions = {
--          "com.android.vending.BILLING",
--      },
-- },

local store = require"store" -- initialize store api.
local items = {
        "eight.app.studio.myappname.myproductname1",
        "eight.app.studio.myappname.myproductname2"
    }

-- This is the callback that checks the state of the transaction.
-- If you want to see more explaination about this visit the Corona API
-- http://docs.coronalabs.com/guide/monetization/IAP/index.html#transaction-listener
local function transactionCallback( event )
    print("transactionCallback: Received event " .. tostring(event.name))
    print("state: " .. tostring(event.transaction.state))
    print("errorType: " .. tostring(event.transaction.errorType))
    print("errorString: " .. tostring(event.transaction.errorString))
    
    local productID= event.transaction.productIdentifier;
    if event.transaction.state == "purchased" then
        print("Product Purchased: ", productID)
    elseif  event.transaction.state == "restored" then
        print("Product Restored", productID)
    elseif  event.transaction.state == "refunded" then
        print("Product Refunded")
    elseif event.transaction.state == "cancelled" then
        print("Transaction cancelled")
    elseif event.transaction.state == "failed" then        
        print("Transaction Failed")
    else
        print("Some unknown event occured.  This should never happen.")
    end
    store.finishTransaction( event.transaction )
end 

-- Identifies the device and will initialize according to type.
if store.availableStores.apple then
    store.init("apple", transactionCallback)
elseif store.availableStores.google then
    store.init("google", transactionCallback)
end

-- this handles the purchasing transaction.
local function purchaseItem()
    -- make sure that your iOS and Google In-App Products has the same product ID
    store.purchase( {items[1]})
end

-- When a user buys new phone or uninstall your app but reinstalls it later
-- all purchased products will be restored.
local function restorePurchases()
    store.restore()
end
