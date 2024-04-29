import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ostra/src/component_library/src/theme/theme_controller.dart';

class ThemeAdaptiveSvgAsset extends HookConsumerWidget {
  const ThemeAdaptiveSvgAsset({
    super.key,
    required this.assetName,
    this.size = const Size(200, 200),
  });

  final String assetName;
  final Size size;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeControllerProvider);
    final isDark = theme.isDark;
    return SvgPicture.asset(
      assetName,
      height: size.height,
      width: size.width,
      theme: SvgTheme(
        currentColor:
            isDark ? theme.darkColors.primary : theme.lightColors.primary,
      ),
    );
  }
}
