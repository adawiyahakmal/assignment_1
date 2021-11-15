import 'package:flutter/material.dart';
import 'package:example/select_form_field.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Assignment 1 List in Flutter',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey<FormState> _oFormKey = GlobalKey<FormState>();
  TextEditingController? _controller;
  String _valueSaved = '';

  final List<Map<String, dynamic>> _items = [
    {
      'value': 'Nasi Lemak',
      'label': '1',
    },
    {
      'value': 'Bihun Tomyam',
      'label': '2',
    },
    {
      'value': 'Bubur Lambuk',
      'label': '3',
    },
    {
      'value': 'Mee Kari',
      'label': '4',
    },
    {
      'value': 'Laksa',
      'label': '5',
    },
  ];

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController(text: '2');

    _getValue();
  }

  /// This implementation is just to simulate a load data behavior
  /// from a data base sqlite or from a API
  Future<void> _getValue() async {
    await Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _controller?.text = '';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ASSIGNMENT 1'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 20, right: 20, top: 10),
        child: Form(
          key: _oFormKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 10),
              Text(
                "\nMENU OF THE DAY",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "1. Nasi Lemak \n2. Bihun Tomyam \n3. Bubur Lambuk \n4. Mee Kari \n5. Laksa\n\n",
                //style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SelectFormField(
                type: SelectFormFieldType.dialog,
                controller: _controller,
                labelText: 'Enter your choice',
                dialogTitle: 'Pick a item',
                dialogCancelBtn: 'CANCEL',
                enableSearch: true,
                dialogSearchHint: 'Search item',
                items: _items,
                onSaved: (val) => setState(() => _valueSaved = val ?? ''),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  final loForm = _oFormKey.currentState;

                  if (loForm?.validate() == true) {
                    loForm?.save();
                  }
                },
                child: Text('Submit'),
              ),
              SizedBox(height: 30),
              Text(
                'Great! Your choice is:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              SelectableText(_valueSaved),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  final loForm = _oFormKey.currentState;
                  loForm?.reset();

                  setState(() {
                    _valueSaved = '';
                    _controller?.clear();
                  });
                },
                child: Text('Reset'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
