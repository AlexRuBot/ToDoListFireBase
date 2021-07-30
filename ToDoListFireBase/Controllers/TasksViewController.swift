//
//  TasksViewController.swift
//  ToDoListFireBase
//
//  Created by Саша Гужавин on 30.07.2021.
//

import UIKit

class TasksViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func addTap(_ sender: UIBarButtonItem) {
        
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
