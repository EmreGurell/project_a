import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project_a/l10n/app_localizations.dart';
import 'package:project_a/common/bloc/app_entry/app_entry_state_cubit.dart';
import 'package:project_a/utils/themes/theme.dart';
import 'package:project_a/utils/local_storage/storage_service.dart';
import 'core/di/service_locator.dart';
import 'core/router/app_router.dart';

final ValueNotifier<Locale> appLocaleNotifier = ValueNotifier(
  const Locale('en'),
);

final ValueNotifier<int> nutritionLoggedNotifier = ValueNotifier(0);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory(
      (await getApplicationDocumentsDirectory()).path,
    ),
  );
  await setupServiceLocator();
  final savedLocaleCode = await sl<LocalStorageService>().getLocaleCode();
  if (savedLocaleCode != null && savedLocaleCode.isNotEmpty) {
    appLocaleNotifier.value = Locale(savedLocaleCode);
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppEntryCubit>(
      create: (_) => sl<AppEntryCubit>(),
      child: ValueListenableBuilder<Locale>(
        valueListenable: appLocaleNotifier,
        builder: (context, locale, _) => MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          routerConfig: router,
          locale: locale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('en'), Locale('tr')],
        ),
      ),
    );
  }
}
