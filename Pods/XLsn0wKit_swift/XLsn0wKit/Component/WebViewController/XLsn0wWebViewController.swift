

import UIKit
import WebKit


class XLsn0wWebViewController: UIViewController {
    
    var webView: WKWebView?
    var progressView: UIProgressView?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        //        self.automaticallyAdjustsScrollViewInsets = false
        let configuration = WKWebViewConfiguration.init()
        
        // 设置偏好设置
        configuration.preferences = WKPreferences.init()
        configuration.preferences.minimumFontSize = 16;
        configuration.preferences.javaScriptEnabled = true
        // 不能自动通过窗口打开
        configuration.preferences.javaScriptCanOpenWindowsAutomatically = false
        // web内容处理池
        configuration.processPool = WKProcessPool.init()
        
        // 通过JS与WebView交互
        configuration.userContentController = WKUserContentController.init()
        
        
        
        // 注意：self会被强引用（像被某个单例请引用，释放webView也不能释放self）,得调用下面的代码才行
        // self.webView?.configuration.userContentController.removeScriptMessageHandler(forName: "AppModel")
        // 注册函数名，注入JS对象名称AppModel,JS调用改函数时WKScriptMessageHandler代理可接收到
        configuration.userContentController.add(self as WKScriptMessageHandler, name: "AppModel")
        
        
        
        self.webView = WKWebView.init(frame: self.view.bounds, configuration: configuration)
        self.view.addSubview(self.webView!)
        
        self.webView?.allowsBackForwardNavigationGestures = true
        
        // 代理代理
        self.webView?.navigationDelegate = self
        
        // 与webview UI 交互代理
        self.webView?.uiDelegate = self
        
        
        // KVO
        self.webView?.addObserver(self, forKeyPath: "title", options: .new, context: nil)
        self.webView?.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        
        self.progressView = UIProgressView.init(frame: CGRect(x:0, y:(self.navigationController?.navigationBar.bounds.height)!, width:self.view.frame.size.width, height:5))
        self.navigationController?.navigationBar.addSubview(self.progressView!)
        self.progressView?.backgroundColor = UIColor.white
        self.progressView?.progressTintColor = UIColor.blue
        self.progressView?.trackTintColor = UIColor.lightGray
        
