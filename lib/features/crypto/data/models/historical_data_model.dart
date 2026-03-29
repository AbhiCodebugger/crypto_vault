import '../../domain/entities/historical_data.dart';

class HistoricalDataModel extends HistoricalData {
  const HistoricalDataModel({required super.timestamp, required super.price});

  factory HistoricalDataModel.fromList(List<dynamic> list) {
    return HistoricalDataModel(
      timestamp: DateTime.fromMillisecondsSinceEpoch(list[0] as int),
      price: (list[1] as num).toDouble(),
    );
  }
}
