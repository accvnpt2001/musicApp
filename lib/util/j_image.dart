import 'package:flutter/cupertino.dart';

class JImage extends StatefulWidget {
  final String? assetPath;
  final String? networkUrl;
  final double? radius;
  final double? width;
  final double? height;
  final BoxFit? boxFit;
  final Color? color;

  const JImage({
    Key? key,
    this.assetPath,
    this.networkUrl,
    this.width,
    this.height,
    this.radius,
    this.boxFit,
    this.color,
  }) : super(key: key);
  @override
  _JImageState createState() => _JImageState();
}

class _JImageState extends State<JImage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: (() {
        return ClipRRect(
          borderRadius: BorderRadius.circular(widget.radius ?? 0),
          child: (() {
            if (widget.assetPath != null) {
              return Image.asset(
                '${widget.assetPath ?? ''}',
                width: widget.width,
                height: widget.height,
                fit: widget.boxFit ?? BoxFit.fill,
                color: widget.color,
              );
            } else if (widget.networkUrl != null) {
              return Image.network(
                widget.networkUrl ?? '',
                height: widget.height,
                width: widget.width,
                fit: widget.boxFit ?? BoxFit.fill,
              );
            } else {
              return Container();
            }
          }()),
        );
      }()),
    );
  }
}
