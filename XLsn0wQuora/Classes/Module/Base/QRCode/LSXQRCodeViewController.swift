//
//  LSXQRCodeViewController.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/4.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit
import SnapKit
import QorumLogs
import AVFoundation

class LSXQRCodeViewController: UIViewController {
    
//MARK: 懒加载
    //: 摄像头相关
        //: 输入
    private lazy var input:AVCaptureDeviceInput? = { () -> AVCaptureDeviceInput? in
        let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        
        return try? AVCaptureDeviceInput(device: device)
    }()
        //: 会话
    private lazy var session:AVCaptureSession = AVCaptureSession()
        //: 输出
    fileprivate lazy var output:AVCaptureMetadataOutput = { () -> AVCaptureMetadataOutput in
        
        let out = AVCaptureMetadataOutput()
        
        return out
    }()
        //: 预览图层
    fileprivate lazy var previewLayer:AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: self.session)
        //: 二维码框选图层
    fileprivate lazy var drawContainerLayer:CALayer = CALayer()
    //: 主视图
    lazy var mainView:LSXQRCodeView = { () -> LSXQRCodeView in
        let view = LSXQRCodeView()
        //: 一定要设置view的大小，不然添加的图层显示不出来
        view.frame = self.view.bounds
        return view
    }()
    
    lazy var tabBar:UITabBar = {
       let tabBar = UITabBar()
        let QRCodeBar = UITabBarItem(title: "二维码", image: #imageLiteral(resourceName: "qrcode_tabbar_icon_qrcode"), selectedImage: #imageLiteral(resourceName: "qrcode_tabbar_icon_qrcode_highlighted"))
        
        let barCodeBar = UITabBarItem(title: "条形码", image: #imageLiteral(resourceName: "qrcode_tabbar_icon_barcode"), selectedImage: #imageLiteral(resourceName: "qrcode_tabbar_icon_barcode_highlighted"))
        
        tabBar.items = [QRCodeBar,barCodeBar]
        tabBar.tintColor = SystemNavgationBarTintColor
        tabBar.barTintColor = UIColor.black
        
        tabBar.delegate = self
        tabBar.selectedItem = QRCodeBar
        
        return tabBar
    }()
//MARK: 系统方法
    override func viewDidLoad() {
        super.viewDidLoad()
    
        //: 主界面
        view = mainView
        view.addSubview(tabBar)
        
        //: 导航栏
       
        navigationItem.leftBarButtonItem =  UIBarButtonItem("关闭", UIColor.white, fontSize15, target: self, action:#selector(closeScanQRCode))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem("相册", UIColor.white, fontSize15, target: self, action:#selector(openPhotoLibrary))
        
        navigationItem.title = "扫一扫"
        navigationController?.navigationBar.titleTextAttributes = {[NSForegroundColorAttributeName:UIColor.white]
        }()
        navigationController?.navigationBar.barTintColor = UIColor.white
        
        scanQRCode()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tabBar.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(64)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        startAnimation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        QL4("退出了")
    }
//MARK: 内部回调方法
    @objc private func closeScanQRCode() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func openPhotoLibrary() {
        
        //: 判断相册能否打开
        if !UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary)
        {
            return
        }
        
        let imagePickController = UIImagePickerController()
        
        imagePickController.delegate = self
        
        present(imagePickController, animated: true, completion: nil)
        
    }
//MARK: 私有方法
    
    private func scanQRCode() {
        
        //: 判断输入源能否添加到回话中
        guard session.canAddInput(input) else {
            return
        }
        
        //: 判断输出源能否添加到回话中
        guard session.canAddOutput(output) else {
            return
        }
        
        session.addInput(input)
        session.addOutput(output)
        
        //: 设置输出数据类型
        output.metadataObjectTypes = output.availableMetadataObjectTypes
       
        
        //: 监听输出解析到的数据
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        
        //: 插入预览图层
        view.layer.insertSublayer(previewLayer, at: 0)
        previewLayer.frame = mainView.bounds
        
        //: 添加画图层
        view.layer.addSublayer(drawContainerLayer)
        
        QL4(".............")
    
        session.startRunning()
    }
    
    private func setScanArea() {
        //: 获取屏幕的frame
        let rect = self.view.frame
        
        //: 获得扫描区域的frame
        let scanRect = mainView.containerView.frame
        let x = scanRect.origin.y / rect.height
        let y = scanRect.origin.x / rect.width
        let width = scanRect.height / rect.height
        let height = scanRect.width / rect.width
        
        //: 指定扫描区域
        output.rectOfInterest = CGRect(x: x, y: y, width: width, height: height)
    }
    
//MARK: 文件内私有方法
    fileprivate func startAnimation() {
        
        //: 更新布局
        mainView.lineView.snp.updateConstraints { (make) in
            make.bottom.equalTo(mainView.containerView.snp.top)
        }
        //: 父视图来调用layoutIfNeeded() 才会有动画
        view.layoutIfNeeded()
        
        //: 执行动画
        UIView.animate(withDuration: 2.0) {
            UIView.setAnimationRepeatCount(MAXFLOAT)
            
            self.mainView.lineView.snp.updateConstraints { (make) in
                make.bottom.equalTo(self.mainView.containerView.snp.top).offset(self.mainView.lineView.bounds.height + self.mainView.containerView.bounds.height)
            }
            
            //: 父视图来调用layoutIfNeeded() 才会有动画
            self.view.layoutIfNeeded()
        }
        
        //: 设置扫描区域
        setScanArea()
    }
    

}

extension LSXQRCodeViewController:UITabBarDelegate{
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem){
        if item.title == "二维码" {
            QL1("二维码")
            mainView.containerView.snp.remakeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview().offset(-60)
                make.width.height.equalTo(220)
            }
            mainView.lineView.image = #imageLiteral(resourceName: "qrcode_scanline_qrcode")
            
            //: 修改扫描类型为二维码
            output.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
        }else {
            mainView.containerView.snp.remakeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview().offset(-60)
                make.width.equalTo(220)
                make.height.equalTo(55)
            }
            
            mainView.lineView.image = #imageLiteral(resourceName: "qrcode_scanline_barcode")
            
            //: 修改扫描类型为二维码
            output.metadataObjectTypes = [AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code,AVMetadataObjectTypeCode128Code,AVMetadataObjectTypeQRCode]
        }
        
        
        
        view.layoutIfNeeded()
        
        clearDrawLayer()
        
        mainView.lineView.layer.removeAllAnimations()
        
       
        
        startAnimation()
        
    }
}

