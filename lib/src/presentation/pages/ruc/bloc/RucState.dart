import 'package:corvi_app/src/domain/models/RucData.dart';
import 'package:equatable/equatable.dart';

abstract class RucState extends Equatable {
  @override
  List<Object> get props => [];
}

class RucInitial extends RucState {}

class RucLoading extends RucState {}

class RucSuccess extends RucState {
  final RucData data;

  RucSuccess(this.data);

  @override
  List<Object> get props => [data];
}

class RucError extends RucState {
  final String message;

  RucError(this.message);

  @override
  List<Object> get props => [message];
}