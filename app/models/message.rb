class Message < ApplicationRecord
  belongs_to :user

  scope :undone, -> { where(is_done: false) }
  scope :end_date_sorted, -> { order(end_date: :asc) }

  def self.process_address_regex(input)
    regex = /(statt:\s*)((.)+)(?=\s*Während)/
    regex.match(input.gsub("\r", "").gsub("\n"," "))[2]
  end

  def self.process_end_data_regex(input)
    regex = /biszum([0-9]{2}\.[0-9]{2}\.[0-9]{4})in/
    regex.match(input)[1]
  end

  def self.process_times_regex(input)
    regex = /((Montag|Dienstag|Mittwoch|Donnerstag|Freitag|Samstag) (bis|ab) 14 Uhr)/
    input.scan(regex).map do |time| time[0] end
    end

  def self.process_price_regex(input)
    regex = /beträgtnetto(.+)€/
    regex.match(input)[1]
  end

  def self.process_test_id_regex(input)
    regex = /NummerdesTests:([0-9]+)/
    regex.match(input)[1]
  end

  def self.process_check_number_regex(input)
    regex = /Prüfkennziffer:([0-9])/
    regex.match(input)[1]
  end

end
