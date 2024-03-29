//
//  ViewController.swift
//  Core Data Demo
//
//  Created by Ishaan Sathaye on 7/29/19.
//  Copyright © 2019 NextGenTech. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // setup code to access CoreData
        var appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context:NSManagedObjectContext = appDel.persistentContainer.viewContext // set up context to work with the database
        
        
        // make a new user in the database
//        let newUser = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context) as NSManagedObject
//
//        newUser.setValue("Praseeda", forKey: "username")
//        newUser.setValue("password123", forKey: "password")
//
//        do {
//            try context.save()
//        } catch {
//            print("Failed saving")
//        }
        
        
        //fetch data from the database
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        request.returnsObjectsAsFaults = false
        
        // predicate = search criteria
        request.predicate = NSPredicate(format: "username = %@", "Siya") // tests if the username is equal to something // request a particular item
            
        do {
            
            let result = try context.fetch(request)
            
            if result.count > 0 {
                
                print(result)
                
                for item: AnyObject in result as! [NSManagedObject] {
                    
                    if let user = (item as AnyObject).value(forKey: "username") as? String { // show specfic value in database
                        
                        if user == "Siya" { // checks if the item is a specific user
                            
//                            context.delete(item as! NSManagedObject) // delete item in the result
//
//                            print(user + " has been deleted!")
                            
                            // update information for that user
                            item.setValue("something123", forKey: "password")
                            
                            do {
                                try context.save() // save the data in the database
                            } catch {
                                print("Failed saving")
                            }
                            
                        }
                        
                    }
            
                }
                
            } else {
                
                print("No results!")
                
            }
            
        } catch {
            print("Failed")
        }
        
    }
    
    
}

