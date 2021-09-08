// To parse this JSON data, do
//
//     final result = resultFromJson(jsonString);

import 'dart:convert';

Result resultFromJson(String str) => Result.fromJson(json.decode(str));

String resultToJson(Result data) => json.encode(data.toJson());

class Result {
    Result({
        required this.ok,
        required this.result,
    });

    final bool ok;
    final ResultClass result;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        ok: json["ok"],
        result: ResultClass.fromJson(json["result"]),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "result": result.toJson(),
    };
}

class ResultClass {
    ResultClass({
        required this.code,
        required this.shortLink,
        required this.fullShortLink,
        required this.shortLink2,
        required this.fullShortLink2,
        required this.shortLink3,
        required this.fullShortLink3,
        required this.shareLink,
        required this.fullShareLink,
        required this.originalLink,
    });

    final String code;
    final String shortLink;
    final String fullShortLink;
    final String shortLink2;
    final String fullShortLink2;
    final String shortLink3;
    final String fullShortLink3;
    final String shareLink;
    final String fullShareLink;
    final String originalLink;

    factory ResultClass.fromJson(Map<String, dynamic> json) => ResultClass(
        code: json["code"],
        shortLink: json["short_link"],
        fullShortLink: json["full_short_link"],
        shortLink2: json["short_link2"],
        fullShortLink2: json["full_short_link2"],
        shortLink3: json["short_link3"],
        fullShortLink3: json["full_short_link3"],
        shareLink: json["share_link"],
        fullShareLink: json["full_share_link"],
        originalLink: json["original_link"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "short_link": shortLink,
        "full_short_link": fullShortLink,
        "short_link2": shortLink2,
        "full_short_link2": fullShortLink2,
        "short_link3": shortLink3,
        "full_short_link3": fullShortLink3,
        "share_link": shareLink,
        "full_share_link": fullShareLink,
        "original_link": originalLink,
    };
}
