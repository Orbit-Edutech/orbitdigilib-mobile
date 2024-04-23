import 'package:flutter/material.dart';

import '../../../api/api_path.dart';
import '../../../theme/app_color.dart';

class LargeBanner extends StatefulWidget {
  const LargeBanner({
    super.key,
    required this.banners,
    required this.index,
  });

  final List<String> banners;
  final int index;

  @override
  State<LargeBanner> createState() => _LargeBannerState();
}

class _LargeBannerState extends State<LargeBanner> {
  late PageController _pageController;
  final TransformationController _transformationController = TransformationController();

  @override
  void initState() {
    _pageController = PageController(initialPage: widget.index);
    super.initState();
  }

  void onInteractionUpdate() {
    Matrix4 matrix = _transformationController.value;
    double currentScale = matrix.getMaxScaleOnAxis();

    if (currentScale == 1.0) {
      _transformationController.value = Matrix4.identity();
    }
  }

  void onTransformationChanged(Offset offset) {
    Matrix4 matrix = _transformationController.value;
    double currentScale = matrix.getMaxScaleOnAxis();
    double newScale;

    if (currentScale <= 1.0) {
      newScale = 2.0;
    } else {
      newScale = currentScale * 2.0;
    }
    newScale = newScale.clamp(1.0, 5.0);
    if (newScale != 5) {
      _transformationController.value = Matrix4.identity()
        ..translate(offset.dx, offset.dy)
        ..scale(newScale)
        ..translate(-offset.dx, -offset.dy);
    } else {
      _transformationController.value = Matrix4.identity();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      backgroundColor: AppColor.black.withOpacity(.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const CloseButton(color: AppColor.white),
          Expanded(
            child: InteractiveViewer(
              transformationController: _transformationController,
              boundaryMargin: const EdgeInsets.all(80),
              minScale: 1,
              maxScale: 5,
              onInteractionUpdate: (details) {
                onInteractionUpdate();
              },
              child: GestureDetector(
                onDoubleTapDown: (details) {
                  onTransformationChanged(details.globalPosition);
                },
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    PageView(
                      controller: _pageController,
                      children: widget.banners.map((banner) {
                        return Image.network(APIPath.publicAsset(banner), fit: BoxFit.contain);
                      }).toList(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: const BoxDecoration(),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