        let goFarward = UIBarButtonItem.init(title: "前进", style: .plain, target: self, action: #selector(XLsn0wWebViewController.goFarward))
        let goBack = UIBarButtonItem.init(title: "后退", style: .plain, target: self, action: #selector(XLsn0wWebViewController.goBack))
        self.navigationItem.rightBarButtonItems = [goBack,goFarward]
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        let Url = Bundle.main.url(forResource: "test", withExtension: "html")
           let Url = URL.init(string: "https://www.baidu.com")
        let request = URLRequest.init(url: Url!)
        _ = self.webView?.load(request)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Swift调用JS
        self.webView?.evaluateJavaScript("callJsAlert()", completionHandler: { (response, error) in
            if (error == nil) {
                print(response ?? 1)//1==error
            }else {
                print(error?.localizedDescription ?? 1)
            }
        })
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        // 一定要调用，不然self会一直被强引用，就算释放webView也不能将self释放
        self.webView?.configuration.userContentController.removeScriptMessageHandler(forName: "AppModel")
        
        
        self.progressView?.removeFromSuperview()
        self.webView?.stopLoading()
    }
    
    deinit {
        self.webView?.removeObserver(self, forKeyPath: "title")
        self.webView?.removeObserver(self, forKeyPath: "estimatedProgress")
        NSLog("\(self.classForCoder)%@已释放")
    }
    
    
    final func goFarward() {
        if (self.webView?.canGoForward == true) {
            _ = self.webView?.goForward()
        }
    }
    
    final func goBack() {
        if (self.webView?.canGoBack == true) {
            _ = self.webView?.goBack()
        }
    }
    
    // MARK - KVO
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "title" {
            self.navigationItem.title = self.webView?.title
        }else if keyPath == "estimatedProgress" {
            let estimatedProgress = Float((self.webView?.estimatedProgress)!)
            self.progressView?.setProgress(estimatedProgress, animated: true)
            
            XLsn0wLog(estimatedProgress)
        }else{
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}




extension XLsn0wWebViewController: WKNavigationDelegate{
    
    // MARK - WKNavigationDelegate
    
    /// 发送请求前决定是否跳转的代理
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        //        let hostName = navigationAction.request.url?.host?.lowercased()
        
        //        if (navigationAction.navigationType == WKNavigationType.linkActivated  && hostName?.contains(".baidu.com") == false) {
        //            UIApplication.shared.canOpenURL(navigationAction.request.url!)
        //            decisionHandler(WKNavigationActionPolicy.cancel)
        //        }else{
        //            self.progressView?.alpha = 1.0
        decisionHandler(WKNavigationActionPolicy.allow)
        //        }
        
        
        
    }
    
    /// 收到响应后，决定是否跳转的代理
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        decisionHandler(WKNavigationResponsePolicy.allow)
        
        
    }
    
    
    /// 接收到服务器跳转请求的代理
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        
        
        
    }
    
    
    
    
    
    
    
    
    /// 准备加载页面
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
        self.progressView?.isHidden = false
        self.progressView?.alpha = 1.0
        
        
    }
    
    /// 准备加载失败
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        
        weak var weakSelf = self
        UIView.animate(withDuration: 0.25, delay: 0.15, options: .curveEaseOut, animations: {
            guard let strongSelf = weakSelf else { return }
            strongSelf.progressView?.alpha = 0
        }) { (finished) in
            guard let strongSelf = weakSelf else { return }
            strongSelf.progressView?.progress = 0
            strongSelf.progressView?.isHidden = true
        }
        
        
    }
    
    
    /// 内容开始加载
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        
        
        
    }
    
    /// 加载完成
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        webView.evaluateJavaScript("showAlert('这是一个弹窗')") { (item, error) in
            if (error != nil) {
                XLsn0wLog(item)
            }else {
                XLsn0wLog(error?.localizedDescription)
            }
        }
        
        
        weak var weakSelf = self
        UIView.animate(withDuration: 0.25, delay: 0.15, options: .curveEaseOut, animations: {
            guard let strongSelf = weakSelf else { return }
            strongSelf.progressView?.alpha = 0
        }) { (finished) in
            guard let strongSelf = weakSelf else { return }
            strongSelf.progressView?.progress = 0
            strongSelf.progressView?.isHidden = true
        }
        
        
    }
    
    /// 加载失败
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        
        weak var weakSelf = self
        UIView.animate(withDuration: 0.25, delay: 0.15, options: .curveEaseOut, animations: {
            guard let strongSelf = weakSelf else { return }
            strongSelf.progressView?.alpha = 0
        }) { (finished) in
            guard let strongSelf = weakSelf else { return }
            strongSelf.progressView?.progress = 0
            strongSelf.progressView?.isHidden = true
        }
        
        
    }
    
    
    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        completionHandler(URLSession.AuthChallengeDisposition.performDefaultHandling, nil)
        
        
    }
    
    func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        
       
        
    }
}



extension XLsn0wWebViewController: WKScriptMessageHandler {
    
    // MARK - WKNavigationDelegate   
    
    
    // JS调用swift注册的函数时回调，message包括JS传的数据
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name.isEqual("AppModel") {
            
            // NSNumber, NSString, NSDate, NSArray,NSDictionary, and NSNull
            print(message.body)
        }
    }
}

extension XLsn0wWebViewController: WKUIDelegate {
    
    // MARK - WKUIDelegate
    
    // web已关闭
    func webViewDidClose(_ webView: WKWebView) {
        
        
        
    }
    
    
    
    // 在JS端调用alert函数时(警告弹窗)，会触发此代理方法。message :JS端传的数据
    // 通过completionHandler()回调JS
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        
        let alertVC = UIAlertController.init(title: "提示", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction.init(title: "确定", style: .default, handler: { (action) in
            completionHandler()
        }))
        self.present(alertVC, animated: true, completion: nil)
        
       
        
    }
    
    
    // JS端调用confirm函数时(确认、取消弹窗)，会触发此方法
    // completionHandler(true)返回结果,message :JS端传的数据
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        
        let alertVC = UIAlertController.init(title: "提示", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction.init(title: "确定", style: .default, handler: { (action) in
            completionHandler(true)
        }))
        alertVC.addAction(UIAlertAction.init(title: "取消", style: .cancel, handler: { (action) in
            completionHandler(false)
        }))
        self.present(alertVC, animated: true, completion: nil)
        
        XLsn0wLog(message)
    }
    
    
    // JS调用prompt函数(输入框)时回调，completionHandler回调结果
    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        
        let alertVC = UIAlertController.init(title: "TextInput", message: prompt, preferredStyle: .alert)
        alertVC.addTextField { (textField) in
            textField.textColor = UIColor.red
            textField.placeholder = "TextInput"
        }
        alertVC.addAction(UIAlertAction.init(title: "确定", style: .cancel, handler: { (action) in
            completionHandler(alertVC.textFields?.last?.text)
        }))
        self.present(alertVC, animated: true, completion: nil)
        
        XLsn0wLog(prompt)
    }
}
