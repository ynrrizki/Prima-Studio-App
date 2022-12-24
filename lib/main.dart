// util
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// state management
import 'package:prima_studio/app/blocs/blocs.dart';
import 'package:prima_studio/app/cubits/cubits.dart';
import 'package:prima_studio/app/repositories/apperance/theme_repo.dart';

// database
import 'package:prima_studio/app/repositories/repositories.dart';
import 'package:prima_studio/config/theme.dart';

// settings
import 'config/routing/routes.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await ThemeRepository.checkDatabaseExists();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = AppRouter();
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => UserRepository(),
        ),
        RepositoryProvider(
          create: (context) => AuthRepository(
            userRepository: context.read<UserRepository>(),
          ),
        ),
        RepositoryProvider(
          create: (context) => FilmRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthCubit(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => FilmBloc(
              filmRepository: context.read<FilmRepository>(),
            )..add(const LoadFilm()),
          ),
          BlocProvider(
            create: (context) => SearchBloc(
              filmBloc: context.read<FilmBloc>(),
            )..add(LoadSearch()),
          ),
          BlocProvider(
            create: (context) => ProfileBloc(
              userRepository: context.read<UserRepository>(),
            )..add(LoadProfile()),
          ),
          BlocProvider(
            create: (context) => UserCubit(),
          ),
          BlocProvider(
            create: (context) => ThemeCubit(),
          ),
        ],
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            return MaterialApp(
              theme: ThemeRepository.getThemeSettings()
                  ? PrimaStudioThemes.darkTheme
                  : PrimaStudioThemes.lightTheme,
              debugShowCheckedModeBanner: false,
              onGenerateRoute: router.onRoute,
            );
          },
        ),
      ),
    );
  }
}
