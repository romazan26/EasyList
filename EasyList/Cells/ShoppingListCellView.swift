//
//  ShoppingListCellView.swift
//  EasyList
//
//  Created by Роман on 13.01.2025.
//

import SwiftUI

struct ShoppingListCellView: View {
    @ObservedObject var list: ShopList
    @StateObject var vm: ShoppingListViewModel
    var body: some View {
        ZStack {
            Color(vm.getAllComlited(list: list) ? .greenApp : .second)
                .cornerRadius(20)
            HStack{
                VStack(alignment: .leading ,spacing: 15) {
                    Text(list.name ?? "")
                        .font(.system(size: 20, weight: .bold))
                    
                    
                    Divider()
                    
                    if let products = list.products?.allObjects as? [Product]{
                        Text("\(vm.getCountComlited(list: list))/\(products.count) items")
                            .font(.system(size: 16))
                        ForEach(products.prefix(3)) { product in
                            Text(product.name ?? "")
                        }
                        if products.count > 3 {
                            Text("And \(products.count - 3) more")
                                .opacity(0.5)
                        }
                    }
                    
                    
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Image(systemName: "arrow.up.right")
                    Spacer()
                    if vm.getAllComlited(list: list){
                        Text("Complete")
                            .padding(8)
                            .background(Color.green.cornerRadius(10))
                    }
                }
            }
            .foregroundStyle(.black)
            .padding()
        }.frame( minHeight: 243)
    }
}

#Preview {
    ShoppingListCellView(list: ShopList(), vm: ShoppingListViewModel())
}
