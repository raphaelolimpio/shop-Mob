import 'package:flutter/material.dart';
import 'package:loja/DS/components/loading/loading.dart';
import 'package:loja/DS/shared/color/colors.dart';

class CreativeLoading extends StatefulWidget {
  final Color color;
  final double size;
  final String? message;

  const CreativeLoading({
    Key? key,
    this.color = Colors.blue,
    this.size = 18.0,
    this.message,
  }) : super(key: key);

  @override
  State<CreativeLoading> createState() => _CreativeLoadingState();
}

class _CreativeLoadingState extends State<CreativeLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation1;
  late Animation<double> _animation2;
  late Animation<double> _animation3;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();

    _animation1 = Tween<double>(begin: 0, end: -15).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(10, 1.0, curve: Curves.easeInOut),
      ),
    );
    _animation2 = Tween<double>(begin: 0, end: -15).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.6, curve: Curves.easeInOut),
      ),
    );
    _animation3 = Tween<double>(begin: 0, end: -15).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 1.0, curve: Curves.easeInOut),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildDot(Animation<double> animation) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, animation.value),
          child: child,
        );
      },
      child: Container(
        width: widget.size,
        height: widget.size,
        margin: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(color: widget.color, shape: BoxShape.circle),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDot(_animation1),
              _buildDot(_animation2),
              _buildDot(_animation3),
            ],
          ),
          if (widget.message != null) ...[
            const SizedBox(height: 18),
            Text(
              widget.message!,
              style: TextStyle(
                color: widget.color,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
          ElevatedButton(
            onPressed: () {
              Loading(color: kGreen200);
            },
            child: const Text("Tentar novamente"),
          ),
        ],
      ),
    );
  }
}
