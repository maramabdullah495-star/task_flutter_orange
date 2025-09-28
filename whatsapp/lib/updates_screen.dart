import 'package:flutter/material.dart';
class UpdatesScreen extends StatelessWidget {
  const UpdatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Status',
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

          _buildMyStatus(),




          _buildViewedUpdates(),


          Expanded(
            child: _buildContactStatusList(),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {

            },
            child: Icon(Icons.camera_alt),
            mini: true,
            backgroundColor: Colors.grey[300],
            foregroundColor: Colors.black,
          ),
          SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () {

            },
            child: Icon(Icons.edit),
            backgroundColor: Colors.blue,
          ),
        ],
      ),
    );
  }

  Widget _buildMyStatus() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          Stack(
            children: [

              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.green,
                    width: 3,
                  ),
                ),
                child: CircleAvatar(
                  radius: 32,
                  backgroundColor: Colors.black,
                ),
              ),

              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'My status',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Just now',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }



  Widget _buildViewedUpdates() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Text(
        'Viewed updates',
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
        time: '7 minutes ago',
        imageUrl: '',
        hasUnseen: true,
      ),
      ContactStatus(
        name: 'USER2',
        time: '8 minutes ago',
        hasUnseen: false, imageUrl: '',
      ),
      ContactStatus(
        name: 'USER3',
        time: '25 minutes ago',
        imageUrl: '',
        hasUnseen: true,
      ),
      ContactStatus(
        name: 'USER4',
        time: '1 hour ago',
        imageUrl: '',
        hasUnseen: false,
      ),
      ContactStatus(
        name: 'USER5',
        time: '2 hours ago',
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
          contact.time,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
        trailing: contact.hasUnseen
            ? Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: Colors.green,
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
            Text('Status: ${contact.time}'),
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
  final String time;
  final String imageUrl;
  final bool hasUnseen;

  ContactStatus({
    required this.name,
    required this.time,
    required this.imageUrl,
    required this.hasUnseen,
  });
}