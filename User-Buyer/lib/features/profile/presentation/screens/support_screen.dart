import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';

class SupportMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  SupportMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
  });
}

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  final List<SupportMessage> _messages = [];
  final TextEditingController _inputController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  
  bool _isBotTyping = false;
  List<String> _currentQuickOptions = [];

  // Common colors
  final Color darkTeal = const Color(0xFF042F2C);
  final Color limeGreen = const Color(0xFFBEF264);

  @override
  void initState() {
    super.initState();
    // Pre-populate with welcome message from bot
    _messages.add(
      SupportMessage(
        text: "Hello! Welcome to ZRent Customer Support. I am your automated assistant. How can I help you today?",
        isUser: false,
        timestamp: DateTime.now(),
      ),
    );
    _currentQuickOptions = [
      "How does ZRent work?",
      "I have an issue with an agent",
      "I have an issue with a payment",
      "Talk to a human"
    ];
  }

  @override
  void dispose() {
    _inputController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
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

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;

    final userMessage = SupportMessage(
      text: text,
      isUser: true,
      timestamp: DateTime.now(),
    );

    setState(() {
      _messages.add(userMessage);
      _inputController.clear();
      _currentQuickOptions = []; // Clear options when user inputs custom text
      _isBotTyping = true;
    });
    _scrollToBottom();

    // Trigger bot reply
    _simulateBotReply(text);
  }

  void _selectQuickOption(String option) {
    final userMessage = SupportMessage(
      text: option,
      isUser: true,
      timestamp: DateTime.now(),
    );

    setState(() {
      _messages.add(userMessage);
      _currentQuickOptions = [];
      _isBotTyping = true;
    });
    _scrollToBottom();

    _simulateBotReply(option);
  }

  void _simulateBotReply(String userQuery) {
    String cleanQuery = userQuery.toLowerCase().trim();
    
    // Simulate thinking delay
    Timer(const Duration(milliseconds: 1200), () {
      if (!mounted) return;

      String botResponse = "";
      List<String> nextOptions = [];

      if (cleanQuery.contains("how does zrent work") || cleanQuery.contains("work")) {
        botResponse = "ZRent is a modern house rental platform that protects both tenants and agents. We feature verified listings, online escrow payments to prevent fraud, and virtual agreement signings. You can browse properties, pay securely, and manage your tenancy in one place!";
        nextOptions = ["What is escrow?", "How do I sign agreements?", "Back to main menu"];
      } else if (cleanQuery.contains("escrow")) {
        botResponse = "With our Escrow System, your rent payment is held securely by ZRent and is only released to the agent/owner after you successfully move into the property and confirm everything is as listed. This prevents rental deposit scams.";
        nextOptions = ["Back to main menu"];
      } else if (cleanQuery.contains("agreements") || cleanQuery.contains("sign")) {
        botResponse = "Once an agent accepts your request, our platform generates a legal digital tenancy agreement. Both you and the agent can review and sign the agreement directly inside the app before making the escrow payment.";
        nextOptions = ["Back to main menu"];
      } else if (cleanQuery.contains("agent")) {
        botResponse = "We take agent conduct very seriously. If an agent is acting unprofessionally, misrepresenting a listing, or committing fraud, please let us know. Could you select the category of the issue?";
        nextOptions = ["Agent requested offline payment", "Listing details were false", "Agent was unreachable", "Back to main menu"];
      } else if (cleanQuery.contains("offline payment")) {
        botResponse = "CRITICAL WARNING: Never pay agents outside the ZRent platform. Payments made offline are not covered by our escrow protection and are highly susceptible to scams. Please report the agent's name to us so we can lock their account.";
        nextOptions = ["Talk to a human", "Back to main menu"];
      } else if (cleanQuery.contains("false") || cleanQuery.contains("misrepresent")) {
        botResponse = "If a property listing contains false information or differs drastically from reality, do not sign or complete payment. Let us know immediately and we will investigate the listing and refund your application fees if applicable.";
        nextOptions = ["Talk to a human", "Back to main menu"];
      } else if (cleanQuery.contains("unreachable")) {
        botResponse = "If an agent is unresponsive for more than 48 hours after you applied, you can cancel your application in your dashboard to receive an immediate refund of your deposit.";
        nextOptions = ["Back to main menu"];
      } else if (cleanQuery.contains("payment") || cleanQuery.contains("money") || cleanQuery.contains("charge") || cleanQuery.contains("refund")) {
        botResponse = "Payment issues are our top priority. Please select the category of your payment issue so we can assist you immediately:";
        nextOptions = ["Failed transaction / Double charge", "How to request a refund", "Escrow release status", "Back to main menu"];
      } else if (cleanQuery.contains("failed") || cleanQuery.contains("charge") || cleanQuery.contains("double")) {
        botResponse = "If your payment failed but you were debited, don't worry! Banks typically reverse failed transactions automatically within 24 to 48 hours. If the funds do not return, please send us the bank transaction receipt and our billing team will verify it immediately.";
        nextOptions = ["Talk to a human", "Back to main menu"];
      } else if (cleanQuery.contains("how to request a refund") || cleanQuery.contains("request a refund")) {
        botResponse = "Refunds are fully supported before you confirm the keys and move-in. To request a refund, go to your Rent details, click 'Cancel & Refund', and select the reason. The funds will be returned to your original payment method in 3-5 business days.";
        nextOptions = ["Back to main menu"];
      } else if (cleanQuery.contains("release status")) {
        botResponse = "Your escrow payment is held securely and only released to the agent/owner 24 hours after your move-in date, provided you do not raise a dispute. This gives you time to verify the property's condition.";
        nextOptions = ["Back to main menu"];
      } else if (cleanQuery.contains("human") || cleanQuery.contains("talk") || cleanQuery.contains("person")) {
        botResponse = "Understood. I am connecting you to an active support agent now. Please hold on for a moment...";
        nextOptions = [];
        
        // Extra delay to simulate a human joining
        Timer(const Duration(milliseconds: 2000), () {
          if (!mounted) return;
          setState(() {
            _messages.add(
              SupportMessage(
                text: "Support Agent 'Sarah' has joined the chat.",
                isUser: false,
                timestamp: DateTime.now(),
              ),
            );
            _messages.add(
              SupportMessage(
                text: "Hi Bessie! I see you need assistance. How can I help you today?",
                isUser: false,
                timestamp: DateTime.now(),
              ),
            );
            _isBotTyping = false;
          });
          _scrollToBottom();
        });
        
        setState(() {
          _messages.add(
            SupportMessage(
              text: botResponse,
              isUser: false,
              timestamp: DateTime.now(),
            ),
          );
        });
        _scrollToBottom();
        return;
      } else if (cleanQuery.contains("menu") || cleanQuery.contains("back")) {
        botResponse = "Returning to main menu. What else can I help you with?";
        nextOptions = [
          "How does ZRent work?",
          "I have an issue with an agent",
          "I have an issue with a payment",
          "Talk to a human"
        ];
      } else {
        botResponse = "I'm sorry, I didn't quite catch that. Please select one of our quick help categories or type 'talk to a human' to speak with a representative.";
        nextOptions = [
          "How does ZRent work?",
          "I have an issue with an agent",
          "I have an issue with a payment",
          "Talk to a human"
        ];
      }

      setState(() {
        _messages.add(
          SupportMessage(
            text: botResponse,
            isUser: false,
            timestamp: DateTime.now(),
          ),
        );
        _currentQuickOptions = nextOptions;
        _isBotTyping = false;
      });
      _scrollToBottom();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: darkTeal),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: darkTeal.withOpacity(0.08),
              child: Icon(Icons.support_agent, color: darkTeal, size: 22),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ZRent Support Bot',
                  style: GoogleFonts.poppins(
                    color: Colors.black87,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  _isBotTyping ? 'Typing...' : 'Online',
                  style: GoogleFonts.poppins(
                    color: _isBotTyping ? Colors.grey : Colors.green,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Chat messages list
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(20),
              physics: const BouncingScrollPhysics(),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                final isSarahNotification = msg.text.contains("has joined the chat");
                
                if (isSarahNotification) {
                  return Center(
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 12),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        msg.text,
                        style: GoogleFonts.poppins(
                          color: Colors.grey.shade700,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                }

                return _buildMessageBubble(msg);
              },
            ),
          ),

          // Typing Indicator
          if (_isBotTyping)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 14,
                    backgroundColor: darkTeal.withOpacity(0.05),
                    child: Icon(Icons.support_agent, color: darkTeal, size: 14),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(16),
                        bottomLeft: Radius.circular(4),
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildTypingDot(0),
                        _buildTypingDot(150),
                        _buildTypingDot(300),
                      ],
                    ),
                  ),
                ],
              ),
            ),

          // Quick Options Chips
          if (_currentQuickOptions.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              color: Colors.transparent,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Row(
                  children: _currentQuickOptions.map((option) {
                    final isEscalate = option.contains("human");
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ActionChip(
                        label: Text(
                          option,
                          style: GoogleFonts.poppins(
                            color: isEscalate ? Colors.white : darkTeal,
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        backgroundColor: isEscalate ? Colors.red.shade400 : Colors.white,
                        side: BorderSide(
                          color: isEscalate ? Colors.red.shade400 : darkTeal.withOpacity(0.3),
                          width: 1,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        onPressed: () => _selectQuickOption(option),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),

          // Message Input Field
          Container(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 10,
              bottom: MediaQuery.of(context).padding.bottom + 12,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey.shade200, width: 1)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      controller: _inputController,
                      style: GoogleFonts.poppins(fontSize: 14),
                      decoration: InputDecoration(
                        hintText: "Type a message...",
                        hintStyle: GoogleFonts.poppins(color: Colors.grey.shade400, fontSize: 14),
                        border: InputBorder.none,
                      ),
                      onSubmitted: _sendMessage,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                CircleAvatar(
                  backgroundColor: darkTeal,
                  radius: 22,
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white, size: 18),
                    onPressed: () => _sendMessage(_inputController.text),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(SupportMessage msg) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: msg.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!msg.isUser) ...[
            CircleAvatar(
              radius: 16,
              backgroundColor: darkTeal.withOpacity(0.08),
              child: Icon(Icons.support_agent, color: darkTeal, size: 16),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: msg.isUser ? darkTeal : Colors.white,
                border: msg.isUser ? null : Border.all(color: Colors.grey.shade200),
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: msg.isUser ? const Radius.circular(16) : const Radius.circular(4),
                  bottomRight: msg.isUser ? const Radius.circular(4) : const Radius.circular(16),
                ),
              ),
              child: Text(
                msg.text,
                style: GoogleFonts.poppins(
                  color: msg.isUser ? Colors.white : Colors.black87,
                  fontSize: 14,
                  height: 1.4,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          if (msg.isUser) ...[
            const SizedBox(width: 8),
            CircleAvatar(
              radius: 16,
              backgroundImage: const AssetImage('assets/images/profile_placeholder.png'),
              backgroundColor: Colors.grey.shade300,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTypingDot(int delayMs) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      width: 6,
      height: 6,
      decoration: BoxDecoration(
        color: darkTeal.withOpacity(0.6),
        shape: BoxShape.circle,
      ),
    );
  }
}
