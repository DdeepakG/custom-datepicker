// ignore_for_file: avoid_print

import 'package:bdp/custom_cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: Scaffold(
        appBar: AppBar(title: Text('Custom Cupertino Date Picker')),
        body: ExampleApp(),
      ),
    );
  }
}

class ExampleApp extends StatefulWidget {
  @override
  State<ExampleApp> createState() => _ExampleAppState();
}

class _ExampleAppState extends State<ExampleApp> {
  final buttonWidth = 300.0;

  final TextEditingController _textController = TextEditingController();

  String _selectedValue = '';
  // Initialize with an empty value
  var _selecteDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffF6F2F2),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.flutter_dash,
            size: 300,
            color: Colors.blue,
          ),
          SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: TextFormField(
              controller: _textController,
              readOnly: true, // Make it non-editable
              onTap: () {
                _openDatePicker(context: context, label: 'Date of Joining');
              },
              decoration: InputDecoration(
                hintText: 'Enter DoJ',
                labelText: 'Date of Joining',
                border: OutlineInputBorder(),
                suffixIcon: _textController.text.isNotEmpty? IconButton(icon:Icon(Icons.close),onPressed: (){setState(() {
                  _textController.clear();
                });},):null
              ),
            ),
          ),
        ],
      ),
    );
  }

  _openDatePicker(
      {required BuildContext context,
      DateTime? minDate,
      DateTime? maxDate,
      DateTime? selectedDate,
      required String label}) {
    final DateTime currentDate = DateTime.now();
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Colors.grey.shade600,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
                color: Colors.white),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Column(
                    children: [
                      Container(
                          margin: EdgeInsets.only(top: 16, bottom: 24),
                          height: 2,
                          width: 32,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                              color: Colors.grey.shade400)),
                      Text(
                        'Select',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.pink,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        label,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.purple,
                        ),
                      ),
                      SizedBox(height: 16),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Divider(thickness: 1)),
                    ],
                  ),
                ),
                SizedBox(
                    height: 200,
                    child: CustomCupertinoDatePicker(
                      itemExtent: 50,
                      onSelectedItemChanged: (date) {
                        _selecteDate = date;
                        print(_selecteDate.toString());
                      },
                      minDate: minDate ??
                          DateTime(
                            currentDate.year - 100,
                            currentDate.month,
                            currentDate.day,
                          ),
                      maxDate: maxDate ??
                          DateTime(
                            currentDate.year,
                            currentDate.month,
                            currentDate.day,
                          ),
                      selectedDate: _selecteDate,
                      selectionOverlay: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: const BoxDecoration(
                            // border: Border.symmetric(
                            //   horizontal:BorderSide(color:Colors.grey,width:1),
                            // ),
                            ),
                      ),
                      selectedStyle: const TextStyle(
                        color: Colors.pink,
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                      ),
                      unselectedStyle: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 18,
                      ),
                      disabledStyle: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 18,
                      ),
                    )),
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 48.0, vertical: 16),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        // Handle OK button press (e.g., save the entered text)
                        final enteredText = _textController.text;
                        setState(() {
                          final df = DateFormat('dd/MM/yyyy');
                          _textController.text = df.format(_selecteDate);
                        });
                        print('Entered text: $enteredText');
                        Navigator.pop(context); // Close the bottom sheet
                      },
                      child: Text('Confirm'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