extension LSXQRCodeViewController:AVCaptureMetadataOutputObjectsDelegate{
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
    
        QL1((metadataObjects.last as AnyObject).stringValue)
        //: 显示结果
        mainView.resultLabel.text = (metadataObjects.last as AnyObject).stringValue
        
        clearDrawLayer()
        
        guard let metadata = metadataObjects.last as? AVMetadataObject else {
            return
        }
        
        let objc = previewLayer.transformedMetadataObject(for: metadata) as? AVMetadataMachineReadableCodeObject
    
        drawLines(objc: objc)
    }
    

    private func drawLines(objc: AVMetadataMachineReadableCodeObject?){
        guard let array = objc?.corners else {
            return
        }
        
        //: 创建图层
        let layer = CAShapeLayer()
        layer.lineWidth = 2
        layer.strokeColor = UIColor.green.cgColor
        layer.fillColor = UIColor.clear.cgColor
        
        //: 创建绘图路径
        let path = UIBezierPath()
        var index = 0
        var point = CGPoint(dictionaryRepresentation: (array[index] as! CFDictionary))!
        index = index + 1
        
        //: 起始点
        path.move(to: point)
        
        while index < array.count {
            
            point = CGPoint(dictionaryRepresentation: (array[index] as! CFDictionary))!
            index = index + 1
            
            //: 连线
            path.addLine(to: point)
        }
      
        path.close()
        
        layer.path = path.cgPath
        
        //: 添加绘图的内容
        drawContainerLayer.addSublayer(layer)
    }
    
    func clearDrawLayer() {
        guard let subLayers = drawContainerLayer.sublayers else {
            return
        }
        
        //: 移除所有图层
        for layer in subLayers {
            layer.removeFromSuperlayer()
        }
    }
}


extension LSXQRCodeViewController:UINavigationControllerDelegate, UIImagePickerControllerDelegate
{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // 1.取出选中的图片
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else
        {
            return
        }
        
        guard let ciImage = CIImage(image: image) else
        {
            return
        }
        
        // 2.从选中的图片中读取二维码数据
        // 2.1创建一个探测器
        let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy: CIDetectorAccuracyLow])
        
        // 2.2利用探测器探测数据
        guard let results = detector?.features(in: ciImage) else {
            return
        }
        
        // 2.3取出探测到的数据
        for result in results
        {
            QL2((result as! CIQRCodeFeature).messageString)
        }
        
        // 注意: 如果实现了该方法, 当选中一张图片时系统就不会自动关闭相册控制器
        picker.dismiss(animated: true, completion: nil)
    }
}

