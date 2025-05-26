import 'package:flutter/material.dart';
import 'dart:async';

class PresensiView extends StatefulWidget {
  const PresensiView({Key? key}) : super(key: key);

  @override
  State<PresensiView> createState() => _PresensiViewState();
}

class _PresensiViewState extends State<PresensiView>
    with TickerProviderStateMixin {
  bool _isScanning = false;
  bool _isFlashOn = false;
  Timer? _scanTimer;
  AnimationController? _scanAnimationController;
  AnimationController? _fadeController;
  Animation<double>? _scanAnimation;
  Animation<double>? _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _scanAnimationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _scanAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _scanAnimationController!, curve: Curves.easeInOut),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController!, curve: Curves.easeInOut),
    );

    _fadeController?.forward();
  }

  @override
  void dispose() {
    _scanTimer?.cancel();
    _scanAnimationController?.dispose();
    _fadeController?.dispose();
    super.dispose();
  }

  void _toggleFlash() {
    setState(() {
      _isFlashOn = !_isFlashOn;
    });

    // Simulasi feedback haptic
    // HapticFeedback.lightImpact(); // Uncomment jika ingin haptic feedback

    // Show snackbar untuk feedback
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_isFlashOn ? 'Flash dinyalakan' : 'Flash dimatikan'),
        duration: const Duration(seconds: 1),
        backgroundColor: const Color(0xFF2DB5A5),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void _startScanning() {
    setState(() {
      _isScanning = true;
    });

    _scanAnimationController?.repeat();

    // Simulasi scanning selama 3 detik
    _scanTimer = Timer(const Duration(seconds: 3), () {
      _scanAnimationController?.stop();
      _showSuccessDialog();
      setState(() {
        _isScanning = false;
      });
    });
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Close button
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
                        size: 20,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Success message
                const Text(
                  'Absen Hari Ini Sukses !',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2DB5A5),
                  ),
                ),

                const SizedBox(height: 30),
                // Success icon
                Container(
                  width: 120,
                  height: 120,
                  decoration: const BoxDecoration(
                    color: Color(0xFF2DB5A5),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check,
                    color: Colors.yellow,
                    size: 60,
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        );
      },
    );
  }

  // Navigation handlers
  void _navigateToHome() {
    Navigator.of(context).pop(); // Go back to home
  }

  void _navigateToKomunitas() {
    // Navigate to Komunitas page
    Navigator.pushNamed(context, '/komunitas');
    // Alternative jika menggunakan direct navigation:
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => const KomunitasView()),
    // );
  }

  void _navigateToJadwal() {
    // Navigate to Jadwal page
    Navigator.pushNamed(context, '/jadwal');
  }

  void _navigateToAkun() {
    // Navigate to Akun page
    Navigator.pushNamed(context, '/akun');
    // Alternative jika menggunakan direct navigation:
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => const AkunView()),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2DB5A5),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(20),
              child: FadeTransition(
                opacity: _fadeAnimation ?? const AlwaysStoppedAnimation(1.0),
                child: Column(
                  children: [
                    // Status bar
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          '09:30',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Row(
                          children: [
                            // Signal bars
                            ...List.generate(4, (index) => Container(
                              width: 3,
                              height: 8 + (index * 2),
                              margin: const EdgeInsets.only(right: 2),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.9),
                                borderRadius: BorderRadius.circular(1.5),
                              ),
                            )),
                            const SizedBox(width: 8),
                            // Battery icon
                            Container(
                              width: 24,
                              height: 12,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white, width: 1.5),
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: Container(
                                margin: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(1),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 40),

                    // Title
                    const Text(
                      'Presensi',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Main Content
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),

                      // Instructions with flash status
                      Column(
                        children: [
                          const Text(
                            'Arahkan kamera ke QR Code untuk presensi',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          if (_isFlashOn)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.yellow[100],
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: Colors.yellow[300]!),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.flash_on,
                                    size: 16,
                                    color: Colors.yellow[700],
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Flash Aktif',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.yellow[700],
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),

                      const SizedBox(height: 40),

                      // QR Scanner Area
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal:5),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Stack(
                            children: [
                              // Camera background simulation
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: _isFlashOn
                                        ? [
                                            const Color(0xFF4a4a4a),
                                            const Color(0xFF6a6a6a),
                                          ]
                                        : [
                                            const Color(0xFF1a1a1a),
                                            const Color(0xFF2a2a2a),
                                          ],
                                    ),
                                  ),
                                  child: Stack(
                                    children: [
                                      // Background pattern untuk simulasi kamera
                                      Container(
                                        decoration: BoxDecoration(
                                          gradient: RadialGradient(
                                            center: Alignment.center,
                                            radius: 1.0,
                                            colors: [
                                              Colors.white.withOpacity(_isFlashOn ? 0.1 : 0.05),
                                              Colors.transparent,
                                            ],
                                          ),
                                        ),
                                      ),
                                      // Flash overlay effect
                                      if (_isFlashOn)
                                        Container(
                                          decoration: BoxDecoration(
                                            gradient: RadialGradient(
                                              center: Alignment.topRight,
                                              radius: 0.8,
                                              colors: [
                                                Colors.white.withOpacity(0.3),
                                                Colors.white.withOpacity(0.1),
                                                Colors.transparent,
                                              ],
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),

                              // QR Code frame overlay
                              Center(
                                child: Container(
                                  width: 200,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Stack(
                                    children: [
                                      // Corner frames
                                      ...List.generate(4, (index) {
                                        return Positioned(
                                          top: index < 2 ? 10 : null,
                                          bottom: index >= 2 ? 10 : null,
                                          left: index % 2 == 0 ? 10 : null,
                                          right: index % 2 == 1 ? 10 : null,
                                          child: Container(
                                            width: 20,
                                            height: 20,
                                            decoration: BoxDecoration(
                                              border: Border(
                                                top: index < 2 ? const BorderSide(color: Color(0xFF2DB5A5), width: 4) : BorderSide.none,
                                                bottom: index >= 2 ? const BorderSide(color: Color(0xFF2DB5A5), width: 4) : BorderSide.none,
                                                left: index % 2 == 0 ? const BorderSide(color: Color(0xFF2DB5A5), width: 4) : BorderSide.none,
                                                right: index % 2 == 1 ? const BorderSide(color: Color(0xFF2DB5A5), width: 4) : BorderSide.none,
                                              ),
                                            ),
                                          ),
                                        );
                                      }),

                                      // Scanning line animation
                                      if (_isScanning)
                                        AnimatedBuilder(
                                          animation: _scanAnimation!,
                                          builder: (context, child) {
                                            return Positioned(
                                              top: _scanAnimation!.value * 160 + 20,
                                              left: 20,
                                              right: 20,
                                              child: Container(
                                                height: 2,
                                                decoration: BoxDecoration(
                                                  gradient: const LinearGradient(
                                                    colors: [
                                                      Colors.transparent,
                                                      Color(0xFF2DB5A5),
                                                      Colors.transparent,
                                                    ],
                                                  ),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: const Color(0xFF2DB5A5).withOpacity(0.5),
                                                      blurRadius: 10,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                    ],
                                  ),
                                ),
                              ),

                              // Flash button
                              Positioned(
                                top: 20,
                                right: 20,
                                child: GestureDetector(
                                  onTap: _toggleFlash,
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: _isFlashOn
                                        ? Colors.yellow[600]
                                        : const Color(0xFF2DB5A5),
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: (_isFlashOn
                                            ? Colors.yellow[600]!
                                            : const Color(0xFF2DB5A5)).withOpacity(0.3),
                                          blurRadius: _isFlashOn ? 15 : 10,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: Icon(
                                      _isFlashOn ? Icons.flash_on : Icons.flash_off,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 40),

                      // Scan Button
                      GestureDetector(
                        onTap: _isScanning ? null : _startScanning,
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: _isScanning
                                  ? [Colors.grey, Colors.grey[600]!]
                                  : [const Color(0xFF2DB5A5), const Color(0xFF1FA396)],
                            ),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: (_isScanning ? Colors.grey : const Color(0xFF2DB5A5)).withOpacity(0.3),
                                blurRadius: 15,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Icon(
                            _isScanning ? Icons.stop : Icons.camera_alt,
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      Text(
                        _isScanning
                          ? 'Scanning...'
                          : _isFlashOn
                            ? 'Tap to Scan (Flash On)'
                            : 'Tap to Scan',
                        style: TextStyle(
                          fontSize: 16,
                          color: _isScanning ? Colors.grey : const Color(0xFF2DB5A5),
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      // Bottom Navigation Bar with full functionality
      bottomNavigationBar: Container(
        height: 85,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(5),
            topRight: Radius.circular(5),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 20,
              offset: const Offset(0, -8),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(
              icon: Icons.home,
              label: 'Home',
              isActive: false,
              onTap: _navigateToHome,
            ),
            _buildNavItem(
              icon: Icons.groups_outlined,
              label: 'Komunitas',
              isActive: false,
              onTap: _navigateToKomunitas,
            ),
            // Center QR Scanner Button (Active)
            Container(
              width: 65,
              height: 65,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF2DB5A5), Color(0xFF1FA396)],
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF2DB5A5).withOpacity(0.4),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: const Icon(
                Icons.qr_code_scanner,
                color: Colors.white,
                size: 32,
              ),
            ),
            _buildNavItem(
              icon: Icons.calendar_today_outlined,
              label: 'Jadwal',
              isActive: false,
              onTap: _navigateToJadwal,
            ),
            _buildNavItem(
              icon: Icons.person_outline,
              label: 'Akun',
              isActive: false,
              onTap: _navigateToAkun,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isActive ? const Color(0xFF2DB5A5).withOpacity(0.1) : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: isActive ? const Color(0xFF2DB5A5) : Colors.grey,
              size: 24,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isActive ? const Color(0xFF2DB5A5) : Colors.grey,
              fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}