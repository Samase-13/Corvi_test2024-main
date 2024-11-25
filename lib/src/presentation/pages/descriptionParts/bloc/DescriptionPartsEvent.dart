import 'package:equatable/equatable.dart';

abstract class DescriptionPartsEvent extends Equatable {
  const DescriptionPartsEvent();

  @override
  List<Object?> get props => [];
}

class FetchPartDescription extends DescriptionPartsEvent {
  final int partId;

  const FetchPartDescription(this.partId);

  @override
  List<Object?> get props => [partId];
}

class IncrementQuantity extends DescriptionPartsEvent {
  const IncrementQuantity();
}

class DecrementQuantity extends DescriptionPartsEvent {
  const DecrementQuantity();
}
