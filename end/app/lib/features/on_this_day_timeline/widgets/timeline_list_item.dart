import 'package:app/ui/build_context_util.dart';
import 'package:flutter/material.dart';
import 'package:wikipedia_api/wikipedia_api.dart';

import '../../../ui/app_theme.dart';
import '../page_view.dart';
import 'timeline_page_link.dart';
import 'timeline_painter.dart';

class TimelineListItem extends StatelessWidget {
  const TimelineListItem({
    required this.event,
    super.key,
    this.contentPadding = EdgeInsets.zero,
    this.maxLines,
  });

  final OnThisDayEvent event;
  final EdgeInsets contentPadding;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          bottom: 0,
          left: sidebarWidth / 2,
          child: CustomPaint(painter: TimelinePainter()),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: sidebarWidth),
                child: Text(
                  event.type != EventType.holiday
                      ? event.year!.absYear
                      : event.type.humanReadable,
                  style: context.titleMedium.copyWith(color: AppColors.primary),
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: context.breakpoint.padding,
                  left: sidebarWidth,
                  right: context.breakpoint.padding,
                ),
                child: Text(
                  event.text,
                  style: context.bodyMedium,
                  maxLines: maxLines,
                  overflow: (maxLines != null) ? TextOverflow.ellipsis : null,
                ),
              ),
            ),
            SizedBox(
              height: 80,
              child: ScrollConfiguration(
                behavior: ScrollConfiguration.of(
                  context,
                ).copyWith(scrollbars: false),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: event.pages.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return Container(width: sidebarWidth);
                    }
                    return TimelinePageLink(event.pages[index - 1]);
                  },
                ),
              ),
            ),
            SizedBox(height: context.breakpoint.spacing),
          ],
        ),
      ],
    );
  }
}
