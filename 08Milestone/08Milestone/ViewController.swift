//
//  ViewController.swift
//  08Milestone
//
//  Created by Maja Bevada on 14.04.2021..
//

import UIKit

class ViewController: UITableViewController {
    
    var shoppingList = [String]()
    var item: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Shopping list"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewItem))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(clearList))
    }
    
    @objc func clearList () {
        let ac = UIAlertController(title: "Do you want to delete shopping list?", message: "All items from list will be removed", preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.addAction(UIAlertAction(title: "Remove", style: .destructive, handler: removeAllItems))
                     
        present(ac, animated: true)
    }
    
    func removeAllItems (alert: UIAlertAction) {
        shoppingList.removeAll()
        tableView.reloadData()
    }
    
    @objc func addNewItem () {
        
        let cancleAction: UIAlertAction
        let addItemAction: UIAlertAction
    
        let ac = UIAlertController(title: "New Item", message: nil, preferredStyle: .alert)
        
        ac.addTextField()
        
        addItemAction = UIAlertAction(title: "Add", style: .default) { [weak self, weak ac] action in
            guard let newItem = ac?.textFields?[0].text else { return }
            self?.submit(newItem)
        }
        
        cancleAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        ac.addAction(addItemAction)
        ac.addAction(cancleAction)
        present(ac, animated: true)
    }
    
    func editItem (selected item: String, at indexPath: IndexPath) {
        
        let cancleAction: UIAlertAction
        let addItemAction: UIAlertAction
    
        let ac = UIAlertController(title: "Edit Item", message: nil, preferredStyle: .alert)
        
        ac.addTextField(configurationHandler: {(textField : UITextField!) -> Void in
            textField.text = item
        })
        
        addItemAction = UIAlertAction(title: "Edit", style: .default) { [weak self, weak ac] action in
            guard let newItem = ac?.textFields?[0].text else { return }
            self?.shoppingList.remove(at: indexPath.row)
            self?.tableView.deleteRows(at: [indexPath], with: .fade)
            self?.submit(newItem)
        }
        
        cancleAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        ac.addAction(addItemAction)
        ac.addAction(cancleAction)
        present(ac, animated: true)
    }
    
    func submit (_ item: String) {
        
        shoppingList.insert(item, at: 0)
        
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        return
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            shoppingList.count
        }
        
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (contextualAction, view, actionPerformed: (Bool) -> ()) in
            self.shoppingList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)            
        }
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let edit = UIContextualAction(style: .normal, title: "Edit") { (contextualAction, view, actionPerformed: (Bool) -> ()) in
            self.item = self.shoppingList[indexPath.row]
            self.editItem(selected: self.item, at: indexPath)
            
            actionPerformed(true)
        }
        edit.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        
        return UISwipeActionsConfiguration(actions: [edit])
    }
}

