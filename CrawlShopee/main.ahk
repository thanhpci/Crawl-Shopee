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


for item in category_items {

    if (A_Index = 1  ||  A_Index = 2) {
        continue
        ; browser.FindElement({ ClassName: "home-category-list__category-grid" }).Click()
    } else {
        browser.Navigate(item.url)
    }

    Sleep 3000
    try {

        while (true) {
            ; result := Array()
            products := browser.FindElements({ ClassName: "col-xs-2-4 shopee-search-item-result__item" })
            cur_document := browser.GetCurrentDocumentElement()


            flag_break := false
            index := 1
            for percent in [21.5, 34.5, 49.4, 63.5] {
                if (flag_break) {
                    break
                }
                random_number := Random(-0.5, 0.5)
                cur_document.VerticalScrollPercent := percent + random_number
                ToolTip "Current scroll percent: " cur_document.VerticalScrollPercent

                Sleep 5000

                
                while (true) {

                    try {
                        if (index > products.Length) {
                            flag_break := true
                            break
                        }

                        product := products[index]

                        jsCode := "void(function(){function copyToClipboard(text) {var dummy = document.createElement('textarea');document.body.appendChild(dummy);dummy.value = text;dummy.select();document.execCommand('copy');document.body.removeChild(dummy);}function checkStar(n) {var items = document.getElementsByClassName('col-xs-2-4 shopee-search-item-result__item');var stars = items[n-1].querySelectorAll('.shopee-rating-stars__lit');var totalWidth = 0;for (var i = 0; i < stars.length; i++) {var starWidth = stars[i].style.width;var widthValue = parseInt(starWidth);totalWidth += widthValue;}var averageStars = totalWidth / 100;return averageStars;}copyToClipboard(checkStar(" index "));})();"
                        browser.JSExecute(jsCode)
                        product.Highlight()
                        Sleep 5000

                        detail := product.DumpAll()
                        ; OutputDebug(detail)

                        product_name := extract_name(detail)
                        product_link := extract_link(detail)
                        product_price := extract_price(detail)
                        sold_quantity := extract_quantity(detail)
                        product_location := extract_location(detail)
                        product_revenue := calculate_revenue(product_price, sold_quantity)

                        rating_star := A_Clipboard


                        filePath := A_ScriptDir "\RawData.csv"
                        current_time := FormatTime(A_Now, "yyyyMMdd-HH:mm:ss")
                        line := current_time "," item.Name "," product_name "," product_link "," rating_star "," product_price "," product_location "," product_revenue "`n"
                        FileAppend(line, filePath, "UTF-8")

                    } 

                    index++
                    if (index - (index // 15) * 15  == 1) {
                        break
                    }
                }
            }
            ToolTip
            cur_document.VerticalScrollPercent := 70
            Sleep 3000

            ; OutputDebug(result)

            ; filePath := A_ScriptDir "\RawData.csv"
            ; for item in result {
            ;     line := item.categoryName "," item.ratingStar "," item.detail "`n"
            ;     FileAppend(line, filePath, "UTF-8")
            ; }


            try {
                browser.FindElement({ ClassName: "shopee-icon-button shopee-icon-button--right" }).Click()
                cur_document.VerticalScrollPercent := -100
                Sleep 3000

            } catch Error {
                break
            }
        }
    } catch Error {
        continue
    }


    ; cur_document.VerticalScrollPercent := -100
    ; Sleep 2000
    ; browser.FindElement({ ClassName: "header-with-search__logo-section" }).Click()


}


extract_name(detail) {
    count_image := 0
    pos_image := 1
    while (pos_image := InStr(detail, "(Image) Name:", true, pos_image + 1))
        count_image++

    if (count_image > 1) {
        startPos := InStr(detail, " (Image) Name: `"", true) + StrLen(" (Image) Name: `"")
        endPos := InStr(detail, "`" LocalizedType: `"graphic`" ClassName:", true)
        productName := SubStr(detail, startPos, endPos - startPos)

        if (InStr(productName, ",") > 0) {
            productName := StrReplace(productName, ",", A_Space)
        }
    } else {
        productName := " "
    }


    return productName
}

extract_link(detail) {
    startPos := InStr(detail, "Value: `"", true) + StrLen("Value: `"")
    endPos := InStr(detail, "`" LocalizedType: `"link`"", true)
    link := SubStr(detail, startPos, endPos - startPos)
    return link
}


extract_price(detail) {
    startPos := InStr(detail, " image current price ", true) + StrLen(" image current price ")
    endPos := InStr(detail, " Đã bán", true, startPos)
    price := SubStr(detail, startPos, endPos - startPos)

    price := StrReplace(price, " current price", "")
    return price
}


extract_quantity(detail) {
    tmpPos := InStr(detail, "Đã bán", true)

    if (tmpPos < 1) {
        return "0"
    }
    ; tmpPos := InStr(detail, "Đã bán", true)
    startPos := InStr(detail, " Đã bán ", true, tmpPos) + StrLen(" Đã bán ")
    endPos := InStr(detail, " from ", true, StartingPos := startPos)
    soldQuantity := SubStr(detail, startPos, endPos - startPos)
    return soldQuantity
}


extract_location(detail) {
    tmpPos := InStr(detail, "Đã bán", true)
    pricePos := InStr(detail, " Đã bán ", true, tmpPos) + StrLen(" Đã bán ")

    startPos := InStr(detail, " from ", true, pricePos) + StrLen(" from ")
    endPos := InStr(detail, "`" Value:", true, startPos)
    location := SubStr(detail, startPos, endPos - startPos)
    return location
}


calculate_revenue(price, soldQuantity) {
    priceString := StrReplace(price, "₫", "")
    priceParts := StrSplit(priceString, " - ")
    highestPrice := priceParts[1]

    if (priceParts.Length > 1) {
        highestPrice := priceParts[2]
    }

    highestPrice := StrReplace(highestPrice, ".", "")
    highestPriceNum := Integer(highestPrice)

    soldQuantity := StrReplace(soldQuantity, ",", ".")

    if (InStr(soldQuantity, "k", true)) {
        soldQuantity := Float(StrReplace(soldQuantity, "k", "")) * 1000

    } else if (InStr(soldQuantity, "tr", true)) {
        soldQuantity := Float(StrReplace(soldQuantity, "tr", "")) * 1000000
    }

    revenue := highestPriceNum * Integer(soldQuantity)
    return revenue
}