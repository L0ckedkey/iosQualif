//
//  ItemTableViewCell.swift
//  AkongHIo
//
//  Created by prk on 29/04/23.
//

import UIKit

class ItemTableViewCell: UITableViewCell {

    
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var descTxt: UITextField!
    @IBOutlet weak var priceTxt: UITextField!
    
    @IBAction func UpdateButton(_ sender: Any) {
        
    }
    
    @IBAction func deleteButton(_ sender: Any) {
    
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
