import 'package:flutter/material.dart';
import 'package:betakety_app/model/notification_model.dart';

class NotificationItem extends StatelessWidget {
  final NotificationModel item;

  const NotificationItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  String _formatDate(DateTime d) {
    return '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')} '
        '${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: _buildIcon(),
        title:Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // crossAxisAlignment: CrossAxisAlignment.s,
          children: [
            // const SizedBox(height: 4),
            Text(
              item.title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 4),
            _buildTypeChip(item.type!),

          ],
        ),

        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.body,
                style: TextStyle(
                  color: Colors.grey.shade700,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                _formatDate(item.date),
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildTypeChip(String type) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: _typeColor(type).withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        type.toUpperCase(),
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: _typeColor(type),
        ),
      ),
    );
  }

  Color _typeColor(String type) {
    switch (type) {
      case 'order':
        return Colors.green;
      case 'salary':
        return Colors.orange;
      case 'attendance':
        return Colors.blue;
      case 'system':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Widget _buildIcon() {
    return CircleAvatar(
      radius: 22,
      backgroundColor: Colors.blue.withOpacity(0.1),
      child: item.iconAsset.isNotEmpty
          ? Image.asset(
        item.iconAsset,
        width: 22,
        height: 22,
        errorBuilder: (_, __, ___) =>
        const Icon(Icons.notifications, color: Colors.blue),
      )
          : const Icon(Icons.notifications, color: Colors.blue),
    );
  }
}
