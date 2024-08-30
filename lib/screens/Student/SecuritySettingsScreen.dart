import 'package:flutter/material.dart';
import 'ChangePasswordScreen.dart';

class SecuritySettingsScreen extends StatefulWidget {
  @override
  _SecuritySettingsScreenState createState() => _SecuritySettingsScreenState();
}

class _SecuritySettingsScreenState extends State<SecuritySettingsScreen> {
  bool isTwoFactorAuthEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Security Settings'),
        backgroundColor: Colors.teal, // Teal color for AppBar
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal.shade200, Colors.teal.shade700],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildListTile(
              context: context,
              title: 'Change Password',
              icon: Icons.lock,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChangePasswordScreen()),
                );
              },
            ),
            _buildDivider(),
            _buildListTile(
              context: context,
              title: 'Enable Two-Factor Authentication (2FA)',
              trailing: Switch(
                value: isTwoFactorAuthEnabled,
                activeColor: Colors.teal, // Teal color for the switch
                onChanged: (bool value) {
                  setState(() {
                    isTwoFactorAuthEnabled = value;
                  });
                },
              ),
              onTap: () {
                // Optional: Add onTap functionality for Switch if needed
              },
            ),
            _buildDivider(),
            _buildListTile(
              context: context,
              title: 'Manage Login Activity',
              icon: Icons.history,
              onTap: () {
                // Handle navigation to login activity screen
              },
            ),
            _buildDivider(),
            _buildListTile(
              context: context,
              title: 'Sign Out of All Devices',
              icon: Icons.logout,
              onTap: () {
                // Handle sign out from all devices
              },
            ),
            _buildDivider(),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile({
    required BuildContext context,
    required String title,
    IconData? icon,
    Widget? trailing,
    required void Function() onTap,
  }) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(16.0),
        leading: icon != null ? Icon(icon, color: Colors.teal.shade700) : null,
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.teal.shade800, // Teal shade for title
          ),
        ),
        trailing: trailing ??
            Icon(Icons.arrow_forward_ios, color: Colors.teal.shade700),
        onTap: onTap,
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      thickness: 1,
      color: Colors.teal.shade200,
    );
  }
}
