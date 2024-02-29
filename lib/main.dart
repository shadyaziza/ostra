import 'package:flutter/material.dart';
import 'package:ostra/app/app.bottomsheets.dart';
import 'package:ostra/app/app.dialogs.dart';
import 'package:ostra/app/app.locator.dart';
import 'package:ostra/app/app.router.dart';
import 'package:ostra/services/theme_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  setupDialogUi();
  setupBottomSheetUi();
  runApp(const MainApp());
}

class MainApp extends StackedView<MainAppViewModel> {
  const MainApp({super.key});

  @override
  Widget builder(
      BuildContext context, MainAppViewModel viewModel, Widget? child) {
    // TODO(shadyaziza): inject this global
    return MaterialApp(
      theme: viewModel.themeData,
      initialRoute: Routes.startupView,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      navigatorKey: StackedService.navigatorKey,
      navigatorObservers: [
        StackedService.routeObserver,
      ],
    );
  }

  @override
  MainAppViewModel viewModelBuilder(BuildContext context) => MainAppViewModel();
}

class MainAppViewModel extends ReactiveViewModel {
  final ThemeService _themeService = locator<ThemeService>();

  ThemeData get themeData => _themeService.themeData;

  @override
  List<ListenableServiceMixin> get listenableServices => [_themeService];
}
