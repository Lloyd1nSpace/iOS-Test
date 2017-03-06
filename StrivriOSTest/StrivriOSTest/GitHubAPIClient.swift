//
//  GitHubAPIClient.swift
//  StrivrTest
//
//  Created by Lloyd W. Sykes on 9/22/16.
//  Copyright © 2016 Strivr, Inc. All rights reserved.
//

import Alamofire

struct GitHubAPIClient {
    static func getCommitsForRepoByAuthor(completion: @escaping ([NSDictionary]?, Error?) -> ()) {
        Alamofire.request("https://api.github.com/repos/apple/swift/commits").responseJSON { (commitsByAuthorResponse) in
            if let gitHubData = commitsByAuthorResponse.result.value as? [NSDictionary] {
                completion(gitHubData, nil)
            } else if let error = commitsByAuthorResponse.result.error {
                print("There was a network error in the GitHubAPIClient: \(error.localizedDescription)")
            }
        }
    }
}
