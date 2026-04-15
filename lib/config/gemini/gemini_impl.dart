

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';

class GeminiImpl {

  final Dio _http = Dio(
    BaseOptions(
      baseUrl: dotenv.env['ENDPOINT_API'] ?? ''
    )
  );

  Future<String> getResponse(String prompt) async {
    
    try{

      final body = jsonEncode({'prompt': prompt});
      final response = await _http.post('/basic-prompt', data: body);
      return response.data;
    } catch (e) {
      print(e);
      throw Exception('Error al obtener respuesta de Gemini');
    }
  }

  Stream<String> getResponseStream(
    String prompt, {
    List<XFile> files = const [],
  
    }) async* {

      yield* _getStreamResponse(
        endpoint: '/basic-prompt-stream',
        prompt: prompt,
        files: files,
      );
    
  }


  Stream<String> getChatStream(
    String prompt,
    String chatId, {
    List<XFile> files = const [],
  
    }) async* {

      yield* _getStreamResponse(
        endpoint: '/chat-stream',
        prompt: prompt,
        files: files,
        formFields: {'chatId': chatId},
      );
   
  }

  // Emitir el stream de información

  Stream<String> _getStreamResponse({
    required String endpoint,
    required String prompt,
    List<XFile> files = const [],
    Map<String, dynamic> formFields = const {},
  }) async*{

    //! Multipart
    final formData = FormData();
    formData.fields.add(MapEntry('prompt', prompt));
    for(final entry in formFields.entries) {
      formData.fields.add(MapEntry(entry.key, entry.value));
    }

  //! Achivos a subir
    if(files.isNotEmpty) {
      for (XFile file in files.reversed) {
        formData.files.add(MapEntry(
          'files',
          MultipartFile.fromFileSync(file.path, filename: file.name)
        ));
      }
    }

    try {
      //print(formData);
      final response = await _http.post(
        endpoint,
        data: formData,
        options: Options(responseType: ResponseType.stream),
      );

      final stream = response.data.stream as Stream<List<int>>;
      String buffer = '';
      
      await for (final chunk in stream) {
        final chunkString = utf8.decode(chunk, allowMalformed: true);
        buffer += chunkString;
        yield buffer;
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
      throw Exception('Error al obtener el stream de Gemini');
    }
  }

}