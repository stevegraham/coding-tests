require 'base64'
require 'simple_secure_random'

RSpec.describe SimpleSecureRandom do
  let(:length) { 16 }

  before do
    allow(IO).to receive(:read).
      with('/dev/random', length, encoding: Encoding::ASCII_8BIT).
      and_wrap_original { |m, *args| @io = m.call(*args) }
  end

  describe '.random_bytes' do
    it 'is encoded as 8 bit ASCII' do
      expect(SimpleSecureRandom.random_bytes.encoding).to eq Encoding::ASCII_8BIT
    end

    it 'returns a different value for each call' do
      expect(SimpleSecureRandom.random_bytes).to_not eq SimpleSecureRandom.random_bytes
    end

    context 'with no arguments' do
      it 'returns 16 bytes from the OS random device' do
        expect(SimpleSecureRandom.random_bytes).to eq @io
        expect(SimpleSecureRandom.random_bytes.length).to eq length
      end
    end

    context 'with an integer argument' do
      let(:length) { 24 }

      it 'returns n bytes from the OS random device where n is the argument' do
        expect(SimpleSecureRandom.random_bytes length).to eq @io
        expect(SimpleSecureRandom.random_bytes(length).length).to eq length
      end
    end
  end

  describe '.hex' do
    let(:pattern) { %r{\A[a-f0-9]{#{length*2}}\Z} }

    it 'returns a different value for each call' do
      expect(SimpleSecureRandom.hex).to_not eq SimpleSecureRandom.hex
    end

    context 'with no arguments' do
      it 'returns 16 bytes from the OS random device encoded as a hex string' do
        expect(SimpleSecureRandom.hex).to eq @io.unpack('H*').first
        expect(SimpleSecureRandom.hex).to match pattern
      end
    end

    context 'with an integer argument' do
      let(:length) { 24 }

      it 'returns n bytes from the OS random device as a hex string where n is the argument' do
        expect(SimpleSecureRandom.hex(length)).to eq @io.unpack('H*').first
        expect(SimpleSecureRandom.hex(length)).to match pattern
      end
    end
  end

  describe '.base64' do
    it 'returns a different value for each call' do
      expect(SimpleSecureRandom.base64).to_not eq SimpleSecureRandom.base64
    end

    context 'with no arguments' do
      it 'returns 16 base64 encoded bytes from the OS random device' do
        expect(SimpleSecureRandom.base64).to eq Base64.strict_encode64 @io
      end
    end

    context 'with an integer argument' do
      let(:length) { 24 }

      it 'returns n base64 encoded bytes from the OS random device where n is the argument' do
        expect(SimpleSecureRandom.base64(length)).to eq Base64.strict_encode64 @io
      end
    end
  end

  describe '.urlsafe_base64' do
    it 'returns a different value for each call' do
      expect(SimpleSecureRandom.urlsafe_base64).to_not eq SimpleSecureRandom.urlsafe_base64
    end

    it 'is url safe' do
      expect(SimpleSecureRandom.urlsafe_base64).to_not match /[+\/]/
    end

    describe 'with padding' do
      it 'pads the result' do
        expect(SimpleSecureRandom.urlsafe_base64(length, true)).to end_with '='
      end
    end

    describe 'without padding' do
      it 'does not pad the result' do
        expect(SimpleSecureRandom.urlsafe_base64).to_not end_with '='
      end
    end

    context 'with no arguments' do
      it 'returns 16 base64 encoded bytes from the OS random device' do
        expect(SimpleSecureRandom.urlsafe_base64).to eq Base64.urlsafe_encode64(@io).delete '='
      end
    end

    context 'with an integer argument' do
      let(:length) { 24 }

      it 'returns n base64 encoded bytes from the OS random device where n is the argument' do
        expect(SimpleSecureRandom.urlsafe_base64(length)).to eq Base64.urlsafe_encode64(@io).delete '='
      end
    end
  end

  describe '.uuid' do
    it 'returns a different value for each call' do
      expect(SimpleSecureRandom.uuid).to_not eq SimpleSecureRandom.uuid
    end

    it 'returns a valid v4 uuid' do
      expect(SimpleSecureRandom.uuid).
        to match %r{\A[[:xdigit:]]{8}-[[:xdigit:]]{4}-4[[:xdigit:]]{3}-[ab89][[:xdigit:]]{3}-[[:xdigit:]]{12}\Z}
    end
  end
end
