# 介紹 StoreKit 2 與 SwiftUI 應用
Github：[iOSAcademy-SwiftUIStoreKit2AppleWatchWithIAP](https://github.com/RainBowT0506/iOSAcademy-SwiftUIStoreKit2AppleWatchWithIAP)
在這段影片中，我們將學習如何使用全新釋出的 StoreKit 2，結合 SwiftUI，建立一個購買 Apple Watch 的應用程式。影片的重點將放在如何點擊購買按鈕、確認購買、並實時更新使用者介面，處理交易狀態等相關功能。

# 建立 SwiftUI 專案與設計使用者介面
![CleanShot 2024-07-11 at 15.08.51](https://hackmd.io/_uploads/rJxzHWpvR.png)
- 使用 Xcode 13 beta 1 創建一個新的 iOS 專案，名為 Apple Store，並使用 Swift 語言。
- 將一張 Apple Watch 的圖片添加到專案的 Assets 資料夾中。
- 設計簡單的使用者介面，包括標題、圖片和購買按鈕，使用 VStack 佈局元件，調整字型大小、圖片比例等細節。

# 導入 StoreKit 並設定環境
![CleanShot 2024-07-11 at 16.07.06](https://hackmd.io/_uploads/rkBTMfTPR.png)

- 在項目中導入 StoreKit 框架，確保可以使用最新的 StoreKit 2 功能。
- 調整專案的最小部署目標至 iOS 15，以使用今年新釋出的 API。

# 實作產品資訊取得與購買功能

- 創建一個 ViewModel 類別，擴展 ObservableObject，用於處理產品資訊的獲取和購買功能。
- 實作 `fetchProducts` 函式，使用 async/await 模式從 App Store 異步取得產品資訊。
- 實作 `purchase` 函式，以產品作為參數，用於執行購買操作，並處理可能的錯誤。

# 整合與測試

- 在 ContentView 中使用 `@StateObject` 創建 ViewModel 實例，並調用 `fetchProducts` 方法以初始化時獲取產品資訊。
- 調整按鈕的動作，使其調用 ViewModel 的 `purchase` 方法以啟動購買流程。
- 使用 Xcode 中的 StoreKit 設定檔來設置和測試本地購買流程，以便在模擬器中進行功能測試。
![CleanShot 2024-07-11 at 16.55.42](https://hackmd.io/_uploads/By77CGTDR.png)
![CleanShot 2024-07-11 at 17.01.23](https://hackmd.io/_uploads/HJQFkm6DR.png)

![CleanShot 2024-07-11 at 17.02.18](https://hackmd.io/_uploads/S1chk7pPC.png)


![CleanShot 2024-07-11 at 16.58.06](https://hackmd.io/_uploads/r1J20MTv0.png)

![CleanShot 2024-07-11 at 17.04.35](https://hackmd.io/_uploads/S1HEeQawR.png)

![CleanShot 2024-07-11 at 17.06.08](https://hackmd.io/_uploads/Sk19gmTDC.png)

![CleanShot 2024-07-11 at 17.08.03](https://hackmd.io/_uploads/HyuQ-XaD0.png)

![CleanShot 2024-07-11 at 17.10.28](https://hackmd.io/_uploads/SyXs-mavA.png)
# 解決問題與調整

- 處理可能出現的 Swift UI 錯誤，例如在初始化時訪問狀態對象的問題，並根據需要調整程式碼結構。
- 優化程式碼，確保 ViewModel 的方法在正確的時間點被調用，以避免應用程式初始化過程中的錯誤。

![CleanShot 2024-07-11 at 17.18.17](https://hackmd.io/_uploads/H1hwX7pw0.png)

# 更新 UI 顯示已購買產品
- 在 `Store.swift` 檔案中，將 `products` 集合設置為 `@Published` 屬性，以便在主隊列上分配產品後，通知 UI 更新。
- 在 `ContentView` 中，根據 `viewModel.purchaseIds` 是否為空來顯示購買按鈕或已購買標籤。

# 管理購買狀態
- 使用 `isPurchased` 函數來檢查產品是否已購買。這需要在成功獲取產品後執行，以更新購買狀態。
- 將已購買的產品 ID 添加到 `viewModel.purchaseIds`，並在購買成功後更新此集合。

# 處理購買操作和驗證
- 在購買按鈕被點擊後，呼叫相應的購買功能。處理 `product.purchaseResult` 的結果，並根據驗證狀態來更新 UI。
- 使用 `transaction` 物件來檢查驗證狀態，如果產品已經驗證，則將其添加到已購買集合中。

# 補充：調整 UI 和錯誤處理
- 在開發過程中，調整 UI 的細節很重要，例如按鈕顏色和標籤文字的顯示。
- 確保在處理錯誤時，使用 `do-catch` 來避免應用程序崩潰或未處理的錯誤。
![CleanShot 2024-07-11 at 18.33.44](https://hackmd.io/_uploads/HJeNSN6P0.png)


# 問題
## fetchProducts
```
func fetchProducts(){
    async{
        do{
            let products = try await Product.request(with:["com.apple.watch"])
            print(products)
        }catch{
            print(error)
        }
    }
}
```
出現了錯誤
```
Type 'Product' has no member 'request'
```

改成
```
func fetchProducts(){
    async{
        do{
            let products = try await Product.products(for: ["com.apple.watch"])
            print(products)
        }catch{
            print(error)
        }
    }
}
```


## 
```
Accessing StateObject's object without being installed on a View. This will create a new instance each time.
```
# 待處理
```
func fetchProducts(){
    async{
        do{
            let products = try await Product.products(for: ["com.apple.watch"])
            print(products)
        }catch{
            print(error)
        }
    }
}
```
```
'async(priority:operation:)' is deprecated: `async` was replaced by `Task.init` and will be removed shortly.
```

# 關鍵字
Interface：SwiftUI、Storyboard
Storage：SwiftData、Core Data
StoreKit Configuration
guard let product = products.first else {return}
- **StoreKit 2**：Apple 在 WWDC 2021 上發布的新框架，用於處理應用內購買。
- **SwiftUI**：Apple 的一種宣告式框架，用於構建 iOS 和其他 Apple 平台上的用戶界面。
- **Xcode 13 beta 1**：Apple 的集成開發環境 (IDE) 的測試版本，用於開發 iOS 和其他 Apple 平台的應用程式。
- **iOS 15**：Apple 的最新操作系統版本，在影片中設定為應用程式的最低部署目標，以使用最新的 API。
- **VStack**：SwiftUI 中的一種佈局結構，用於垂直排列視圖。
- **Image(systemName:)**：SwiftUI 中使用系統符號（如 Apple logo）來顯示圖像的方法。
- **AspectRatio**：用於設置圖像的寬高比，以保持圖像的正確顯示比例。
- **Button(action:label:)**：SwiftUI 中用於創建按鈕的方法，包含動作和標籤。
- **ObservableObject**：SwiftUI 中的一個協議，允許對象發布變更通知，從而更新 UI。
- **@StateObject**：SwiftUI 中的一種屬性包裝器，用於在視圖中創建和管理可觀察對象的生命週期。
- **Async**：Swift 中的一個關鍵字，表示函數是異步的，可以等待非阻塞操作完成。
- **Await**：Swift 中的一個關鍵字，用於等待異步操作完成。
- **Do-Catch**：Swift 中的錯誤處理語法，用於捕獲和處理可能引發的錯誤。
- **StoreKit Configuration File**：一種配置文件，用於在 Xcode 中本地測試 StoreKit 購買功能。
- **Resizable**：SwiftUI 中用於設置圖像可調整大小的修飾符。
- **System Font**：指使用系統預設字體的設置方法，例如設定字體大小和樣式。
- **Frame**：SwiftUI 中用於設置視圖尺寸和位置的修飾符。
- **ForegroundColor**：SwiftUI 中用於設置文本或圖像前景色的修飾符。
- **CornerRadius**：SwiftUI 中用於設置視圖圓角的修飾符。
- **Product**：StoreKit 2 中表示可供購買的產品實例。
- **Purchase**：StoreKit 2 中處理購買流程的方法。
- **Identifiers**：用於唯一標識 StoreKit 產品的標識符。
- **@Published**：Swift 中用於聲明可觀察對象屬性並自動發布變更通知的屬性包裝器。
- **Main Project Navigator**：Xcode 中左側的導航欄，用於瀏覽和管理專案文件。
- **Scheme**：Xcode 中一組設定，用於定義專案的構建和運行配置。
- **StoreKit Testing in Xcode**：使用 Xcode 進行 StoreKit 測試的功能，允許開發者在本地模擬和測試應用內購買。
- **Preview Device**：SwiftUI 中用於設置預覽設備的修飾符，方便在不同設備上查看 UI。
- **Global Instance**：在程式中定義的全局變量或實例，允許在不同作用域中訪問和使用。
- **Share Sheet**：iOS 中用於分享內容的界面，通常包含不同的分享選項。
- **Purchase Sheet**：應用內購買界面，用於確認和處理用戶購買操作。
- **Publishable Property**：使用 `@Published` 修飾符宣告的屬性，當其值改變時會通知視圖更新。
- **Main Queue**：主線程，處理 UI 更新和用戶交互的主要執行線程。
- **Display Name**：產品在應用內購買界面中的顯示名稱。
- **Display Price**：產品的顯示價格。
- **Verification**：檢查購買交易是否由 App Store 驗證的過程。
- **Unverified State**：交易未通過 App Store 驗證的狀態。
- **Transaction**：應用內購買交易的實體，包含產品 ID 和交易狀態。
- **Command B**：Xcode 中用於編譯專案的快捷鍵。
- **Guard Let**：Swift 中用於條件檢查的語法，當條件不滿足時退出當前作用域。
- **Configuration File**：用於設定和測試 StoreKit 功能的文件，包含產品 ID 和測試數據。
- **Scheme**：Xcode 中的構建和運行配置設定。
- **Simulator**：Xcode 中的 iOS 模擬器，用於在虛擬設備上運行和測試應用程式。
- **Switch Statement**：Swift 中用於條件檢查的語句，類似於其他語言中的 switch-case。
- **Optionals**：Swift 中的一種類型，可以包含值或為 nil，用於處理可能缺失的值。
- **Entitlements**：應用內購買產品的權限，用於檢查用戶是否擁有特定產品。
- **Resumable**：Swift 中的修飾符，用於設置視圖可以調整大小。
- **Command R**：Xcode 中用於運行專案的快捷鍵。
- **ViewModel**：用於管理視圖邏輯和數據的類，通常實現 `ObservableObject` 協議以便與 SwiftUI 結合使用。
- **App Store Connect**：Apple 的在線平台，用於管理應用程式和應用內購買產品。 
