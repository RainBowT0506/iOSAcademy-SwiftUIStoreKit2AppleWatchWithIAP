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
                .frame(width: 70,height: 70)
            
            Text("Apple Store")
                .bold()
                .font(.system(size: 32))
            
            Image("apple_watch_se")
                .resizable()
                .aspectRatio(nil,contentMode: .fit)
            
            Button(action:{
                viewModel.purchase()
            }){
                Text("Buy Now")
                    .bold()
                    .foregroundColor(Color.white)
                    .frame(width: 220,height: 50)
                    .background(Color.green)
                    .cornerRadius(8)
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
