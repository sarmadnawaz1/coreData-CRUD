//
//  ViewController.swift
//  coreDataDemo
//
//  Created by sarmad on 11/10/24.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return item.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        let person = item[indexPath.row]
        let name = person.name ?? "Unknown"
        let gender = person.gender ?? "Unknown"
        let age = person.age
        cell?.textLabel?.text = "Person Name: \(name), Person Gender: \(gender), Person Age: \(age)"
        cell?.textLabel?.numberOfLines = 0
        return cell!
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { action, view, completionHandler in
            
            // which person to remove
            let personToRemove = self.item[indexPath.row]
            
            // remove the person
            
            self.context.delete(personToRemove)
            
            // save the data
            do {
                try self.context.save()
            } catch  {
                
            }
            
            // re fetch the data
            
            self.fetchPeople()
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPerson = self.item[indexPath.row]
        let alert = UIAlertController(title: "Edit", message: "Edit the details", preferredStyle: .alert)
        
        alert.addTextField {textField in
            textField.placeholder = "Name"
        }
        alert.addTextField {textField in
            textField.placeholder = "Gender"
        }
        alert.addTextField {textField in
            textField.placeholder = "Age"
            textField.keyboardType = .numberPad
        }
        
        alert.textFields?[0].text = selectedPerson.name
        alert.textFields?[1].text = selectedPerson.gender
        alert.textFields?[2].text = "\(selectedPerson.age)"
        
        let editAction = UIAlertAction(title: "Add", style: .default) {_ in
            guard
                let name = alert.textFields?[0].text, !name.isEmpty,
                let gender = alert.textFields?[1].text, !gender.isEmpty,
                let textage = alert.textFields?[2].text, let age = Int(textage)
            else {
                return
            }
            
            
            // edit the data
            selectedPerson.name = name
            selectedPerson.gender = gender
            selectedPerson.age = Int16(age)
            
            // save the data
            do {
                try self.context.save()
            }
            catch {
                
            }
            
            // refetch the data
            
            self.fetchPeople()
            
        }
        
        alert.addAction(editAction)
        present(alert, animated: true)
        
        
        
    }
    
    // Reference to managed object context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // data for the table
    var item: [Person] = []
    
    
    
    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // tableView DataSource and Delegate
        tableView.dataSource = self
        tableView.delegate = self
        
        (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        
        // Get item from the CoreData
        fetchPeople()
    }
    
    func fetchPeople() {
        // fetch the data from the coreData to display on the tableView
        do {
            self.item = try context.fetch(Person.fetchRequest())
            
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            debugPrint("The error is \(error)")
        }
        
        
        
    }
    
    func addNewPerson(name: String, gender: String, age: Int) {
        let newPerson = Person(context: context)
        newPerson.name = name
        newPerson.gender = gender
        newPerson.age = Int16(age)
        
        do {
            try context.save()
            fetchPeople() //refresh People array
        } catch  {
            debugPrint("There's an error \(error)")
        }
    }
    
    @IBAction func barButtonTapped(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "New Person", message: "Enter Details", preferredStyle: .alert)
        
        alert.addTextField {textField in
            textField.placeholder = "Name"
        }
        alert.addTextField {textField in
            textField.placeholder = "Gender"
        }
        alert.addTextField {textField in
            textField.placeholder = "Age"
            textField.keyboardType = .numberPad
        }
        
        let addAction = UIAlertAction(title: "Add", style: .default) {_ in
            guard
                let name = alert.textFields?[0].text, !name.isEmpty,
                let gender = alert.textFields?[1].text, !gender.isEmpty,
                let textage = alert.textFields?[2].text, let age = Int(textage)
            else {
                return
            }
            self.addNewPerson(name: name, gender: gender, age: age)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    
    
    
    


}

