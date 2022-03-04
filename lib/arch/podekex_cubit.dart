import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class PokedexCubit<T> extends Cubit<PokedexState> {

  PokedexCubit(): super(EmptyState());

  void manageStatesDuring(Future Function() code) async {
    try {
      emit(LoadingState());
      final result = await code.call();
      emit(SuccessState<T>(result));
    } on Exception catch(exception) {
      emit(ErrorState(exception));
    }
  }
}

abstract class PokedexState with EquatableMixin { }

class EmptyState extends PokedexState {
  @override
  List<Object?> get props => [];
 }
class LoadingState extends PokedexState {
  @override
  List<Object?> get props => [];
 }
class ErrorState extends PokedexState {
  ErrorState(this.exception);

  Exception exception;

  @override
  List<Object?> get props => [];
}
class SuccessState<T> extends PokedexState {
  SuccessState(this.result);

  final T result;

  @override
  List<Object?> get props => [result];
}