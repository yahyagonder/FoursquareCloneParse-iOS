//
//  AddPlaceVC.swift
//  FoursquareCloneParse
//
//  Created by Yahya Gönder on 20.06.2022.
//

import UIKit

//var globalName = ""
//var globalType = ""

class AddPlaceVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var placeNameText: UITextField!
    @IBOutlet weak var placeTypeText: UITextField!
    @IBOutlet weak var placeAtmosphereText: UITextField!
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.isUserInteractionEnabled = true
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTap))
        imageView.addGestureRecognizer(gestureRecognizer)
        
    }
    
    @objc func imageTap() {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        self.present(picker, animated: true)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.editedImage] as? UIImage
        self.dismiss(animated: true)
        
    }
    

    @IBAction func nextButtonClicked(_ sender: Any) {
        
        if placeNameText.text != "" && placeTypeText.text != "" && placeAtmosphereText.text != "" {
            
            if let chosenImage = imageView.image {
                
                PlaceModel.sharedInstance.placeName = placeTypeText.text!
                PlaceModel.sharedInstance.placeType = placeTypeText.text!
                PlaceModel.sharedInstance.placeAtmosphere = placeAtmosphereText.text!
                PlaceModel.sharedInstance.placeImage = chosenImage
                
            }
            
            self.performSegue(withIdentifier: "toMapVC", sender: nil)
            
        } else {
            let alert = UIAlertController(title: "Error", message: "Place Name/Type/Atmosphere?", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
            alert.addAction(okButton)
            self.present(alert, animated: true)
        }
        
    }

}
