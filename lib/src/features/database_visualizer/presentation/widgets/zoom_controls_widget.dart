import 'package:flutter/material.dart';
import 'package:sql_studio/src/core/app_radii.dart';
import 'package:sql_studio/src/core/app_shadows.dart';
import 'package:sql_studio/src/core/extensions/build_context_extension.dart';

/// Floating zoom in/out/reset controls for the database visualizer canvas.
class ZoomControlsWidget extends StatelessWidget {
  /// Creates zoom controls driving [transformationController].
  const ZoomControlsWidget({required this.transformationController, super.key});

  /// The controller shared with the canvas' [InteractiveViewer].
  final TransformationController transformationController;

  static const double _minScale = 0.2;
  static const double _maxScale = 2;
  static const double _step = 1.2;

  void _zoom(double factor) {
    final currentScale = transformationController.value.getMaxScaleOnAxis();
    final targetScale = (currentScale * factor).clamp(_minScale, _maxScale);
    final appliedFactor = targetScale / currentScale;

    transformationController.value = transformationController.value.clone()
      ..scaleByDouble(appliedFactor, appliedFactor, appliedFactor, 1);
  }

  void _reset() {
    transformationController.value = Matrix4.identity();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(AppRadii.full),
        border: Border.all(color: context.colors.border),
        boxShadow: AppShadows.elevated,
      ),
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _ZoomButton(
            icon: Icons.add_rounded,
            onTap: () => _zoom(_step),
          ),
          SizedBox(
            width: 28,
            child: Divider(height: 1, color: context.colors.border),
          ),
          _ZoomButton(
            icon: Icons.remove_rounded,
            onTap: () => _zoom(1 / _step),
          ),
          SizedBox(
            width: 28,
            child: Divider(height: 1, color: context.colors.border),
          ),
          _ZoomButton(
            icon: Icons.center_focus_strong_rounded,
            onTap: _reset,
          ),
        ],
      ),
    );
  }
}

class _ZoomButton extends StatelessWidget {
  const _ZoomButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.colors.transparent,
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Icon(icon, size: 20),
        ),
      ),
    );
  }
}
