//
//  ExerciseClassTableViewController.swift
//  Get Jüge
//
//  Created by Albert Kragl on 2017-12-25.
//  Copyright © 2017 Albert Kragl. All rights reserved.
//

import UIKit
import os.log

class ExerciseClassTableViewController: UITableViewController {
    
    // MARK: Properties
    public var exercises = [ExerciseClass]();
    
    @IBAction func myUnwindAction(unwindSegue: UIStoryboardSegue) {}
    
    @IBAction func unwindToExerciseListAdd(sender: UIStoryboardSegue) {
        
        if let sourceViewController = sender.source as? AddExerciseViewController, let newExercise = sourceViewController.newExercise {
            
                // Add a new exercise
                let newIndexPath = IndexPath(row: exercises.count, section: 0)
                
                exercises.append(newExercise)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }

        if let sourceViewController = sender.source as? EditExerciseViewController, let updatedExercise = sourceViewController.updatedExercise {
            
            if let selectedIndexPath = mainTableView.indexPathForSelectedRow {
                // Update an existing exercise
                exercises[selectedIndexPath.row] = updatedExercise
                mainTableView.reloadRows(at: [selectedIndexPath], with: .none) 
            }
        }
        
        // Save the exercises
        saveExercises()
    }
    
    @IBOutlet var mainTableView: UITableView!
    
    var EditExerciseViewControllerVariable: EditExerciseViewController = EditExerciseViewController(nibName: nil, bundle: nil)
    
    // MARK: Private Methods
    
    // Used for testing
    /*
    private func loadSampleExercises() {
        
        // Create some sample exercises for testing
        guard let exercise1 = ExerciseClass(name: "Deadlift", weight: 205, date: Date()) else {
            fatalError("Instantiation failed");
        }
        
        guard let exercise2 = ExerciseClass(name: "Barbell Row", weight: 115, date: Date()) else {
            fatalError("Instantiation failed");
        }
        
        guard let exercise3 = ExerciseClass(name: "Bench Press", weight: 115, date: Date()) else {
            fatalError("Instantiation failed");
        }
        
        // Add exercises to array
        exercises += [exercise1, exercise2, exercise3];
    }
    */
    
    private func saveExercises() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(exercises, toFile: ExerciseClass.ArchiveURL.path)
        
        if isSuccessfulSave {
            os_log("Exercises successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save exercises.", log: OSLog.default, type: .error)
        }
    }
    
    // MARK: Public methods
    
    public func addExercise(exercise: ExerciseClass) {
        exercises.append(exercise)
        
        let indexPath = IndexPath(row: exercises.count - 1, section: 0)
        mainTableView.beginUpdates()
        mainTableView.insertRows(at: [indexPath], with: .automatic)
        mainTableView.endUpdates()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //loadSampleExercises()
        
        // Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem
        
        if let savedExercises = loadExercises() {
            exercises += savedExercises
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercises.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "ExerciseClassTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ExerciseClassTableViewCell else {
            fatalError("The dequeued cell is not an instance of ExerciseClassTableViewCell")
        }
        
        let exercise = exercises[indexPath.row]

        // Configure the cell...
        
        cell.nameOfExercise.text = exercise.name
        cell.weight.text = "\(exercise.weight)" + " lbs"

        return cell
    }

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            exercises.remove(at: indexPath.row)
            saveExercises()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "AddExercise":
            os_log("Adding a new exercise.", log: OSLog.default, type: .debug)
            
        case "ShowDetail":
            guard let NavigationController = segue.destination as? EditExerciseNavigationController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedExerciseCell = sender as? ExerciseClassTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = mainTableView.indexPath(for: selectedExerciseCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }

            //EditExerciseViewControllerVariable.updatedExercise = exercises[indexPath.row]
            let selectedExercise = exercises[indexPath.row]
            EditExerciseNavigationController.selectedExercise = selectedExercise
            
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
        
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    
    private func loadExercises() -> [ExerciseClass]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: ExerciseClass.ArchiveURL.path) as? [ExerciseClass]
    }
    
}
