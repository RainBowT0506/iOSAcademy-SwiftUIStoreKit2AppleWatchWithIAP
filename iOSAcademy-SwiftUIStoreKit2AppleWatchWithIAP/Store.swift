//
//  Store.swift
//  iOSAcademy-SwiftUIStoreKit2AppleWatchWithIAP
//
//  Created by RainBowT on 2024/7/11.
//

import SwiftUI
import StoreKit //StoreKit 2
import Foundation

//  Fetch Products
//  Purchase Product
//  Update UI / Fetch Product State

class ViewModel: ObservableObject{
    
    var products: [Product] = []
    
    func fetchProducts(){
        async{
            do{
                let products = try await Product.products(for: ["com.apple.watch"])
                self.products = products
                print(products)
            }catch{
                print(error)
            }
        }
    }
    
    func purchase(){
        async{
            guard let product = products.first else {return}
            do{
                let result = try await product.purchase()
                print(result)
            }catch{
                print(error)
            }
        }
    }
}
