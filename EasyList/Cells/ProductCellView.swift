//
//  ProductCellView.swift
//  EasyList
//
//  Created by Роман on 14.01.2025.
//

import SwiftUI

struct ProductCellView: View {
    @ObservedObject var product: Product
    @StateObject var vm: ShoppingListViewModel
    var body: some View {
        HStack {
            Text(product.name ?? "")
                .opacity(product.complite ? 0.5 : 1)
            
            Spacer()
            
            Text(String(format: "%.2f", product.countUnit ))
                .opacity(product.complite ? 0.5 : 1)
            Text(product.unit ?? "")
                .opacity(product.complite ? 0.5 : 1)
                .padding(.trailing, 30)
            Button {
                vm.comlitinProduct(product: product)
            } label: {
                Image(systemName: product.complite ? "checkmark.square" : "square")
                    .foregroundStyle(product.complite ? .blue : .gray)
            }

        }
    }
}


