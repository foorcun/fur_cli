import 'package:bosun/bosun.dart';
import 'dart:io';

class WriteRuny extends Command {
  WriteRuny() : super(command: 'runy', aliases: ['r'], example: 'fur runy');

  // final file = File('main.dart'); // bin/main.dart
  // final file = File(Directory.current.path + '\\lib\\main.dart'); // bin/lib/main.dart
  // final file = File('./lib/main.dart'); // bin/lib/main // bin/lib/main.dart
  // final file = File('./../lib/main.dart'); // lib/main.dart

  final file = File(
      './lib/main.dart'); // bin/lib/main // bin/lib/main.dart // bin flutter da project seviyesi ile ayni olacak

  @override
  void run(List<String> args, Map<String, dynamic> flags) async {
    // find file path

    //write
    await executeWrite(file);
  }

  Future<void> executeWrite(File file) async {
    //read file as List<String>
    List<String> lineList = readAsLinesSync(file);

    // search for void main()
    int lineNumber = -1;
    for (int i = 0; i < lineList.length; i++) {
      // print(lineList[i]);

      if (lineList[i].contains("void main()")) lineNumber = i;
    }
    if (lineNumber == -1) throw Exception("void main() bulunamadi...");

    // insert
    if (lineNumber > 0 &&
        lineList[lineNumber - 1] !=
            '''// flutter run -d chrome --web-hostname localhost --web-port 5000 --no-sound-null-safety''') {
      lineList.insert(lineNumber,
          '''// flutter run -d chrome --web-hostname localhost --web-port 5000 --no-sound-null-safety''');
      await file.writeAsString(lineList.join('\n'));
    }
  }

  List<String> readAsLinesSync(File file) {
    List<String> lines = file.readAsLinesSync();
    return lines;
  }
}
