//
//  TasksViewController.swift
//  ToDoListFireBase
//
//  Created by Саша Гужавин on 30.07.2021.
//

import UIKit
import Firebase

class TasksViewController: UIViewController {
    
    var person: Person!
    var ref: DatabaseReference!
    var tasks = Array<Task>()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let currentUser = Auth.auth().currentUser else {return}
        person = Person(user: currentUser)
        ref = Database.database().reference(withPath: "persons").child(String(person.uid)).child("tasks")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ref.observe(.value) { [weak self] snapshot in
            var _tasks = Array<Task>()
            for item in snapshot.children {
                let task = Task(snapshot: item as! DataSnapshot)
                _tasks.append(task)
            }
            self?.tasks = _tasks
            self?.tableView.reloadData()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        ref.removeAllObservers()
    }

    @IBAction func addTap(_ sender: UIBarButtonItem) {
        
        let allertController = UIAlertController(title: "New Task", message: "Add new task", preferredStyle: .alert)
        allertController.addTextField()
        let save = UIAlertAction(title: "Save", style: .default) { [weak self] _ in
            guard let textField = allertController.textFields?.first , textField.text != "" else {return}
            let task = Task(title: textField.text!, userId: (self?.person.uid)!)
            let taskRef = self?.ref.child(task.title.lowercased())
            taskRef?.setValue(task.convertToDictionary())
            
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
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.backgroundColor = .systemBlue
        let textLable = tasks[indexPath.row].title
        cell.textLabel?.text = textLable
        cell.textLabel?.textColor = .systemGray
        return cell
    }
    
    
}
