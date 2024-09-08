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
