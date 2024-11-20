import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService extends GetxController {
  late IO.Socket socket;
  var messages = <Map<String, dynamic>>[].obs;

  String? server = dotenv.env['server'];

  // Initialize Socket.IO connection
  void connectToSocket(String userId, String groupId) {
    socket = IO.io(server, {
      'transports': ['websocket'],
      'query': {
        'userId': userId,
        'groupId': groupId,
      },
    });
    print("Connecting to socket...");

    // Listen for incoming messages and update all connected users
    socket.on('chat message', (data) {
      messages.add(data); // Add new message to the list
      update(); // Update UI for all clients connected
    });

    // Listen for previous messages
    socket.on('previous messages', (data) {
      messages.assignAll(
          List<Map<String, dynamic>>.from(data)); // Assign previous messages
      update(); // Update UI for all clients connected
    });

    socket.connect();
  }

  void joinGroup(String groupId) {
    socket.emit('join group', groupId);
  }

  // Send a new message and broadcast it to all other connected users
  void sendMessage(String content, String userId, String groupId) {
    final messageData = {
      'content': content,
      'user': {
        '_id': userId,
      },
      'group': {
        '_id': groupId,
      },
      'timestamp': DateTime.now().toIso8601String(),
    };
    socket.emit('chat message', messageData); // Emit the message to the server
  }

  @override
  void onClose() {
    socket
        .disconnect(); // Ensure to disconnect when the service is no longer needed
    super.onClose();
  }
}
