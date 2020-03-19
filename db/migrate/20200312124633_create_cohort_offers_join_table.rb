class CreateCohortOffersJoinTable < ActiveRecord::Migration[5.2]
  def change
	  create_join_table :cohorts, :offers
  end
end
