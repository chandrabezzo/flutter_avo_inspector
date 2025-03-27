import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_avo_inspector/flutter_avo_inspector.dart';

import 'track_event_json_request.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool enableLogging = false;
  late FlutterAvoInspector avoInspector;

  @override
  void initState() {
    const apiKey = String.fromEnvironment('API_KEY');

    avoInspector = FlutterAvoInspector(
      apiKey: apiKey,
      appName: 'example_avo',
      appVersion: '1.0.0',
      env: FlutterAvoInspectorEnv.development,
    );

    super.initState();
    FlutterAvoInspector.isLogging.then((value) {
      setState(() {
        enableLogging = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Avo Inspector'),
        ),
        body: buildBody(context),
      );

  Widget buildBody(BuildContext context) => ListView(
        children: [
          ListTile(
            title: const Text('Has Initialized'),
            subtitle: const Text(
              'Check avo has initialized or not',
            ),
            onTap: () async {
              final ctx = context;
              await avoInspector.hasInitialized.then((value) {
                if (!ctx.mounted) return;

                if (value == 201) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Avo has been initialized'),
                  ));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Avo has not been initialized'),
                  ));
                }
              });
            },
          ),
          ListTile(
            title: const Text('Track Event Params'),
            subtitle: const Text(
              'Track event using params Map<String, dynamic>',
            ),
            onTap: () async {
              final ctx = context;
              await avoInspector.trackEventParams(
                eventName: 'event_avo_plugin',
                params: {
                  'dateTime': DateTime.now().toIso8601String(),
                  'detail': 'Just event plugin test, please ignore this event'
                },
              ).then((value) {
                if (!ctx.mounted) return;
                if (value == 200) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Track event params success'),
                  ));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Track event params failed'),
                  ));
                }
              });
            },
          ),
          Visibility(
            visible: Platform.isAndroid,
            replacement: const SizedBox.shrink(),
            child: ListTile(
              title: const Text('Track Event JSON'),
              subtitle: const Text(
                'Track event using params Json',
              ),
              onTap: () async {
                final ctx = context;
                final params = TrackEventJsonRequest(
                  dateTime: DateTime.now().toIso8601String(),
                  detail:
                      'Just event using json plugin test, please ignore this event',
                );

                await avoInspector
                    .trackEventParams(
                  eventName: 'event_avo_json_plugin',
                  params: params.toJson(),
                )
                    .then((value) {
                  if (!ctx.mounted) return;
                  if (value == 200) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Track event JSON success'),
                    ));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Track event JSON failed'),
                    ));
                  }
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Enable Logging'),
            subtitle: const Text(
              'To enable / disable logging',
            ),
            trailing: CupertinoSwitch(
              value: enableLogging,
              onChanged: (value) async {
                final ctx = context;
                await avoInspector.logging(value).then((logging) {
                  if (!ctx.mounted) return;
                  if (logging == 200) {
                    String enableMessage = '';
                    if (value) {
                      enableMessage = 'Enable Logging Success';
                    } else {
                      enableMessage = 'Disable Logging Success';
                    }

                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(enableMessage),
                    ));

                    setState(() {
                      enableLogging = value;
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Set Loggin Failed'),
                    ));
                  }
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Set Batch Size'),
            subtitle: const Text(
              'Update batch size with new value, minimal batch size is 1.'
              ' If you set under 1, the value will set back to 1',
            ),
            onTap: () async {
              final ctx = context;
              await avoInspector.setBatchSize(5).then((value) {
                if (!ctx.mounted) return;
                if (value == 200) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Set Batch Size success'),
                  ));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Set Batch Size failed'),
                  ));
                }
              });
            },
          ),
          ListTile(
            title: const Text('Set Batch Size'),
            subtitle: const Text(
              'Update batch size with new value, minimal batch size is 1.'
              ' If you set under 1, the value will set back to 1',
            ),
            onTap: () async {
              final ctx = context;
              await avoInspector.setBatchSize(5).then((value) {
                if (!ctx.mounted) return;
                if (value == 200) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Set Batch Size success'),
                  ));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Set Batch Size failed'),
                  ));
                }
              });
            },
          ),
          ListTile(
            title: const Text('Batch Size'),
            subtitle: const Text(
              'Get value of batch size',
            ),
            onTap: () async {
              final ctx = context;
              await avoInspector.batchSize.then((value) {
                if (!ctx.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Value Batch Size: $value'),
                ));
              });
            },
          ),
          ListTile(
            title: const Text('Set Batch Interval'),
            subtitle: const Text(
              'Update batch interval using batch flush seconds',
            ),
            onTap: () async {
              final ctx = context;
              await avoInspector.setBatchFlushSeconds(200).then((value) {
                if (!ctx.mounted) return;
                if (value == 200) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Update batch interval success'),
                  ));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Update batch interval failed'),
                  ));
                }
              });
            },
          ),
          ListTile(
            title: const Text('Batch Interval'),
            subtitle: const Text(
              'Get value of batch interval via batch flush seconds',
            ),
            onTap: () async {
              final ctx = context;
              await avoInspector.batchFlushSeconds.then((value) {
                if (!ctx.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Batch Flush Seconds: $value'),
                ));
              });
            },
          ),
          ListTile(
            title: const Text('Show Visual Inspector'),
            subtitle: const Text(
              'Show Visual Inspector with specific mode',
            ),
            onTap: () async {
              final ctx = context;
              await avoInspector
                  .showVisualInspector(
                VisualInspectorMode.bubble,
              )
                  .then((value) {
                if (!ctx.mounted) return;
                if (value == 200) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Show Visual Inspector Success'),
                  ));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Show Visual Inspector Failed'),
                  ));
                }
              });
            },
          ),
          ListTile(
            title: const Text('Hide Visual Inspector'),
            subtitle: const Text(
              'Hide Visual Inspector from app',
            ),
            onTap: () async {
              final ctx = context;
              await avoInspector.hideVisualInspector.then((value) {
                if (!ctx.mounted) return;
                if (value == 200) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Hide Visual Inspector Success'),
                  ));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Hide Visual Inspector Failed'),
                  ));
                }
              });
            },
          ),
        ],
      );
}
