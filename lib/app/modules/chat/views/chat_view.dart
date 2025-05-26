import 'package:flutter/material.dart';

class ChatView extends StatefulWidget {
  final CommunityItem community;

  const ChatView({Key? key, required this.community}) : super(key: key);

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<ChatMessage> messages = [];

  @override
  void initState() {
    super.initState();
    _initializeMessages();
  }

  void _initializeMessages() {
    // Sample messages based on mockup
    messages = [
      ChatMessage(
        text: 'Hai!',
        isMe: true,
        time: '10:10',
        sender: 'You',
      ),
      ChatMessage(
        text: 'Kita mau coba latihan dimana?',
        isMe: true,
        time: '10:11',
        sender: 'You',
      ),
      ChatMessage(
        text: 'Lapangan Sampo?',
        isMe: false,
        time: '10:11',
        sender: 'David Wayne',
        avatar: 'assets/images/david.png',
      ),
      ChatMessage(
        text: widget.community.name == 'Basket'
            ? 'Lapangan Sampo aja luas'
            : 'Kalo di KopiStudio gimana?',
        isMe: false,
        time: '10:14',
        sender: 'Edward Davidson',
        avatar: 'assets/images/edward.png',
      ),
      if (widget.community.name == 'Paduan Suara')
        ChatMessage(
          text: 'Boleh!',
          isMe: true,
          time: '10:16',
          sender: 'You',
        ),
    ];

    // Add unread messages indicator for Basket community
    if (widget.community.name == 'Basket' && widget.community.unreadCount > 0) {
      messages.insert(messages.length - 1, ChatMessage(
        text: '2 Pesan Belum Terbaca',
        isMe: false,
        time: '',
        sender: '',
        isUnreadIndicator: true,
      ));
    }
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
                color: const Color(0xFF2DB5A5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  widget.community.image,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.groups,
                      color: Colors.white,
                      size: 20,
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.community.name,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '${widget.community.members} members online',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.videocam_outlined, color: Colors.grey[700]),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.call_outlined, color: Colors.grey[700]),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.grey[700]),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Messages
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];

                if (message.isUnreadIndicator) {
                  return _buildUnreadIndicator();
                }

                return _buildMessage(message);
              },
            ),
          ),

          // Message Input
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2DB5A5),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
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
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                      ),
                      onSubmitted: _sendMessage,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: () => _sendMessage(_messageController.text),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2DB5A5),
                      borderRadius: BorderRadius.circular(25),
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
          ),
        ],
      ),
    );
  }

  Widget _buildMessage(ChatMessage message) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: message.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!message.isMe) ...[
            // Avatar for other users
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: Image.asset(
                  message.avatar ?? 'assets/images/default_avatar.png',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.person,
                      color: Colors.grey[600],
                      size: 20,
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: 8),
          ],

          // Message bubble
          Flexible(
            child: Column(
              crossAxisAlignment: message.isMe
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                if (!message.isMe && message.sender.isNotEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.only(left: 12, bottom: 4),
                    child: Text(
                      message.sender,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: message.isMe
                        ? const Color(0xFF2DB5A5)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(20).copyWith(
                      bottomLeft: message.isMe
                          ? const Radius.circular(20)
                          : const Radius.circular(4),
                      bottomRight: message.isMe
                          ? const Radius.circular(4)
                          : const Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    message.text,
                    style: TextStyle(
                      color: message.isMe ? Colors.white : Colors.black87,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                if (message.time.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Padding(
                    padding: EdgeInsets.only(
                      left: message.isMe ? 0 : 12,
                      right: message.isMe ? 12 : 0,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
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
              ],
            ),
          ),

          if (message.isMe) ...[
            const SizedBox(width: 8),
            const SizedBox(width: 32), // Space for alignment
          ],
        ],
      ),
    );
  }

  Widget _buildUnreadIndicator() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 1,
              color: Colors.grey[300],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '2 Pesan Belum Terbaca',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 1,
              color: Colors.grey[300],
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;

    setState(() {
      messages.add(ChatMessage(
        text: text.trim(),
        isMe: true,
        time: TimeOfDay.now().format(context),
        sender: 'You',
      ));
    });

    _messageController.clear();

    // Auto scroll to bottom
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}

class ChatMessage {
  final String text;
  final bool isMe;
  final String time;
  final String sender;
  final String? avatar;
  final bool isUnreadIndicator;

  ChatMessage({
    required this.text,
    required this.isMe,
    required this.time,
    required this.sender,
    this.avatar,
    this.isUnreadIndicator = false,
  });
}

// CommunityItem class definition (if not already defined elsewhere)
class CommunityItem {
  final String name;
  final String description;
  final String image;
  final int members;
  final bool isLarge;
  final String lastMessage;
  final String lastTime;
  final int unreadCount;

  CommunityItem({
    required this.name,
    required this.description,
    required this.image,
    required this.members,
    required this.isLarge,
    required this.lastMessage,
    required this.lastTime,
    required this.unreadCount,
  });
}