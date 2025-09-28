import 'package:flutter/material.dart';

class ChatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Chats',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildViewedUpdates(),
          Expanded(
            child: _buildContactStatusList(),
          ),
        ],
      ),

    );
  }

  Widget _buildViewedUpdates() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Text(
        'All chats ',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
          color: Colors.grey[600],
        ),
      ),
    );
  }
  
  Widget _buildContactStatusList() {
    final List<ContactStatus> contacts = [
      ContactStatus(
        name: 'USER1',
        masseg: 'Hello',
        imageUrl: '',
        hasUnseen: true,
      ),
      ContactStatus(
        name: 'USER2',
        masseg: 'Hello',
        hasUnseen: false, imageUrl: '',
      ),
      ContactStatus(
        name: 'USER3',
        masseg: 'Hello',
        imageUrl: '',
        hasUnseen: true,
      ),
      ContactStatus(
        name: 'USER4',
        masseg: 'Hello',
        imageUrl: '',
        hasUnseen: false,
      ),
      ContactStatus(
        name: 'USER5',
        masseg: 'Hello',
        imageUrl: '',
        hasUnseen: true,
      ),
    ];

    return ListView.builder(
      itemCount: contacts.length,
      itemBuilder: (context, index) {
        final contact = contacts[index];
        return _buildContactStatusItem(contact);
      },
    );
  }


  Widget _buildContactStatusItem(ContactStatus contact) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: Stack(
          children: [
            Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: contact.hasUnseen ? Colors.green : Colors.grey[400]!,
                  width: 2,
                ),
              ),
              child: CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(contact.imageUrl),
              ),
            ),
          ],
        ),
        title: Text(
          contact.name,
          style: TextStyle(
            fontWeight: contact.hasUnseen ? FontWeight.bold : FontWeight.normal,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          contact.masseg,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
        trailing: contact.hasUnseen
            ? Container(
          child: Icon(Icons.check_outlined),
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
        )
            : null,
        onTap: () {

        },
      ),
    );
  }

  void _showContactStatus(BuildContext context, ContactStatus contact) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(contact.name),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(contact.imageUrl),
            ),
            SizedBox(height: 16),
            Text('Status: ${contact.masseg}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('close'),
          ),
        ],
      ),
    );
  }
}


class ContactStatus {
  final String name;
  final String masseg;
  final String imageUrl;
  final bool hasUnseen;

  ContactStatus({
    required this.name,
    required this.masseg,
    required this.imageUrl,
    required this.hasUnseen,
  });
}
