import 'package:arenation_app/utils/custom_colors.dart';
import 'package:flutter/material.dart';
import "package:skeletons/skeletons.dart";

Widget skeletonCardArena(BuildContext context) {
  return Expanded(
    child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 2,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(color: CustomColors.secondaryWhite),
            child: SkeletonItem(
              child: Column(
                children: [
                  SkeletonAvatar(
                    style: SkeletonAvatarStyle(
                      borderRadius: BorderRadius.circular(8.0),
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height / 5,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SkeletonParagraph(
                    style: SkeletonParagraphStyle(
                      lines: 4,
                      lineStyle: SkeletonLineStyle(
                        randomLength: true,
                        height: 16,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
          );
        }),
  );
}

Widget arenaImageSkeleton(double height) {
  return SkeletonAvatar(
    style: SkeletonAvatarStyle(
      borderRadius: BorderRadius.circular(8.0),
      width: double.infinity,
      height: height,
    ),
  );
}

Widget selectedArenaSkeleton(BuildContext context) {
  return Expanded(
    child: ListView(
      children: [
        SkeletonItem(
          child: Column(
            children: [
              arenaImageSkeleton(170.0),
              SkeletonParagraph(
                style: SkeletonParagraphStyle(
                  lines: 1,
                  lineStyle: SkeletonLineStyle(
                    randomLength: true,
                    height: 24,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SkeletonParagraph(
                style: SkeletonParagraphStyle(
                  lines: 3,
                  lineStyle: SkeletonLineStyle(
                    randomLength: true,
                    height: 16,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              SkeletonParagraph(
                style: SkeletonParagraphStyle(
                  lines: 1,
                  lineStyle: SkeletonLineStyle(
                    randomLength: true,
                    height: 24,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SkeletonParagraph(
                style: SkeletonParagraphStyle(
                  lines: 5,
                  lineStyle: SkeletonLineStyle(
                    // randomLength: true,
                    height: 16,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              SkeletonParagraph(
                style: SkeletonParagraphStyle(
                  lines: 1,
                  lineStyle: SkeletonLineStyle(
                    randomLength: true,
                    height: 24,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SkeletonParagraph(
                style: SkeletonParagraphStyle(
                  lines: 5,
                  lineStyle: SkeletonLineStyle(
                    randomLength: true,
                    height: 16,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
