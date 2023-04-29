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
    var arrOfPrices = [NSNumber]()
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrOfNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ItemTableViewCell
        
        cell.descTxt.text = arrOfDescs[indexPath.row]
        cell.nameTxt.text = arrOfNames[indexPath.row]
        cell.priceTxt.text = arrOfPrices[indexPath.row].stringValue
        
        return cell
    }
    
    func loadData() {
        // Load Data based on existing array
        arrOfNames.removeAll()
        arrOfDescs.removeAll()
        arrOfPrices.removeAll()
        
        // Select All and insert into array
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Hio")
        
        do {
            
            let results = try context.fetch(request) as! [NSManagedObject]
            print(results)
            for data in results {
                print("test")
                arrOfDescs.append(data.value(forKey: "desc") as! String)
                arrOfNames.append(data.value(forKey: "name") as! String)
                arrOfPrices.append(data.value(forKey: "price") as! NSNumber)
                
            }
            
            itemTV.reloadData()
            
        } catch {
            print("Fetch data failed")
        }
    }
    
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
        itemTV.delegate = self
        itemTV.dataSource = self
        
        loadData()
    }

}
