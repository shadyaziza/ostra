import 'package:ostra/src/component_library/component_library.dart';
import 'package:ostra/src/core/core.dart';
import 'package:ostra/src/core/router/router.dart';

import 'src/common/common.dart';

// TODO(shadyaziza): add app startup widget
void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      routerConfig: router,
      theme: ref.watch(themeControllerProvider).themeData,
      themeAnimationDuration: const Duration(seconds: 2),
      themeAnimationCurve: Curves.fastLinearToSlowEaseIn,
    );
  }
}
