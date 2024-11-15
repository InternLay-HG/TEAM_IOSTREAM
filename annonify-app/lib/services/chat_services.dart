import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatSocketService extends GetxService {
  late IO.Socket socket;
  final RxList<String> joinedGroups = <String>[].obs;
  String? server = dotenv.env['uri'];

  @override
  void onInit() {
    super.onInit();
    _initializeSocket();
  }

  void _initializeSocket() {
    String userId = "673482cfb9a43a6672046461";

    // Initialize Socket.IO connection with configuration
    socket = IO.io("http://10.0.1.91:8080/", <String, dynamic>{
      'transports': ['websocket'],
      'query': {'userId': userId},
    });

    // Connect to the server
    socket.connect();

    // Listen for connection events
    socket.on('connect', (_) {
      Get.log('Connected to Socket.IO server');
    });

    // Listen for groups the user has joined
    socket.on('joinedGroups', (groups) {
      Get.log('Joined groups: $groups');
      joinedGroups.assignAll(List<String>.from(groups));
    });

    // Listen for incoming messages in a group
    socket.on('newGroupMessage', (data) {
      Get.log('New message in group ${data['group']}: ${data['message']}');
      // Here you could update a chat screen, notify the user, etc.
    });

    // Handle disconnection event
    socket.on('disconnect', (_) {
      Get.log('Disconnected from Socket.IO server');
    });

    // Handle reconnection attempts
    socket.on('reconnect_attempt', (_) {
      Get.log('Attempting to reconnect...');
    });

    // Handle error events
    socket.on('connect_error', (error) {
      Get.log('Connection error: $error');
    });
  }

  // Send a message to a specific group
  void sendMessage(String groupName, String message) {
    print("Sending message to $groupName: $message");

    if (socket.connected) {
      socket.emit('groupMessage', {
        'groupName': groupName,
        'message': message,
      });
      socket.emit('chat_message', message);
      print("Message sent to server successfully");
    } else {
      print("Socket not connected; message not sent");
    }
  }

  @override
  void onClose() {
    socket.disconnect();
    super.onClose();
  }
}
