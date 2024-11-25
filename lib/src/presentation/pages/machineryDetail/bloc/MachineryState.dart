import 'package:corvi_app/src/domain/models/Maquinarias.dart';
import 'package:equatable/equatable.dart';

abstract class MachineryState extends Equatable {
  const MachineryState();

  @override
  List<Object?> get props => [];
}

class MachineryInitial extends MachineryState {}

class MachineryLoading extends MachineryState {}

class MachineryLoaded extends MachineryState {
  final Maquinaria maquinaria;
  final bool isHourlySelected;
  final String estado; // Nueva propiedad para el estado de la maquinaria

  const MachineryLoaded(this.maquinaria, {this.isHourlySelected = true, required this.estado});

  MachineryLoaded copyWith({bool? isHourlySelected, String? estado}) {
    return MachineryLoaded(
      maquinaria,
      isHourlySelected: isHourlySelected ?? this.isHourlySelected,
      estado: estado ?? this.estado,
    );
  }

  @override
  List<Object?> get props => [maquinaria, isHourlySelected, estado];
}


class MachineryError extends MachineryState {
  final String error;

  const MachineryError(this.error);

  @override
  List<Object?> get props => [error];
}
