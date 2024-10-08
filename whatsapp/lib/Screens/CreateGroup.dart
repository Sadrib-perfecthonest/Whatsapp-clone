import 'package:flutter/material.dart';
import 'package:whatsapp/CustomUI/AvtarCard.dart';
import 'package:whatsapp/CustomUI/ContactCard.dart';
import 'package:whatsapp/Model/ChatModel.dart';

class CreateGroup extends StatefulWidget {
  CreateGroup({Key? key}) : super(key: key);

  @override
  _CreateGroupState createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
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
  List<ChatModel> groupmember = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "New Group",
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Add participants",
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
          ],
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Color(0xFF128C7E),
            onPressed: () {},
            child: Icon(Icons.arrow_forward)),
        body: Stack(
          children: [
            ListView.builder(
                itemCount: contacts.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Container(
                      height: groupmember.length > 0 ? 90 : 10,
                    );
                  }
                  return InkWell(
                    onTap: () {
                      setState(() {
                        if (contacts[index - 1].select == true) {
                          groupmember.remove(contacts[index - 1]);
                          contacts[index - 1].select = false;
                        } else {
                          groupmember.add(contacts[index - 1]);
                          contacts[index - 1].select = true;
                        }
                      });
                    },
                    child: ContactCard(
                      contact: contacts[index - 1],
                    ),
                  );
                }),
            groupmember.length > 0
                ? Align(
                    child: Column(
                      children: [
                        Container(
                          height: 75,
                          color: Colors.white,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: contacts.length,
                              itemBuilder: (context, index) {
                                if (contacts[index].select == true)
                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        groupmember.remove(contacts[index]);
                                        contacts[index].select = false;
                                      });
                                    },
                                    child: AvatarCard(
                                      chatModel: contacts[index],
                                    ),
                                  );
                                return Container();
                              }),
                        ),
                        Divider(
                          thickness: 1,
                        ),
                      ],
                    ),
                    alignment: Alignment.topCenter,
                  )
                : Container(),
          ],
        ));
  }
}
