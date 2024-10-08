import 'package:flutter/material.dart';
import 'package:whatsapp/CustomUI/ButtonCard.dart';
import 'package:whatsapp/CustomUI/ContactCard.dart';
import 'package:whatsapp/Model/ChatModel.dart';
import 'package:whatsapp/Screens/CreateGroup.dart';

class SelectContact extends StatefulWidget {
  SelectContact({Key? key}) : super(key: key);

  @override
  _SelectContactState createState() => _SelectContactState();
}

class _SelectContactState extends State<SelectContact> {
  @override
  Widget build(BuildContext context) {
    List<ChatModel> contacts = [
      ChatModel(
          name: "Dev Stack",
          status: "A full stack developer",
          isGroup: false,
          time: '6.00 am',
          currentMessage: 'Hi',
          icon: '',
          id: 1),
      ChatModel(
          name: "Balram",
          status: "Flutter Developer...........",
          isGroup: false,
          time: '4.00 pm',
          currentMessage: 'yes',
          icon: '',
          id: 10),
      ChatModel(
          name: "Saket",
          status: "Web developer...",
          isGroup: false,
          time: '3.00 am',
          currentMessage: 'are u there',
          icon: '',
          id: 11),
      ChatModel(
          name: "Bhanu Dev",
          status: "App developer....",
          isGroup: true,
          time: '2.00 pm',
          currentMessage: 'Hi',
          icon: '',
          id: 16),
      ChatModel(
          name: "Collins",
          status: "Raect developer..",
          isGroup: false,
          time: '7.00 pm',
          currentMessage: 'dont disturb',
          icon: '',
          id: 13),
      ChatModel(
          name: "Kishor",
          status: "Full Stack Web",
          isGroup: false,
          time: '8.00 am',
          currentMessage: 'bye',
          icon: '',
          id: 4),
      ChatModel(
          name: "Testing1",
          status: "Example work",
          isGroup: false,
          time: '9.00 am',
          currentMessage: 'How are u',
          icon: '',
          id: 23),
      ChatModel(
          name: "Testing2",
          status: "Sharing is caring",
          isGroup: true,
          time: '12.00 pm',
          currentMessage: 'please help',
          icon: '',
          id: 7),
      ChatModel(
          name: "Divyanshu",
          status: ".....",
          isGroup: true,
          time: '2.00 am',
          currentMessage: 'Need a help',
          icon: '',
          id: 6),
      ChatModel(
          name: "Helper",
          status: "Love you Mom Dad",
          isGroup: false,
          time: '3.00 pm',
          currentMessage: 'Your number',
          icon: '',
          id: 5),
      ChatModel(
          name: "Tester",
          status: "I find the bugs",
          isGroup: true,
          time: '4.00 am',
          currentMessage: 'are u there',
          icon: '',
          id: 3),
    ];

    return Scaffold(
        appBar: AppBar(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Select Contact",
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "256 contacts",
                style: TextStyle(
                  fontSize: 13,
                ),
              )
            ],
          ),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.search,
                  size: 26,
                ),
                onPressed: () {}),
            PopupMenuButton<String>(
              padding: EdgeInsets.all(0),
              onSelected: (value) {
                print(value);
              },
              itemBuilder: (BuildContext contesxt) {
                return [
                  PopupMenuItem(
                    child: Text("Invite a friend"),
                    value: "Invite a friend",
                  ),
                  PopupMenuItem(
                    child: Text("Contacts"),
                    value: "Contacts",
                  ),
                  PopupMenuItem(
                    child: Text("Refresh"),
                    value: "Refresh",
                  ),
                  PopupMenuItem(
                    child: Text("Help"),
                    value: "Help",
                  ),
                ];
              },
            ),
          ],
        ),
        body: ListView.builder(
            itemCount: contacts.length + 2,
            itemBuilder: (context, index) {
              if (index == 0) {
                return InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (builder) => CreateGroup()));
                  },
                  child: ButtonCard(
                    icon: Icons.group,
                    name: "New group",
                  ),
                );
              } else if (index == 1) {
                return ButtonCard(
                  icon: Icons.person_add,
                  name: "New contact",
                );
              }
              return ContactCard(
                contact: contacts[index - 2],
              );
            }));
  }
}
