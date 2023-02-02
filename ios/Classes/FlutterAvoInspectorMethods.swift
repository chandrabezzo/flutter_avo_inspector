//
//  FlutterAvoInspectorMethods.swift
//  flutter_avo_inspector
//
//  Created by Chandra Abdul Fattah on 02/02/23.
//

import Foundation
import AvoInspector

class FlutterAvoInspectorMethods {
    static func trackEventParams(
        avo: AvoInspector,
        call: FlutterMethodCall,
        result: @escaping FlutterResult
    ){
        let args = call.arguments as! [String : Any]
        
        let name = args[Arguments.eventName] as! String
        let params = args[Arguments.eventParams] as? [String: Any]
        
        let track = avo.trackSchema(fromEvent: name, eventParams: params ?? [:] )
        
        result(Constants.successResult)
    }

    static func logging(call: FlutterMethodCall, result: @escaping FlutterResult){
        let args = call.arguments as! [String : Any]

        let isEnable = args[Arguments.isEnableLogging] as! Bool
        AvoInspector.setLogging(isEnable)
        result(Constants.successResult)
    }

    static func isLogging(result: @escaping FlutterResult){
        let isEnableLogging = AvoInspector.isLogging()
        result(isEnableLogging)
    }

    static func setBatchSize(call: FlutterMethodCall, result: @escaping FlutterResult){
        let args = call.arguments as! [String : Any]

        let batchSize = args[Arguments.batchSize] as! Int32

        AvoInspector.setBatchSize(batchSize)
        result(Constants.successResult)
    }

    static func batchSize(call: FlutterMethodCall, result: @escaping FlutterResult){
        let value = AvoInspector.getBatchSize()
        result(value)
    }

    static func setBatchFlushSeconds(call: FlutterMethodCall, result: @escaping FlutterResult){
        let args = call.arguments as! [String : Any]
        let batchFlushSeconds = args[Arguments.batchFlushSeconds] as! Int32
        AvoInspector.setBatchFlushSeconds(batchFlushSeconds)
        result(Constants.successResult)
    }

    static func batchFlushSeconds(call: FlutterMethodCall, result: @escaping FlutterResult){
        let batchFlushSeconds = AvoInspector.getBatchFlushSeconds()
        result(batchFlushSeconds)
    }
    
    static func showVisualInspector(avo: AvoInspector, call: FlutterMethodCall, result: @escaping FlutterResult){
        let args = call.arguments as! [String : Any]

        let mode = args[Arguments.visualInspectorMode] as! Int
        var viMode: AvoVisualInspectorType = AvoVisualInspectorType.Bubble
        
        if(mode == 0){
            viMode = AvoVisualInspectorType.Bar
        }
        
        avo.show(viMode)
        result(Constants.successResult)
    }
    
    static func hideVisualInspector(avo: AvoInspector, call: FlutterMethodCall, result: @escaping FlutterResult){
        avo.hideVisualInspector()
        result(Constants.successResult)
    }
}
