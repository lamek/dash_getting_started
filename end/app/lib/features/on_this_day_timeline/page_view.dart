/*
 * // Copyright 2025 The Dart and Flutter teams. All rights reserved.
 * // Use of this source code is governed by a BSD-style license that can be
 * // found in the LICENSE file.
 */

import 'package:flutter/material.dart';
import 'package:wikipedia_api/wikipedia_api.dart';

import '../../ui/app_theme.dart';
import '../../ui/build_context_util.dart';
import 'view_model.dart';
import 'widgets/timeline_list_item.dart';

const double sidebarWidth = 60;
const double mainColumnWidthPercentage = .85;

class TimelinePageView extends StatelessWidget {
  const TimelinePageView({required this.viewModel, super.key});

  final TimelineViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (BuildContext context, _) {
        if (viewModel.hasError) {
          return Center(child: Text(viewModel.error!));
        }
        if (!viewModel.hasData && !viewModel.hasError) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }

        return ColoredBox(
          color: Colors.white,
          child: ListView.builder(
            itemCount: viewModel.filteredEvents.length + 1,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return Padding(
                  padding: EdgeInsets.all(context.breakpoint.margin),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        viewModel.readableDate,
                        style: context.titleMedium.copyWith(fontSize: 24),
                      ),
                      SizedBox(height: context.breakpoint.spacing),
                      Text(
                        'TODO : historic events',
                        // AppStrings.historicEvents(
                        //   viewModel.filteredEvents.length.toString(),
                        // ).toUpperCase(),
                        // style: context.titleMedium.copyWith(
                        //   color: AppColors.labelOnLight,
                        // ),
                      ),
                      if (viewModel.readableYearRange != '')
                        Text(
                          'TODO: year range',
                          // AppStrings.yearRange(viewModel.readableYearRange),
                          style: context.titleMedium.copyWith(
                            color: AppColors.labelOnLight,
                          ),
                        ),
                      SizedBox(height: context.breakpoint.spacing),
                    ],
                  ),
                );
              }

              final OnThisDayEvent event = viewModel.filteredEvents[index - 1];
              return TimelineListItem(event: event);
            },
          ),
        );
      },
    );
  }
}
