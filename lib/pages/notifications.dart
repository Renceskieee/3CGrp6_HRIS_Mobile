// ignore_for_file: library_prefixes, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  late IO.Socket socket;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  bool isConnected = false;
  List<Map<String, dynamic>> notifications = [];

  @override
  void initState() {
    super.initState();
    _initSocket();
    _initLocalNotifications();
  }

  void _initSocket() {
    socket = IO.io('http://192.168.137.96:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });

    socket.onConnect((_) {
      setState(() => isConnected = true);
    });

    socket.onDisconnect((_) {
      setState(() => isConnected = false);
    });

    socket.on('db_change', (data) {
      final notification = {
        'event': data['event'],
        'payload': data['payload'],
        'time': DateTime.now().toIso8601String(),
      };

      setState(() {
        notifications.insert(0, notification);
      });

      _showLocalNotification(data['event'], data['payload']);
    });
  }

  Future<void> _initLocalNotifications() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidSettings);
    await flutterLocalNotificationsPlugin.initialize(initSettings);
  }

  Future<void> _showLocalNotification(String event, dynamic payload) async {
    final id = DateTime.now().millisecondsSinceEpoch % 100000;

    final AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'db_channel',
      'Database Events',
      channelDescription: 'Notification when the database changes',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: true,
    );

    final title = event == 'added'
        ? 'New Record Added'
        : event == 'updated'
            ? 'Record Updated'
            : event == 'deleted'
                ? 'Record Deleted'
                : 'Database Change';

    final body = event == 'deleted'
        ? 'ID: ${payload['id']}'
        : '${payload['name']} (ID: ${payload['id']})';

    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      NotificationDetails(android: androidDetails),
    );
  }

  @override
  void dispose() {
    socket.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          Icon(
            isConnected ? Icons.cloud_done : Icons.cloud_off,
            color: isConnected ? Colors.green : Colors.red,
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: notifications.isEmpty
          ? const Center(
              child: Text(
                'No notifications yet.\nWaiting for database events...',
                textAlign: TextAlign.center,
              ),
            )
          : ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notif = notifications[index];
                final time = DateTime.parse(notif['time']);
                final event = notif['event'];
                final payload = notif['payload'];

                IconData icon;
                Color iconColor;

                switch (event) {
                  case 'added':
                    icon = Icons.add_circle_outline;
                    iconColor = Colors.green;
                    break;
                  case 'updated':
                    icon = Icons.edit;
                    iconColor = Colors.orange;
                    break;
                  case 'deleted':
                    icon = Icons.delete_outline;
                    iconColor = Colors.red;
                    break;
                  default:
                    icon = Icons.notifications_active;
                    iconColor = Colors.blue;
                }

                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: iconColor.withOpacity(0.1),
                    child: Icon(icon, color: iconColor),
                  ),
                  title: Text(
                    event == 'deleted'
                        ? 'Record Deleted (ID: ${payload['id']})'
                        : '${payload['name']} (ID: ${payload['id']})',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    '${event.toUpperCase()} • ${_formatTime(time)}',
                    style: TextStyle(color: iconColor, fontSize: 12),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            notifications.clear();
          });
        },
        tooltip: 'Clear All',
        child: const Icon(Icons.clear_all),
      ),
    );
  }

  String _formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }
}
