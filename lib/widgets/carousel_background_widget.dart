import 'dart:async';
import 'package:flutter/material.dart';
import '../config/app_theme.dart';

/// A scalable vertical rolling collage carousel background widget
/// Displays multiple images in a collage layout that continuously scrolls
class CarouselBackgroundWidget extends StatefulWidget {
  /// List of image asset paths
  final List<String> imagePaths;
  
  /// Duration for each collage transition
  final Duration transitionDuration;
  
  /// Optional overlay color to darken/lighten the background
  final Color? overlayColor;
  
  /// Opacity of the overlay (0.0 to 1.0)
  final double overlayOpacity;
  
  /// How the image should be sized
  final BoxFit fit;
  
  /// Number of images to show in each collage
  final int imagesPerCollage;
  
  /// The child widget to display on top of the background
  final Widget child;

  CarouselBackgroundWidget({
    super.key,
    required this.imagePaths,
    required this.child,
    this.transitionDuration = const Duration(seconds: 6),
    this.overlayColor,
    this.overlayOpacity = AppTheme.overlayOpacityLight,
    this.fit = BoxFit.cover,
    this.imagesPerCollage = 4,
  }) : assert(imagePaths.isNotEmpty, 'Image paths list cannot be empty'),
       assert(imagesPerCollage > 0, 'Images per collage must be greater than 0');

  @override
  State<CarouselBackgroundWidget> createState() => _CarouselBackgroundWidgetState();
}

class _CarouselBackgroundWidgetState extends State<CarouselBackgroundWidget> {
  late PageController _pageController;
  Timer? _timer;
  late List<List<String>> _collageGroups;

  @override
  void initState() {
    super.initState();
    // Create collage groups from image paths
    _collageGroups = _createCollageGroups();
    
    // Start at a middle index for infinite scroll
    final initialIndex = _collageGroups.length * 50;
    _pageController = PageController(initialPage: initialIndex);
    
    // Start auto-scrolling after a brief delay
    Future.delayed(const Duration(milliseconds: 500), () {
      _startAutoScroll();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  /// Creates groups of images for collage layouts
  List<List<String>> _createCollageGroups() {
    final groups = <List<String>>[];
    final images = List<String>.from(widget.imagePaths);
    
    // Shuffle and create overlapping groups for variety
    for (int i = 0; i < images.length; i++) {
      final group = <String>[];
      for (int j = 0; j < widget.imagesPerCollage; j++) {
        final index = (i + j) % images.length;
        group.add(images[index]);
      }
      groups.add(group);
    }
    
    return groups;
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(widget.transitionDuration, (timer) {
      if (_pageController.hasClients && mounted) {
        final nextPage = _pageController.page!.toInt() + 1;
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 2000),
          curve: Curves.easeInOutCubic,
        );
      }
    });
  }

  /// Builds a collage layout with multiple images
  Widget _buildCollage(BuildContext context, List<String> imagePaths) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    return Stack(
      fit: StackFit.expand,
      children: [
        // Top left - larger image
        Positioned(
          top: 0,
          left: 0,
          width: screenWidth * 0.6,
          height: screenHeight * 0.5,
          child: _buildImageTile(imagePaths[0], isLarge: true),
        ),
        // Top right - medium image
        Positioned(
          top: 0,
          right: 0,
          width: screenWidth * 0.4,
          height: screenHeight * 0.35,
          child: _buildImageTile(imagePaths.length > 1 ? imagePaths[1] : imagePaths[0]),
        ),
        // Bottom left - medium image
        Positioned(
          bottom: 0,
          left: 0,
          width: screenWidth * 0.45,
          height: screenHeight * 0.5,
          child: _buildImageTile(imagePaths.length > 2 ? imagePaths[2] : imagePaths[0]),
        ),
        // Bottom right - larger image
        Positioned(
          bottom: 0,
          right: 0,
          width: screenWidth * 0.55,
          height: screenHeight * 0.65,
          child: _buildImageTile(
            imagePaths.length > 3 ? imagePaths[3] : imagePaths[0],
            isLarge: true,
          ),
        ),
      ],
    );
  }

  Widget _buildImageTile(String imagePath, {bool isLarge = false}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(isLarge ? 12 : 8),
      child: Image.asset(
        imagePath,
        fit: widget.fit,
        width: double.infinity,
        height: double.infinity,
        gaplessPlayback: true,
        errorBuilder: (context, error, stackTrace) {
          debugPrint('Error loading collage image: $imagePath');
          return Container(
            decoration: BoxDecoration(
              gradient: AppTheme.backgroundGradient,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Collage carousel background
          PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _collageGroups.length * 1000,
            itemBuilder: (context, index) {
              final collageIndex = index % _collageGroups.length;
              return _buildCollage(context, _collageGroups[collageIndex]);
            },
          ),
          // Overlay
          if (widget.overlayColor != null)
            Container(
              width: double.infinity,
              height: double.infinity,
              color: widget.overlayColor!.withOpacity(widget.overlayOpacity),
            ),
          // Content
          widget.child,
        ],
      ),
    );
  }
}
