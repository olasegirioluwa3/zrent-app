import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_theme.dart';

/// Document Scan Screen
/// 
/// Figma: https://www.figma.com/design/MwxOsKuN9q6b815CH3IcLJ/Untitled?node-id=304-1754
/// Screen ID: 236:287
class DocumentScanScreen extends StatefulWidget {
  const DocumentScanScreen({super.key});

  @override
  State<DocumentScanScreen> createState() => _DocumentScanScreenState();
}

class _DocumentScanScreenState extends State<DocumentScanScreen> {
  CameraController? _cameraController;
  bool _isCameraInitialized = false;
  bool _isFrontSide = true;
  bool _isCapturing = false;
  bool _isFlashOn = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isNotEmpty) {
        _cameraController = CameraController(
          cameras[0],
          ResolutionPreset.high,
          enableAudio: false,
        );
        await _cameraController!.initialize();
        if (mounted) {
          setState(() => _isCameraInitialized = true);
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Camera error: ${e.toString()}'),
            backgroundColor: AppTheme.error,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  void _captureDocument() async {
    if (_cameraController == null || !_isCameraInitialized) return;

    setState(() => _isCapturing = true);

    try {
      final image = await _cameraController!.takePicture();
      // TODO: Process and upload the document image
      
      if (_isFrontSide) {
        setState(() {
          _isFrontSide = false;
          _isCapturing = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Front side captured. Please capture the back side.'),
            backgroundColor: AppTheme.secondary,
          ),
        );
      } else {
        if (mounted) {
          context.push(RouteNames.verificationSubmitted);
        }
      }
    } catch (e) {
      setState(() => _isCapturing = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Capture failed: ${e.toString()}'),
            backgroundColor: AppTheme.error,
          ),
        );
      }
    }
  }

  void _toggleFlash() async {
    if (_cameraController == null || !_isCameraInitialized) return;
    try {
      final nextMode = _isFlashOn ? FlashMode.off : FlashMode.torch;
      await _cameraController!.setFlashMode(nextMode);
      setState(() {
        _isFlashOn = !_isFlashOn;
      });
    } catch (e) {
      // Failed to set flash mode
    }
  }

  void _selectFromGallery() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Gallery picker not implemented yet'),
        backgroundColor: AppTheme.warning,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(LucideIcons.x, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        centerTitle: true,
        title: Text(
          _isFrontSide ? 'Scan Front Side' : 'Scan Back Side',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.5,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              _isFlashOn ? LucideIcons.zap : LucideIcons.zapOff,
              color: _isFlashOn ? AppTheme.primary : Colors.white,
            ),
            onPressed: _toggleFlash,
          ),
        ],
      ),
      body: Stack(
        children: [
          // Camera Preview
          if (_isCameraInitialized && _cameraController != null)
            Positioned.fill(
              child: AspectRatio(
                aspectRatio: _cameraController!.value.aspectRatio,
                child: CameraPreview(_cameraController!),
              ),
            )
          else
            const Center(
              child: CircularProgressIndicator(color: AppTheme.primary),
            ),
          
          // Transparent Dark Overlay everywhere except the center target frame
          if (_isCameraInitialized) _buildScannerOverlay(),

          // Corner Guides
          if (_isCameraInitialized) _buildCornerGuides(),
          
          // Bottom Controls
          if (_isCameraInitialized)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.fromLTRB(24, 40, 24, 40),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.9),
                    ],
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Position the document clearly within the borders',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Gallery Button
                        _buildControlButton(
                          icon: LucideIcons.image,
                          onPressed: _selectFromGallery,
                        ),
                        // Capture Button
                        GestureDetector(
                          onTap: _isCapturing ? null : _captureDocument,
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(6),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 150),
                              decoration: BoxDecoration(
                                color: _isCapturing 
                                    ? Colors.grey 
                                    : Colors.white,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.black, width: 2),
                              ),
                              child: _isCapturing
                                  ? const Center(
                                      child: SizedBox(
                                        width: 24,
                                        height: 24,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                                        ),
                                      ),
                                    )
                                  : null,
                            ),
                          ),
                        ),
                        // Switch Camera Button
                        _buildControlButton(
                          icon: LucideIcons.refreshCw,
                          onPressed: () {
                            // TODO: Implement switch camera if multiple available
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.12),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: Colors.white, size: 24),
        padding: const EdgeInsets.all(14),
      ),
    );
  }

  Widget _buildScannerOverlay() {
    return ColorFiltered(
      colorFilter: ColorFilter.mode(
        Colors.black.withOpacity(0.55),
        BlendMode.srcOut,
      ),
      child: Stack(
        children: [
          Container(
            color: Colors.transparent,
          ),
          Center(
            child: Container(
              width: 320,
              height: 210,
              decoration: BoxDecoration(
                color: Colors.black, // acts as mask when srcOut is applied
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCornerGuides() {
    const double size = 30;
    const double thickness = 3;
    final borderRadius = BorderRadius.circular(20);

    return Center(
      child: SizedBox(
        width: 320,
        height: 210,
        child: Stack(
          children: [
            // Top Left corner
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: size,
                height: size,
                decoration: const BoxDecoration(
                  border: Border(
                    left: BorderSide(color: AppTheme.primary, width: thickness),
                    top: BorderSide(color: AppTheme.primary, width: thickness),
                  ),
                ),
              ),
            ),
            // Top Right corner
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                width: size,
                height: size,
                decoration: const BoxDecoration(
                  border: Border(
                    right: BorderSide(color: AppTheme.primary, width: thickness),
                    top: BorderSide(color: AppTheme.primary, width: thickness),
                  ),
                ),
              ),
            ),
            // Bottom Left corner
            Positioned(
              left: 0,
              bottom: 0,
              child: Container(
                width: size,
                height: size,
                decoration: const BoxDecoration(
                  border: Border(
                    left: BorderSide(color: AppTheme.primary, width: thickness),
                    bottom: BorderSide(color: AppTheme.primary, width: thickness),
                  ),
                ),
              ),
            ),
            // Bottom Right corner
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: size,
                height: size,
                decoration: const BoxDecoration(
                  border: Border(
                    right: BorderSide(color: AppTheme.primary, width: thickness),
                    bottom: BorderSide(color: AppTheme.primary, width: thickness),
                  ),
                ),
              ),
            ),
            // Text guide in center
            const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Fit ID Card Here',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

