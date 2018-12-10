//
//  YTDataService.swift
//  YouTubeKaCopy
//
//  Created by Shivam Aditya on 07/12/18.
//  Copyright © 2018 Shivam Aditya. All rights reserved.
//

import Foundation

class YTDataService: HTTPService {
    let sampleUrl = "http://dh-ws.news.dailyhunt.in/api/v2/pages/users/c1_d1_a1_67810580?langCode=en&edition=india&appLanguage=en&returnTickers=true"
    let homeFeedURL = YTBaseApi + "/activities?part=snippet,contentDetails&home=true"
    let admiralBulldogSearchURL = YTBaseApi + "/search?part=snippet&q=admiralBulldog&type=video&key="+YTApiKey

    func getYTData(callback: @escaping (_ response: YoutubeSearchModel?) -> Void) {
        performGetRequest(urlString: admiralBulldogSearchURL) { (data, statusCode, error) in
            
            if let data = data {
                let result = NSString(data: data, encoding:
                    String.Encoding.ascii.rawValue)
                print("getYTData. data received is:", result)
            }

            print("getYTData. statusCode received is:", statusCode ?? "")
            print("getYTData. error received is:", error)
            if let statusCode = statusCode {
                if error != nil {
                    print(error?.localizedDescription)
                } else {
                    if let data = data {
                        do{
                            let jsonDecoder = JSONDecoder()
                            let responseModel  = try jsonDecoder.decode(YoutubeSearchModel.self, from: data)
                            callback(responseModel)
                        }
                        catch{
                            print("error in decoding data in yt data service")
                        }
                        //print(data)
                    }
                }
            }
        }
    }
}
