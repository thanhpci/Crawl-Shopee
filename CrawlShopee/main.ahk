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

    if (A_Index = 1) {
        browser.FindElement({ ClassName: "home-category-list__category-grid" }).Click()
    } else {
        browser.Navigate(item.url)
    }

    Sleep 5000

    while (true) {
        ; result := Array()
        products := browser.FindElements({ ClassName: "col-xs-2-4 shopee-search-item-result__item" })
        cur_document := browser.GetCurrentDocumentElement()


        times := 0
        for percent in [21.5, 34.5, 49.4, 63.5] {
            random_number := Random(-0.5, 0.5)
            cur_document.VerticalScrollPercent := percent + random_number
            ToolTip "Current scroll percent: " cur_document.VerticalScrollPercent

            Sleep 6000

            index := 15 * times + 1
            while (index <= 15) {
                product := products[index]

                jsCode := "void(function(){function copyToClipboard(text) {var dummy = document.createElement('textarea');document.body.appendChild(dummy);dummy.value = text;dummy.select();document.execCommand('copy');document.body.removeChild(dummy);}function checkStar(n) {var items = document.getElementsByClassName('col-xs-2-4 shopee-search-item-result__item');var stars = items[n-1].querySelectorAll('.shopee-rating-stars__lit');var totalWidth = 0;for (var i = 0; i < stars.length; i++) {var starWidth = stars[i].style.width;var widthValue = parseInt(starWidth);totalWidth += widthValue;}var averageStars = totalWidth / 100;return averageStars;}copyToClipboard(checkStar(" index "));})();"
                browser.JSExecute(jsCode)
                product.Highlight()
                Sleep 3000
 
                detail := product.DumpAll()
                ; OutputDebug(detail)

                product_name := extract_name(detail)
                product_link := extract_link(detail)
                product_price := extract_price(detail)
                sold_quantity := extract_quantity(detail)
                product_location := extract_location(detail)
                product_revenue := calculate_revenue(product_price, sold_quantity)

                rating_star := A_Clipboard

                ; result.Push({ categoryName: item.Name, ratingStar: rating_star, detail: detail })


                filePath := A_ScriptDir "\RawData.csv"
                line := item.Name "," product_name "," product_link "," rating_star "," product_price "," product_location "," product_revenue "`n"
                FileAppend(line, filePath, "UTF-8")

                index++
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


        times++
        try {
            browser.FindElement({ ClassName: "shopee-icon-button shopee-icon-button--right" }).Click()
            cur_document.VerticalScrollPercent := -100
            Sleep 3000

        } catch Error {
            break
        }
    }

    ; cur_document.VerticalScrollPercent := -100
    ; Sleep 2000
    ; browser.FindElement({ ClassName: "header-with-search__logo-section" }).Click()


}


extract_name(detail) {
    count_image := 0
    pos_image := 1
    while (pos_image := InStr(detail, "(Image) Name:", false, pos_image + 1))
        count_image++

    if (count_image > 1) {
        startPos := InStr(detail, " (Image) Name: `"") + StrLen(" (Image) Name: `"")
        endPos := InStr(detail, "`" LocalizedType: `"graphic`" ClassName:")
        productName := SubStr(detail, startPos, endPos - startPos)
    } else {
        productName := " "
    }

    return productName
}

extract_link(detail) {
    startPos := InStr(detail, "Value: `"") + StrLen("Value: `"")
    endPos := InStr(detail, "`" LocalizedType: `"link`"")
    link := SubStr(detail, startPos, endPos - startPos)
    return link
}


extract_price(detail) {
    startPos := InStr(detail, " image current price ") + StrLen(" image current price ")
    endPos := InStr(detail, " Đã bán", false, startPos)
    price := SubStr(detail, startPos, endPos - startPos)

    price := StrReplace(price, " current price", "")
    return price
}


extract_quantity(detail) {
    tmpPos := InStr(detail, "Đã bán")
    startPos := InStr(detail, " Đã bán ", false, tmpPos) + StrLen(" Đã bán ")
    endPos := InStr(detail, " from ")
    soldQuantity := SubStr(detail, startPos, endPos - startPos)
    return soldQuantity
}


extract_location(detail) {
    startPos := InStr(detail, " from ") + StrLen(" from ")
    endPos := InStr(detail, "`" Value:")
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

    if (InStr(soldQuantity, "k")) {
        soldQuantity := Float(StrReplace(soldQuantity, "k", "")) * 1000

    } else if (InStr(soldQuantity, "tr")) {
        soldQuantity := Float(StrReplace(soldQuantity, "tr", "")) * 1000000
    }

    revenue := highestPriceNum * Integer(soldQuantity)
    return revenue
}