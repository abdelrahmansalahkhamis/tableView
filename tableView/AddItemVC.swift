//
//  AddItem.swift
//  tableView
//
//  Created by abdulrahman on 4/15/20.
//  Copyright © 2020 abdulrahmanAbdou. All rights reserved.
//

import UIKit

protocol AddItemDelegate: class {
    func addItemVCDidCancel(_ addItemVC: AddItemVC)
    func addItemVC(_ addItemVC: AddItemVC, didFinishAdding item: CheckListItem)
    func addItemVC(_ addItemVC: AddItemVC, didFinishEditing item: CheckListItem)
}

class AddItemVC: UITableViewController {

    weak var addItemDelegate: AddItemDelegate?
    
    weak var todoList: ToDoList?
    weak var itemToEdit: CheckListItem?
    
    @IBOutlet weak var cancelBtn: UIBarButtonItem!
    @IBOutlet weak var addBtn: UIBarButtonItem!
    
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func cancelPressed(_ sender: Any) {
        addItemDelegate?.addItemVCDidCancel(self)
    }
    
    @IBAction func AddPressed(_ sender: Any) {
        
        if let item = itemToEdit, let text = textField.text{
            item.text = text
            addItemDelegate?.addItemVC(self, didFinishEditing: item)
        }
        else{
            if let item = todoList?.addNewItem(){
                if let textFieldText = textField.text{
                    item.text = textFieldText
                }
                item.checked = false
                addItemDelegate?.addItemVC(self, didFinishAdding: item)
            }
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationItem.largeTitleDisplayMode = .never
        
        if let item = itemToEdit{
            title = "Edit Item"
            addBtn.isEnabled = true
            textField.text = item.text
        }
        
        textField.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        textField.becomeFirstResponder()
    }

    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
}


// in order to react to textfield events

extension AddItemVC: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let oldText = textField.text, let stringRande = Range(range, in: oldText) else{return false}
        
        let newText = oldText.replacingCharacters(in: stringRande, with: string)
        if newText.isEmpty{
            addBtn.isEnabled = false
        }else{
            addBtn.isEnabled = true
        }
        return true
    }
    
}
