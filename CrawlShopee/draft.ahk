; Run "msedge.exe",
; , "UseErrorLevel" ; Khởi chạy Microsoft Edge và cài đặt UseErrorLevel để xử lý lỗi
; WinWait "ahk_exe msedge.exe" ; Đợi cho đến khi cửa sổ Edge xuất hiện
; browserHwnd := WinExist("A") ; Lấy HWND của cửa sổ trình duyệt hiện hành
; MsgBox "HWND của trình duyệt Edge là: " browserHwnd ; Hiển thị HWND


#Requires AutoHotkey v2
#include ..\Lib\UIA.ahk
#include ..\Lib\UIA_Browser.ahk
Run "msedge" ; Start Edge
WinWait "ahk_exe msedge.exe" ; Wait for Edge to load

browserHwnd := WinExist("A") ; Lấy HWND của cửa sổ trình duyệt hiện hành
MsgBox "HWND của trình duyệt Edge là: " browserHwnd ; Hiển thị HWND

; The following is a conceptual framework for using UIA in AHK v2
; You will need to replace this with actual code to find and interact with the Edge address bar using UIA v2
; uiElement := UIA_GetElement("Edge Address Bar Identifier") ; Locate the address bar
; uiElement.SetValue("https://shopee.vn") ; Set the URL

ExitApp


; #Requires AutoHotkey v2
; #include ..\Lib\UIA.ahk
; #include ..\Lib\UIA_Browser.ahk

; Run "chrome.exe"
; WinWait "ahk_exe chrome.exe", , 10

; if (WinActive("ahk_exe chrome.exe")) {
;     browser := UIA_Browser()

;     if (browser) {
;         browser.Navigate("https://shopee.vn/")
;         elements := browser.WaitElement({Name: "home-category-list__category-grid" }).ControlClick()

;         ; ... [Your existing script to open the browser and navigate to the website]

;         ; Find elements with a specific UI property that corresponds to your class name
;         ; elements := FindElementsWithProperty(browser, "home-category-list__category-grid")

;         ; Iterate over the found elements and click each one
;         for element in elements
;         {
;             InvokeClick(element) ; Custom function to perform click using UIA
;         }

;         ; Function to find elements based on a UI property
;         FindElementsWithProperty(browser, property)
;         {
;             ; Implement function to find elements using UIA functions
;         }

;         ; Function to perform click on a UI element
;         InvokeClick(element)
;         {
;             ; Implement function to perform click using UIA invoke pattern
;         }


;     }
;     else {
;         MsgBox "Không thể khởi tạo đối tượng browser."
;     }
; } else {
;     MsgBox "Chrome không kích hoạt trong thời gian mong đợi."
; }


; #Requires AutoHotkey v2
; #include ..\Lib\UIA.ahk
; #include ..\Lib\UIA_Browser.ahk

; ;using microsoft edge
; Run "msedge.exe"
; ; WinWait "ahk_exe msedge.exe"

; WinActive("ahk_exe msedge.exe")
; Sleep 500
; browser := UIA_Edge("ahk_exe msedge.exe")

; browser.Navigate("https://shopee.vn/")


; if (WinActive("ahk_exe msedge.exe")) {
;     browser := UIA_Browser()

;     if (browser) {
;         elements := browser.WaitElement({Name: "home-category-list__category-grid" }).ControlClick()

;     }
;     else {
;         MsgBox "Không thể khởi tạo đối tượng browser."
;     }
; } else {
;     MsgBox "Edge không kích hoạt trong thời gian mong đợi."
; }

; Sleep 500


; browser.Navigate("https://shopee.vn/")
; Sleep 500


; AttemptLogin(username, password) {
;     browser.WaitElement({
;         Type: "Button",
;         or: [{ ClassName: "btn-submit btn position-relative" }, { Name: "Đăng Nhập" }] }
;         , 1000).ControlClick()

;     browser.WaitElement({ Type: "Edit", AutomationId: "logUsername" }).Value := username
;     browser.WaitElement({ Type: "Edit", Name: "Mật khẩu" }).Value := password
;     browser.WaitElement({ Type: "Button", Name: "» Đăng Nhập" }).ControlClick()
; }


; x := 5
; MsgBox(x)
; OutputDebug("Thành công ")
; Run "chrome.exe"
; WinWaitActive "ahk_exe chrome.exe"

; browserHwnd := WinExist("A")


; browser := UIA_Browser(browserHwnd)

; browser.Navigate("https://shopee.vn")

; Sleep 3000


; ; elements := browser.FindElements({Type:"List", LocalizedType:"list"})


; x := browser.ElementFromPath("VRrK").Highlight()
; ; y := x.WalkTree("+2").Highlight()


; ; ; elements := browser.FindElement({Name: "shopee-top shopee-top--sticky" })

; ; x := browser.GetCurrentDocumentElement().DumpAll()

; OutputDebug(x)
; ; elements.Click()
; ; ; Use the UIA_Browser library's methods to find elements. This is pseudocode:
; ; ; elements := browser.FindElementsByClassName("home-category-list__category-grid")
; ; for element in elements
; ; {
; ;     ; Do something with each element, such as getting the URL from an 'a' tag
; ;     elementURL := element.GetCurrentPropertyValue(UIA.ValuePattern.ValueProperty)
; ;     MsgBox "Found URL: " elementURL
; ; }


; for product in products {
;     OutputDebug(product.Dump())
; }


; x := category_list.DumpAll()
; OutputDebug(x)
; category_list.WalkTree("+1").Highlight()





; cur_document := browser.GetCurrentDocumentElement()
; ToolTip "Current scroll percent: " cur_document.VerticalScrollPercent
; while (true) {
;     ToolTip "Current scroll percent: " cur_document.VerticalScrollPercent
; }




random_number := Random(20, 30)
cur_document.VerticalScrollPercent := -random_number
Sleep 2000
cur_document.VerticalScrollPercent := +10 + random_number

Sleep 5000
ToolTip

for product in products {
    x .= product.Dump() "`n"
}


while (loop_times > 0) {
    for percent in [10, 21.5] {
        random_number := Random(-1.9, 1.9)
        percent += random_number
        cur_document.VerticalScrollPercent := percent
        Sleep 2000
        ToolTip "Current scroll percent: " cur_document.VerticalScrollPercent
    }
    while (index <= 15) {
        product := products[index]
        x .= product.Dump() "`n"
        index += 1
    }
}





                ; parts := StrSplit(k, "Type: 50007 (ListItem) Name: ")
                ; desiredPart := StrSplit(parts[2], " LocalizedType:")

                ; result := desiredPart[1]

                ; MsgBox result  ; Hiển thị kết quả