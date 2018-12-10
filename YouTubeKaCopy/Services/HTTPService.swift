//
//  HTTPService.swift
//  YouTubeKaCopy
//
//  Created by Shivam Aditya on 07/12/18.
//  Copyright © 2018 Shivam Aditya. All rights reserved.
//

import Foundation

class HTTPService {
    let session = URLSession.shared

    func performGetRequest(urlString: String, callback: @escaping (_ data: Data?, _ HTTPStatusCode: Int?, _ error: Error?) -> Void) {
        NSLog("performGetRequest. urlString is:", urlString)
        guard let serviceUrl = URL(string: urlString) else { return }
        print(serviceUrl)

        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "GET"

        let task = session.dataTask(with: request){
            (data, response, error) -> Void in
            
            if let responseObj = response as? HTTPURLResponse {
                //print("response received is:", response)
                print("response status code received is:", responseObj.statusCode)
                print("error received is:", error)
                
                let statusCode = responseObj.statusCode
                if error != nil {
                    callback(nil, statusCode, error)
                } else {
                    callback(data, statusCode, nil)
                }
            }
        }

        task.resume()
    }
    
    func performPostRequest(urlString: String, parameters:[String:String], callback: @escaping (_ data: String?, _ HTTPStatusCode: Int?, _ error: Error?) -> Void) {
        guard let serviceUrl = URL(string: urlString) else { return }
        print(serviceUrl)

        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = try! JSONSerialization.data(withJSONObject: parameters, options: [])

        let task = session.dataTask(with: request){
            (data, response, error) -> Void in
            
            if let responseObj = response as? HTTPURLResponse {
                //print("response received is:", response)
                print("response status code received is:", responseObj.statusCode)
                print("error received is:", error)
                
                let statusCode = responseObj.statusCode
                if error != nil {
                    callback(nil, statusCode, error)
                } else {
                    let result = NSString(data: data!, encoding:
                        String.Encoding.ascii.rawValue)!
                    callback(result as String, statusCode, nil)
                }
            }
        }
        
        task.resume()
    }
}



//func httpGet(request: URLRequest, callback: @escaping (String, String?) -> Void) {
//    let session = URLSession.shared
//    let task = session.dataTask(with: request){
//        (data, response, error) -> Void in
//        if error != nil {
//            callback("", error?.localizedDescription)
//        } else {
//            let result = NSString(data: data!, encoding:
//                String.Encoding.ascii.rawValue)!
//            callback(result as String, nil)
//        }
//    }
//
//    task.resume()
//}
//
//let urlString = "http://dh-ws.news.dailyhunt.in/api/v2/pages/users/c1_d1_a1_67810580?langCode=en&edition=india&appLanguage=en&returnTickers=true"
//var request = URLRequest(url: NSURL(string: urlString)! as URL)
//httpGet(request: request){
//    (data, error) -> Void in
//    if error != nil {
//        print(error!)
//    } else {
//        print(data)
//    }
//}







//import Alamofire
//import PromiseKit
//import SwiftyJSON
//
//class HttpService{
//    func getAsync(url:String) -> Promise<JSON>{
//        return Promise<JSON>(){ seal in
//            Alamofire.request(url, method: .get, parameters: nil).responseJSON{
//                response in
//                switch(response.result){
//                case .success(let responseString):
//                    let res: JSON = JSON(responseString)
//                    seal.resolve(res, nil)
//                case .failure(let error):
//                    print (error)
//                    seal.reject(error)
//                }
//            }
//        }
//    }
//}
