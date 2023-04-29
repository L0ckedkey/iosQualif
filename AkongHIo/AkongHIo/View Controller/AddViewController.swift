//
//  AddViewController.swift
//  AkongHIo
//
//  Created by prk on 28/04/23.
//

import UIKit
import CoreData

class AddViewController: UIViewController {


    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var descTxt: UITextField!
    @IBOutlet weak var priceTxt: UITextField!
    @IBOutlet weak var categoryTxt: UITextField!
    var context:NSManagedObjectContext!

    
    @IBAction func AddButton(_ sender: Any) {
        let name = nameTxt.text as! String
        let desc = descTxt.text as! String
        let price = priceTxt.text as! String
        let category = categoryTxt.text as! String
        print("desc : "   + desc)
        print("name : "   + name)
        print("price : "   + price)
        print("cate : "   + category)
        
        if name.isEmpty == false && desc.isEmpty == false && price.isEmpty == false && category.isEmpty == false && name.count > 5{
            
            let entity = NSEntityDescription.entity(forEntityName: "Hio", in: context)
            let newUser = NSManagedObject(entity: entity!, insertInto: context)
            
            newUser.setValue(name + " " + category , forKey: "name")
            newUser.setValue(desc, forKey: "desc")
            newUser.setValue(Int(price), forKey: "price")
            
            if let nextView = storyboard?.instantiateViewController(withIdentifier: "HomeViewController") {
                navigationController?.pushViewController(nextView, animated: true)
            }
            
            print("Move to home")
        }else{
            print("form is empty")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        // Do any additional setup after loading the view.
    }

}
