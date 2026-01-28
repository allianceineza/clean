import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherHelper {
  /// Launch URL with error handling
  static Future<void> launchURL(BuildContext context, String urlString) async {
    final Uri url = Uri.parse(urlString);
    
    try {
      // Check if the URL can be launched
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        _showErrorDialog(context, urlString);
      }
    } catch (e) {
      _showErrorDialog(context, urlString);
    }
  }

  /// Launch email with error handling
  static Future<void> launchEmail(
    BuildContext context, {
    required String email,
    String? subject,
    String? body,
  }) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      query: _encodeQueryParameters(<String, String>{
        if (subject != null) 'subject': subject,
        if (body != null) 'body': body,
      }),
    );

    try {
      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);
      } else {
        // Fallback: Show dialog with copy option
        _showEmailFallbackDialog(context, email, subject, body);
      }
    } catch (e) {
      _showEmailFallbackDialog(context, email, subject, body);
    }
  }

  /// Launch phone call with error handling
  static Future<void> launchPhone(BuildContext context, String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);

    try {
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri);
      } else {
        _showPhoneFallbackDialog(context, phoneNumber);
      }
    } catch (e) {
      _showPhoneFallbackDialog(context, phoneNumber);
    }
  }

  /// Launch SMS with error handling
  static Future<void> launchSMS(
    BuildContext context, {
    required String phoneNumber,
    String? message,
  }) async {
    final Uri smsUri = Uri(
      scheme: 'sms',
      path: phoneNumber,
      queryParameters: message != null ? {'body': message} : null,
    );

    try {
      if (await canLaunchUrl(smsUri)) {
        await launchUrl(smsUri);
      } else {
        _showSMSFallbackDialog(context, phoneNumber, message);
      }
    } catch (e) {
      _showSMSFallbackDialog(context, phoneNumber, message);
    }
  }

  /// Launch WhatsApp with error handling
  static Future<void> launchWhatsApp(
    BuildContext context, {
    required String phoneNumber,
    String? message,
  }) async {
    // Remove + and spaces from phone number
    final cleanNumber = phoneNumber.replaceAll(RegExp(r'[^\d]'), '');
    final Uri whatsappUri = Uri.parse(
      'https://wa.me/$cleanNumber${message != null ? '?text=${Uri.encodeComponent(message)}' : ''}',
    );

    try {
      if (await canLaunchUrl(whatsappUri)) {
        await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
      } else {
        _showWhatsAppFallbackDialog(context, phoneNumber);
      }
    } catch (e) {
      _showWhatsAppFallbackDialog(context, phoneNumber);
    }
  }

  // Helper method to encode query parameters
  static String? _encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  // Error dialog for general URLs
  static void _showErrorDialog(BuildContext context, String url) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: Icon(Icons.error_outline, color: Colors.orange, size: 50),
        title: Text('Cannot Open Link'),
        content: Text(
          'Unable to open this link. Please make sure you have the appropriate app installed.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  // Email fallback dialog with copy option
  static void _showEmailFallbackDialog(
    BuildContext context,
    String email,
    String? subject,
    String? body,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: Icon(Icons.email_outlined, color: Colors.blue, size: 50),
        title: Text('Email Not Available'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('No email app found. Please send an email to:'),
            SizedBox(height: 12),
            SelectableText(
              email,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue,
                fontSize: 16,
              ),
            ),
            if (subject != null) ...[
              SizedBox(height: 8),
              Text('Subject: $subject', style: TextStyle(fontSize: 12)),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  // Phone fallback dialog
  static void _showPhoneFallbackDialog(BuildContext context, String phoneNumber) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: Icon(Icons.phone_outlined, color: Colors.green, size: 50),
        title: Text('Phone Not Available'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Please call us at:'),
            SizedBox(height: 12),
            SelectableText(
              phoneNumber,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green,
                fontSize: 18,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  // SMS fallback dialog
  static void _showSMSFallbackDialog(
    BuildContext context,
    String phoneNumber,
    String? message,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: Icon(Icons.sms_outlined, color: Colors.purple, size: 50),
        title: Text('SMS Not Available'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('No SMS app found. Please send a message to:'),
            SizedBox(height: 12),
            SelectableText(
              phoneNumber,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.purple,
                fontSize: 18,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  // WhatsApp fallback dialog
  static void _showWhatsAppFallbackDialog(BuildContext context, String phoneNumber) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: Icon(Icons.chat_outlined, color: Colors.green, size: 50),
        title: Text('WhatsApp Not Available'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('WhatsApp is not installed. Please install WhatsApp or contact us at:'),
            SizedBox(height: 12),
            SelectableText(
              phoneNumber,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green,
                fontSize: 18,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}