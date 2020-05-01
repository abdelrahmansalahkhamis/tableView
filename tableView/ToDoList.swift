//
//  ToDoList.swift
//  tableView
//
//  Created by abdulrahman on 4/12/20.
//  Copyright © 2020 abdulrahmanAbdou. All rights reserved.
//

import Foundation

class ToDoList{
    
    enum Periority: Int, CaseIterable {
        case high, medium, low, no
    }
    
    private var highPeriorityTodos: [CheckListItem] = []
    private var mediumPeriorityTodos: [CheckListItem] = []
    private var lowPeriorityTodos: [CheckListItem] = []
    private var noPeriorityTodos: [CheckListItem] = []
    
    var todos: [CheckListItem] = []
    
    
    init(){
        let row0Item = CheckListItem()
        let row1Item = CheckListItem()
        let row2Item = CheckListItem()
        let row3Item = CheckListItem()
        let row4Item = CheckListItem()
        let row5Item = CheckListItem()
        let row6Item = CheckListItem()
        let row7Item = CheckListItem()
        let row8Item = CheckListItem()
        let row9Item = CheckListItem()
        
        row0Item.text = "take a jog"
        row1Item.text = "watch a movie"
        row2Item.text = "code an app"
        row3Item.text = "walk the dog"
        row4Item.text = "play a game"
        row5Item.text = "eat fresh food"
        row6Item.text = "perform unit testing"
        row7Item.text = "impelement ui design"
        row8Item.text = "walk in the park"
        row9Item.text = "test your code"
        
        addTodo(row0Item, for: .medium)
        addTodo(row1Item, for: .high)
        addTodo(row2Item, for: .low)
        addTodo(row3Item, for: .no)
        addTodo(row4Item, for: .low)
        addTodo(row5Item, for: .high)
        addTodo(row6Item, for: .medium)
        addTodo(row7Item, for: .no)
        addTodo(row8Item, for: .high)
        addTodo(row9Item, for: .medium)
    }
    
    func addNewItem()-> CheckListItem{
        let item = CheckListItem()
        item.text = "new item row"
        mediumPeriorityTodos.append(item)   // mediam preority by default
        item.text = randomTitles()
        item.checked = true
        return item
    }
    
    func addTodo(_ item: CheckListItem, for priority: Periority, at index: Int = -1){
        switch priority {
            case .high:
                if index < 0{
                    highPeriorityTodos.append(item)
                }else{
                    highPeriorityTodos.insert(item, at: index)
                }
                
            case .medium:
                if index < 0{
                    mediumPeriorityTodos.append(item)
                }else{
                    mediumPeriorityTodos.insert(item, at: index)
                }
            case .low:
                if index < 0{
                    lowPeriorityTodos.append(item)
                }else{
                    lowPeriorityTodos.insert(item, at: index)
                }
            case .no:
                if index < 0{
                    noPeriorityTodos.append(item)
                }else{
                    noPeriorityTodos.insert(item, at: index)
                }
        }
    }
    
    func todoList(for priority: Periority) -> [CheckListItem]{
        switch priority {
            case .high:
                return highPeriorityTodos
            case .medium:
                return mediumPeriorityTodos
            case .low:
                return lowPeriorityTodos
            case .no:
                return noPeriorityTodos
        }
    }
    
    func move(item: CheckListItem, from sourcePriority: Periority, at sourceIndex: Int, to destinationPriority: Periority, to destinationIndex: Int){
        remove(item, from: sourcePriority, at: sourceIndex)
        addTodo(item, for: destinationPriority, at: destinationIndex)
    }
    
    
    func remove(_ item: CheckListItem, from priority: Periority, at index: Int){
        switch priority {
            case .high:
                highPeriorityTodos.remove(at: index)
            case .medium:
                mediumPeriorityTodos.remove(at: index)
            case .low:
                lowPeriorityTodos.remove(at: index)
            case .no:
                noPeriorityTodos.remove(at: index)
        }
    }
    
    private func randomTitles()-> String{
        let titles = ["new ToDo Item", "Generic ToDo", "Fill me out", "I need something to do", "much to do abount nothing"]
        let randomNumber = Int.random(in: 0...titles.count - 1)
        return titles[randomNumber]
    }
}
