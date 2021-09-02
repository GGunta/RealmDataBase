//
//  ContentView.swift
//  RealmDataBase
//
//  Created by gunta.golde on 01/09/2021.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var modelData = RealmDataViewModel()
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(spacing: 15) {
                    ForEach(modelData.cards) { card in
                        VStack(alignment: .leading, spacing: 10, content: {
                            Text(card.title)
                            Text(card.detail)
                                .font(.caption)
                                .foregroundColor(.gray)
                        })
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(10)
                        .background(Color.secondary.opacity(0.2))
                        .cornerRadius(10)
                        .contentShape(RoundedRectangle(cornerRadius: 10))
                        .contextMenu(ContextMenu(menuItems: {
                            Button(action: {
                                modelData.deleteData(object: card)
                            }, label: {
                                Text("Delete Item")
                            })
                            
                            Button(action: {
                                modelData.updateObject = card
                                modelData.openNewPage.toggle()
                            }, label: {
                                Text("Update Item")
                            })
                            
                        }))
                    }
                }//vsatck
                .padding()
            }//scrollView
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button(action: {
                        modelData.openNewPage.toggle()
                        addMore()
                    }, label: {
                        Image(systemName: "doc.fill.badge.plus")
                            
                    })
                }
            }//toolbar
            
            .sheet(isPresented: $modelData.openNewPage, content: {
                AddPageView()
                    .environmentObject(modelData)
            })
            
            .navigationBarTitle("RealmDB", displayMode: .large)
        }.navigationViewStyle(StackNavigationViewStyle())
    }
    
    func addMore(){
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
