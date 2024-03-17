//
//  VenueTicketsViewController.swift
//  NearByApp
//
//  Created by Sonam on 17/03/24.
//

import UIKit
import WebKit

// MARK: VenueTicketsViewController
final class VenueTicketsViewController: UIViewController, WKUIDelegate {
    private var webView: WKWebView!
    var url: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url = url else {
            return
        }
        guard let webURL = URL(string:url) else {
            return
        }
        
        let webRequest = URLRequest(url: webURL)
        webView.load(webRequest)
    }
    
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
}
