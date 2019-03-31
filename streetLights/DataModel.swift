//
//  DataModel.swift
//  streetLights
//
//  Created by Валентина on 30/03/2019.
//  Copyright © 2019 Валентина. All rights reserved.
//
import Realm
import RealmSwift
import Foundation
import MapKit
class StreetLight: NSObject, MKAnnotation {
    let title: String?
    let street: String
    let coordinate: CLLocationCoordinate2D
    let isBroken : String
    let id : String
    
    init(title: String, street: String, coordinate: CLLocationCoordinate2D, id : String, isBroken : String) {
        self.title = title
        self.street = street
        self.coordinate = coordinate
        self.id = id
        self.isBroken = isBroken
        super.init()
    }
    
    var subtitle: String? {
        return street
    }
}

class RealmLight : Object {
//    @objc dynamic var title: String = ""
    @objc dynamic var street: String = ""
    @objc dynamic var latitude: String = ""
    @objc dynamic var longitude : String = ""
    @objc dynamic var assetStatus : String = ""
    @objc dynamic var assetType : String = ""
    @objc dynamic var condition : String = ""
    @objc dynamic var crossStreet : String = ""
//    @objc dynamic var fixtureTypeDesc : String = ""
    @objc dynamic var globalID : String = ""
//    @objc dynamic var inOperation : String = ""
//    @objc dynamic var isMeteredDesc : String = ""
    @objc dynamic var isModifiedDesc : String = ""
    @objc dynamic var lightHistory : String = ""
    @objc dynamic var lightsManufacturerDesc : String = ""
    @objc dynamic var lightType : String = ""
//    @objc dynamic var numberLights : String = ""
    @objc dynamic var owner : String = ""
//    @objc dynamic var proximity : String = ""
    @objc dynamic var powerFeed : String = ""
    @objc dynamic var roadClassification : String = ""
//    @objc dynamic var shieldDesc : String = ""
    @objc dynamic var streetLightID : String = ""
//    @objc dynamic var streetName : String = ""
    @objc dynamic var ward : String = ""
    @objc dynamic var wattage1 : String = ""
    @objc dynamic var whyInactive : String = ""
    @objc dynamic var isBroken : String = ""
    @objc dynamic var breakdownTime : String = ""
}
enum Status : String{
    case assistant = "assistant"
    case head0fDepartment = "head of department"
}

class User {
    @objc dynamic var name : String = ""
    @objc dynamic var surname : String = ""
    @objc dynamic var status : Status.RawValue?
}

