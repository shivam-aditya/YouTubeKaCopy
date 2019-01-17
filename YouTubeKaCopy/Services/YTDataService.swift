//
//  YTDataService.swift
//  YouTubeKaCopy
//
//  Created by Shivam Aditya on 07/12/18.
//  Copyright © 2018 Shivam Aditya. All rights reserved.
//

import Foundation
import YoutubeDirectLinkExtractor

class YTDataService: HTTPService {
    let sampleUrl = "http://dh-ws.news.dailyhunt.in/api/v2/pages/users/c1_d1_a1_67810580?langCode=en&edition=india&appLanguage=en&returnTickers=true"
    let homeFeedURL = YTBaseApi + "/activities?part=snippet,contentDetails&home=true"
    
    let admiralBulldogSearchURL = YTBaseApi + "/search?part=snippet&q=avenger&type=video&key=" + YTApiKey
    let videoIdDataAndStatsUrl = YTBaseApi + "/videos?part=snippet,statistics&id=%@&key=" + YTApiKey //MD_0061a5vs
    //https://www.googleapis.com/youtube/v3/videos?part=snippet,statistics&id=MD_0061a5vs&key=AIzaSyArGHNDm-QS4BKFzzW0VU9IXJGD6a9Qzg4
    
    func getYTSearchData(callback: @escaping (_ response: YoutubeSearchModel?) -> Void) {
        performGetRequest(urlString: admiralBulldogSearchURL) { (data, statusCode, error) in
            
            if let data = data {
                let result = NSString(data: data, encoding:
                    String.Encoding.ascii.rawValue)
                //print("[getYTSearchData] data received is:", result)
            }

            print("[getYTSearchData] statusCode received is:", statusCode ?? "")
            print("[getYTSearchData] error received is:", error)
            if statusCode != nil {
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
                    }
                }
            }
        }
    }
    
    func getYTStreamingUrl(videoId: String ,callback: @escaping (_ response: String?) -> Void) {
        print("[GetYTStreamingUrl] videoId received is: \(videoId)")
        let ytLinkExtractor = YoutubeDirectLinkExtractor()
        ytLinkExtractor.extractInfo(for: .urlString(YTVideoBaseURL+videoId), success: { info in
            print("[GetYTStreamingUrl] returning url is: \(info.highestQualityPlayableLink)")
            callback(info.highestQualityPlayableLink)
        }) { error in
            print("Error in getting streaming link. Error is: \(error)")
        }
    }
}
