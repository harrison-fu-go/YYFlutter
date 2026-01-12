import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ITxtSpan {
  String? text;
  TextStyle? sty;
  String? tapLink;
  //for icon.
  String? icon;
  String? iconSel;
  bool selected;
  double? iconSize;
  double iconWidth;
  double iconHeight;
  //for on tap callback
  ValueChanged<String>? onTap;
  ITxtSpan({
    this.text,
    this.sty,
    this.tapLink,
    this.icon,
    this.iconSel,
    this.selected = false,
    this.iconSize,
    this.iconWidth = 10,
    this.iconHeight = 10,
    this.onTap,
  });
  bool isIcon() {
    return icon != null;
  }

  bool isNeedTap() {
    return onTap != null;
  }
}

class XsCusTextSpan extends StatefulWidget {
  final List<ITxtSpan> textSpans;
  final TextAlign? txtAlign;
  final TextStyle? defHsty; // default highlight style
  final TextStyle? defNSty; // default normal style
  const XsCusTextSpan({
    super.key,
    required this.textSpans,
    this.txtAlign,
    this.defHsty,
    this.defNSty,
  });

  @override
  State<StatefulWidget> createState() => _XsCusTextSpanState();
}

class _XsCusTextSpanState extends State<XsCusTextSpan> {
  List<InlineSpan> _spans(BuildContext context) {
    List<InlineSpan> spans = [];
    for (ITxtSpan info in widget.textSpans) {
      if (info.isIcon()) {
        spans.add(_getIconSpan(info));
      } else {
        spans.add(_getTextSpan(info));
      }
    }
    return spans;
  }

  TextSpan _getTextSpan(ITxtSpan info) {
    bool isNeedTap = info.isNeedTap();
    TextStyle? sty = info.sty;
    if (isNeedTap && sty == null) {
      sty = widget.defHsty;
    }
    sty ??= widget.defNSty;
    return TextSpan(
        text: info.text,
        style: sty,
        recognizer: isNeedTap
            ? (TapGestureRecognizer()
              ..onTap = () {
                info.onTap?.call(info.tapLink ?? "");
              })
            : null);
  }

  InlineSpan _getIconSpan(ITxtSpan info) {
    bool isSelected = info.selected;
    String? icon = isSelected ? info.iconSel : info.icon;
    icon ??= info.icon; //default icon.
    if (icon == null) {
      throw Exception('icon is null');
    }
    double width = info.iconSize ?? info.iconWidth;
    double height = info.iconSize ?? info.iconHeight;
    return WidgetSpan(
        alignment: PlaceholderAlignment.middle,
        child: GestureDetector(
          onTap: () {
            info.selected = !info.selected;
            info.onTap?.call(info.selected ? '1' : '0');
            setState(() {});
          },
          child: Image.asset(
            icon,
            width: width,
            height: height,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: _spans(context),
        style: widget.defNSty,
      ),
      textAlign: widget.txtAlign ?? TextAlign.left,
    );
  }
}
