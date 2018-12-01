//
//  ViewController.swift
//  test
//
//  Created by Imobtree Solutions on 10/22/18.
//  Copyright © 2018 Imobtree Solutions. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet var tblView : UITableView!
    var r: AllData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getDataFromServer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func getDataFromServer () {
        let params = ["PollAlgo":"1","CountryId":"147", "PageIndex":"1","LanguageId":"1","Skip":"0","RegionId":"1","CategoryId":"1"] as [String : Any]
        var request = URLRequest(url: URL(string: "http://pollia.imperoserver.in/Api/Poll/PollByGategory")!)
        request.setValue("en", forHTTPHeaderField:"Accept-Language")
        request.setValue("Bearer f4FdKEMVHyiwhCgPKWUKi7P7f3VtcvSI6q9lOFhTn4CF9KssFPwMmi0_ddL0zBuX79_1e48lVCQxQZ_VUKRafaWu2I5kgs9HvsKGwmqsivVobmvLrsH4L_tvJ3DFBr8GH_ncu0YIxqZsD0zxEUPZjP6jY21ilb8deXkwjc90OuOkdJQXuC22FcrKmxYGUZz2EJ2tYf4PjYW5TMemK9rA-bMiXTJ8Lwrhj8XFU6xacuDI8gAa3X420Mw_NHmkr3wkB24hkszENh70Hc5KRzNb8LDBfRvjWv0s_kR_BR7x72HMbtzwSrskeb7gRiNbD7Aj94_GRAgnTHM8o0nZ-m2DWHaduME", forHTTPHeaderField:"Authorization")
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "POST"
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            do {
                
                //let returnData = String(data: data!, encoding: .utf8)
                //print(returnData!)
                let myStruct = try JSONDecoder().decode(AllData.self, from: data!)
                self.r = myStruct
                DispatchQueue.main.async  {
                    self.tblView.reloadData()
                }
            } catch {
                print("error")
            }
        })
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.r != nil  {
            return self.r!.Result.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let lblQestion:UILabel = cell.contentView.viewWithTag(1) as! UILabel
        lblQestion.text = self.r?.Result[indexPath.row].Question
        
        let lbl1:UILabel = cell.contentView.viewWithTag(3) as! UILabel
        let question1 = self.r?.Result[indexPath.row].Options[0].Option
        lbl1.text = question1
        
        let lbl2:UILabel = cell.contentView.viewWithTag(4) as! UILabel
        let question2 = self.r?.Result[indexPath.row].Options[1].Option
        lbl2.text = question2
        
        let lbl3:UILabel = cell.contentView.viewWithTag(5) as! UILabel
        
        if let option = self.r?.Result[indexPath.row].Options {
            if option.count > 2 {
                lbl3.text = option[2].Option
            }
        }
        
        let imageView = cell.contentView.viewWithTag(2) as! UIImageView
        imageView.image = nil
        if let url = (self.r?.Result[indexPath.row].ImageName) {
            if url.isEmpty == false {
                imageView.downloaded(from: url, contentMode: .scaleAspectFill)
            }
        }
        return cell
    }
}

struct AllData : Decodable {
    let Result : [result]
    let Status : Int
    let PollAlgo : Int
    let PageIndex : Int
    let ForceUpdate : Bool
    let iOSVersion : String
}
struct result : Decodable {
    let Question : String
    let ImageName : String
    let Options : [option]
}
struct option : Decodable {
    let Option : String
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
