import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:dio/dio.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'unique_common_data.dart';
import 'unique_common_type.dart';

class UniqueCommonWidget extends StatelessWidget {
  final UniqueCommonData data;
  final double? height;
  final double? width;

  const UniqueCommonWidget({
    super.key,
    required this.data,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
      child: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    switch (data.type) {
      case UniqueCommonType.text:
        return _TextContent(content: data.content);
      case UniqueCommonType.html:
        return _HtmlContent(content: data.content);
      case UniqueCommonType.webview:
        return _WebViewContent(url: data.content);
      case UniqueCommonType.lottie:
        return _LottieContent(
          url: data.content,
          repeat: data.metadata?['repeat'] ?? true,
        );
      case UniqueCommonType.video:
        return _VideoContent(url: data.content);
      case UniqueCommonType.api:
        return _ApiContent(
          url: data.content,
          method: data.metadata?['method'] ?? 'GET',
          headers: data.metadata?['headers'],
        );
      case UniqueCommonType.iframe:
        return _IframeContent(url: data.content);
    }
  }
}

class _TextContent extends StatelessWidget {
  final String content;
  const _TextContent({required this.content});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        content,
        style: const TextStyle(fontSize: 16, color: Colors.black87),
      ),
    );
  }
}

class _HtmlContent extends StatelessWidget {
  final String content;
  const _HtmlContent({required this.content});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: HtmlWidget(content),
    );
  }
}

const String _mobileUserAgent =
    "Mozilla/5.0 (Linux; Android 13; SM-G991B) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Mobile Safari/537.36";

class _WebViewContent extends StatefulWidget {
  final String url;
  const _WebViewContent({required this.url});

  @override
  State<_WebViewContent> createState() => _WebViewContentState();
}

class _WebViewContentState extends State<_WebViewContent> {
  bool _isLoading = true;
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InAppWebView(
          initialUrlRequest: URLRequest(url: WebUri(widget.url)),
          initialSettings: InAppWebViewSettings(
            userAgent: _mobileUserAgent,
            javaScriptEnabled: true,
            useWideViewPort: true,
            loadWithOverviewMode: true,
            allowsInlineMediaPlayback: true,
            mediaPlaybackRequiresUserGesture: false,
            domStorageEnabled: true,
            databaseEnabled: true,
            useShouldOverrideUrlLoading: true,
            transparentBackground: true,
            safeBrowsingEnabled: false,
            mixedContentMode: MixedContentMode.MIXED_CONTENT_ALWAYS_ALLOW,
          ),
          onWebViewCreated: (controller) {
            debugPrint("WebView created for URL: ${widget.url}");
            // Fallback: Some platforms (like Web) might not fire onLoadStart/Stop reliably.
            // We set a safety timeout to hide the spinner anyway.
            Future.delayed(const Duration(seconds: 2), () {
              if (mounted && _isLoading) {
                setState(() {
                  _isLoading = false;
                });
                debugPrint("WebView loading fallback triggered (timeout)");
              }
            });
          },
          onLoadStart: (controller, url) {
            if (mounted) {
              setState(() {
                _isLoading = true;
                _errorMessage = null;
              });
            }
            debugPrint("WebView started loading: $url");
          },
          onLoadStop: (controller, url) {
            if (mounted) {
              setState(() {
                _isLoading = false;
              });
            }
            debugPrint("WebView finished loading: $url");
          },
          onProgressChanged: (controller, progress) {
            debugPrint("WebView progress: $progress");
            if (progress >= 70 && _isLoading) {
              if (mounted) {
                setState(() {
                  _isLoading = false;
                });
              }
            }
          },
          onReceivedError: (controller, request, error) {
            setState(() {
              _isLoading = false;
              _errorMessage = error.description;
            });
            debugPrint("WebView Error: ${error.description}");
          },
          onReceivedHttpError: (controller, request, errorResponse) {
            if ((errorResponse.statusCode ?? 0) >= 400) {
              setState(() {
                _isLoading = false;
              });
            }
          },
          onPermissionRequest: (controller, request) async {
            return PermissionResponse(
              resources: request.resources,
              action: PermissionResponseAction.GRANT,
            );
          },
        ),
        if (_isLoading)
          const Center(
            child: CircularProgressIndicator(),
          ),
        if (_errorMessage != null)
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error_outline, color: Colors.red, size: 40),
                const SizedBox(height: 8),
                Text('Failed to load website', style: const TextStyle(fontWeight: FontWeight.bold)),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(_errorMessage!, textAlign: TextAlign.center, style: const TextStyle(fontSize: 12)),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _LottieContent extends StatelessWidget {
  final String url;
  final bool repeat;
  const _LottieContent({required this.url, this.repeat = true});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.network(
        url,
        repeat: repeat,
        fit: BoxFit.contain,
        frameRate: FrameRate.max,
        onLoaded: (composition) {
          debugPrint("Lottie loaded successfully from: $url");
        },
        errorBuilder: (context, error, stackTrace) {
          debugPrint("Lottie error for $url: $error");
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.animation, color: Colors.orange, size: 40),
                const SizedBox(height: 8),
                const Text('Animation Load Failed',
                    style:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                  child: Text(
                    url,
                    style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _VideoContent extends StatefulWidget {
  final String url;
  const _VideoContent({required this.url});

  @override
  State<_VideoContent> createState() => _VideoContentState();
}

class _VideoContentState extends State<_VideoContent> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    try {
      _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(widget.url));
      await _videoPlayerController.initialize();
      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        autoPlay: false,
        looping: false,
        aspectRatio: _videoPlayerController.value.aspectRatio,
        errorBuilder: (context, errorMessage) {
          return Center(
            child: Text(
              errorMessage,
              style: const TextStyle(color: Colors.white),
            ),
          );
        },
      );
      if (mounted) setState(() {});
    } catch (e) {
      debugPrint("Video initialization error: $e");
    }
  }

  void _handleVisibilityChanged(VisibilityInfo info) {
    final visibleFraction = info.visibleFraction;
    final isVisibleNow = visibleFraction >= 0.8;

    if (isVisibleNow != _isVisible) {
      _isVisible = isVisibleNow;
      if (_chewieController != null && _chewieController!.videoPlayerController.value.isInitialized) {
        if (_isVisible) {
          _chewieController!.play();
        } else {
          _chewieController!.pause();
        }
      }
    }
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_chewieController != null &&
        _chewieController!.videoPlayerController.value.isInitialized) {
      return VisibilityDetector(
        key: Key(widget.url),
        onVisibilityChanged: _handleVisibilityChanged,
        child: AspectRatio(
          aspectRatio: _chewieController!.videoPlayerController.value.aspectRatio,
          child: Chewie(controller: _chewieController!),
        ),
      );
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }
}

