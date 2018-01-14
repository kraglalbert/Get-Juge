//
//  ExerciseClassTableViewCell.swift
//  Get Jüge
//
//  Created by Albert Kragl on 2017-12-25.
//  Copyright © 2017 Albert Kragl. All rights reserved.
//

import UIKit

class ExerciseClassTableViewCell: UITableViewCell {
    
    // MARK: Properties
    
    @IBOutlet weak var nameOfExercise: UILabel!
    @IBOutlet weak var weight: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
