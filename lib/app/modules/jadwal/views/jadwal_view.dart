import 'package:flutter/material.dart';

class JadwalView extends StatefulWidget {
  const JadwalView({Key? key}) : super(key: key);

  @override
  State<JadwalView> createState() => _JadwalViewState();
}

class _JadwalViewState extends State<JadwalView> {
  int _selectedIndex = 2; // Set to 2 since this is the Jadwal page

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2DB5A5),
      body: SafeArea(
        child: Column(
          children: [
            // Header Section with decorative elements
            Container(
              height: 200,
              child: Stack(
                children: [
                  // Decorative circles
                  Positioned(
                    top: -50,
                    right: -50,
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 50,
                    right: 20,
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  // Main header content
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                    color: Colors.white.withOpacity(0.8),
                                    borderRadius: BorderRadius.circular(1),
                                  ),
                                )),
                                const SizedBox(width: 5),
                                // Battery icon
                                Container(
                                  width: 24,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white, width: 1),
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                  child: Container(
                                    margin: const EdgeInsets.all(1),
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

                        // Back button and title
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                child: const Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              'Kembali',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // Title
                        const Text(
                          'Jadwal Ekstrakurikuler Yang\nAnda Ikuti',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Righteous',
                            height: 1.1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Content Section
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      // Rabu - 27
                      _buildScheduleDay(
                        day: 'Rabu',
                        date: '27',
                        schedules: [
                          ScheduleItem(
                            startTime: '14:45',
                            endTime: '17:10',
                            title: 'Paduan Suara',
                            subtitle: 'Sedang Berlangsung',
                            location: 'Ruang Musik Lt. 2',
                            status: ScheduleStatus.ongoing,
                          ),
                        ],
                      ),

                      const SizedBox(height: 30),

                      // Kamis - 28
                      _buildScheduleDay(
                        day: 'Kamis',
                        date: '28',
                        schedules: [
                          ScheduleItem(
                            startTime: '14:45',
                            endTime: '15:20',
                            title: 'Jurnalistik',
                            subtitle: '14 Jam lagi akan dimulai',
                            location: 'Ruang Kelas 8A',
                            status: ScheduleStatus.upcoming,
                          ),
                          ScheduleItem(
                            startTime: '15:30',
                            endTime: '17:15',
                            title: 'PMR',
                            subtitle: '15 Jam lagi akan dimulai',
                            location: 'Ruang UKS 1',
                            status: ScheduleStatus.upcoming,
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      // Senin - 1
                      _buildScheduleDay(
                        day: 'Senin',
                        date: '1',
                        schedules: [
                          ScheduleItem(
                            startTime: '14:45',
                            endTime: '16:10',
                            title: 'Seni Rupa dan Desain',
                            subtitle: '4 hari lagi',
                            location: 'Ruang Seni',
                            status: ScheduleStatus.future,
                          ),
                        ],
                      ),

                      const SizedBox(height: 100), // Space for bottom navigation
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      // Bottom Navigation Bar - Added from HomeView
      bottomNavigationBar: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
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
              onTap: () {
                setState(() => _selectedIndex = 0);
                Navigator.pushReplacementNamed(context, '/home');
              },
            ),
            _buildNavItem(
              icon: Icons.groups_outlined,
              label: 'Komunitas',
              isActive: _selectedIndex == 1,
              onTap: () => setState(() => _selectedIndex = 1),
            ),
            // Center QR Scanner Button
            Container(
              width: 60,
              height: 60,
              decoration: const BoxDecoration(
                color: Color(0xFF2DB5A5),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.qr_code_scanner,
                color: Colors.white,
                size: 30,
              ),
            ),
            _buildNavItem(
              icon: Icons.calendar_today_outlined,
              label: 'Jadwal',
              isActive: _selectedIndex == 2,
              onTap: () => setState(() => _selectedIndex = 2),
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

  Widget _buildScheduleDay({
    required String day,
    required String date,
    required List<ScheduleItem> schedules,
  }) {
    return Column(
      children: [
        // Day header with date circle
        Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                color: Color(0xFF2DB5A5),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  date,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 15),
            Text(
              day,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),

        const SizedBox(height: 15),

        // Schedule items
        ...schedules.map((schedule) => _buildScheduleItem(schedule)).toList(),
      ],
    );
  }

  Widget _buildScheduleItem(ScheduleItem schedule) {
    Color statusColor;
    Color statusBgColor;
    IconData statusIcon;

    switch (schedule.status) {
      case ScheduleStatus.ongoing:
        statusColor = Colors.orange[700]!;
        statusBgColor = Colors.yellow[100]!;
        statusIcon = Icons.schedule;
        break;
      case ScheduleStatus.upcoming:
        statusColor = Colors.blue[700]!;
        statusBgColor = Colors.blue[50]!;
        statusIcon = Icons.access_time;
        break;
      case ScheduleStatus.future:
        statusColor = Colors.grey[600]!;
        statusBgColor = Colors.grey[100]!;
        statusIcon = Icons.event;
        break;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Time column
          Container(
            width: 60,
            child: Column(
              children: [
                Text(
                  schedule.startTime,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  width: 2,
                  height: 15,
                  color: const Color(0xFF2DB5A5),
                ),
                const SizedBox(height: 5),
                Text(
                  schedule.endTime,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 15),

          // Schedule content
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.grey[200]!,
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and status
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          schedule.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: statusBgColor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          statusIcon,
                          color: statusColor,
                          size: 16,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // Subtitle
                  Text(
                    schedule.subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: statusColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Location
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 16,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 5),
                      Text(
                        schedule.location,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                        ),
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

  // Navigation bar item builder - Added from HomeView
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
          Icon(
            icon,
            color: isActive ? const Color(0xFF2DB5A5) : Colors.grey,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isActive ? const Color(0xFF2DB5A5) : Colors.grey,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

class ScheduleItem {
  final String startTime;
  final String endTime;
  final String title;
  final String subtitle;
  final String location;
  final ScheduleStatus status;

  ScheduleItem({
    required this.startTime,
    required this.endTime,
    required this.title,
    required this.subtitle,
    required this.location,
    required this.status,
  });
}

enum ScheduleStatus {
  ongoing,
  upcoming,
  future,
}