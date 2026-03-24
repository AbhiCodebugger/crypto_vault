import 'package:equatable/equatable.dart';
import '../../domain/entities/historical_data.dart';

sealed class ChartEvent extends Equatable {
  const ChartEvent();
  @override
  List<Object?> get props => [];
}

class GetChartDataEvent extends ChartEvent {
  final String id;
  final int days;
  const GetChartDataEvent(this.id, this.days);
  @override
  List<Object?> get props => [id, days];
}

sealed class ChartState extends Equatable {
  const ChartState();
  @override
  List<Object?> get props => [];
}

class ChartInitial extends ChartState {}

class ChartLoading extends ChartState {}

class ChartLoaded extends ChartState {
  final List<HistoricalData> data;
  const ChartLoaded(this.data);
  @override
  List<Object?> get props => [data];
}

class ChartError extends ChartState {
  final String message;
  const ChartError(this.message);
  @override
  List<Object?> get props => [message];
}
