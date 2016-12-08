//
//  ElementDetailViewController.swift
//  AC3.2-MidtermElements
//
//  Created by Ana Ma on 12/8/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class ElementDetailViewController: UIViewController {
    
    var element: Element!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var meltingPointLabel: UILabel!
    @IBOutlet weak var boilingPointLabel: UILabel!
    @IBOutlet weak var densityLabel: UILabel!
    @IBOutlet weak var crustPercentLabel: UILabel!
    @IBOutlet weak var discoveryYearLabel: UILabel!
    @IBOutlet weak var groupLabel: UILabel!
    @IBOutlet weak var electronsLabel: UILabel!
    @IBOutlet weak var ionEnergyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dump(self.element)
        APIRequestManager.manager.getData(endPoint: "https://s3.amazonaws.com/ac3.2-elements/\(self.element.symbol).png") { (data: Data?) in
            guard let validData = data else { return }
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: validData)
                self.imageView.reloadInputViews()
                //self.view.reloadInputViews()
            }
        }
        if let validMP = self.element.melting_c{
            self.meltingPointLabel.text = "Melting Point: \(validMP)"
        } else {
            self.meltingPointLabel.text = "Melting Point: N/A"
        }
        if let validBP = self.element.boiling_c {
            self.boilingPointLabel.text = "Boiling Point: \(validBP)"
        } else {
            self.boilingPointLabel.text = "Boiling Point: N/A"
        }
        if let validDensity = self.element.density {
             self.densityLabel.text = "Density: \(validDensity)"
        } else {
            self.densityLabel.text = "Density: N/A"
        }
        if let validCrust = self.element.crust_percent {
            self.crustPercentLabel.text = "Crust Percent: \(validCrust)"
        } else {
            self.crustPercentLabel.text = "Crust Percent: N/A"
        }
        if let validElectrons = self.element.electrons {
            self.electronsLabel.text = "Electrons: \(validElectrons)"
        } else {
            self.electronsLabel.text = "Electrons: N/A"
        }
        if let validIonEnergy = self.element.ion_energy {
            self.ionEnergyLabel.text = "Ion Energy: \(validIonEnergy)"
        }else {
            self.ionEnergyLabel.text = "Ion Energy: N/A"
        }
        self.navigationItem.title = element.name
        self.symbolLabel.text = "\(self.element.symbol)"
        self.numberLabel.text = "\(self.element.number)"
        self.weightLabel.text = "\(self.element.weight)"
        self.discoveryYearLabel.text = "Discovery Year: \(self.element.discovery_year)"
        self.groupLabel.text = "Group: \(self.element.group)"
    }
    
    @IBAction func myFavoriteElementPostAction(_ sender: UIButton) {
        let dict: [String: Any] = ["my_name": "Ana Ma", "favorite_element": "\(self.element.name)"]
        APIRequestManager.manager.postRequest(endPoint: "https://api.fieldbook.com/v1/58488d40b3e2ba03002df662/favorites", data: dict)
    }
}
