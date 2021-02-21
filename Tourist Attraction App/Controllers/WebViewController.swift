//
//  WebViewController.swift
//  Tourist Attraction App
//
//  Created by Pinal Patel on 2020-12-02.
//

import UIKit
import WebKit

class WebViewController: UIViewController , WKNavigationDelegate {

    var webView: WKWebView!
    var urlData:String = ""
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        let url = URL(string: urlData)!
           webView.load(URLRequest(url: url))
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
        }
}
