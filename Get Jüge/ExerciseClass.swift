//
//  ExerciseClass.swift
//  Get Jüge
//
//  This class represents a generic exercise that the user may create
//
//  Created by Albert Kragl on 2017-12-25.
//  Copyright © 2017 Albert Kragl. All rights reserved.
//

import Foundation
import os.log

class ExerciseClass: NSObject, NSCoding {
    
    // MARK: Properties
    
    var name: String
    var weight: Double
    var date: Date
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("exercises")
    
    // MARK: Types
    
    struct PropertyKey {
        static let name = "name"
        static let weight = "weight"
        static let date = "date"
    }
    
    // MARK: Constructor
    
    init?(name: String, weight: Double, date: Date) {
        if (name.isEmpty || weight < 0) {
            return nil;
        }
        
        self.name = name;
        self.weight = weight;
        self.date = date;
    }
    
    // MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(weight, forKey: PropertyKey.weight)
        aCoder.encode(date, forKey: PropertyKey.date)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for an ExcerciseClass object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        let weight = aDecoder.decodeDouble(forKey: PropertyKey.weight)
        let date = aDecoder.decodeObject(forKey: PropertyKey.date)
        
        // Must call designated initializer.
        self.init(name: name, weight: weight, date: date as! Date)
    }
    
}
