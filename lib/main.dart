import 'package:flutter/material.dart';
import 'package:speech_to_text_toggle_example/presentation/page/text_list_view.dart';
import 'package:speech_to_text_toggle_example/presentation/widget/custom_text_form_field.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const MyHomePage(title: 'Speech to Text Toggle'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> _messages = [];
  final FocusNode _focusNode = FocusNode();  // FocusNode 추가

  void _addMessage(String message) {
    setState(() {
      _messages.add(message);
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();  // FocusNode 해제
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: TextListView(items: _messages),
              ),
              CustomTextFormField(
                onSend: _addMessage,
                focusNode: _focusNode,  // FocusNode 전달
              ),
            ],
          ),
        ),
      ),
    );
  }
}
