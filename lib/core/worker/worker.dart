// import 'dart:async';
// import 'dart:isolate';

// import 'package:dio/dio.dart';

// import '../core.dart';
// import 'work_response.dart';
// import 'worker_request.dart';

// abstract class IWorker {
//   Future<void>? get isolateReady => null;

//   Future<Response> excuteRequest({required WorkRequest request});

//   void dispose();
// }

// class Worker extends IWorker {
//   late Isolate _isolate;
//   // sendport of new isolate
//   late SendPort _sendPort;

//   // completer to listen isolate prepare complete
//   final _isolateReady = Completer<void>();
//   @override
//   Future<void> get isolateReady => _isolateReady.future;

//   // completer to return response
//   late Completer<Response> _response;
//   Future<Response> get response => _response.future;

//   Worker() {
//     init();
//   }

//   @override
//   void dispose() {
//     _isolate.kill();
//   }

//   @override
//   Future<Response> excuteRequest({required WorkRequest request}) async {
//     _sendPort.send(request);
//     return _response.future;
//   }

//   Future<void> init() async {
//     // receive port of main isolate
//     final receivePort = ReceivePort();
//     receivePort.listen(_handleMessage);

//     // create completer response
//     _response = Completer<Response>();
//     // create new isolate
//     _isolate = await Isolate.spawn(_isolateEntry, receivePort.sendPort);
//   }

//   static void _isolateEntry(dynamic message) {
//     SendPort sendPort;
//     // receive port of new isolate
//     final receivePort = ReceivePort();
//     receivePort.listen((message) async {
//       if (message is WorkRequest) {
//         final response = await _handleNetworkRequest(message);
//         sendPort.send(WorkResponse(
//           statusCode: response.statusCode,
//           data: response.data,
//           statusMessage: response.statusMessage,
//         ));
//       }
//     });

//     if (message is SendPort) {
//       sendPort = message;
//       sendPort.send(receivePort.sendPort);
//       return;
//     }
//   }

//   void _handleMessage(dynamic message) {
//     if (message is SendPort) {
//       _sendPort = message;
//       _isolateReady.complete();
//       return;
//     }

//     if (message is WorkResponse) {
//       _response.complete(Response(
//         statusCode: message.statusCode,
//         data: message.data,
//         statusMessage: message.statusMessage,
//         requestOptions: RequestOptions(),
//       ));
//       return;
//     }
//   }



//   static Future<Response> _handleNetworkRequest(WorkRequest request) async {
//     final rest = NetworkUtility(
//       request.baseUrl,
//     );
//     final response = await rest.request(
//       request.enpoint,
//       request.method,
//       data: request.data,
//       queryParameters: request.params,
//     );
//     return response;
//   }
// }
