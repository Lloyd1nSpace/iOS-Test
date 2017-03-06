//
//  AuthorCustomTableViewCell.swift
//  StrivriOSTest
//
//  Created by Lloyd W. Sykes on 9/23/16.
//  Copyright © 2016 Strivr, Inc. All rights reserved.
//

import Foundation
import UIKit

class AuthorCustomTableViewCell: UITableViewCell {
    static let reuseIdentifer = "authorInfo"
    static let segueIdentifier = "webView"
    @IBOutlet weak var userAvatarImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
}
