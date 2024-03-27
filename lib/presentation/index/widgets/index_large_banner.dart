import 'package:flutter/material.dart';

import '../../../api/api_path.dart';
import '../../../theme/app_color.dart';

class LargeBanner extends StatefulWidget {
  const LargeBanner({
    super.key,
    required this.banners,
  });

  final List<String> banners;

  @override
  State<LargeBanner> createState() => _LargeBannerState();
}

class _LargeBannerState extends State<LargeBanner> {
  final TransformationController _controller = TransformationController();

  void onInteractionUpdate() {
    Matrix4 matrix = _controller.value;
    double currentScale = matrix.getMaxScaleOnAxis();

    if (currentScale == 1.0) {
      _controller.value = Matrix4.identity();
    }
  }

  void onTransformationChanged(Offset offset) {
    Matrix4 matrix = _controller.value;
    double currentScale = matrix.getMaxScaleOnAxis();
    double newScale;

    if (currentScale <= 1.0) {
      newScale = 2.0;
    } else {
      newScale = currentScale * 2.0;
    }
    newScale = newScale.clamp(1.0, 5.0);
    if (newScale != 5) {
      _controller.value = Matrix4.identity()
        ..translate(offset.dx, offset.dy)
        ..scale(newScale)
        ..translate(-offset.dx, -offset.dy);
    } else {
      _controller.value = Matrix4.identity();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      backgroundColor: AppColor.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const CloseButton(color: AppColor.white),
          Expanded(
            child: InteractiveViewer(
              transformationController: _controller,
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
                child: PageView(
                  children: widget.banners.map((banner) {
                    return Image.network(APIPath.publicAsset(banner), fit: BoxFit.contain);
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
