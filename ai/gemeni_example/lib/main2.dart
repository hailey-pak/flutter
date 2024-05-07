import 'dart:io';
import 'package:gemini_example/api_key.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

Future<void> main() async {

 /* const apiKey = String.fromEnvironment('API_KEY');
  if (apiKey == null) {
    print('No \$API_KEY environment variable');
    exit(1);
  }*/
  // For text-only input, use the gemini-pro model
  final model = GenerativeModel(
      model: 'gemini-pro',
      apiKey: apiKey,
      generationConfig: GenerationConfig(maxOutputTokens: 100));
  // Initialize the chat
  final chat = model.startChat(history: [
    Content.text('Hello, I have 2 dogs in my house.'),
    Content.model([TextPart('Great to meet you. What would you like to know?')])
  ]);
  var content = Content.text('How many paws are in my house?');
  var response = await chat.sendMessage(content);
  print(response.text);
}