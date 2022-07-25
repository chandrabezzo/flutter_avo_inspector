import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_avo_inspector/consts/visual_inspector_mode.dart';
import 'package:flutter_avo_inspector/flutter_avo_inspector.dart';
import 'package:flutter_avo_inspector/flutter_avo_inspector_env.dart';
import 'package:flutter_avo_inspector_example/track_event_json_request.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool enableLogging = false;

  @override
  void initState() {
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
            title: const Text('Initialization'),
            subtitle: const Text(
              'Need apiKey and environment, '
              'by default, will use env dev',
            ),
            onTap: () async {
              const apiKey = String.fromEnvironment('API_KEY');

              final initialize = await FlutterAvoInspector.initialize(
                apiKey: apiKey,
                env: FlutterAvoInspectorEnv.development,
              );
              if (initialize == 201) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Initialize Avo'),
                ));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Failed Initialize Avo $initialize'),
                ));
              }
            },
          ),
          ListTile(
            title: const Text('Has Initialized'),
            subtitle: const Text(
              'Check avo has initialized or not',
            ),
            onTap: () async {
              final initialize = await FlutterAvoInspector.hasInitialized;
              if (initialize == 201) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Avo has been initialized'),
                ));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Avo has not been initialized'),
                ));
              }
            },
          ),
          ListTile(
            title: const Text('Track Event Params'),
            subtitle: const Text(
              'Track event using params Map<String, dynamic>',
            ),
            onTap: () async {
              final track = await FlutterAvoInspector.trackEventParams(
                eventName: 'event_avo_plugin',
                params: {
                  'dateTime': DateTime.now().toIso8601String(),
                  'detail': 'Just event plugin test, please ignore this event'
                },
              );
              if (track == 200) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Track event params success'),
                ));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Track event params failed'),
                ));
              }
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
                final params = TrackEventJsonRequest(
                  dateTime: DateTime.now().toIso8601String(),
                  detail:
                      'Just event using json plugin test, please ignore this event',
                );

                final track = await FlutterAvoInspector.trackEventParams(
                  eventName: 'event_avo_json_plugin',
                  params: params.toJson(),
                );

                if (track == 200) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Track event JSON success'),
                  ));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Track event JSON failed'),
                  ));
                }
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
                final logging =
                    await FlutterAvoInspector.logging(isEnableLogging: value);
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
              final update = await FlutterAvoInspector.setBatchSize(batchSize: 5);
              if (update == 200) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Set Batch Size success'),
                ));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Set Batch Size failed'),
                ));
              }
            },
          ),
          ListTile(
            title: const Text('Set Batch Size'),
            subtitle: const Text(
              'Update batch size with new value, minimal batch size is 1.'
              ' If you set under 1, the value will set back to 1',
            ),
            onTap: () async {
              final update = await FlutterAvoInspector.setBatchSize(batchSize: 5);
              if (update == 200) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Set Batch Size success'),
                ));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Set Batch Size failed'),
                ));
              }
            },
          ),
          ListTile(
            title: const Text('Batch Size'),
            subtitle: const Text(
              'Get value of batch size',
            ),
            onTap: () async {
              final value = await FlutterAvoInspector.batchSize;
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Value Batch Size: $value'),
              ));
            },
          ),
          ListTile(
            title: const Text('Set Batch Interval'),
            subtitle: const Text(
              'Update batch interval using batch flush seconds',
            ),
            onTap: () async {
              final update = await FlutterAvoInspector.setBatchFlushSeconds(
                  batchFlushSeconds: 200);
              if (update == 200) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Update batch interval success'),
                ));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Update batch interval failed'),
                ));
              }
            },
          ),
          ListTile(
            title: const Text('Batch Interval'),
            subtitle: const Text(
              'Get value of batch interval via batch flush seconds',
            ),
            onTap: () async {
              final value = await FlutterAvoInspector.batchFlushSeconds;
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Batch Flush Seconds: $value'),
              ));
            },
          ),
          ListTile(
            title: const Text('Show Visual Inspector'),
            subtitle: const Text(
              'Show Visual Inspector with specific mode',
            ),
            onTap: () async {
              final show = await FlutterAvoInspector.showVisualInspector(
                mode: VisualInspectorMode.bar,
              );

              if(show == 200){
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Show Visual Inspector Success'),
                ));
              }
              else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Show Visual Inspector Failed'),
                ));
              }
            },
          ),
          ListTile(
            title: const Text('Hide Visual Inspector'),
            subtitle: const Text(
              'Hide Visual Inspector from app',
            ),
            onTap: () async {
              final hide = await FlutterAvoInspector.hideVisualInspector;
              
              if(hide == 200){
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Hide Visual Inspector Success'),
                ));
              }
              else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Hide Visual Inspector Failed'),
                ));
              }
            },
          ),
        ],
      );
}
