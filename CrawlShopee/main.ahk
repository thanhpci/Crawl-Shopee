#Requires AutoHotkey v2.0.11

#include ..\Lib\UIA.ahk
#include ..\Lib\UIA_Browser.ahk


Run "msedge.exe https://shopee.vn/"

WinWaitActive("ahk_exe msedge.exe")
browser := UIA_Browser()
Sleep 5000


Try {
    arrow_button := browser.WaitElement({ ClassName: "carousel-arrow carousel-arrow--next carousel-arrow--hint" }, 10)
    arrow_button.Click()
    Sleep 2000
}


category_list := browser.FindElements({ ClassName: "home-category-list__category-grid" })


category_items := Array()
for item in category_list {
    category_items.Push({ Name: item.Name, url: item.Value })
}

browser.FindElement({ ClassName: "home-category-list__category-grid" }).Click()

for item in category_items {
    ; browser.Navigate(item.url)    
    Sleep 5000

    while (true) {
        result := ""
        products := browser.FindElements({ ClassName: "col-xs-2-4 shopee-search-item-result__item" })
        cur_document := browser.GetCurrentDocumentElement()
        ToolTip "Current scroll percent: " cur_document.VerticalScrollPercent
        cur_document.VerticalScrollPercent := 7

        times := 0
        for percent in [21.5, 34.5, 49.4, 63.5] {
            random_number := Random(-1.9, 1.9)
            cur_document.VerticalScrollPercent := percent + random_number
            Sleep 5000
            ToolTip "Current scroll percent: " cur_document.VerticalScrollPercent
            index := 15*times + 1
            while (index <= 15) {
                detail := (products[index]).DumpAll()

                ; startPos := InStr(detail, "Type: 50007 (ListItem) Name: " "") + StrLen("Type: 50007 (ListItem) Name: " "") + 1
                ; endPos := InStr(detail, "" " LocalizedType:") - 1
                ; length := endPos - startPos
                ; result .= SubStr(detail, startPos, length)  "`n"
                result .= detail "`n"
                index += 1
            }
        }
        ToolTip
        cur_document.VerticalScrollPercent := 70
        Sleep 3000

        OutputDebug(result)
        times++
        try {
            next_button := browser.FindElement({ ClassName: "shopee-icon-button shopee-icon-button--right" }).Click()
            cur_document.VerticalScrollPercent := -100
            Sleep 3000

        } catch Error {
            break
        }
    }

    x := 5


}