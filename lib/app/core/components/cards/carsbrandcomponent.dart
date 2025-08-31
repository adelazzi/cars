import 'package:cars/app/core/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CarsBrandComponent extends StatefulWidget {
  final String brandName;
  final String logoUrl;
  final Color? accentColor;
  final bool isPremium;

  const CarsBrandComponent({
    Key? key,
    required this.brandName,
    required this.logoUrl,
    this.accentColor,
    this.isPremium = false,
  }) : super(key: key);

  @override
  State<CarsBrandComponent> createState() => _CarsBrandComponentState();
}

class _CarsBrandComponentState extends State<CarsBrandComponent>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _rotateController;
  late AnimationController _glowController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotateAnimation;
  late Animation<double> _glowAnimation;

  bool _isHovered = false;

  @override
  void initState() {
    super.initState();

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _rotateController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _glowController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    ));

    _rotateAnimation = Tween<double>(
      begin: 0.0,
      end: 0.05,
    ).animate(CurvedAnimation(
      parent: _rotateController,
      curve: Curves.easeInOut,
    ));

    _glowAnimation = Tween<double>(
      begin: 0.3,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _glowController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _rotateController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  Color get _getBrandColor {
    return widget.accentColor ?? _getColorByBrand(widget.brandName);
  }

  Color _getColorByBrand(String brand) {
    switch (brand.toLowerCase()) {
      case 'ferrari':
        return const Color(0xFFDC143C);
      case 'lamborghini':
        return const Color(0xFFFFD700);
      case 'bmw':
        return const Color(0xFF0066CC);
      case 'mercedes-benz':
        return const Color(0xFF00A3AD);
      case 'audi':
        return const Color(0xFFBB0A30);
      case 'tesla':
        return const Color(0xFFE31837);
      case 'porsche':
        return const Color(0xFFD5A441);
      case 'jaguar':
        return const Color(0xFF0F4C3A);
      case 'maserati':
        return const Color(0xFF003087);
      default:
        return const Color(0xFF2196F3);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _rotateController.forward().then((_) {
          _rotateController.reverse();
        });
        // Add haptic feedback
        // HapticFeedback.lightImpact();
      },
      child: MouseRegion(
        onEnter: (_) {
          setState(() => _isHovered = true);
          _scaleController.forward();
        },
        onExit: (_) {
          setState(() => _isHovered = false);
          _scaleController.reverse();
        },
        child: AnimatedBuilder(
          animation: Listenable.merge([
            _scaleAnimation,
            _rotateAnimation,
            _glowAnimation,
          ]),
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Transform.rotate(
                angle: _rotateAnimation.value,
                child: Container(
                  padding: EdgeInsets.all(10.r),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Logo Container with advanced styling
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          // Outer glow effect for premium brands
                          if (widget.isPremium)
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: RadialGradient(
                                  colors: [
                                    _getBrandColor.withOpacity(
                                      _glowAnimation.value * 0.4,
                                    ),
                                    Colors.transparent,
                                  ],
                                ),
                              ),
                            ),

                          // Main logo container
                          Container(
                            width: 70.w,
                            height: 70.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.white,
                                  Colors.grey.shade50,
                                ],
                              ),
                              border: Border.all(
                                color: _isHovered
                                    ? _getBrandColor.withOpacity(0.8)
                                    : Colors.grey.shade200,
                                width: _isHovered ? 3 : 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: _getBrandColor.withOpacity(
                                    _isHovered ? 0.3 : 0.1,
                                  ),
                                  blurRadius: _isHovered ? 20 : 12,
                                  offset: const Offset(0, 6),
                                  spreadRadius: _isHovered ? 2 : 0,
                                ),
                                BoxShadow(
                                  color: MainColors.shadowColor(context)!,
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.r),
                              child: Container(
                                padding: EdgeInsets.all(12.r),
                                child: Image.network(
                                  widget.logoUrl,
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(
                                      Icons.directions_car,
                                      size: 25.sp,
                                      color: _getBrandColor,
                                    );
                                  },
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes!
                                            : null,
                                        color: _getBrandColor,
                                        strokeWidth: 2.w,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),

                          // Premium badge
                          if (widget.isPremium)
                            Positioned(
                              bottom: 0,
                              right: 1,
                              child: Container(
                                padding: EdgeInsets.all(4.r),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFD700),
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 4.r,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.star,
                                  color: Colors.white,
                                  size: 12.sp,
                                ),
                              ),
                            ),
                        ],
                      ),

                      SizedBox(height: 12.h),

                      // Brand name with creative styling
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.r,
                        ),
                        decoration: BoxDecoration(
                          gradient: _isHovered
                              ? LinearGradient(
                                  colors: [
                                    _getBrandColor.withOpacity(0.1),
                                    _getBrandColor.withOpacity(0.05),
                                  ],
                                )
                              : null,
                          borderRadius: BorderRadius.circular(20.r),
                          border: _isHovered
                              ? Border.all(
                                  color: _getBrandColor.withOpacity(0.3),
                                  width: 1.w,
                                )
                              : null,
                        ),
                        child: Text(
                          widget.brandName,
                          style: TextStyle(
                            fontSize: 15.r,
                            fontWeight:
                                _isHovered ? FontWeight.w700 : FontWeight.w600,
                            color: _isHovered ? _getBrandColor : Colors.black87,
                            letterSpacing: 0.5,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      // Subtle accent line
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.only(top: 8),
                        height: 2.h,
                        width: _isHovered ? 40.w : 20.w,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              _getBrandColor
                                  .withOpacity(_isHovered ? 0.8 : 0.4),
                              _getBrandColor.withOpacity(0.1),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(1.r),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

























// // // Usage Example with GridView
// // class CarBrandsGrid extends StatelessWidget {
//   final List<Map<String, dynamic>> brands = [
//     {
//       'name': 'Ferrari',
//       'logo': 'https://logos-world.net/wp-content/uploads/2020/04/Ferrari-Logo.png',
//       'isPremium': true,
//       'color': const Color(0xFFDC143C),
//     },
//     {
//       'name': 'Tesla',
//       'logo': 'https://logos-world.net/wp-content/uploads/2020/04/Tesla-Logo.png',
//       'isPremium': false,
//       'color': const Color(0xFFE31837),
//     },
//     {
//       'name': 'BMW',
//       'logo': 'https://logos-world.net/wp-content/uploads/2020/04/BMW-Logo.png',
//       'isPremium': true,
//       'color': const Color(0xFF0066CC),
//     },
//     // Add more brands as needed...
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//           colors: [
//             Colors.grey.shade50,
//             Colors.white,
//           ],
//         ),
//       ),
//       child: GridView.builder(
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 3,
//           childAspectRatio: 0.8,
//           crossAxisSpacing: 8,
//           mainAxisSpacing: 8,
//         ),
//         itemCount: brands.length,
//         itemBuilder: (context, index) {
//           final brand = brands[index];
//           return CarsBrandComponent(
//             brandName: brand['name'],
//             logoUrl: brand['logo'],
//             accentColor: brand['color'],
//             isPremium: brand['isPremium'],
//           );
//         },
//       ),
//     );
//   }
// }