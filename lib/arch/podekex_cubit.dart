import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class PokedexCubit extends Cubit<PokedexViewState> {
  PokedexCubit() : super(EmptyState());

  void manageStatesDuring<T>(Future Function() code) async {
    try {
      emit(LoadingState());
      final result = await code.call();
      emit(SuccessState<T>(result));
    } on Exception catch (exception) {
      emit(ErrorState(exception));
    }
  }
}

abstract class PokedexViewState with EquatableMixin {}

class EmptyState extends PokedexViewState {
  @override
  List<Object?> get props => [];
}

class LoadingState extends PokedexViewState {
  @override
  List<Object?> get props => [];
}

class ErrorState extends PokedexViewState {
  ErrorState(this.exception);

  Exception exception;

  @override
  List<Object?> get props => [];
}

class SuccessState<T> extends PokedexViewState {
  SuccessState(this.result);

  final T result;

  @override
  List<Object?> get props => [result];
}
