import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/coin.dart';
import '../bloc/chart_bloc.dart';
import '../bloc/chart_bloc_state.dart';
import '../../../../injection_container.dart' as di;

class DetailsScreen extends StatefulWidget {
  final Coin coin;

  const DetailsScreen({super.key, required this.coin});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  int _selectedDays = 1;

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(symbol: '\$');

    return BlocProvider(
      create:
          (_) =>
              di.sl<ChartBloc>()
                ..add(GetChartDataEvent(widget.coin.id, _selectedDays)),
      child: Scaffold(
        appBar: AppBar(title: Text(widget.coin.name)),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Hero(
                  tag: widget.coin.id,
                  child: Image.network(widget.coin.imageUrl, height: 80),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  currencyFormat.format(widget.coin.currentPrice),
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              _buildTimeframeSelector(),
              const SizedBox(height: 16),
              SizedBox(
                height: 300,
                child: BlocBuilder<ChartBloc, ChartState>(
                  builder: (context, state) {
                    return switch (state) {
                      ChartInitial() || ChartLoading() => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      ChartLoaded(data: var data) => _buildChart(data),
                      ChartError(message: var message) => Center(
                        child: Text(message),
                      ),
                    };
                  },
                ),
              ),
              const SizedBox(height: 32),
              _buildInfoRow(
                'Market Cap',
                currencyFormat.format(widget.coin.marketCap),
              ),
              _buildInfoRow('Symbol', widget.coin.symbol.toUpperCase()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeframeSelector() {
    final timeframes = {1: '24h', 7: '7d', 30: '30d', 365: '1y'};
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children:
          timeframes.entries.map((entry) {
            final isSelected = _selectedDays == entry.key;
            return ChoiceChip(
              label: Text(entry.value),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) {
                  setState(() => _selectedDays = entry.key);
                  context.read<ChartBloc>().add(
                    GetChartDataEvent(widget.coin.id, entry.key),
                  );
                }
              },
            );
          }).toList(),
    );
  }

  Widget _buildChart(List data) {
    if (data.isEmpty) return const Center(child: Text('No data available'));

    final spots =
        data
            .asMap()
            .entries
            .map((e) => FlSpot(e.key.toDouble(), e.value.price))
            .toList();

    return LineChart(
      LineChartData(
        gridData: const FlGridData(show: false),
        titlesData: const FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: Theme.of(context).colorScheme.primary,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              color: Theme.of(
                context,
              ).colorScheme.primary.withValues(alpha: 0.1),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 16)),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
