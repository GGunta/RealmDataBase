//
//  Task.swift
//  RealmDataBase
//
//  Created by gunta.golde on 01/09/2021.
//

import SwiftUI
import RealmSwift

class Task: Object, Identifiable {
    @objc dynamic var id: Date = Date()
    @objc dynamic var title = ""
    @objc dynamic var detail = ""
    
}
