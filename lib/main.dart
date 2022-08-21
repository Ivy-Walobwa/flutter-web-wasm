import 'package:flutter/material.dart';
import './wasm/wasm_loader.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Wasm demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late WasmLoader loader;
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    loader = WasmLoader(path: 'assets/wasm/release.wasm');
    final isLoaded = await loader.initialized();
    if (isLoaded) {
      setState(() {});
    }
  }

  void _incrementCounter() {
    _counter = loader.callfunc('plusOne', _counter) as int;
    setState(() {});
  }

  void _decrementCounter() {
    _counter = loader.callfunc('minusOne', _counter) as int;
    setState(() {});
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
          children: <Widget>[
            const Text(
              'You current count is:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(
              height: 100,
            ),
            Wrap(
              spacing: 100,
              children: [
                ElevatedButton(
                    onPressed: _incrementCounter,
                    child: const Text('Increment')),
                ElevatedButton(
                    onPressed: _decrementCounter,
                    child: const Text('Decrement'))
              ],
            )
          ],
        ),
      ),
    );
  }
}
