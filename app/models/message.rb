class Message < ApplicationRecord
  belongs_to :user

  scope :undone, -> { where(is_done: false) }

  def self.process_address_regex(input)
    regex = /statt:\r\n((.|\r\n)+)(?=\r\n\r\nWährend)/
    regex.match(input)[1]
  end

  def self.process_end_data_regex(input)
    regex = /bis zum (.+) in/
    regex.match(input)[1]
  end

  def self.process_times_regex(input)
    regex = /((Montag|Dienstag|Mittwoch|Donnerstag|Freitag|Samstag)\s(bis|ab)\s14 Uhr)/
    input.scan(regex).map do |time| time[0] end
  end

end
