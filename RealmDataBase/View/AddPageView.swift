//
//  AddPageView.swift
//  RealmDataBase
//
//  Created by gunta.golde on 02/09/2021.
//

import SwiftUI

struct AddPageView: View {
    @EnvironmentObject var modelData: RealmDataViewModel
    @Environment(\.presentationMode) var present
    
    var body: some View {
        NavigationView{
            List{
                Section(header: Text("Title")) {
                    TextField("",text: $modelData.title)
                }
                
                Section(header: Text("Deatil")) {
                    TextField("",text: $modelData.detail)
                }
            }.listStyle(GroupedListStyle())
            
            .navigationTitle(modelData.updateObject == nil ? "Add Note" : "Update Note")
            
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button(action: {
                        modelData.addData(presantation: present)
                    }, label: {
                        Text("Done")
                    })
                }
                
                ToolbarItem(placement: .navigationBarLeading){
                    Button(action: {
                        present.wrappedValue.dismiss()
                    }, label: {
                        Text("Cancel")
                    })
                }
            }//toolbar
        }
        
        .onAppear(){
            modelData.setupInitialData()
        }
        .onDisappear(){
            modelData.deInitData()
        }
    }
}

struct AddPageView_Previews: PreviewProvider {
    static var previews: some View {
        AddPageView()
    }
}
