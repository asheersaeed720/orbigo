import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orbigo/models/chat.dart';
import 'package:orbigo/providers/auth_provider.dart';
import 'package:orbigo/providers/user_provider.dart';
import 'package:orbigo/widgets/chat_widget.dart';
import 'package:orbigo/widgets/loading_indicator.dart';

class SubsriberChatScreen extends StatefulWidget {
  static const String routeName = '/subsriber-chat';

  @override
  _SubsriberChatScreenState createState() => _SubsriberChatScreenState();
}

class _SubsriberChatScreenState extends State<SubsriberChatScreen>
    with TickerProviderStateMixin {
  final List<ChatMessage> _messages = [];
  final _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isComposing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Global',
          style: TextStyle(color: Colors.white),
        ),
        elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
          child: Column(
            children: [
              // Flexible(
              //   child: ListView.builder(
              //     padding: EdgeInsets.all(8.0),
              //     reverse: true,
              //     itemBuilder: (_, int index) => _messages[index],
              //     itemCount: _messages.length,
              //   ),
              // ),
              Consumer(
                builder: (context, watch, _) {
                  final userPvd = watch(userProvider);
                  final authPvd = watch(authProvider);
                  return FutureBuilder(
                    future: userPvd.getUserMessages(authPvd),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<Chat> chatMessages = snapshot.data;
                        return Flexible(
                          child: ListView.builder(
                            itemCount: chatMessages.length,
                            padding: EdgeInsets.all(8.0),
                            reverse: true,
                            itemBuilder: (context, i) => Card(
                              elevation: 2,
                              child: ListTile(
                                leading:
                                    Text('${chatMessages[i].users.username}'),
                                title: Text('${chatMessages[i].text}'),
                              ),
                            ),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            "${snapshot.error}",
                          ),
                        );
                      }
                      return LoadingIndicator();
                    },
                  );
                },
              ),
              Divider(height: 1.0),
              Container(
                decoration: BoxDecoration(color: Theme.of(context).cardColor),
                child: _buildTextComposer(),
              ),
            ],
          ),
          decoration: Theme.of(context).platform == TargetPlatform.iOS //new
              ? BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.grey[200]),
                  ),
                )
              : null),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).accentColor),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _textController,
                onChanged: (String text) {
                  setState(() {
                    _isComposing = text.length > 0;
                  });
                },
                onSubmitted: _isComposing ? _handleSubmitted : null,
                decoration:
                    InputDecoration.collapsed(hintText: 'Send a message'),
                focusNode: _focusNode,
              ),
            ),
            Consumer(builder: (context, watch, _) {
              final userPvd = watch(userProvider);
              final authPvd = watch(authProvider);
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                child: Theme.of(context).platform == TargetPlatform.iOS
                    ? CupertinoButton(
                        child: Text('Send'),
                        onPressed: _isComposing
                            ? () => _handleSubmitted(_textController.text)
                            : null,
                      )
                    : IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: _isComposing
                            ? () => userPvd.sendMessages(
                                authPvd, _textController.text)
                            : null,
                      ),

                // : IconButton(
                //   icon: const Icon(Icons.send),
                //   onPressed: _isComposing
                //       ? () => _handleSubmitted(_textController.text)
                //       : null,
                // ),
              );
            })
          ],
        ),
      ),
    );
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    setState(() {
      _isComposing = false;
    });
    ChatMessage message = ChatMessage(
      text: text,
      animationController: AnimationController(
        duration: const Duration(milliseconds: 700),
        vsync: this,
      ),
    );
    setState(() {
      _messages.insert(0, message);
    });
    _focusNode.requestFocus();
    message.animationController.forward();
  }

  @override
  void dispose() {
    for (ChatMessage message in _messages)
      message.animationController.dispose();
    super.dispose();
  }
}
