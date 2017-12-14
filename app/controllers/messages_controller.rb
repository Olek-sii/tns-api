class MessagesController < GoogleApiController
  def index
    fetch_new_messages
    render :json => current_user.messages.undone
  end

  private

  def fetch_new_messages
    google_tokens = JSON.parse(current_user.google_tokens)
    client = Google::Apis::GmailV1::GmailService.new
    client.authorization = google_tokens['token']
    data = {q: 'from:hamburg.mysteryshopping@tns-infratest.com after:2017/11/01 older:2017/12/06'}
    messages = client.list_user_messages('me', data)
    messages.messages.each do |m|
      message = Message.find_by(message_id: m.id.to_s)
      if message == nil
        fetch_new_message client, m
      end
    end
  end

  def fetch_new_message(client, m)
    regex_adress = /statt:\r\n((.|\r\n)+)(?=\r\n\r\nWährend)/
    regex_times = /((Montag|Dienstag|Mittwoch|Donnerstag|Freitag|Samstag)\s(bis|ab)\s14 Uhr)/
    regex_end_date = /bis zum (.+) in/

    message = JSON.parse(client.get_user_message('me', m.id).to_json)
    body = message['payload']['parts'][0]['parts'][0]['body']['data']
    body = Base64.decode64(body).force_encoding('UTF-8')

    adress = regex_adress.match(body)[1]
    end_date = regex_end_date.match(body)[1]
    times = body.scan(regex_times).map do |time| time[0] end

    current_user.messages.create(message_id: m.id, adress: adress, end_date: end_date, times: times.to_json)
  end
end
