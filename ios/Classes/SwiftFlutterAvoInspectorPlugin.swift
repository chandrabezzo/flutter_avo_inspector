import Flutter
import UIKit
import AvoInspector

public class SwiftFlutterAvoInspectorPlugin: NSObject, FlutterPlugin {

  var avo: AvoInspector? = nil

  public static func register(with registrar: FlutterPluginRegistrar) {
      let channel = FlutterMethodChannel(name: Constants.pluginName, binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterAvoInspectorPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }
    
  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
        case MethodNames.initialize:
            initialize(call: call, result: result)
            break
        case MethodNames.hasInitialized:
            hasInitialized(result: result)
            break
        case MethodNames.trackEventParams:
            FlutterAvoInspectorMethods.trackEventParams(avo: avo!, call: call, result: result)
        case MethodNames.logging:
            FlutterAvoInspectorMethods.logging(call: call, result: result)
        case MethodNames.isLogging:
            FlutterAvoInspectorMethods.isLogging(result: result)
            break
        case MethodNames.setBatchSize:
            FlutterAvoInspectorMethods.setBatchSize(call: call, result: result)
            break
        case MethodNames.batchSize:
            FlutterAvoInspectorMethods.batchSize(call: call, result: result)
            break
        case MethodNames.setBatchFlushSeconds:
            FlutterAvoInspectorMethods.setBatchFlushSeconds(call: call, result: result)
            break
        case MethodNames.batchFlushSeconds:
            FlutterAvoInspectorMethods.batchFlushSeconds(call: call, result: result)
            break
        case MethodNames.showVisualInspector:
            FlutterAvoInspectorMethods.showVisualInspector(avo: avo!, call: call, result: result)
            break
        case MethodNames.hideVisualInspector:
            FlutterAvoInspectorMethods.hideVisualInspector(avo: avo!, call: call, result: result)
            break
        default:
            result(FlutterMethodNotImplemented)
    }
        
  }
    
  private func initialize(call: FlutterMethodCall, result: @escaping FlutterResult){
    let args = call.arguments as! [String : Any]
    let apiKey = args[Arguments.apiKey] as! String
    let env = args[Arguments.environment] as! String
    
    avo = instance(apiKey: apiKey, env: getEnv(environment: env))
    result(Constants.createdResult)
  }
    
  private func instance(apiKey: String, env: AvoInspectorEnv) -> AvoInspector {
    return AvoInspector(apiKey: apiKey, env: env)
  }
    
  private func getEnv(environment: String) -> AvoInspectorEnv {
    switch environment {
        case Constants.staging:
            return AvoInspectorEnv.staging
        case Constants.production:
            return AvoInspectorEnv.prod
        default:
            return AvoInspectorEnv.dev
    }
  }
    
  private func hasInitialized(result: @escaping FlutterResult) {
    if(avo != nil){
        result(Constants.createdResult)
    }
    else {
        result(FlutterError(code: "404", message: "Avo Not Initialized", details: "Please call method initialize first"))
    }
  }
}
