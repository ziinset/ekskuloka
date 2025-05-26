import 'package:flutter/material.dart';
import '../../presensi/views/presensi_view.dart';
import '../../akun/views/akun_view.dart';

class KomunitasView extends StatefulWidget {
  const KomunitasView({Key? key}) : super(key: key);

  @override
  State<KomunitasView> createState() => _KomunitasViewState();
}

class _KomunitasViewState extends State<KomunitasView> with TickerProviderStateMixin {
  int _selectedIndex = 1; // Index 1 untuk komunitas
  List<Community> communities = [
    Community(
      id: '1',
      name: 'Paduan Suara',
      description: 'Bersama membangun harmoni!',
      members: 3,
      color: const Color(0xFF2DB5A5),
      icon: Icons.music_note,
      lastMessage: 'Kamu: Boleh! 😊',
      lastMessageTime: '12.12',
      unreadCount: 0,
    ),
    Community(
      id: '2',
      name: 'Basket',
      description: 'Dalam tubuh yang sehat, terdapat jiwa yang kuat',
      members: 3,
      color: const Color(0xFF2DB5A5),
      icon: Icons.sports_basketball,
      lastMessage: 'Edward: Lapangan Sampo aja luas',
      lastMessageTime: '10.14',
      unreadCount: 2,
    ),
  ];

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
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Komunitas',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 36), // Balance the back button
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(20, 25, 20, 20),
                      child: Text(
                        'Komunitas Anda',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                    ),

                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: communities.length,
                        itemBuilder: (context, index) {
                          final community = communities[index];
                          return _buildCommunityCard(community);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // Bottom Navigation Bar (sama seperti di home)
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
              onTap: () => Navigator.pop(context),
            ),
            _buildNavItem(
              icon: Icons.groups_outlined,
              label: 'Komunitas',
              isActive: _selectedIndex == 1,
              onTap: () => setState(() => _selectedIndex = 1),
            ),
            // Center QR Scanner Button
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PresensiView(),
                ),
              ),
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
              onTap: () {
                setState(() => _selectedIndex = 2);
                Navigator.pushNamed(context, '/jadwal');
              },
            ),
            _buildNavItem(
              icon: Icons.person_outline,
              label: 'Akun',
              isActive: _selectedIndex == 3,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AkunView()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCommunityCard(Community community) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: community.color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: community.color.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          // Community Header
          Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: community.color,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    community.icon,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        community.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        community.description,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Chat Preview Section
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatView(community: community),
              ),
            ),
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 15, 20, 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: community.color,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.chat,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'General',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          community.lastMessage,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[600],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        community.lastMessageTime,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[500],
                        ),
                      ),
                      if (community.unreadCount > 0) ...[
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: community.color,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            community.unreadCount.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
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

// Model untuk Community
class Community {
  final String id;
  final String name;
  final String description;
  final int members;
  final Color color;
  final IconData icon;
  final String lastMessage;
  final String lastMessageTime;
  final int unreadCount;

  Community({
    required this.id,
    required this.name,
    required this.description,
    required this.members,
    required this.color,
    required this.icon,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.unreadCount,
  });
}

// Halaman Chat Detail
class ChatView extends StatefulWidget {
  final Community community;

  const ChatView({Key? key, required this.community}) : super(key: key);

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final TextEditingController _messageController = TextEditingController();
  List<ChatMessage> messages = [];

  @override
  void initState() {
    super.initState();
    _loadInitialMessages();
  }

  void _loadInitialMessages() {
    if (widget.community.name == 'Paduan Suara') {
      messages = [
        ChatMessage(
          id: '1',
          sender: 'You',
          message: 'Hai!',
          time: '10:11',
          isMe: true,
        ),
        ChatMessage(
          id: '2',
          sender: 'You',
          message: 'Kita mau coba latihan dimana?',
          time: '10:11',
          isMe: true,
        ),
        ChatMessage(
          id: '3',
          sender: 'David Wayne',
          message: 'Lapangan Sampo?',
          time: '10:11',
          isMe: false,
        ),
        ChatMessage(
          id: '4',
          sender: 'Edward Davidson',
          message: 'Kalo di KopiStudio gimana?',
          time: '10:14',
          isMe: false,
        ),
        ChatMessage(
          id: '5',
          sender: 'You',
          message: 'Boleh!',
          time: '10:16',
          isMe: true,
        ),
      ];
    } else {
      messages = [
        ChatMessage(
          id: '1',
          sender: 'You',
          message: 'Hai!',
          time: '10:11',
          isMe: true,
        ),
        ChatMessage(
          id: '2',
          sender: 'You',
          message: 'Kita mau coba latihan dimana?',
          time: '10:11',
          isMe: true,
        ),
        ChatMessage(
          id: '3',
          sender: 'David Wayne',
          message: 'Lapangan ub?',
          time: '10:11',
          isMe: false,
        ),
        ChatMessage(
          id: '4',
          sender: 'Edward Davidson',
          message: 'Lapangan Sampo aja luas',
          time: '10:14',
          isMe: false,
        ),
      ];
    }
  }

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      setState(() {
        messages.add(
          ChatMessage(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            sender: 'You',
            message: _messageController.text.trim(),
            time: _formatTime(TimeOfDay.now()),
            isMe: true,
          ),
        );
      });
      _messageController.clear();
    }
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: widget.community.color,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                widget.community.icon,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.community.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  '${widget.community.members} members online',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.videocam, color: Colors.black54),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.call, color: Colors.black54),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black54),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return _buildChatBubble(messages[index]);
              },
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildChatBubble(ChatMessage message) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment:
            message.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          if (!message.isMe && messages.indexOf(message) > 0 &&
              messages[messages.indexOf(message) - 1].sender != message.sender)
            Padding(
              padding: const EdgeInsets.only(bottom: 4, left: 50),
              child: Text(
                message.sender,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

          Row(
            mainAxisAlignment:
                message.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (!message.isMe) ...[
                CircleAvatar(
                  radius: 16,
                  backgroundColor: widget.community.color.withOpacity(0.2),
                  child: Text(
                    message.sender.split(' ').map((e) => e[0]).join(),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: widget.community.color,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
              ],

              Flexible(
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: message.isMe
                        ? const Color(0xFF2DB5A5)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    message.message,
                    style: TextStyle(
                      fontSize: 14,
                      color: message.isMe ? Colors.white : Colors.black87,
                    ),
                  ),
                ),
              ),
            ],
          ),

          Padding(
            padding: EdgeInsets.only(
              top: 4,
              left: message.isMe ? 0 : 50,
              right: message.isMe ? 0 : 50,
            ),
            child: Row(
              mainAxisAlignment:
                  message.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
              children: [
                Text(
                  message.time,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey[500],
                  ),
                ),
                if (message.isMe) ...[
                  const SizedBox(width: 4),
                  Icon(
                    Icons.done_all,
                    size: 14,
                    color: Colors.grey[500],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.grey[600]),
            onPressed: () {},
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(25),
              ),
              child: TextField(
                controller: _messageController,
                decoration: const InputDecoration(
                  hintText: 'Ketik Pesanmu',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                onSubmitted: (_) => _sendMessage(),
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: _sendMessage,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Color(0xFF2DB5A5),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.send,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Model untuk Chat Message
class ChatMessage {
  final String id;
  final String sender;
  final String message;
  final String time;
  final bool isMe;

  ChatMessage({
    required this.id,
    required this.sender,
    required this.message,
    required this.time,
    required this.isMe,
  });
}