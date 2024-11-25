import 'package:equatable/equatable.dart';

abstract class RepuestosEvent extends Equatable {
  const RepuestosEvent();

  @override
  List<Object?> get props => [];
}

class FetchRepuestos extends RepuestosEvent {
  const FetchRepuestos();
}
