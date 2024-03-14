part of 'active_index_cubit.dart';

class ActiveIndexState extends Equatable {
  final int? index;
  final String? category;
  final String? country;
  const ActiveIndexState(
    this.index,
    this.category,
    this.country,
  );

  @override
  List<Object> get props => [index!, category!, country!];
}

final class ActiveIndexInitial extends ActiveIndexState {
  const ActiveIndexInitial() : super(0, "sports", "us");
}
