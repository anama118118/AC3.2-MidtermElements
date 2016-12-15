//
//  ElementsTableViewController.swift
//  AC3.2-MidtermElements
//
//  Created by Ana Ma on 12/8/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class ElementsTableViewController: UITableViewController {

    let elementCellIdentifier = "elementCellIdentifier"
    var elementsArr: [Element] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        APIRequestManager.manager.getData(endPoint: "https://api.fieldbook.com/v1/58488d40b3e2ba03002df662/elements") { (data: Data?) in
            guard let validData = data else { return }
            //dump(validData)
            guard let validElements = Element.getElements(data: validData) else {
                return
            }
            self.elementsArr = validElements
            //dump(self.elementsArr)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.elementsArr.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.elementCellIdentifier, for: indexPath)
        let element = elementsArr[indexPath.row]
        let detailText = "\(element.symbol)(\(element.number))  \(element.weight)"
        
        cell.textLabel?.text = element.name
        cell.detailTextLabel?.text = detailText
        
        cell.imageView?.image = #imageLiteral(resourceName: "default-placeholder") //nil
        
        APIRequestManager.manager.getData(endPoint: "https://s3.amazonaws.com/ac3.2-elements/\(element.symbol)_200.png") { (data: Data?) in
            guard let validImageData = data else { return }
            DispatchQueue.main.async {
                cell.imageView?.image = UIImage(data: validImageData)
                cell.setNeedsLayout()
            }
        }
        return cell
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "elementDetailViewSegue" {
            if let elementDetailViewController = segue.destination as? ElementDetailViewController,
                let cell = sender as? UITableViewCell,
                let indexPath = tableView.indexPath(for: cell){
                let selectedElement = elementsArr[indexPath.row]
                elementDetailViewController.element = selectedElement
            }
        }
    }
}
