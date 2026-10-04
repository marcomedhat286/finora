import 'package:finora/core/utils/parse/money_input_parser.dart';
import 'package:finora/domain/criteria/transaction_search_criteria.dart';
import 'package:finora/domain/entities/account.dart';
import 'package:finora/domain/entities/transaction.dart';
import 'package:finora/domain/enum/transaction/amount_range_option.dart';
import 'package:finora/domain/enum/transaction/date_range_options.dart';
import 'package:finora/domain/enum/transaction/transaction_sort_option.dart';
import 'package:finora/domain/enum/transaction/transaction_type_option.dart';
import 'package:finora/domain/exception/account/invalid_amount_exception.dart';
import 'package:finora/domain/exception/account/invalid_double_format_exception.dart';
import 'package:finora/domain/exception/user/empty_value_exception.dart';
import 'package:finora/domain/exception/user/invalid_date_time_exception.dart';
import 'package:finora/domain/exception/user/invalid_format_exception.dart';
import 'package:finora/domain/services/transaction/amount_range_calculator.dart';
import 'package:finora/domain/services/transaction/date_range_calculator.dart';
import 'package:finora/domain/usecases/transaction/search_transactions_usecase.dart';
import 'package:finora/domain/validators/transaction/title_validator.dart';
import 'package:finora/domain/validators/user/validate_date.dart';
import 'package:finora/domain/value_object/transaction/amount_range.dart';
import 'package:finora/domain/value_object/transaction/date_range.dart';
import 'package:finora/presentation/controller/auth_accounts_controller.dart';
import 'package:finora/presentation/screens/transaction_search/widgets/flitter_search_option_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FlitterSearchTransactionsController extends GetxController {
  Worker? _accountsWorker;
  Worker? _searchCriteriaWorker;
  final Rx<TransactionSearchCriteria> _searchCriteria =
      Rx<TransactionSearchCriteria>(TransactionSearchCriteria());
  final SearchTransactionsUsecase _searchTransactionsUsecase;
  FlitterSearchTransactionsController({
    required this._searchTransactionsUsecase,
  });
  final RxList<Transaction> result = <Transaction>[].obs;
  final isStartedSearch = false.obs;
  ////////////////////////////////////////////////////////////////////////
  final RxnString _transactionName = RxnString();
  final transactionNameError = RxnString();
  /////////////////////////////////////////////////////////////////////////
  final RxList<String> _selectedAccounts = <String>[].obs;
  final List<Account> _allAccounts = [];
  final _accountOptionState = ''.obs;

  /////////////////////////////////////////////////////////////
  final Rx<TransactionTypeOptions> _txOptionType = Rx<TransactionTypeOptions>(
    TransactionTypeOptions.all,
  );
  /////////////////////////////////////////////////////////////
  final Rx<DateRangeOptions> _selectedDateRange = DateRangeOptions.anyDate.obs;
  DateRange? _customDateRange;
  DateTime? _from = DateRange.now.subtract(const Duration(days: 12));
  DateTime _to = DateRange.now;

  final dateTimeFromError = RxnString();
  final dateTimeToError = RxnString();
  ////////////////////////////////////////////////////////////
  double? _minAmount;
  double? _maxAmount;
  final Rxn<AmountRangeOptions> _quickAmountOption = Rxn<AmountRangeOptions>();
  AmountRange? _customAmountRange;

  final minAmountController = TextEditingController();
  final minAmmountError = RxnString();
  final maxAmountController = TextEditingController();
  final maxAmmountError = RxnString();

  ///////////////////////////////////////////////////////
  final transactionSortOption = Rx<TransactionSortOption>(
    TransactionSortOption.newest,
  );
  void setTransactionSortOption(TransactionSortOption option) {
    transactionSortOption.value = option;
    _searchCriteria.value.sortOption = option;
    _searchCriteria.refresh();
  }

  void validateTransactionName(String name) {
    transactionNameError.value = null;
    if (name.isEmpty) {
      _transactionName.value = null;
      _searchCriteria.value.name = _transactionName.value;
      _searchCriteria.refresh();
      return;
    }
    ;
    try {
      _transactionName.value = TitleValidator.validateOrThrow(title: name);
      _searchCriteria.value.name = _transactionName.value;
      _searchCriteria.refresh();
    } on EmptyValueException catch (e) {
      transactionNameError.value = e.message;
    } on InvalidFormatException catch (e) {
      transactionNameError.value = e.message;
    }
  }

  void resetTransactionSearchCriteria() {
    result.clear();

    _selectedAccounts.clear();
    _selectedAccounts.addAll(_allAccounts.map((acc) => acc.id.value));

    _customAmountRange = null;
    _quickAmountOption.value = AmountRangeOptions.any;

    _customDateRange = null;
    _selectedDateRange.value = DateRangeOptions.anyDate;

    _transactionName.value = null;

    _txOptionType.value = TransactionTypeOptions.all;

    _searchCriteria.value
      ..accountIds = _selectedAccounts
      ..amountRange = _customAmountRange
      ..dateRange = _customDateRange
      ..type = _txOptionType.value.name
      ..name = _transactionName.value;
    _searchCriteria.refresh();
  }

  @override
  void onInit() {
    super.onInit();

    _initinateAttributes();

    _accountsWorker = ever(AuthAccountsController.to.reactiveUerAccounts, (_) {
      _initinateAttributes();
    });
    _searchCriteriaWorker = ever(_searchCriteria, (searchvalue) async {
      await search();
    });
  }

  Future<void> search() async {
    result.clear();

    final useCaseresult = await _searchTransactionsUsecase.call(
      _searchCriteria.value,
    );
    result.addAll(useCaseresult);

    result.refresh();
    isStartedSearch.value = true;
  }

  @override
  void onClose() {
    _accountsWorker?.dispose();
    _searchCriteriaWorker?.dispose();
    minAmountController.dispose();
    maxAmountController.dispose();
    super.onClose();
  }

  void _initinateAttributes() {
    _allAccounts.clear();
    _allAccounts.addAll(AuthAccountsController.to.userAccounts);
    addAllSelectedAccounts();
    _customAmountRange = null;
    _quickAmountOption.value = null;

    _customDateRange = null;
    _selectedDateRange.value = DateRangeOptions.anyDate;

    _transactionName.value = null;

    _txOptionType.value = TransactionTypeOptions.all;

    _searchCriteria.value = TransactionSearchCriteria(
      accountIds: _selectedAccounts,
      amountRange: _customAmountRange,
      dateRange: _customDateRange,
      type: _txOptionType.value.name,
      name: _transactionName.value,
      sortOption: transactionSortOption.value,
    );
  }

  void addAllSelectedAccounts() {
    _resetSelectedAccounts();
    _selectedAccounts.addAll(_allAccounts.map((account) => account.id.value));
    _selectedAccounts.refresh();
    _searchCriteria.value.accountIds = _selectedAccounts;
    _searchCriteria.refresh();
  }

  void removeAllAccounts() {
    _resetSelectedAccounts();
    _searchCriteria.value.accountIds = _selectedAccounts;
    _searchCriteria.refresh();
  }

  void addAccountOption(String accountId) {
    _selectedAccounts.add(accountId);
    _selectedAccounts.refresh();
    _searchCriteria.value.accountIds = _selectedAccounts;
    _searchCriteria.refresh();
  }

  void removeAccountOption(String accountId) {
    _selectedAccounts.remove(accountId);
    _selectedAccounts.refresh();
    _searchCriteria.value.accountIds = _selectedAccounts;
    _searchCriteria.refresh();
  }

  void _resetSelectedAccounts() {
    if (_selectedAccounts.isNotEmpty) {
      _selectedAccounts.clear();
      _selectedAccounts.refresh();
    }
  }

  bool get isAllSelected {
    if (_allAccounts.isEmpty) return false;

    return _selectedAccounts.length == _allAccounts.length &&
        _allAccounts.every(
          (account) => _selectedAccounts.contains(account.id.value),
        );
  }

  RxString get _getAccountOptionState {
    if (isAllSelected) {
      _accountOptionState.value = "all";
      return _accountOptionState;
    } else {
      if (_selectedAccounts.isNotEmpty) {
        _accountOptionState.value = "select ${_selectedAccounts.length}";
      } else {
        _accountOptionState.value = "None";
      }
    }
    return _accountOptionState;
  }

  bool isAccountSelected(String? accountId) {
    if (accountId == null) return false;
    return _selectedAccounts.contains(accountId);
  }

  //////////////////////////////////////////////////////////////////////////////////////
  void updateTransactionType(TransactionTypeOptions option) {
    _txOptionType.value = option;
    _searchCriteria.value.type = _txOptionType.value.name;
    _searchCriteria.refresh();
  }

  void setAllTransactionTypeOption() {
    _txOptionType.value = TransactionTypeOptions.all;
    _searchCriteria.value.type = _txOptionType.value.name;
    _searchCriteria.refresh();
  }

  bool isEqualToTransactionTypeOption(TransactionTypeOptions option) =>
      _txOptionType.value == option;
  ///////////////////////////////////////////////////////////////////////////////////
  void selectDateRangeOption(DateRangeOptions option) {
    if (option != DateRangeOptions.customRange) {
      _selectedDateRange.value = option;
      _customDateRange = DateRangeCalculator.calculate(
        option: _selectedDateRange.value,
      );
      _searchCriteria.value.dateRange = _customDateRange;
      _searchCriteria.refresh();
    } else {
      _customDateRange = null;
      _searchCriteria.value.dateRange = _customDateRange;
      _searchCriteria.refresh();
      _selectedDateRange.value = option;
    }
  }

  void validateFromDateTime(DateTime from) {
    dateTimeFromError.value = null;
    try {
      CreatedAtValidator.validateOrThrow(time: from);
      _from = from;
    } on InvalidDateTimeException catch (e) {
      dateTimeFromError.value = e.message;
    }
  }

  void removeFromDateTime() {
    dateTimeFromError.value = null;
    _from = null;
  }

  DateTime? get from => _from;

  void validateToDateTime(DateTime to) {
    dateTimeToError.value = null;
    try {
      CreatedAtValidator.validateOrThrow(time: to);
      _to = to;
    } on InvalidDateTimeException catch (e) {
      dateTimeToError.value = e.message;
    }
  }

  DateTime get to => _to;

  void setCustomDateRange() {
    dateTimeToError.value = null;
    try {
      _customDateRange = DateRange.create(from: _from, to: _to);
      _selectedDateRange.value = DateRangeOptions.customRange;
      _searchCriteria.value.dateRange = _customDateRange;
      _searchCriteria.refresh();
      Get.back();
    } on InvalidDateTimeException catch (e) {
      dateTimeToError.value = e.message;
    }
  }

  bool isEqualToDateRangeOption(DateRangeOptions option) =>
      _selectedDateRange.value == option;

  bool get isEqualToCustomDateRangeOption =>
      _selectedDateRange.value == DateRangeOptions.customRange;
  ////////////////////////////////////////////////////////////////////////

  void validateMinAmountRange() {
    minAmmountError.value = null;
    _minAmount = null;
    try {
      if (minAmountController.text.isEmpty) return;
      _minAmount = MoneyInputParser.parseToDouble(
        value: minAmountController.text,
        fieldName: "Min Amount",
      );
    } on EmptyValueException catch (e) {
      minAmmountError.value = e.message;
    } on InvalidDoubleFormatException catch (e) {
      minAmmountError.value = e.message;
    }
  }

  void validateMaxAmountRange() {
    maxAmmountError.value = null;
    _maxAmount = null;
    try {
      if (maxAmountController.text.isEmpty) return;

      _maxAmount = MoneyInputParser.parseToDouble(
        value: maxAmountController.text,
        fieldName: "Max Amount",
      );
    } on EmptyValueException catch (e) {
      maxAmmountError.value = e.message;
    } on InvalidDoubleFormatException catch (e) {
      maxAmmountError.value = e.message;
    }
  }

  void setCustomeAmountRange() {
    minAmmountError.value = null;
    maxAmmountError.value = null;
    _customAmountRange = null;
    try {
      if (_maxAmount != null || _minAmount != null) {
        _customAmountRange = AmountRange.create(
          min: _minAmount,
          max: _maxAmount,
        );
      }
      _quickAmountOption.value = null;
      _searchCriteria.value.amountRange = _customAmountRange;
      _searchCriteria.refresh();
      Get.back();
    } on InvalidAmountException catch (e) {
      final message = e.message.toLowerCase();
      if (message.contains("min")) {
        minAmmountError.value = e.message;
      } else if (message.contains("max")) {
        maxAmmountError.value = e.message;
      } else {
        maxAmmountError.value = e.message;
      }
    } on ArgumentError catch (e) {
      minAmmountError.value = e.message;
    }
  }

  Future<void> setQuickAmountRange(AmountRangeOptions option) async {
    _customAmountRange = null;
    _customAmountRange = AmountRangeCalculator.calculate(option);
    if (_customAmountRange != null) {
      final customAmount = _customAmountRange!;
      if (customAmount.min != null) {
        minAmountController.text = customAmount.min.toString();
      } else {
        minAmountController.text = "";
      }
      if (customAmount.max != null) {
        maxAmountController.text = customAmount.max.toString();
      } else {
        maxAmountController.text = "";
      }
    } else {
      minAmountController.text = "";
      maxAmountController.text = "";
    }
    _quickAmountOption.value = option;
    _searchCriteria.value.amountRange = _customAmountRange;
    _searchCriteria.refresh();
    await Future.delayed(const Duration(milliseconds: 600));
    Get.back();
  }

  Rx getAllOptionsState(FlitterOptions option) {
    switch (option) {
      case FlitterOptions.accountType:
        return _getAccountOptionState;
      case FlitterOptions.transactionType:
        return _txOptionType.value.name.obs;
      case FlitterOptions.dateRange:
        return _selectedDateRange.value.displayName.obs;
      case FlitterOptions.amountRange:
        if (_quickAmountOption.value != null) {
          return _quickAmountOption.value!.displayRange.obs;
        } else {
          return "Custome".obs;
        }
    }
  }
}
