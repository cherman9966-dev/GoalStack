import 'package:flutter/material.dart';

class AccountSupportSection extends StatelessWidget {
  const AccountSupportSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Account & Support',
          style: TextStyle(
            color: Colors.black,
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        _buildSettingsListTile(
          icon: Icons.email_outlined,
          title: 'Link Email Account',
          subtitle: 'Protect your data',
          onTap: () {
            // Перехід на екран підключення пошти
          },
        ),
        _buildSettingsListTile(
          icon: Icons.help_outline,
          title: 'Help & Support',
          subtitle: 'FAQ and contact',
          onTap: () {},
        ),
        _buildSettingsListTile(
          icon: Icons.privacy_tip_outlined,
          title: 'Privacy Policy',
          subtitle: null,
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildSettingsListTile({
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.05),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.black),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: TextStyle(color: Colors.black.withOpacity(0.5)),
            )
          : null,
      trailing: const Icon(Icons.chevron_right, color: Colors.black54),
      onTap: onTap,
    );
  }
}
