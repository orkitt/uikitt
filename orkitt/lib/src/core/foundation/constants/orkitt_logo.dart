part of 'package:orkitt/orkitt.dart';

//OrkittAssest Image
final String orkittLogo = 'packages/orkitt/lib/src/data/raw/orkitt.png';


class OrkittLogo extends StatefulWidget {
  final double size;
  final Duration animationDuration;
  final bool animateOnInit;
  final VoidCallback? onTap;
  final Color? glowColor;

  const OrkittLogo({
    super.key,
    this.size = 120,
    this.animationDuration = const Duration(milliseconds: 1200),
    this.animateOnInit = true,
    this.onTap,
    this.glowColor,
  });

  @override
  State<OrkittLogo> createState() => _OrkittLogoState();
}

class _OrkittLogoState extends State<OrkittLogo>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacityAnimation;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _opacityAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    if (widget.animateOnInit) _controller.forward();
  }

  void _restartAnimation() {
    _controller.reset();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap?.call();
        _restartAnimation();
      },
      child: MouseRegion(
        cursor: widget.onTap != null
            ? SystemMouseCursors.click
            : SystemMouseCursors.basic,
        child: FadeTransition(
          opacity: _opacityAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Image.asset(
              orkittLogo, // your penguin image asset
              width: widget.size,
              height: widget.size,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: widget.size,
                  height: widget.size,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.broken_image,
                    size: widget.size * 0.5,
                    color: Colors.grey.shade600,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
