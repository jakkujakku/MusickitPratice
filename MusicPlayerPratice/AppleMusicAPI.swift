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
}
