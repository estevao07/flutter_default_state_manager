import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_default_state_manager/bloc_pattern/imc_state.dart';

class ImcBlocPatternController {
  final _imcStreamController = StreamController<ImcState>.broadcast()
    ..add(ImcState(imc: 0));

  Stream<ImcState> get imcOut => _imcStreamController.stream;

  Future<void> calcularIMC(
      {required double peso, required double altura}) async {
    try {
      _imcStreamController.add(ImcStateLoading());

      await Future.delayed(const Duration(seconds: 1));

      final imc = peso / pow(altura, 2);

      // throw Exception();
      _imcStreamController.add(ImcState(imc: imc));
    } on Exception catch (e) {
      debugPrint(e.toString());
      _imcStreamController.add(ImcStateError(message: 'Erro ao calcular IMC'));
    }
  }

  void dispose() {
    _imcStreamController.close();
  }
}
