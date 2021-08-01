//
//  TasksViewController.swift
//  ToDoListFireBase
//
//  Created by Саша Гужавин on 30.07.2021.
//

import UIKit
import Firebase

class TasksViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func addTap(_ sender: UIBarButtonItem) {
        
        let allertController = UIAlertController(title: "New Task", message: "Add new task", preferredStyle: .alert)
        allertController.addTextField()
        let save = UIAlertAction(title: "Save", style: .default) { _ in
            guard let textField = allertController.textFields?.first , textField.text != "" else {return}
            
            // расписать добавлние информации в бд и на сервер
            
            
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        allertController.addAction(save)
        allertController.addAction(cancel)
        
        present(allertController, animated: true, completion: nil)
        
    }
    @IBAction func signOutTap(_ sender: UIBarButtonItem) {
        do{
           try Auth.auth().signOut()
        } catch {
            print(error.localizedDescription)
        }
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - TableView Delegate, DataSource
extension TasksViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.backgroundColor = .clear
        cell.textLabel?.text = "Number \(indexPath.row)"
        cell.textLabel?.textColor = .systemBlue
        return cell
    }
    
    
}
