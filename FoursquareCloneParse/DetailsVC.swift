//
//  DetailsVC.swift
//  FoursquareCloneParse
//
//  Created by Yahya Gönder on 20.06.2022.
//

import UIKit
import MapKit
import Parse

class DetailsVC: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var detailsNameLabel: UILabel!
    @IBOutlet weak var detailsTypeLabel: UILabel!
    @IBOutlet weak var detailsAtmosphereLabel: UILabel!
    
    @IBOutlet weak var detailsImageView: UIImageView!
    
    @IBOutlet weak var detailsMapView: MKMapView!
    
    var chosenPlaceID = ""
    
    var chosenLatitude = Double()
    var chosenLongitude = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        detailsMapView.delegate = self
        
        getDataFromParse()
        
    }
    
    func getDataFromParse() {
        
        let query = PFQuery(className: "Places")
        query.whereKey("objectId", equalTo: chosenPlaceID)
        query.findObjectsInBackground { objects, error in
            if error != nil {
                
            } else {
                if objects != nil {
                    if objects!.count > 0 {
                        let chosenObject = objects![0]
                        
                        //Objects
                        
                        if let placeName = chosenObject.object(forKey: "name") as? String {
                            self.detailsNameLabel.text = placeName
                        }
                        
                        if let placeType = chosenObject.object(forKey: "type") as? String {
                            self.detailsTypeLabel.text = placeType
                        }
                        
                        if let placeAtmosphere = chosenObject.object(forKey: "atmosphere") as? String {
                            self.detailsAtmosphereLabel.text = placeAtmosphere
                        }
                        
                        if let placeLatitude = chosenObject.object(forKey: "latitude") as? String {
                            if let placeLatitudeDouble = Double(placeLatitude) {
                                self.chosenLatitude = placeLatitudeDouble
                            }
                        }
                        
                        if let placeLongitude = chosenObject.object(forKey: "longitude") as? String {
                            if let placeLongitudeDouble = Double(placeLongitude) {
                                self.chosenLongitude = placeLongitudeDouble
                            }
                        }
                        
                        if let imageData = chosenObject.object(forKey: "image") as? PFFileObject {
                            imageData.getDataInBackground { data, error in
                                if error == nil {
                                    if data != nil {
                                        self.detailsImageView.image = UIImage(data: data!)
                                    }
                                }
                            }
                        }
                        
                        //Maps
                        
                        let location = CLLocationCoordinate2D(latitude: self.chosenLatitude, longitude: self.chosenLongitude)
                        
                        let span = MKCoordinateSpan(latitudeDelta: 0.035, longitudeDelta: 0.035)
                        
                        let region = MKCoordinateRegion(center: location, span: span)
                        
                        self.detailsMapView.setRegion(region, animated: true)
                        
                        let annotation = MKPointAnnotation()
                        annotation.coordinate = location
                        annotation.title = self.detailsNameLabel.text
                        annotation.subtitle = self.detailsTypeLabel.text
                        self.detailsMapView.addAnnotation(annotation)
                        
                    }
                }
            }
        }
        
    }
    
    
}
