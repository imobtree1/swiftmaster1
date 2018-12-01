//
//  WebForLeaseController.swift
//  demo
//
//  Created by Imobtree Solutions on 10/10/18.
//  Copyright © 2018 Imobtree Solutions. All rights reserved.
//

import UIKit
import SwiftyJSON
import HTMLEntities

class WebForLeaseController: UIViewController {

    @IBOutlet var myWebview: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let api = APIManager.sharedInstance
        api.userLogin() { (userJson)->Void in
            if userJson != JSON.null {
                let attr = userJson["DATA"].string!
                let encodedString = "&lt;!DOCTYPE html&gt;&lt;html&gt;&lt;body&gt;&lt;h1&gt;My First Heading&lt;/h1&gt;&lt;p&gt;My first paragraph.&lt;/p&gt;> &lt;/body&gt;&lt;/html&gt;"
                //let encodedString = attr.htmlEscape(allowUnsafeSymbols: true)
                let decodedString = String(htmlEncodedString: encodedString)
                self.myWebview.loadHTMLString(decodedString!, baseURL: nil)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension String {
    
    init?(htmlEncodedString: String) {
        
        guard let data = htmlEncodedString.data(using: .utf8) else {
            return nil
        }
        
        let options: [String: Any] = [
            NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
            NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue
        ]
        
        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
            return nil
        }
        
        self.init(attributedString.string)
    }
    
}

//extension String {
//
//    init(htmlString: String) {
//        self.init()
//        guard let encodedData = htmlString.data(using: .utf8) else {
//            self = htmlString
//            return
//        }
//
//        let attributedOptions: [NSAttributedString.DocumentReadingOptionKey : Any] = [
//            .documentType: NSAttributedString.DocumentType.html,
//            .characterEncoding: String.Encoding.utf8.rawValue
//        ]
//
//        do {
//            let attributedString = try NSAttributedString(data: encodedData,
//                                                          options: attributedOptions,
//                                                          documentAttributes: nil)
//            self = attributedString.string
//        } catch {
//            print("Error: \(error.localizedDescription)")
//            self = htmlString
//        }
//    }
//}


//extension String {
//    init(htmlEncodedString: String) {
//        self.init()
//        guard let encodedData = htmlEncodedString.data(using: .utf8) else {
//            self = htmlEncodedString
//            return
//        }
//
//        let attributedOptions: [String : Any] = [
//            NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
//            NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue
//        ]
//
//        do {
//            let attributedString = try NSAttributedString(data: encodedData, options: attributedOptions, documentAttributes: nil)
//            self = attributedString.string
//        } catch {
//            print("Error: \(error)")
//            self = htmlEncodedString
//        }
//    }
//}

