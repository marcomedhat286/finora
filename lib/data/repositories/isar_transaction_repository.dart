import 'package:finora/data/mapper/account_mapper.dart';
import 'package:finora/data/mapper/transaction_mapper.dart';
import 'package:finora/data/models/account_model.dart';
import 'package:finora/data/models/transaction_model.dart';
import 'package:finora/domain/criteria/get_all_transactions_result.dart';
import 'package:finora/domain/criteria/transaction_search_criteria.dart';
import 'package:finora/domain/entities/account.dart';
import 'package:finora/domain/entities/transaction.dart';
import 'package:finora/domain/enum/transaction/transaction_sort_option.dart';
import 'package:finora/domain/exception/account/not_found_account_exception.dart';

import 'package:finora/domain/repositories/transaction_repository.dart';
import 'package:isar_community/isar.dart';

class IsarTransactionRepository implements TransactionRepository {
  final Isar _isar;

  const IsarTransactionRepository({required this._isar});
  @override
  Future<void> saveTransaction({
    required Transaction transaction,
    required Account account,
  }) async {
    await _isar.writeTxn(() async {
      final transactionModel = TransactionMapper.toModel(transaction);

      await _isar.transactionModels.put(transactionModel);

      final existingAccount = await _isar.accountModels
          .filter()
          .accountIdEqualTo(account.id.value)
          .findFirst();

      if (existingAccount == null) {
        throw NotFoundAccountException('This account is not found');
      }

      final accountModel = AccountMapper.toModel(account);

      accountModel.isarId = existingAccount.isarId;
      await _isar.accountModels.put(accountModel);
    });
  }

  @override
  Future<GetAllTransactionsResult> getAllTransactionsUser({
    required List<Account> accounts,
    int? limit,
  }) async {
    if (accounts.isNotEmpty) {
      final accountIds = accounts.map((account) => account.id.value).toList();

      final txModels = await _isar.transactionModels
          .filter()
          .anyOf(
            accountIds,
            (query, accountId) => query.accountIdEqualTo(accountId),
          )
          .sortByCreatedAtDesc()
          .findAll();

      final transactions = txModels.map(TransactionMapper.toEntity).toList();

      if (limit != null && transactions.length > limit) {
        return GetAllTransactionsResult(
          allTransactionsLength: transactions.length,
          alltransactions: transactions.take(limit).toList(),
          totalExpense: Transaction.getTotalExpenseAmount(transactions),
          totalIncome: Transaction.getTotalIncomesAmount(transactions),
        );
      } else {
        return GetAllTransactionsResult(
          allTransactionsLength: transactions.length,
          alltransactions: transactions,
          totalExpense: Transaction.getTotalExpenseAmount(transactions),
          totalIncome: Transaction.getTotalIncomesAmount(transactions),
        );
      }
    }
    return GetAllTransactionsResult(
      allTransactionsLength: 0,
      alltransactions: [],
      totalExpense: 0.0,
      totalIncome: 0.0,
    );
  }

  @override
  Future<List<Transaction>> getOffestLimitTransactionUser({
    required List<Account> accounts,
    required int offest,
    required int limit,
  }) async {
    if (accounts.isNotEmpty) {
      final accountsId = accounts.map((account) => account.id.value).toList();
      final offestLimitedTransactions = await _isar.transactionModels
          .filter()
          .anyOf(
            accountsId,
            (query, accountId) => query.accountIdEqualTo(accountId),
          )
          .sortByCreatedAtDesc()
          .offset(offest)
          .limit(limit)
          .findAll();
      return offestLimitedTransactions.map(TransactionMapper.toEntity).toList();
    }
    return [];
  }

  @override
  Future<GetAllTransactionsResult> getAllTransactionsAccount({
    required String accountId,
    int? limit,
  }) async {
    final txModels = await _isar.transactionModels
        .filter()
        .accountIdEqualTo(accountId)
        .sortByCreatedAtDesc()
        .findAll();

    final transactions = txModels.map(TransactionMapper.toEntity).toList();

    if (limit != null && transactions.length > limit) {
      return GetAllTransactionsResult(
        allTransactionsLength: transactions.length,
        alltransactions: transactions.take(limit).toList(),
        totalExpense: Transaction.getTotalExpenseAmount(transactions),
        totalIncome: Transaction.getTotalIncomesAmount(transactions),
      );
    } else {
      return GetAllTransactionsResult(
        allTransactionsLength: transactions.length,
        alltransactions: transactions,
        totalExpense: Transaction.getTotalExpenseAmount(transactions),
        totalIncome: Transaction.getTotalIncomesAmount(transactions),
      );
    }
  }

