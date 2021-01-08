import 'dart:io';

import 'package:chat_realtime/widgets/chat_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  bool _escribiendo = false;
  final _textController = TextEditingController();
  final _focusNode = FocusNode();

  List<ChatMessage> _messages = [
    // ChatMessage(
    //   texto: 'queso',
    //   uid: '123',
    // ),
    // ChatMessage(
    //   texto: 'queso',
    //   uid: '123',
    // ),
    // ChatMessage(
    //   texto:
    //       'mensaje super largo para ver como se ve y estas cosas de si se rompe o se ve chido',
    //   uid: '123',
    // ),
    // ChatMessage(
    //   texto: 'queso',
    //   uid: '123',
    // ),
    // ChatMessage(
    //   texto: 'queso',
    //   uid: '123',
    // ),
    // ChatMessage(
    //   texto: 'queso',
    //   uid: '1234',
    // ),
    // ChatMessage(
    //   texto: 'queso',
    //   uid: '1234',
    // ),
    // ChatMessage(
    //   texto:
    //       'mensaje super sas de si se rompe o se ve chido asdfghjklsdffcffcfcfccfcfcfcfc fcfcf fcfcf fcfcf fcfcf fcf fcf fcf fcf f fdgfcchfhgv xzs',
    //   uid: '1234',
    // ),
    // ChatMessage(
    //   texto: 'queso',
    //   uid: '1234',
    // ),
    // ChatMessage(
    //   texto: 'queso',
    //   uid: '1234',
    // ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        title: Column(
          children: [
            CircleAvatar(
              child: Text(
                'Te',
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              backgroundColor: Colors.blue[100],
              maxRadius: 14,
            ),
            SizedBox(
              height: 5,
            ),
            Text('Melissa',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 12,
                )),
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: _messages.length,
                itemBuilder: (_, i) => _messages[i],
                reverse: true,
              ),
            ),
            Divider(
              height: 1,
            ),
            Container(
              color: Colors.white,
              child: _inputChat(),
            ),
          ],
        ),
      ),
    );
  }

  _inputChat() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(bottom: 5, top: 1),
        margin: EdgeInsets.symmetric(
          horizontal: 8,
        ),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                maxLines: 5,
                minLines: 1,
                controller: _textController,
                // onSubmitted: _escribiendo
                //     ? () => _handlesubmit(_textController.text.trim())
                //     : null,
                onChanged: (String texto) {
                  //Cuando hay un valor, para poder postear
                  setState(() {
                    if (texto.trim().length > 0) {
                      _escribiendo = true;
                    } else {
                      _escribiendo = false;
                    }
                  });
                },
                decoration: InputDecoration.collapsed(
                  hintText: 'Enviar Mensaje',
                ),
                focusNode: _focusNode,
              ),
            ),

            //Boton de enviar

            Container(
              margin: EdgeInsets.symmetric(horizontal: 4),
              child: Platform.isIOS
                  ? CupertinoButton(
                      child: Text('Enviar'),
                      onPressed: _escribiendo
                          ? () => _handlesubmit(_textController.text.trim())
                          : null,
                    )
                  : Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 4,
                      ),
                      child: IconTheme(
                        data: IconThemeData(
                          color: Colors.blue[400],
                        ),
                        child: IconButton(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          icon: Icon(
                            Icons.send,
                            // color: Colors.blue[400],
                          ),
                          onPressed: _escribiendo
                              ? () => _handlesubmit(_textController.text.trim())
                              : null,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  _handlesubmit(String texto) {
    print(texto);
    _textController.clear();
    _focusNode.requestFocus();

    final newMessage = ChatMessage(
      uid: '123',
      texto: texto,
      animationController: AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 200),
      ),
    );
    _messages.insert(0, newMessage);
    newMessage.animationController.forward();
    setState(() {
      _escribiendo = false;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose

    // TODO: off del socket

    // limpiar cada instancia de el arreglo de mensajes
    for (ChatMessage message in _messages){
      message.animationController.dispose();
    }
    super.dispose();
  }
}
