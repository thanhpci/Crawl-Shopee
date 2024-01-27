#Requires AutoHotkey v2.0.11

#include ..\Lib\UIA.ahk
#include ..\Lib\UIA_Browser.ahk



Run "msedge.exe https://shopee.vn/"

WinWaitActive("ahk_exe msedge.exe")
browser := UIA_Browser()
Sleep 5000

Try {
    arrow_button := browser.WaitElement({ClassName:"carousel-arrow carousel-arrow--next carousel-arrow--hint"}, 10)
    arrow_button.Click()
}



category_list := browser.FindElements({ClassName:"home-category-list__category-grid"})



category_items := Array()
for item in category_list {
    category_items.Push(item.Value)
}
    

x := ""
for url in category_items {
    browser.Navigate(url)
    Sleep 5000
    products := browser.FindElements({ClassName:"col-xs-2-4 shopee-search-item-result__item"})
    for product in products {
        x .= product.Dump() "`n"
    }
    OutputDebug(x)

    ; for product in products {
    ;     OutputDebug(product.Dump())
    ; }
}




; x := category_list.DumpAll()
; OutputDebug(x)
; category_list.WalkTree("+1").Highlight()
k := 5











