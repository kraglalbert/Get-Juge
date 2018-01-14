//
//  AddExerciseViewController.swift
//  Get Jüge
//
//  Created by Albert Kragl on 2017-12-25.
//  Copyright © 2017 Albert Kragl. All rights reserved.
//

import UIKit
import os.log

class AddExerciseViewController: UIViewController {

    let homeViewController: ExerciseClassTableViewController = ExerciseClassTableViewController();
    var newExercise: ExerciseClass?
    
    // MARK: Properties
    @IBOutlet weak var userText: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    // Not sure if this actually does anything
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        guard let newExercise = ExerciseClass(name: userText.text!, weight: 0.0, date: Date()) else {
            fatalError("Instantiation failed");
        }
        
        homeViewController.addExercise(exercise: newExercise)
    }
    

    
    // MARK: Preset methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let button = sender as? UIBarButtonItem, button === doneButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let exerciseName = userText.text ?? ""
        
        newExercise = ExerciseClass(name: exerciseName, weight: 0.0, date: Date())
        
    }

}
