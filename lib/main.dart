import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:newsapp/config/theme/app_theme.dart';
import 'package:newsapp/features/daily_news/presentation/widgets/custom_body.dart';
import 'package:newsapp/features/daily_news/presentation/widgets/custom_drawer.dart';
import 'package:newsapp/features/daily_news/presentation/widgets/custom_navbar.dart';
import 'package:newsapp/injection_controller.dart';

Future<void> main() async {
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
  }

  void toggle() => _animationController!.isDismissed
      ? _animationController!.forward()
      : _animationController!.reverse();

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  bool _canBeDragged = false;

  void _onDragStart(DragStartDetails details) {
    bool isDraggingFromLeft =
        _animationController!.isDismissed && details.globalPosition.dx < 20;
    bool isDraggingFromRight = _animationController!.isCompleted &&
        details.globalPosition.dx > MediaQuery.of(context).size.width - 20;
    _canBeDragged = isDraggingFromLeft || isDraggingFromRight;
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (_canBeDragged) {
      double delta = details.primaryDelta! / maxSide;
      _animationController!.value += delta;
    }
  }

  void _onDragEnd(DragEndDetails details) {
    if (_animationController!.isDismissed ||
        _animationController!.isCompleted) {
      return;
    }
    if (details.velocity.pixelsPerSecond.dx.abs() >= 365) {
      double visualVelocity = details.velocity.pixelsPerSecond.dx /
          MediaQuery.of(context).size.width;
      _animationController!.fling(velocity: visualVelocity);
    } else if (_animationController!.value < 0.5) {
      _animationController!.reverse();
    } else {
      _animationController!.forward();
    }
  }

  double maxSide = 225;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeConfig.getDarkThemeData(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: GestureDetector(
          onHorizontalDragUpdate: (details) {
            if (details.primaryDelta! > 0) {
              _animationController!.forward();
            } else {
              _animationController!.reverse();
            }
          },
          // onTap: toggle,
          child: AnimatedBuilder(
              animation: _animationController!,
              builder: (context, _) {
                double slide = maxSide * _animationController!.value;
                double scale = 1 - (_animationController!.value * 0.3);
                return Stack(
                  children: [
                    const CustomDrawer(),
                    Transform(
                        transform: Matrix4.identity()
                          ..translate(slide)
                          ..scale(scale),
                        alignment: Alignment.centerLeft,
                        child: CustomBody(
                          onMenuTap: toggle,
                        )),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
