//
//  User.swift
//  OneInChrist
//
//  Created by iMobtree on 23/09/18.
//  Copyright © 2018 Kristine Galindo. All rights reserved.
//

import UIKit

protocol UserProfileDelegate {
    func didFinishProfileDownload(aUser:User)
}

class User: NSObject {
    
    var profileImage:String = ""
    var name:String = ""
    var email:String = ""
    var aboutMe:String = ""
    var userDesc:String = ""
    var mileRange:String = ""
    var minAge:String = ""
    var maxAge:String = ""
    var userAge:String = ""
    var isMale:Bool = false
    var ID:String = ""
    var deviceToken:String = ""
    
    var isNotificationEnabled:Bool = false
    var uID:String = ""
    
//    class func getUserProfileData (userID:String,delegate:UserProfileDelegate) {
//        let aUser = User()
//        let manager:AppManager = AppManager.sharedInstance
//
//        let userReference = manager.ref.child("users").child(userID)
//        userReference.observeSingleEvent(of: .value, with: { (snapshot) in
//            if snapshot.exists() {
//                let userDict = snapshot.value as! [String: Any]
//
//                aUser.uID = userID
//                aUser.ID = userID
//
//                if (userDict["name"] != nil) {
//                    aUser.name = userDict["name"] as! String
//                }
//                if (userDict["email"] != nil) {
//                    aUser.email = userDict["email"] as! String
//                }
//                if (userDict["url"] != nil) {
//                    aUser.profileImage = userDict["url"] as! String
//                }
//                if (userDict["about"] != nil) {
//                    aUser.aboutMe = userDict["about"] as! String
//                }
//                if (userDict["discription"] != nil) {
//                    aUser.userDesc = userDict["discription"] as! String
//                }
//                if (userDict["gender"] != nil) {
//                    if (userDict["gender"] as! String == "Male") {
//                        aUser.isMale = true
//                    } else {
//                        aUser.isMale = false
//                    }
//                }
//
//                if (userDict["mile"] != nil) {
//                    let nMile = (userDict["mile"] as! NSNumber)
//                    aUser.mileRange = nMile.stringValue
//                }
//                if (userDict["min"] != nil) {
//                    let nMin = (userDict["min"] as! NSNumber)
//                    aUser.minAge = nMin.stringValue
//                }
//                if (userDict["max"] != nil) {
//                    let nMax = (userDict["max"] as! NSNumber)
//                    aUser.maxAge = nMax.stringValue
//                }
//                if (userDict["age"] != nil) {
//                    let nAge = (userDict["age"] as! NSNumber)
//                    aUser.userAge = nAge.stringValue
//                }
//
//                if (userDict["notification"] != nil) {
//                    if (userDict["notification"] as! String == "on") {
//                        aUser.isNotificationEnabled = true
//                    } else {
//                        aUser.isNotificationEnabled = false
//                    }
//                }
//                if (userDict["device_token"] != nil) {
//                    aUser.deviceToken = userDict["device_token"] as! String
//                }
//            }
//            delegate.didFinishProfileDownload(aUser: aUser)
//        })
//
//    }
//
//    class func info(forUserID: String, completion: @escaping (User) -> Swift.Void) {
//        AppManager.sharedInstance.ref.child("users").child(forUserID).observeSingleEvent(of: .value, with: { (snapshot) in
//            if snapshot.exists() {
//                let data = snapshot.value as! [String: Any]
//                let name = data["name"]!
//                let email = data["email"]!
//                let profileUrl = data["url"]!
//                var deviceToken = ""
//                if (data["device_token"] != nil) {
//                    deviceToken = data["device_token"] as! String
//                }
//                let user = User.init(name: name as! String, email: email as! String, id: forUserID, profileUrl: profileUrl as! String,deviceToken:deviceToken)
//                completion(user)
//            }
//        })
//    }
    
    override init() {
        
    }
    //MARK: Inits""
    init(name: String, email: String, id: String, profileUrl: String,deviceToken:String) {
        self.name = name
        self.email = email
        self.ID = id
        self.profileImage = profileUrl
        self.deviceToken = deviceToken
    }

}
