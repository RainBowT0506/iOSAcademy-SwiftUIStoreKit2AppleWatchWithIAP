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
    
    @Published var products: [Product] = []
    @Published var purchasedIds: [String] = []
    
    func fetchProducts(){
        async{
            do{
                let products = try await Product.products(for: ["com.apple.watch"])
                
                DispatchQueue.main.async {
                    self.products = products
                }
                
                if let product = products.first{
                    await isPurchased(product: product)
                }
            }catch{
                print(error)
            }
        }
    }
    
    func isPurchased(product: Product) async{
        guard let product = products.first else{
            print("no products")
            return
        }
        
        guard let state = try await product.currentEntitlement else{
            return
        }
        
        print("Checking state")
        
        switch state{
        case .unverified(_):
            print("unverified")
            break
        case .verified(let transaction):
            print("verified")
            DispatchQueue.main.async{
                self.purchasedIds.append(transaction.productID)
            }
            break
        }
    }
    
    func purchase(){
        async{
            guard let product = products.first else {return}
            do{
                let result = try await product.purchase()
                switch result{
                case .success(let verification):
                    switch verification{
                    case .unverified(_):
                        break
                    case .verified(let transaction):
                        DispatchQueue.main.async{
                            self.purchasedIds.append(transaction.productID)
                        }
                        break
                    }
                    break
                case .userCancelled:
                    break
                case .pending:
                    break
                @unknown default:
                    break
                }
            }catch{
                print(error)
            }
        }
    }
}
