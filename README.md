# Flutter Avo Inspector
![GitHub code size](https://img.shields.io/github/languages/code-size/chandrabezzo/flutter_avo_inspector)
![GitHub followers](https://img.shields.io/github/followers/chandrabezzo?style=social)
![GitHub contributors](https://img.shields.io/github/contributors/chandrabezzo/flutter_avo_inspector)
[![Linkedin](https://i.stack.imgur.com/gVE0j.png) LinkedIn](https://www.linkedin.com/in/chandra-abdul-fattah/)
[![GitHub](https://i.stack.imgur.com/tskMh.png) GitHub](https://github.com/chandrabezzo/)

`flutter_avo_inspector` allows you to integration Flutter with Native Avo Inspector Native SDK.

## Setting things up
First of all, if you don't have one already, you must have an `apiKey`.
1. Get your apiKey
2. You need to call initialization in the first of all, for example in main.dart
```dart
    await AvoInspector.initialize(
        apiKey: avoApiKey, 
        env: 'development',
    );
```
* Don't forget to replace [avoApiKey] with your apiKey

# Official Documentation
## Android
For more information you can see full setup from [Avo Inspector Android](https://www.avo.app/docs/implementation/inspector/sdk/android). Please follow instruction for [installation](https://www.avo.app/docs/implementation/inspector/sdk/android#a-nameinstallationainstallation).

## iOS
For more information you can see full setup from [Avo Inspector iOS](https://www.avo.app/docs/implementation/inspector/sdk/ios)

## Getting involved
First of all, thank you for even considering to get involved. You are a real super :star:  and we :heart:  you!

### Reporting bugs and issues
Use the configured [Github issue report template](https://github.com/chandrabezzo/flutter_avo_inspector/issues/new?assignees=&labels=&template=bug_report.md&title=) when reporting an issue. Make sure to state your observations and expectations
as objectively and informative as possible so that we can understand your need and be able to troubleshoot.

### Discussions and ideas
We're happy to discuss and talk about ideas in the
[repository discussions](https://github.com/chandrabezzo/flutter_avo_inspector/discussions) and/or post your
question to [StackOverflow](https://stackoverflow.com/search?q=flutter+avo+inspector).
Feel free to open a thread if you are having any questions on how to use either the Facebook SDK as a reporting tool
itself or even on how to use this plugin. 
