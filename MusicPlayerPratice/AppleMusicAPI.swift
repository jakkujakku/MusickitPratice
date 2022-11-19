//
//  AppleMusicAPI.swift
//  MusicPlayerPratice
//
//  Created by (^ㅗ^)7 iMac on 2022/11/19.
//

import StoreKit
 
// 2
class AppleMusicAPI {
    // 3
    let developerToken = "YOUR DEVELOPER TOKEN FROM PART 1"
    
    // 4
    func getUserToken() -> String {
        var userToken = String()

        // 1
        let lock = DispatchSemaphore(value: 0)

        // 2
        SKCloudServiceController().requestUserToken(forDeveloperToken: developerToken) { (receivedToken, error) in
            // 3
            guard error == nil else { return }
            if let token = receivedToken {
                userToken = token
                lock.signal()
            }
        }

        // 4
        lock.wait()
        return userToken
    }
    
    func fetchStorefrontID() -> String {
        // 1
        let lock = DispatchSemaphore(value: 0)
        var storefrontID: String!
     
        // 2
        let musicURL = URL(string: "https://api.music.apple.com/v1/me/storefront")!
        var musicRequest = URLRequest(url: musicURL)
        musicRequest.httpMethod = "GET"
        musicRequest.addValue("Bearer \(developerToken)", forHTTPHeaderField: "Authorization")
        musicRequest.addValue(getUserToken(), forHTTPHeaderField: "Music-User-Token")
     
        // 3
        URLSession.shared.dataTask(with: musicRequest) { (data, response, error) in
            guard error == nil else { return }
     
            // 4
            if let json = try? JSON(data: data!) {
                let result = (json["data"]).array!
                let id = (result[0].dictionaryValue)["id"]!
                 
                // 2
                storefrontID = id.stringValue
                 
                // 3
                lock.signal()            }
        }.resume()
     
        // 5
        lock.wait()
        return storefrontID
    }
    
    func searchAppleMusic(_ searchTerm: String!) -> [Song] {
        let lock = DispatchSemaphore(value: 0)
        var songs = [Song]()
     
        let musicURL = URL(string: "https://api.music.apple.com/v1/catalog/\(fetchStorefrontID())/search?term=\(searchTerm.replacingOccurrences(of: " ", with: "+"))&types=songs&limit=25")!
        var musicRequest = URLRequest(url: musicURL)
        musicRequest.httpMethod = "GET"
        musicRequest.addValue("Bearer \(developerToken)", forHTTPHeaderField: "Authorization")
            musicRequest.addValue(getUserToken(), forHTTPHeaderField: "Music-User-Token")
     
        URLSession.shared.dataTask(with: musicRequest) { (data, response, error) in
            guard error == nil else { return }
            
            if let json = try? JSON(data: data!) {
                // 2
                let result = (json["results"]["songs"]["data"]).array!
                // 3
                for song in result {
                    // 4
                    let attributes = song["attributes"]
                    let currentSong = Song(id: attributes["playParams"]["id"].string!, name: attributes["name"].string!, artistName: attributes["artistName"].string!, artworkURL: attributes["artwork"]["url"].string!)
                    songs.append(currentSong)
                }
                // 5
                lock.signal()
            } else {
                // 6
                lock.signal()
            }
        }.resume()
     
        lock.wait()
        return songs
    }
}
