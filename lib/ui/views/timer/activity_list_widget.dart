import 'package:flutter/material.dart';
import 'package:ostra/models/models.dart';
import 'package:ostra/ui/common/common.dart';
import 'package:ostra/ui/views/timer/activity_list_viewmodel.dart';
import 'package:ostra/utils/utils.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:stacked/stacked.dart';

class ActivityListWidget extends StackedView<ActivityListViewModel> {
  const ActivityListWidget({super.key});

  @override
  Widget builder(BuildContext context, viewModel, Widget? child) {
    if (viewModel.list.isEmpty) {
      return const _EmptyPlaceHolder();
    }
    return ListView.builder(
      itemCount: viewModel.list.length,
      itemBuilder: (context, index) {
        final model = viewModel.list[index];
        return ShakingActivityContainer(key: UniqueKey(), activity: model);
      },
    );
  }

  @override
  viewModelBuilder(BuildContext context) => ActivityListViewModel();
}

class _EmptyPlaceHolder extends StatelessWidget {
  const _EmptyPlaceHolder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        PhosphorIcon(
          PhosphorIcons.placeholder(PhosphorIconsStyle.duotone),
          size: 100,
        ),
        gapH16,
        Text(
          'You do not have any activity,\n start recording your first.'
              .localized,
          style: Theme.of(context).textTheme.titleLarge,
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}

class ShakingActivityContainer extends StatelessWidget {
  const ShakingActivityContainer({super.key, required this.activity});
  final ActivityModel activity;

  @override
  Widget build(BuildContext context) {
    final color = getRandomColor();
    return Container(
      key: key,
      decoration: BoxDecoration(
        color: activity.backgroundColor.hexToColor,

        borderRadius: BorderRadius.circular(16), // Rounded corners
      ),
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(16.0),
      child: Text(
        activity.title,
        style: TextStyle(color: getTextColorBasedOnBackground(color)),
      ),
    );
  }
}
