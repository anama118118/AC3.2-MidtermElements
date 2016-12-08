//
//  Element.swift
//  AC3.2-MidtermElements
//
//  Created by Ana Ma on 12/8/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import Foundation

enum ElementModelParseError: Error {
    case arrayOfDict
    case element
    case id
    case record_url
    case number
    case weight
    case name
    case symbol
    case melting_c
    case boiling_c
    case density
    case crust_percent
    case discovery_year
    case group
    case electrons
    case ion_energy
}

class Element {
    let id: Int
    let record_url: String
    let number: Int
    let weight: Int
    let name: String
    let symbol: String
    let melting_c: Int?
    let boiling_c: Int?
    let density: Double?
    let crust_percent: Double?
    let discovery_year: String
    let group: Int
    let electrons: String?
    let ion_energy: Double?
    
    init( id: Int,
        record_url: String,
        number: Int,
        weight: Int,
        name: String,
        symbol: String,
        melting_c: Int?,
        boiling_c: Int?,
        density: Double?,
        crust_percent: Double?,
        discovery_year: String,
        group: Int,
        electrons: String?,
        ion_energy: Double?) {
        self.id = id
        self.record_url = record_url
        self.number = number
        self.weight = weight
        self.name = name
        self.symbol = symbol
        self.melting_c = melting_c
        self.boiling_c = boiling_c
        self.density = density
        self.crust_percent = crust_percent
        self.discovery_year = discovery_year
        self.group = group
        self.electrons = electrons
        self.ion_energy = ion_energy
    }
    
    convenience init? (dict: [String: AnyObject]) throws {
        guard let id = dict["id"] as? Int else {
            throw ElementModelParseError.id
        }
        guard let record_url = dict["record_url"] as? String else {
            throw ElementModelParseError.record_url
        }
        guard let number = dict["number"] as? Int else {
            throw ElementModelParseError.number
        }
        guard let weight = dict["weight"] as? Int else {
            throw ElementModelParseError.weight
        }
        guard let name = dict["name"] as? String else {
            throw ElementModelParseError.name
        }
        guard let symbol = dict["symbol"] as? String else {
            throw ElementModelParseError.symbol
        }
        let melting_c = dict["melting_c"] as? Int
        let boiling_c = dict["boiling_c"] as? Int
        let density = dict["density"] as? Double
        let crust_percent = dict["crust_percent"] as? Double
        guard let discovery_year = dict["discovery_year"] as? String else {
            throw ElementModelParseError.discovery_year
        }
        guard let group = dict["group"] as? Int else {
            throw ElementModelParseError.group
        }
        let electrons = dict["electrons"] as? String
        let ion_energy = dict["ion_energy"] as? Double

        self.init( id: id,
                   record_url: record_url,
                   number: number,
                   weight: weight,
                   name: name,
                   symbol: symbol,
                   melting_c: melting_c,
                   boiling_c: boiling_c,
                   density: density,
                   crust_percent: crust_percent,
                   discovery_year: discovery_year,
                   group: group,
                   electrons: electrons,
                   ion_energy: ion_energy)
    }
    
    static func getElements(data: Data) -> [Element]? {
        var elementArry: [Element] = []
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            guard let arrayOfDict = json as? [[String: AnyObject]] else {
                throw ElementModelParseError.arrayOfDict
            }
            try arrayOfDict.forEach({ (element) in
                guard let e = try Element(dict: element) else {
                    throw ElementModelParseError.element
                }
                elementArry.append(e)
            })
        }
        catch {
            print(error)
        }
        return elementArry
    }
}

/*
 {
    "id": 1,
    "record_url": "https://fieldbook.com/records/5848deac37802c0400b17c6b",
    "number": 1,
    "weight": 1.0079,
    "name": "Hydrogen",
    "symbol": "H",
    "melting_c": -259,
    "boiling_c": -253,
    "density": 0.09,
    "crust_percent": 0.14,
    "discovery_year": "1776",
    "group": 1,
    "electrons": "1s1",
    "ion_energy": 13.5984
 },
{
    "id": 109,
    "record_url": "https://fieldbook.com/records/5848dead37802c0400b17cd7",
    "number": 109,
    "weight": 268,
    "name": "Meitnerium",
    "symbol": "Mt",
    "melting_c": null,
    "boiling_c": null,
    "density": null,
    "crust_percent": null,
    "discovery_year": "1982",
    "group": 9,
    "electrons": null,
    "ion_energy": null
}
 */
