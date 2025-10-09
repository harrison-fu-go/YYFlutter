import 'dart:ui';

extension AlphaColor on Color {
  Color xsAlpha(double alpha) {
    return withValues(alpha: alpha);
  }
}
