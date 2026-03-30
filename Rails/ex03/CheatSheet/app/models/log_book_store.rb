# Persists diary entries in entry_log.txt with the required timestamp format.
class LogBookStore
  TIMESTAMP_FORMAT = "%d/%m/%Y %H:%M:%S".freeze

  def initialize(path)
    @path = path
  end

  def append(raw_entry)
    entry = raw_entry.to_s.strip
    return if entry.empty?

    ensure_file
    path.open("a") { |file| file.puts("#{Time.current.strftime(TIMESTAMP_FORMAT)} : #{self.class.send(:serialize, entry)}") }
  end

  def entries
    ensure_file
    path.readlines(chomp: true).reject(&:empty?).reverse.map { |entry| self.class.send(:deserialize, entry) }
  end

  private

  attr_reader :path

  def ensure_file
    return if path.exist?

    path.write("")
  end

  class << self
    private

    def serialize(entry)
      entry.gsub(/\r\n?/, "\n").gsub("\n", "\\n")
    end

    def deserialize(entry)
      entry.gsub("\\n", "\n")
    end
  end
end
