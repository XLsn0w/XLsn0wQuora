/*
 /*
 * 注意如果遇到某些带有导航栏的页面 出现webView内容页自动下沉的情况 下面的这行代码可以解决
 * automaticallyAdjustsScrollViewInsets = false
 */
 
 class ViewController: UIViewController {
 
 let testUrl = "https://github.com/xlsn0w"
 
 fileprivate var webView: SJWebview = {
 let web = SJWebview()
 // 与前端约定好的注册H5 的名字，没有与H5的交互则不用配置
 web.scriptName = ""
 return web
 }()
 /// 初始化一个没有交互的网页
 fileprivate var simpleWebView: SJWebview = {
 let web = SJWebview()
 return web
 }()
 
 override func viewDidLoad() {
 super.viewDidLoad()
 
 showSimpleWebView()
 //        showComplexWebView()
 
 }
 
 /// 显示一个简单的（没有交互）网页
 func showSimpleWebView() {
 
 view.addSubview(simpleWebView)
 simpleWebView.snp.makeConstraints { (maker) in
 
 maker.edges.equalToSuperview()
 }
 
 // 开始网络请求 替换为你自己想加载的网页
 simpleWebView.startLoading(testUrl) {
 // 此处是没有地址的回调
 }
 
 }
 
 
 
 /// 显示一个有交互的网页
 func showComplexWebView() {
 
 // 如果有交互 在webView.scriptArray 添加需要注入JS 的变量
 webView.scriptArray.append("")
 // 显示这个webView
 view.addSubview(webView)
 webView.snp.makeConstraints { (maker) in
 maker.edges.equalToSuperview()
 }
 // 开始网络请求
 webView.startLoading(testUrl) {
 // 此处是没有地址不能加载的回调
 }
 // 与H5交互的回调
 webView.userContentAction { (userContentController, receiveMessage) in
 
 //            receiveMessage.name 注册JS 的名字
 //            receiveMessage.body H5 传来的参数
 }
 
 }
 */


import UIKit
import WebKit
import SnapKit

/* 使用前必读：
 *          所有可配置的参数均要在 webView 开始加载到视图上之前配置
 * 可配置参数：
 *          1.scriptName 需要注册H5的名字(有交互的H5 必填)
 *          2.scriptArray 注入JS 的参数（有注入JS的H5 必填）
 *          3.cachePolicy 缓存策略（默认不使用缓存 选填）
 *          4.progressColor 进度条颜色（默认是橙色 选填）
 * 回调的参数：
 *          1.startRequestHandler 开始加载
 *          2.didFinishLoadHandler 完成加载
 *          3.userContentAction H5传回的参数
 * 配置步骤：
 *          1.配置必要的参数
 *          2.将webview 添加进视图
 *          3.调用 startLoading() 发起请求
 *          4.监听回调
 *
 */

typealias ScriptResult = (userContentController: WKUserContentController, receiveMessage: WKScriptMessage)

class SJWebview: UIView {
    
    public var scriptName: String?
    /// 存放JS 的数组
    public var scriptArray: [String] = []
    /// 开始加载
    public var startRequestHandler: (() -> Void)?
    /// 完成加载
    public var didFinishLoadHandler: (() ->Void)?
    /// 缓存策略 default is no Caache
    public var cachePolicy: NSURLRequest.CachePolicy = .reloadIgnoringLocalAndRemoteCacheData
    /// 进度条颜色 defaule is orangeColor
    public var progressColor: UIColor = .orange
    /// 存放请求地址的数组
    fileprivate var snapShotsArray: [(request: URLRequest,view: UIView)] = []
    /// H5的传值回调
    fileprivate var scriptHandler: ((ScriptResult) -> Void)?
    
    lazy var webView: WKWebView = {
        
        let webView: WKWebView
        defer {
            // 设置代理
            webView.navigationDelegate = self
            webView.uiDelegate = self
            // 开启手势 后退前进
            webView.allowsBackForwardNavigationGestures = true
            webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        }
        if let scriptName = self.scriptName {
            
            let userContentController: WKUserContentController = WKUserContentController()
            userContentController.add(self, name: scriptName)
            // 注入js
            for script in self.scriptArray {
                let userScript: WKUserScript = WKUserScript(source: script, injectionTime: .atDocumentStart, forMainFrameOnly: true)
                userContentController.addUserScript(userScript)
            }
            // WKWebView的配置
            let configuration: WKWebViewConfiguration = WKWebViewConfiguration()
            configuration.userContentController = userContentController
            // 显示WKWebView
            webView = WKWebView(frame: .zero, configuration: configuration)
        } else {
            webView = WKWebView(frame: .zero)
        }
        return webView
    }()
    
    /// 进度条
    fileprivate lazy var progressView: UIProgressView = {
        let view: UIProgressView = UIProgressView()
        view.tintColor = self.progressColor
        return view
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupViews()
        
    }
    
    /// 开始发起请求
    ///
    /// - Parameters:
    ///   - urlString: 请求的地址
    ///   - unLoad: 没有地址不能加载
    public func startLoading(_ urlString: String, unLoad: @escaping (()-> Void)) {
        
        guard let url = URL.init(string: urlString) else {
            unLoad()
            return
        }
        // 设置请求缓存策略
        let request: URLRequest = URLRequest(url: url, cachePolicy: cachePolicy, timeoutInterval: 10.0)
        // 发起请求
        webView.load(request)
    }
    
    /// H5回调
    public func userContentAction(webView didReceive: @escaping ((_ userContentController: WKUserContentController, _ receiveMessage: WKScriptMessage) -> Void)) {
        scriptHandler = didReceive
    }
    
    /// 调用H5的方法
    public func evaluateJavaScript(_ source: String) {
        
        webView.evaluateJavaScript(source) { (any, error) in
            print("----- 回调H5方法成功\(source)")
        }
    }
    
    /// 监听进度条
    override public func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == #keyPath(WKWebView.estimatedProgress) {
            progressView.alpha = 1.0
            progressView.setProgress(Float(webView.estimatedProgress), animated: true)
            if webView.estimatedProgress >= 1.0 {
                UIView.animate(withDuration: 0.3, delay: 0.3, options: .curveEaseOut, animations: {
                    self.progressView.alpha = 0.0
                }, completion: { (finfished: Bool) in
                    self.progressView.setProgress(0.0, animated: false)
                })
            }
        }
    }
    
    
    deinit {
        
        webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress))
        if let scriptName = scriptName {
            webView.configuration.userContentController.removeScriptMessageHandler(forName: scriptName)
        }
        webView.navigationDelegate = nil
        webView.uiDelegate = nil
    }
    
}



