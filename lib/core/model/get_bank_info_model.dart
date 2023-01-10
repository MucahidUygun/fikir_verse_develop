// To parse this JSON data, do
//
//     final getBankInfo = getBankInfoFromJson(jsonString);

import 'dart:convert';

GetBankInfoModel getBankInfoFromJson(String str) => GetBankInfoModel.fromJson(json.decode(str));

class GetBankInfoModel {
    GetBankInfoModel({
        this.status,
        this.bankId,
        this.userId,
        this.bankName,
        this.bankUserName,
        this.bankBranchCode,
        this.bankAccountNumber,
        this.bankIban,
        this.numberTC,
    });

    bool? status;
    String? bankId;
    String? userId;
    String? bankName;
    String? bankUserName;
    String? bankBranchCode;
    String? bankAccountNumber;
    String? numberTC;
    String? bankIban;

    factory GetBankInfoModel.fromJson(Map<String, dynamic> json) => GetBankInfoModel(
        status: json["status"],
        bankId: json["bank_id"],
        userId: json["user_id"],
        numberTC: json['bank_identity_number'],
        bankName: json["bank_name"],
        bankUserName: json["bank_user_name"],
        bankBranchCode: json["bank_branch_code"],
        bankAccountNumber: json["bank_account_number"],
        bankIban: json["bank_iban"],
    );
}
