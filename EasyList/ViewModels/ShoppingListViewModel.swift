//
//  ShopListViewmOdel.swift
//  EasyList
//
//  Created by Роман on 13.01.2025.
//

import Foundation
import CoreData

final class ShoppingListViewModel: ObservableObject {
    let manager = CoreDataManager.instance
    
    @Published var shoppingLists: [ShopList] = []
    @Published var archiveList: [ShopList] = []
    @Published var simpleList: ShopList?
    
    @Published var simpleListName = ""
    @Published var simpleProductName = ""
    @Published var simpleInit: InitProduct = .kg
    @Published var simpleCount = ""
    @Published var simpleProducts: [Product] = []
    
    //MARK: Preset propertyes
    @Published var isPresentAddView: Bool = false
    @Published var isPresentListView: Bool = false
    @Published var isPresentShare: Bool = false
    @Published var isPresentArchiveView: Bool = false
    
    //MARK: alert proertyes
    @Published var maxLimitProducts: Bool = false
    @Published var isPresentDeleteAlert: Bool = false
    @Published var isPresentArchiveAlert = false
    
    @Published var isArchiveMode = false
    
    init(){
        getData()
        getArchiveList()
    }
    
    func getArchiveList(){
        archiveList.removeAll()
        for shoppingList in shoppingLists {
            if shoppingList.archive {
                archiveList.append(shoppingList)
            }
        }
    }
    
    //MARK: - Get complted Data
    func getCountComlited(list: ShopList) -> Int{
        var countComlited: Int = 0
        if let products = list.products?.allObjects as? [Product] {
            products.forEach {
                if $0.complite {
                    countComlited += 1
                }
            }
        }
        return countComlited
    }
    
    func getAllComlited(list: ShopList) -> Bool{
        var result: Bool = false
        let countComplites = getCountComlited(list: list)
        if let products = list.products?.allObjects as? [Product] {
            if countComplites == products.count {
                result = true
            }else{
                result = false
            }
        }
        return result
    }
    
    //MARK: - Tap button fun
    func presentedArchiveAlert(){
        isPresentArchiveAlert.toggle()
    }
    
    func tapArchiveList(list: ShopList){
        simpleList = list
        simpleListName = list.name ?? ""
        if let products = list.products?.allObjects as? [Product] {
            simpleProducts = products
        }
        presentArchiveview()
    }
    
    func tapList(list: ShopList){
        simpleList = list
        simpleListName = list.name ?? ""
        if let products = list.products?.allObjects as? [Product] {
            simpleProducts = products
        }
        presentListView()
    }
    
    //MARK: - Core data func
    func removeToArchive(){
        guard let simpleList else { return }
        simpleList.archive = false
        saveData()
        presentArchiveview()
        getArchiveList()
    }
    
    func sendToarchive(){
        guard let simpleList else { return }
        simpleList.archive = true
        saveData()
        presentListView()
        getArchiveList()
    }
    
    func comlitinProduct(product: Product){
        product.complite.toggle()
        saveData()
    }
    
    func deleteList(){
        guard let simpleList else { return }
        if let products = simpleList.products?.allObjects as? [Product] {
            for product in products {
                manager.context.delete(product)
            }
        }
        manager.context.delete(simpleList)
        saveData()
        clearData()
        presentListView()
    }
    
    func deleteInSimpleProduct(product: Product) {
        simpleProducts.removeAll(where: { $0 === product })
    }
    
    
    func addToSimpleProduct() {
        if simpleProductName == "" { return }
        
        if simpleProducts.count == 9 {
            maxLimitProducts = true
            return
        }
        
        let newProduct = Product(context: manager.context)
        newProduct.name = simpleProductName
        newProduct.unit = simpleInit.rawValue
        newProduct.countUnit = Double(simpleCount) ?? 0
        simpleProducts.append(newProduct)
        simpleProductName = ""
        simpleInit = .kg
        simpleCount = ""
    }
    
    func addList() {
        let newList = ShopList(context: manager.context)
        newList.name = simpleListName
        for simpleProduct in simpleProducts {
            let newProduct = Product(context: manager.context)
            newProduct.name = simpleProduct.name
            newProduct.unit = simpleProduct.unit
            newProduct.countUnit = simpleProduct.countUnit
            newProduct.shopList = newList
        }
        saveData()
        clearData()
    }
    
    func getData() {
        let request = NSFetchRequest<ShopList>(entityName: "ShopList")
        do{
            shoppingLists = try manager.context.fetch(request)
        }catch let error{
            print("error fetch list:\(error)")
        }
    }
    func saveData() {
        shoppingLists.removeAll()
        manager.save()
        getData()
    }
    
    func clearData(){
        simpleListName = ""
        simpleInit = .kg
        simpleProducts.removeAll()
        simpleProductName = ""
        simpleCount = ""
        
    }
    //MARK: - Presentetion func
    func presentAddView() {
        isPresentAddView.toggle()
    }
    
    func presentListView() {
        isPresentListView.toggle()
        
    }
    
    func presentDeleteAlert() {
        isPresentDeleteAlert.toggle()
    }
    
    func presentArchiveview() {
        isPresentArchiveView.toggle()
    }
}
