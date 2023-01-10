// To parse this JSON data, do
//
//     final kvkkModel = kvkkModelFromJson(jsonString);

import 'dart:convert';

KvkkModel kvkkModelFromJson(String str) => KvkkModel.fromJson(json.decode(str));

class KvkkModel {
    KvkkModel({
        required this.kvkkContract,
    });

    final Contract kvkkContract;

    factory KvkkModel.fromJson(Map<String, dynamic> json) => KvkkModel(
        kvkkContract: Contract.fromJson(json["kvkk_contract"]),
    );
}

class Contract {
    Contract({
        required this.filename,
        required this.file,
    });

    final String filename;
    final String file;

    factory Contract.fromJson(Map<String, dynamic> json) => Contract(
        filename: json["filename"],
        file: json["file"],
    );
}