// MARK: UI
extension SJWebview {
    
    
    fileprivate func setupViews() {
        
        addSubview(webView)
        webView.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview()
        }
        addSubview(progressView)
        progressView.snp.makeConstraints { (maker) in
            maker.top.left.right.equalToSuperview()
            maker.height.equalTo(3)
        }
    }
    
    /// 请求链接处理
    func pushCurrentSnapshotView(WithRequest request: URLRequest) {
        
        let lastRequest: URLRequest? = snapShotsArray.last?.request
        
        if request.url?.absoluteString == "about:blank" { return }
        // 如果url一样就不进行push
        if lastRequest?.url?.absoluteString == request.url?.absoluteString { return }
        if let currentSnapShotView: UIView = self.webView.snapshotView(afterScreenUpdates: true) {
            snapShotsArray.append((request: request, view:currentSnapShotView))
        }
    }
    
}
// MARK: - WKScriptMessageHandler 协议
extension SJWebview: WKScriptMessageHandler {
    
    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
        if message.name == scriptName {
            scriptHandler?(userContentController: userContentController, receiveMessage: message)
        } else {
            print("----- 未执行 js 方法, 方法名不匹配: \(message.name)")
        }
    }
    
    // H5的弹窗信息
    public func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        
        print("----- H5的信息是：\(message)")
        completionHandler()
    }
    
    // 完成加载
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        print("----- H5页面加载完成")
        didFinishLoadHandler?()
    }
    
}

extension SJWebview: WKNavigationDelegate {
    
    // 开始加载时
    public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        progressView.isHidden = false
    }
    // 服务器开始请求的时候调用
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        switch navigationAction.navigationType {
        case .linkActivated, .formSubmitted, .other:
            pushCurrentSnapshotView(WithRequest: navigationAction.request)
            
        default: break
        }
        
        startRequestHandler?()
        decisionHandler(.allow)
    }
    
}


extension SJWebview: WKUIDelegate {
    
}
