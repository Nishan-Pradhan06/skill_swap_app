import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../home/widgets/custom_cateogry_chip.dart';

class SwapCardWidget extends StatelessWidget {
  const SwapCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: false,
      child: Material(
        borderRadius: BorderRadius.circular(20),
        child: GestureDetector(
          // borderRadius: BorderRadius.circular(20),
          onTap: () {},
          onLongPressStart: (details) {
            final position = RelativeRect.fromLTRB(
              details.globalPosition.dx,
              details.globalPosition.dy,
              MediaQuery.of(context).size.width - details.globalPosition.dx,
              MediaQuery.of(context).size.height - details.globalPosition.dy,
            );

            showMenu(
              context: context,
              position: position,
              items: [
                PopupMenuItem(value: 'accept', child: Text('Accept')),
                PopupMenuItem(value: 'reject', child: Text('Reject')),
              ],
            ).then((value) {
              if (value == 'accept') {
                // accept logic
              } else if (value == 'reject') {
                // reject logic
              }
            });
          },

          child: Ink(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                spacing: 20,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "You offered:",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      CustomCategoryChip(chipText: 'Pending'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Mobile App Dev",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: Theme.of(context).textTheme.bodyMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "By Nishan Pradhan",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                      Icon(Icons.swap_horiz_rounded),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Mobile App Dev",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: Theme.of(context).textTheme.bodyMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "By Nishan Pradhan",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    'Created on: 12 Jan, 2024',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
