import 'package:finora/domain/enum/transaction/expense_category.dart';
import 'package:finora/domain/enum/transaction/income_category.dart';
import 'package:finora/domain/exception/account/invalid_amount_exception.dart';
import 'package:finora/domain/exception/account/invalid_double_format_exception.dart';
import 'package:finora/domain/exception/transaction/invalid_expense_type_exception.dart';
import 'package:finora/domain/exception/transaction/invalid_income_type_exception.dart';
import 'package:finora/domain/exception/transaction/invalid_make_transaction.dart';
import 'package:finora/domain/exception/user/empty_value_exception.dart';
import 'package:finora/domain/exception/user/invalid_date_time_exception.dart';
import 'package:finora/domain/exception/user/invalid_format_exception.dart';
import 'package:finora/domain/usecases/transaction/create_transaction_usecase.dart';
import 'package:finora/presentation/controller/auth_user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddTransactionController extends GetxController {
  final CreateTransactionUseCase _createTransactionUseCase;
  AddTransactionController({required this._createTransactionUseCase});

  final TextEditingController title = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController amount = TextEditingController();
  final incomeCategory = Rxn<IncomeCategory>(IncomeCategory.salary);
  final expenseCategory = Rxn<ExpenseCategory>(ExpenseCategory.food);
  final createdAt = Rxn<DateTime>(DateTime.now());

  final titleError = RxnString();
  final categoryError = RxnString();
  final createdAtError = RxnString();
  final amountError = RxnString();
  final otherErrors = RxnString();

  final isLoading = false.obs;

  Future<void> sumbitAddIncome() async {
    _resetErrors();
    isLoading.value = true;
    final account = AuthUserController.to.defaultAccount;
    if (account == null) return;
    try {
      final result = await _createTransactionUseCase.createIncome(
        account: account,
        rawTitle: title.text,
        description: (description.text.isNotEmpty) ? description.text : null,
        createdAt: createdAt.value ?? DateTime.now(),
        categoryCode: incomeCategory.value!.code,
        rawAmount: amount.text,
      );
      print(result.transaction.displayData);
      print(result.account);

      AuthUserController.to.updateDefaultAccount(result.account);
      AuthUserController.to.addTransaction(result.transaction);

      Get.offAllNamed('/home');
      isLoading.value = false;
    } on EmptyValueException catch (e) {
      _setErrors(e);
    } on InvalidFormatException catch (e) {
      _setErrors(e);
    } on InvalidIncomeTypeException catch (e) {
      categoryError.value = e.message;
    } on InvalidDateTimeException catch (e) {
      createdAtError.value = e.message;
    } on InvalidDoubleFormatException catch (e) {
      amountError.value = e.message;
    } on InvalidAmountException catch (e) {
      amountError.value = e.message;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> sumbitAddExpense() async {
    _resetErrors();
    isLoading.value = true;
    final account = AuthUserController.to.defaultAccount;
    print(account?.currentBalance);
    if (account == null) return;
    try {
      final result = await _createTransactionUseCase.createExpense(
        account: account,
        rawTitle: title.text,
        description: (description.text.isNotEmpty) ? description.text : null,
        createdAt: createdAt.value ?? DateTime.now(),
        categoryCode: expenseCategory.value!.code,
        rawAmount: amount.text,
      );
      AuthUserController.to.updateDefaultAccount(result.account);
      AuthUserController.to.addTransaction(result.transaction);
      Get.offAllNamed('/home');
      isLoading.value = false;
    } on EmptyValueException catch (e) {
      _setErrors(e);
    } on InvalidFormatException catch (e) {
      _setErrors(e);
    } on InvalidExpenseTypeException catch (e) {
      categoryError.value = e.message;
    } on InvalidDateTimeException catch (e) {
      createdAtError.value = e.message;
    } on InvalidDoubleFormatException catch (e) {
      amountError.value = e.message;
    } on InvalidAmountException catch (e) {
      amountError.value = e.message;
    } on InvalidMakeTransaction catch (e) {
      otherErrors.value = e.message;
    } finally {
      isLoading.value = false;
    }
  }

  void setCreatedAt(DateTime date) {
    createdAt.value = date;
  }

  void _setErrors(Exception e) {
    final message = e.toString();

    if (message.contains("title")) {
      titleError.value = message;
    } else if (message.contains("amount")) {
      amountError.value = message;
    } else if (message.contains("income")) {
      categoryError.value = message;
    } else if (message.contains("expense")) {
      categoryError.value = message;
    } else if (message.contains("date")) {
      createdAtError.value = message;
    } else {
      otherErrors.value = message;
    }
  }

  void _resetErrors() {
    titleError.value = null;
    amountError.value = null;
    categoryError.value = null;
    createdAtError.value = null;
    otherErrors.value = null;
  }
}
