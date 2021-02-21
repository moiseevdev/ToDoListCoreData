//
//  TableViewController.swift
//  ToDoListCoreData
//
//  Created by Андрей Моисеев on 20.02.2021.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {

    var tasks: [Task] = []
    
    @IBAction func saveTask(_ sender: UIBarButtonItem) {
        
        let alertController = UIAlertController(title: "New task", message: "Enter a new task", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default) { action in
            let textField = alertController.textFields?.first
            if let newTaskTitle = textField?.text {
                self.saveTask(withTitle: newTaskTitle)
                self.tableView.reloadData()
            }
        }
        
        alertController.addTextField { _ in }
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive) { _ in }
        //let testAction = UIAlertAction(title: "test", style: .default) { _ in }
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        //alertController.addAction(testAction)
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    private func saveTask(withTitle title: String) {
        let context = getContext()
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Task", in: context) else { return }
        
        let taskObject = Task(entity: entity, insertInto: context)
        taskObject.tittle = title
        
        do {
            try context.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
    }
    
    private func getContext() ->NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let context = getContext()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tasks.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let task = tasks[indexPath.row]
        cell.textLabel?.text = task.tittle
        
        return cell
    }



}
