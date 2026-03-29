import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_cubit.dart';
import 'injection_container.dart' as di;
import 'features/crypto/presentation/bloc/crypto_bloc.dart';
import 'features/crypto/presentation/bloc/crypto_bloc_state.dart';
import 'features/crypto/presentation/bloc/wishlist_bloc.dart';
import 'features/crypto/presentation/bloc/wishlist_bloc_state.dart';
import 'features/crypto/presentation/pages/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.sl<CryptoBloc>()..add(GetTopCoinsEvent()),
        ),
        BlocProvider(
          create: (_) => di.sl<WishlistBloc>()..add(GetWishlistEvent()),
        ),
        BlocProvider(create: (_) => di.sl<ThemeCubit>()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            key: ValueKey(themeMode),
            title: 'CryptoVault',
            debugShowCheckedModeBanner: false,
            themeMode: themeMode,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}
