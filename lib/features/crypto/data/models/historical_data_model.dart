import '../../domain/entities/historical_data.dart';

class HistoricalDataModel extends HistoricalData {
  const HistoricalDataModel({required super.timestamp, required super.price});

  factory HistoricalDataModel.fromJson(Map<String, dynamic> json) {
    return HistoricalDataModel(
      timestamp: DateTime.parse(json['date']),
      price: (json['price'] as num).toDouble(),
    );
  }
}
