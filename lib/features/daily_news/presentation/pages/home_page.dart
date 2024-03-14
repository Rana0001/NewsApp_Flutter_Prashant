import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/features/daily_news/presentation/cubit/internet_connection_cubit.dart';
import 'package:newsapp/features/daily_news/presentation/widgets/custom/custom_body.dart';
import 'package:newsapp/features/daily_news/presentation/widgets/custom/custom_drawer.dart';

class HomeNewsPage extends StatefulWidget {
  const HomeNewsPage({super.key});

  @override
  State<HomeNewsPage> createState() => _MyAppState();
}

class _MyAppState extends State<HomeNewsPage>
    with SingleTickerProviderStateMixin {
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
    return BlocListener<InternetConnectionCubit, InternetConnectionState>(
      listener: (context, state) {
        if (state is InternetConnectionDisconnected) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('No internet connection'),
            ),
          );
        }
      },
      child: SafeArea(
        child: Scaffold(
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
      ),
    );
  }
}
