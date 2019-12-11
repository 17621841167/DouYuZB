//
//  PageTitleView.swift
//  DYZB
//
//  Created by liuhangjun on 2019/12/11.
//  Copyright © 2019 liuhangjun. All rights reserved.
//

import UIKit

private let kScrollLinH : CGFloat = 2
class PageTitleView: UIView {
    //MARK: -懒加载属性
    
    private lazy var titleLabels : [UILabel] = [UILabel]()
    private var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.isPagingEnabled = false//默认false
        scrollView.bounces = false
        return scrollView
    }()
    private var scollLine : UIView = {
       let scollLine = UIView()
        
        scollLine.backgroundColor = UIColor.orange
         return scollLine
    }()
    
    //MARK: -定义属性
    private var titles : [String]
    
    //MARK: -自定义构造函数
    init(frame: CGRect, titles : [String] ) {
        self.titles = titles
        super.init(frame: frame)
        
        //设置UI界面
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
//MARK: -设置UI界面

extension PageTitleView {
    private func setupUI(){
        //1.添加UIScrollview
        addSubview(scrollView)
        scrollView.frame = bounds
        
        //2.d添加对应的Label
        setupTitleLabel()
        
        //3.设置底线和滚动滑块
        setupBottomLineAndScrollLine()
        
    }
    private func setupTitleLabel(){
        for (index, title) in titles.enumerated() {
            
            //0 确定label的一些frame的值
            let labelW : CGFloat = frame.width / CGFloat(titles.count)
            let labelH : CGFloat = frame.height - kScrollLinH
            let labelY : CGFloat = 0
            //1.创建Label
            let label = UILabel()
            
            //2.设置label的属性
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = UIColor.darkGray
            label.textAlignment = .center
            //3设置label.frame
            let labelX : CGFloat = labelW * CGFloat(index)

            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            //4.将label添加到scrollView 中
            scrollView.addSubview(label)
            titleLabels.append(label)
        }
    }
    
    private func setupBottomLineAndScrollLine() {
        //1.添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        //2.添加scollLine
        //2.1 获取第一个label
        guard let firstLabel = titleLabels.first else { return }
        firstLabel.textColor = UIColor.orange
        scrollView.addSubview(scollLine)
        
        
        scollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLinH, width: firstLabel.frame.width, height: kScrollLinH)
    }
}
