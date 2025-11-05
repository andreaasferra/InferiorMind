import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App!!',
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      home: const MyHomePage(title: 'MasterMind'),
      debugShowCheckedModeBanner: false,
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
  Color buttonColor1 = Colors.grey;
  Color buttonColor2 = Colors.grey;
  Color buttonColor3 = Colors.grey;
  Color buttonColor4 = Colors.grey;
  final random = Random();
  
  // Colori disponibili in Mastermind
  final List<Color> mastermindColors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
  ];
  
  // Sequenza vincente
  final Color sequenzaVincente = Colors.blue;

  void _buttonNeutral(int buttonNumber) {
    setState(() {
      Color newColor = mastermindColors[random.nextInt(mastermindColors.length)];
      
      switch (buttonNumber) {
        case 1:
          buttonColor1 = newColor;
          break;
        case 2:
          buttonColor2 = newColor;
          break;
        case 3:
          buttonColor3 = newColor;
          break;
        case 4:
          buttonColor4 = newColor;
          break;
      }
    });
  }
  
  void _verifica() {
    if (buttonColor1 == sequenzaVincente &&
        buttonColor2 == sequenzaVincente &&
        buttonColor3 == sequenzaVincente &&
        buttonColor4 == sequenzaVincente) {
      // Hai vinto!
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Congratulazioni!'),
            content: const Text('Hai vinto! Sequenza corretta!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    // Resetta i colori
                    buttonColor1 = Colors.grey;
                    buttonColor2 = Colors.grey;
                    buttonColor3 = Colors.grey;
                    buttonColor4 = Colors.grey;
                  });
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      // Non hai vinto
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Riprova!'),
            content: const Text('Sequenza non corretta.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(width: 12),
                FloatingActionButton(
                  heroTag: 'button1',
                  onPressed: () => _buttonNeutral(1),
                  backgroundColor: buttonColor1,
                  shape: const CircleBorder(),
                ),
                const SizedBox(width: 12),
                FloatingActionButton(
                  heroTag: 'button2',
                  onPressed: () => _buttonNeutral(2),
                  backgroundColor: buttonColor2,
                  shape: const CircleBorder(),
                ),
                const SizedBox(width: 12),
                FloatingActionButton(
                  heroTag: 'button3',
                  onPressed: () => _buttonNeutral(3),
                  backgroundColor: buttonColor3,
                  shape: const CircleBorder(),
                ),
                const SizedBox(width: 12),
                FloatingActionButton(
                  heroTag: 'button4',
                  onPressed: () => _buttonNeutral(4),
                  backgroundColor: buttonColor4,
                  shape: const CircleBorder(),
                ),
              ],
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _verifica,
              child: const Text('Verifica'),
            ),
          ],
        ),
      ),
    );
  }
}