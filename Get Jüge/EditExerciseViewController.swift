//
//  EditExerciseViewController.swift
//  Get Jüge
//
//  Created by Albert Kragl on 2017-12-26.
//  Copyright © 2017 Albert Kragl. All rights reserved.
//

import UIKit
import os.log

class EditExerciseViewController: UIViewController {
    
    var updatedExercise: ExerciseClass?

    @IBOutlet weak var editName: UITextField!
    @IBOutlet weak var editWeight: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var editNameText: String?
    
    var myNavigationController: EditExerciseNavigationController = EditExerciseNavigationController(nibName: nil, bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //editName.text = updatedExercise?.name
        editName.text = EditExerciseNavigationController.selectedExercise?.name

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let button = sender as? UIBarButtonItem, button == saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }

        let exerciseName = editName.text ?? ""
        let weight = Double(editWeight.text!) ?? 0.0
        
        updatedExercise = ExerciseClass(name: exerciseName, weight: weight, date: Date())
        
    }


}
