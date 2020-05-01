//
//  ViewController.swift
//  tableView
//
//  Created by abdulrahman on 4/11/20.
//  Copyright © 2020 abdulrahmanAbdou. All rights reserved.
//

import UIKit

class ChecklistVC: UITableViewController {

    
    
    var todoList: ToDoList
    
    // cast a number into enum
    private func priorityForIndexSection(_ index: Int)-> ToDoList.Periority?{
        return ToDoList.Periority(rawValue: index)
    }
    
    // this is called when this viewController is initialized from storyboard
    required init?(coder: NSCoder) {
        
        todoList = ToDoList()
        
        super.init(coder: coder)
    }
    
    @IBAction func addItem(_ sender: Any) {
        let newRowIndex = todoList.todoList(for: .medium).count
        _ = todoList.addNewItem()

        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
    }
    
    @IBAction func deleteItems(_ sender: Any) {
        if let selectedRows = tableView.indexPathsForSelectedRows{
            
            for indexPath in selectedRows{
                if let priority = priorityForIndexSection(indexPath.section){
                    let todos = todoList.todoList(for: priority)
                    
                    let rowToDelete = indexPath.row > todos.count - 1 ? todos.count - 1 : indexPath.row
                    
                    let item = todos[rowToDelete]
                    todoList.remove(item, from: priority, at: rowToDelete)
                }
            }
            tableView.beginUpdates()
            tableView.deleteRows(at: selectedRows, with: .automatic)
            tableView.endUpdates()
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.leftBarButtonItem = editButtonItem
        
        // allow to multiple selection in tableview
        tableView.allowsMultipleSelectionDuringEditing = true
        
        
        /*
            UILocalizedIndexedCollation:
            - provides the first letter of a language'a alphabit
            - automaticaly configured based on locale
         */
        
    }


    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: true)
        tableView.setEditing(tableView.isEditing, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let priority = priorityForIndexSection(section){
            return todoList.todoList(for: priority).count
        }
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as? ChecklistVCCell else {return UITableViewCell()}
        
        if let priority = priorityForIndexSection(indexPath.section){
            let item = todoList.todoList(for: priority)[indexPath.row]
            configText(for: cell, with: item)
            configureCheckMark(for: cell, with: item)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.isEditing{
            return
        }
        
        else{
            if let cell = tableView.cellForRow(at: indexPath) as? ChecklistVCCell{
                if let priority = priorityForIndexSection(indexPath.section){
                    let item = todoList.todoList(for: priority)[indexPath.row]
                    item.toggleChecked()
                    configureCheckMark(for: cell, with: item)
                    tableView.deselectRow(at: indexPath, animated: true)
                }
            }
        }
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if let priority = priorityForIndexSection(indexPath.section){
            let item = todoList.todoList(for: priority)[indexPath.row]
            todoList.remove(item, from: priority, at: indexPath.row)
            let indexPath = [indexPath]
            tableView.deleteRows(at: indexPath, with: .automatic)
        }
        
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        if let srcPriority = priorityForIndexSection(sourceIndexPath.section), let destPriority = priorityForIndexSection(destinationIndexPath.section){
            
            let item = todoList.todoList(for: srcPriority)[sourceIndexPath.row]
            todoList.move(item: item, from: srcPriority, at: sourceIndexPath.row, to: destPriority, to: destinationIndexPath.row)
        }
        
        tableView.reloadData()
    }
    
    func configText(for cell: ChecklistVCCell, with item: CheckListItem){
        cell.textLbl.text = item.text
    }
    
    func configureCheckMark(for cell: ChecklistVCCell, with item: CheckListItem){
        if item.checked{
            cell.checkLbl.text = "√"
        }else{
            cell.checkLbl.text = ""
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return ToDoList.Periority.allCases.count
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "AddItemSegue"{
            if let addItemVC = segue.destination as? AddItemVC{
                addItemVC.addItemDelegate = self
                addItemVC.todoList = todoList
            }
            
        }else if segue.identifier == "EditItemSegue"{
            
            if let addItemVC = segue.destination as? AddItemVC{
                if let cell = sender as? UITableViewCell,
                    let indexPath = tableView.indexPath(for: cell),
                    let priority = priorityForIndexSection(indexPath.section){
                    
                    let item = todoList.todoList(for: priority)[indexPath.row]
                    addItemVC.itemToEdit = item
                    addItemVC.addItemDelegate = self
                    
                }
            }
        }
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title: String? = nil
        if let priority = priorityForIndexSection(section){
            switch priority {
            case .high:
                title =  "High Priority Todos"
            case .medium:
                title =  "mediam Priority Todos"
            case .low:
                title =  "low Priority Todos"
            case .no:
                title =  "someday Priority Todos"
            }
        }
        return title
    }

}
extension ChecklistVC: AddItemDelegate{
    func addItemVCDidCancel(_ addItemVC: AddItemVC) {
        navigationController?.popViewController(animated: true)
    }
    
    func addItemVC(_ addItemVC: AddItemVC, didFinishAdding item: CheckListItem) {
        navigationController?.popViewController(animated: true)
        
        let rowIndex = todoList.todoList(for: .medium).count - 1
        //todoList.todos.append(item)
        let indexPath = IndexPath(row: rowIndex, section: ToDoList.Periority.medium.rawValue)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
    }
    
    func addItemVC(_ addItemVC: AddItemVC, didFinishEditing item: CheckListItem) {
        
        for priority in ToDoList.Periority.allCases{
            let currentList = todoList.todoList(for: priority)
            if let index = currentList.firstIndex(of: item){
                let indexPath = IndexPath(row: index, section: priority.rawValue)
                if let cell = tableView.cellForRow(at: indexPath) as? ChecklistVCCell{
                    configText(for: cell, with: item)
                }
            }
        }
        navigationController?.popViewController(animated: true)
    }
    
}
