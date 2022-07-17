import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// Measure and call callback after child size changed
class Sizer extends SingleChildRenderObjectWidget {
  const Sizer({
    required this.onSizeChanged,
    required Widget child,
    this.dispatchNotification = false,
    Key? key,
  }) : super(key: key, child: child);

  /// Callback when child size changed and after layout rebuild
  final void Function(Size size) onSizeChanged;

  /// Send [SizeChangedLayoutNotification] notification
  final bool dispatchNotification;

  @override
  RenderObject createRenderObject(BuildContext context) => _SizerRenderObject((Size size) {
        if (dispatchNotification) {
          const SizeChangedLayoutNotification().dispatch(context);
        }
        onSizeChanged(size);
      });
} // Sizer

class _SizerRenderObject extends RenderProxyBox {
  _SizerRenderObject(this.onLayoutChangedCallback);

  final void Function(Size size) onLayoutChangedCallback;

  Size? _oldSize;

  @override
  void performLayout() {
    super.performLayout();
    final content = child;
    assert(content is RenderBox, 'Must contain content');
    assert(content!.hasSize, 'Content must obtain a size');
    final newSize = content!.size;
    if (newSize == _oldSize) return;
    _oldSize = newSize;
    onLayoutChangedCallback(newSize);
  }
}
