import 'package:flutter/material.dart';

class FadeListViewWidget extends StatelessWidget {
  final Widget? child;
  final Axis? axis;
  final Color? color;

  const FadeListViewWidget({
    Key? key,
    this.child,
    this.axis = Axis.vertical,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isH = axis == Axis.horizontal;
    double size = 26;
    return Stack(
      children: [
        child!,
        Container(
          height: isH ? double.infinity : size,
          width: isH ? size : double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            gradient: LinearGradient(
              colors: [
                (color ?? Theme.of(context).scaffoldBackgroundColor),
                (color ?? Theme.of(context).scaffoldBackgroundColor).withOpacity(0.5),
                (color ?? Theme.of(context).scaffoldBackgroundColor).withOpacity(0.1),
                (color ?? Theme.of(context).scaffoldBackgroundColor).withOpacity(0.01),
              ],
              begin: isH ? Alignment.centerLeft : Alignment.topCenter,
              end: isH ? Alignment.centerRight : Alignment.bottomCenter,
            ),
          ),
        ),
        Align(
          alignment: isH ? Alignment.centerRight : Alignment.bottomCenter,
          child: Container(
            height: isH ? double.infinity : size,
            width: isH ? size : double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              gradient: LinearGradient(
                colors: [
                  (color ?? Theme.of(context).scaffoldBackgroundColor),
                  (color ?? Theme.of(context).scaffoldBackgroundColor).withOpacity(0.5),
                  (color ?? Theme.of(context).scaffoldBackgroundColor).withOpacity(0.1),
                  (color ?? Theme.of(context).scaffoldBackgroundColor).withOpacity(0.01),
                ],
                end: isH ? Alignment.centerLeft : Alignment.topCenter,
                begin: isH ? Alignment.centerRight : Alignment.bottomCenter,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
