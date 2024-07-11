//
//  ContentView.swift
//  iOSAcademy-SwiftUIStoreKit2AppleWatchWithIAP
//
//  Created by RainBowT on 2024/7/11.
//

import SwiftUI 

struct ContentView: View {
    
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        VStack{
            Image(systemName: "applelogo")
                .resizable()
                .aspectRatio(nil,contentMode: .fit)
                .frame(width: 70,height: 70)
            
            Text("Apple Store")
                .bold()
                .font(.system(size: 32))
            
            Image("apple_watch_se")
                .resizable()
                .aspectRatio(nil,contentMode: .fit)
            
            if let product = viewModel.products.first{
                Text(product.displayName).padding(.top, 10)
                Text(product.description).padding(.top, 10)
                Button(action:{
                    if viewModel.purchasedIds.isEmpty{
                        viewModel.purchase()
                    }
                }){
                    Text(viewModel.purchasedIds.isEmpty ? "Buy Now (\(product.price)" : "Purchased")
                        .bold()
                        .foregroundColor(Color.white)
                        .frame(width: 220,height: 50)
                        .background(viewModel.purchasedIds.isEmpty ? Color.blue : Color.green)
                        .cornerRadius(8)
                }.padding(.top, 10)
            }
        }
        .onAppear{
            viewModel.fetchProducts()
        }
    }
}

#Preview {
    ContentView()
}
