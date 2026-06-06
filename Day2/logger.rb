require "time"

module Logger
  LOG_FILE = "app.log"

  def write_log(level, message)
    File.open(LOG_FILE, "a") do |file|
      file.puts("#{Time.now.iso8601} -- #{level} -- #{message}")
    end
  end

  def log_info(message)
    write_log("info", message)
  end

  def log_warning(message)
    write_log("warning", message)
  end

  def log_error(message)
    write_log("error", message)
  end
end