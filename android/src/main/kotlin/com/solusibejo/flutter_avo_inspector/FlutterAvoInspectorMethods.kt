package com.solusibejo.flutter_avo_inspector

import android.app.Activity
import app.avo.inspector.AvoInspector
import app.avo.inspector.VisualInspectorMode
import com.solusibejo.flutter_avo_inspector.consts.Arguments
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import org.json.JSONObject

object FlutterAvoInspectorMethods {
    fun trackEventParams(
        avo: AvoInspector,
        call: MethodCall,
        result: MethodChannel.Result
    ){
        val name = call.argument<String>(Arguments.eventName)!!
        val params = call.argument<Map<String, Any>?>(Arguments.eventParams)

        avo.trackSchemaFromEvent(
            name,
            params ?: emptyMap<String, Any>()
        )

        result.success(200)
    }

    fun trackEventJson(
        avo: AvoInspector,
        call: MethodCall,
        result: MethodChannel.Result
    ) {
        val name = call.argument<String>(Arguments.eventName)!!
        val jsonObject = call.argument<JSONObject?>(Arguments.eventJson)

        val track = avo.trackSchemaFromEvent(name, jsonObject)

        if(track.entries.isNotEmpty()){
            result.success(200)
        }
        else {
            result.error("500", "Track using params JSONObject failed",
                "Entries is empty, track using params JSONObject failed")
        }
    }

    fun logging(
        call: MethodCall,
        result: MethodChannel.Result
    ) {
        val isEnable = call.argument<Boolean>(Arguments.isEnableLogging)!!
        AvoInspector.enableLogging(isEnable)
        result.success(200)
    }

    fun isLogging(
        result: MethodChannel.Result
    ) {
        val isEnableLogging = AvoInspector.isLogging()
        result.success(isEnableLogging)
    }

    fun setBatchSize(
        call: MethodCall,
        result: MethodChannel.Result
    ) {
        val batchSize = call.argument<Int>(Arguments.batchSize)!!
        AvoInspector.setBatchSize(batchSize)
        result.success(200)
    }

    fun batchSize(
        result: MethodChannel.Result
    ) {
        val size = AvoInspector.getBatchSize()
        result.success(size)
    }

    fun setBatchFlushSeconds(
        call: MethodCall,
        result: MethodChannel.Result
    ) {
        val batchFlushSeconds = call.argument<Int>(Arguments.batchFlushSeconds)!!
        AvoInspector.setBatchFlushSeconds(batchFlushSeconds)
        result.success(200)
    }

    fun batchFlushSeconds(
        result: MethodChannel.Result
    ) {
        val batchFlushSeconds = AvoInspector.getBatchFlushSeconds()
        result.success(batchFlushSeconds)
    }

    fun showVisualInspector(
        activity: Activity,
        avo: AvoInspector,
        call: MethodCall,
        result: MethodChannel.Result
    ) {
        val mode = call.argument<Int>(Arguments.visualInspectorMode)!!
        var viMode = VisualInspectorMode.BUBBLE

        if(mode == 0) viMode = VisualInspectorMode.BAR

        avo.showVisualInspector(activity, viMode)
        result.success(200)
    }

    fun hideVisualInspector(
        activity: Activity,
        avo: AvoInspector,
        result: MethodChannel.Result
    ) {
        avo.hideVisualInspector(activity)
        result.success(200)
    }
}