import 'package:flutter/material.dart';

class ImageAnimation extends StatefulWidget {
  const ImageAnimation({Key? key}) : super(key: key);

  @override
  State<ImageAnimation> createState() => _ImageAnimationState();
}

class _ImageAnimationState extends State<ImageAnimation>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

  bool selected = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  double _size = 50.0;
  bool _large = false;

  void _updateSize() {
    setState(() {
      _size = _large ? 250.0 : 100.0;
      _large = !_large;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Animation"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
        AnimatedBuilder(
    animation: _controller,
    child: Container(
    width: 200.0,
    height: 200.0,
    color: Colors.green,
    child: const Center(
    child: Text('Whee!'),
    ),
    ),
    builder: (BuildContext context, Widget? child) {
        return Transform.rotate(
          angle: _controller.value * 2.0 * 3.14,
          child: child,
        );
    }
    ),
  GestureDetector(
            onTap: () {
              _updateSize();
              setState(() {
                selected = !selected;
              });
            },
            child: Center(
              child: Container(
                width: 250.0,
                height: 250.0,
                color: Colors.yellowAccent,
                child: AnimatedAlign(
                  alignment: selected ? Alignment.topRight : Alignment.topLeft,
                  duration: const Duration(seconds: 1),
                  curve: Curves.fastOutSlowIn,
                  child: const FlutterLogo(size: 50.0),
                ),
              ),
            ),
          ),AnimatedContainer(
              width: selected ? 200.0 : 100.0,
              height: selected ? 100.0 : 200.0,
              color: selected ? Colors.red : Colors.blue,
              alignment:
              selected ? Alignment.center : AlignmentDirectional.topCenter,
              duration: const Duration(seconds: 2),
              curve: Curves.fastOutSlowIn,
              child: const FlutterLogo(size: 75),
            ),
            AnimatedOpacity(
              opacity: selected ? 1.0 : 0.0,
              duration: const Duration(seconds: 3),
              child: const FlutterLogo(),
            ),
        AnimatedSize(
          curve: Curves.easeIn,
          duration: const Duration(seconds: 1),
          child: FlutterLogo(size: _size),
        ),
        ScaleTransition(
          scale: _animation,
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: FlutterLogo(size: 150.0),
          ),
        ),
    ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/state_management');
        },
      ),
    );
  }
/*    floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.pushNamed(context, '/second');
      },

      ),
    );
  }*/
}
