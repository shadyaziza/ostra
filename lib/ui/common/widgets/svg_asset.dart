// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:ostra/app/app.locator.dart';
// import 'package:ostra/services/theme_service.dart';

// class SvgAsset extends StatelessWidget {
//   const SvgAsset({
//     super.key,
//     required this.assetName,
//     this.size = const Size(200, 200),
//   });

//   final String assetName;
//   final Size size;
//   @override
//   Widget build(BuildContext context) {
//     ThemeService themeService = locator<ThemeService>();
//     final isDark = themeService.isDark;
//     return SvgPicture.asset(
//       assetName,
//       height: size.height,
//       width: size.width,
//       theme: SvgTheme(
//         currentColor: isDark
//             ? themeService.darkColors.primary
//             : themeService.lightColors.primary,
//       ),
//     );
//   }
// }
