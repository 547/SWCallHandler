//
//  SWCallHandler.swift
//  SWCallHandler
//
//  Created by Supernova SanDick SSD on 2019/6/24.
//  Copyright © 2019 Seven. All rights reserved.
//

import Foundation
public class SWCallHandler {
    public typealias FailHandler = (_ error:CallError) -> ()
    public static func call(_ phoneNumber:String?, fail:FailHandler?) -> () {
        guard let phoneNumber = phoneNumber, let url = URL.init(string: "tel://" + phoneNumber) else {
            fail?(CallError.number)
            return
        }
        guard UIApplication.shared.canOpenURL(url) else {
            fail?(CallError.openFail)
            return
        }
        UIApplication.shared.openURL(url)
    }
    public static func shouldAutoDisposeFailWhenCall(_ phoneNumber:String?) -> () {
        guard let phoneNumber = phoneNumber, let url = URL.init(string: "tel://" + phoneNumber) else {
            self.disposeFail(.number)
            return
        }
        guard UIApplication.shared.canOpenURL(url) else {
            self.disposeFail(.openFail)
            return
        }
        UIApplication.shared.openURL(url)
    }
}
extension SWCallHandler {
    public enum CallError {
        case number
        case openFail
    }
}
fileprivate extension SWCallHandler {
    static func disposeFail(_ error:SWCallHandler.CallError) -> () {
        switch error {
        case .number:
            print("电话号码出错")
        case .openFail:
            print("拨号页打开失败")
        }
    }
}
