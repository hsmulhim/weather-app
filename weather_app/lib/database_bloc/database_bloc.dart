import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:weather_app/Service/supabseApi.dart';

part 'database_event.dart';
part 'database_state.dart';

class ApiBlocBloc extends Bloc<DatabaseBlocEvent, DatabaseBlocState> {
  ApiBlocBloc() : super(ApiBlocInitial()) {
    on<GetCityEvent>((event, emit) async {
      emit(GetLoadingCityState());
      try {
        final List Citys = await getCity();
        emit(GetSucceedCityState(Citys));
      } catch (e) {
        emit(GetFaildCityState());
      }
    });

    on<AddCityEvent>((event, emit) async {
      emit(GetLoadingCityState());
      try {
        await addCity(event.name);
        emit(AddCityState());
      } catch (e) {
        emit(GetFaildCityState());
      }
    });
  }
}
