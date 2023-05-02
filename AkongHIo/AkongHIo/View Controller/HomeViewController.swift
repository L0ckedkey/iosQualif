//
//  HomeViewController.swift
//  AkongHIo
//
//  Created by prk on 28/04/23.
//

import UIKit
import CoreData

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var itemTV: UITableView!
    var context:NSManagedObjectContext!
    var arrOfNames = [String]()
    var arrOfDescs = [String]()
    var arrOfPrices = [String]()
    
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var descTxt: UITextField!
    @IBOutlet weak var priceTxt: UITextField!
    
    @IBAction func aboutUsButton(_ sender: Any) {
        if let nextView = storyboard?.instantiateViewController(withIdentifier: "AddViewController") {
            navigationController?.pushViewController(nextView, animated: true)
        }
    }
    @IBAction func addButton(_ sender: Any) {
        let name = nameTxt.text as! String
        let desc = descTxt.text as! String
        let price = priceTxt.text as! String

        print("desc : "   + desc)
        print("name : "   + name.uppercased())
        print("price : "   + price)
        
        if name.isEmpty == false && desc.isEmpty == false && price.isEmpty == false && name.count > 5{
            
            let entity = NSEntityDescription.entity(forEntityName: "Hio2", in: context)
            let newUser = NSManagedObject(entity: entity!, insertInto: context)
            
            newUser.setValue(name.uppercased(), forKey: "name")
            newUser.setValue(desc.capitalized, forKey: "desc")
            newUser.setValue(price, forKey: "price")
            
            do {
               try context.save()
               loadData()
           }
           catch {
               
           }
            
            print("Move to home")
        }else{
            print("form is empty")
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrOfNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ItemTableViewCell
        
        cell.descTxt.text = arrOfDescs[indexPath.row]
        cell.nameTxt.text = arrOfNames[indexPath.row]
        cell.priceTxt.text = arrOfPrices[indexPath.row]
        
        cell.updateHandler = {
            self.updateData(cell: cell, indexPath: indexPath)
        }
        cell.deleteHandler = {
            self.deleteData(indexPath: indexPath)
        }
        
        
        return cell
    }
    
    func deleteData(indexPath: IndexPath) {
        let name = arrOfNames[indexPath.row]
        let req = NSFetchRequest<NSFetchRequestResult>(entityName: "Hio2")
        req.predicate = NSPredicate(format: "name == %@", name)
        do {
            let res = try context.fetch(req) as! [NSManagedObject]
            for data in res {
                context.delete(data)
            }
            try context.save()
            loadData()
        }
        catch {
            
        }
    }
    
    func updateData(cell:ItemTableViewCell, indexPath: IndexPath){
        let oldName = arrOfNames[indexPath.row]
        let oldDesc = arrOfDescs[indexPath.row]
        let oldPrice = arrOfPrices[indexPath.row]
        let newDesc = cell.descTxt.text
        let newPrice = cell.priceTxt.text
        let req = NSFetchRequest<NSFetchRequestResult>(entityName: "Hio2")
        req.predicate = NSPredicate(format: "name==%@", oldName)
        do {
            let res = try context.fetch(req) as! [NSManagedObject]
            for todos in res {
                todos.setValue(newDesc, forKey: "desc")
                todos.setValue(newPrice, forKey: "price")
            }
            try context.save()
            loadData()
        } catch {
            
        }
    }
    
    func loadData() {
        // Load Data based on existing array
        arrOfNames.removeAll()
        arrOfDescs.removeAll()
        arrOfPrices.removeAll()
        
        // Select All and insert into array
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Hio2")
        
        do {
            
            let results = try context.fetch(request) as! [NSManagedObject]
            print(results)
            for data in results {
                print("test")
                arrOfDescs.append(data.value(forKey: "desc") as! String)
                arrOfNames.append(data.value(forKey: "name") as! String)
                arrOfPrices.append(data.value(forKey: "price") as! String)
                
            }
            
            itemTV.reloadData()
            
        } catch {
            print("Fetch data failed")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        itemTV.delegate = self
        itemTV.dataSource = self
        
        loadData()
    }

}
