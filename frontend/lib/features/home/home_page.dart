import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  String _result = "";
  bool _isButtonEnabled = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('DeutschAI')),
      body: Center(
        child: SizedBox(
          width: 300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Введите предложение', style: TextStyle(fontSize: 24)),

              SizedBox(height: 20),

              TextField(
                controller: _controller,
                onChanged: onTextChanged,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Введите текст',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: onClearPressed,
                  ),
                ),
                style: TextStyle(fontSize: 18, color: Colors.blue),
              ),

              SizedBox(height: 60),

              ElevatedButton(
                onPressed: _isButtonEnabled ? onButtonPressed : null,
                child: const Text('Отправить'),
              ),

              SizedBox(height: 20),
              _isLoading
                  ? CircularProgressIndicator()
                  : _result.isNotEmpty
                  ? Card(
                      elevation: 4,
                      margin: const EdgeInsets.only(top: 20),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          _result,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onButtonPressed() async {
    final text = _controller.text.trim();
    _controller.clear();

    setState(() {
      _isLoading = true;
      _isButtonEnabled = false;
    });

    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _isLoading = false;
      _result = text;
    });
  }

  void onTextChanged(String text) {
    setState(() {
      _isButtonEnabled = text.trim().isNotEmpty;
    });
  }

  void onClearPressed() {
    _controller.clear();
    setState(() {
      _isButtonEnabled = false;
    });
  }
}
