# MultiValueListenableBuilder

`MultiValueListenableBuilder` is a Flutter widget that listens to multiple `ValueNotifier`s and rebuilds its UI when any of them change. This is useful when you need to react to changes from multiple value notifiers and update the UI accordingly.

## Features

- Listens to multiple `ValueNotifier`s at once.
- Automatically rebuilds the UI when any of the notifiers change.
- Provides a clean and simple API for handling multiple `ValueNotifier`s in your Flutter apps.

## Installation

Add the following to your `pubspec.yaml`:

```yaml
dependencies:
  multi_value_listenable: ^1.0.0
```

Then run:

```bash
flutter pub get
```

## Usage

The `MultiValueListenableBuilder` widget takes in a list of `ValueNotifier`s and listens for changes. When any of the notifiers change, the `builder` function is called, allowing you to update the UI.

### Example

```dart
import 'package:flutter/material.dart';
import 'package:multi_value_listenable/multi_value_listenable.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Multi Value Listenable',
      home: MyHomePage(),
    );
  }
}

class NameController extends TextEditingController {}

class SurnameController extends TextEditingController {}

class MiddleNameController extends TextEditingController {}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late NameController _nameController;
  late SurnameController _surnameController;
  late MiddleNameController _middleNameController;

  @override
  void initState() {
    super.initState();
    _nameController = NameController();
    _surnameController = SurnameController();
    _middleNameController = MiddleNameController();
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _surnameController.dispose();
    _middleNameController.dispose();
  }

  void _callback() {}

  void _listen(ListValueNotifier values) {
    final name = values.get<NameController>();
    final surname = values.get<SurnameController>();
    final middleName = values.get<MiddleNameController>();

    final bool isAccess = name.text.isNotEmpty &&
        surname.text.isNotEmpty &&
        middleName.text.isNotEmpty;

    if (isAccess) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Success'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
            ),
            TextField(
              controller: _surnameController,
              decoration: const InputDecoration(
                labelText: 'Surname',
              ),
            ),
            TextField(
              controller: _middleNameController,
              decoration: const InputDecoration(
                labelText: 'Middle Name',
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            MultiValueListenableBuilder(
              listenable: _listen,
              valuesListenable: [
                _nameController,
                _surnameController,
                _middleNameController,
              ],
              builder: (context, values, child) {
                final name = values.get<NameController>();
                final surname = values.get<SurnameController>();
                final middleName = values.get<MiddleNameController>();

                final bool isDisable = name.text.isEmpty ||
                    surname.text.isEmpty ||
                    middleName.text.isEmpty;

                return ElevatedButton(
                  onPressed: isDisable ? null : _callback,
                  child: const Text('Send'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
```

In this example:
- We have three `TextEditingController` instances for `Name`, `Surname`, and `Middle Name`.
- The `MultiValueListenableBuilder` listens to these controllers and updates the button's state based on whether the fields are filled in.
- The `listenable` callback checks if all fields are non-empty and shows a success message.

### Parameters

- `valuesListenable`: A list of `ValueNotifier`s to listen to. The builder function will be called whenever any of the notifiers change.
- `builder`: The function that builds the widget tree. It is called with the current `BuildContext`, the list of values from the notifiers, and an optional `child` widget.
- `listenable` (optional): A function that can be triggered when the notifiers change.
- `child` (optional): A widget that is passed to the builder and can be used to optimize performance by not rebuilding static content.

## License

This package is licensed under the MIT License. See the [LICENSE](./LICENSE) file for more information.

---

You can customize the GitHub URL and other details as needed. Let me know if you need further adjustments!