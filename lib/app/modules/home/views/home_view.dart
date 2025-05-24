import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  int _selectedIndex = 0;
  AnimationController? _fadeController;
  AnimationController? _slideController;
  Animation<double>? _fadeAnimation;
  Animation<Offset>? _slideAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController!, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideController!, curve: Curves.elasticOut));

    _fadeController?.forward();
    _slideController?.forward();
  }

  @override
  void dispose() {
    _fadeController?.dispose();
    _slideController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2DB5A5),
      body: SafeArea(
        child: Column(
          children: [
            // Enhanced Header Section with decorative elements
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF2DB5A5),
                    const Color(0xFF1FA396),
                  ],
                ),
              ),
              child: Stack(
                children: [
                  // Decorative circles
                  Positioned(
                    top: -30,
                    right: -30,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.1),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 60,
                    left: -40,
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.08),
                      ),
                    ),
                  ),

                  Padding(
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
                                  // Enhanced signal bars
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
                                  // Enhanced battery icon
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

                          const SizedBox(height: 30),

                          // Enhanced Profile Section
                          Row(
                            children: [
                              // Enhanced Profile Avatar with pulse effect
                              Container(
                                width: 68,
                                height: 68,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    colors: [Colors.white, Colors.white.withOpacity(0.8)],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Container(
                                  margin: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: ClipOval(
                                    child: Image.asset(
                                      'assets/images/profile_avatar.png',
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Container(
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                const Color(0xFF2DB5A5).withOpacity(0.1),
                                                const Color(0xFF2DB5A5).withOpacity(0.2),
                                              ],
                                            ),
                                          ),
                                          child: const Icon(
                                            Icons.person,
                                            color: Color(0xFF2DB5A5),
                                            size: 32,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(width: 15),

                              // Enhanced Profile Info with better typography
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Albert Einstein',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    _buildInfoRow('NISN: 010101010'),
                                    _buildInfoRow('Status: Pelajar Gokil'),
                                    _buildInfoRow('Aktif Sejak: 20 Mei 345'),
                                  ],
                                ),
                              ),

                              // Enhanced Notification and Settings with hover effects
                              Row(
                                children: [
                                  _buildHeaderButton(Icons.notifications_outlined),
                                  const SizedBox(width: 10),
                                  _buildHeaderButton(Icons.settings_outlined),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Enhanced Main Content
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: SlideTransition(
                  position: _slideAnimation ?? const AlwaysStoppedAnimation(Offset.zero),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 25, 20, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Enhanced Aktivitas Section
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Aktivitas',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.black87,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: const Color(0xFF2DB5A5).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: const Text(
                                'Lihat Semua',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF2DB5A5),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // Enhanced Activity Menu with better shadows and animations
                        Container(
                          padding: const EdgeInsets.all(25),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.grey[50]!,
                                Colors.grey[100]!,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                blurRadius: 15,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () => Navigator.pushNamed(context, '/jadwal'),
                                child: _buildEnhancedActivityItem(
                                  icon: Icons.calendar_today,
                                  label: 'Jadwal',
                                  color: const Color(0xFF2DB5A5),
                                ),
                              ),
                              _buildEnhancedActivityItem(
                                icon: Icons.badge_outlined,
                                label: 'Presensi',
                                color: const Color(0xFF2DB5A5),
                              ),
                              _buildEnhancedActivityItem(
                                icon: Icons.assignment_outlined,
                                label: 'Pendaftaran\nEkskul',
                                color: const Color(0xFF2DB5A5),
                              ),
                              _buildEnhancedActivityItem(
                                icon: Icons.groups_outlined,
                                label: 'Komunitas',
                                color: const Color(0xFF2DB5A5),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 35),

                        // Enhanced Jadwal Ekstrakurikuler section
                        Row(
                          children: [
                            Container(
                              width: 4,
                              height: 24,
                              decoration: BoxDecoration(
                                color: const Color(0xFF2DB5A5),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              'Jadwal Ekstrakurikuler hari ini',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // Enhanced Schedule Card
                        GestureDetector(
                          onTap: () => Navigator.pushNamed(context, '/jadwal'),
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Colors.white, Colors.grey[50]!],
                              ),
                              borderRadius: BorderRadius.circular(18),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.15),
                                  blurRadius: 20,
                                  offset: const Offset(0, 8),
                                ),
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.05),
                                  blurRadius: 5,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                // Enhanced Date Circle
                                Container(
                                  width: 55,
                                  height: 55,
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [Color(0xFF2DB5A5), Color(0xFF1FA396)],
                                    ),
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFF2DB5A5).withOpacity(0.3),
                                        blurRadius: 10,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: const Center(
                                    child: Text(
                                      '27',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 18),

                                // Enhanced Schedule Info
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Rabu',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFF2DB5A5).withOpacity(0.1),
                                              borderRadius: BorderRadius.circular(6),
                                            ),
                                            child: const Text(
                                              '14:45',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xFF2DB5A5),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Container(
                                            width: 20,
                                            height: 1,
                                            color: Colors.grey[300],
                                          ),
                                          const SizedBox(width: 8),
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                            decoration: BoxDecoration(
                                              color: Colors.orange.withOpacity(0.1),
                                              borderRadius: BorderRadius.circular(6),
                                            ),
                                            child: const Text(
                                              '17:10',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.orange,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 12),
                                      const Text(
                                        'Paduan Suara',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      const Text(
                                        'Ekskul Musik',
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.location_on_outlined,
                                            size: 16,
                                            color: Colors.grey[600],
                                          ),
                                          const SizedBox(width: 6),
                                          Text(
                                            'Ruang Musik Lt. 2',
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.grey[600],
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                                // Enhanced Status Badge
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [Colors.yellow[100]!, Colors.orange[50]!],
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.schedule,
                                    color: Colors.orange[700],
                                    size: 18,
                                  ),
                                ),

                                const SizedBox(width: 12),

                                const Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.grey,
                                  size: 16,
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 35),

                        // Enhanced Informasi Section
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 4,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                const Text(
                                  'Informasi untuk kamu',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.grey,
                              size: 16,
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // Enhanced News Card
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.15),
                                blurRadius: 20,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Enhanced News Image
                              Container(
                                height: 180,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(18),
                                    topRight: Radius.circular(18),
                                  ),
                                  gradient: LinearGradient(
                                    colors: [Colors.grey[200]!, Colors.grey[100]!],
                                  ),
                                ),
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(18),
                                        topRight: Radius.circular(18),
                                      ),
                                      child: Image.asset(
                                        'assets/images/cakrabeswara.png',
                                        width: double.infinity,
                                        height: double.infinity,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) {
                                          return Container(
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [Colors.grey[200]!, Colors.grey[100]!],
                                              ),
                                            ),
                                            child: const Center(
                                              child: Icon(
                                                Icons.image,
                                                size: 60,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    // Gradient overlay
                                    Positioned(
                                      bottom: 0,
                                      left: 0,
                                      right: 0,
                                      height: 80,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Colors.transparent,
                                              Colors.black.withOpacity(0.3),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Enhanced News Content
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Cakrabeswara Kembali Membawa Piala Dunia',
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black87,
                                        height: 1.3,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      'Sejak pandemi melanda negeri banyak para siswa yang...',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[600],
                                        height: 1.4,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                          decoration: BoxDecoration(
                                            color: Colors.blue.withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: const Text(
                                            'Berita Terbaru',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.blue,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      // Enhanced Bottom Navigation Bar
      bottomNavigationBar: Container(
        height: 85,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
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
              isActive: _selectedIndex == 0,
              onTap: () => setState(() => _selectedIndex = 0),
            ),
            _buildNavItem(
              icon: Icons.groups_outlined,
              label: 'Komunitas',
              isActive: _selectedIndex == 1,
              onTap: () => setState(() => _selectedIndex = 1),
            ),
            // Enhanced Center QR Scanner Button
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
              isActive: _selectedIndex == 2,
              onTap: () {
                setState(() => _selectedIndex = 2);
                Navigator.pushNamed(context, '/jadwal');
              },
            ),
            _buildNavItem(
              icon: Icons.person_outline,
              label: 'Akun',
              isActive: _selectedIndex == 3,
              onTap: () => setState(() => _selectedIndex = 3),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white.withOpacity(0.9),
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildHeaderButton(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: 20,
      ),
    );
  }

  Widget _buildEnhancedActivityItem({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          width: 65,
          height: 65,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [color, color.withOpacity(0.8)],
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 26,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black87,
            fontWeight: FontWeight.w600,
            height: 1.2,
          ),
        ),
      ],
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