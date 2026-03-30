require "sqlite3"

class FtQueryController < ApplicationController
  def index
    $all ||= ["Not so fast, young padawan"]
    $time_stamps = fetch_time_stamps
  end

  def create_db
    open_database
    redirect_to root_path
  end

  def create_table
    with_database do
      $db.execute("DROP TABLE IF EXISTS clock_watch")
      $db.execute("DROP TABLE IF EXISTS race")
      $db.execute(create_clock_watch_sql)
      $db.execute(create_race_sql)
    end
    redirect_to root_path
  end

  def drop_table
    with_database do
      $db.execute("DROP TABLE IF EXISTS clock_watch")
      $db.execute("DROP TABLE IF EXISTS race")
    end
    dropped_message
    redirect_to root_path
  end

  def start_race
    with_database do
      time = Time.now
      race_id = create_race!(time)
      runners.each do |name|
        insert_clock_watch!(name: name, race_id: race_id, lap: 1, time: time)
      end
    end
    $all = ["Not so fast, young padawan"]
    $time_stamps = fetch_time_stamps
    redirect_to root_path
  end

  def insert_time_stamp
    slot, name = submitted_runner
    with_database do
      time = Time.now
      race_id = current_race_id
      lap = next_lap_for(name, race_id)
      insert_clock_watch!(name: name, race_id: race_id, lap: lap, time: time)
    end
    refresh_runner(slot, name)
    $time_stamps = fetch_time_stamps
    redirect_to root_path
  end

  def delete_last
    with_database do
      ts_id = $db.get_first_value("SELECT ts_id FROM clock_watch ORDER BY ts_id DESC LIMIT 1")
      $db.execute("DELETE FROM clock_watch WHERE ts_id = ?", ts_id) if ts_id
    end
    $time_stamps = fetch_time_stamps
    redirect_to root_path
  end

  def destroy_all
    with_database do
      $db.execute("DELETE FROM clock_watch")
      $db.execute("DELETE FROM race")
    end
    $time_stamps = fetch_time_stamps
    $all = ["Database is empty or another error occurred"]
    redirect_to root_path
  end

  def all_by_name
    $all = fetch_all("ORDER BY clock_watch.name ASC, clock_watch.race ASC, clock_watch.ts_id ASC")
    redirect_to root_path
  end

  def all_by_race
    $all = fetch_all("ORDER BY clock_watch.race ASC, clock_watch.ts_id ASC")
    redirect_to root_path
  end

  def update_time_stamp
    slot, new_name = submitted_runner
    old_name = runner_name_for(slot)
    if slot && new_name.present? && old_name.present? && old_name != "anonymous"
      with_database do
        $db.execute(
          "UPDATE clock_watch SET name = ? WHERE race = ? AND name = ?",
          [new_name, race_id_for_update, old_name]
        )
      end
      refresh_runner(slot, new_name)
    end
    $time_stamps = fetch_time_stamps
    redirect_to root_path
  end

  private

  def query_params
    @query_params ||= params.slice(:name_1, :name_2, :name_3, :name_4).permit(:name_1, :name_2, :name_3, :name_4)
  end

  def db_file_path
    Rails.root.join("ft_sql")
  end

  def open_database
    $db = SQLite3::Database.new(db_file_path.to_s)
  end

  def with_database
    open_database
    yield if block_given?
  rescue SQLite3::Exception, Errno::ENOENT
    dropped_message
  end

  def create_clock_watch_sql
    <<~SQL.squish
      CREATE TABLE IF NOT EXISTS clock_watch (
        ts_id INTEGER PRIMARY KEY,
        day INTEGER,
        month INTEGER,
        year INTEGER,
        hour INTEGER,
        min INTEGER,
        sec INTEGER,
        race INTEGER,
        name VARCHAR(50),
        lap INTEGER
      )
    SQL
  end

  def create_race_sql
    <<~SQL.squish
      CREATE TABLE IF NOT EXISTS race (
        r_id INTEGER PRIMARY KEY,
        start VARCHAR(50)
      )
    SQL
  end

  def create_race!(time)
    $db.execute("INSERT INTO race(start) VALUES (?)", time.to_s)
    $db.last_insert_row_id
  end

  def insert_clock_watch!(name:, race_id:, lap:, time:)
    $db.execute(
      "INSERT INTO clock_watch(day, month, year, hour, min, sec, race, name, lap)
       VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)",
      [time.day, time.month, time.year, time.hour, time.min, time.sec, race_id, name, lap]
    )
  end

  def runners
    [
      assign_runner(:name_1, :$runner_1),
      assign_runner(:name_2, :$runner_2),
      assign_runner(:name_3, :$runner_3),
      assign_runner(:name_4, :$runner_4)
    ]
  end

  def assign_runner(param_key, global_name)
    value = query_params[param_key].presence || "anonymous"
    case global_name
    when :$runner_1 then $runner_1 = value
    when :$runner_2 then $runner_2 = value
    when :$runner_3 then $runner_3 = value
    when :$runner_4 then $runner_4 = value
    end
    value
  end

  def submitted_runner
    %i[name_1 name_2 name_3 name_4].each do |key|
      next unless query_params.key?(key)

      return [key, query_params[key].presence || runner_name_for(key) || "anonymous"]
    end
    [nil, "anonymous"]
  end

  def runner_name_for(slot)
    return unless slot

    {
      name_1: $runner_1,
      name_2: $runner_2,
      name_3: $runner_3,
      name_4: $runner_4
    }[slot]
  end

  def refresh_runner(slot, name)
    case slot
    when :name_1 then $runner_1 = name
    when :name_2 then $runner_2 = name
    when :name_3 then $runner_3 = name
    when :name_4 then $runner_4 = name
    end
  end

  def current_race_id
    $db.get_first_value("SELECT r_id FROM race ORDER BY r_id DESC LIMIT 1")
  end

  def race_id_for_update
    [current_race_id.to_i - 1, 1].max
  end

  def next_lap_for(name, race_id)
    previous_lap = $db.get_first_value(
      "SELECT MAX(lap) FROM clock_watch WHERE race = ? AND name = ?",
      [race_id, name]
    )
    previous_lap.to_i + 1
  end

  def fetch_time_stamps
    with_database do
      rows = $db.execute("SELECT * FROM clock_watch")
      return rows unless rows.empty?
    end
    ["Database is empty or another error occurred"]
  end

  def fetch_all(order_clause)
    with_database do
      rows = $db.execute(
        "SELECT clock_watch.name, clock_watch.hour, clock_watch.min, clock_watch.sec,
                race.start, clock_watch.race - 1
         FROM clock_watch
         INNER JOIN race ON race.r_id = clock_watch.race
         #{order_clause}"
      )
      return rows unless rows.empty?
    end
    ["Database is empty or another error occurred"]
  end

  def dropped_message
    $time_stamps = ["table has been droped"]
    $all = ["table has been droped"]
  end
end
