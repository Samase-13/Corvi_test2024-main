import 'package:equatable/equatable.dart';

abstract class MachineryEvent extends Equatable {
  const MachineryEvent();

  @override
  List<Object?> get props => [];
}

class FetchMachineryDescription extends MachineryEvent {
  final int idMachinery;

  const FetchMachineryDescription(this.idMachinery);

  @override
  List<Object?> get props => [idMachinery];
}

class TogglePriceSelection extends MachineryEvent {
  final bool isHourlySelected;

  const TogglePriceSelection(this.isHourlySelected);

  @override
  List<Object?> get props => [isHourlySelected];
}
