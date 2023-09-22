//
//  PlacesVC.swift
//  FoursquareCloneParse
//
//  Created by Yahya Gönder on 19.06.2022.
//

import UIKit
import Parse

class PlacesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var PlaceNameArray = [String]()
    var PlaceIDArray = [String]()
    
    var selectedPlaceID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "Log Out", style: UIBarButtonItem.Style.plain, target: self, action: #selector(logOutButtonClicked))
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getDataFromParse()
        
    }
    
    func getDataFromParse() {
        
        let query = PFQuery(className: "Places")
        query.findObjectsInBackground { objects, error in
            if error != nil {
                self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
            } else {
                if objects != nil {
                    
                    self.PlaceNameArray.removeAll(keepingCapacity: false)
                    self.PlaceIDArray.removeAll(keepingCapacity: false)
                    
                    for object in objects! {
                        
                        if let placeName = object.object(forKey: "name") as? String {
                            
                            if let placeID = object.objectId  {
                                
                                self.PlaceNameArray.append(placeName)
                                self.PlaceIDArray.append(placeID)
                                
                            }
                            
                        }
        
                    }
                    
                    self.tableView.reloadData()
                    
                }
            }
        }
        
    }
    
    @objc func addButtonClicked() {
        
        self.performSegue(withIdentifier: "toAddPlaceVC", sender: nil)
        
    }
    
    @objc func logOutButtonClicked() {
        
        PFUser.logOutInBackground { error in
            if error != nil {
                self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
            } else {
                self.performSegue(withIdentifier: "toSignUpVC", sender: nil)
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVC" {
            let destiantionVC = segue.destination as! DetailsVC
            destiantionVC.chosenPlaceID = selectedPlaceID
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPlaceID = PlaceIDArray[indexPath.row]
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = PlaceNameArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PlaceNameArray.count
    }
    
    func makeAlert(titleInput: String, messageInput: String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true )
    }
    
}
