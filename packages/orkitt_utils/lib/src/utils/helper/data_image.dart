
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class DataImageProvider extends ImageProvider<DataImageProvider> {
  final String base64ImageData;

  DataImageProvider({required this.base64ImageData});

  ImageStreamCompleter load(
    DataImageProvider key,
    Future<ui.Codec> Function(Uint8List) decode,
  ) {
    // Decode the base64 string (skip the 'data:image/png;base64,' part)
    final data = base64Decode(base64ImageData.split(',')[1]);
    final bytes = Uint8List.fromList(data);

    // Return an image stream completer with the decoded image bytes
    return OneFrameImageStreamCompleter(
      decode(bytes).then((codec) async {
        final frame = await codec.getNextFrame();
        return ImageInfo(image: frame.image);
      }),
    );
  }

  @override
  Future<DataImageProvider> obtainKey(ImageConfiguration configuration) {
    return SynchronousFuture<DataImageProvider>(this);
  }
}
