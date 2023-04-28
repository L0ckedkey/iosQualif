//
//  LoginViewController.swift
//  AkongHIo
//
//  Created by prk on 28/04/23.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {

    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var usernameTxt: UITextField!
    var context:NSManagedObjectContext!
    

    @IBAction func loginButton(_ sender: Any) {
        
               
        let username = usernameTxt.text as! String
        let password = passwordTxt.text as! String
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        request.predicate = NSPredicate(format: "username == %@ AND password == %@", username, password)
        
        do {
            let result = try context.fetch(request) as! [NSManagedObject]
            
            // Login null or not, cek the size of array
            if result.count == 0 {
                print("Login Failed")
            } else {
                print("Login Successfull")
                
                // Redirect to Home Page
                if let nextView = storyboard?.instantiateViewController(withIdentifier: "HomeViewController") {
                    navigationController?.pushViewController(nextView, animated: true)
                }
            }
            
        } catch {
            print("Fetch data failed")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        // Do any additional setup after loading the view.
    }

}
