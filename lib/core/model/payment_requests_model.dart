// To parse this JSON data, do
//
//     final paymentRequestsModel = paymentRequestsModelFromJson(jsonString);

import 'dart:convert';

PaymentRequestsModel paymentRequestsModelFromJson(String str) => PaymentRequestsModel.fromJson(json.decode(str));


class PaymentRequestsModel {
    PaymentRequestsModel({
        this.paymentActions,
    });

    final List<PaymentAction>? paymentActions;

    factory PaymentRequestsModel.fromJson(Map<String, dynamic> json) => PaymentRequestsModel(
        paymentActions: List<PaymentAction>.from(json["payment_actions"].map((x) => PaymentAction.fromJson(x))),
    );
}

class PaymentAction {
    PaymentAction({
        required this.actionId,
        required this.userId,
        required this.actionPoint,
        required this.actionStatus,
        required this.statusName,
        required this.bankId,
        required this.bankName,
        required this.bankUserName,
        required this.bankBranchCode,
        required this.bankAccountNumber,
        required this.bankIban,
        required this.actionIsactive,
        required this.actionIsdelete,
        required this.actionCreatetime,
        required this.actionTimestamp,
    });

    final String actionId;
    final String userId;
    final String actionPoint;
    final String actionStatus;
    final String statusName;
    final String bankId;
    final String bankName;
    final String bankUserName;
    final String bankBranchCode;
    final String bankAccountNumber;
    final String bankIban;
    final String actionIsactive;
    final String actionIsdelete;
    final DateTime actionCreatetime;
    final DateTime actionTimestamp;

    factory PaymentAction.fromJson(Map<String, dynamic> json) => PaymentAction(
        actionId: json["action_id"],
        userId: json["user_id"],
        actionPoint: json["action_point"],
        actionStatus: json["action_status"],
        statusName: json["status_name"],
        bankId: json["bank_id"],
        bankName: json["bank_name"],
        bankUserName: json["bank_user_name"],
        bankBranchCode: json["bank_branch_code"],
        bankAccountNumber: json["bank_account_number"],
        bankIban: json["bank_iban"],
        actionIsactive: json["action_isactive"],
        actionIsdelete: json["action_isdelete"],
        actionCreatetime: DateTime.parse(json["action_createtime"]),
        actionTimestamp: DateTime.parse(json["action_timestamp"]),
    );
}
