//
//  RealmDataViewModel.swift
//  RealmDataBase
//
//  Created by gunta.golde on 01/09/2021.
//

import SwiftUI
import RealmSwift

class RealmDataViewModel: ObservableObject {
   
    //data
    @Published var title = ""
    @Published var detail = ""
    @Published var openNewPage = false
    
    //Fetch data
    @Published var cards: [Task] = []
    
    //data update
    @Published var updateObject: Task?
    
    init() {
        fetchData()
    }
    
    //fetching data
    func fetchData(){
        guard let realm = try? Realm() else {return}
        
        let results = realm.objects(Task.self)
        self.cards = results.compactMap({ card in
            return card
        })
    }
    //add
    func addData(presantation: Binding<PresentationMode>){
        if title == "" || detail == "" {return}
        
        let card = Task()
        card.title = title
        card.detail = detail
        
        guard let realm = try? Realm() else {return}
        
        try? realm.write {
            guard let availableObject = updateObject else{
                realm.add(card)
                return
            }
            availableObject.title = title
            availableObject.detail = detail
        }
        fetchData()
        
        presantation.wrappedValue.dismiss()
    }
    
    //delete
    func deleteData(object: Task){
        guard let realm = try? Realm() else {return}
        
        try? realm.write {
            realm.delete(object)
            fetchData()
        }
    }
    
    
    func setupInitialData(){
        guard let updateData = updateObject else {return}
        
        title = updateData.title
        detail = updateData.detail
    }
    
    func deInitData(){
        updateObject = nil
        title = ""
        detail = ""
    }
 
}
