//
//  RealmProvider.swift
//  streetLights
//
//  Created by Валентина on 30/03/2019.
//  Copyright © 2019 Валентина. All rights reserved.
//

import Foundation
import RealmSwift
import CSV
import MapKit

class RealmProvider {
    static var configuration : Realm.Configuration{
        return Realm.Configuration(deleteRealmIfMigrationNeeded: true)
    }
    
    static func get<T: Object>(_ type: T.Type, in realm: Realm? = try? Realm(configuration: RealmProvider.configuration)) -> Results<T>? {
        return realm?.objects(type)
    }
    
    static func cleanTables (){
        let realm = try! Realm(configuration: RealmProvider.configuration)
        try! realm.write {
            realm.delete(realm.objects(RealmLight.self))
        }
    }
    
    @discardableResult
    static func saveToDB<T : Object>(items : [T], update : Bool) -> Realm { //with update
        let realm = try! Realm(configuration: RealmProvider.configuration)
        print(RealmProvider.configuration.fileURL!)
        do {
            try realm.write {
                realm.add(items, update: update)
            }
        }
        catch{
            print(error.localizedDescription)
        }
        return realm
    }
    
    static func parseData(filePath : String){
        let stream = InputStream(fileAtPath: filePath)!
        let csv = try! CSVReader(stream: stream)
        let rowOfTiltes = csv.next()
        print(rowOfTiltes!)
        var i = 0
        while let row = csv.next() {
                print("\(row)")
                let lat = CLLocationDegrees(exactly: Float(row[2])!)
                let long = CLLocationDegrees(exactly: Float(row[1])!)
                let coordinate = CLLocationCoordinate2DMake(lat!, long!)
                let realmLight = RealmLight()
                realmLight.latitude = row[2]
                realmLight.longitude = row[1]
                realmLight.assetStatus = row[3]
                realmLight.assetType = row[4]
                realmLight.condition = row[5]
                realmLight.crossStreet = row[6]
                realmLight.globalID = row[7]
                realmLight.isModifiedDesc = row[8]
                realmLight.lightHistory = row[9]
                realmLight.lightsManufacturerDesc = row[10]
                realmLight.lightType = row[11]
                realmLight.owner = row[12]
                realmLight.powerFeed = row[13]
                realmLight.roadClassification = row[14]
                realmLight.streetLightID = row[15]
                realmLight.street = row[16]
                realmLight.ward = row[17]
                realmLight.wattage1 = row[18]
                realmLight.whyInactive = row[19]
                realmLight.isBroken = row[21]
            realmLight.breakdownTime = String((row[20].split(separator: " "))[0])
                RealmProvider.saveToDB(items: [realmLight], update: false)
                i = i + 1

        }
    }
    
}
