import 'package:equatable/equatable.dart';

class HistoricalData extends Equatable {
  final DateTime timestamp;
  final double price;

  const HistoricalData({required this.timestamp, required this.price});

  @override
  List<Object?> get props => [timestamp, price];
}
