require 'spec_helper'

describe HaproxyConfigDefaults do
  let(:section) { HaproxyConfigDefaults.new }

  describe '#update_with_resource' do
    let(:new_resource) { FakeResource::Defaults.new }

    it 'sets balance' do
      new_resource.balance = 'roundrobin'

      expect {
        section.update_with_resource(new_resource)
      }.to change {
        section.balance
      }.from(nil).to('roundrobin')
    end

    it 'sets mode' do
      new_resource.mode = 'tcp'

      expect {
        section.update_with_resource(new_resource)
      }.to change {
        section.mode
      }.from(nil).to('tcp')
    end

    it 'sets retries' do
      new_resource.retries = 4

      expect {
        section.update_with_resource(new_resource)
      }.to change {
        section.retries
      }.from(nil).to(4)
    end

    it 'sets timeout_client' do
      new_resource.timeout_client = '20s'

      expect {
        section.update_with_resource(new_resource)
      }.to change {
        section.timeout_client
      }.from(nil).to('20s')
    end

    it 'sets timeout_server' do
      new_resource.timeout_server = '1s'

      expect {
        section.update_with_resource(new_resource)
      }.to change {
        section.timeout_server
      }.from(nil).to('1s')
    end

    it 'sets timeout_connect' do
      new_resource.timeout_connect = '5s'

      expect {
        section.update_with_resource(new_resource)
      }.to change {
        section.timeout_connect
      }.from(nil).to('5s')
    end
  end

  describe '#to_s' do
    it 'includes mode if set' do
      section.mode = 'http'
      expect(section.to_s).to eq(<<-END.gsub(/^\s{8}/, ''))
        defaults
          mode http
      END
    end

    it 'includes balance if set' do
      section.balance = 'roundrobin'
      expect(section.to_s).to eq(<<-END.gsub(/^\s{8}/, ''))
        defaults
          balance roundrobin
      END
    end

    it 'includes retries if set' do
      section.retries = 60
      expect(section.to_s).to eq(<<-END.gsub(/^\s{8}/, ''))
        defaults
          retries 60
      END
    end

    it 'includes timeout_client if set' do
      section.timeout_client = '10s'
      expect(section.to_s).to eq(<<-END.gsub(/^\s{8}/, ''))
        defaults
          timeout client 10s
      END
    end

    it 'includes timeout_server if set' do
      section.timeout_server = '10s'
      expect(section.to_s).to eq(<<-END.gsub(/^\s{8}/, ''))
        defaults
          timeout server 10s
      END
    end

    it 'includes timeout_connect if set' do
      section.timeout_connect = '10s'
      expect(section.to_s).to eq(<<-END.gsub(/^\s{8}/, ''))
        defaults
          timeout connect 10s
      END
    end
  end
end
