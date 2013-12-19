require 'spec_helper'

describe HaproxyConfigGlobal do
  let(:section) { HaproxyConfigGlobal.new }

  describe '#update_with_resource' do
    let(:new_resource) { FakeResource::Global.new }

    it 'sets maxconn' do
      new_resource.maxconn = 5432

      expect {
        section.update_with_resource(new_resource)
      }.to change {
        section.maxconn
      }.from(nil).to(5432)
    end

    it 'sets nbproc' do
      new_resource.nbproc = 34

      expect {
        section.update_with_resource(new_resource)
      }.to change {
        section.nbproc
      }.from(nil).to(34)
    end

    it 'sets spread_checks' do
      new_resource.spread_checks = 4

      expect {
        section.update_with_resource(new_resource)
      }.to change {
        section.spread_checks
      }.from(nil).to(4)
    end

    it 'sets user' do
      new_resource.user = 'some_user'

      expect {
        section.update_with_resource(new_resource)
      }.to change {
        section.user
      }.from(nil).to('some_user')
    end

    it 'sets group' do
      new_resource.group = 'some_group'

      expect {
        section.update_with_resource(new_resource)
      }.to change {
        section.group
      }.from(nil).to('some_group')
    end
  end

  describe '#to_s' do
    it 'includes maxconn if set' do
      section.maxconn = 6000
      expect(section.to_s).to eq(<<-END.gsub(/^\s{8}/, ''))
        global
          maxconn 6000
      END
    end

    it 'includes nbproc if set' do
      section.nbproc = 12
      expect(section.to_s).to eq(<<-END.gsub(/^\s{8}/, ''))
        global
          nbproc 12
      END
    end

    it 'includes user if set' do
      section.user = 'someone'
      expect(section.to_s).to eq(<<-END.gsub(/^\s{8}/, ''))
        global
          user 'someone'
      END
    end

    it 'includes group if set' do
      section.group = 'some_group'
      expect(section.to_s).to eq(<<-END.gsub(/^\s{8}/, ''))
        global
          group 'some_group'
      END
    end

    it 'includes spread_checks if set' do
      section.spread_checks = 5
      expect(section.to_s).to eq(<<-END.gsub(/^\s{8}/, ''))
        global
          spread-checks 5
      END
    end
  end
end
