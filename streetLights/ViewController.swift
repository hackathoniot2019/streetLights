//
//  ViewController.swift
//  streetLights
//
//  Created by Валентина on 30/03/2019.
//  Copyright © 2019 Валентина. All rights reserved.
//

import UIKit
import RealmSwift
import Realm
import MapKit
import CSV

class ViewController: UIViewController, MKMapViewDelegate{
    var status = false
    var realmLights = [RealmLight]()
    var dots = [StreetLight]()
    var mapView = MKMapView()
    let slideMenu = SlideOutMenu()
    let detailsCard = DetailsCard()
    let hamburgerButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "hamburgerMenu"), for: .normal)
        button.addTarget(self, action: #selector(handleMenu), for: .touchUpInside)
        return button
    }()
    
    let searchButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "search"), for: .normal)
        button.addTarget(self, action: #selector(handleSearch), for: .touchUpInside)
        return button
    }()
    
    @objc func handleSearch() {
        if status {
            let searchController = SearchTableViewController()
            self.present(searchController, animated: true, completion: nil)
        } else {
            detailsCard.dismissCard()
            self.mapView.selectedAnnotations = []
            let searchController = SearchTableViewController()
            self.present(searchController, animated: true, completion: nil)
        }
    }
    
    @objc func handleMenu() {
        if status {
            slideMenu.configureUnderView()
        } else {
            detailsCard.dismissCard()
            slideMenu.configureUnderView()
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        detailsCard.originYOfHamburger = hamburgerButton.frame.origin.y
        detailsCard.hamburger = hamburgerButton
        detailsCard.search = searchButton
        detailsCard.configureUnderView()
        let coord = view.annotation!.coordinate
        let light = self.dots.first{
            $0.coordinate.latitude == coord.latitude && $0.coordinate.longitude == coord.longitude
        }
        let detailedLight = self.realmLights.first{
            $0.streetLightID == light!.id
        }
        print(detailedLight)
        detailsCard.tableView.reloadData()
        detailsCard.currentLight = detailedLight!
        detailsCard.streetLabel.text = light!.street
        detailsCard.idLabel.text = light!.id
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?
    {
        if !(annotation is StreetLight) {
            return nil
        }
        
        let annotationIdentifier = "AnnotationIdentifier"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            annotationView!.canShowCallout = true
        }
        else {
            annotationView!.annotation = annotation
        }
        if (annotation as! StreetLight).isBroken == "False"{
            let pinImage = UIImage(named: "red")
            annotationView!.image = pinImage
        }
        else{
        let pinImage = UIImage(named: "green")
        annotationView!.image = pinImage
        }
        
        return annotationView
    }

    
    func makeMapView() {
        mapView.frame = view.frame
        view.addSubview(mapView)
        self.mapView.delegate = self
    }
    
    func configureHamburgerMenu() {
        view.addSubview(hamburgerButton)
        hamburgerButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leadingAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 30, paddingBottom: 0, paddingRight: 0, width: 40, height: 40, enableInsets: false)
    }
    
    func configureSearch() {
        view.addSubview(searchButton)
        searchButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: view.trailingAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: -30, width: 40, height: 40, enableInsets: false)
        
    }
    func startTimer(){
        let timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(fire), userInfo: nil, repeats: false)
    }
    
    @objc func fire()
    {
        if RealmProvider.get(RealmLight.self) != nil {
            RealmProvider.cleanTables()
        }
        RealmProvider.parseData(filePath: "/Users/Valentina/Desktop/StreetLights_DF2_FINAL_.csv")
        prepareLights()
        uploadLightsFromDB()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeMapView()
        configureHamburgerMenu()
        configureSearch()
        if RealmProvider.get(RealmLight.self) != nil {
            RealmProvider.cleanTables()
            self.realmLights = Array(RealmProvider.get(RealmLight.self)!)
        }
        RealmProvider.parseData(filePath: "/Users/Valentina/Desktop/StreetLights_DF1_FINAL.csv")
        let lights = RealmProvider.get(RealmLight.self)!
        print(lights)
        prepareLights()
//        startTimer()
}
    func prepareLights(){
        let lights = RealmProvider.get(RealmLight.self)!
        print(lights)
        var lightsToShow = [StreetLight]()
        var savedlights = Array(lights)
        savedlights.map{
            let lat = CLLocationDegrees(exactly: Float($0.latitude)!)
            let long = CLLocationDegrees(exactly: Float($0.longitude)!)
            var coordinate = CLLocationCoordinate2DMake(lat!, long!)
            let new = StreetLight(title: "", street: $0.street, coordinate: coordinate, id : $0.streetLightID, isBroken : $0.isBroken)
            
            lightsToShow.append(new)
        }
        self.dots = lightsToShow
        self.centerMapOnLocation(light: lightsToShow[200])//
        self.mapView.addAnnotations(lightsToShow)
        uploadLightsFromDB()
    }
   
    func addLight(light : StreetLight){
        self.mapView.addAnnotation(light)
    }
    
    func uploadLightsFromDB(){
        self.realmLights = Array(RealmProvider.get(RealmLight.self)!)
    }
    
    func centerMapOnLocation(light : StreetLight) {
        let regionRadius: CLLocationDistance = 1500
        let coordinateRegion = MKCoordinateRegion(center: light.coordinate,
                                                      latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        self.mapView.setRegion(coordinateRegion, animated: true)}
}
