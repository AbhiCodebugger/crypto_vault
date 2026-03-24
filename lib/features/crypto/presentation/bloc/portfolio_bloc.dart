import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/portfolio_usecases.dart';
import 'portfolio_bloc_state.dart';

class PortfolioBloc extends Bloc<PortfolioEvent, PortfolioState> {
  final GetPortfolio getPortfolio;
  final AddAsset addAsset;
  final RemoveAsset removeAsset;

  PortfolioBloc({
    required this.getPortfolio,
    required this.addAsset,
    required this.removeAsset,
  }) : super(PortfolioInitial()) {
    on<GetPortfolioEvent>((event, emit) async {
      emit(PortfolioLoading());
      final failureOrPortfolio = await getPortfolio(NoParams());
      failureOrPortfolio.fold(
        (failure) => emit(const PortfolioError('Failed to load portfolio')),
        (portfolio) => emit(PortfolioLoaded(portfolio)),
      );
    });

    on<AddAssetEvent>((event, emit) async {
      final failureOrVoid = await addAsset(AddAssetParams(item: event.item));
      failureOrVoid.fold(
        (failure) => emit(const PortfolioError('Failed to add asset')),
        (_) => add(GetPortfolioEvent()), // Reload portfolio after adding
      );
    });

    on<RemoveAssetEvent>((event, emit) async {
      final failureOrVoid = await removeAsset(
        RemoveAssetParams(coinId: event.coinId),
      );
      failureOrVoid.fold(
        (failure) => emit(const PortfolioError('Failed to remove asset')),
        (_) => add(GetPortfolioEvent()), // Reload portfolio after removal
      );
    });
  }
}
