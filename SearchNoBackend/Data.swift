//
//  Data.swift
//  SearchNoBackend
//
//  Created by Josh R on 10/29/18.
//  Copyright © 2018 Josh R. All rights reserved.
//

import Foundation

class Todo {
    var name: String
    var isDone: Bool = false
    
    init(name: String) {
        self.name = name
    }

}


var todos = [
    Todo(name: "Buy milk"),
    Todo(name: "Pay bills"),
    Todo(name: "Drop lunch off at school"),
    Todo(name: "Pay friend $10"),
    Todo(name: "Eat healthy"),
    Todo(name: "go to the gym"),
    Todo(name: "Save money for new car"),
]
