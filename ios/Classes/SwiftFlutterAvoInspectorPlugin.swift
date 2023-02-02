import Flutter
import UIKit
import AvoInspector

public class SwiftFlutterAvoInspectorPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
      let channel = FlutterMethodChannel(name: Constants.pluginName, binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterAvoInspectorPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
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
            AvoInspectorMethods.trackEventParams(avo: avo!, call: call, result: result)
        case MethodNames.logging:
            AvoInspectorMethods.logging(call: call, result: result)
        case MethodNames.isLogging:
            AvoInspectorMethods.isLogging(result: result)
            break
        case MethodNames.setBatchSize:
            AvoInspectorMethods.setBatchSize(call: call, result: result)
            break
        case MethodNames.batchSize:
            AvoInspectorMethods.batchSize(call: call, result: result)
            break
        case MethodNames.setBatchFlushSeconds:
            AvoInspectorMethods.setBatchFlushSeconds(call: call, result: result)
            break
        case MethodNames.batchFlushSeconds:
            AvoInspectorMethods.batchFlushSeconds(call: call, result: result)
            break
        case MethodNames.showVisualInspector:
            AvoInspectorMethods.showVisualInspector(avo: avo!, call: call, result: result)
            break
        case MethodNames.hideVisualInspector:
            AvoInspectorMethods.hideVisualInspector(avo: avo!, call: call, result: result)
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
