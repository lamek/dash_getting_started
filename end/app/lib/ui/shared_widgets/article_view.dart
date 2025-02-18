import 'package:app/ui/build_context_util.dart';
import 'package:flutter/material.dart';
import 'package:wikipedia_api/wikipedia_api.dart';

import '../../ui/breakpoint.dart';
import '../../ui/shared_widgets/rounded_image.dart';

class ArticleView extends StatelessWidget {
  const ArticleView({required this.summary, super.key});

  final Summary summary;

  ({double height, double width}) _imageSize(BuildContext context) {
    final breakpoint = context.breakpoint;
    final appWidth = MediaQuery.of(context).size.width;
    return switch (breakpoint.width) {
      BreakpointWidth.small => (height: appWidth, width: appWidth),
      BreakpointWidth.medium => (
        height: BreakpointWidth.medium.begin,
        width: BreakpointWidth.medium.begin,
      ),
      BreakpointWidth.large => (
        height: BreakpointWidth.medium.begin,
        width: BreakpointWidth.medium.begin,
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    final imageSize = _imageSize(context);
    final breakpoint = context.breakpoint;

    Widget addMargin(Widget child) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        child: child,
      );
    }

    return ColoredBox(
      color: Colors.white,
      child: ListView(
        children: [
          if (summary.originalImage != null)
            RoundedImage(
              source: summary.originalImage!.source,
              height: imageSize.height,
              width: imageSize.width,
              borderRadius: BorderRadius.zero,
            ),
          addMargin(
            Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(
                summary.titles.normalized,
                overflow: TextOverflow.ellipsis,
                style: context.titleLarge,
              ),
            ),
          ),
          addMargin(
            Padding(
              padding: EdgeInsets.symmetric(vertical: breakpoint.padding),
              child: Text(summary.description ?? '', style: context.labelSmall),
            ),
          ),

          addMargin(Text(summary.extract)),
          const SizedBox(height: 10),
          // Center(
          //   child: SaveForLaterButton(
          //     summary: summary,
          //     label: Text('Save for later'),
          //     viewModel: SavedArticlesViewModel(
          //       repository:
          //           RepositoryProvider.of(context).savedArticlesRepository,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
