import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView(
          children: const <Widget>[
            SectionTitle(title: 'General'),
            SettingsCard(title: 'Language', icon: Icons.arrow_forward_ios),
            SectionTitle(title: 'Information'),
            SettingsCard(title: 'App Version', subtitle: '1.0.0'),
            SettingsCard(title: 'Official Website', icon: Icons.open_in_new),
            SettingsCard(title: 'Privacy Policy', icon: Icons.open_in_new),
            SettingsCard(title: 'Contact', icon: Icons.open_in_new),
          ],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }
}

class SettingsCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? icon;
  const SettingsCard({
    required this.title,
    this.subtitle,
    this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(fontSize: 14.0, color: Colors.black87),
        ),
        subtitle: subtitle != null
            ? Text(
                subtitle!,
                style: const TextStyle(fontSize: 12.0, color: Colors.black54),
              )
            : null,
        trailing: icon != null
            ? Icon(icon, size: 18.0, color: Colors.black54)
            : null,
        onTap: () {},
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0,
        ),
      ),
    );
  }
}
