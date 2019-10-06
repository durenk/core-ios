//
//  WebViewController.swift
//  OLCore
//
//  Created by DENZA on 06/10/19.
//

import UIKit
import WebKit

open class WebViewController: ViewController, WKNavigationDelegate {
    private var webView: WKWebView = WKWebView()
    public weak var delegate: WebViewControllerDelegate?
    public var htmlContent: String = DefaultValue.emptyString

    override open func loadView() {
        super.loadView()
        webView = WKWebView()
        webView.backgroundColor = UIColor.white
        webView.navigationDelegate = self
        view = webView
    }

    override open func viewDidLoad() {
        super.viewDidLoad()
        webView.loadHTMLString(htmlContent, baseURL: nil)
    }
}
