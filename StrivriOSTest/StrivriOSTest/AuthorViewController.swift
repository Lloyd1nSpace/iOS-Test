//
//  ViewController.swift
//  StrivriOSTest
//
//  Created by Lloyd W. Sykes on 9/23/16.
//  Copyright © 2016 Strivr, Inc. All rights reserved.
//

import UIKit

class AuthorViewController: UIViewController {
    
    @IBOutlet weak var authorTableView: UITableView!
    let authorDataStore = AuthorDataStore.authorStore
    var urlPlaceholder = ""
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    func setUpViews() {
        authorTableView.delegate = self
        authorTableView.dataSource = self
        navigationItem.title = "Recent Commits on Swift"
    
        authorDataStore.getCommitsForRepoByAuthor { [weak self] (authorDict, error) in
            guard let strongSelf = self else { return }
            if authorDict != nil {
                strongSelf.authorTableView.reloadData()
            } else if let error = error {
                print("There was a network error in AuthoVC: \(error.localizedDescription)")
            }
        }
    }

}

extension AuthorViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.authorDataStore.loginName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AuthorCustomTableViewCell.reuseIdentifer, for: indexPath) as! AuthorCustomTableViewCell
        if let url = URL(string: self.authorDataStore.avatar[indexPath.row]) {
            do {
                let imageData = try Data(contentsOf: url)
                cell.userAvatarImageView.image = UIImage(data: imageData)
                
            } catch {
                print("There was an issue unwrapping the imageData for the Avatar in AuthorVC")
            }
        }
        cell.usernameLabel.text = "Username: \(self.authorDataStore.loginName[indexPath.row])"
        cell.dateLabel.text = "Date: \(self.authorDataStore.timeStamp[indexPath.row])"
        cell.messageLabel.text = "Message: \(self.authorDataStore.commitMessage[indexPath.row])"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        authorTableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        index = indexPath.row
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == AuthorCustomTableViewCell.segueIdentifier {
            if let destination = segue.destination as? WebViewController {
                destination.urlString = self.authorDataStore.commitHTMLURL[self.index]
                destination.navigationItem.title = self.authorDataStore.loginName[self.index]
                print("Moving from AuthorVC to CommitsVC")
            }
        }
    }
}
