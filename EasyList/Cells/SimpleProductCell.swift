//
//  SimpleProductCell.swift
//  EasyList
//
//  Created by Роман on 13.01.2025.
//

import SwiftUI

struct SimpleProductCell: View {
    @StateObject var vm: ShoppingListViewModel
    @ObservedObject var produnct: Product
    var body: some View {
        HStack(spacing: 10) {
            Text(produnct.name ?? "")
                
            Spacer()
            Text(String(format: "%.2f", produnct.countUnit ))
            Text(produnct.unit ?? "")
            Button {
                vm.deleteInSimpleProduct(product: produnct)
            } label: {
                Image(systemName: "xmark.circle")
                    .foregroundStyle(.red)
            }

        }
        .foregroundStyle(.black)
            .font(.system(size: 16))
    }
}

