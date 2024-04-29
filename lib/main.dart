import 'package:ostra/src/core/core.dart';
import 'package:ostra/src/core/router/router.dart';

import 'src/common/common.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    // TODO(shadyaziza): inject this global
    return MaterialApp.router(
      routerConfig: router,
      theme: ref.watch(themeServiceProvider).themeData,
    );
  }
}
