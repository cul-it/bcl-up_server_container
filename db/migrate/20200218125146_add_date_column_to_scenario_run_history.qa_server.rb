class AddDateColumnToScenarioRunHistory < ActiveRecord::Migration[5.1]
  def change
    add_column :scenario_run_history, :date, :date
    add_index :scenario_run_history, :date

    begin
      BclUpServer::ScenarioRunHistory.all.each do |entry|
        registry = BclUpServer::ScenarioRunRegistry.find(entry.scenario_run_registry_id)
        entry.date = registry.dt_stamp.to_date
        entry.save
      end
    end
  end
end
