import 'package:corvi_app/src/presentation/pages/firma/bloc/FirmaService.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'FirmaEvent.dart';
import 'FirmaState.dart';

class FirmaBloc extends Bloc<FirmaEvent, FirmaState> {
  final FirmaService firmaService;
  final int usuarioId;

  FirmaBloc(this.firmaService, this.usuarioId) : super(FirmaInitial()) {
    on<EnviarCodigo>(_onEnviarCodigo);
    on<ValidarCodigo>(_onValidarCodigo);
  }

  Future<void> _onEnviarCodigo(EnviarCodigo event, Emitter<FirmaState> emit) async {
    emit(FirmaLoading());
    try {
      final enviado = await firmaService.enviarCodigo(usuarioId);
      if (enviado) {
        emit(FirmaCodigoEnviado());
        emit(FirmaEsperandoCodigo()); // Espera el ingreso del código
      }
    } catch (e) {
      emit(FirmaError(e.toString()));
    }
  }

  Future<void> _onValidarCodigo(ValidarCodigo event, Emitter<FirmaState> emit) async {
    emit(FirmaLoading());
    try {
      final validado = await firmaService.validarCodigo(usuarioId, event.codigo);
      if (validado) {
        emit(FirmaCodigoValidado());
      }
    } catch (e) {
      emit(FirmaError(e.toString()));
    }
  }
}
