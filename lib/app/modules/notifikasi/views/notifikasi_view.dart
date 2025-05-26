import 'package:flutter/material.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({Key? key}) : super(key: key);

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView>
    with TickerProviderStateMixin {
  AnimationController? _fadeController;
  Animation<double>? _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 600),
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
    super.dispose();
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
              height: 120,
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

                  // Header content with back button
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                        const Expanded(
                          child: Text(
                            'Notifikasi',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                        const SizedBox(width: 36), // Balance the back button
                      ],
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
                child: FadeTransition(
                  opacity: _fadeAnimation ?? const AlwaysStoppedAnimation(1.0),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Today Section
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF2DB5A5),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Text(
                                'Hari Ini',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const Text(
                              'Tandai Semua Dibaca',
                              style: TextStyle(
                                color: Color(0xFF2DB5A5),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // Today Notifications
                        _buildNotificationItem(
                          icon: Icons.school_outlined,
                          title: 'Pengingat Ekskul',
                          description: 'hai, goldi! ekskul seni akan dimulai dalam 3 jam lagi, jangan lupa join yaa.',
                          time: '2 Menit',
                          isUnread: true,
                        ),

                        const SizedBox(height: 15),

                        _buildNotificationItem(
                          icon: Icons.school_outlined,
                          title: 'Pengingat Ekskul',
                          description: 'hai, goldi! ekskul basket akan dimulai dalam 3 jam lagi, jangan lupa join yaa.',
                          time: '2 Jam',
                          isUnread: true,
                        ),

                        const SizedBox(height: 15),

                        _buildNotificationItem(
                          icon: Icons.school_outlined,
                          title: 'Pengingat Ekskul',
                          description: 'hai, goldi! paduan suara akan dimulai dalam 3 jam lagi, jangan lupa join yaa.',
                          time: '3 Jam',
                          isUnread: true,
                        ),

                        const SizedBox(height: 30),

                        // Yesterday Section
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2DB5A5),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'Kemarin',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        _buildNotificationItem(
                          icon: Icons.school_outlined,
                          title: 'Pengingat Ekskul',
                          description: 'hai, goldi! jurnalistik akan dimulai dalam 3 jam lagi, jangan lupa join yaa..',
                          time: '1 Hari',
                          isUnread: false,
                        ),

                        const SizedBox(height: 30),

                        // 15 April Section
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2DB5A5),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            '15 April',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        _buildNotificationItem(
                          icon: Icons.groups_outlined,
                          title: 'Komunitas',
                          description: 'seseorang baru saja meninggalkanmu pesan, batas mereka segera!',
                          time: '5 Hari',
                          isUnread: false,
                        ),

                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationItem({
    required IconData icon,
    required String title,
    required String description,
    required String time,
    required bool isUnread,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: isUnread
            ? Border.all(color: const Color(0xFF2DB5A5).withOpacity(0.3), width: 1)
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon container
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: const Color(0xFF2DB5A5).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF2DB5A5),
              size: 22,
            ),
          ),

          const SizedBox(width: 15),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      time,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[500],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),

          // Unread indicator
          if (isUnread)
            Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.only(top: 8, left: 8),
              decoration: const BoxDecoration(
                color: Color(0xFF2DB5A5),
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }
}