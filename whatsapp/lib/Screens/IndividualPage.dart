import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:whatsapp/CustomUI/OwnMessgaeCrad.dart';
import 'package:whatsapp/CustomUI/ReplyCard.dart';
import 'package:whatsapp/Model/ChatModel.dart';
import 'package:whatsapp/Model/MessageModel.dart';

class IndividualPage extends StatefulWidget {
  IndividualPage({Key? key, required this.chatModel, required this.sourchat})
      : super(key: key);
  final ChatModel chatModel;
  final ChatModel sourchat;

  @override
  _IndividualPageState createState() => _IndividualPageState();
}

class _IndividualPageState extends State<IndividualPage> {
  bool showEmojiPicker = false;
  FocusNode focusNode = FocusNode();
  bool sendButton = false;
  List<MessageModel> messages = [];
  TextEditingController _controller = TextEditingController();
  ScrollController _scrollController = ScrollController();
  late IO.Socket socket;

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          showEmojiPicker = false;
        });
      }
    });
    connect();
  }

  void connect() {
    socket = IO.io("http://192.168.0.101:3000", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket.connect();
    socket.emit("signin", widget.sourchat.id);
    socket.onConnect((data) {
      socket.on("message", (msg) {
        setMessage("destination", msg["message"]);
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    });
  }

  void sendMessage(String message, int sourceId, int targetId) {
    setMessage("source", message);
    socket.emit("message", {
      "message": message,
      "sourceId": sourceId,
      "targetId": targetId,
    });
  }

  void setMessage(String type, String message) {
    MessageModel messageModel = MessageModel(
        type: type,
        message: message,
        time: DateTime.now().toString().substring(10, 16));
    setState(() {
      messages.add(messageModel);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/whatsapp_Back.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: AppBar(
              leadingWidth: 70,
              titleSpacing: 0,
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.arrow_back, size: 24),
                    CircleAvatar(
                      child: SvgPicture.asset(
                        widget.chatModel.isGroup
                            ? "assets/groups.svg"
                            : "assets/person.svg",
                        color: Colors.white,
                        height: 36,
                        width: 36,
                      ),
                      radius: 20,
                      backgroundColor: Colors.blueGrey,
                    ),
                  ],
                ),
              ),
              title: InkWell(
                onTap: () {},
                child: Container(
                  margin: EdgeInsets.all(6),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.chatModel.name,
                        style: TextStyle(
                          fontSize: 18.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "last seen today at 12:05",
                        style: TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                IconButton(icon: Icon(Icons.videocam), onPressed: () {}),
                IconButton(icon: Icon(Icons.call), onPressed: () {}),
                PopupMenuButton<String>(
                  padding: EdgeInsets.all(0),
                  onSelected: (value) {
                    print(value);
                  },
                  itemBuilder: (BuildContext contesxt) {
                    return [
                      PopupMenuItem(
                        child: Text("View Contact"),
                        value: "View Contact",
                      ),
                      PopupMenuItem(
                        child: Text("Media, links, and docs"),
                        value: "Media, links, and docs",
                      ),
                      PopupMenuItem(
                        child: Text("Whatsapp Web"),
                        value: "Whatsapp Web",
                      ),
                      PopupMenuItem(
                        child: Text("Search"),
                        value: "Search",
                      ),
                      PopupMenuItem(
                        child: Text("Mute Notification"),
                        value: "Mute Notification",
                      ),
                      PopupMenuItem(
                        child: Text("Wallpaper"),
                        value: "Wallpaper",
                      ),
                    ];
                  },
                ),
              ],
            ),
          ),
          body: WillPopScope(
            onWillPop: () {
              if (showEmojiPicker) {
                setState(() {
                  showEmojiPicker = false;
                });
                return Future.value(false);
              } else {
                Navigator.pop(context);
                return Future.value(true);
              }
            },
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    controller: _scrollController,
                    itemCount: messages.length + 1,
                    itemBuilder: (context, index) {
                      if (index == messages.length) {
                        return Container(height: 70);
                      }
                      if (messages[index].type == "source") {
                        return OwnMessageCard(
                          message: messages[index].message,
                          time: messages[index].time,
                        );
                      } else {
                        return ReplyCard(
                          message: messages[index].message,
                          time: messages[index].time,
                        );
                      }
                    },
                  ),
                ),
                _buildMessageInput(),
                showEmojiPicker ? _buildEmojiPicker() : Container(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMessageInput() {
    return Container(
      height: 70,
      child: Row(
        children: [
          Expanded(
            child: Card(
              margin: EdgeInsets.only(left: 2, right: 2, bottom: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              child: TextFormField(
                controller: _controller,
                focusNode: focusNode,
                textAlignVertical: TextAlignVertical.center,
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                minLines: 1,
                onChanged: (value) {
                  if (value.length > 0) {
                    setState(() {
                      sendButton = true;
                    });
                  } else {
                    setState(() {
                      sendButton = false;
                    });
                  }
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Type a message",
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: IconButton(
                    icon: Icon(
                      showEmojiPicker
                          ? Icons.keyboard
                          : Icons.emoji_emotions_outlined,
                    ),
                    onPressed: () {
                      if (!showEmojiPicker) {
                        focusNode.unfocus();
                        focusNode.canRequestFocus = false;
                      }
                      setState(() {
                        showEmojiPicker = !showEmojiPicker;
                      });
                    },
                  ),
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.attach_file),
                        onPressed: () {
                          showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (builder) => bottomSheet(),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.camera_alt),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  contentPadding: EdgeInsets.all(5),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 8,
              right: 2,
              left: 2,
            ),
            child: CircleAvatar(
              radius: 25,
              backgroundColor: Color(0xFF128C7E),
              child: IconButton(
                icon: Icon(
                  sendButton ? Icons.send : Icons.mic,
                  color: Colors.white,
                ),
                onPressed: () {
                  if (sendButton) {
                    sendMessage(
                      _controller.text,
                      widget.sourchat.id,
                      widget.chatModel.id,
                    );
                    _controller.clear();
                    setState(() {
                      sendButton = false;
                    });
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmojiPicker() {
    return SizedBox(
      height: 250,
      child: EmojiPicker(
        onEmojiSelected: (emoji, category) {
          setState(() {
            _controller.text = _controller.text + emoji.toString();
          });
        },
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 278,
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: EdgeInsets.all(18),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _iconCreation(
                      Icons.insert_drive_file, Colors.indigo, "Document"),
                  SizedBox(width: 40),
                  _iconCreation(Icons.camera_alt, Colors.pink, "Camera"),
                  SizedBox(width: 40),
                  _iconCreation(Icons.insert_photo, Colors.purple, "Gallery"),
                ],
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _iconCreation(Icons.headset, Colors.orange, "Audio"),
                  SizedBox(width: 40),
                  _iconCreation(Icons.location_pin, Colors.teal, "Location"),
                  SizedBox(width: 40),
                  _iconCreation(Icons.person, Colors.blue, "Contact"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _iconCreation(IconData icon, Color color, String text) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: color,
            child: Icon(
              icon,
              size: 29,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 5),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
