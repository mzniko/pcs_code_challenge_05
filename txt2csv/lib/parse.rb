# Parses from name, phone, twitter and email strings
class Parse
  def self.parse_names(prefixes, suffixes, name_string)
    parsed_name = { pre: '', first: '', middle: '', last: '', suffix: '' }

    word = name_string.split
    parsed_name[:suffix] = word.pop if suffixes.include? word.last
    parsed_name[:pre] = word.shift if prefixes.include? word.first
    parsed_name[:last] = word.pop
    parsed_name[:first] = word.shift if word.count > 0
    parsed_name[:middle] = word.pop if word.count > 0
    parsed_name.values
  end

  def self.parse_phone(phone_string)
    parsed_phone = { country: '', area: '', pre: '', line: '', ext: '' }

    phone = phone_string.scan(/\d+/)
    parsed_phone[:country] = phone.shift if phone[0].length < 3
    parsed_phone[:area] = phone.shift
    parsed_phone[:pre] = phone.shift
    parsed_phone[:line] = phone.shift
    parsed_phone[:ext] = phone.shift if phone.first
    parsed_phone.values
  end

  def self.parse_twitter(twitter_string)
    parsed_twitter = { handle: '' }

    twitter_string.delete! '@'
    parsed_twitter[:handle] = 'Not Valid'
    parsed_twitter[:handle] = twitter_string if twitter_string.length < 15
    parsed_twitter.values
  end

  def self.parse_email(em_string)
    parsed_email = { address: '' }

    parsed_email[:address] = 'Not Found'
    parsed_email[:address] = em_string if em_string.match(/\S+\@\w+\.\w+/)
    parsed_email.values
  end
end
