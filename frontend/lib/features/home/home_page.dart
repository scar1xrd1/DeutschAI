import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  String _result = "";

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
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Введите текст',
                  suffixIcon: Icon(Icons.clear),

                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey, width: 1.5),
                  ),
                  // Состояние фокуса (когда пользователь нажал на поле)
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                  // Состояние ошибки (если поле завалило валидацию)
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.red, width: 2.0),
                  ),
                ),
                style: TextStyle(fontSize: 18, color: Colors.blue),
              ),

              SizedBox(height: 60),

              ElevatedButton(
                onPressed: onButtonPressed,
                child: const Text('Отправить'),
              ),

              SizedBox(height: 20),
              Text(_result, style: TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }

  void onButtonPressed() {
    setState(() {
      if (_controller.text.trim().isEmpty) {
        _result = "Введите предложение";
      } else {
        _result = _controller.text;
      }
    });
    _controller.clear();
  }
}
