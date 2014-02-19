#
# https://github.com/grosser/test_after_commit/issues/17#issuecomment-32280854
#
require 'active_record/connection_adapters/abstract/transaction'

module ActiveRecord
  module ConnectionAdapters
    class SavepointTransaction < OpenTransaction

      def perform_commit_with_transactional_fixtures
        out = perform_commit_without_transactional_fixtures
        commit_records if number == 1 # last one before test one that's always there, do callbacks
        out
      end
      alias_method_chain :perform_commit, :transactional_fixtures

    end
  end
end