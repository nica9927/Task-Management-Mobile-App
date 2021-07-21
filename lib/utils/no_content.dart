import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoContent extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final List<Widget>? actions;
  final String? svgImage;
  final bool? isDefault;

  const NoContent({
    Key? key,
    this.title = "Oops, No Content Sorry about that",
    this.actions = const [],
    this.subtitle,
    this.svgImage,
    this.isDefault = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.all(32),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            if (svgImage == null)
              Container(
                padding: EdgeInsets.all(16),
                margin: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  CupertinoIcons.bell,
                  color: Colors.red,
                  size: 50,
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SvgPicture.asset(
                  svgImage!,
                  width: 100,
                  height: 100,
                ),
              ),
            Text(
              title!,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline6!.copyWith(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.normal),
            ),
            if (isDefault! || subtitle != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  subtitle ?? "Keep calm, light a fire and pull to refresh\nto try again",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: 12, color: Colors.grey[300]),
                ),
              ),
            if (actions!.isNotEmpty) SizedBox(height: 16),
            ...actions!,
          ],
        ),
      ),
    );
  }
}
