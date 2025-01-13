//
//  AddListView.swift
//  EasyList
//
//  Created by Роман on 13.01.2025.
//

import SwiftUI

struct AddListView: View {
    @StateObject var vm: ShoppingListViewModel
    var body: some View {
        ZStack {
            //MARK: - Background
            Color.main.ignoresSafeArea()
            
            //MARK: - Main stack
            VStack(spacing: 15) {
                //MARK: - Top toolbar
                HStack {
                    //MARK: - Back button
                    Button {
                        vm.presentAddView()
                        vm.clearData()
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundStyle(.black)
                    }

                    Spacer()
                    
                    //MARK: - Title view
                    Text("New shopping list")
                        .foregroundStyle(.black)
                        .font(.system(size: 22, weight: .bold))
                        .padding(.leading)
                    
                    Spacer()
                    
                    Button {
                        vm.addList()
                        vm.presentAddView()
                    } label: {
                        Text("Save")
                            .opacity(vm.simpleListName.isEmpty ? 0.3 : 1)
                    }
                    .disabled(vm.simpleListName.isEmpty ? true : false)
   
                }
                Divider()
                
                //MARK: - List name
                VStack(alignment: .leading) {
                    Text("Product list name")
                        .foregroundStyle(.black)
                        .font(.system(size: 16))
                    TextField("Enter list name", text: $vm.simpleListName)
                }
                
                Divider()
                
                //MARK: - List of product
                ScrollView{
                    VStack(alignment: .leading, spacing: 15){
                        Text("List")
                            .foregroundStyle(.black)
                            .font(.system(size: 16))
                        
                        ForEach(vm.simpleProducts) { product in
                            SimpleProductCell(vm: vm, produnct: product)
                            Divider()
                        }
                        
                        //MARK: - New product
                        HStack {
                            TextField("Product", text: $vm.simpleProductName)
                            TextField("0", text: $vm.simpleCount)
                                .keyboardType(.numberPad)
                                .frame(width: 30)
                            Picker(vm.simpleInit.rawValue, selection: $vm.simpleInit) {
                                ForEach(InitProduct.allCases , id: \.self) { unit in
                                    Text(unit.rawValue)
                                }
                            }
                        }
                        Divider()
                        //MARK: - Add button for simple list of products
                        HStack{
                            Spacer()
                            Button {
                                vm.addToSimpleProduct()
                            } label: {
                                Image(systemName: "plus.circle")
                            }
                            Spacer()

                        }
                    }
                }
                Spacer()
            }
            
            .padding()
            
        }
        .alert("You can add a maximum of 10 items", isPresented: $vm.maxLimitProducts) {
            VStack{
                Button("Save and new") {
                    ///
                }
                Button("Save and exit") {
                    ///
                }
                Button("Back") {
                    vm.maxLimitProducts = false
                }
            }

        } message: {
            Text("You can save this list and exit, or save this list and create another one")
        }

    }
}

#Preview {
    AddListView(vm: ShoppingListViewModel())
}

struct CustomAlertView: View {
    @Binding var showSheet: Bool

    var body: some View {
        VStack(spacing: 20) {
            Text("Выберите действие")
                .font(.headline)
            
            Button("Кнопка 1") { print("Нажата кнопка 1"); showSheet = false }
            Button("Кнопка 2") { print("Нажата кнопка 2"); showSheet = false }
            Button("Кнопка 3") { print("Нажата кнопка 3"); showSheet = false }
            Button("Закрыть") { showSheet = false }
        }
        .padding()
    }
}
