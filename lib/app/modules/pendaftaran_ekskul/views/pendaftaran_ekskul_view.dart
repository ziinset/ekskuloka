import 'package:flutter/material.dart';

class PendaftaranEkskulView extends StatefulWidget {
  const PendaftaranEkskulView({Key? key}) : super(key: key);

  @override
  State<PendaftaranEkskulView> createState() => _PendaftaranEkskulViewState();
}

class _PendaftaranEkskulViewState extends State<PendaftaranEkskulView>
    with TickerProviderStateMixin {
  int _selectedIndex = 2; // Set to "Pendaftaran Ekskul" tab
  AnimationController? _fadeController;
  Animation<double>? _fadeAnimation;

  // Form controllers
  final TextEditingController _nisnController = TextEditingController();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _kelasController = TextEditingController();
  final TextEditingController _tujuanController = TextEditingController();

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

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController!, curve: Curves.easeInOut),
    );

    _fadeController?.forward();
  }

  @override
  void dispose() {
    _fadeController?.dispose();
    _nisnController.dispose();
    _namaController.dispose();
    _kelasController.dispose();
    _tujuanController.dispose();
    super.dispose();
  }

  // List of ekstrakurikuler
  final List<Map<String, dynamic>> _ekstrakurikuler = [
    {
      'title': 'Paduan Suara',
      'quota': '32/46 siswa',
      'status': 'Open Recruitment',
      'image': 'assets/images/paduan_suara.png',
      'color': const Color(0xFF2DB5A5),
    },
    {
      'title': 'Basket',
      'quota': '32/46 siswa',
      'status': 'Open Recruitment',
      'image': 'assets/images/basket.png',
      'color': const Color(0xFFFF6B6B),
    },
    {
      'title': 'Jurnalistik',
      'quota': '32/46 siswa',
      'status': 'Open Recruitment',
      'image': 'assets/images/jurnalistik.png',
      'color': const Color(0xFF4ECDC4),
    },
    {
      'title': 'Dewan Galang',
      'quota': '32/46 siswa',
      'status': 'Open Recruitment',
      'image': 'assets/images/dewan_galang.png',
      'color': const Color(0xFFFFBE0B),
    },
  ];

  String? _selectedEkskul;
  bool _showForm = false;

  void _showRegistrationForm(String ekskulTitle) {
    setState(() {
      _selectedEkskul = ekskulTitle;
      _showForm = true;
    });
  }

  void _backToEkskulList() {
    setState(() {
      _showForm = false;
      _selectedEkskul = null;
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
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 20),
                    // Success Icon with circle background
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: const Color(0xFF2DB5A5),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF2DB5A5).withOpacity(0.3),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Pendaftaranmu Sukses!',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF2DB5A5),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
                // Close button positioned at top right
                Positioned(
                  top: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop(); // Go back to home
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
                        color: Colors.grey,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _submitForm() {
    if (_nisnController.text.isEmpty ||
        _namaController.text.isEmpty ||
        _kelasController.text.isEmpty ||
        _tujuanController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Mohon lengkapi semua field'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    _showSuccessDialog();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2DB5A5),
      body: SafeArea(
        child: Column(
          children: [
            // Header Section
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF2DB5A5), Color(0xFF1FA396)],
                ),
              ),
              child: Stack(
                children: [
                  // Decorative circles
                  Positioned(
                    top: -60,
                    right: -60,
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.1),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 80,
                    right: 30,
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
                          // Back button and title
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (_showForm) {
                                    _backToEkskulList();
                                  } else {
                                    Navigator.pop(context);
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15),
                              const Text(
                                'Kembali',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 30),

                          // Main Title
                          if (!_showForm) ...[
                            Row(
                              children: [
                                // Illustration placeholder
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(
                                    Icons.assignment_outlined,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                ),
                                const SizedBox(width: 15),
                                const Expanded(
                                  child: Text(
                                    'Pendaftaran Ekskul',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Righteous',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ] else ...[
                            // Form header with illustration
                            Row(
                              children: [
                                // Use PNG illustration based on selected ekskul
                                Container(
                                  width: 120,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.asset(
                                      _getImagePathForEkskul(_selectedEkskul!),
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Center(
                                          child: Icon(
                                            _getIconForEkskul(_selectedEkskul!),
                                            color: Colors.white,
                                            size: 40,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Daftar Jadi Anggota',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        '$_selectedEkskul!',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 24,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
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
                child: !_showForm ? _buildEkskulList() : _buildRegistrationForm(),
              ),
            ),
          ],
        ),
      ),

      // Bottom Navigation Bar (same as home)
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
              isActive: _selectedIndex == 0,
              onTap: () => Navigator.pushReplacementNamed(context, '/home'),
            ),
            _buildNavItem(
              icon: Icons.groups_outlined,
              label: 'Komunitas',
              isActive: _selectedIndex == 1,
              onTap: () => setState(() => _selectedIndex = 1),
            ),
            // Center QR Scanner Button
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/presensi'),
              child: Container(
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
            ),
            _buildNavItem(
              icon: Icons.calendar_today_outlined,
              label: 'Jadwal',
              isActive: _selectedIndex == 2,
              onTap: () => Navigator.pushNamed(context, '/jadwal'),
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

  Widget _buildEkskulList() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 25, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Filter section
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF2DB5A5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.list_alt,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Daftar Ekstrakurikuler',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.tune,
                  color: Colors.grey,
                  size: 20,
                ),
              ),
            ],
          ),

          const SizedBox(height: 25),

          // Ekstrakurikuler List
          ..._ekstrakurikuler.map((ekskul) => _buildEkskulCard(ekskul)).toList(),

          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildEkskulCard(Map<String, dynamic> ekskul) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // PNG Image - Larger size to match mockup
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                ekskul['image'],
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  // Fallback to icon if image not found
                  return Container(
                    decoration: BoxDecoration(
                      color: ekskul['color'].withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      _getIconForEkskul(ekskul['title']),
                      color: ekskul['color'],
                      size: 40,
                    ),
                  );
                },
              ),
            ),
          ),

          const SizedBox(width: 16),

          // Content - Adjusted spacing and alignment
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ekskul['title'],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Kuota: ${ekskul['quota']}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Status: ${ekskul['status']}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF2DB5A5),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          // Daftar Button - Positioned to the right with Righteous font
          GestureDetector(
            onTap: () => _showRegistrationForm(ekskul['title']),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF2DB5A5), Color(0xFF1FA396)],
                ),
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF2DB5A5).withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Text(
                'Daftar',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Righteous',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegistrationForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 25, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Form Fields
          _buildFormField(
            label: 'NISN',
            controller: _nisnController,
            placeholder: 'Ketik NISN',
          ),
          const SizedBox(height: 25),
          _buildFormField(
            label: 'NAMA',
            controller: _namaController,
            placeholder: 'Ketik Nama',
          ),
          const SizedBox(height: 25),
          _buildFormField(
            label: 'KELAS',
            controller: _kelasController,
            placeholder: 'Ketik Kelas',
          ),
          const SizedBox(height: 25),
          _buildFormField(
            label: 'TUJUAN/MOTTO',
            controller: _tujuanController,
            placeholder: 'Ketik Tujuan/Motto',
            maxLines: 3,
          ),

          const SizedBox(height: 40),

          // Submit Button
          SizedBox(
            width: double.infinity,
            child: GestureDetector(
              onTap: _submitForm,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 18),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF2DB5A5), Color(0xFF1FA396)],
                  ),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF2DB5A5).withOpacity(0.4),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    'Daftar Sekarang',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildFormField({
    required String label,
    required TextEditingController controller,
    required String placeholder,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: TextField(
            controller: controller,
            maxLines: maxLines,
            decoration: InputDecoration(
              hintText: placeholder,
              hintStyle: TextStyle(
                color: Colors.grey[400],
                fontSize: 14,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }

  String _getImagePathForEkskul(String title) {
    switch (title.toLowerCase()) {
      case 'paduan suara':
        return 'assets/images/paduan_suara.png';
      case 'basket':
        return 'assets/images/basket.png';
      case 'jurnalistik':
        return 'assets/images/jurnalistik.png';
      case 'dewan galang':
        return 'assets/images/dewan_galang.png';
      default:
        return 'assets/images/default_ekskul.png';
    }
  }

  IconData _getIconForEkskul(String title) {
    switch (title.toLowerCase()) {
      case 'paduan suara':
        return Icons.music_note;
      case 'basket':
        return Icons.sports_basketball;
      case 'jurnalistik':
        return Icons.article;
      case 'dewan galang':
        return Icons.groups;
      default:
        return Icons.star;
    }
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
              color: isActive
                  ? const Color(0xFF2DB5A5).withOpacity(0.1)
                  : Colors.transparent,
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