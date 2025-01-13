//
//  ArchiveListView.swift
//  EasyList
//
//  Created by Роман on 14.01.2025.
//

import SwiftUI

struct ArchiveListView: View {
    @StateObject var vm: ShoppingListViewModel
    var body: some View {
        VStack(spacing: 20) {
            //MARK: - top toolbar
            HStack{
                //MARK: - Clouse button
                Button(action: {vm.presentArchiveview()}) {
                    Image(systemName: "chevron.backward")
                        .foregroundStyle(.black)
                }
                Spacer()
                //MARK: - Name tool
                Text(vm.simpleListName)
                    .font(.system(size: 22))
                Spacer()
                
                //MARK: - Option button
                Menu("...") {
                    Button { vm.presentedArchiveAlert()} label: {
                        Label("Remove from archive", systemImage: "archivebox")
                    }
                    Button {vm.isPresentShare.toggle()} label: {
                        Label("Share", systemImage: "square.and.arrow.up")
                    }
                    Button(role: .destructive, action: {
                        vm.presentDeleteAlert()
                    }) {
                        Label("Delete", systemImage: "trash")
                    }
                }
            }
            
            ScrollView {
                ForEach(vm.simpleProducts) { product in
                    ProductCellView(product: product, vm: vm)
                        .padding(.vertical, 10)
                }
            }
            
            Spacer()
            
        }
        .padding()
        .alert("Delete this shopping list?", isPresented: $vm.isPresentDeleteAlert) {
            Button(role: .destructive) {
                vm.deleteList()
            } label: {
                Text("Delete")
            }
            
        }
        .alert("Remove from archive this shopping list?",
               isPresented: $vm.isPresentArchiveAlert) {
            HStack {
                Button("No", role: .cancel) {
                    vm.isPresentArchiveAlert.toggle()
                }
                Button("Yes") {
                    vm.removeToArchive()
                }
            }
        }
        .sheet(isPresented: $vm.isPresentShare, content: {
            ShareSheet(items: vm.simpleListName )
        })
        
    }
}

#Preview {
    ArchiveListView(vm: ShoppingListViewModel())
}
