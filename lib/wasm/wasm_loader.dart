import 'package:flutter/services.dart' show rootBundle;

import 'package:wasm_interop/wasm_interop.dart';

class WasmLoader {
  WasmLoader({required this.path});

  late Instance? _wasmInstance;
  final String path;

  Future<bool> initialized() async {
    try {
      final bytes = await rootBundle.load(path);
      _wasmInstance = await Instance.fromBufferAsync(bytes.buffer);

      return isLoaded;
    } catch (exc) {
      // ignore: avoid_print
      print('Error on wasm init ${exc.toString()}');
    }

    return false;
  }

  bool get isLoaded => _wasmInstance != null;

  Object callfunc(String name, int input) {
    final func = _wasmInstance?.functions[name];
    return func?.call(input);
  }
}
