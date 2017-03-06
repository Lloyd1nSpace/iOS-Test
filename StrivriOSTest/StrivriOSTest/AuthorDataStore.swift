//
//  AuthorDataStore.swift
//  StrivriOSTest
//
//  Created by Lloyd W. Sykes on 9/23/16.
//  Copyright © 2016 Strivr, Inc. All rights reserved.
//

import Foundation

class AuthorDataStore {
    
    static let authorStore = AuthorDataStore()
    
    var loginName = [String]()
    var avatar = [String]()
    var timeStamp = [String]()
    var commitMessage = [String]()
    var commitHTMLURL = [String]()
    
    func getCommitsForRepoByAuthor(completion: @escaping ([NSDictionary]?, Error?) -> ()) {
    
        GitHubAPIClient.getCommitsForRepoByAuthor {  [weak self] (authorsWithCommits, error) in
            guard let strongSelf = self else { return }
            if let authorsWithCommits = authorsWithCommits {
                for authorInfo in authorsWithCommits {
                    guard
                        let authorDict = authorInfo["author"] as? NSDictionary,
                        let loginNameData = authorDict["login"] as? String,
                        let avatarURL = authorDict["avatar_url"] as? String,
                        let commitDict = authorInfo["commit"] as? NSDictionary,
                        let dateDict = commitDict["committer"] as? NSDictionary,
                        let message = commitDict["message"] as? String,
                        let dateTime = dateDict["date"] as? String,
                        let htmlURL = authorInfo["html_url"] as? String else {
                            print("There was an issue unwrapping the author information in the Author Class.")
                            return
                    }
                    strongSelf.loginName.append(loginNameData)
                    strongSelf.avatar.append(avatarURL)
                    strongSelf.timeStamp.append(dateTime)
                    strongSelf.commitMessage.append(message)
                    strongSelf.commitHTMLURL.append(htmlURL)
                    
                    completion(authorsWithCommits, nil)
                }
            } else if let error = error {
                print("There was a network error in AuthorDataStore: \(error.localizedDescription)")
                completion(nil, error)
            }
        }
    }
}
