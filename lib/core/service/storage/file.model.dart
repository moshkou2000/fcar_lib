import 'dart:io';

class FileModel {
  final File? file;
  final String? directory;
  final String? extension;
  final String? name;
  final String? path;

  FileModel({
    this.file,
    this.extension,
    this.directory,
    this.name,
    this.path,
  });
}
