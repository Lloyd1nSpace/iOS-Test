//
//  WebViewController.swift
//  StrivriOSTest
//
//  Created by Lloyd W. Sykes on 9/23/16.
//  Copyright © 2016 Strivr, Inc. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var urlString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadGitHubPage()
    }
    
    func loadGitHubPage() {
        webView.delegate = self
        guard let url = URL(string: urlString) else {
            print("There was an issue unwrapping the url in WebViewController")
            return
        }
        let request = URLRequest(url: url)
        webView.loadRequest(request)
    }
}

extension WebViewController: UIWebViewDelegate {
    func webViewDidStartLoad(_ webView: UIWebView) {
        activityIndicator.startAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        activityIndicator.stopAnimating()
        activityIndicator.hidesWhenStopped = true
    }
}
