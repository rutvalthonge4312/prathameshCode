import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

void main() {
  runApp(TextEditorApp());
}

class TextEditorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TextEditorPage(),
    );
  }
}

class TextEditorPage extends StatefulWidget {
  @override
  _TextEditorPageState createState() => _TextEditorPageState();
}

class _TextEditorPageState extends State<TextEditorPage> {
  String _selectedFont = 'Arial';
  double _fontSize = 16;
  Color _selectedColor = Colors.black;
  TextEditingController _textController = TextEditingController();
  String _displayText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text Editor'),
        actions: [
          IconButton(
            icon: Icon(Icons.undo),
            onPressed: () {
              // Add undo functionality
            },
          ),
          IconButton(
            icon: Icon(Icons.redo),
            onPressed: () {
              // Add redo functionality
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
                child: Center(
                  child: Text(
                    _displayText,
                    style: TextStyle(
                      fontFamily: _selectedFont,
                      fontSize: _fontSize,
                      color: _selectedColor,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    value: _selectedFont,
                    items: ['Arial', 'Times New Roman', 'Courier New']
                        .map((font) => DropdownMenuItem(
                              child: Text(font),
                              value: font,
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedFont = value!;
                      });
                    },
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Row(
                    children: [
                      Text('Size:'),
                      SizedBox(width: 8),
                      DropdownButton<double>(
                        value: _fontSize,
                        items: [12, 14, 16, 18, 20, 22, 24]
                            .map((size) => DropdownMenuItem(
                                  child: Text(size.toString()),
                                  value: size.toDouble(),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _fontSize = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Row(
                    children: [
                      Text('Color:'),
                      SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Pick a color'),
                              content: SingleChildScrollView(
                                child: BlockPicker(
                                  pickerColor: _selectedColor,
                                  onColorChanged: (color) {
                                    setState(() {
                                      _selectedColor = color;
                                    });
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: 24,
                          height: 24,
                          color: _selectedColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: 'New Text',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _displayText = _textController.text;
                });
              },
              child: Text('Add Text'),
            ),
          ],
        ),
      ),
    );
  }
}
