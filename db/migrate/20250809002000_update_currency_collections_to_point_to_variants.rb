class UpdateCurrencyCollectionsToPointToVariants < ActiveRecord::Migration[8.0]
  def change
    unless column_exists?(:currency_collections, :currency_denomination_variant_id)
      add_reference :currency_collections, :currency_denomination_variant, foreign_key: true
    end

    # Keep the old foreign key for now; app code will transition. Follow-up migration could remove it.
  end
end


