import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'active_index_state.dart';

class ActiveIndexCubit extends Cubit<ActiveIndexState> {
  ActiveIndexCubit() : super(const ActiveIndexInitial());

  void changeIndex(int index, String category, String country) {
    emit(ActiveIndexState(index, category, country));
  }
}
