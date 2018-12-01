//
//  SaveDataController.swift
//  demo
//
//  Created by Imobtree Solutions on 3/16/18.
//  Copyright © 2018 Imobtree Solutions. All rights reserved.
//

import UIKit
import RealmSwift


class SaveDataController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet var txtName: UITextField!
    @IBOutlet var profileImage: UIImageView!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        
        profileImage.isUserInteractionEnabled = true
        profileImage.addGestureRecognizer(tapGestureRecognizer)
        imagePicker.delegate = self
        
    }

    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            profileImage.image = pickedImage
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func btnSave(_ sender: Any) {
        let saveProfile = Profile()
        let imageData: NSData = UIImagePNGRepresentation(profileImage.image!)! as NSData
        saveProfile.name = txtName.text!
        saveProfile.photo = imageData
        try! realm.write {
            realm.add(saveProfile)
        }
    }
}
