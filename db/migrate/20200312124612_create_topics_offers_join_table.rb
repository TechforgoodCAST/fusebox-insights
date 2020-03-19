class CreateTopicsOffersJoinTable < ActiveRecord::Migration[5.2]
  def change
	  create_join_table :topics, :offers
  end
end
