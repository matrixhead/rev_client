import 'dart:convert';

import 'package:revolt_client/src/api_wrapper/helpers.dart';
import 'package:revolt_client/src/config/config.dart';
import 'package:revolt_client/src/exceptions/exceptions.dart';
import 'package:revolt_client/src/models/ws_events/ws_events.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class RevWsChannel {
  RevWsChannel({required RevConfig config, WebSocketChannel? channel})
    : _channel = channel,
      _uri = Uri.parse('ws://${config.baseUrl}:${config.wsPort}');

  WebSocketChannel? _channel;
  final Uri _uri;

  WebSocketChannel get _getChannel {
    if (_channel case final WebSocketChannel channel) {
      return channel;
    }
    throw RevWebsocketNotInitialized();
  }

  Future<void> get isReady => _getChannel.ready;

  Stream<ServerToClientEvents> get stream =>
      _getChannel.stream.map<ServerToClientEvents>((event) {
        return ServerToClientEvents.fromJson(parseJsonToMap(event as String));
      });
  void init() {
    _channel ??= WebSocketChannel.connect(_uri);
  }

  void authenticateWsChannel(String sessionToken) {
    final json = jsonEncode(AuthenticateEvent(token: sessionToken).toJson());
    _getChannel.sink.add(json);
  }
}
