require 'spec_helper'

describe HaproxyConfigGlobal do
  let(:global) { HaproxyConfigGlobal.new }

  describe '#update_with_resource' do
    let(:new_resource) { FakeResource::Global.new }

    it 'sets maxconn' do
      new_resource.maxconn = 5432

      expect {
        global.update_with_resource(new_resource)
      }.to change {
        global.maxconn
      }.from(nil).to(5432)
    end

    it 'sets nbproc' do
      new_resource.nbproc = 34

      expect {
        global.update_with_resource(new_resource)
      }.to change {
        global.nbproc
      }.from(nil).to(34)
    end

    it 'sets spread_checks' do
      new_resource.spread_checks = 4

      expect {
        global.update_with_resource(new_resource)
      }.to change {
        global.spread_checks
      }.from(nil).to(4)
    end

    it 'sets user' do
      new_resource.user = 'some_user'

      expect {
        global.update_with_resource(new_resource)
      }.to change {
        global.user
      }.from(nil).to('some_user')
    end

    it 'sets group' do
      new_resource.group = 'some_group'

      expect {
        global.update_with_resource(new_resource)
      }.to change {
        global.group
      }.from(nil).to('some_group')
    end
  end

  describe '#to_s' do
    it 'includes maxconn if set' do
      global.maxconn = 6000
      expect(global.to_s).to eq(<<-END.gsub(/^\s{8}/, ''))
        global
          maxconn 6000
      END
    end

    it 'includes nbproc if set' do
      global.nbproc = 12
      expect(global.to_s).to eq(<<-END.gsub(/^\s{8}/, ''))
        global
          nbproc 12
      END
    end

    it 'includes user if set' do
      global.user = 'someone'
      expect(global.to_s).to eq(<<-END.gsub(/^\s{8}/, ''))
        global
          user 'someone'
      END
    end

    it 'includes group if set' do
      global.group = 'some_group'
      expect(global.to_s).to eq(<<-END.gsub(/^\s{8}/, ''))
        global
          group 'some_group'
      END
    end

    it 'includes spread_checks if set' do
      global.spread_checks = 5
      expect(global.to_s).to eq(<<-END.gsub(/^\s{8}/, ''))
        global
          spread-checks 5
      END
    end
  end
end
