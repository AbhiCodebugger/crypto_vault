import 'package:equatable/equatable.dart';
import '../../domain/entities/portfolio_item.dart';

sealed class PortfolioEvent extends Equatable {
  const PortfolioEvent();
  @override
  List<Object?> get props => [];
}

class GetPortfolioEvent extends PortfolioEvent {}

class AddAssetEvent extends PortfolioEvent {
  final PortfolioItem item;
  const AddAssetEvent(this.item);
  @override
  List<Object?> get props => [item];
}

class RemoveAssetEvent extends PortfolioEvent {
  final String coinId;
  const RemoveAssetEvent(this.coinId);
  @override
  List<Object?> get props => [coinId];
}

sealed class PortfolioState extends Equatable {
  const PortfolioState();
  @override
  List<Object?> get props => [];
}

class PortfolioInitial extends PortfolioState {}

class PortfolioLoading extends PortfolioState {}

class PortfolioLoaded extends PortfolioState {
  final List<PortfolioItem> portfolio;
  const PortfolioLoaded(this.portfolio);
  @override
  List<Object?> get props => [portfolio];
}

class PortfolioError extends PortfolioState {
  final String message;
  const PortfolioError(this.message);
  @override
  List<Object?> get props => [message];
}
