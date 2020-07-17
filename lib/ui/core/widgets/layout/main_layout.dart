import 'package:e_coupon/ui/core/widgets/gradient_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

class MainLayout extends StatelessWidget {
  final String title;
  final Widget body;

  MainLayout({this.title, this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TODO waiting for this: https://github.com/joostlek/GradientAppBar/pulls pull request to merge and support shapes
      // until then i just copied the code, fixed it and added it as widget
      appBar: GradientAppBar(
        shape: AppBarShapeBorder(),
        // title: title,
        title: Text(
          title,
          textAlign: TextAlign.end,
          style: TextStyle(color: Colors.white),
        ),
        // gradient: ThemeGradients.defaultGradient,
        gradient: Gradients.cosmicFusion,
        elevation: 0,
      ),
      body: Container(
          margin: const EdgeInsets.only(left: 24, right: 24, top: 36),
          child: body),
    );
  }
}

class AppBarShapeBorder extends ContinuousRectangleBorder {
  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    final double extraHeight = 15.0;
    final double stepWidth = 20.0;

    Path path = Path();
    path.lineTo(0, rect.height + extraHeight);
    path.lineTo(50.0, rect.height + extraHeight);
    path.lineTo(50.0 + stepWidth, rect.height);
    path.lineTo(rect.width, rect.height);
    path.lineTo(rect.width, 0.0);
    path.close();

    return path;
  }
}
