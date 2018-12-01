//
//  GetServerDataController.swift
//  demo
//
//  Created by Imobtree Solutions on 3/16/18.
//  Copyright © 2018 Imobtree Solutions. All rights reserved.
//

import UIKit
import SwiftyJSON

class GetServerDataController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet var userTable: UITableView!
    var userAll:[UserModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userTable.rowHeight = UITableViewAutomaticDimension
        userTable.estimatedRowHeight = 160
        
        let api = APIManager.sharedInstance
        api.getUserData() { (userJson)->Void in
            if userJson != JSON.null {
                for i in 0..<userJson.count {
                    let singleUser = UserModel(res: userJson[i])
                    self.userAll.append(singleUser)
                    self.userTable.reloadData()
                }
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userAll.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UserCell  = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! UserCell
        let singleUser = userAll[indexPath.row]
        
        cell.lblTitle.text = singleUser.userId
        if indexPath.row == 2 {
            cell.lblDisc.text = singleUser.name! + "Test for cell big or not jhsfhdkjkjhfksdjfhksjdhfkjdhfk" + singleUser.body! + "finally i have done this task hfkjsdhfkjdshfkjdshfkjdhhfkdjshfkjdhfkdjshfkhkhkjfhkjhkdsjfhkjfkjdshds" + (singleUser.add?.city!)!
        } else {
            cell.lblDisc.text = singleUser.name
        }
        
        return cell
    }
}
