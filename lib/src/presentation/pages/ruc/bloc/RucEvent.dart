import 'package:equatable/equatable.dart';

abstract class RucEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchRucEvent extends RucEvent {
  final String ruc;

  FetchRucEvent(this.ruc);

  @override
  List<Object> get props => [ruc];
}