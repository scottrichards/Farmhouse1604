//
//  WebViewController.swift
//  TruColoriOS
//
//  Created by Scott Richards on 2/21/22.
//

import Foundation
import UIKit
import WebKit

private let KVOEstimatedProgress = "estimatedProgress"

class WebViewController: UIViewController, WKUIDelegate {
    var url: URL?
    var htmlString: String?
    var baseURL: URL?
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var webView: WKWebView!
    
    fileprivate var isLoading = false
    fileprivate var myTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.uiDelegate = self
        if let htmlString = htmlString {
            webView.loadHTMLString(htmlString, baseURL: baseURL)
        } else if let url = url {
            let request = URLRequest(url: url)
            webView.load(request)
        }
        webView.addObserver(self, forKeyPath: KVOEstimatedProgress, options: .new, context: nil)
    }
    
    func updateProgressbar(to progess: Float) {
        progressView?.progress = progess
        progressView?.isHidden = progess <= 0.0 || progess >= 1.0
    }
    
    // To start loading for uiwebview as we cann't track progress
    func startLoading() {
        progressView?.progress = 0.0
        isLoading = true
        myTimer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { [weak self] _ in
            
            guard let strongSelf = self else { return }
            strongSelf.timerCallBack()
        })
    }
    
    func loadHTMLString(_ htmlString: String, baseURL: URL? = nil) {
        webView.loadHTMLString(htmlString, baseURL: baseURL)
    }
    
    deinit {
        webView?.removeObserver(self, forKeyPath: KVOEstimatedProgress)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == KVOEstimatedProgress {
            updateProgressbar(to: Float(webView.estimatedProgress))
        }
    }


    // MARK: - <WKNavigationDelegate> -
    
    @available(iOS 8.0, *)
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        didStartLoadOfURL(webView.url)
    }
    
    @available(iOS 8.0, *)
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        didFinishLoad(webView.url)
    }
    
    // To stop loading for uiwebview as we can't track progress
    func stopLoading() {
        isLoading = false
    }
    
    func timerCallBack() {
        guard let progressView = progressView else {
            return
        }
        if isLoading {
            updateProgressbar(to: progressView.progress + 0.005)
            if progressView.progress >= 0.95 {
                updateProgressbar(to: 0.95)
            }
        } else {
            myTimer?.invalidate()
            updateProgressbar(to: 1.1)
        }
    }
    
    
    fileprivate func didStartLoadOfURL(_ URL: Foundation.URL?) {
    }
    
    fileprivate func didFinishLoad(_ URL: Foundation.URL?) {
        // Update web view controller UI
//        bottomBar.isBackEnable = webView.canGoBack
//        bottomBar.isForwardEnable = webView.canGoForward
    }
}

