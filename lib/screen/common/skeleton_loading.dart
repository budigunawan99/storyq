import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SkeletonLoading extends StatefulWidget {
  final int count;

  const SkeletonLoading({super.key, required this.count});

  @override
  State<SkeletonLoading> createState() => _SkeletonLoadingState();
}

class _SkeletonLoadingState extends State<SkeletonLoading> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.count,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[700]!.withValues(alpha: 0.5),
          highlightColor: Colors.grey.withValues(alpha: 0.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxHeight: 25,
                        minHeight: 25,
                        maxWidth: 25,
                        minWidth: 25,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox.square(dimension: 8),
                    Container(
                      width: 100,
                      height: 12,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: 0.65 * MediaQuery.of(context).size.width,
                  minHeight: 0.65 * MediaQuery.of(context).size.width,
                  maxWidth: MediaQuery.of(context).size.width,
                  minWidth: MediaQuery.of(context).size.width,
                ),
                child: Container(
                  decoration: BoxDecoration(color: Colors.white),
                ),
              ),

              Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 12,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox.square(dimension: 8),
                    Container(
                      width: double.infinity,
                      height: 12,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