class _ApiContent extends StatefulWidget {
  final String url;
  final String method;
  final Map<String, dynamic>? headers;

  const _ApiContent({
    required this.url,
    this.method = 'GET',
    this.headers,
  });

  @override
  State<_ApiContent> createState() => _ApiContentState();
}

class _ApiContentState extends State<_ApiContent> {
  late Future<dynamic> _apiFuture;
  final Dio _dio = Dio();

  @override
  void initState() {
    super.initState();
    _apiFuture = _fetchData();
  }

  Future<dynamic> _fetchData() async {
    try {
      final response = await _dio.request(
        widget.url,
        options: Options(
          method: widget.method,
          headers: widget.headers,
        ),
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: _apiFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.api_outlined, color: Colors.red, size: 40),
                const SizedBox(height: 8),
                Text('API Error: ${snapshot.error}', style: const TextStyle(fontSize: 12), textAlign: TextAlign.center),
              ],
            ),
          );
        } else {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              snapshot.data.toString(),
              style: const TextStyle(fontFamily: 'monospace', fontSize: 13),
            ),
          );
        }
      },
    );
  }
}

class _IframeContent extends StatelessWidget {
  final String url;
  const _IframeContent({required this.url});

  @override
  Widget build(BuildContext context) {
    // YouTube embeds often work better when loaded directly as a URL request with a mobile User-Agent
    if (url.contains("youtube.com/embed/")) {
      return InAppWebView(
        initialUrlRequest: URLRequest(url: WebUri(url)),
        initialSettings: InAppWebViewSettings(
          userAgent: _mobileUserAgent,
          javaScriptEnabled: true,
          allowsInlineMediaPlayback: true,
          mediaPlaybackRequiresUserGesture: false,
          useWideViewPort: true,
          loadWithOverviewMode: true,
          domStorageEnabled: true,
        ),
        onLoadStop: (controller, url) {
          debugPrint("YouTube Iframe loaded directly");
        },
        onReceivedError: (controller, request, error) {
          debugPrint("YouTube Iframe Error: ${error.description}");
        },
      );
    }

    return InAppWebView(
      initialData: InAppWebViewInitialData(
        baseUrl: WebUri(url.startsWith('https')
            ? Uri.parse(url).origin
            : "https://www.google.com"),
        data: """
          <!DOCTYPE html>
          <html>
            <head>
              <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
              <style>
                body { margin: 0; padding: 0; background-color: transparent; overflow: hidden; }
                .iframe-container {
                  position: absolute;
                  top: 0; bottom: 0; left: 0; right: 0;
                  display: flex;
                  justify-content: center;
                  align-items: center;
                }
                iframe { width: 100%; height: 100%; border: none; }
              </style>
            </head>
            <body>
              <div class="iframe-container">
                <iframe 
                  src="$url" 
                  allow="autoplay; encrypted-media; fullscreen; picture-in-picture" 
                  allowfullscreen
                ></iframe>
              </div>
            </body>
          </html>
        """,
      ),
      initialSettings: InAppWebViewSettings(
        userAgent: _mobileUserAgent,
        javaScriptEnabled: true,
        allowsInlineMediaPlayback: true,
        mediaPlaybackRequiresUserGesture: false,
        domStorageEnabled: true,
        useWideViewPort: true,
        transparentBackground: true,
      ),
      onLoadStop: (controller, url) {
        debugPrint("Generic Iframe host loaded");
      },
      onReceivedError: (controller, request, error) {
        debugPrint("Generic Iframe WebView Error: ${error.description}");
      },
    );
  }
}
