//
//  PlaceModel.swift
//  FoursquareCloneParse
//
//  Created by Yahya Gönder on 23.06.2022.
//

import Foundation
import UIKit

class PlaceModel {
    
    static let sharedInstance = PlaceModel()
    
    var placeName = ""
    var placeType = ""
    var placeAtmosphere = ""
    var placeImage = UIImage()
    var placeLatitude = ""
    var placeLongitude = ""
    
    private init() {}
    
}