  @override
  Future<List<Transaction>> getOffestLimitTransactionAccount({
    required String accountId,
    required int offest,
    required int limit,
  }) async {
    final offestLimitedTransactions = await _isar.transactionModels
        .filter()
        .accountIdEqualTo(accountId)
        .sortByCreatedAtDesc()
        .offset(offest)
        .limit(limit)
        .findAll();
    return offestLimitedTransactions.map(TransactionMapper.toEntity).toList();
  }

  ////////////////////////////////////////////////////////////////////////////////////
  @override
  Future<List<Transaction>> searchTransactions(
    TransactionSearchCriteria criteria,
  ) async {
    if (criteria.accountIds != null && criteria.accountIds!.isEmpty) {
      return [];
    }
    final List<TransactionModel> models;
    if (criteria.sortOption == TransactionSortOption.newest) {
      models = await _isar.transactionModels
          .filter()
          // =========================
          // Account Filter
          // =========================
          .optional(
            criteria.accountIds != null && criteria.accountIds!.isNotEmpty,

            (query) => query.anyOf(criteria.accountIds!, (query, accountId) {
              return query.accountIdEqualTo(accountId);
            }),
          )
          // =========================
          // Transaction Type Filter
          // =========================
          .optional(
            criteria.type != null,
            (query) => query.typeEqualTo(criteria.type!),
          )
          // =========================
          // Date Range Filter
          // =========================
          .optional(
            criteria.name != null,
            (query) => query.titleContains(criteria.name!),
          )
          .optional(criteria.dateRange != null, (query) {
            if (criteria.dateRange?.from != null) {
              final fromDate = criteria.dateRange!.from!;
              final toDate = criteria.dateRange!.to;
              query = query.createdAtBetween(
                fromDate,
                toDate,
                includeLower: true,
                includeUpper: true,
              );
            } else {
              query = query.createdAtLessThan(
                criteria.dateRange!.to,
                include: true,
              );
            }
            return query;
          })
          // =========================
          // Amount Range Filter
          // =========================
          .optional(criteria.amountRange != null, (query) {
            final amountRange = criteria.amountRange!;

            if (amountRange.max != null && amountRange.min != null) {
              query = query.amountBetween(
                amountRange.min!,
                amountRange.max!,
                includeLower: true,
                includeUpper: true,
              );
            } else if (amountRange.max != null && amountRange.min == null) {
              query = query.amountLessThan(amountRange.max!, include: true);
            } else if (amountRange.max == null && amountRange.min != null) {
              query = query.amountGreaterThan(amountRange.min!, include: true);
            }
            return query;
          })
          // =========================
          // Sorting
          // =========================
          .sortByCreatedAtDesc()
          // =========================
          // Execute Query
          // =========================
          .findAll();
    } else {
      models = await _isar.transactionModels
          .filter()
          // =========================
          // Account Filter
          // =========================
          .optional(
            criteria.accountIds != null && criteria.accountIds!.isNotEmpty,

            (query) => query.anyOf(criteria.accountIds!, (query, accountId) {
              return query.accountIdEqualTo(accountId);
            }),
          )
          // =========================
          // Transaction Type Filter
          // =========================
          .optional(
            criteria.type != null,
            (query) => query.typeEqualTo(criteria.type!),
          )
          // =========================
          // Date Range Filter
          // =========================
          .optional(
            criteria.name != null,
            (query) => query.titleContains(criteria.name!),
          )
          .optional(criteria.dateRange != null, (query) {
            if (criteria.dateRange?.from != null) {
              final fromDate = criteria.dateRange!.from!;
              final toDate = criteria.dateRange!.to;
              query = query.createdAtBetween(
                fromDate,
                toDate,
                includeLower: true,
                includeUpper: true,
              );
            } else {
              query = query.createdAtLessThan(
                criteria.dateRange!.to,
                include: true,
              );
            }
            return query;
          })
          // =========================
          // Amount Range Filter
          // =========================
          .optional(criteria.amountRange != null, (query) {
            final amountRange = criteria.amountRange!;

            if (amountRange.max != null && amountRange.min != null) {
              query = query.amountBetween(
                amountRange.min!,
                amountRange.max!,
                includeLower: true,
                includeUpper: true,
              );
            } else if (amountRange.max != null && amountRange.min == null) {
              query = query.amountLessThan(amountRange.max!, include: true);
            } else if (amountRange.max == null && amountRange.min != null) {
              query = query.amountGreaterThan(amountRange.min!, include: true);
            }
            return query;
          })
          // =========================
          // Sorting
          // =========================
          .sortByCreatedAt()
          // =========================
          // Execute Query
          // =========================
          .findAll();
    }

    return models.map(TransactionMapper.toEntity).toList();
  }

  ///////////////////////////////////////////////////////////////////////////////////
  ///
  @override
  Future<void> deleteTransaction(String txId) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateTransaction(Transaction tx) {
    throw UnimplementedError();
  }
}
