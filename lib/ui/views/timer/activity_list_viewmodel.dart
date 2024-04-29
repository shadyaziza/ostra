// import 'package:ostra/app/app.locator.dart';
// import 'package:ostra/models/models.dart';
// import 'package:ostra/services/services.dart';
// import 'package:ostra/utils/utils.dart';
// import 'package:stacked/stacked.dart';

// class ActivityListViewModel extends ReactiveViewModel {
//   final ActivitiesService _activitiesService = locator<ActivitiesService>();

//   @override
//   List<ListenableServiceMixin> get listenableServices => [_activitiesService];

//   List<ActivityModel> get list => _activitiesService.activities;

//   void saveActivity(
//     String name,
//     String description,
//     int timeElapsed,
//   ) {
//     final backgroundColor = getRandomColor();
//     final textColor = getTextColorBasedOnBackground(backgroundColor);
//     // TODO(shadyaziza): fill the remaining
//     final a = ActivityModel(
//       title: name,
//       description: description,
//       backgroundColor: backgroundColor.colorToHex(),
//       textColor: textColor.colorToHex(),
//       tags: [],
//       timeInSeconds: timeElapsed,
//       start: DateTime.now().subtract(Duration(seconds: timeElapsed)),
//       end: DateTime.now(),
//     );
//     _activitiesService.add(a);
//     rebuildUi();
//   }
// }
