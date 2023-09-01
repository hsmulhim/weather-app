import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/Service/weather_service.dart';
import 'package:weather_app/model/weather_model.dart';

part 'api_event.dart';
part 'api_state.dart';

class ApiBloc extends Bloc<ApiEvent, ApiState> {
  ApiBloc() : super(ApiInitial()) {
    on<SearchCityEvent>((event, emit) async {
      emit(GetCityLoadingState());

      try {
        final Weather weather = await getWeatherData(event.citysApi);

        emit(SearchApiCityState(weather));
      } catch (e) {
        emit(GetCityFaildState());
      }
    });
  }
}
