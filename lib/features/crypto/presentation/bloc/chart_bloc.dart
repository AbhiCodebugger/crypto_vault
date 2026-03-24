import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_historical_data.dart';
import 'chart_bloc_state.dart';

class ChartBloc extends Bloc<ChartEvent, ChartState> {
  final GetHistoricalData getHistoricalData;

  ChartBloc({required this.getHistoricalData}) : super(ChartInitial()) {
    on<GetChartDataEvent>((event, emit) async {
      emit(ChartLoading());
      final failureOrData = await getHistoricalData(
        GetHistoricalDataParams(id: event.id, days: event.days),
      );
      failureOrData.fold(
        (failure) => emit(const ChartError('Failed to fetch chart data')),
        (data) => emit(ChartLoaded(data)),
      );
    });
  }
}
