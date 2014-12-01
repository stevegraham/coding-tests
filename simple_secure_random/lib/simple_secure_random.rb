require 'base64'

module SimpleSecureRandom
  extend self

  def random_bytes(bytes=nil)
    IO.read('/dev/random', (bytes || 16).to_i, encoding: Encoding::ASCII_8BIT)
  end

  def hex(bytes=nil)
    random_bytes(bytes).unpack('H*').first
  end

  def base64(bytes=nil)
    Base64.strict_encode64 random_bytes(bytes)
  end

  def urlsafe_base64(bytes=nil, padding=false)
    Base64.urlsafe_encode64(random_bytes(bytes)).tap { |s| s.delete! '=' unless padding }
  end

  def uuid
    # RFC 4122 UUID - http://www.cryptosys.net/pki/uuid-rfc4122.html
    bytes = random_bytes.bytes

    bytes[6] = 0x40 | (bytes[6] & 0xf)
    bytes[8] = 0x80 | (bytes[8] & 0x3f)

    "%s%s%s%s-%s%s-%s%s-%s%s-%s%s%s%s%s%s" % bytes.map { |b| "%02x" % b }
  end
end
