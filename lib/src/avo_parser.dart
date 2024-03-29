import 'package:flutter/material.dart';

String _runtimeTypeToAvoType(String? type) {
  if (type == null) {
    return "null";
  }

  if (type.contains("list") || type.contains(("set"))) {
    return "list";
  } else if (type.contains("map")) {
    return "object";
  } else if (["double", "float"].contains(type)) {
    return "float";
  } else if (["string", "int", "bool"].contains(type)) {
    return type;
  }

  return "unknown";
}

String _extractType(Object? eventParam) {
  final type = eventParam?.runtimeType.toString().toLowerCase();

  return _runtimeTypeToAvoType(type);
}

List<Map<String, dynamic>> extractSchemaFromEventParams(
    {required Map<String, dynamic> eventParams}) {
  List<Map<String, dynamic>> children = [];

  eventParams.forEach((key, value) {
    children.add({
      "propertyName": key,
    }..addAll(extractTypeJson(value)));
  });

  return children;
}

@visibleForTesting
Map<String, dynamic> extractTypeJson(Object? eventParam) {
  try {
    final type = _extractType(eventParam);

    if (type == "list") {
      final runtimeType = eventParam.runtimeType.toString().toLowerCase();

      var subtype = runtimeType.substring(
          runtimeType.indexOf("<") + 1, runtimeType.indexOf(">"));

      final isOptional = subtype.contains("?");

      if (isOptional) {
        subtype = subtype.substring(0, subtype.length - 1);
      }

      var children = <String>{};
      if (subtype == "dynamic" || subtype == "object") {
        for (var element in (eventParam as Iterable)) {
          children.add(_extractType(element));
        }
      } else if ((eventParam as Iterable).isNotEmpty) {
        children.add(subtype);
      }

      if (isOptional) {
        children.add("null");
      }

      return {"propertyType": type, "children": children.toList()};
    } else if (type == "object") {
      Map<String, dynamic> map = eventParam as Map<String, dynamic>;

      var children = extractSchemaFromEventParams(eventParams: map);
      return {"propertyType": type, "children": children};
    } else {
      return {
        "propertyType": type,
      };
    }
  } catch (e) {
    debugPrint("Fialed to extrac schema from $eventParam");
    return {
      "propertyType": "unknown",
    };
  }
}
