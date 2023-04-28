//
//  HomeViewController.swift
//  AkongHIo
//
//  Created by prk on 28/04/23.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {

    var context:NSManagedObjectContext!
    
    
    @IBAction func addButton2(_ sender: Any) {
        do {
            try context.save()
            
            // Auto redirect to Login Page
            
            if let nextView = storyboard?.instantiateViewController(withIdentifier: "AddViewController") {
                navigationController?.pushViewController(nextView, animated: true)
            }
        }
        catch {
            print("Insert NewUser Failed")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        // Do any additional setup after loading the view.
    }

}
