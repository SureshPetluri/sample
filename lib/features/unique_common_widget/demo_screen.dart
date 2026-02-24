import 'package:flutter/material.dart';
import 'unique_common_widget.dart';
import 'unique_common_data.dart';
import 'unique_common_type.dart';

class UniversalWidgetDemoScreen extends StatelessWidget {
  const UniversalWidgetDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final testData = [
      UniqueCommonData(
        type: UniqueCommonType.text,
        content: "Hello! This is a standard text widget inside our Universal Common Widget.",
      ),
      UniqueCommonData(
        type: UniqueCommonType.lottie,
        content: "https://raw.githubusercontent.com/xvrh/lottie-flutter/master/example/assets/Mobilo/A.json", 
      ),
      UniqueCommonData(
        type: UniqueCommonType.html,
        content: """
          <h1 style='color: #2196F3;'>HTML Content</h1>
          <p>This is <b>bold</b> and this is <i>italic</i>.</p>
          <div style='background-color: #f0f0f0; padding: 10px; border-radius: 8px;'>
            Custom styled div from HTML
          </div>
        """,
      ),
      UniqueCommonData(
        type: UniqueCommonType.video,
        content: "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
      ),
      UniqueCommonData(
        type: UniqueCommonType.api,
        content: "https://jsonplaceholder.typicode.com/posts/1",
        metadata: {'method': 'GET'},
      ),
      UniqueCommonData(
        type: UniqueCommonType.webview,
        content: "https://www.wikipedia.org", // Very compatible URL
      ),
      UniqueCommonData(
        type: UniqueCommonType.iframe,
        content: "https://www.youtube.com/embed/dQw4w9WgXcQ?autoplay=0&mute=1&enablejsapi=1",
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Universal Widget Demo"),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: testData.length,
        separatorBuilder: (context, index) => const SizedBox(height: 20),
        itemBuilder: (context, index) {
          final data = testData[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Type: ${data.type.name.toUpperCase()}",
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: data.type == UniqueCommonType.video || data.type == UniqueCommonType.webview || data.type == UniqueCommonType.iframe ? 300 : null,
                child: UniqueCommonWidget(
                  data: data,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
