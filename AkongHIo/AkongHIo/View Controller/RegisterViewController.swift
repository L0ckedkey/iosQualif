//
//  RegisterViewController.swift
//  AkongHIo
//
//  Created by prk on 28/04/23.
//

import UIKit
import CoreData

class RegisterViewController: UIViewController {

    
    
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var confPasswordTxt: UITextField!
    
    var context:NSManagedObjectContext!
    
    @IBAction func registerButton(_ sender: Any) {
        
        let username = usernameTxt.text as! String
        let password = passwordTxt.text as! String
        let confPassword = confPasswordTxt.text as! String

        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
               
        request.predicate = NSPredicate(format: "username == %@", username)
        
        
        
        // forKey = attributes in DB
        
        
        do {
            let result = try context.fetch(request) as! [NSManagedObject]
            try context.save()
            
            if username.isEmpty == false && password.isEmpty == false && confPassword.isEmpty == false{
                if result.count > 0 {
                   print("Register Failed username is used")
               } else {
                   if password == confPassword{
                       
                       let entity = NSEntityDescription.entity(forEntityName: "Users", in: context)
                       
                       let newUser = NSManagedObject(entity: entity!, insertInto: context)
                       
                       newUser.setValue(username, forKey: "username")
                       newUser.setValue(password, forKey: "password")
                    
                       print("Register Success")
                       
                       if let nextView = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") {
                           navigationController?.pushViewController(nextView, animated: true)
                       }
                       
                   }else{
                       print("Password not match")
                   }
               }
            }else{
                print("Form is empty")
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
